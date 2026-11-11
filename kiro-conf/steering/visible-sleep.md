---
inclusion: always
---

# Visible waits

For any wait or polling delay, call `qsleep N` instead of `sleep N`.
`qsleep` writes the deadline so the tmux status bar shows a live countdown; bare `sleep` leaves Pierre waiting in the dark.

Bare `sleep` is still fine for sub-second throttling (`sleep 0.2`) where no countdown is useful.
