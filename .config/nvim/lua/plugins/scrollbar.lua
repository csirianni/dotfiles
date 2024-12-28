return {
    'petertriho/nvim-scrollbar',
    config = function()
        require('scrollbar').setup({
            handle = {
                color = '#E2E2E3',
                blend = 80,
                hide_if_all_visible = false,
            },
        })
    end
}
