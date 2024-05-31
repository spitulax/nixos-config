return {
  config = function()
    require('mini.align').setup()
    require('mini.bufremove').setup()
    require('mini.surround').setup({
      mappings = {
        add = 'Sa',
        delete = 'Sd',
        find = 'Sf',
        find_left = 'SF',
        highlight = 'Sh',
        replace = 'Sr',
        update_n_lines = 'Sn',
      },
    })
  end,
}
