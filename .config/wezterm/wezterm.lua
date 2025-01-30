-- pulling the wezterm API
local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local colors = require("colors")
local scheme = wezterm.get_builtin_color_schemes()["Tokyo Night"]
print(scheme)

resurrect.periodic_save({ interval_seconds = 15 * 60, save_workspaces = true, save_windows = true, save_tabs = true })

-- bulding the wezterm config builder
local config = wezterm.config_builder()

-- selecting all GPUs
local gpus = wezterm.gui.enumerate_gpus()

-- changing the renderer to GPU
config.front_end = "WebGpu"

-- ACTUAL CONFIG --

local SOLID_LEFT_ARROW = utf8.char(0xe0b2) -- solid filled in variant of <
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0) -- solid filled in variant of >
-- color scheme
config.color_scheme = "Tokyo Night" -- nordfox -- "coolnite" -- "Tokyo Night" -- "Catppuccin Macchiato" some others are 'Dracula', 'rose-pinr'
-- my coolnight colorscheme:
config.colors = {
--     foreground = colors.foreground,
--     background = colors.background,
    
--     cursor_bg = colors.cursor_bg,
--     cursor_border = colors.cursor_border,
--     cursor_fg = colors.cursor_fg,
    
--     selection_bg = colors.selection_bg,
--     selection_fg = colors.selection_fg,

--     ansi = {
--         colors.black,
--         colors.red,
--         colors.green,
--         colors.yellow,
--         colors.blue,
--         colors.purple,
--         colors.light_cyan,
--         colors.white,
--     },

--     brights = {
--         colors.bright_black,
--         colors.bright_red,
--         colors.bright_green,
--         colors.bright_yellow,
--         colors.bright_blue,
--         colors.bright_purple,
--         colors.bright_light_cyan,
--         colors.bright_white,
--     },

    tab_bar = {
        background = colors.tab_bar_bg,

--         active_tab = {
--             bg_color = colors.active_tab_bg,
--             fg_color = colors.active_tab_fg,
--             intensity = "Bold",
--         },

--         inactive_tab = {
--             bg_color = colors.inactive_tab_bg,
--             fg_color = colors.inactive_tab_fg,
--         },
    },
}


-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- windows opacity
config.window_background_opacity = 0.8
config.win32_system_backdrop = "Acrylic"

-- tab bar config
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.default_workspace = "Coding..."
config.window_decorations = "RESIZE"
config.integrated_title_buttons = { "Close" }
config.integrated_title_button_style = "Gnome"

