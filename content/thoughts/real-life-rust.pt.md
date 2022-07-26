+++
title = "Rust na Vida Real"
date = 2022-07-26

[taxonomies]
tags = ["rust"]
+++

Já faz algum tempo que eu tenho falado sobre Rust, fazendo apresentações, indo
a meetups...

Mas a alguns meses eu tive a oportunidade de finalmente trabalhar num projeto
real em Rust.

Então, como é que foi?

<!-- more -->

## Cargo é mágico

A primeira aplicação que eu usei Rust foi uma parte pequena de um grande
projeto. Eu tinha que capturar valores vindos de um websocket e guardar os
mesmos num banco de dados.

Haviam duas opções de linguagens que eu poderia usar: Python e C. Python já
estava sendo usado em outras partes da empresa, e isso garantiria mais olhos
caso algo desse errado. C estava sendo usado em outra aplicação do mesmo
projeto, e eu poderia manter todo o projeto na mesma linguagem. Ambas
linguagens tinham alguns problemas: Eu não tinha certeza que Python conseguiria
lidar com a carga de dados de um stream contínuo do websocket e eu não queria
ter que escrever meu próprio processamento de websocket e parser de JSON em C.

E foi por isso que eu usei Rust nesta aplicação: Eu tinha a performance de C
com um excelente gerenciador de pacotes, e mais milhares de pacotes
disponíveis.

Assim, Cargo foi quem decidiu o uso de Rust no projeto. E a linguagem se provou
bem capaz, pois a aplicação fico rodando até o ponto que acabamos esquecendo
que ela estava rodando.

## `.unwrap()` é o inimigo

Um ponto que eu faço nas minhas apresentações é que você pode usar `.unwrap()`
(e `.expect()`) para evitar ter que lidar com erros, e embora o uso deste faça
com que sua aplicação seja encerrada, você tem total controle sobre *onde* ela
pode ser encerrada (comparado com um NullPointerException, ou ler valores NULL,
ou não capturar as exceções corretas). Mas, no fim das contas, `.unwrap()` vai
te machucar. Bastante.

Foi o que aconteceu com a segunda aplicação que eu escrevi: A parte principal
da aplicação era ler um conjunto de bytes, e o significado destes bytes estava
nos bits que os compunham, em uma combinação de bitmaps e números num formato
tipo UTF-8. Mas não era só o parsing que estava envolvido: Havia um socket a
ser lido, e os dados parseados tinham que ser guardados num banco de dados, e
haviam os problemas usuais envolvidos nisso -- o socket poderia ser fechado
pelo servidor, nós poderíamos perder a conexão de rede, o parser poderia
produzir valores estranhos no caso de um bit perdido, que não poderia ser
guardado no banco de dados...

Para cada um dos problemas possíveis (que eram bem claros, já que `Result` é a
base de quase tudo), e como eu estava com pressa para entregar a aplicação, eu
usei um monte de `.unwrap()`s pelo código -- de novo, a ideia era que, se a
aplicação crasheasse, pelo menos eu disse que ela podia crashear, e iria me dar
uma mensagem mais ou menos indicando onde. A realidade é que problemas aconteciam
com tal frequência (especialmente o parser recebendo bits estranhos que
produziam valores estranhos) que a aplicação não ficava rodando por muito
tempo.

A solução para esses crashes constantes foi bem simples, embora trabalhoso:
trocar todo `.unwrap()` e `.expect()` por `if let Ok(_)` e `match`. Isso me deu
controle total do que fazer nos casos de valores não esperados. O resultado foi
que a aplicação rodou sem problemas por dias, ao ponto que nós, mais uma vez,
esquecemos que ela estava rodando -- exceto quando os dados de entrada mudavam
e nós tínhamos que atualizar nossos filtros.

## Cargo de novo

Nesta segunda aplicação, havia um monte de coisinhas chatas no protocolo que
eram realmente complicadas de entender. Felizmente nós conseguimos capturar
alguns pacotes do serviço, que permitiria testar o parser localmente. Tudo que
eu precisava era algo que me desse uma rede de suporte para jogar esses bits e
ver como o código processaria.

Com C, isso normalmente significa criar outro executável para os testes e rodar
esse executável ao invés do executável real (e, pra ser honesto, é exatamente
isso que o Rust faz) mas o Cargo escondeu toda a complexidade de fazer isso. Eu
só criei `test.rs` nos meus módulos, marquei o mesmo com `#[cfg(test)]`
(indicando que o mesmo só existe na configuração de teste) e `cargo test`
compilou o código e rodou os testes.

O fato que eu tinha um framework de test e um executor de testes logo ali foi
de grande ajuda, especialmente quando um problema era encontrado.

## Deveria ter tentado (`try`ed) mais

Um dos efeitos colaterais de trocar todo `.unwrap()` e `.expect()` for alguma
forma explícita de tratamento de erro foi o aumento da indentação do código --
porque *tudo* que eu fiz foi fazer essa alteração, mas eu não quebrei o código
em funções menores.

Rust tem o operador `try` -- `?` -- mas isso requer que a função com o operador
retorne um `Result`, que eu negligenciei na primeira passagem porque, bom, a
única saída das funções era o sucesso e falhas significavam `panic!()` (por
causa do `.unwrap()`).

Se eu tivesse usando `Result` como resultado desde o começo, eu tenho a
impressão que o código não ficaria uma bagunça com 7-8 níveis de indentação. Ou
seja, outra coisa que eu teria "ganho" se eu não tivesse usado `.unwrap()`.

## Async não faz menor sentido até que faz

A terceira aplicação no projeto precisava fazer um monte de I/O -- ler de
vários bancos de dados, enviar dados por socket, escrever de volta no banco de
dados... Parecia o perfeito experimento para um projeto async.

Na primeira versão que eu escrevi, eu usei tasks (funções async) da mesma forma
que eu faço com threads. Isso gerou um monte de erros do borrow checker que eu
não conseguia entender o porquê -- neste ponto, eu já conseguia entender
exatamente porque o borrow checker estava reclamando de alguma coisa numa
aplicação com threads, mas os erros eram tão confusos que eu devo ter
mencionado algo como "async não é natural em Rust". E, quando eu finalmente
consegui evitar todas as reclamações do borrow checker, a performance foi...
terrível. Algo como 0.8 registros por segundo, que era extremamente baixo para
o que estávamos esperando.

Com essa performance horrível, eu removi todas as coisas async e usei threads.
Isso estava mais com o que eu estava acostumado -- eu sabia exatamente o que eu
tinha feito de errado quando o borrow checker reclamava de algo -- e a
performance melhorou: O processamento passou a 7 registros por segundo.

Enquanto eu estava nessa reescrita, eu fiquei lendo sobre async e como
funciona, até que eu consegui formar um modelo mental para trabalhar desta
forma (mais sobre isso num post futuro). Eu consegui ter algum tempo para
efetivamente aplicar esse modelo mental -- e aí os erros do borrow checker
começaram a fazer sentido, e eu me senti produtivo de novo. O resultado? 70
registros por segundo, uma melhoria de 10x sobre o uso de threads.

## Conclusão

Tudo isso eu aprendi num espaço de 6 meses. Eu acabei trocando de emprego para
um lugar onde não há nada em Rust (por enquanto 😈), e embora a estrada do Rust
seja ingrime e cheia de curvas fechadas, eu ainda acho que vale a pena.

(E, até onde eu sei, todas as aplicações aqui *continuam* rodando...)

<!-- 
vim:spelllang=pt:
-->

