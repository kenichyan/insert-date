# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`insert-date` is a minimal Neovim plugin (Lua) that registers a `:Date` command to insert the current UTC date/time at the cursor position. The entire plugin is one file: `lua/insert-date/init.lua`.

## Testing

There is no test suite or build system. To test changes, install the plugin in a local Neovim setup (e.g., via lazy.nvim with a local path) and run `:Date` in a buffer.

## Architecture

The plugin follows the standard Neovim plugin layout:

- `lua/insert-date/init.lua` — the whole plugin. It loads on `require("insert-date")`, and the user calls `setup()` to register the `:Date` command.

**Configuration loading:** On module load, it tries `require("config.insert-date")` and merges any returned table into the default config using `vim.tbl_deep_extend`. This allows users to override `format` without calling `setup()` with options.

**UTC handling:** The date is formatted with `os.date(format, os.time(os.date("!*t")))`. The `"!*t"` argument to the inner `os.date` call returns UTC time as a table, which is then passed to `os.time` to get a UTC epoch, and finally formatted. This is why `vim.fn.strftime` (which uses local time) is commented out.

**Default format:** ISO 8601 — `%Y-%m-%dT%H:%M:%S`.
