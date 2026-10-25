local lint = require("lint")


-- Specify linters
lint.linters_by_ft = { c = { "cppcheck" } }


-- Define extra flags for cppcheck
local extra = { "--enable=portability", "-I", "inc" }

local gdk = os.getenv("GDK")
if gdk then
  vim.list_extend(extra, { "-I", gdk .. "/inc" })
end

local smslib = os.getenv("SMSLIB_INCLUDE_DIR")
if smslib then
  vim.list_extend(extra, { "-I", smslib})
end


-- Add extra flags on top of cppcheck's default
lint.linters.cppcheck.args = vim.list_extend(
  vim.deepcopy(lint.linters.cppcheck.args), extra
)


-- Autocommand to try linting
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  callback = function() lint.try_lint() end,
})

