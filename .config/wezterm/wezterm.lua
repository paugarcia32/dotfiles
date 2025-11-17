local wezterm = require("wezterm")
local act = wezterm.action
local function is_found(str, pattern)
	return string.find(str, pattern) ~= nil
end
local is_win = is_found(wezterm.target_triple, "windows")

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end



function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Gruvbox Material (Gogh)"
	else
		return "Gruvbox Material (Gogh)"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())

config.window_background_opacity = 0.3

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Hack Nerd Font Mono",
})

config.window_background_opacity = 1
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"


config.initial_rows = 38
config.initial_cols = 135

config.scrollback_lines = 3000

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 25


config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
	end
	if window:leader_is_active() then
		stat = "LDR"
	end

	-- Current working directory
	local basename = function(s)
		-- Nothign a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end
	local cwd = basename(pane:get_current_working_dir())
	-- Current command
	local cmd = basename(pane:get_foreground_process_name())

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Let's add color to one of the components
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "FFB86C" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = " |" },
	}))
end)


local function is_found(str, pattern)
	return string.find(str, pattern) ~= nil
end

local is_win = is_found(wezterm.target_triple, "windows")
local is_linux = is_found(wezterm.target_triple, "linux")
local is_mac = is_found(wezterm.target_triple, "apple")
local os = is_win and "windows" or is_linux and "linux" or is_mac and "mac" or "unknown"

local options = {
	default_prog = {},
	launch_menu = {},
}

return config