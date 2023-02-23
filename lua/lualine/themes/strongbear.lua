local c = require('strongbear.colors')
local cfg = vim.g.strongbear_config
local colors = {
    bg = c.bg0,
    fg = c.fg,
    red = c.cerise,
    green = c.moss,
    yellow = c.sunny,
    blue = c.frost,
    purple = c.lilac,
    cyan = c.lime,
    gray = c.grey
}

local one_dark = {
    inactive = {
        a = {fg = colors.gray, bg = colors.bg, gui = 'bold'},
        b = {fg = colors.gray, bg = colors.bg},
        c = {fg = colors.gray, bg = cfg.lualine.transparent and c.none or c.bg1},
    },
    normal = {
        a = {fg = colors.bg, bg = colors.green, gui = 'bold'},
        b = {fg = colors.fg, bg = c.bg3},
        c = {fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.bg1},
    },
    visual = {a = {fg = colors.bg, bg = colors.purple, gui = 'bold'}},
    replace = {a = {fg = colors.bg, bg = colors.red, gui = 'bold'}},
    insert = {a = {fg = colors.bg, bg = colors.blue, gui = 'bold'}},
    command = {a = {fg = colors.bg, bg = colors.yellow, gui = 'bold'}},
    terminal = {a = {fg = colors.bg, bg = colors.cyan, gui = 'bold'}},
}
return one_dark;
