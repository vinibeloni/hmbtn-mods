# Fast dialogue

[English](README.md) · **Português (Brasil)** · [← todos os mods](../../README.pt-BR.md)

Os textos aparecem cerca de três vezes mais rápido. Sempre ligado, sem botão para apertar.

Versão 0.1.1 · só para **Harvest Moon: Back to Nature (USA, SLUS-01115)**.

## O que esperar

- Todos os caracteres continuam aparecendo, na ordem. Medido no jogo: 0,64 caractere por tick
  no jogo original, 2,05 com o mod.
- O ✕ continua avançando uma caixa já terminada, exatamente como antes, e não pula a próxima.
- Caixas que se fecham **sozinhas** (sem o ícone de ✕, como o passeio pela vila com o prefeito)
  têm o tempo definido pela cena, não pelo texto. Texto mais rápido deixa menos tempo para ler.
  Se isso incomodar, diminua a velocidade (abaixo).

## Mude a velocidade você mesmo

Abra `mods/hmbtn/fast-dialogue/mod.toml` em qualquer editor de texto. No segundo `[[patch]]`,
troque o último dígito da linha `replace`, salve e reinicie o jogo:

| `replace` | Velocidade |
|---|---|
| `0x24420002` (padrão) | cerca de 3x |
| `0x24420003` | cerca de 4,5x |
| `0x24420004` | cerca de 6x |
| `0x2442000F` | o máximo |

Só o 2 foi conferido em toda a abertura, e o 4 no evento do policial. Os outros valores não
foram testados.

## Instalação

1. Abra o [`mod.toml`](mod.toml) desta pasta e clique em **Download raw file**.
2. Coloque-o numa pasta chamada `fast-dialogue` dentro de `mods/hmbtn/`, ao lado do executável do
   jogo (crie as pastas se não existirem). Você deve ficar com `mods/hmbtn/fast-dialogue/mod.toml`.
   Não precisa de zip nem de release: o mod é esse arquivo.
3. Reinicie o jogo. Os mods são lidos quando o jogo inicia.

Para remover, apague a pasta `fast-dialogue` e reinicie: o texto volta à velocidade original.
Exige o jogo compilado com o motor de mods (veja o [README principal](../../README.pt-BR.md#instalação)).

## Compatibilidade

Só o disco USA, SLUS-01115. Os dois patches trazem a palavra original que esperam (`expected`) e
são ignorados se a RAM tiver outra coisa.

Testado pelo autor jogando: o evento do policial (todas as caixas completas, o jogo segue) e o
passeio pela vila. Não testado: digitar o nome, lojas e perguntas de sim/não, e salvar logo
depois de uma cena rápida.

## Como funciona

Dois patches protegidos na rotina de mensagem do jogo (`0x80018B98`, executável principal):

| Endereço | Original | Patch | Efeito |
|---|---|---|---|
| `0x80018C10` | `lh a0,472($gp)` | `addiu a0,zero,0` | sem espera entre caracteres |
| `0x80018C58` | `addiu v0,v0,1` | `addiu v0,v0,2` | dois caracteres por passo |

O laço de desenho desenha todos os caracteres até a contagem revelada, então um passo maior não
pula nada. Como cada endereço foi achado está no bloco de comentários do [`mod.toml`](mod.toml).

## Histórico de versões

- **0.1.1**: documentou como mudar a velocidade (só comentário, mesmos patches).
- **0.1.0**: primeira versão, cerca de 3x.

## Licença

[PolyForm Noncommercial 1.0.0](../../LICENSE). Projeto não oficial de fã; não contém dados do jogo.
