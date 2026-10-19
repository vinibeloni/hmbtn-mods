# Harvest Moon: Back to Nature — mods

[English](README.md) · **Português (Brasil)**

Mods "drop-in" para a versão nativa de PC de **Harvest Moon: Back to Nature (USA, SLUS-01115)**,
feita pelo [harvest-moon-btn-psx-recomp](https://github.com/vinibeloni/harvest-moon-btn-psx-recomp).

Um mod é uma pasta com um `mod.toml`. Coloque-a em `mods/hmbtn/`, ao lado do executável do
jogo, e ele fica ativo; remova a pasta e ele some. Sem recompilar, sem regenerar, sem
liga/desliga dentro do jogo.

## Mods

| Mod | O que faz | Documentação |
|---|---|---|
| **save-anywhere** | Abre a tela de salvar (**L2 + R2**) ou de carregar (**L1 + R1**) o diário direto do campo, sem precisar ir dormir. | [English](mods/save-anywhere/README.md) · [Português](mods/save-anywhere/README.pt-BR.md) |
| **fast-dialogue** | Os textos aparecem cerca de três vezes mais rápido, sempre ligado. A velocidade é um número que você edita no `mod.toml`. | [English](mods/fast-dialogue/README.md) · [Português](mods/fast-dialogue/README.pt-BR.md) |

Cada mod tem o seu próprio README com controles, o que esperar, como funciona e o histórico
de versões. O `mod.toml` de cada um também começa com um bloco de comentários (em inglês)
explicando o que o mod faz e contra o que ele não protege. Leia os dois antes de usar um mod.

## Instalação

Você precisa do jogo compilado a partir do repositório acima, com o motor de mods (branch
`feat/drop-in-mods`, commit `5eb3c45` ou posterior).

1. Abra a pasta do mod aqui (`mods/<mod>/`), abra o `mod.toml` e clique em **Download raw
   file**. (Ou use **Code → Download ZIP** para baixar o repositório inteiro e pegar a pasta.)
2. Coloque o `mod.toml` numa pasta com o nome do mod, dentro de `mods/hmbtn/`, ao lado do
   executável do jogo (crie as pastas se não existirem). Você deve ficar com
   `mods/hmbtn/<mod>/mod.toml`. Um mod é só esse arquivo: sem zip e sem release.
3. Reinicie o jogo. Os mods são lidos quando o jogo inicia.

Para remover um mod, apague a pasta dele. Extrair numa pasta com o nome do mod
(`mods/hmbtn/<mod>/<mod>/mod.toml`) também funciona.

Ou, a partir de um clone deste repositório, o instalador faz a cópia por você:

```powershell
.\install.ps1 -GameDir "C:\caminho\da\pasta\com\o\exe" [-Mod save-anywhere]
```

```sh
./install.sh /caminho/da/pasta/com/o/exe [save-anywhere]
```

Para conferir se o motor carregou um mod, rode `python3 psxrecomp/tools/debug_client.py mod_counters`
no repositório do jogo: ele mostra `hmbtn.patchengine.mods_loaded` e, se algum mod falhou ao
ser lido, `.mods_rejected` (um mod que falha ao ser lido é rejeitado por inteiro, nunca
aplicado pela metade).

## Compatibilidade

Estes mods escrevem na RAM do jogo em endereços fixos. Eles só valem para o **disco USA,
SLUS-01115**. Em outra versão ou região escreveriam no lugar errado, e o motor não tem como
saber. Todo `[[patch]]` traz a palavra original que espera (`expected`) e é ignorado se a RAM
tiver outra coisa; as escritas de `[[trigger]]` não têm essa proteção.

## Publicar uma release (opcional)

Não é preciso para usar um mod: a pasta é o mod. O zip da release é só uma comodidade.

```sh
python3 tools/package.py                 # gera dist/<mod>-<versão>.zip, um por mod
gh release create <mod>-v<versão> dist/<mod>-<versão>.zip --title "..." --notes "..."
```

Cada zip tem uma única pasta no topo, com o nome do mod (e o README dele), com nomes de entrada
com barra normal para abrir corretamente no Windows, macOS e Linux, e data fixa, para que as
mesmas fontes sempre gerem o mesmo zip. Aumente o `version` no `mod.toml` do mod antes; o zip
leva esse nome. Baixar releases exige um repositório **público**.

## Escrever um mod

O formato do `mod.toml` (`[[patch]]`, `[[trigger]]`, `[[require]]`, `[[write]]`) está definido
e documentado no repositório do jogo (em inglês): veja a seção "Drop-in mods" do `CLAUDE.md` e
o comentário no início de `src/mods/hmbtn_patchengine.c`. Regras que importam:

- Ache os endereços medindo, não adivinhando, e escreva no bloco de comentários do mod como
  você os achou.
- Confira o estado do jogo **antes** de acionar um gatilho ao testar: um gatilho disparado muda
  o estado do jogo e toda leitura depois disso fica errada.
- Um gatilho deve dizer durante o que ele se recusa a rodar (diálogo, eventos, menus).
- Dê ao mod um `README.md` e um `README.pt-BR.md` próprios, e acrescente-o à tabela acima.

## O que nunca deve ser commitado aqui

Nenhum dado do jogo: nada de imagem de disco, executável, ROM, BIOS, cartão de memória ou save,
nem dump da RAM ou do código do jogo. Este repositório só tem arquivos `mod.toml` e scripts, e
você usa a sua própria cópia obtida legalmente. O `tools/check_no_game_data.py` garante isso;
ative a trava de commit uma vez por clone:

```sh
git config core.hooksPath .githooks
```

## Licença

[PolyForm Noncommercial License 1.0.0](LICENSE) (texto em inglês). Você pode usar, copiar,
modificar e compartilhar este código para qualquer fim não comercial (uso pessoal, projetos de
hobby, estudo, organizações sem fins lucrativos, educação etc.). Você **não** pode vendê-lo nem
usá-lo comercialmente. É uma licença "source-available", não uma licença "open source" da OSI.
O motor sobre o qual isto é construído, o [psxrecomp](https://github.com/mstan/psxrecomp), usa a
mesma licença.

Este é um projeto não oficial de fã. Não é afiliado nem endossado pela Natsume nem pelos
detentores dos direitos de Harvest Moon, e não contém dados do jogo: você precisa da sua própria
cópia do jogo, obtida legalmente.
