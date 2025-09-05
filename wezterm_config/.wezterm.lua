--
-- TODO: 改变标签页 让它可以拖动 现在是新建的时候会有 应该保持默认就有
--
-- Wezterm configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-------------------- 颜色配置 --------------------
-- colorscheme
-- config.color_scheme = "Batman"
-- config.color_scheme = "Atom"
-- config.color_scheme = "Apple System Colors"
-- config.color_scheme = 'CutiePro'
-- config.color_scheme = "Material Darker (base16)"

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha" -- or Macchiato, Frappe, Latte
	else
		return "Catppuccin Latte"
	end
end

color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.tab_bar_at_bottom = true
config.show_close_tab_button_in_tabs = false


config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- font
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 12.0
config.initial_cols = 120
config.initial_rows = 30
config.max_fps = 120

-- 设置默认的启动shell

-- config.set_environment_variables    = {
-- COMSPEC = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
-- }

-- config.default_prog                 = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', '-NoLogo' }


-- config.default_prog = {
-- 	"C:/Users/AZK19/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShellPreview_8wekyb3d8bbwe/pwsh.exe",
-- 	"-NoLogo",
-- }

config.default_prog = {
	"pwsh.exe",
	"-NoLogo",
}

config.window_frame = {
	font = wezterm.font({
		family = "Consolas",
		weight = "Bold",
	}),
	font_size = 12.0,
	active_titlebar_bg = "#090909",
	inactive_titlebar_bg = "#333333",
}
config.colors = {
	tab_bar = {
		inactive_tab_edge = "#575757",
	},
}

-------------------- 键盘绑定 --------------------
local act = wezterm.action

-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "q",
		mods = "CTRL",
		action = act.QuitApplication,
	},
	{
		key = "h",
		mods = "CTRL",
		action = act.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "v",
		mods = "CTRL",
		action = act.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "w",
		mods = "SHIFT|CTRL",
		action = act.CloseCurrentPane({
			confirm = true,
		}),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Down"),
	}, -- CTRL + T 创建默认的Tab
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab("DefaultDomain"),
	}, -- CTRL + W 关闭当前Tab
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentTab({
			confirm = false,
		}),
	},
}

for i = 1, 8 do
	-- CTRL + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act.ActivateTab(i - 1),
	})
end

-------------------- 鼠标绑定 --------------------
config.mouse_bindings = { -- copy the selection
	{
		event = {
			Up = {
				streak = 1,
				button = "Left",
			},
		},
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	}, -- Open HyperLink
	{
		event = {
			Up = {
				streak = 1,
				button = "Left",
			},
		},
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

-------------------- az --------------------
-- window opacity
-- config.window_background_opacity = 0.85
-- config.win32_system_backdrop     = 'Acrylic'

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.85
-- config.win32_system_backdrop     = 'Mica'
-- config.win32_system_backdrop     = 'Tabbed'
config.win32_system_backdrop = "Acrylic"

-- windows background image
local dimmer = {
	brightness = 0.1,
}
-- config.background = {{
--     source = {
--         File = 'D:/!Workbenches/10/wezterm-background/voyage.jpg'
--     },
--     repeat_x = 'Mirror',
--     hsb = dimmer,
--     attachment = {
--         Parallax = 0.1
--     }
-- }}
return config
