local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--- ====== Wygląd i Fonty ======
config.font = wezterm.font_with_fallback({
    "JetBrains Mono Nerd Font",
    "Noto Color Emoji" 
})
config.font_size = 11.0
config.line_height = 1.1

-- Estetyka okna
config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 0.92
config.window_decorations = "RESIZE" 
config.window_padding = { left = '10pt', right = '10pt', top = '10pt', bottom = '10pt' }
config.colors = {
  tab_bar = {
    background = 'rgba(0, 0, 0, 0)', -- Przezroczyste tło paska, użyje koloru okna
    active_tab = {
      bg_color = '#89b4fa', -- Kolor niebieski z palety Catppuccin
      fg_color = '#1e1e2e', -- Ciemny tekst dla kontrastu
    },
  },
}

--- ====== Pasek Kart (Tab Bar) ======
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

--- ====== Zachowanie (Behavior) ======
config.default_prog = { "/usr/bin/zsh" }
config.scrollback_lines = 10000
config.check_for_updates = true
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5, -- Przyciemnia nieaktywne panele
}

--- ====== Skróty Klawiszowe (Keybindings) ======
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Dwa razy Ctrl+a wysyła Ctrl+a do terminala
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },
  
  -- Intuicyjne dzielenie okien (v - pionowo, h - poziomo)
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  
  -- NAWIGACJA STRZAŁKAMI (Ctrl + Strzałka)
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Szybkie przeładowanie configu (bez restartu terminala!)
  { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration },
  
  -- Tryb kopiowania (jak w tmux)
  { key = 'Enter', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  
  -- Zoom (Maksymalizacja panelu)
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
}

--- ====== Dynamiczny Status (Prawy róg) ======
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime('%Y-%m-%d %H:%M ')
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#89b4fa' } },
    { Text = wezterm.nerdfonts.fa_calendar .. '  ' .. date },
  }))
end)

return config

