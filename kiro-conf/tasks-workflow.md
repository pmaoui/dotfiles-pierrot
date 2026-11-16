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
| `qtimer`, `timer-popup` | `tmux-conf/bin/` | Async timer engine (called through `qsleep --async`, `--list`, `--ack`) and its picker on `prefix + W`. See Async timers. |
| Agent rule | `kiro-conf/agents/pierrot.json` | Prompt rule, `file://TASKS.md` resource, write allowance for `TASKS.md`. |

## Use

`C-Space`, then `Shift+t` in a window whose repo has a `TASKS.md`.

- Enter: sends `Please do this (task N in TASKS.md): "<task line>"` plus the note, in the same session.
- Tab: pastes the same text without sending, cursor on a new line, so you can add words and send it yourself.
- Ctrl-E: asks the agent to add a note to the task. It investigates read-only, writes a short note (context, where to look, done criteria, guesses marked unverified), changes nothing else and does not tick the task.
- Esc: cancels. Without a `TASKS.md`, in a git repo, the popup offers to create an empty one (y/N). Outside a git repo it shows the error and waits for a key.
- The pane under the list previews the highlighted task in full, with its note.

The status bar shows `📋 done/total (percent)` in a blue badge, for example `📋 13/14 (93%)`. The percent is rounded, and stays at 99% until every task is done. Nothing is shown without a `TASKS.md`.

## Agent rule (summary)

Read `TASKS.md` at the start of a task, re-read it before editing. Work on the named task, or propose the next actionable one. Tick `[x]` only after the work is done and verified in the turn, as the last action, and keep the note. Add discovered work as a task. Say what could not be verified. Give new tasks a short note (at most 3 lines: context, where to look, done criteria), and while working append what it learned and what is left, so a new session can resume. Guesses are marked unverified. Never commit it, never gitignore it. With a `TASKS.md`, end every reply with the open tasks and one status line. In a git repo without one, when the work is clearly multi-step, offer once per session to create it from the steps, and create it only after you confirm. No offer for a one-off question.

`TASKS.md` writes are allowed without a prompt through two settings in `pierrot.json`. CLI 2.x reads `toolsSettings.fs_write.allowedPaths`. CLI V3 reads the `permissions` rule and ignores the first one. Keep both until V3 is the only engine.

## Status bar

`status-right` is ` <qsleep timer><task badge><time> - <date> `, set by `tmux_conf_theme_status_right` in `tmux.conf.local`.

- `qsleep N` (`tmux-conf/bin/qsleep`) is a blocking wait with a countdown. It writes its deadline to `/tmp/tmux-sleep-<pane id>-<pid>`, one file per call so overlapping waits do not clobber each other. `tmux-sleep-timer <window id>` shows the longest remaining one of the window's panes as a magenta badge (`⏳ 02:05`, `⏳ 2h05m` beyond an hour), so each window has its own countdown and it is easy to spot why a session looks frozen. Files from killed processes are removed once they are more than a minute old. The global steering file `kiro-conf/steering/visible-sleep.md` tells every agent to use `qsleep` instead of `sleep` for waits (checked: a fresh session picks `qsleep 5`).
- The english tutor flag (`kiro-english-tutor-hook.sh`, `english-tutor.sh`) takes the live `status-right`, drops everything up to the last `#[default]`, and prepends its flag. The base is never hardcoded in the scripts.

## Async timers

For a wait of 2 minutes or more the agent must not block: you could not talk to it meanwhile. It starts a timer and the conversation stays open.

```
qsleep --async 3600 "check the deploy status"   # timer B started, ends 15:53: check the deploy status
qsleep --list [--all]                           # B  12m left  check the deploy status
qsleep --ack B                                  # prints the message, removes the timer (also cancels a running one)
```

- The tool assigns the letter (A to Z, cyclic, a freed letter is not reused right away). The message is required: it is the agent's own reminder.
- A timer is a file `/tmp/qtimers/<window id>/<letter>` (deadline, pane, bell sent, message). No background process, so nothing dies with the shell, and it survives a Kiro restart. It does not survive a reboot.
- Scope is the window. Two Kiro panes in one window share the list. The same letter can exist in two windows.
- Bar: `⏳ B 59:12 +2` (magenta, nearest timer and how many others) while running. When one has expired: white `✔ B +1`, with its age after 10 minutes (`✔ B 2h`), until acknowledged. Removed after 24 hours, or when its window is gone.
- Bell: rung once per timer, for all windows (the status script only runs for the visible window, so it checks every window). A background window gets the tmux bell flag.
- The agent is never woken up. You tell it: "B is done" runs `qsleep --ack B`. "A timer is done" runs `qsleep --list` first: one done, it acknowledges it; several, oldest first; none, it says how much time is left.
- `prefix + W` lists the finished timers of the window. Enter sends "Timer B is done. Its reminder: ... Acknowledge it with `qsleep --ack B`, then continue." to the agent, Tab pastes it so you can edit it first. The popup acknowledges nothing: the agent does, as in the typed flow. With nothing finished it lists the running timers and waits for a key. (`prefix + J` is oh-my-tmux's resize, hence `W` for wait.)
- `qsleep` is allowed without approval in `pierrot.json`, as a lone command. Chained with `;` or `&&` it asks.

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

Checked on Kiro CLI 2.33.1: Enter and Tab paths, same-session context, note delivery, tick without a prompt, tick order, the create offer (none for a one-off question, one for a multi-step request, file created after "yes"), the Ctrl-E describe key (three-line note, nothing else changed, not ticked), a note on a newly added task, a blocked task logged in its note, your own `Ctrl-Space T` keypress.

Not checked: Kiro CLI V3, a fresh machine install, very long notes.
