-- lua/insert-date/init.lua

local config = { format = "%Y-%m-%d %H:%M:%S %p" } -- default format

-- Try to load user config from ~/.config/nvim/lua/config/insert-date.lua
local ok, user_config = pcall(require, "config.insert-date")
if ok and type(user_config) == "table" then
  config = vim.tbl_deep_extend("force", config, user_config)
end

local function setup()
  vim.api.nvim_create_user_command("Date", function()
    local datetime = os.date(config.format)
    local buf = vim.api.nvim_get_current_buf()

    local was_modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1
    local col = pos[2]

    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
    if col > #line then
      col = #line
    end

    vim.api.nvim_buf_set_text(buf, row, col, row, col, { datetime })
    vim.api.nvim_win_set_cursor(0, { row + 1, col + #datetime })

    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end, {})
end

return {
  setup = setup
}

