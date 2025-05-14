
local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    local datetime = os.date("%Y-%m-%d %I:%M:%S %p")
    local buf = 0 -- current buffer

    -- Check if buffer is modifiable
    local was_modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
    end

    -- Get cursor position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1 -- convert to 0-based row

    -- Insert date at the exact cursor position
    vim.api.nvim_buf_set_text(buf, row, col, row, col, { datetime })

    -- Move cursor to after the inserted datetime
    vim.api.nvim_win_set_cursor(0, { row + 1, col + #datetime })

    -- Restore original modifiable state
    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end, {})
end

return M

