---
inclusion: always
---

# Visible waits

For a short wait or polling delay (under 2 minutes), call `qsleep N` instead of `sleep N`.
`qsleep` writes the deadline so the tmux status bar shows a live countdown; bare `sleep` leaves Pierre waiting in the dark.

Bare `sleep` is still fine for sub-second throttling (`sleep 0.2`) where no countdown is useful.

## Long waits (2 minutes or more)

Never block on them: Pierre could not talk to you meanwhile. Start a timer and keep the conversation open.

`qsleep --async SECS "what to do when it ends"` returns at once and prints a letter, for example `timer B started, ends 15:53: ...`.
The message is required: it is your reminder for later, so write what to check or do next.

- Tell Pierre in one line, with the letter and its purpose: "I started timer B (deploy check, 1h). Tell me when it is done. Meanwhile, what can I do for you?"
- If the repo has a TASKS.md, add the wait to the note of the task it belongs to.
- Do not poll or loop waiting for the timer. Do not acknowledge it yourself: Pierre tells you.
- Run `qsleep` as its own command, never chained with `;`, `&&` or a pipe: a lone `qsleep` needs no approval, a chained one does.

When Pierre says a timer is done:
- With a letter ("B is done"): run `qsleep --ack B`. It prints your message. Continue from it. A letter is acknowledged even if the timer is still running, that cancels it.
- Without a letter ("a timer is done"): run `qsleep --list` first. One timer done: acknowledge it and continue. Several done: take them oldest first and say the order. None done: say so and show the time left.
