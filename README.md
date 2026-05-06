# dotfiles

个人常用开发环境配置，主要覆盖 Bash、Git、Vim/IdeaVim、tmux 和 VS Code。

## 使用方式

```bash
./autoconfig.sh
```

脚本会把仓库中的配置软链接到 `$HOME`。如果目标位置已经有文件，会先备份到
`~/.dotfiles-backup/<timestamp>/`，再创建新的软链接。

## 配置清单

- `.bashrc`：交互式 Bash、常用 alias、Conda/Cargo/pnpm 路径加载。
- `.gitconfig`：Git 用户信息、常用 alias、rebase pull、rerere。
- `.vimrc` / `.ideavimrc`：Vim 与 JetBrains IdeaVim 配置。
- `.tmux.conf`：tmux prefix、pane 快捷键和状态栏样式。
- `vscode/settings.json`：VS Code 用户设置。

## 注意

这是公开 dotfiles 仓库，不要提交 token、私钥、公司内网地址或本机专属密钥材料。
