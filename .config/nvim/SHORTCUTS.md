# Neovim Custom Shortcuts

This document lists all custom key mappings defined in this Neovim configuration, grouped by feature/category. All mappings are specific to this config and may not be present in default Neovim or plugins.

---

## Clipboard

| Mode(s) | Shortcut     | Action                 |
| ------- | ------------ | ---------------------- |
| n, x    | `+`          | Use Clipboard Register |
| i, c    | `<S-Insert>` | Paste from Clipboard   |
| i, c    | `<A-p>`      | Paste from Buffer      |

## Edit/Selection

| Mode(s) | Shortcut    | Action              |
| ------- | ----------- | ------------------- |
| n       | `<leader>>` | Indent the Line     |
| x       | `<leader>>` | Indent the Block    |
| n       | `<leader><` | Dedent the Line     |
| x       | `<leader><` | Dedent the Block    |
| n       | `<A-j>`     | Move Up the Line    |
| x       | `<A-j>`     | Move Up the Block   |
| n       | `<A-k>`     | Move Down the Line  |
| x       | `<A-k>`     | Move Down the Block |
| n       | `<A-a>`     | Select All          |
| x       | `<C-h>`     | Replace Selection   |

## Window Management

| Mode(s) | Shortcut    | Action                 |
| ------- | ----------- | ---------------------- |
| n       | `<C-h>`     | Window Switch Left     |
| n       | `<C-l>`     | Window Switch Right    |
| n       | `<C-j>`     | Window Switch Down     |
| n       | `<C-k>`     | Window Switch Up       |
| n       | `<A-Up>`    | Window Increase Height |
| n       | `<A-Down>`  | Window Decrease Height |
| n       | `<A-Right>` | Window Increase Width  |
| n       | `<A-Left>`  | Window Decrease Width  |

## Buffer Operations

| Mode(s) | Shortcut | Action      |
| ------- | -------- | ----------- |
| n       | `<C-n>`  | Buffer New  |
| n, x, i | `<C-s>`  | Buffer Save |

## Terminal/Options

| Mode(s) | Shortcut               | Action                    |
| ------- | ---------------------- | ------------------------- |
| t       | `<Esc>`                | Terminal Switch to Normal |
| n       | `<Plug>(TermEsc)<Esc>` | Terminal Send Esc         |
| n       | `<Esc>`                | Highlight Clear           |
| n       | `<leader>wt`           | Wrap Toggle               |

## LSP (Language Server Protocol)

| Mode(s) | Shortcut     | Action                       |
| ------- | ------------ | ---------------------------- |
| n       | `<leader>wa` | LSP Add Workspace Folder     |
| n       | `<leader>wl` | LSP Show Workspace Folders   |
| n       | `<leader>wr` | LSP Remove Workspace Folder  |
| n, x    | `<leader>ca` | LSP Code Action              |
| n       | `gD`         | LSP Declaration              |
| n       | `gd`         | LSP Definition               |
| n       | `K`          | LSP Hover                    |
| n       | `<leader>rn` | LSP Rename                   |
| n       | `<leader>D`  | LSP Type Definition          |
| n       | `]d`         | LSP Next Diagnostic          |
| n       | `[d`         | LSP Previous Diagnostic      |
| n       | `<leader>x`  | LSP Diagnostic Quickfix List |
| n       | `<leader>ci` | LSP Toggle Inlay Hint        |

## Formatting

| Mode(s) | Shortcut     | Action         |
| ------- | ------------ | -------------- |
| n       | `<leader>fm` | Conform Format |

## Debugging (DAP)

| Mode(s) | Shortcut     | Action                                         |
| ------- | ------------ | ---------------------------------------------- |
| n       | `<F5>`       | Debug Start/Continue                           |
| n       | `<F11>`      | Debug Step Into                                |
| n       | `<F10>`      | Debug Step Over                                |
| n       | `<S-F11>`    | Debug Step Out                                 |
| n       | `<S-F10>`    | Debug Step Back                                |
| n       | `<C-F5>`     | Debug Restart                                  |
| n       | `<S-F5>`     | Debug Stop Debugging                           |
| n       | `<F12>`      | Debug Disconnect                               |
| n       | `<F9>`       | Debug Toggle Breakpoint                        |
| n       | `<leader>bc` | Debug Set Conditional Breakpoint (Expression)  |
| n       | `<leader>bh` | Debug Set Conditional Breakpoint (Hit Count)   |
| n       | `<leader>bl` | Debug Set Conditional Breakpoint (Log Message) |
| n       | `<F7>`       | Debug Toggle Session Result                    |

## Snacks (Custom Picker/Utility)

| Mode(s) | Shortcut           | Action                      |
| ------- | ------------------ | --------------------------- |
| n       | `<leader><leader>` | Snacks Search Buffers       |
| n       | `<C-\>`            | Snacks Toggle Explorer      |
| n       | `<leader>se`       | Snacks Toggle Explorer      |
| n       | `<leader>sf`       | Snacks Search Files         |
| n       | `<leader>sg`       | Snacks Search Files by Grep |
| n       | `<leader>sh`       | Snacks Search Help          |
| n       | `<leader>sk`       | Snacks Search Keymaps       |
| n       | `<leader>sp`       | Snacks Search All Pickers   |
| n       | `<leader>sr`       | Snacks Search Recent Files  |
| n, t    | `<A-i>`            | Snacks Toggle Terminal      |

---

**Legend:**

- `n` = normal mode
- `x` = visual mode
- `i` = insert mode
- `c` = command mode
- `t` = terminal mode
- `<leader>` = your configured leader key (often `\` or `,`)
- `<A-*>` = Alt + key
- `<C-*>` = Ctrl + key
- `<S-*>` = Shift + key

For more details, see the descriptions in the respective files under `lua/keymaps/`.
