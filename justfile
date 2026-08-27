pull:
  [[ ! -d './ansible-monorepo' ]] && git clone git@github.com:carlba/ansible-monorepo.git || echo 'Repo already cloned'
  cd ansible-monorepo && git pull && cd ..
  cp ansible-monorepo/roles/common/files/starship.toml ~/.config/starship.toml
  cp ansible-monorepo/roles/common/files/dark-plus.yml .config/vivid/themes/dark-plus.yml
  cp ansible-monorepo/roles/common/files/.zsh_plugins.txt .
  cp ansible-monorepo/roles/common/files/.zshrc .
