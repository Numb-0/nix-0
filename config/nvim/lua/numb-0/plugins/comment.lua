return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")
    local comment_api = require("Comment.api")

    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    local keymap = vim.keymap

    keymap.set("n", "<leader>/", function()
      comment_api.toggle.linewise.current()
    end, { desc = "Comment toggle" })

    keymap.set("v", "<leader>/", function()
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      comment_api.toggle.linewise(vim.fn.visualmode())
    end, { desc = "Comment toggle" })

    -- enable comment
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
