+++
title = "14.05. Plugins - Tabular"
date = 2015-12-22
weight = 3589
+++

Essa é a parte em que deixamos as coisas alinhadas.

<!-- more -->

O quinto plugin da lista de plugins é
[Tabular](https://github.com/godlygeek/tabular), um plugin para alinhar
elementos baseados em expressões regulares (calma, não é tão complicado quando
parece.)

Mais uma vez, para instalar pelo Vundle:

```viml
Plugin "godlygeek/tabular"
```

Assim como Fugitive e Commentary, Tabular não é um plugin visual, mas adiciona
um novo comando `:{range}Tabularize {expressão regular}`.

(Apenas lembrando de {range}: são dois indicadores separados por vírgula,
números são linhas, "$" é a última linha do arquivo, "%" é igual à "1,$" (todo o
arquivo), "'{marcador1},'{marcador2}" vai do marcador1 até o marcador2 e, se você
selecionar uma região no modo visual, ao pressionar `:`, o prompt deve ficar "'<
,'>" que são os marcadores especiais de início e fim, respectivamente, da área
visual. Todos os exemplos que eu vou mostrar daqui pra frente vão usar o
{range} de início e fim do bloco visual, porque faz mais sentido.)

A forma mais simples de usar o Tabular é passar um único caractere, que indica
qual o ponto onde os elementos serão alinhados. Por exemplo, com o seguinte
trecho de código:

```javascript
var pos = 1;
var element = $(this);
var i = 0;
```

Se você selecionar o mesmo visualmente e fizer `:'< ,'>Tabularize /=`, o resultado será:

```javascript
var pos     = 1;
var element = $(this);
var i       = 0;
```

Ao contrário da pesquisa (e da substituição), Tabularize aceita um segundo
parâmetro que indica como os elementos devem ser alinhados e qual o espaçamento
que deve existir entre os elementos. Este parâmetro pode ser até 3 pares, no
formato {alinhamento}{espaços depois do elemento} que, apesar da minha péssima
descrição, não é tão complicado assim.

Por exemplo, imagine que eu tenho o seguinte pedaço de código em HTML:

```html
<input class='block-size disabled'
    id='input-box'
    name='login'
    value=''
    placeholder='Enter your login'>
```

No caso, eu estou quebrando cada um dos elementos para diminuir o tamanho da
linha, já que ainda não coloquei minhas opções de templating e cada uma destas
linhas deve ficar bem maior. Mas, como exemplo, serve.

O que eu quero é que os "=" fiquem alinhados (mais ou menos o que o Xcode faz
com código Objective-C). Assim, eu posso fazer `:'< ,'>Tabularize /=/r0c0l0` para
obter:

```html
   <input class='block-size disabled'
             id='input-box'
           name='login'
          value=''
    placeholder='Enter your login'>
```

A explicação está no parámetro: o primeiro par, "r0" siginfica que o elemento
antes do alinhamento deve ser alinhado à direita ("r") com 0 espaços depois do
elemento; "c0" significa que o elemento de alinhamento (no nosso caso, "=")
deve ser centralizado ("c") também com 0 espaços depois; e finalmente "l0"
significa que o elemento depois do alinhamento deve ficar à esquerda ("l") e
nenhum espaço deve ser adicionado.

Se eu quisesse que o espaço não ficasse grudado tanto na esquerda quando na
direita, eu teria que fazer `:'< ,'>Tabularize /=/r1c1l0` para obter:

```html
   <input class = 'block-size disabled'
             id = 'input-box'
           name = 'login'
          value = ''
    placeholder = 'Enter your login'>
```

{{ chapters(prev_chapter_link="./14-04-commentary", prev_chapter_title="Plugins - Commentary", next_chapter_link="./14-06-autopairs", next_chapter_title="Plugins - Auto-pairs") }}
