local wezterm = require("wezterm")
local config = wezterm.config_builder()

local osname
local n = 1
for i in string.gmatch(wezterm.target_triple, "[^-]+") do
  if n == 3 then osname = i end
  n = n + 1
end

-- SIMPLE FUNCTIONALITY
-- Right Alt Compose
config.send_composed_key_when_right_alt_is_pressed = false
-- Dead Keys
config.use_dead_keys = false
-- Max FPS
config.max_fps = 120
-- Wezterm features.
config.term = "wezterm"

-- VISUALS
-- Native MacOS fullscreen.
if osname == "darwin" then
  config.native_macos_fullscreen_mode = true
end
-- Windows WSL
if osname == "windows" then
  config.default_domain = "WSL:Ubuntu"
end
-- Font
local function get_font(weight, style)
  local args = {
    family = "JetBrainsMono Nerd Font",
    harfbuzz_features = {
      "zero",
      "calt=0",
      "clig=0",
      "liga=0",
    },
  }
  if weight then args.weight = weight end
  if style then args.style = style end
  return wezterm.font(args)
end
config.font = get_font()
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
    font = get_font("ExtraBold"),
	},
	{
		intensity = "Bold",
		italic = true,
    font = get_font("ExtraBold", "Italic"),
	},
}
-- Color Scheme
config.color_scheme = "Horizon Dark (Gogh)"
-- Cursor Blinking
config.cursor_blink_rate = 0
-- Disable Tab Bar
config.hide_tab_bar_if_only_one_tab = true
-- Alignment/Padding.
config.window_padding = {
  left = "0cell",
  right = "0cell",
  top = "0cell",
  bottom = "0cell",
}
-- Center Alignment
config.window_content_alignment = {
  horizontal = "Center",
  vertical = "Center",
}
-- Set default program to fish.
config.default_prog = { "fish" }

-- DATA
local function join(...) return table.concat({...}, "/"):gsub("//+", "/") end
local datadir = join(os.getenv("XDG_DATA_HOME") or join((osname == "windows") and os.getenv("HOMEPATH") or os.getenv("HOME"), "/.local/share"), "/wezterm")
os.execute("mkdir -p" .. datadir)
local data_file = join(datadir, "/data.lua")
-- Try to load data file.
local file, err = io.open(data_file, "r")
local data
if not file then
  wezterm.log_error("Can't open [data_file] for read: " .. err)
else
  file:close()
  data = dofile(data_file)
end
-- Load data values.
local backgrounds = {}
if data then
  if data.backgrounds then backgrounds = data.backgrounds end
end

-- BACKGROUND SWITCHER
local window_backgrounds = {}
-- Apply Background
local function apply_background(overrides, bg)
  overrides.background = {
    {
      source = {
        Color = "black",
      },
      width = "100%",
      height = "100%",
    },
    {
      source = {
        File = bg[1],
      },
      horizontal_align = "Center",
      vertical_align = "Middle",
      width = "Cover",
      height = "Cover",
      opacity = bg[2],
    },
  }
end

-- CONFIG
local conf_file = join(datadir, "/conf.lua")
-- Try to load config file.
file, err = io.open(conf_file, "r")
local conf
if not file then
  wezterm.log_error("Can't open [conf_file] for read: " .. err)
else
  file:close()
  conf = dofile(conf_file)
end
-- Load config values.
local loaded_bid = 1
if conf then
  if conf.bid then loaded_bid = conf.bid end
  if conf.bgon then apply_background(config, backgrounds[loaded_bid]) end
end

local function write_value(name, value)
  io.write(name .. "=")
  local t = type(value)
      if t == "number" then io.write(value)
  elseif t == "string" then io.write("\"" .. value .. "\"")
  elseif t == "boolean" then io.write(value and "true" or "false")
  elseif t == "nil" then io.write("nil")
  end
end

local function write_record(rec)
  local k, v = next(rec, nil)
  io.write("{")
  while k do
    write_value(k, v)
    io.write(",")
    k, v = next(rec, k)
  end
  io.write("}")
end

local function get_bg_state(overrides, wid)
  local bid = window_backgrounds[wid] or loaded_bid
  if overrides.background then
    return {#overrides.background > 0, bid}
  else
    return {config.background ~= nil, bid}
  end
end

-- Toggle Background
local function toggle_background(window, _)
  local overrides = window:get_config_overrides() or {}
  local wid = window:window_id()
  local bg_state = get_bg_state(overrides, wid)
  if bg_state[1] then
    overrides.background = {}
  else
    apply_background(overrides, backgrounds[bg_state[2]])
  end
  window:set_config_overrides(overrides)
end
-- Cycle Background
local function cycle_background(window, _)
  local overrides = window:get_config_overrides() or {}
  local wid = window:window_id()
  local bg_state = get_bg_state(overrides, wid)
  local bid = bg_state[2]
  if bg_state[1] then
    bid = bid + 1
  end
  if bid > #(backgrounds) then
    bid = 1
  end
  window_backgrounds[wid] = bid
  apply_background(overrides, backgrounds[bid])
  window:set_config_overrides(overrides)
end

-- SAVE CONFIG
local function save_conf(window, _)
  file, err = io.open(conf_file, "w")
  if not file then
    wezterm.log_error("Can't open [conf_file] for write: " .. err)
  else
    local overrides = window:get_config_overrides() or {}
    local wid = window:window_id()
    local bg_state = get_bg_state(overrides, wid)
    io.output(file)
    io.write("return")
    write_record({
      bgon=bg_state[1],
      bid=bg_state[2],
    })
    file:close()
    loaded_bid = bg_state[2]
    if bg_state[1] then apply_background(config, backgrounds[loaded_bid]) end
  end
end

config.keys = {
  {
    key = "B",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(toggle_background),
  },
  {
    key = "C",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(cycle_background),
  },
  {
    key = "S",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(save_conf),
  },
}

return config
