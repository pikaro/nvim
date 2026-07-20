local systems = {
	["dre-mbp"] = "work",
	["dre-mba"] = "personal",
}

_G.context = {
	system = systems[vim.fn.hostname()],
}
