# jkr-neovim - My Neovim Configuration

Here you find my **Personal Development Environment** and my **Configuration Files** for **Neovim**.

[Neovim](https://neovim.io/) is a hyperextensible Vim-based text editor - in my eyes one of the best editors in the world.

This configuration is based on [Nix: the package manager](https://nixos.org/learn.html).

## TLDR; Quick run, easy testing

Quickly run and test my Neovim setup without installing it:

### 1.) Clone the Repo

```
git clone git@git.kuetemeier.de:jkr/jkr-neovim.git
cd jkr-neovim
```

### 2.a) With nix and flakes already enabled

If you have `nix` installed on your system ([How to install nix](https://nixos.org/download.html#download-nix)),
and [flakes enabled](https://nixos.wiki/wiki/Flakes), you can run a quick and easy test of my Neovim config with:

```console
nix run .#
```

This will startup Neovim with my configuration.

If you want to directly edit a file, e.g. `demo.md` just use:

```console
nix run .# -- demo.md
```

### or 2.b) With nix - temporarily enabled flakes

If you have not enabled flakes yet, just enable them temporarily on the command line and run this instead:

```console
nix --experimental-features 'nix-command flakes' run .#
```

## Development

### Format source code

Use `nix fmt` to format the `.nix` files with `nixpkgs-fmt`.

### Upgrading nixvim

Upgrading nixvim to the latest version is sometimes a little bit tricky. Not to say "a problem". [nixvim](https://github.com/pta2002/nixvim) has decided to follow `nixos-unstable`. Especially in <https://github.com/pta2002/nixvim/blob/main/plugins/nvim-lsp/language-servers/default.nix> there are sometimes (most of the time) modules that are only available in `nixos-unstable` but not in the regular `nixpkgs` releases. Because of this the build will fail.

## My thanks to

Great work and a good source of inspiration:

- [nixvim](https://github.com/pta2002/nixvim)

## Copyright and MPL-2.0 License

(c) 2009-2023 Jörg Kütemeier - https://kuetemeier.de

This Source Code Form is subject to the terms of the Mozilla Public License, v.
2.0. See the file [LICENSE](LICENSE) in this repo. If a copy of the MPL was not
distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

