+++
title = "Múltiplas Distribuições com Toolbx"
date = 2022-06-24

[taxonomies]
tags = ["linux", "podman", "conteineres", "toolbox", "toolbx"]
+++

Quando eu troquei meu Fedora pelo
[Silverblue](https://silverblue.fedoraproject.org/), eu passei a usar `toolbox`
para verificar pacotes e coisas do genêro. Mas quando eu precisei testar um
projeto em múltiplas distribuiçoes, eu decidi que era hora de explorar Toolbx
um pouco mais a fundo.

<!-- more -->

## O que é?

Antes de mais nada, Toolbx (ou `toolbox`) é uma ferramente criada para
facilitar o uso de imagens com  [Podman](https://podman.io/). Sabe quando você
usa o Docker para criar uma imagem que você possa usar junto com a sua
instalação atual, que você possa quebrar de várias maneiras sem estragar o
sistema externo e ainda tem acesso aos seus dados? Bom, isso é o Toolbx.

Por padrão, no Silverblue, existe apenas uma imagem: fedora-toolbox. É a
instalação padrão do Fedora Workstation, mas você pode usar qualquer versão do
Fedora. Você pode fazer

```
toolbox create
```

... para criar um ambiente com o a instalação do Fedora na mesma versão que a
versão do Silverblue e então

```
toolbox enter
```

... para entrar na imagem. A partir daí você pode instalar qualquer coisa sem
que isso afete o seu sistema.

`toolbox create` tem uma opção para selecionar uma imagem, é foi nisso que eu
tive a ideia de usar o Toolbx para ter várias distribuições no meu sistema,
cada uma no seu contêiner isolado, com suas próprias ferramentas, e que eu
pudesse estragar a vontade sem estragar a instalação básica.

## Usando outas imagens

Para usar uma imagem diferente no Toolbx, você pode simplesmente baixar a
imagem usando `podman pull` e o nome da imagem. Infelizmente, nem toda imagem
está pronta para ser usada, porque o Toolbx tem alguns requisitos para
conseguir interagir com a imagem.

## Requisitos

Primeiro, é preciso que `capsh` esteja disponível dentro da imagem. O nome do
pacote depende da distribuições, mas nas imagens que eu tentei usar, nenhuma
delas tinha o mesmo instalado por padrão.

Segundo, você possivelmente vai precisar do "sudo" para que você possa instalar
pacotes no container e, novamente, parece que ele não é padrão nas outras
imagens.

Terceiro, como "sudo" não vai estar disponível, não vai haver um arquivo
`sudoers`, fazendo necessário que você crie um.

Quarto, o grupo de usuários do sudo muda de distribuição para distribuição;
algumas chamam o grupo de "sudo", outras chama de "wheel". Mas o grupo deve
existir.

E quinto, Toolbx vai alterar o entrypoint do container, então você precisa
garantir que o não há nenhum comando no entrypoint da imagem.

{% note() %}
Existe uma linha que basicamente remove o entrypoint não importa o que a imagem
base usa, e eu adicionei a mesma em todos os exemplos, só por garantia.
{% end %}

## Uma imagem OpenSuse

Vou começar com uma imagem do OpenSuse: Suse não tem um grupo de sudo, não vem
com o `capsh` nem com `sudo`. Assim, eu tive que criar minha própria imagem.
Isso pode ser feito com um arquivo `Containerfile` or, se você preferir, pode
criar o mesmo com o nome `Dockerfile`, que o Podman não tem o menor problema em
usar.

Assim, eu tenho esse `Containerfile`:

```
FROM opensuse/leap:15.1

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN groupadd wheel
RUN zypper install -y libcap-progs sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

Os labels são apenas para informar o Toolbx que a imagem é uma imagem Toolbx.
Como não há um grupo de sudo, eu tive que criar um grupo chamado "wheel";
libcap-progs é onde o `capsh` se encontra; um arquivo `sudoers` foi adicionado
para permitir usar `sudo` sem senha.

{% note() %}
Se você estiver curioso, esse é o conteúdo inteiro do `sudoers` é apenas uma
linha:

```
%wheel        ALL=(ALL)       NOPASSWD: ALL
```
{% end %}

Com isso, a imagem pode ser criada com `podman create . -t suse51` onde
"suse51" vai ser o nome da imagem.

Com a imagem criada, o ambiente do Toolbx pode ser criado com `toolbox create
-i <hash> suse`; o `<hash>` é a parte do ID da imagem e `suse` vai ser o nome
do toolbox. Não sei porque, mas algumas vezes referenciar a imagem pelo nome (o
nome que usamos na parte do `build`) não parece funcionar, mas o hash sempre
funciona.

E, com isso, para usar o ambiente, basta usar `toolbox enter suse`.

Outras distribuições que eu tive que construir a imagem:

## Uma Imagem Ubuntu

Parecido com o OpenSuse, a imagem padrão do Ubuntu não vem com `capsh` nem
`sudo`, mas isso pode ser corrigido com este `Containerfile`:

```
FROM ubuntu:18.04

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN apt update && apt upgrade -y
RUN apt install -y libcap2-bin sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

Ainda, o grupo do `sudo` é "sudo", e o arquivo `sudoers` tem que refletir isso.

## Uma Imagem Centos 7

Centos 7 vem com `capsh`, mas não com o `sudo`. Assim, precisamos de mais uma
imagem customizada:

```
FROM centos:7.3.1611

LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true"

RUN yum -y update yum-skip-broken
RUN yum install -y sudo
COPY sudoers /etc/sudoers

ENTRYPOINT []
```

O grupo do `sudo` é o "wheel", e assim o `sudoers` tem que ser ajustado.

## Conclusão

Bom, é basicamente isso. Eu tive que trabalhar um pouco com as iagens,
verificar os logs tentando criar ambientes com `toolbox create -i <imagem>
<umnome> --log-devel DEBUG` para ver o que o Toolbx estava encontrando de
problemas, encontrar uma solução para isso, mas depois que a primeira imagem
foi criada (a do Suse), encontrar o que estava falando foi bem fácil.

E agora eu não preciso ficar pulando de distribuição em distribuição para
descobrir se o nosso projeto funciona nelas.
