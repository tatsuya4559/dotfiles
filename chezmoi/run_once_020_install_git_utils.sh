#!/bin/bash
echo 'download .git-completion.bash'
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "$HOME/.git-completion.bash"
chmod a+x "$HOME/.git-completion.bash"

echo 'download .git-prompt.sh'
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o "$HOME/.git-prompt.sh"
chmod a+x "$HOME/.git-prompt.sh"
