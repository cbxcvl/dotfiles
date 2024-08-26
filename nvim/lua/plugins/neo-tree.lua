return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      sources = { "filesystem", "buffers" }, -- Exclui "git_status"
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        filtered_items = {
          visible = true, -- Exibe arquivos ocultos
          hide_dotfiles = false, -- Não oculta arquivos que começam com "."
          hide_gitignored = true, -- Oculta arquivos ignorados pelo .gitignore
        },
        bind_to_cwd = false, -- Não vincula ao diretório do buffer
        follow_current_file = { enabled = false }, -- Não segue o arquivo atual
        use_libuv_file_watcher = true, -- Usa watcher de arquivos para atualizações automáticas
        cwd_target = {
          current = false, -- Não muda para o diretório do buffer
          root = true, -- Usa o diretório inicial como root
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      -- Removido o autocmd para evitar erros
    end,
  },
}
