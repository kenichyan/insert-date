-- insert-date/init.lua

-- Default configuration: ISO 8601 format
local config = { format = "%Y-%m-%dT%H:%M:%S" }

-- Try to load user-defined configuration from config.insert-date
local ok, user_config = pcall(require, "config.insert-date")
if ok and type(user_config) == "table" then
  -- Merge user configuration with default
  config = vim.tbl_deep_extend("force", config, user_config)
end

-- Setup function that registers the :Date command
local function setup()
  vim.api.nvim_create_user_command("Date", function()
    local buf = vim.api.nvim_get_current_buf()

    -- Get the current cursor position (1-based indexing)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1  -- Convert to 0-based indexing

    -- Get the current line
    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""

    -- Ensure cursor column doesn't exceed line length
    if col > #line then col = #line end

    -- Format current date using Vim's strftime()
    local datetime = vim.fn.strftime(config.format)

    -- Make buffer modifiable if needed
    local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
    if not modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
    end

    -- Insert the formatted date at the cursor position
    vim.api.nvim_buf_set_text(buf, row, col, row, col, { datetime })

    -- Move cursor to the end of the inserted text
    vim.api.nvim_win_set_cursor(0, { row + 1, col + #datetime })

    -- Restore buffer's original modifiable state
    if not modifiable then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end, {})
end

-- Export the setup function
return {
  setup = setup,
}

