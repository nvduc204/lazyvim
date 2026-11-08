return {
	"mfussenegger/nvim-dap",
	cmd = {
		"DapContinue",
		"DapToggleBreakpoint",
	},
	opts = function()
		local dap = require("dap")
		local mason = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")

		---------------------------------------------------------------------------
		-- JavaScript / TypeScript (pwa-node)
		---------------------------------------------------------------------------
		local js_debug = vim.fs.joinpath(mason, "js-debug-adapter", "js-debug", "src", "dapDebugServer.js")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					js_debug,
					"${port}",
					"127.0.0.1",
				},
			},
		}

		for _, ft in ipairs({ "javascript", "typescript" }) do
			dap.configurations[ft] = dap.configurations[ft] or {}

			table.insert(dap.configurations[ft], {
				name = "Launch current file",
				type = "pwa-node",
				request = "launch",
				program = "${file}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				sourceMaps = true,
				skipFiles = {
					"<node_internals>/**",
				},
			})
		end

		---------------------------------------------------------------------------
		-- C / C++ (codelldb)
		---------------------------------------------------------------------------
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fs.joinpath(mason, "codelldb", "extension", "adapter", "codelldb.exe"),
				args = { "--port", "${port}" },
				detached = false,
			},
		}

		for _, ft in ipairs({ "c", "cpp" }) do
			dap.configurations[ft] = dap.configurations[ft] or {}

			table.insert(dap.configurations[ft], {
				name = "Launch executable",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				console = "integratedTerminal",
			})
		end
	end,
}
