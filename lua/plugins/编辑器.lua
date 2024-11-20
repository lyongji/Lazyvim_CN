return {
  --文件资源管理器
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "资源树 (根目录)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "资源树 (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "文件树 (根目录)", remap = true },
      { "<leader>E", "<leader>fE", desc = "文件树 (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git资源管理器",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "缓存资源管理器",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "复制路径到剪贴板",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "用系统应用程序打开",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
  --多文件中的搜索替换
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "搜寻及替换",
      },
    },
  },
  --Flash 通过显示标签来增强内置搜索功能 在每个匹配结束时，让您快速跳转到特定的位置
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "速搜" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "速搜语法" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "速搜远处" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc =  "语法解析搜索" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "切换:速搜/搜索" },
  },
  },
  --which-key 通过显示弹出窗口来帮助你记住键绑定 使用命令的活动 keybindings 开始键入。
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "标签" },
          { "<leader>c", group = "代码" },
          { "<leader>f", group = "文件/搜寻" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "代码块" },
          { "<leader>q", group = "退出/工区" },
          { "<leader>s", group = "搜索" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "诊断/快速修复", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "上页" },
          { "]", group = "下页" },
          { "g", group = "转到" },
          { "gs", group = "环绕" },
          { "z", group = "折叠" },
          {
            "<leader>b",
            group = "缓存",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "窗口",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "用系统应用打开" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "缓存快捷键表 ",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "窗口快捷键表",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },
  --Git Signs 高亮显示自列表以来已更改的文本 git commit，还允许您交互式暂存和取消暂存 hunks 的 intent 值。
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "下个文本块")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "上个文本块")
      map("n", "]H", function() gs.nav_hunk("last") end, "末尾文本块")
      map("n", "[H", function() gs.nav_hunk("first") end, "起始文本块")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "暂存文本块")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "重置文本块")
      map("n", "<leader>ghS", gs.stage_buffer, "暂存缓存")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "撤销暂存文本块")
      map("n", "<leader>ghR", gs.reset_buffer, "重置缓存")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "内联预览文本块")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "追溯行")
      map("n", "<leader>ghB", function() gs.blame() end, "追溯缓存")
      map("n", "<leader>ghd", gs.diffthis, "当前差异")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "当前差异 ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns 选择文本块")
      end,
    },
  },
}
