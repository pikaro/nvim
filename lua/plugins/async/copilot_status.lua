return function()
	local api = require("copilot.api")
	api.register_status_notification_handler(function(data)
		if data.status == "Normal" then
			vim.g.copilot_status = "🥽"
		elseif data.status == "InProgress" then
			vim.g.copilot_status = "⏳"
        elseif data.status == "Warning" then
            vim.g.copilot_status = "❗"
		else
			vim.g.copilot_status = "❌"
		end
	end)
end
