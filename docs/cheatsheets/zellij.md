# Zellij Cheatsheet

Default mode: **locked** | Unlock: `Ctrl+a`

## Mode Switching (from normal/unlocked)

| Key | Mode    |
|-----|---------|
| `p` | Pane    |
| `t` | Tab     |
| `r` | Resize  |
| `m` | Move    |
| `s` | Scroll  |
| `o` | Session |

`Enter` or `Esc` returns to locked mode.

## Always Available (locked & normal)

| Key       | Action              |
|-----------|---------------------|
| `Alt h/l` | Focus pane/tab left/right |
| `Alt j/k` | Focus pane down/up  |
| `Alt 1-9` | Go to tab N         |
| `Alt n`   | New pane            |
| `Alt f`   | Toggle floating panes |
| `Alt +/-` | Resize +/-          |
| `Alt [/]` | Prev/next layout    |
| `Alt i/o` | Move tab left/right |
| `Alt s`   | Session manager     |
| `Alt p`   | Toggle pane in group |
| `Ctrl q`  | Quit (unlocked only) |

## Pane Mode (`p`)

| Key   | Action               |
|-------|----------------------|
| `h/j/k/l` | Move focus        |
| `n`   | New pane             |
| `r`   | New pane right       |
| `d`   | New pane down        |
| `s`   | New pane stacked     |
| `x`   | Close pane           |
| `f`   | Fullscreen           |
| `w`   | Toggle floating      |
| `e`   | Toggle embed/float   |
| `i`   | Pin pane             |
| `z`   | Toggle frames        |
| `c`   | Rename pane          |
| `tab` | Switch focus         |

## Tab Mode (`t`)

| Key   | Action               |
|-------|----------------------|
| `h/l` | Prev/next tab       |
| `1-9` | Go to tab N          |
| `n`   | New tab              |
| `x`   | Close tab            |
| `r`   | Rename tab           |
| `b`   | Break pane to tab    |
| `[/]` | Break pane left/right |
| `s`   | Sync tab             |
| `tab` | Toggle last tab      |

## Resize Mode (`r`)

| Key       | Action            |
|-----------|-------------------|
| `h/j/k/l` | Increase left/down/up/right |
| `H/J/K/L` | Decrease left/down/up/right |
| `+/-`     | Increase/decrease  |

## Move Mode (`m`)

| Key       | Action            |
|-----------|-------------------|
| `h/j/k/l` | Move pane direction |
| `n/tab`   | Move pane next     |
| `p`       | Move pane back     |

## Scroll Mode (`s`)

| Key       | Action            |
|-----------|-------------------|
| `j/k`     | Scroll down/up    |
| `h/l`     | Page up/down      |
| `d/u`     | Half page down/up |
| `Ctrl b/f`| Page up/down      |
| `e`       | Edit scrollback   |
| `f`       | Search            |
| `Ctrl c`  | Exit to locked    |

## Search (from scroll `f`)

| Key | Action              |
|-----|---------------------|
| `n` | Next match          |
| `p` | Previous match      |
| `c` | Toggle case         |
| `w` | Toggle wrap         |
| `o` | Toggle whole word   |

## Session Mode (`o`)

| Key | Action              |
|-----|---------------------|
| `w` | Session manager     |
| `c` | Configuration       |
| `p` | Plugin manager      |
| `a` | About               |
| `d` | Detach              |
