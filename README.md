# dotfiles

- `git clone git@github.com:dsokal/dotfiles.git .dotfiles`
- `cd .dotfiles && ./install`.
- Manual steps:
  - Install [GPG Suite](https://gpgtools.org/), import GPG keys, and optionally set matching email in `gitconfig_local`.
  - Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
  - Install [Sublime Text](https://www.sublimetext.com/) and re-run `./install`.
  - Install [Visual Studio Code](https://code.visualstudio.com/).
  - Claude Code notifications: install [Claude](https://claude.ai/download) (for the icon) and re-run `./install`; set terminal-notifier's style to "Persistent" in the System Settings pane it opens; grant VS Code Accessibility access (System Settings → Privacy & Security) so notifications are skipped while you're looking at the project.
- Optional steps:
  - Install [SDKMAN!](https://sdkman.io/) with `curl -s "https://get.sdkman.io" | bash`.
