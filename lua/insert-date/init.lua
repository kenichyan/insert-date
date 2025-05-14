-- lua/insert-date/init.lua

-- Default format: ISO 8601
local config = { format = "%Y-%m-%dT%H:%M:%S" }

-- Try to load user config
local ok, user_config = pcall(require, "config.insert-date")
if ok and type(user_config) == "table" then
  config = vim.tbl_deep_extend("force", config, user_config)
end

local function setup()
  vim.api.nvim_create_user_command("Date", function()
    local buf = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1

    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
    if col > #line then col = #line end

    local datetime = vim.fn.strftime(config.format)

    local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
    if not modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
    end

    vim.api.nvim_buf_set_text(buf, row, col, row, col, { datetime })
    vim.api.nvim_win_set_cursor(0, { row + 1, col + #datetime })

    if not modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end, {})
end

return {
  setup = setup,
}

