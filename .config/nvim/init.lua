--[[ if vim.g.vscode ~= nil then ]]
--[[     return ]]
--[[ end ]]

require('plugins')

vim.o.rnu = true
vim.o.number = true

if vim.g.started_by_firenvim ~= nil then 
    vim.cmd[[au BufEnter learn.zybooks.com_*.txt set filetype=cpp]]
    vim.g.firenvim_config = {
        ['localSettings'] = {
            ['https://learn\\.zybooks\\.com.*'] = { selector = 'textarea:not([aria-labelledby^="short"])'} 
        }
    }
end

