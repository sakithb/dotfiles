local M = {}

M.basedpyright = {
    python = {
        venv = ".venv",
        venvPath = ".",
        exclude = { ".venv" }
    }
}

M.emmet_ls = {
    filetypes = { "templ" , "typescriptreact" }
}

return M
