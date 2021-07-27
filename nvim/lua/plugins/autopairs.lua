require('nvim-autopairs').setup({
  check_ts = true;
  ts_config = {};
  enable_check_bracket_line = true;
  ignored_next_char = "[%w%.'\"]"; -- maybe remove ' and " from the list?
})

require('nvim-autopairs.completion.compe').setup({
  map_cr = true;
  map_complete = true;
})
