# Dotfiles

## Usage


### chezmoi
```sh
chezmoi edit --apply $FILE
chezmoi edit $FILE
chezmoi status
chezmoi diff
chezmoi apply
chezmoi git add / commit / push

chezmoi git pull -- --rebase && chezmoi diff

sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply tatsuya4559
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --one-shot tatsuya4559
```

### plug
```sh
cd plug
make install
```
