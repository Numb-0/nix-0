return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    enable_autocmd = false,
  },
  init = function()
    -- Hook native gc operator to use treesitter-aware commentstring (e.g. JSX, Svelte)
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
