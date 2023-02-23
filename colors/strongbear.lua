for k in pairs(package.loaded) do
    if k:match(".*strongbear.*") then package.loaded[k] = nil end
end

require('strongbear').setup()
require('strongbear').colorscheme()
