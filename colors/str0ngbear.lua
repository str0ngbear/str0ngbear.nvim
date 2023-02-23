for k in pairs(package.loaded) do
    if k:match(".*str0ngbear.*") then package.loaded[k] = nil end
end

require('str0ngbear').setup()
require('str0ngbear').colorscheme()
