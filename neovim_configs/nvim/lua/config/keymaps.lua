-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = {
  noremap = true,
  silent = true,
}

-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- Incrrement/decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

keymap("i", "jk", "<Esc>", opts)
keymap("i", "kk", "<Esc>:w<CR>", opts)

-- Delete a word backwards
keymap("n", "dw", "vb_d", opts)

-- Jumplist
keymap("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap("n", "<C-t>", ":tabedit", opts)
keymap("n", "<C-t>", ":tabnew<CR>", opts)
keymap("n", "gt", ":tabnext<Return>", opts)
keymap("n", "gT", ":tabprev<Return>", opts)

-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap("n", "<C-]>", function()
  vim.diagnostic.jump({ count = 1 })
end, opts)
keymap("n", "<C-[>", function()
  vim.diagnostic.jump({ count = -1 })
end, opts)

-- split window
keymap("n", "<leader>-", "<CMD>split<CR>", opts)
keymap("n", "<leader>\\", "<CMD>vsplit<CR>", opts)

-- toggle color between 雷姆蓝 和 拉姆粉
local color_switch = 1
local function toggle_color()
  if color_switch == 1 then
    color_switch = 0
    vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#ffb6c1")
  else
    color_switch = 1
    vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#91bef0")
  end
end
keymap("n", "<leader>T", function()
  toggle_color()
end, {
  desc = "Toggle gui cursor color",
})

-- toggleterm
keymap("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", {
  desc = "ToggleTerm horizontal split",
})
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", {
  desc = "ToggleTerm float",
})
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", {
  desc = "ToggleTerm vertical split",
})

-- vscode config
if vim.g.vscode then
  local vscode = require("vscode")

  -- toggle bottom status bar
  keymap("n", "<leader>ts", function()
    vscode.action("workbench.action.toggleStatusbarVisibility")
  end, { desc = "Toggle Status Bar" })

  -- fold code
  keymap("n", "zc", function()
    vscode.action("editor.fold")
  end, { silent = true })
  keymap("n", "zo", function()
    vscode.action("editor.unfold")
  end, { silent = true })
  keymap("n", "zR", function()
    vscode.action("editor.unfoldAll")
  end, { silent = true })
  keymap("n", "zM", function()
    vscode.action("editor.foldAll")
  end, { silent = true })

  -- split window in vscode
  keymap("n", "<leader>-", function()
    vscode.action("workbench.action.splitEditorDown")
  end)
  keymap("n", "<leader>\\", function()
    vscode.action("workbench.action.splitEditorRight")
  end)

  -- Code Actions
  keymap({ "n", "x" }, "<leader>r", function()
    vscode.action("editor.action.refactor")
  end, { desc = "Refactor" })

  keymap({ "n", "x" }, "<leader>ca", function()
    vscode.action("editor.action.quickFix")
  end, { desc = "Code Action" })

  keymap({ "n", "x" }, "<leader>cr", function()
    vscode.action("editor.action.rename")
  end, { desc = "Rename Symbol" })

  keymap({ "n", "x" }, "gr", function()
    vscode.action("editor.action.goToReferences")
  end, { desc = "Go to References" })

  keymap({ "n", "x" }, "gi", function()
    vscode.action("editor.action.goToImplementation")
  end, { desc = "Go to Implementation" })

  keymap({ "n", "x" }, "<leader>D", function()
    vscode.action("editor.action.goToTypeDefinition")
  end, { desc = "Go to Type Definition" })

  keymap("n", "<C-]>", function()
    vscode.action("editor.action.marker.nextInFiles")
  end, { desc = "Next diagnostic" })

  keymap("n", "<C-[>", function()
    vscode.action("editor.action.marker.prevInFiles")
  end, { desc = "Prev diagnostic" })

  -- -- ! TODO
  -- local function terminal_is_focused()
  --   return vscode.get_context("terminalFocus")
  -- end
  --
  -- local function toggle_term_editor()
  --   if not terminal_is_focused() then
  --     vscode.action("workbench.action.terminal.focus")
  --   else
  --     vscode.action("workbench.action.focusActiveEditorGroup")
  --   end
  -- end
  --
  -- keymap({ "n", "t" }, "<A-;>", toggle_term_editor, { silent = true })
  -- -- ! TODO

  -- TODO slowly???
  -- find in current file
  -- keymap("n", "<leader>f", function()
  --   vim.fn.VSCodeNotify("actions.find")
  -- end, { desc = "Find" })

  -- map <leader>q close window
  -- keymap("n", "<leader>q", function()
  --   vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
  -- end, { desc = "Close active editor" })
end
