require('nvim-autopairs').setup({
  check_ts = true;
  ts_config = {};
  enable_check_bracket_line = false;
  ignored_next_char = "[%w%.'\"]"; -- maybe remove ' and " from the list?
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local cmp = require("cmp")

cmp.event:on( 'comfirm_done', cmp_autopairs )
