# Save anywhere (salvar em qualquer lugar)

[English](README.md) · **Português (Brasil)** · [← todos os mods](../../README.pt-BR.md)

Abre a tela de **salvar** ou de **carregar** o diário do próprio jogo, direto do campo, sem
precisar ir dormir.

Versão 0.5.0 · apenas para **Harvest Moon: Back to Nature (USA, SLUS-01115)**.

## Controles

| Ação | Controle | Teclado (padrão) |
|---|---|---|
| Salvar | **L2 + R2** (segure os dois) | **E + R** |
| Carregar | **L1 + R1** (segure os dois) | **Q + W** |

As teclas são as do mapeamento padrão do jogo (`keybinds.ini`); se você trocou o
mapeamento, use as suas teclas para L1, R1, L2 e R2.

## O que esperar

- **Salvar** abre a tela normal do cartão de memória ("Select a MEMORY CARD slot"). Dá para
  cancelar: "Aborting save. Is that OK?" → Yes, e você volta ao campo.
- O save guarda a **hora do dia** e o **item que está na mão**.
- **Carregar** abre a tela normal de load. **Ele substitui o jogo atual** pelo diário que você
  escolher: tudo o que aconteceu desde o último save é perdido.
- Depois do load o jogo **não** coloca você onde salvou. Ele toca a cena de acordar na casa,
  como sempre: o personagem aparece na mesa e toma o café da manhã, depois o controle volta,
  com o mesmo item que você tinha ao salvar. Essa refeição é cena do próprio jogo; o mod não
  a cria nem a pula.
- Carregar com L1 + R1 também gira a câmera uma vez, porque L1 e R1 giram a câmera no campo.

## Quando funciona

Os atalhos só disparam com você livre no campo. Eles são recusados:

- durante um diálogo ou uma cutscene (um save feito durante um evento voltava para o diálogo
  desse evento),
- com o menu Start aberto.

Eles **não** são protegidos na tela "Now Loading", então não aperte enquanto o jogo carrega.

## Instalação

1. Baixe `save-anywhere-<versão>.zip` na página de [Releases](../../../../releases).
2. Extraia dentro da pasta `mods/hmbtn/`, ao lado do executável do jogo (crie a pasta se não
   existir). Você deve ficar com `mods/hmbtn/save-anywhere/mod.toml`.
3. Reinicie o jogo. Os mods são lidos quando o jogo inicia.

Para remover, apague a pasta `save-anywhere` e reinicie. Precisa da versão do jogo com o motor
de mods (veja o [README principal](../../README.pt-BR.md#instalação)).

## Compatibilidade

Somente o disco USA, SLUS-01115. O mod escreve na RAM do jogo em endereços fixos; em outra
versão ou região ele escreveria no lugar errado, e nada consegue detectar isso.

Testado pelo autor no jogo: salvar ao ar livre segurando um item e carregar em seguida.
Não testado: salvar no fim do dia.

## Como funciona

Os dois atalhos fazem o que o próprio jogo faz: escrevem as palavras que o `SetMode` escreve,
a palavra de modo em `0x8005E39C` (7 = tela de salvar no cartão, 8 = tela de carregar) e a
palavra seguinte, em `0x8005E3A0` (zerada). Cada atalho exige `0x80127208 == 1` (sem diálogo
nem evento) e `0x800A072C == 0x18` (menu Start fechado), e proíbe os botões do outro atalho,
para que segurar os quatro não dispare nenhum. O raciocínio completo, com a forma como cada
endereço foi encontrado, está no bloco de comentários do [`mod.toml`](mod.toml) (em inglês).

**Por que não Select?** O Select é o botão de MAPA do jogo. Nas versões antigas o mapa abria
quando o jogo voltava da tela de load. L2 e R2 não fazem nada no campo (medido), e L1 e R1 só
giram a câmera.

## Histórico de versões

- **0.5.0**: salvar é L2 + R2 e carregar é L1 + R1 (o Select abria o mapa depois de um load).
- **0.4.0 e anteriores**: salvar era Select + L1 e carregar era Select + R1; recusado durante
  eventos e com o menu Start aberto.

## Licença

[PolyForm Noncommercial 1.0.0](../../LICENSE) (texto em inglês). Projeto não oficial de fã;
não contém dados do jogo.
