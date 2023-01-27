# Use `config-neovim` as a GIT Subtree of your own dotfile repository

This presumes that your whole `$HOME` is a git repo. If not, you can easily adjust the commands.

## 3 simple Steps to add `config-neovim` as a subtree to your repo

### Step 01 - Add the `config-neovim` repo as a remote

Go to the base direcory of your `dotfiles` repo (e.g. your `$HOME` if its checked out there).

```
# go to you base dir

cd 

# NORMAL YOU WOULD USE THIS
git remote add config-neovim https://github.com/kuetemeier/config-neovim.git

# OR - AS ALTERNATIVE - use somethis like this,
# if you are locked in to GitHub or use your own fork directly (see below)
git remote add config-neovim git@github.com:kuetemeier/config-neovim.git

```

### Step 02 - Backup old `nvim` directory if it exists

```
# backup old nvim dir if it exists
mv .config/nvim .config/nvim.old
```

### Step 03 - checkout `config-neovim`

Checkout `config-neovim` main branch and squash all commits into one commit of your repository.

```
git subtree add --prefix .config/nvim config-neovim main --squash
```

## Update to the latest version

Now you can update the subtree to the latest version at any time with the following command:

```
git fetch config-neovim main
git subtree pull --prefix .config/nvim config-neovim main --squash
```

## Contribute back to upstream (config-neovim)

### Step 01 - Fork config-neovim

Fork `config-neovim` on GitHub

### Step 02 - Add your fork as another upstream

This can be done easily with 

```
git remote add my-config-neovim ssh://git@github.com:my/config-neovim.git
```

### Step 03 - Push changes from the subtree to the fork

```
git subtree push --prefix=.config/nvim my-config-neovim main
```

### Step 04 - Make a pull request

Now you can make a pull request as usual.

