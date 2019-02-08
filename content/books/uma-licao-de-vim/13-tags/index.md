+++
title = "13. Tags"
date = 2015-12-22
weight = 3328
+++

Essa é a parte em que você vai entender Unix um pouco.

<!-- more -->

Eu expliquei antes que haviam dois comandos para utilizar tags, `[Ctrl]]` e
`[Ctrl]t`. Existem duas coisas que eu não expliquei: O que são tags e de onde
elas vem.

Primeiro, tags são qualquer palavra que o editor encontre no arquivo de tags. E
o arquivo de tags pode ser definido em `:set tags`. Por padrão, são verificados
os arquivos `./tags` ("tags" no diretório atual do editor), `./TAGS`, `tags`
(arquivo "tags" em algum diretório de pesquisa) e `TAGS`.

Acontece que não é qualquer arquivo com este nome que o torna válido. Existem
um formato específico em que as coisas devem estar declaradas para serem
detectadas como tags. E o formato é

```
{tagname}{tagfile}{tagaddress}
```

(onde "tagname" é a tag em si, "tagfile" é o nome do arquivo onde a tag se
encontra e "tagaddress" é uma expressão Ex para encontrar a tag -- por exemplo,
"89" para ir para linha 89).

Sim, só isso. E eu sei que manter um arquivo assim é chato horrores, e por isto
existem ferramentas que já fazem isso. A mais completa de todas é "Exuberant
CTags"" e pode ser encontrada em praticamente todas as distribuições Linux
atuais, gerenciadores de pacotes do OS X e ainda vem um pacote para Windows.

A grande vantagem do Exuberant é a quantidade de linguagens suportadas. Assim,
se você estiver num projeto em Python e depois passar para um projeto em C,
você ainda pode usar o mesmo aplicativo.

A sintaxe gerado do Exuberant é "ctags {arquivos}", onde "{arquivos}" são os
arquivos a serem processados (expressões como "\*.py" são válidas) ou, da forma
mais simples "ctags -R", para que todos os arquivos do diretório atual e
subdiretórios sejam processados.

Uma vez que este arquivo tenha sido criado, dentro do editor você pode usar
`[Ctrl]]` para tentar achar a definição da tag (que, com o uso do Exuberant
significa definição de funções ou definições de variáveis) e `[Ctrl]t` para
retornar para a localização anterior. Se houver mais de um arquivo com uma
definição válida, o VIM irá mostrar uma lista das localizações e você poderá
selecionar qual deve ser acessada.

A única dica que sobra aqui é cuidar com arquivos minificados. Isso porque o
Exuberant entende arquivos CSS. Não que arquivos CSS sejam um problema, mas o
Exuberant coloca a expressão regular da linha onde a tag se encontra e, num
arquivo minificado, a expressão acaba sendo uma linha gigantesca, que fica se
repetindo em vários lugares do arquivo, deixando-o gigantesco. Se você tiver
algo desse tipo, use a opção "--exclude={expressão}", onde "{expressão}" é a
expressão regular que define o nome dos arquivos que devem ser ignorados.

{{ chapters(prev_chapter_link="./12-modelines", prev_chapter_title="Modelines", next_chapter_link="./14-01-vundle", next_chapter_title="Plugins - Vundle") }}
