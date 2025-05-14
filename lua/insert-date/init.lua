

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    local datetime = os.date("%Y-%m-%d %I:%M:%S %p")
    local buf = vim.api.nvim_get_current_buf()

    -- Check if buffer is modifiable
    local was_modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
    end

    -- Get cursor position (1-based row, 0-based col)
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1  -- convert to 0-based index for API
    local col = pos[2]      -- column is already 0-based

    -- Get current line to verify insertion point
    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""

    -- Clamp col if it's beyond the line length (just in case)
    if col > #line then
      col = #line
    end

    -- Insert date at the exact cursor position
    vim.api.nvim_buf_set_text(buf, row, col, row, col, { datetime })

    -- Move cursor to after the inserted text
    vim.api.nvim_win_set_cursor(0, { row + 1, col + #datetime })

    -- Restore original modifiable state
    if not was_modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end, {})
end

return M

