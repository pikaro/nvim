return function()
    require("notify").setup({
        background_colour = "#000000",
        timeout = 1000,
        stages = "fade",
        render = "wrapped-compact",
    })
    require("telescope").load_extension("notify")
end
