#  justfile
#
#  just configuration file
#  just is a handy way to save and run project-specific commands.
#
#  Manual: https://just.systems/man/en/
#
#
#        //_/  Jörg Kütemeier <https://kuetemeier.de>
#     ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}

# Print command list
default:
    @just --list

alias f := fmt

# Format source code with treefmt
fmt:
    treefmt

alias h := hello

# Print 'Hello World'
hello:
    hello

# Health Check for nix environment
health:
    nix run "github:juspay/nix-browser#nix-health"

# Ensure Flake inputs are flat
flat:
    nix run github:linyinfeng/flat-flake -- check .

alias cpc := check-pre-commit

# Run pre commit hook checks
check-pre-commit:
 nix build --rebuild --print-build-logs .#checks.x86_64-linux.pre-commit

# {{{ SPDX Copyright Tags and Vim / NeoVim Modeline
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de/>
# SPDX-License-Identifier: MPL-2.0
#
# vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
# }}}
