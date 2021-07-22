+++
title = "Experimentos com Command Pattern em Rust"
date = 2021-07-22

[taxonomies]
tags = ["design patterns", "command", "rust"]
+++

Eu tenho feito alguns experimentos implementando o command pattern em Rust e
encontrei pelo menos duas formas de implementar.

<!-- more -->

## Mas Primeiro... Por que?

Existe uma coisa que eu estou tentando fazer em que o command pattern se
encaixa perfeitamente: Eu quero ter uma biblioteca com todas as ações do
sistema e implementar uma interface em cima disso, sendo que pode ser uma CLI
ou uma interface web ou uma interface qualquer. Para isso, a lógica por trás da
ação deve estar de alguma forma isolada da origem da chamada.

## O Que É

O command pattern é descrito como ter um objeto para cada ação (porque,
basicamente, os patterns são mais focados em projetos orientados a objetos) e
cada um destes tem um método chamado `execute` que... bem... executa o comando.

## A Solução Enum

Como o que você têm é uma lista de ações, uma das ideias foi usar `Enum`, mesmo
que isso não seja exatamente o que pattern descreve.

Digamos que nós temos duas ações que podem ser chamadas: Depositar dinheiro e
sacar dinheiro. Simples.

Assim, podemos ter o seguinte Enum[^1]:

```rust
enum Command {
    Depositar(Decimal),
    Sacar(Decimal),
}
```

Como Rust permite que as variantes de um Enum carreguem um valor com elas, o
valor a ser depositado ou sacado fica anexado junto com a variante.

E então você tem a função `execute()`. E, de novo, porque Rust permite que
sejam adicionadas funções em basicamente tudo, o que eu fiz foi adicionar um
método diretamente no Enum:

```rust
impl Command {
    fn execute(&self) -> Result<...> {
        match self {
            Depositar(valor) => faz_o_deposito(valor),
            Sacar(valor) => sacar_dinheiro(valor),
        }
    }
}
```

E assim por diante.

Para usar, eu coloquei algo parecido com isso na minha camada de interface:

```rust
let valor = requisicao_externa.valor();
let comando = match requisicao_externa.comando() {
    "depositar" => Command::Depositar(valor),
    "sacar" => Command::Sacar(valor),
}
comando.execute();
```

Tudo fica simples e tal, mas existe uma tendência a deixar uma bagunça com a
quantidade de conteúdo que fica dentro ou ao redor do `impl`, na minha opinião.
Mas, ao mesmo tempo, a camada de dispatch (que fica entre a camada de
serviço/enum e a camada de interface) é bem básica.

Uma solução para para a quantidade de "conteúdo dentro ou ao redor do `impl`"
seria o uso de múltiplos `impl`: Ter um módulo `deposito.rs` que faz o `impl`
de `faz_o_deposito` e outro módulo `saque.rs` que também faz o `impl` dentro do
enum com o conteúdo de `sacar_dinheiro`. Mas eu ainda precisaria centrar todas
as operações no `execute` para ter um dispatch correto.

## A Solução com Traits

A solução com trait é bem parecida com o que o pattern diz: Você cria uma trait
(interface) e "impl" em todos os comandos, que são structs. Por exemplo:

```rust
trait Command {
    fn execute(&self) -> Result<...>;
}
```

```rust
struct Depositar(Decimal);
impl Command for Depositar {
    fn execute(&self) -> Result <...> {
        // o que era o `faz_o_deposito` vai aqui.
    }
}

struct Sacar(Decimal);
impl Command for Sacar {
    fn execute(&self) -> Result <...> {
        // o que era o `sacar_dinheiro` vai aqui.
    }
}
```

... o que parece um pouco mais limpo, já que todas as coisas relacionadas com
Deposito ou Saque estão juntas agora.

Entretanto, isso causa um pequeno problema com a camada de interface: Agora ela
não pode mais retorna algo com tamanho fixo: É necessário usar um conteúdo com
dispatch dinâmico, como `Box<dyn Command>`, o que não é tão direto quando um
Enum/Struct/conteúdo com tamanho.

Por outro lado, como `Box` implementa `Deref`, uma vez que a interface retorne
algo-que-implementa-Command, basta chamada `execute()` diretamente nele.

```rust
let comando = interface_que_retorna_um_comando_num_box_dyn();
comando.execute();
```

## Onde Eu Vejo Esses Dois

Eu consigo ver o uso do Enum em arquiteturas simples, com apenas um domínio.
Como toas as coisas são relacionadas, elas podem viver tranquilamente dentro do
Enum.

Mas quando estamos lidando com múltiplos domínios, a solução de trait/dispatch
dinâmico parece fazer mais sentido: Coisas relacionadas nos seus próprios
módulos, nos seus próprios espaços e a ideia de misturar os mesmos (por
exemplo, se você tiver um domínio de tags e um domínio de dinheiro, e quer
colocar tags nas operações de dinheiro) ficaria na camada acima deles.

---

[^1]: `Decimal` não faz parte da biblioteca padrão do Rust, mas pode ser usada
  a partir da [crate rust_decimal](https://crates.io/crates/rust_decimal).

<!-- 
vim:spelllang=pt:
-->
