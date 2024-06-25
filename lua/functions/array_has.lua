return function(array, value)
	for _, v in ipairs(array) do
		if v == value then
			return true
		end
	end
	return false
end
