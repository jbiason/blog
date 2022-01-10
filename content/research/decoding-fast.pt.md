+++
title = "Decodificando o Protocolo FAST"
date = 2022-01-10

[taxonomies]
tags = ["finanças", "binário", "protocolo", "fix", "fast"]
+++

Recentemente tive que trabalhar com um FAST (FIX Adapted for Streaming) e
como a documentação está espalhada, decidi colocar as coisas que descobri em um
único lugar para (minha) referência futura.

<!-- more -->

{% note() %}
Como isso é baseado na minha experiência pessoal e eu tive contato com uma
única instância disso até agora, existem algumas coisas que estão incompletas
e/ou erradas. Vou continuar atualizando este post enquanto descubro coisas
novas.

O changelog está no final deste post.
{% end %}

# O que é o FAST

[FAST](https://en.wikipedia.org/wiki/FAST_protocol) é, basicamente, um método
de compressão para o protocolo FIX.

# E o que é FIX

[FIX](https://en.wikipedia.org/wiki/Financial_Information_eXchange) é um
protocolo criado para as instituições financeiras trocarem informações. Embora
não haja nada "financeiramente" relacionado a ele - você poderia usar o
protocolo para qualquer coisa, basicamente - a maioria das empresas financeiras
o usa.

FIX é um protocolo muito simples: você tem pares de "campo ID" e "valor"
separados por um "`=`" (sinal de igual) e os pares são separados pelo caractere
ASCII com código 1 (que é representado por `^A` em alguns editores). Alguns IDs
de campo são definidos pelo protocolo (há uma lista completa
[aqui](https://www.inforeachinc.com/fix-dictionary/index.html)), mas cada
central pode criar seus próprios IDs.

Por exemplo, se você tiver o campo MsgType (ID 35) com valor "`y`" e o campo
Security ID (ID 48) com valor " 123456", a mensagem recebida seria

```
35=y^A48=123456
```

# E de Volta ao FAST

Uma das coisas para que o FAST foi projetado é remover conteúdo duplicado e/ou
constante. Por exemplo, MsgType (ID 35) identifica que a mensagem é
"SecurityList" (lista de ativos), que contém informações sobre todos os
símbolos (seus IDs de segurança) disponíveis na exchange. Como a exchange é a
mesma em todos os símbolos, o FAST permite definir os campos relacionados a ela
(Source, campo ID 22, e Exchange, campo ID 207) para valores constantes, para
que não precisem ser transmitidos e, na decodificação FAST de volta a FIX, o
decodificador simplesmente adiciona o valor constante.

Para saber quais campos são constantes e quais não (e algumas outras
informações), o protocolo define um modelo, que possui um esquema bem definido,
para relatar essas informações.

# O Template

O template é um arquivo XML que descreve os campos, seus tipos, nomes, IDs e
operatores. O protocolo em si não fornece nenhuma maneira padrão de realmente
receber esse campo e, portanto, é deixado para que a exchange defina a forma
dos clientes encontrar este arquivo.

Note que o modelo descreve os IDs de campo e seus tipos, e os dados recebidos
possuem apenas os valores. Se usarmos a descrição FIX acima, o modelo define o
lado esquerdo do par, enquanto os dados de entrada têm apenas o lado direito.

## Tipos de Campos

O protocolo define arquivos tipos de dados: Inteiros de 32 e 64 bits sem sinal,
Inteiros de 32 e 64 bits com sinal, strings em ASCII, strings em UTF8,
sequências, decimais e um tipo especial chamando "Mapa de Presença" (Presence
Map).

Uma coisa que o processamento de todos os campos é que estes usam um formato de
"bit de parada". O formato é bem parecido com o formato de UTF8, embora UTF8
use um "bit de continuação" ao invés de "bit de parada", mas o processo de
leitura é o mesmo:

- Ler um byte;
- O bit de mais alta ordem é 0?
  - Sim: Continue lendo;
  - Não: Pare de ler o valor do campo.

Eu vou mostrar alguns exemplos mais a frente neste post.

## Definição dos Campos

O template define os campos com seus tipo nome (opcional), ID,
um indicador de presença e um operador (opcional).

Por exemplo, para descrever um inteiro sem sinal de 32 bits, chamado "MsgType"
com ID "35", ele seria descrito no template como

```xml
<uInt32 name="MsgType" id="35"/>
```

Como não há indicador de presença, é assumido que o campo é "mandatório" e deve
sempre deve ter um valor. Por outro lado, se a definição do campo for algo do
tipo

```xml
<int32 name="ImpliedMarketIndicator" id="1144" presence="optional"/>
```

... então o campo pode não ter valor. Isso também é definido como campo
"nulável" (nullable).

## Campos Mandatórios e Opcionais

A diferença entre campos opcionais e mandatórios é que campos mandatórios
*sempre* tem um valor, mesmo que seja 0. Campos opcionais, por outro lado,
podem ser null e não ter valor algum.

{% note() %}
Eu tenho a impressão que isso foi feito para que a exchange possa marcar um
campo como "não parece na versão FIX"; então mesmo que o campo tenha uma
definição, o resultado em FIX não teria o campo.

Então é algo mais como "compatibilidade com versões anteriores" do que qualquer
outra coisa.
{% end %}

## Tipos

### Tipos: Inteiros

Para ler um inteiro, o decodificador pegaria os 7 bits mais baixos (tudo exceto
o bit de alta ordem) e mover os mesmos para o valor resultante. Se o bit de
parada estiver presente, a leitura está completa; se não estiver, deve ser
feito um "shift" de 7 bits no valor resultado e movidos os 7 bits do próximo
byte e assim por diante, até que seja encontrado um byte com o bit de parada.

Inteiros de 32 e 64 bits definem apenas os valores máximos de um campo e não
necessariamente usados como "número de bits a serem lidos" -- justamente por
causa do bit de parada. Se o valor excede 32 ou 64 bits, isso é considerado um
erro e o processamento deve ser abortado.

Inteiros com sinal funcionam exatamente igual, mas com complemento de 2.

Por exemplo, se os dados de entrada tem os seguintes bytes (em binário, para
ficar mais fácil de ler; eu adicionei um underscore entre cada 4
valores, também para ficar mais fácil de ler):

```
0000_0001 1001_0010
```

... o decodificador irá ler o primeiro byte e ver que o bit de mais alta ordem
não está ligado, então ele mantém apenas o "1" do valor e move 7 bits à
esquerda. O segundo byte então é ligado; este tem o bit de alta ordem ligado,
então os bits restantes (no caso, "001_0010") são adicionados no valor final e
temos `1001_0010` -- ou 146.

Números negativos são representados por complemento de 2, então se o
decodificador receber, por exemplo:

```
0000_0011 0111_1110 1110_1110
```

... que, quando os bits de alta ordem são removidos, deve gerar "`1111_1111
0110_1110`", que é -146 (em 16 bits, apenas para ficar mais fácil de ler).

Quando um campo inteiro é opcional, o valor resultante deve se decrementado 
em 1. O motivo é que deve haver uma forma de diferenciar entre 0 e Null. Assim,
um inteiro que seja decodificado para 0 é, na verdade, Null; para obter o valor
0 num inteiro, é enviado o valor 1, que é decrementando por 1 e volta a zero.

### Tipos: Strings

Strings em ASCII são bem simples de serem lidas: Novamente, o decodificador
fica lendo os dados de entrada até que encontre um byte com o bit de mais alta
ordem ligado (novamente, o bit de parada) e converte cada byte para o
respectivo caractere em ASCII.

Por exemplo

```
0100_1000 0110_0101 0110_1100 0110_1100 1110_1111
```

... iria gerar os bytes 72, 101, 108, 108 e 111, que usando a tabela ASCII
geraria o valor "Hello". Note que o bit de parada aqui representa "acabou a
string" e os bytes não devem ser agrupados como em Inteiros.

{% note() %}
Até aqui eu não tive nenhum contato com strings UTF8, então eu não tenho
certeza de como estes devem ser lidos. Com certeza há documentação em como
devem ser lidos, mas como esta é a minha experiência pessoal com o protocolo,
eu decidi não comentar aqui.
{% end %}

Strings opcionais são Null quando o primeiro byte tiver o bit de mais alta
ordem ligado e todos os demais desligados.

### Tipos: Sequências

Sequências são basicamente arrays. O primeiro campo de uma sequência é o
"tamanho" (com o tipo "`<length>`" no template) com o número de registros
presentes. Dentro da sequência, você tem uma lista de definições de campos, que
podem até mesmo incluir outras sequências.

Sequências opcionais afetam a forma como o campo de tamanho é lido: Se a
sequência é opcional, o tamanho deve ser tratato como um inteiro opcional e,
portanto, decrementando em 1.

### Tipos: Decimais

Decimais são formados por dois campos: Expoente e Mantissa. A forma como isso
funciona é que se você tiver um Expoente de "-2" e uma Mantissa de "1020", o
valor resultante é `1020 * 10 ^ -2` ("1020 vezes 10 na potência -2") ou
"10.20".

Tanto o Expoente quanto a Mantissa são lidos como Inteiros com sinal.

Um Decimal opcional significa que o Expoente é opcional. A documentação diz que
a Mantissa é sempre mandatória, mas tem uma pegadinha: Se o Expoente é Null,
então a Mantissa não está presente nos dados de entrada e o Decimal inteiro é
Null; caso contrário, o decodificador deve ler a Mantissa e aplicar a forma
acima.

Ainda, como o Expoente e a Mantissa são dois campos, eles podem ter operadores
diferentes. Eu vou mostrar exemplos depois de explicar os Operadores,
principalmente porque eu vi os dois com operadores diferentes e a leitura é
complicada.

### Tipo: Mapa de Presença

Mapas de Presença são usados em conjunto com operadores. Eles são lidos da
mesma forma como Inteiros sem sinal (ler os bytes até encontrar o byte com o
bit de mais alta ordem ligado, remover os bits de alta ordem e colocar os bits
em sequência) mas não há uma conversão em si. Cada vez que o decodificador
precisa verificar se um campo está presente no Mapa de Presença, o bit é
consumido e a linha avança.

Mapas de Presença não estão presentes no template e a existência do Mapa ocorre
se pelo menos um dos campos precisa do Mapa de Presença. Por exemplo, se os campos
de uma sequência são todos mandatórios, não haverá Mapa de Presença nos dados
de entrada.

Os bits do Mapa de Presença sequem a ordem dos campos no template. Por exemplo,
se um template tem

1. Um campo mandatório;
2. Um campo com um operador que requer o Mapa de Presença (eu vou comentar
   sobre estes mais pra frente);
3. Outro campo mandatório;
4. E, finalmente, outro campo com operador.

... é possível ter um mapa de presença como `1110_0000`, no qual:

1. O primeiro bit é o bit de parada, e o decodificar assume que este é o último
   byte do Mapa de Presença.
2. O segundo bit indica que o primeiro com operador está presente. Ele *não*
   representa o campo mandatório porque, bom, o campo é mandatório e, assim,
   está sempre presente.
3. O segundo bit indica que o segundo campo com operador está presente.

(De novo, eu vou mencionar quais operadores requerem o Mapa de Presença.)

## Operadores

Operadores definem a forma como alguns campos devem ser tratados. Eu vi 5 tipos
diferentes de Operadores:

- Nenhum;
- Constant;
- Default;
- Copy;
- Delta;
- Increment.

### Operador: Nenhum.

Quando não há operador definido para o campo no template, então o operador e o
"Nenhum". Isto significa que não há forma especial de lidar com o valor de
entrada.

Quando um campo tem o operador "Nenhum", não haverá bit para o mesmo no Mapa de
Presença.

### Operador: Contant

Um campo com o operador Constant (Constante) não irá ser enviado nos dados de
entrada e o decodificador deve assumir que o valor é o valor constante.
Anteriormente eu mencionei que uma lista de símbolos pode ter o campo 22,
"Source" e o campo 207 "Exchange", com valores contantes, e assim eles seriam
definidos como

```xml
<string name="Source" id="22">
    <constant value="123"/>
</string>
<string name="Exchange" id="207">
    <constant value="EXCHANGE"/>
</string>
```

Existe uma pegadinha, no entanto: Se um campo contante pode ser Null
(`presence="optional"`), então o decodificador precisa verificar o Mapa de
Presença: Se estiver ligado, o valor contante deve ser usado; caso contrário, o
valor do campo é Null.

O Mapa de Presença deve ser usado apenas se o campo com valor contante é
opcional.

### Operador: Default

O operador Default é parecido com o operador Constante, mas o decodificador
precisa verificar o bit do campo no Mapa de Presença; se estiver ligado, o
valor do campo deve ser lido dos dados de entrada; caso contrário, deve ser
usado o valor Default.

{% note() %}
Uma forma de ler isso é: O valor está presente nos dados de entrada (indicado
pelo Mapa de Presença)? Leia o valor dos dados de entrada; caso contrário, use
o valor default.
{% end %}

### Operador: Copy

O operador Copy (Cópia) indica que o valor deste campo neste registro tem o
mesmo valor do registro anterior; se este é o primeiro registro, então o valor
atual deve ser usado. Se o bit no Mapa de Presença estiver ligado para este
campo, então o decodificador deve ler o campo dos dados de entrada; caso
contrário, o valor anterior deve ser usado. 

{% note() %}
Nos dados que eu vi, todo primeiro registro tinha o bit ligado.
{% end %}

Por exemplo: Com um template como:

```xml
<string name="MDReqID" id="262">
    <copy/>
</string>
```

... e os dados de entrada tem os seguintes registros e Mapas de Presença:

1. O primeiro registro tem o bit do campo ligado no Mapa de Presença e a string
   é lida como "primeiro". O resultado para este campo neste registro será o
   valor "primeiro".
2. O segundo registro não tem o bit ligado no Mapa de Presença. Assim, o
   decodificador usa o valor anterior e este campo neste registro terá o valor
   "primeiro" (de novo).
3. O terceiro registro tem o bit do Mapa de Presença ligado novamente, e é lido
   o valor "segundo". Este é o valor para este campo neste registro.
4. O quatro registro não tem o bit ligado no Mapa de Presença e o decodificador
   usa o valor "segundo" para o campo.

O operador Copy pode indicar o valor inicial do campo. Por exemplo

```xml
<string name="MDReqID" id="262">
    <copy value="string"/>
</string>
```

Isso significa que deve usar "string" como valor anterior, mesmo no primeiro
registro.

Conforme indicado, campos com o operador Copy sempre aparecem no Mapa de
Presença.

### Operador: Delta

Delta é um operador parecido com Copy, mas ao invés de usar o valor do registro
anterior neste campo, o novo valor deve ser calculado usando o valor anterior e
o atual. De novo, se não há valor anterior, então nenhuma operação é feita o
valor nos dados de entrada é o valor atual.

Um exemplo:

```xml
<uInt32 name="NumberOfOrders" id="346">
    <delta/>
</uInt32>
```

1. O primeiro registro vem com o valor "300". Este é o valor do campo.
2. O segundo registro vem com o valor "2". Este valor deve ser adicionado no
   valor anterior e usado, então o valor no segundo registro é "302".
3. O terceiro registro vem com o valor "3". Novamente, deve ser usado o valor
   anterior e o valor atual deve ser adicionar. Assim, o campo no terceiro
   registro terá o valor "305".

### Operador: Increment

Increment (Incremento) funciona de forma similar ao operador Delta por estar
sempre adicionando um valor ao valor anterior, mas o valor adicionar é sempre
1.

Se o bit do campo estiver ligado no Mapa de Presença, o valor do campo será o
valor vindo dos dados de entrada; caso contrário, deverá ser usado o valor
anterior acrescido de 1.

Exemplo:

```xml
<uInt32 name="RptSeq" id="83">
    <increment/>
</uInt32>
```

1. O primeiro registro tem o bit ligado para o campo no Mapa de Presença e o
   decodificador lê o valor "100" nos dados de entrada. Este é o valor do campo
   neste registro.
2. O segundo registro não tem o bit ligado, então não há nada a ser lido dos
   dados de entrada, mas o campo deve ter o valor "101" para este registro.

Campos com o operador Increment devem aparecer no Mapa de Presença.

## Mapa do Mapa de Presença

Existe um mapa simples que indica se um campo aparece ou não no Mapa de
Presença, [de acordo com a JetTek](https://jettekfix.com/education/fix-fast-tutorial/):

<table>
    <tr>
        <th>Operador</th>
        <th>Aparece para campos Mandatórios?</th>
        <th>Aparece para campos Opcionais?</th>
    </tr>
    <tr>
        <td>Nenhum</td>
        <td>Não.</td>
        <td>Não.</td>
    </tr>
    <tr>
        <td>Constant</td>
        <td>Não, o valor constante é sempre usado.</td>
        <td>Sim; se ligado, deve usar o valor Constante; caso contrario, o
        valor do campo é Null.</td>
    </tr>
    <tr>
        <td>Copy</td>
        <td>Sim; se ligado, deve usar o valor dos dados de entrada; caso
        contrário, deve ser usado o valor anterior.</td>
        <td>Sim, mesma coisa que campos Mandatórios.</td>
    </tr>
    <tr>
        <td>Default</td>
        <td>Sim; se ligado, deve usar o valor vindo dos dados de entrada; caso
        contrário, use o valor default.</td>
        <td>Sim; mesma coisa que campos Mandatórios.</td>
    </tr>
    <tr>
        <td>Delta</td>
        <td>Não; o valor vindo dos dados de entrada deve ser adicionado ao
        anterior.</td>
        <td>Não; mesma coisa que campos Mandatórios.</td>
    </tr>
    <tr>
        <td>Increment</td>
        <td>Sim; se ligado, deve usar o valor vindo dos dados de entrada; caso
        contrário, adicionar 1 no valor anterior.</td>
        <td>Sim; mesma coisa que campos Mandatórios.</td>
    </tr>
</table>

# Anomalias

Eu chamo "anomalia" qualquer coisa que eu levei muito tempo para entender.

## Decimais com Operadores Diferentes

Isso foi uma coisa meio complicada para entender inicialmente. Por exemplo:

```xml
<decimal name="MDEntryPX" id="270" presence="optional">
    <exponent>
        <default value="0"/>
    </exponent>
    <mantissa>
        <delta/>
    </mantissa>
</decimal>
```

Parece simples, mas tem várias peças se movendo ao mesmo tempo aqui:

1. O indicador `presence="optional"` no decimal significa que o `exponent` pode
   ser Null e apenas isso.
2. O operador Default no Expoente significa que o decodificador deve verificar
   se o expoente tem um valor presente nos dados de entrada ou se deve ser
   usado o valor default de "0".

   Existe um problema aqui: Se o Mapa de Presença indica que o valor está
   presente e é lido o valor 0, como o campo é opcional, o decodificador deve
   considerada o Expoente Null e, portanto, não há Mantissa e todo o valor é
   Null.
4. O operador Delta na Mantissa deve ser usado aplicando o valor de entrada com
   o valor anterior. Mas, se o Expoente não estiver com o bit ligado no Mapa de
   Presença, como há um valor default, este deve ser usado e não lido dos dados
   de entrada, e o valor lido deve ser usado na Mantissa.

Tipo isso:

1. O primeiro registro tem o bit no Mapa de Presença ligado e o valor lido é
   "-2"; este é o Expoente. O próximo valor valor é "1020", que é o valor da
   Mantissa, e o decimal inteiro é "10.20".
2. O segundo registro tem o bit ligado no Mapa de Presença e o valor lido é
   "0". Como o Decimal é opcional, o Expoente é opcional e como 0 é Null para
   campos opcionais, não há Expoente e o próximo valor não é a Mantissa. O
   valor do campo neste registro é Null.
3. O terceiro registro não tem o bit ligado no Mapa de Presença. Como o
   Expoente tem um valor default, ele fica como "0" e a Mantissa deve ser lida.
   Se vier o valor "10", o decimal se torna "10" (ou "10.00" para mantermos o
   mesmo número de casas decimais).

Uma coisa estranha que vi foi relacionada com a forma como a Exchange estava
ordenando os resultados. Era uma sequência de ordens de compra e venda, na
quais

1. O primeiro registro era a ordem de venda, com um Expoente de "0" e Mantissa
   de "5410". Isso significa que o valor era "5410".
2. O segundo registro era uma ordem de compra. Ele tinha o Expoente de "-2" e
   Mantissa tinha o valor de "526604". Com o operador Delta, isso dá a Mantissa
   o valor de "532014", mas como o Expoente é "-2", o valor real era de
   "5420.14".
3. A coisa estranha aconteceu no terceiro registro, que era novamente uma ordem
   de venda. O valor deveria ser o valor igual ao primeiro, mas a Exchange
   mandou o valor "0" para o Expoente e Mantissa de "-526604". Com o Delta,
   isso trouxe o valor de volta a "5410".

Eu achei estranho que a Exchange ficou mudando entre dois Expoentes ao invés de
usar apenas um, e na época eu estava com problemas com o cálculo de Deltas no
meu código, então...

## Sequências com Tamanho Null

Outra coisa que eu vi foi a Sequência opcional: Na prática não há diferença
entre uma sequência com 0 elementos e uma com o tamanho Null -- especialmente
se você pensar que o protocolo é, basicamente, um gerador de FIX. Eu não faço
ideia porque não foi padronizado que tamanhos são mandatórios e um valor de 0
significa que não há valores ao invés de ficar fazendo uma dança ao redor de
sequências mandatórias e opcionais.

---

Changelog:

2021-01-10: Primeira versão.

<!-- 
vim:spelllang=pt:
-->
