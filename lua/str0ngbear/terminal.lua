local M = {}
local cfg = vim.g.str0ngbear_config
local c = require 'str0ngbear.colors'

function M.setup()
    if not cfg.term_colors then return end
    vim.g.terminal_color_0 = c.black
    vim.g.terminal_color_1 = c.cerise
    vim.g.terminal_color_2 = c.moss
    vim.g.terminal_color_3 = c.sunny
    vim.g.terminal_color_4 = c.frost
    vim.g.terminal_color_5 = c.lilac
    vim.g.terminal_color_6 = c.lime
    vim.g.terminal_color_7 = c.fg
    vim.g.terminal_color_8 = c.grey
    vim.g.terminal_color_9 = c.cerise
    vim.g.terminal_color_10 = c.moss
    vim.g.terminal_color_11 = c.sunny
    vim.g.terminal_color_12 = c.frost
    vim.g.terminal_color_13 = c.lilac
    vim.g.terminal_color_14 = c.lime
    vim.g.terminal_color_15 = c.fg
end

return M
