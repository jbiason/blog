+++
title = "Link Comentado: Mitigando Problemas de Segurança de Memória em Softwares Open Source"
date = 2021-02-18

[taxonomies]
tags = ["links", "google", "segurança", "rust"]
+++

Inicialmente anunciado no HackerNews como "Google Vai Pagar Desenvolvedores
Para Portarem Seu Código Para Rust" [nesse
post](https://security.googleblog.com/2021/02/mitigating-memory-safety-issues-in-open.html),
mas o conteúdo não parece ser exatamente o que é dito.

E parece que dessa vez os comentários do HackerNews [entenderam o que o post
realmente quer dizer](https://news.ycombinator.com/item?id=26179032).

<!-- more -->

Mas me deixem fazer um resumo.

Primeiro, o dinheiro não irá para os desenvolvedores dos projetos open source
para que estes possam garantir a segurança dos seus projetos, ou olhar para
alternativas que tornem os projetos mais seguros. Google irá dar o dinheiro para
outra empresa -- ISRG -- para que eles escrevam novas versões de alguns
códigos. Assim, embora a ideia pareça ser boa, isso não quer dizer que eles
estarão oferecendo dinheiro para os autores trabalharem nos seus projetos; o
dinheiro irá para outra pessoa, que irá prover os patches.

Esse "alguém vai prover os patches" me lembra de uma talk do Brett Cannon em uma
DjangoCon. "Você vê esse cachorrinho, tão bonitinho, mas o que eu vejo são 10
anos de caminhadas, dar comida e juntar coco."[^1] Assim, embora a ISRG mande
patches para melhorar projetos open source usando linguagens com proteção de
memória, não existe qualquer menção a "e continuar a fazer funcionar". Claro que
é legal ter um patch de segurança em outra linguagem no seu projeto, mas quem é
que vai continuar cuidando dela pra próxima versão? E na próxima? ISRG ou o
autor original -- que, de novo, não recebeu absolutamente nada para isso?

Segundo, há essa linha[^2]:

> A forma que a ISRG trabalha diretamente com os mantenedores para suportar a
> reescrita de ferramentas e bibliotecas incrementalmente encaixa perfeitamente
> com a nossa perspectiva aqui na Google.

O que parece estranho aqui é que nós sabemos, por um bom tempo, que Google não
trabalha para o bem comum; ela trabalha pra si mesma (e é ok para uma
empresa). Mas e se a forma segura de algum projeto não encaixar com a
"perspectiva" esperada pelo Google? Eles vão fazer um fork? Aceitar que a
perspectiva deles não é a forma correta?

Por exemplo, recentemente a biblioteca Cryptography trocou um componente base
para usar Rust -- o que faz todo o sentido num projeto de segurança. O problema
é para algumas pessoas, usando arquiteturas não comuns, [viu seus builds
quebrando](https://github.com/pyca/cryptography/issues/5771). De novo, faz
sentido que algo que é usado para segurança use uma linguagem com proteção de
memória, mas o que aconteceria se a solução proposta pela ISRG -- que, de novo,
se encaixa na perspectiva do Google -- e o autor decidir que portabilidade é
mais importante?

No final, parece que o Goog está tentando mais uma vez tomar controle de
projetos open source para seus propósitos e não realmente se preocupando para
que usuários finais tenha uma melhor experiência na internet.

---

[^1]: Parafraseando, eu não me lembro exatamente das palavras usadas.

[^2]: Traduzido por mim, o texto original diz: "The ISRG's approach of working
  directly with maintainers to support rewriting tools and libraries
  incrementally falls directly in line with our perspective here at Google."


<!-- 
vim:spelllang=pt:
-->
