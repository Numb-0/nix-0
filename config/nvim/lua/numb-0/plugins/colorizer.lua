return {
    "norcalli/nvim-colorizer",
    url = 'git@github.com:norcalli/nvim-colorizer.lua.git',
    config = function()
        require("colorizer").setup()
    end
}
