# Dotiles

Install instructions:

Clone:
```
git clone --bare https://github.com/zenhaeus/dotfiles.git $HOME/.dotfiles
```

Define alias:
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Checkout:
```
dotfiles checkout
```
