--[[
  Plugin configuration for GitHub Copilot and CopilotChat in Neovim.

  1. github/copilot.vim:
     - Disables Copilot by default.
     - Prevents Copilot from mapping <Tab>.
     - Maps <C-l> in insert mode to accept Copilot suggestions.

  2. CopilotC-Nvim/CopilotChat.nvim:
     - Depends on plenary.nvim (master branch).
     - Builds tiktoken for enhanced chat features.
     - Provides keymaps for CopilotChat commands:
         <leader>öö: Open CopilotChat (normal mode)
         <leader>öe: Explain code (visual mode)
         <leader>öc: Generate commit message (normal mode)
         <leader>öf: Fix code (visual mode)
         <leader>öd: Generate docs (visual mode)
         <leader>öo: Optimize code (visual mode)
]]
return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-l>", "copilot#Accept('<CR>')", {
        silent = true,
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", branch = "master" } },
    build = "make tiktoken",
    opts = {},
    keys = {
      { "<leader>öö", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
      { "<leader>öe", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
      { "<leader>öc", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate commit message" },
      { "<leader>öf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code" },
      { "<leader>öd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
      { "<leader>öo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
    },
  },
}
