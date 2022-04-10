# Dotfiles

## Usage

### for mac
```sh
curl -fsSL https://raw.githubusercontent.com/tatsuya4559/dotfiles/master/setup_mac.sh | sh
```

### for manjaro linux
```sh
curl -fsSL https://raw.githubusercontent.com/tatsuya4559/dotfiles/master/setup_manjaro.sh | sh
```

## chezmoi
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
