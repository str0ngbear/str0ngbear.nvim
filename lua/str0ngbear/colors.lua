local colors = require("str0ngbear.palette")

local function select_colors()
	local selected = { none = "none" }
	selected = vim.tbl_extend("force", selected, colors[vim.g.str0ngbear_config.style])
	selected = vim.tbl_extend("force", selected, vim.g.str0ngbear_config.colors)
	return selected
end

return select_colors()
