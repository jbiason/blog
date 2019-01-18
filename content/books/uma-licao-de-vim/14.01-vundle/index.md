+++
title = "Plugins - Vundle"
date = 2015-12-22
+++

Essa é a parte em que começamos a mexer ao redor do VIM.

<!-- more -->

Vamos começar a ver como adicionar funcionalidades no VIM com plugins. E, para
isso, vamos ver Vundle, que é um gerenciador de plugins.

A pergunta que você deveria estar se fazendo agora é "E por que usar o
Vundle?". Na verdade, esta pergunta tem duas respostas:

A primeira é: Apesar de ser extremamente fácil de adicionar um plugin no VIM --
normalmente é uma questão de descompactar um arquivo dentro do diretório
`$HOME/.vim` -- a parte chata é manter os scripts atualizados (e ficar preso à um
arquivo compactado) e removê-los depois, se você encher o saco de um.

A segunda é: Vundle não é o único gerenciador de plugins para VIM, mas consegue
instalar plugins por conta própria (Pathogen requer que você baixe os plugins
manualmente, assumindo depois o controle para manter atualizado); a desvantagem
é que Vundle requer que os scripts tenham uma determinada estrutura de arquivos
e diretórios, mas praticamente todos os scripts hoje utilizam esta estrutura.

Então vamos lá, instalar o Vundle:

Primeiro, você deve baixar o plugin em si. Para isso, você tem que ter o Git
instalado e executar:

```
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

Simplesmente, você está copiando o repositório do vundle para um diretório do
próprio VIM. Até aqui nenhuma surpresa, exceto que o diretório de plugins é
`$HOME/.vim/plugin` (ou `~/.vim/plugin`) e o clone colocou no diretório
`~/.vim/bundle`. Ou seja, o Vundle não está ativo como um plugin do VIM (ainda).
O Vundle faz isso de propósito, para que os scripts instalados com o Vundle não
se misturem com os plugins instalados manualmente.

A seguir, é preciso ativar o Vundle. Para isso, nós vamos adicionar o diretório
do Vundle no path do VIM e chamar o script de inicialização. Para isto,
adicione as seguintes linhas no seu vimrc:

```vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
```

Explicando: "rtp" é a forma curta de "runtimepath", que identifica os
diretórios onde o VIM irá procurar scripts, se preciso. No caso, estamos
adicionando o diretório do Vundle, que clonamos anteriormente. A seguir é
chamado o script de inicialização do Vundle.

Pronto! Agora o Vundle está instalado.

A questão é: E agora que o Vundle está instalado, "faz o que?"

O Vundle tem mais comandos disponíveis, entre eles `:Plugin "{bundle}"`[^1]. Este
comando adiciona um bundle/plugin/script na lista de bundles/plugins/scripts
gerenciados pelo Vundle. A única coisa que esse comando faz é adicionar o
bundle na lista; ele não vai instalar o bundle ainda, ele não vai remover o
bundle, ele não vai atualizar o bundle. Apenas adicionar na lista.

O parâmetro do comando, {bundle} pode ser:

* O nome de um plugin conforme listado no repositórios de scripts do VIM;
  apenas uma string (por exemplo, `:Plugin "vundle"` para instalar este script
  (que é a descrição do Vundle nos repositórios de script);

* O nome de um plugin no Github, no formato "{usuário}/{repositório}", que você
  pode ver na parte superior de qualquer repositório (por exemplo, `:Bundle "
  gmarik/vundle"` para instalar o Vundle a partir do repositório -- que tende a
  ser atualizado com maior frequência);

* Uma URL, que pode ser clonada com Git (por exemplo, `:Plugin
  "https://github.com/gmarik/vundle"` para fazer o mesmo que acima.

Uma vez que você tenha a lista de plugins que você quer no sistema, você pode
instalar todos usando `:PluginInstall`; se quiser remover um plugin, você
simplesmente o deixa fora da lista de plugins desejados e executa `:PluginClean`;
e, para atualizar os plugins que estão instalados, `:PluginUpdate.`

Acho que você já percebeu que o problema de se manter uma lista de plugins
manualmente é meio chato: Toda vez que você quiser verificar se há atualizações
dos plugins, você tem que entrar a lista inteira; se você esquecer de um plugin
e fizer `:PluginClean` irá remover esse plugin. Para evitar essa complicação,
você pode adicionar os comandos Plugin diretamente no seu vimrc[^2]. Assim, cada
vez que você usar qualquer comando do Vundle, você não precisa se preocupar em
lembrar de todos os plugins instalados.

E, como última dica, fica o seguinte: Logo após a linha do "call vundle#rc()",
adicione

```viml
Plugin 'gmarik/vundle'
```

.. que nada mais é que o repositório que fizemos o clone logo no começo; desta
forma, quando você fizer um `:PluginUpdate`, o próprio Vundle poderá ser
atualizado com a última versão disponível.

[^1] Lembram que eu falei que plugins poderiam adicionar novos comandos e que
     estes teriam pelo menos a primeira letra em maiúsculas? Pois é...

[^2] Lembre-se também que o vimrc é um arquivo executado em modo Ex e o modo Ex
     nada mais é que o modo de comando sem precisar colocar `:` na frente de cada
     comando.

{{ chapters(prev_chapter_link="./13-tags", prev_chapter_title="Tags", next_chapter_link="./14-02-airline", next_chapter_title="Plugins - Airline") }}
