# Setup Instructions

Install `gh`, run `gh auth login`. Then open a shell and paste the following:

```shell
echo "alias dotgit='/usr/bin/git --git-dir=$HOME/dotfiles.git --work-tree=$HOME'" > ~/.bashrc
source ~/.bashrc
dotgit clone --bare https://SpicyRicecaker/dotfiles.git
# delete conflicting files if needed
dotgit checkout
```

Now manage your config files as you would a normal git repository. Easily add all modified files with

```shell
dotgit add -u
```

However, new files must be added manually. Do not use `dotgit add -A` unless you want a 5GB commit.

# Programs Used

## Terminal

- kitty
- ~~alacritty~~ latency too high, tmux adds dependency

## Text Editor

- vscode AND neovim for quick file editing

## Desktop

- gnome
- ~~kde~~ not enough material design, too much customization

## Distro

- fedora
- ~~arch~~ it broke and I was too lazy to fix it

## Shell

- fish really hard to script with, but very user friendly for everything else
- ~~nu~~ breaking changes to the vi editor 

## Node

- volta
- ~~fnm~~ breaks on updating node on windows

# Reason for going from alacritty -> kitty

<center>
Type of Emulator vs Latency

|                | Avg latency (ms) | Max latency (ms) | Min latency (ms) |
| -------------- | ---------------- | ---------------- | ---------------- |
| Kitty          | 16.24            | 41.64            | 4.73             |
| Wezterm        | 38.71            | 52.9             | 13.8             |
| Alacritty      | 39.15            | 353.81           | 24.47            |
| Alacritty+Tmux | 40.19            | 395.09           | 19.63            |
| Gnome          | 32.69            | 39.18            | 28.25            |

</center>

Surprisingly, Kitty responds 50% (~23 ms) faster than Alacritty on every keystroke! Even the stock gnome terminal has lower latency compared to the terminals written in rust. When using Alacritty, one would also need to use tmux on top of it in order to support multiple tabs and splits. This results in, among other drawbacks, [every byte being rendered twice](https://github.com/kovidgoyal/kitty/issues/391#issuecomment-638320745) and slightly higher latency, as supported by the data. Alacritty also had large latency spikes that occured every trial.

## How?

How do the implementations of wezterm and alacritty differ from kitty and gnome, such that the latency is so much (150% greater in the case of alacritty v. kitty) worse? Surface-level comparisons are that kitty and gnome are written in c, while wezterm and alacritty are written in rust. But the performance of rust shouldn't be 150% worse than c. In terms of graphics libraries, Kitty uses the standard `GLFW`, alacritty uses `glutin`, wezterm uses `glium`, and I can't read gnome terminal at all but it seems like it just uses `gtk`. `Glium` itself is built on `glutin`, and as far as I konw `GLFW` and `glutin` both are just OpenGL. So maybe it has less to do with grahpics and more todo with the event loop or something.

## Conclusion

Obviously more data/research is to answer _why_ exactly kitty is faster, as well as why alacritty spikes in latency, but for now switching to kitty is the obvious choice. It's both more practical in that it results in less latency, and makes more sense in that it drops a (tmux) dependency.

## Methodology

- Inspiration: [Why do all (newer) Terminal Emulators have such bad input latency?](https://www.reddit.com/r/linux/comments/jc9ipw/why_do_all_newer_terminal_emulators_have_such_bad/)
- References: [Terminal Latency](https://danluu.com/term-latency/) - [A loook at terminal emulators, part 2](https://lwn.net/Articles/751763/)

Used [Typometer](https://pavelfatin.com/typometer/) to benchmark 4 terminal emulators. For each terminal emulator, configured such that there was

- a black/white background
- an underlined, solid (no blinking) cursor
- a small enough fontsize, resulting in no word wrap
- an absence of ligatures

Ran 3 trials for each terminal in succession

