---@diagnostic disable: undefined-global

require("full-border"):setup()
require("bookmarks"):setup({
  save_last_directory = true,
})

--------------------

Header:children_add(function()
  if ya.target_family() ~= "unix" then
    return ui.Line({})
  end
  return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

--------------------

Status:children_remove(5, Status.RIGHT)

function Status:name()
  local h = cx.active.current.hovered
  if not h then
    return ui.Line({})
  end

  local linked = h.link_to ~= nil and " -> " .. tostring(h.link_to) or ""
  return ui.Line(" " .. h.name .. linked)
end

Status:children_add(function()
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
end, 500, Status.RIGHT)

Status:children_add(function()
  local h = cx.active.current.hovered
  if not h then
    return ui.Line({})
  end

  local time = (h.cha.mtime or 0) // 1
  return ui.Line({
    ui.Span(" " .. THEME.status.separator_open):fg(THEME.status.separator_style.fg),
    ui.Span(" " .. (time ~= 0 and os.date("%d/%m/%Y %H:%M", time) or "") .. " ")
      :fg(THEME.manager.hovered.bg)
      :bg(THEME.status.separator_style.bg),
  })
end, 2000, Status.RIGHT)

--------------------

local function linemode_time(t)
  local time = (t or 0) // 1
  local time_str
  if time > 0 and os.date("%Y", time) == os.date("%Y") then
    time_str = os.date("%d/%m %H:%M", time)
  else
    time_str = time and os.date("%d/%m/%Y", time) or ""
  end
  return ui.Line(time_str)
end

function Linemode:ctime()
  return linemode_time(self._file.cha.btime)
end

function Linemode:mtime()
  return linemode_time(self._file.cha.mtime)
end

----------
