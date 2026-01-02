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

config.color_scheme = 'Darcula (base16)'


-- local function scheme_for_appearance(appearance)
--     return appearance:find("Dark") and "Catppuccin Mocha" or "Catppuccin Latte"

--     -- way 02
--     -- if appearance:find("Dark") then
--     --     return "Catppuccin Mocha" -- or Macchiato, Frappe, Latte, Mocha
--     -- else
--     --     return "Catppuccin Latte"
--     -- end
-- end

-- local color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
-- config.color_scheme = color_scheme

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
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

-- config.default_prog = {
-- 	"pwsh.exe",
-- 	"-NoLogo",
-- }

config.default_prog = {
    "nu",
}

-- todo
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

config.keys = config.keys or {}
-- todo 无法正常显示leader键本身
config.leader = { key = "\\", mods = "NONE", timeout_milliseconds = 300 }
local leader_map = {
    h              = act.SplitVertical { domain = "CurrentPaneDomain" },
    v              = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    x              = act.CloseCurrentPane { confirm = true },
    t              = act.SpawnTab("DefaultDomain"),
    w              = act.CloseCurrentTab { confirm = false },
    ["LeftArrow"]  = act.ActivatePaneDirection("Left"),
    ["RightArrow"] = act.ActivatePaneDirection("Right"),
    ["UpArrow"]    = act.ActivatePaneDirection("Up"),
    ["DownArrow"]  = act.ActivatePaneDirection("Down"),
}
for k, a in pairs(leader_map) do
    table.insert(config.keys, { key = k, mods = "LEADER", action = a })
end


local custom_map = {
    {
        key = "q",
        mods = "SHIFT|CTRL",
        action = act.QuitApplication,
    },
    {
        key = "w",
        mods = "SHIFT|CTRL",
        action = act.CloseCurrentPane({
            confirm = true,
        }),
    },
    {
        key = "t",
        mods = "CTRL",
        action = act.SpawnTab("DefaultDomain"),
        description = "Create a new tab",
    },
}

for _, m in ipairs(custom_map) do
    table.insert(config.keys, m)
end

-- todo 这里只写一个 Mod 是可以的
for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = act.ActivateTab(i - 1),
    })
end

-------------------- 鼠标绑定 --------------------
config.mouse_bindings            = { -- copy the selection
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
config.window_padding            = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.95

-- Acrylic 最透明，
-- Mica 磨砂感强，
-- Tabbed 介于两者之间
--
config.win32_system_backdrop     = 'Mica'
-- config.win32_system_backdrop     = 'Tabbed'
-- config.win32_system_backdrop     = "Acrylic"

-- windows background image
-- local dimmer                     = {
--     brightness = 0.1,
-- }
-- config.background = {{
--     source = {
--         File = 'xxxxxx/wezterm-background/voyage.jpg'
--     },
--     repeat_x = 'Mirror',
--     hsb = dimmer,
--     attachment = {
--         Parallax = 0.1
--     }
-- }}
return config
