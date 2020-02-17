+++
title = "Microserviços: Onde Fica a Fonte da Verdade?"
date = 2020-02-17

[taxonomies]
tags = ["microserviços", "fonte da verdade", "estado"]
+++

Quando estamos falando de um sistema, existe um ponto que precisamos discutir
que é onde a "fonte da verdade" está. Em monolitos, a fonte da verdade está no
armazenamento dos dados em si. Mas onde é que essa fonte fica em um sistema
que é composto de múltiplas partes?

<!-- more -->

Só para ficar claro aqui: O que eu quero dizer com "fonte da verdade" é
qualquer coisa que você possa usar para verificar se o sistema está produzindo
os valores corretos. Por exemplo, em um pipeline que conta quanto foi
transferido de cada usuário em uma CDN, a fonte da verdade podem ser os logs
(você pode ler os logs e verificar se o sistema responsável por somar os
valores está correto); num site de e-commerce, podemos assumir que a fonta da
verdade é a lista de itens comprados em cada pedido para receita total (se
você somar todas as quantidades e seus preços de venda, você vai ter a receita
total de volta).

Um fator importante da fonte da verdade e que você pode usar tanto para
verificar se os serviços estão corretos quanto reaplicar o conteúdo de volta
no sistema para que artefatos sejam reconstruídos.

Mas existe um problema: Se o sistema é distribuído e [cada microserviço cria
um artefato diferente](@./microservices-artifact-input-state.pt.md), onde é
que fica a fonte da verdade?

Anteriormente, eu mencionei que microserviços podem manter um estado para
produzir o artefato. Essa pode ser a fonte da verdade para o microserviço,
desde que o mesmo não apague dados antigos -- nesse caso, como é que artefatos
antigos seriam reconstruídos se você não pode retornar o estado a um estado
anterior?

Outra solução é alterar o microserviço de importação de dados (aquele que
captura dados de uma fonte externa) para construir a fonte da verdade; havendo
a necessidade de reconstruir artefatos, você pode simplesmente adicionar uma
API nesse microserviço para que ele republique os dados relacionados com um
determinado objeto, que irão percorrer o pipeline e cada microserviço irá
reconstruir seus artefatos.

E, finalmente, se você construir um pipeline de event source corretamente,
você pode criar um serviço que irá escutar _todos_ os eventos e manter um
event source global, que você pode, novamente, expor uma API para reenviar os
eventos relacionados com um objeto.

{% note() %}
... embora eu tenha a sensação que certos eventos precisariam ser alterados;
por exemplo, se você mandar o event source reenviar os eventos relacionados
com um epdido -- para que seja recriado o artefato desse pedido -- você pode
ter que reaplicar um evento de "criar usuário", que não vai fazer sentido
porque o objeto já existe e não deve ser criado mais um usuário com as mesmas
informações.

Ou isso ou você vai ter que fazer com que o serviço de pedidos peça os dados
do cliente se ele já não tiver os mesmos.
{% end %}

De qualquer forma, uma recomendação que eu tenho é sempre construir alguma
coisa que possa guardar os seus dados, de forma que você possa reconstruir
seus artefatos novamente e os serviços apagam dados antigos (que é
perfeitamente normal, diga-se de passagem).

<!-- vim:spelllang=pt 
-->
