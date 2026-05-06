# Agent 配置

这个目录记录可以在不同主机之间重放的 Agent 配置。

## Codex Skills

`codex/skills/` 保存需要跨主机同步的 Codex 用户技能目录。同步单位是整个
skill 目录，而不是只同步 `SKILL.md`，因为有些 skill 会附带 `scripts/`、
`references/`、`assets/` 或模板文件。

同步流程尽量做成无脑：

- `autoconfig.sh` 会安装本仓库的 pre-commit hook。
- 每次在 dotfiles 仓库执行 `git commit` 时，hook 会自动运行
  `agents/codex/sync-skills.sh`。
- `sync-skills.sh` 会扫描 `$CODEX_HOME/skills`（默认 `~/.codex/skills`），
  跳过 Codex 自己管理的 `.system`，把其他包含 `SKILL.md` 的用户技能目录复制到
  `agents/codex/skills/`，并自动 `git add` 这些同步结果。

在新主机上运行仓库根目录的 `./autoconfig.sh` 时，会把
`agents/codex/skills/<skill-name>` 逐个软链接到
`$CODEX_HOME/skills/<skill-name>`。安装或同步后需要重启 Codex 才能识别新技能。

如果想手动立即同步，也可以运行：

```bash
agents/codex/sync-skills.sh
```

当前同步的技能：

- `karpathy-guidelines`

## Claude Code

Claude Code 的插件安装目前更适合在 Claude Code 内执行：

```text
/plugin marketplace add forrestchang/andrej-karpathy-skills
/plugin install andrej-karpathy-skills@karpathy-skills
```

这里先记录命令，不在 `autoconfig.sh` 中自动执行，避免依赖交互式 Claude Code 环境。
