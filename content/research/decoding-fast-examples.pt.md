+++
title = "Decodificando o Protocolo FAST: Exemplos"
date = 2022-01-12
draft = true

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
O ID do Template. Como o primeiro bit está ligado, nós sabemos que o ID está
lá. Ainda, tenha em mente que o ID do Template é o único campo que nós sabemos
que existe até agora; não existe nenhuma outra informação sobre o que é aquele
segundo bit no Mapa de Presença -- nós precisamos encontrar qual template vamos
usar antes de mais nada.

O próximo byte é lido: `1000_0001`. Como mencionado acima, isso é o ID do
Template. Sendo um inteiro sem sinal (e provavelmente mandatório, mas não me
pergunte como isso funciona) e removendo o bit de parada, temos o inteiro "1",
que é exatamente o mesmo ID que temos no nosso template; agora nós sabemos
quais campos devem ser processados.

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

<!-- 
vim:spelllang=pt:
-->
