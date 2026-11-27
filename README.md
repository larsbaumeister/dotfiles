# dotfiles

fish + tide, tmux, AstroNvim, git, and a couple of scripts. Managed with
[GNU stow](https://www.gnu.org/software/stow/): every top-level directory is a
package that mirrors `$HOME`, and stow symlinks its files into place.
The files in this repo are the source of truth; there is no install script.

```
bash/   ~/.bashrc, ~/.bash_profile
bin/    ~/.local/bin/workspace_switcher   (tmux + fzf project picker, Ctrl-n in tmux)
fish/   ~/.config/fish/...                (config, fisher plugin list, tide prompt settings)
git/    ~/.gitconfig, ~/.config/git/ignore
nvim/   ~/.config/nvim                    (AstroNvim, plugins pinned in lazy-lock.json)
tmux/   ~/.tmux.conf                      (Kanagawa theme, TPM)
```

## Requirements

Install these with your package manager (names may differ slightly per distro).

| Software | Needed for |
| --- | --- |
| `git`, `stow` | cloning and linking this repo |
| `fish` | shell (make it the login shell: `chsh -s "$(command -v fish)"`) |
| `tmux` | terminal multiplexer |
| `neovim` | editor; a recent release (this setup runs on 0.12) |
| `fzf` | `workspace_switcher` |
| `lazygit` | git TUI, opened by `workspace_switcher` and from nvim |
| `ripgrep` | nvim search |
| `curl`, `unzip`, `tar`, `gzip` | fisher install, Mason downloading LSPs and tools |
| C compiler (`gcc` or `clang`) | building treesitter parsers |
| `python3` | Mason's `debugpy` |
| A [Nerd Font](https://www.nerdfonts.com/), set in your terminal emulator | icons in the tide prompt and nvim (on WSL: set it in Windows Terminal) |

Arch:

```sh
sudo pacman -S --needed git stow fish tmux neovim fzf lazygit ripgrep curl unzip tar gzip base-devel python
```

Debian / Ubuntu:

```sh
sudo apt update
sudo apt install git stow fish tmux neovim fzf lazygit ripgrep curl unzip tar gzip build-essential python3
```

On apt-based distros, check two things:

- `neovim` from apt is often too old for AstroNvim. Check `nvim --version`; if it is
  old, install a release from [neovim/neovim](https://github.com/neovim/neovim/releases) instead.
- `lazygit` is only packaged in newer releases (Debian 13+, Ubuntu 25.04+). If
  `apt` can't find it, drop it from the command and install it from
  [jesseduffield/lazygit](https://github.com/jesseduffield/lazygit/releases).

Language toolchains for the nvim language packs, installed through these version managers:

| Tool | Install | Needed for |
| --- | --- | --- |
| Node.js via [nvm.fish](https://github.com/jorgebucaran/nvm.fish) (a fisher plugin) | `nvm install v26.13.1` | TypeScript, Svelte, and Node-based LSPs |
| A JDK via [SDKMAN](https://sdkman.io) | `curl -s https://get.sdkman.io \| bash`, then `sdk install java` | Java / Spring Boot pack (jdtls) |

## Setup

```sh
git clone <this repo> ~/dotfiles
cd ~/dotfiles
stow */          # .stowrc sets --target=~ --no-folding
stow fish tmux   # or only some packages
```

If a file already exists in `$HOME`, stow refuses to overwrite it. `stow --adopt */`
moves the existing files into the repo and links them, then `git diff` shows what differed.

Plugins are declared in the configs and installed by their own managers:

- fish: install [fisher](https://github.com/jorgebucaran/fisher), then `fisher update` (reads `fish_plugins`)
- tmux: clone [TPM](https://github.com/tmux-plugins/tpm) to `~/.tmux/plugins/tpm`, then `prefix + I`
- nvim: start `nvim`; lazy.nvim bootstraps itself (`:Lazy restore` to match the lockfile)

## Notes

- Files in `$HOME` are symlinks into this repo, so editing them in place edits the repo.
- `--no-folding` links files, not directories, so plugin managers writing into
  `~/.config/fish/functions` etc. don't write into the repo.
- New file to track: move it to the same relative path inside a package, run `stow <package>`.
- The tide prompt is set in `fish/.config/fish/conf.d/tide-config.fish` as globals,
  which override `tide configure`. Edit that file to change the prompt.
- Not tracked: plugin code, `fish_variables` (machine state), `~/.ssh`, sqlit connections/credentials.
