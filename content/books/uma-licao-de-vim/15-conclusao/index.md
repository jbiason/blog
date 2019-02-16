+++
title = "15. Conclusão"
date = 2015-12-22
weight = 3840
+++

Essa é a parte em que nos despedimos.

<!-- more -->

Pessoalmente, a palavra que eu usaria para descrever o VIM é extensível. Não
apenas pela quantidade de plugins criados e aperfeiçoados nestes 20 anos de
editor (na verdade, 22 se você considerar a [primeira versão
disponibilizada](http://en.wikipedia.org/wiki/Vim_%28text_editor%29) em 1991 ou
25 se você considerar quando Bram Moolenaar fez a versão 1.0 para o Amiga), mas
pela forma como os comandos foram projetados: Você sabe que uma movimentação do
cursor com um número da frente “pula” outras ocorrências, então qualquer
comando que você descobre como movimentação repete esse comportamento; Você
sabe que comandos que requerem movimentação aceitam qualquer comando de
movimentação (incluindo a quantidade, discutido antes); e assim por diante.
Claro que isto permite várias formas diferentes de fazer a mesma coisa, mas
isto também garante que você vai achar uma forma que se encaixe com o seu
workflow de desenvolvimento.

E não que, como eu falei lá no começo, VIM seja o editor perfeito para todas as
condições: Existem coisas novas surgindo a todo momento (por exemplo, a idéia
de múltiplos cursores só foi popularizado quando o TextMate foi lançado no OS
X) e que o editor base não consegue fazer -- mas como o editor é extensível em
várias formas, alguém já fez um plugin para repetir o comportamento no editor.
Existem arquivos de sintaxe que são terríveis, e mesmo assim fazem parte do
pacote original -- e existem formas de atualizar por versões melhores. Existem
plugins que baseiam-se unicamente no tipo de arquivo inteiro e não no bloco --
mas não há nada que não garanta que, no futuro, alguém consiga fazer um plugin
que troque automaticamente de modo baseado no contexto atual.

Na contrapartida, existem certas coisas que o VIM consegue fazer que outros
editores não fazem: Pular para o ponto onde o texto foi inserido da última vez
é o que sempre me faz voltar a usar o VIM e que eu sinto uma tremenda falta nos
outros editores -- que, diga-se de passagem, é fácil do editor controlar pela
existência dos modos.

E, como dicas de despedida: Quando alguém comentar sobre uma feature em outro
editor, lembre-se de procurar por "vim {feature}" na internet; muito
provavelmente a feature já existe em alguma forma para o VIM ou já tem alguém
tentando escrever um plugin para fazer a mesma coisa. E lembre-se sempre que
`:wq` só funciona no VIM, não nos demais editores ou no seu emulador de
terminal[^1].

[^1] Você pode perguntar para qualquer usuário de longa data quantas vezes eles
	 tentaram fechar o terminal ou mesmo um editor de textos como Word ou
	 LibreOffice com `:wq` e a resposta provavelmente vai ser "mais vezes que eu
	 posso lembrar".

{{ chapters(prev_chapter_link="./14-10-multiple-cursors", prev_chapter_title="Plugins - Vim-Multiple-Cursors") }}
