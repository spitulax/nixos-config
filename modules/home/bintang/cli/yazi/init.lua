---@diagnostic disable: undefined-global

require("full-border"):setup()
require("bookmarks"):setup({
  save_last_directory = true,
})
require("git-status"):setup({
  style = "beside",
})

--------------------

function Header:host()
  if ya.target_family() ~= "unix" then
    return ui.Line({})
  end
  return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end

function Header:render(area)
  self.area = area

  local right = ui.Line({ self:count(), self:tabs() })
  local left = ui.Line({ self:host(), self:cwd(math.max(0, area.w - right:width())) })
  return {
    ui.Paragraph(area, { left }),
    ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
  }
end

--------------------

function Status:name()
  local h = cx.active.current.hovered
  if not h then
    return ui.Span("")
  end

  local linked = ""
  if h.link_to ~= nil then
    linked = " -> " .. tostring(h.link_to)
  end

  return ui.Span(" " .. h.name .. linked)
end

function Status:owner()
  local h = cx.active.current.hovered
  if h == nil or ya.target_family() ~= "unix" then
    return ui.Line({})
  end

  return ui.Line({
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ui.Span(":"),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    ui.Span(" "),
  })
end

function Status:mtime()
  local h = cx.active.current.hovered
  if not h then
    return ui.Line({})
  end

  local style = self.style()
  local time = h.cha.modified
  return ui.Line({
    ui.Span(" " .. THEME.status.separator_open):fg(THEME.status.separator_style.fg),
    ui.Span((time and os.date("%d/%m/%y %H:%M", time // 1) or "") .. " ")
      :fg(style.bg)
      :bg(THEME.status.separator_style.bg),
  })
end

function Status:render(area)
  self.area = area

  local left = ui.Line({ self:mode(), self:size(), self:name() })
  local right = ui.Line({ self:owner(), self:permissions(), self:mtime(), self:position() })
  return {
    ui.Paragraph(area, { left }),
    ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
    table.unpack(Progress:render(area, right:width())),
  }
end

--------------------

function Folder:linemode(area, files)
  local mode = cx.active.conf.linemode
  if mode == "none" then
    return {}
  end

  local lines = {}
  for _, f in ipairs(files) do
    local spans = { ui.Span(" ") }
    if mode == "size" then
      local size = f:size()
      spans[#spans + 1] = ui.Span(size and ya.readable_size(size) or "")
    elseif mode == "mtime" then
      local time = f.cha.modified
      spans[#spans + 1] = ui.Span(time and os.date("%d/%m/%y %H:%M", time // 1) or "")
    elseif mode == "permissions" then
      spans[#spans + 1] = ui.Span(f.cha:permissions() or "")
    elseif mode == "owner" then
      spans[#spans + 1] = ya.user_name
          and ui.Span(ya.user_name(f.cha.uid) .. ":" .. ya.group_name(f.cha.gid))
        or ui.Span("")
    end

    spans[#spans + 1] = ui.Span(" ")
    lines[#lines + 1] = ui.Line(spans)
  end
  return ui.Paragraph(area, lines):align(ui.Paragraph.RIGHT)
end

----------
