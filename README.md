# md

## Only works in nightly builds of Kitty (or Kitty v0.40.0+ when released)

Renders markdown content with `h1`, `h2`, and `h3` headings scaled proportionally to demo the
[kitty text sizing protocol](https://github.com/kovidgoyal/kitty/issues/8226).

Currently this is basically an _extremely simple_ `cat`-like utility for markdown files. Don't be
surprised if this crashes or breaks in some way.

This does not respect code blocks or anything of the sort; all lines that start with any number of
`#` characters will be scaled.

## Usage

```sh
md $FILE

# for example, in this repo:
md README.md

# Or with a debug build
zig build run -- README.md
```

## Build

```sh
# Build a release version of this in `~/.local/bin/md`.
zig build -Doptimize=ReleaseFast --prefix ~/.local

# Build a release version of this in `./zig-out/bin/md`
zig build -Doptimize=ReleaseFast

# Build a debug build in `./zig-out/bin/md`
zig build
```

