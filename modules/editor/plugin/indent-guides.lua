local indent_char = "│"

local function update_listchars()
	-- vim-sleuth sets 'shiftwidth' (not 'tabstop') for space-indented files.
	-- shiftwidth() also follows 'tabstop' when 'shiftwidth' is 0.
	local indent = vim.fn.shiftwidth()

	vim.opt_local.list = true
	vim.opt_local.listchars = {
		tab = "> ",
		leadtab = indent_char .. " ",
		leadmultispace = indent_char .. string.rep(" ", math.max(indent - 1, 0)),
		trail = "·",
		nbsp = "␣",
	}
end

update_listchars()

vim.api.nvim_create_autocmd({ "BufEnter", "OptionSet" }, {
	group = vim.api.nvim_create_augroup("MyIndentGuide", { clear = true }),
	callback = function(event)
		if event.event == "OptionSet" and event.match ~= "shiftwidth" and event.match ~= "tabstop" then
			return
		end

		update_listchars()
	end,
})
