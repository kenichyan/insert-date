-- config/insert-date.lua
-- Place this file at lua/config/insert-date.lua in your Neovim config directory.
--
-- Available format specifiers (same as os.date / strftime):
--   %Y  4-digit year        (e.g. 2026)
--   %m  2-digit month       (e.g. 06)
--   %d  2-digit day         (e.g. 10)
--   %H  hour (24h)          (e.g. 14)
--   %M  minute              (e.g. 30)
--   %S  second              (e.g. 00)
--
-- The date is always UTC regardless of the local timezone.

return {
  -- Default: ISO 8601 with UTC suffix (e.g. 2026-06-10T14:30:00UTC)
  format = "%Y-%m-%dT%H:%M:%SUTC",

  -- Other examples:
  -- format = "%Y-%m-%d",              -- date only:  2026-06-10
  -- format = "%Y/%m/%d %H:%M:%S",     -- slash style: 2026/06/10 14:30:00
  -- format = "%d %b %Y",              -- verbose:     10 Jun 2026
}
