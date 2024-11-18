-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- 这个文件由 lazyvim.config.init 自动加载

-- 不要在你的配置中使用 `LazyVim.safe_keymap_set`!!
-- 使用 `vim.keymap.set` 代替
--local map = LazyVim.safe_keymap_set
local map = vim.keymap.set

-- 更好的上下移动
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "向下", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "向下", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "向上", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "向上", expr = true, silent = true })

-- 使用 <ctrl> hjkl 键移动到窗口
map("n", "<C-h>", "<C-w>h", { desc = "转到左窗口", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "转到下窗口", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "转到上窗口", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "转到右窗口", remap = true })

-- 使用 <ctrl> 箭头键调整窗口大小
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "增加窗口高度" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "减少窗口高度" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "减少窗口宽度" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "增加窗口宽度" })

-- 移动行
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "向下移动" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "向上移动" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "向下移动" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "向上移动" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "向下移动" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "向上移动" })

-- 缓冲区
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "上一个缓冲区" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "下一个缓冲区" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "上一个缓冲区" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "下一个缓冲区" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "切换到其他缓冲区" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "切换到其他缓冲区" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "删除缓冲区" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "删除缓冲区和窗口" })

-- 使用 <esc> 清除搜索
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "退出并清除高亮搜索" })

-- 清除搜索、更新差异并重绘
-- 取自 runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "重绘 / 清除高亮搜索 / 更新差异" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "下一个搜索结果" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索结果" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索结果" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "上一个搜索结果" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索结果" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索结果" })

-- 添加撤销断点
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- 保存文件
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "保存文件" })

-- 关键词帮助
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "关键词帮助" })

-- 更好的缩进
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 注释
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "在下方添加注释" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "在上方添加注释" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- 新建文件
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "新建文件" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "位置列表" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "快速修复列表" })

map("n", "[q", vim.cmd.cprev, { desc = "上一个快速修复" })
map("n", "]q", vim.cmd.cnext, { desc = "下一个快速修复" })

-- 格式化
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, { desc = "格式化" })

-- 诊断
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "行诊断" })
map("n", "]d", diagnostic_goto(true), { desc = "下一个诊断" })
map("n", "[d", diagnostic_goto(false), { desc = "上一个诊断" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "下一个错误" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "上一个错误" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "下一个警告" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "上一个警告" })

-- stylua: ignore start

-- 切换选项
LazyVim.format.snacks_toggle():map("<leader>uf")
LazyVim.format.snacks_toggle(true):map("<leader>uF")
Snacks.toggle.option("spell", { name = "拼写检查"}):map("<leader>us")
Snacks.toggle.option("wrap", {name = "换行"}):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "相对行号"}):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", {off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2}):map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark" , name = "深色背景"}):map("<leader>ub")
if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (根目录)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (当前目录)" })
  map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git 责备行" })
  map("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git 浏览" })
  map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit 当前文件历史" })
  map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit 日志" })
  map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit 日志 (当前目录)" })
end

-- 退出
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "退出所有" })

-- 光标下的高亮
map("n", "<leader>ui", vim.show_pos, { desc = "检查位置" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "检查树" })

-- LazyVim 更新日志
map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim 更新日志" })

-- 浮动终端
map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "终端 (当前目录)" })
map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "终端 (根目录)" })
map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "终端 (根目录)" })
map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

-- 终端映射
map("t", "<C-/>", "<cmd>close<cr>", { desc = "隐藏终端" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- 窗口
map("n", "<leader>w", "<c-w>", { desc = "窗口", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "向下分割窗口", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "向右分割窗口", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "删除窗口", remap = true })
LazyVim.ui.maximize():map("<leader>wm")

-- 标签
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "最后一个标签" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "关闭其他标签" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "第一个标签" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "新建标签" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "下一个标签" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "关闭标签" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "上一个标签" })
