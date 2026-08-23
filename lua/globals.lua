local systems = {
	["dre-mbp"] = {
		name = "work",
		copilot = false,
	},
	["dre-mba"] = {
		name = "personal",
		copilot = true,
	},
	["windows"] = {
		name = "windows",
		copilot = false,
	},
}

_G.context = {
	system = systems[vim.fn.hostname()],
}
