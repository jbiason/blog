+++
title = "14.06. Plugins - Auto-Pairs"
date = 2015-12-22
weight = 3590
+++

Essa é a parte em que o VIM fecha as coisas pra você.

<!-- more -->

O sexto plugin da lista de plugins que eu vou falar é
[Auto-Pairs](https://github.com/jiangmiao/auto-pairs). Como de costume, para
instalar o plugin pelo Vundle:

```viml
Plugin "jiangmiao/auto-pairs"
```

Uma vez instalado o plugin, você verá que cada `'`, `"`, `(`, `[` e `{` irá,
automagicamente, gerar o seu respectivo `'`, `"`, `)`, `]` e `}`. Simples assim.

Entretanto, Auto-Pairs não funciona bem com o modo visual (se você já usou
TextMate ou Sublime Text, deve ter percebido que se você usar uma das
combinações acima com uma área selecionada, o editor vai "circular" a área
selecionada com o par indicado). O que existe é `[Alt]e` em modo de inserção que
faz a troca rápida entre o caractere de fechamento de pair com a próxima
palavra.

Por exemplo, se você tiver

```
''auto
```

... com o cursor posicionado entre as duas aspas e usar `[Alt]e`, você irá ficar com

```
'auto'
```

Ainda, o Auto-pairs tem um controle para "pular" sobre os caracteres de
fechamento já existentes. Se ele adicionar um ")" (que deve ficar antes do
cursor), quando você pressionar ")" no seu teclado, ao invés de adicionar mais
um ")", o cursor irá pular o ")" existente.

Embora isso pareça bom, em certos casos pode ser um problema. Por exemplo, caso
você tenha o seguinte trecho de código:

```javascript
$(function () {
  $('#button').on('click', function () {

})
```

Se você tentar fechar a função interna, o Auto-Pairs irá, na verdade, saltar
para o fechamento da função externa, efetivamente "proibindo" que você feche as
funções corretamente. Soluções são:

* Fechar a função externa de novo, forçando o que era para encerrar a função
  externa em encerramento da função interna (depois você pode alinhar as duas
  novamente usando o modo visual e `=` em modo normal);

* Copiar e colar o fechamento da função externa;

* Desligar o "salto" de elementos de fechamento com `:let g:AutoPairsFlyMode = 0`
  (e, se você realmente preferir que o salto nunca seja feito, pode adicionar
  esta linha no seu vimrc);

* Desligar temporariamente o Auto-Pairs com `[Alt]p` em modo de inserção (usar
  `[Alt]p` novamente irá reativar o Auto-Pairs).

{{ chapters(prev_chapter_link="./14-05-tabular", prev_chapter_title="Plugins - Tabular", next_chapter_link="./14-07-syntastic", next_chapter_title="Plugins - Syntastic") }}
