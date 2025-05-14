local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    local datetime = os.date("%Y-%m-%d %I:%M:%S %p")
    vim.api.nvim_put({ datetime }, "c", false, true)
  end, {})
end

return M

