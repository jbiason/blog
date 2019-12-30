+++
title = "Microserviços: Expelindo Artefatos"
date = 2019-12-30

[taxonomies]
tags = ["microserviços", "artefatos", "conexões", "expelir"]
+++

Como eu estava comentando sobre [artefatos em
microserviços](@/code/microservices-artifact-input-state.pt.md), eu acredito que esqueci
de discutir um ponto importante: Como é que esses artefatos são "expelidos" do
microserviço?

<!-- more -->

"Expelido", nesse caso, significa "passa para o próximo estágio necessário",
que pode ser um bocado de coisas (algumas vezes, até mais de uma). E como eu
precisava de um palavra capciosa para chamar a atenção, já que "produz" não
tem nada de chamativo.

Por exemplo, se um microserviço produz um dado intermediário -- digamos que
ele conecta num serviço externo e busca uma informação, que é então processada
por outros microserviços -- então você vai possivelmente utilizar um serviço
de message broker (mensageria) para expelir o artefato. Usando um message
broker irá permitir que outros serviços fiquem escutando a criação desses
artefatos e que façam seu serviço -- produzindo novos artefatos.

Outra possibilidade é que esse microserviço é o fim da linha de produção e,
por isso, ele mantém o artefato consigo para ser consumido de uma forma
não assíncrona. Por exemplo, o microserviço produz elementos que são pedidos
depois uma requisição de um serviço web, e o que o microserviço precisa fazer
é produzir o artefato e mantê-lo em si, respondendo requisições mais tarde.

De novo, isso é semelhante a forma com que CQRS (command-query response
segregation -- segregação de comandos e queries) funciona: Você tem um lado do
seu microserviço que recebe dados e processa o artefato, e outro que permite a
consulta dos artefatos gerados.

Você pode até mesmo ter os dois: Quando o artefato é produzido, o microserviço
expele o mesmo pelo message broker para ser processado por outros
microserviços, e guarda o artefato localmente para ser pesquisado depois.

Existe até mesmo a possibilidade da parte de pesquisa/query ser apenas outros
microserviço: Ele recebe o artefato de outro microserviço e o armazena, sem
qualquer processamento (desde que você não considere "salva num armazenamento
permanente" uma forma de processamento). Isso é interessante porque a parte de
pesquisa/query do microserviço é apenas um outro microserviço ao invés de ser
uma espécie de microserviço especializado que produz, expele e armazena
artefatos.

Quando eu mencionando que nós salvamentos nossos artefatos no Firebase, nós
estamos basicamente construindo esse microserviço separado: Enquanto nossos
microserviços produzem artefatos, a parte de "armazenamento e pesquisa" fica a
cargo do Firebase -- mas você pode considerar isso como qualquer outro
microserviço.

(Esse post é simplesmente para ter alguns ponteiros a mais para quando eu for
discutir um pouco mais sobre o que eu penso sobre microserviços com auto-cura
-- e o que eu quero dizer com isso.)
