# TASKS.md workflow

The agent keeps the open tasks of a project in `TASKS.md` at the repo root. tmux shows the progress and lets you send a task to the running Kiro session with two keys.

## File format

```
- [ ] 7 | Grafana monitoring not set up
  Steps are in MONITOR.md.

- [ ] 13 | after:2026-11-12T07:30 | read the first daily_check report
- [x] 1 | Merge PR #50
```

- One task per line: `- [ ] <id> | [after:<date or datetime> | ]<text>`.
- Note: the lines below a task, until a blank line or the next task line. Indent by two spaces. A note line must not start with `- [ ]` or `- [x]`.
- `after:` hides the task from the picker until the date is reached. It still counts in the total.
- The file stays untracked and is not gitignored. The developer decides whether to commit it. Delete it when the work is done.

## Pieces

| Piece | Where | Role |
|---|---|---|
| `task` | `tmux-conf/bin/task` | Parser: `list [-a]`, `count`, `stats`, `show <id>`, `prompt <id>`, `pick`. Finds `TASKS.md` at the git root, or `$TASKS_FILE`. |
| `task-popup` | `tmux-conf/bin/task-popup` | fzf picker, pastes the chosen task into the pane that opened it. |
| `task-count` | `tmux-conf/bin/task-count` | `done/total` badge in the status bar, for the active pane's repo. |
| `prefix + T` | `tmux-conf/tmux.conf.local` | Opens the picker. Prefix is `C-Space`. |
| Agent rule | `kiro-conf/agents/pierrot.json` | Prompt rule, `file://TASKS.md` resource, write allowance for `TASKS.md`. |

## Use

`C-Space`, then `Shift+t` in a window whose repo has a `TASKS.md`.

- Enter: sends `Please do this (task N in TASKS.md): "<task line>"` plus the note, in the same session.
- Tab: pastes the same text without sending, cursor on a new line, so you can add words and send it yourself.
- Esc: cancels. Without a `TASKS.md`, in a git repo, the popup offers to create an empty one (y/N). Outside a git repo it shows the error and waits for a key.

The status bar shows `📋 done/total (percent)` in a blue badge, for example `📋 13/14 (93%)`. The percent is rounded, and stays at 99% until every task is done. Nothing is shown without a `TASKS.md`.

## Agent rule (summary)

Read `TASKS.md` at the start of a task, re-read it before editing. Work on the named task, or propose the next actionable one. Tick `[x]` only after the work is done and verified in the turn, as the last action, and keep the note. Add discovered work as a task. Say what could not be verified. Never commit it, never gitignore it. With a `TASKS.md`, end every reply with the open tasks and one status line. In a git repo without one, when the work is clearly multi-step, offer once per session to create it from the steps, and create it only after you confirm. No offer for a one-off question.

`TASKS.md` writes are allowed without a prompt through two settings in `pierrot.json`. CLI 2.x reads `toolsSettings.fs_write.allowedPaths`. CLI V3 reads the `permissions` rule and ignores the first one. Keep both until V3 is the only engine.

## Status bar

`status-right` is ` <qsleep timer><task badge><time> - <date> `, set by `tmux_conf_theme_status_right` in `tmux.conf.local`.

- `qsleep N` (`tmux-conf/bin/qsleep`) waits N seconds and writes its deadline to `/tmp/tmux-sleep-<pane id>`. `tmux-sleep-timer <window id>` shows the longest remaining one of the window's panes, so each window has its own countdown.
- The english tutor flag (`kiro-english-tutor-hook.sh`, `english-tutor.sh`) takes the live `status-right`, drops everything up to the last `#[default]`, and prepends its flag. The base is never hardcoded in the scripts.

## Setup

See `tmux-conf/install-tmux.md` (`qsleep` and `task` in `~/.local/bin`, `fzf` from apt).

## Gotchas found on the way

- oh-my-tmux drops a `status-right` section whose `#()` output is empty at reload. Keep the timer and the badge in the same section as the clock.
- `display-popup` expands formats in `-d` but not in its shell command. The binding goes through `run-shell`, which expands `#{pane_id}` and `#{client_name}`.
- `display-message -p` does not run `#()` jobs, so it cannot be used to check what the status bar draws.
- A `tmux rename-window` without `-t` renames the window you are looking at. The `kiro-cli` alias in `zsh-conf/zshenv` uses `-t "$TMUX_PANE"`. `zshenv` also loads in the `zsh -c` that tmux uses for `new-window`.
- Pasting into Kiro: `tmux load-buffer` then `paste-buffer -p` keeps a multi-line text in the input without sending. Enter is sent 0.3 s later.
- Test through the binding and the real Kiro pane, not only the script. Inject keys with `tmux send-keys -K -c <client> C-Space T`.

## Checked and not checked

Checked on Kiro CLI 2.33.1: Enter and Tab paths, same-session context, note delivery, tick without a prompt, tick order, the create offer (none for a one-off question, one for a multi-step request, file created after "yes"), your own `Ctrl-Space T` keypress.

Not checked: Kiro CLI V3, a fresh machine install, very long notes.
