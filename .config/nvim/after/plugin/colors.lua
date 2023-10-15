require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'main',
})

local colorDefault = 'rose-pine'

local iColor
local colors = vim.fn.getcompletion('', 'color')
local colorsLength = 0
for i, color in pairs(colors) do
    if color == colorDefault then
        iColor = i
    end
    colorsLength = colorsLength + 1 
end

function cycleColor ()
    iColor = (iColor % colorsLength ) + 1
    local color = colors[iColor]
    vim.cmd('colorscheme ' .. color)
    --vim.api.nvim_out_write(color)
    vim.cmd('echo "' .. color .. '"')
end

-- Set colorscheme after options
vim.cmd('colorscheme ' .. colorDefault)
