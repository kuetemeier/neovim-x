# Suites

Suites are a set of profiles and modules and form a complete Neovim configuration.

Currently there are 5 suites:

- **nvim-jkr** - My every day Neovim configuration
- **nvim-jkr-pde** - My full Personal Development Environment
- **nvim-jkr-minimal** - A very minimal Neovim configuration (Neovim + color theme)
- **nvim-jkr-system** - A small footprint configuration for system and server use
- **nvim-jkr-test** - !unstable - not for daily use! - Just for testing new plugins and configurations

## Run suites for tests

With flake support you should be able to test run suites like so:

```
nix run .#[suite name] -- [file to edit]

# e.g.

nix run .#nvim-jkr -- test.md
```

