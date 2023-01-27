# Neovim / Vim / VI Configuration

*This is my current Neovim / Vim / VI configuration for text editing,
programming, server maintenance etc.*

**Feel free to use it directly or as a basis for your own configuration.**

The template itself is licensed under the [Apache 2.0][] and the [CC-BY 4.0][]
licenses (see [Copyright and Licenses](#copyright-and-licenses) for more
informations).

Contributions [welcome](#contributing).


## Table of contents

* [Motivation](#motivation)
* [Quick start](#quick-start)
* [Versioning](#versioning)
* [Issues](#issues)
* [Contributing](#contributing)
* [Authors](#authors)
* [Copyright and Licenses](#copyright-and-licenses)

## Motivation

OpenSource has given me a lot and I want to give something back.

This configuration is part of my "ThePerfectSetup" Series. Tools and Software
I use in my daily work and life. You can find more informations on my
[Blog](https://kuetemeier.de/blog/).

## Quick start

### Use config as is

Create or backup (if exists) the directory `~/.config/nvim`:

    mv ~/.config/nvim ~/.config/nvim.old
    mkdir -p ~/.config
    cd ~/.config

    # if you are logged in to github use
    git clone git@github.com:kuetemeier/config-neovim.git

    # if not, just use:
    git clone https://github.com/kuetemeier/config-neovim.git nvim

### (Optional) Link `.vimrc` file

If you use `vim` (and not only `nvim`) you should link the `.vimrc` file in
you `$HOME` directory to `~/.config/nvim/init.vim`.

    mv ~/.vimrc ~/.vimrc.old
    ln -s ~/.config/nvim/init.rc .vimrc

### (Optional) Use a local / custom config file

If you want to use additional or local configuration settings, just create
a `~/.config/nvim/local.vim` file. It will be parsed after all other settings.
So you can override or add every setting you like.


## Versioning

For transparency into the release cycle and in striving to maintain backward
compatibility, this project is maintained under [the Semantic Versioning
guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to
those rules whenever possible.

See [the Releases section of our GitHub
project](https://github.com/kuetemeier/config-neovim/releases) for changelogs
for each release version.

## Issues

Please report any bugs or requests that you have using the GitHub issue tracker!

## Contributing

**Contributions Welcome!**

Please read through our [contributing guidelines](./CONTRIBUTING.md). Included
are directions for opening issues, coding standards, and notes on development.

Editor preferences are available in the editor config for easy use in common
text editors. Read more and download plugins at http://editorconfig.org.

## Authors

**Jörg Kütemeier**

* <https://kuetemeier.de> - Website (German)
* <https://kuetemeier.com> - Website (English)
* <https://twitter.com/kuetemeier>
* <https://github.com/kuetemeier>

## Copyright and Licenses

### Apache License 2.0

Copyright 2016-2019 - Jörg Kütemeier - https://kuetemeier.de

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License.  You may obtain a copy of the
License at

   <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied.  See the License for the
specific language governing permissions and limitations under the License.

### Documentations under CC-BY

Documentations in the `doc` folder released under Creative Commons - [CC-BY
4.0][]

### External libraries and software

All files located in the `node_modules`, `vendor` and `external` directories (if
present) are externally maintained libraries used by this software which have
their own licenses; we recommend you read them, as their terms may differ from
the terms above.

[Kuetemeier.NET]: https://kuetemeier.net/ "Kuetemeier.NET GmbH"
[CC-BY 4.0]: http://creativecommons.org/licenses/by/4.0/ "Creative Commons Attribution 4.0
International (CC BY 4.0)"
[Apache 2.0]: http://www.apache.org/licenses/LICENSE-2.0
