+++
title = "Decodificando o Protocolo FAST: Exemplos"
date = 2022-01-12

[taxonomies]
tags = ["finanças", "binário", "protocolo", "fix", "fast", "exemplos"]
+++

Depois de toda a explicação sobre a definição do protocolo FAST, eu notei que
tinha uma coisa faltando: Exemplos, para que fique mais fácil de entender.

<!-- more -->

{% note() %}
Mesmo aviso do post anterior: Como isso tudo é baseado na minha experiência
pessoal, algumas coisas podem estar erradas. Eu tentei o meu melhor para deixar
tudo correto, mas eu posso ter entendido alguma coisa errada, ou digitei errado
aqui.

Ainda, a medida que eu for encontrando casos que eu acredite sejam
interessantes, novos exemplos serão adicionados.
{% end %}

# Hello World

Este exemplo é basicamente o mesmo da
[JetTek](https://jettekfix.com/education/fix-fast-tutorial/) mas é realmente
simples de explicar, então vamos nós:

## Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xmlns="http://www.fixprotocol.org/ns/fast/td/1.1">
  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="HelloWorld" id="1">
    <string name="String" id="1">
      <default value=""/>
    </string>
  </template>
</templates>
```

## Dados de Entrada

Bytes:

```
1110_0000   1000_0001   0100_1000   0110_0101
0110_1100   0110_1100   0100_1111   0101_0111
0110_1111   0111_0010   0110_1100   1110_0100
```

## Processamento

O primeiro byte é o Mapa de Presença. Removendo o bit de parada, temos
`110_0000`. Esse Mapa de Presença tem um campo que não é descrito no template:
O Template ID (ID de Template). Como o primeiro bit está ligado, nós sabemos
que o ID está lá. Ainda, tenha em mente que o Template ID é o único campo que
nós sabemos que existe até agora; não existe nenhuma outra informação sobre o
que é aquele segundo bit no Mapa de Presença -- nós precisamos encontrar qual
template vamos usar antes de mais nada.

O próximo byte é lido: `1000_0001`. Como mencionado acima, isso é o Template
ID. Sendo um inteiro sem sinal (e provavelmente mandatório, mas não me pergunte
como isso funciona) e removendo o bit de parada, temos o inteiro "1", que é
exatamente o mesmo ID que temos no nosso template; agora nós sabemos quais
campos devem ser processados.

O primeiro campo do template é uma string com um valor default. Como o campo
usa o operador Default, nós precisamos verificar se o valor está presente nos
dados de entrada ou se devemos usar esse valor default. O bit no Mapa de
Presença para este campo é `1`, o que indica que a string está presente nos
dados de entrada e que nós devemos lê-la.

O campo é uma string, então vamos ler todos os bytes até encontrarmos um com o
bit de parada. Ainda, sendo string, nós não precisamos "juntar" os bits: cada
byte é uma letra da tabela ASCIII. A sequência é `100_10000` (72), `110_0101`
(101), `110_1100` (108), `110_1100` (108), `100_1111` (79), `101_0111` (87),
`110_1111` (79), `111_0010` (114), `110_1100` (108) e `110_0100` (100). Observe
que nós consumimos todos os bites e o último tinha o bit de parada, então
terminamos o pacote com a string. Convertendo os bytes usando a tabela ASCII,
temos "HelloWorld".

Assim, temos o resultado: Nós recebemos um registro do tipo "HelloWorld" cujo
campo com ID "1" (chamado "String") tem o valor "HelloWorld".

# Sequências

Vamos expandir nosso exemplo adicionando uma sequência e alguns operadores:

## Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<templates xmlns="http://www.fixprotocol.org/ns/fast/td/1.1">
  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="HelloWorld" id="1">
    <string name="String" id="1">
      <default value=""/>
    </string>
  </template>

  <template xmlns="http://www.fixprotocol.org/ns/fast/td/1.1" name="SequenceOfSequences" id="2">
    <sequence name="OuterSequence">
      <length name="NoOuterSequence" id="3"/>
      <uInt32 name="GroupID" id="2"/>
      <sequence name="InnerSequence">
        <length name="NoInnerSequence" id="25"/>
        <string name="Username" id="4"/>
        <uInt32 name="ID" id="32" presence="optional">
          <increment/>
        </uInt32>
      </sequence>
    </sequence>
  </template>
</templates>
```

Apesar do FAST ser criado para trabalhar com FIX e o mercado financeiro, não
existe nada que iniba o mesmo de ser usado para outras coisas. O novo template
descreve um group de usuários, então nós temos uma lista de grupos e, para cada
grupo, uma lista de usuários e seus IDs.

## Dados de Entrada

```
1100_0000   1000_0010   1000_0011   0000_0011
0010_0011   0001_1000   1110_0111   1000_0010
1100_0000   0101_0101   0111_0011   0110_0101
0111_0010   1011_0001   1000_0100   1000_0000
0101_0101   0111_0011   0110_0101   0111_0010   
1011_0010   1111_1111   1000_0001   1100_0000
0101_0101   1011_0001   1111_1111   0000_1000 
1000_0000   1000_0010   1100_0000   1100_1001
1011_0110   1000_0000   0100_1101   1110_0101
```

## Processamento

Como mencionado anteriormente, o primeiro byte, `1100_0000` é o Mapa de
Presença do elemento raiz. Existe apenas um bit ligado, o que indica que o
Template ID está presente.

Como o Template ID está presente no Mapa de Presença, nós lemos o próximo byte
`1000_0010`. Como este byte tem o bit de parada, nós paramos de ler. Removendo
este bit, nós temos `000_0010`, que é "2", e agora sabemos que estamos lidando
com o template "SequenceOfSequences".

Agora que temos o template e conhecemos os campos, nós sabemos o que precisamos
ler. O primeiro campo do nosso template é uma sequência. A primeira coisa que
nós temos em uma sequência (e é a primeira coisa em *todas* as sequências) é o
tamanho desta. Assim, nós lemos o próximo byte, `1000_0011`, que é o único byte
que precisamos ler. Ele representa um inteiro sem sinal, que é 3, então esta
sequência tem 3 registros -- e usando nossa descrição anterior, nós sabemos que
temos 3 grupos de usuários.

Um ponto ser visto aqui: Como todos os campos desta sequência não tem qualquer
operador, o Mapa de Presença não é necessário e, assim, ele não existe (ou,
melhor, nós não devemos tentar ler alguma coisa e assumir que é o Mapa de
Presença). Para sequências, o começo de cada registro contém um Mapa de
Presença apenas se pelo menos um dos campos na sequência precisa do Mapa. O que
não é o caso aqui.

Como não há Mapa de Presença para a sequência "OuterSequence", os próximos
bytes são o campo "GroupID". Nós devemos ler os bytes até encontrar o bit de
parada; assim, recebemos `0000_0011`, `0010_0011`, `0001_1000` e `1110_0111`.
Para cada byte nós removemos o bit de mais alta ordem (o bit de parada) e
juntamos tudo em uma única coisa, neste caso, `00_0011 010_0011 001_1000
110_0111` ou simplesmente `0000_0110_1000_1100_1100_0110_0110`. Este valor,
sendo um inteiro sem sinal, é "6868070". 

{% note() %}
Aqui é um bom ponto para lembrar que, como o campo é mandatório, isto significa
que este é realmente o valor para "GroupID"; se o campo fosse opcional, o valor
de verdade seria "6868069".
{% end %}

Agora para o campo "InnerSequence". O primeiro passo é recuperar o número de
elementos (o "length" da sequência). Esse é o byte `1000_0010`, que é 2. Assim,
há dois usuários neste grupo.

Como o "InnerSequence" tem um campo que precisa do Mapa de Presença ("ID" usa o
operador Increment, o que indica que ou iremos ler o o valor vindo dos dados de
entrada ou iremos incrementar o valor anterior), o primeiro byte depois do
tamanho é o Mapa de Presença para este registro. O byte `1100_0000` indica que
o primeiro campo que precisa do Mapa de Presença está presente.

Mas ainda não é o momento de usar o Mapa de Presença. O campo logo após o
tamanho é "Username", que é uma string mandatória. Strings mandatórias sem
operadores estão sempre presentes e nós não precisamos olhar o Mapa de
Presença. Assim como fizemos com "String" no exemplo anterior, nós lemos os
bytes até encontrar um com o bit de parada, mas não juntamos os mesmos:
`0101_0101` (85), `0111_0011` (115), `0110_0101` (101), `0111_0010` (114) e
`1011_0001` (49, se removermos o bit de parada), que convertidos pela tabela
ASCII nos dá o valor "User1".

Agora é o momento de usar o Mapa de Presença, já que estamos lendo o campo "ID"
e ele tem um operador que usa o Mapa. O Mapa de Presença que lemos
anteriormente foi `100_0000` (com o bit de parada removido), então sim, o "ID"
está presente nos dados de entrada. Nós lemos o próximo byte, `1000_0100`, que
é "4". Mas tem uma pegadinha aqui: O campo é opcional. Então embora tenhamos
lido "4", o valor de verdade é "3" -- se o valor lido fosse "0", significaria
que o ID é Null.

Beleza. Terminamos de ler o primeiro registro de "InnerSequence": O usuário
"User1" tem ID "3" e pertence ao grupo "6868070". Agora vamos ler o segundo
registro.

Não precisamos ler o tamanho de novo, mas precisamos ler o Mapa de Presença
deste registro. É o byte `1000_0000` um Mapa de Presença indicando que nenhum
dos campos com operadores estão presentes. Mas, de novo, não é hora de usar o
Mapa de Presença, porque nós temos que ler o "Username". Os bytes do campo são
`0101_0101` (85), `0111_0011` (115), `0110_0101` (101), `0111_0010` (114) e
`1011_0001` (50), que gera o valor "User2".

O segundo registro tem um Mapa de Presença vazio (`1000_0000`) o que indica que
o ID não está presente nos dados de entrada. Como o campo tem o operador
Increment, nós precisamos pegar o valor anterior -- "3" -- e incrementar em 1>
Assim, "User2" tem o ID "4".

E assim termina o "InnerSequence" do primeiro regsitro do "OuterSequence".
Agora mais rápido:

- `1111_1111`: O segundo "GroupID" (que usa apenas um byte por causa do bit de
  parada), que é "127".
- `1000_0001`: O tamanho do "InnerSequence"; apenas 1 elemento.
- `1100_0000`: O Mapa de Presença do segundo registro de "InnerSequence";
  significa que o "ID" está presente.
- `0101_0101`, `1011_0001`: Username. "U1".
- `1111_1111`: O valor de "ID" para o usuário "U1" é 126 (é lido "127", mas
  como o campo é opcional, o valor é decrementado em 1).
- `0000_1000`, `1000_0000`: O terceiro "GroupID". Removendo os bits de parada e
  juntando os bits restantes temos `0000_1000 0000_0000`, que é "2048".
- `1000_0010`: Tamanho da sequência "InnerSequence" do terceiro grupo; 2
  elementos.
- `1100_0000`: Mapa de Presença do primeiro registro de "InnerSequence"; ID
  está presente.
- `1100_1001`: Username. "I".
- `1011_0110`: "ID" para o usuário "I". 53.
- `1000_0000`: Mapa de presença do segundo registro de "InnerSequence"; ID não
  está presente.
- `0100_1101`, `1110_0101`: Username. "Me".
- Agora não precisamos ler nada, pois o Mapa de Presença aponta que o ID não
  está presente, mas como o valor lido anteriormente para este campo foi "53",
  o ID para o usuário "Me" é "54". E como este era o último elemento de
  "InnerSequence", a sequência está completa; ainda, como este era o último
  elemento de "OuterSequence", a leitura terminou.

---

Changelog:

- 2022-01-17: Versão inicial.

<!-- 
vim:spelllang=pt:
-->
