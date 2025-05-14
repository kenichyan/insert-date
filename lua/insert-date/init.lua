local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    local datetime = os.date("%Y-%m-%d %I:%M:%S %p")

    -- Get the current cursor position: (row, col)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Convert row to 0-based index (required by nvim_buf_set_text)
    row = row - 1

    -- Insert the datetime string at the exact cursor position
    vim.api.nvim_buf_set_text(0, row, col, row, col, { datetime })
  end, {})
end

return M