local firstTabId = 0
local lastTabId = 1
local _ = 0
-- Format tab title - adding arrow in front of them
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- print(tab:tab_id())
    local is_active = tab.is_active
    local next_is_active = false
	-- local title = tab.title

    for i, t in ipairs(tabs) do
		if i == 1 then
			firstTabId = t.tab_id
		end
        if t.tab_id == tab.tab_id and i < #tabs then
            next_is_active = tabs[i + 1].is_active
            break
        end
    end

    local active_bg = colors.blue
	local active_fg = colors.background
	local inactive_bg = colors.inactive_tab_bg
	local inactive_fg = colors.inactive_tab_fg

    local arrow_fg = is_active and active_bg or inactive_bg
    local arrow_bg = is_active and inactive_bg or (next_is_active and active_bg or inactive_bg)
    local tab_fg = is_active and active_fg or inactive_fg
    local tab_bg = is_active and active_bg or inactive_bg

	local title = "home"
	-- print("this: " .. string.len(tab.tab_title))
	if string.len(tab.tab_title) > 0 then
		title = tab.tab_title
	else
		title = tab.tab_id .. ":" .. tab.active_pane.title
	end

	if string.len(title) > 13 then
		title = string.sub(title, 1, 11) .. ".."
	end
	-- print(tabs[#tabs])
	if tab.tab_id == tabs[#tabs].tab_id then
		arrow_bg = "rgba(0,0,0,0)"
	end

    return {
        -- Changed order to show arrow after tab
        { Background = { Color = tab_bg } },
        { Foreground = { Color = tab_fg } },
        { Text = " " .. title .. " " },
        
        { Background = { Color = arrow_bg } },
        { Foreground = { Color = arrow_fg } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

-- window padding
config.window_padding = {
	left = 6,
	right = 2,
	top = 2,
	bottom = 0,
}
config.window_background_image = "C:\\Users\\ASUS\\.config\\wezterm\\bg-blurred-darker.png"

-- changing the startup program and setting up WSL
config.wsl_domains = {
	{
		name = "WSL:Ubuntu",
		distribution = "Ubuntu",
		default_cwd = "/home/bhavya",
	},
}
config.default_domain = "WSL:Ubuntu"
config.default_prog = { "wsl" }

-- configuring font
config.font = wezterm.font("JetBrains Mono")
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.line_height = 1.05
config.cell_width = 1

-- rename workspace funcion
local function rename_workspace(window, pane)
	window:perform_action(
		wezterm.action.PromptInputLine({
			description = "Rename Workspace:",
			action = wezterm.action_callback(function(_, _, new_name)
				if new_name and new_name ~= "" then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), new_name)
				end
			end),
		}),
		pane
	)
end

-- setting up the leader key and other key bindings
config.leader = { key = "mapped:1", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "c", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	-- pane workflow key bindings
	{ key = "phys:Space", mods = "LEADER", action = wezterm.action.ActivateCommandPalette },
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
	},
	{ key = "m", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	-- pane resizing key bindings
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },

	-- tab key bindings
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{ key = "n", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
	{
		key = "e",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Rename Tab Title:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({ name = "move_tab", one_shot = false }),
	},
	-- workspace key bindings
	{ key = "]", mods = "LEADER", action = wezterm.action.SwitchWorkspaceRelative(1) },
	{ key = "[", mods = "LEADER", action = wezterm.action.SwitchWorkspaceRelative(-1) },
	{
		mods = "LEADER|SHIFT",
		key = "R",
		action = wezterm.action_callback(rename_workspace),
	},
	{
		key = "N",
		mods = "LEADER|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
		  end),
	  },
	  {
		key = "W",
		mods = "ALT",
		action = resurrect.window_state.save_window_action(),
	  },
	  {
		key = "t",
		mods = "CTRL",
		action = resurrect.tab_state.save_tab_action(),
	  },
	  {
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		  end),
	  },
	  {
		key = "p",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
		  resurrect.fuzzy_load(win, pane, function(id, label)
			local type = string.match(id, "^([^/]+)") -- match before '/'
			id = string.match(id, "([^/]+)$") -- match after '/'
			id = string.match(id, "(.+)%..+$") -- remove file extention
			local opts = {
			  relative = true,
			  restore_text = true,
			  on_pane_restore = resurrect.tab_state.default_on_pane_restore,
			}
			if type == "workspace" then
			  local state = resurrect.load_state(id, "workspace")
			  resurrect.workspace_state.restore_workspace(state, opts)
			elseif type == "window" then
			  local state = resurrect.load_state(id, "window")
			  resurrect.window_state.restore_window(pane:window(), state, opts)
			elseif type == "tab" then
			  local state = resurrect.load_state(id, "tab")
			  resurrect.tab_state.restore_tab(pane:tab(), state, opts)
			end
		  end)
		end),
	  },
	  -- to completely quit wezterm
	  { key = 'Q', mods = 'ALT|SHIFT', action = wezterm.action.QuitApplication },
}

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- key tables
config.key_tables = {
	resize_pane = {
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "j", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "k", action = wezterm.action.MoveTabRelative(1) },
		{ key = "l", action = wezterm.action.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- status bar
config.status_update_interval = 1000
wezterm.on("update-status", function(window, pane)
    -- Left status bar configs
	local BACKGROUND = { Background = { Color = colors.green } }
	local FOREGROUND = { Foreground = { Color = colors.background } }
	local prefix = " " .. wezterm.nerdfonts.cod_multiple_windows .. " " .. window:active_workspace()

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) .. "Leader" -- ocean wave
		BACKGROUND = { Background = { Color = colors.red } }
	end

	if window:active_key_table() then
		prefix = " " .. wezterm.nerdfonts.md_keyboard .. " " .. window:active_key_table()
		BACKGROUND = { Background = { Color = colors.yellow } }
	end

	-- Dynamic arrow background for 0th tab
	local active_tab_index = window:active_tab():tab_id()
	local is_0th_tab_active = active_tab_index == firstTabId

	local ARR_BG = {
		Background = is_0th_tab_active and
			{ Color = colors.blue } or
			{ Color = colors.inactive_tab_bg }
	}

	local ARR_FG = { Foreground = BACKGROUND.Background }
	
    -- Left status bar
    window:set_left_status(wezterm.format({
        FOREGROUND,
        BACKGROUND,
        { Attribute = { Intensity = "Bold" } },
        { Text = prefix },
        "ResetAttributes",
        ARR_FG,
        ARR_BG,
        { Text = SOLID_RIGHT_ARROW },
    }))

    -- Right status bar (UPDATED with left arrow)
    local function basename(s)
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end

    local bat = 'this much battery'
	local th = 'md_battery_charging_'
	-- print(wezterm.nerdfonts[th])
	for _, b in ipairs(wezterm.battery_info()) do
		local batPer = b.state_of_charge * 100
		local batsign = th .. math.tointeger((batPer//10)*10)
		batsign = wezterm.nerdfonts[batsign]
		bat = " " .. batsign .. " " .. string.format('%.0f%%', batPer) 
	end
	
    local time1 = os.date("%d %b,%Y") 
	local time2 = os.date("%I:%M %p")

	window:set_right_status(wezterm.format({
		-- Added left arrow with matching colors
		{Foreground = {Color = colors.black}},
		{Background = {Color = colors.tab_bar_bg}},
		{Text = SOLID_LEFT_ARROW},

		{Foreground = {Color = colors.foreground}},
		{Background = {Color = colors.black}},
		{Attribute = {Intensity = "Bold"}},
		{Text = bat .. " "},

		{Foreground = {Color = colors.blue}},
		{Background = {Color = colors.black}},
		{Text = SOLID_LEFT_ARROW},

		{Background = {Color = colors.blue}},
		{Foreground = {Color = colors.background}},
		{Text = " " .. wezterm.nerdfonts.md_calendar_month .. " " .. time1 .. " "},

		{Background = {Color = colors.blue}},
		{Foreground = {Color = colors.green}},
		{Text = SOLID_LEFT_ARROW},

		{Foreground = {Color = colors.background}},
		{Background = {Color = colors.green}},
		{Text = " " .. wezterm.nerdfonts.fa_clock_o .. " " .. time2 .. " "},

		"ResetAttributes",
	}))
end)

config.max_fps = 144
wezterm.on("gui-startup", resurrect.resurrect_on_gui_startup)

-- finally returning the config
return config
