vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("my.conform", {}),
	callback = function(evt)
		require("conform").format({ bufnr = evt.buf })
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
	formatters = {
		prettier = {
			condition = require("conform.util").root_file({
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettierrc.json5",
				".prettierrc.js",
				"prettier.config.js",
				".prettierrc.ts",
				"prettier.config.ts",
				".prettierrc.mjs",
				"prettier.config.mjs",
				".prettierrc.mts",
				"prettier.config.mts",
				".prettierrc.cjs",
				"prettier.config.cjs",
				".prettierrc.cts",
				"prettier.config.cts",
				".prettierrc.toml",
			}),
		},
	},
	notify_no_formatters = false,
})
