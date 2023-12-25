local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = {}
local dimmer = { brightness = 0.01 }
local dimmer2 = { brightness = 0.1, hue = 0.5, saturation = 0.5 }


------------------------------
-- Mouse functions on selection
------------------------------
function make_mouse_binding(dir, streak, button, mods, action)
  return {
    event = { [dir] = { streak = streak, button = button } },
    mods = mods,
    action = action,
  }
end

config.mouse_bindings = {
    make_mouse_binding('Up', 1, 'Left', 'NONE', wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'SHIFT', wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'ALT', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'SHIFT|ALT', wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 2, 'Left', 'NONE', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 3, 'Left', 'NONE', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
  }
-------------------
-- Scrollback
-------------------
-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 100000
config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'

------------------
-- Color scheme
------------------.
config.color_scheme = 'Zenburn' -- Dark theme
-- config.color_scheme = 'Tomorrow'-- Light theme
-- config.color_scheme = 'zenbones'-- Light theme
-- config.color_scheme = 'zenwritten_light'-- Light theme
-- config.color_scheme = 'Yousai (terminal.sexy)'
-- config.color_scheme = 'Solarized (light) (terminal.sexy)'
-- config.color_scheme = 'Mocha (light) (terminal.sexy)' 
-- config.color_scheme = 'Material'-- Light theme
config.background = {
     {
     source = {
       -- File = "C:\\tools\\mountains.jpg",
       -- File = "C:\\tools\\chemistry.jpg",
       File = "~/bin/chemistry.jpg"
     },
     width = '100%',
     -- repeat_x = 'NoRepeat',
     repeat_x = 'Mirror',

     -- position the spins starting at the bottom, and repeating every
     -- two screens.
     vertical_align = 'Top',
     repeat_y_size = '100%',
     repeat_y = 'Repeat',
     height = "Cover",

     -- hsb = dimmer,
     hsb = { brightness = 0.03 },
     -- The parallax factor is higher than the background layer, so this
     -- one will appear to be closer when we scroll
     attachment = { Parallax = 0.0 },
     -- attachment = "Scroll",
    },
}

------------------
-- Font setup
------------------
config.font = wezterm.font("BlexMono Nerd Font Mono", {weight="Bold", italic=false})

------------------
-- SSH Configuration
------------------
config.ssh_domains = {
}

---------------------
-- Serial connection
---------------------
config.serial_ports = {
}

------------------
-- Window startup
------------------
wezterm.on("gui-startup", function()
  local _, pane0, window = mux.spawn_window{}
  --local _, pane1, _ = window:spawn_tab{}
  --local _, pane2, _ = window:spawn_tab{}
  --local _, pane3, _ = window:spawn_tab{}
  --local _, pane4, _ = window:spawn_tab{}
  
  window:gui_window():maximize()

  --pane0:send_text "winscp sftp://a.maza:!dlatl00@182.197.162.161\n"
  --pane1:send_text "cd C:/work/\n"
  --pane2:send_text "cd ~/work\n"
  --pane0:send_text "cmd.exe /K C:/tools/cmder/vendor/init.bat /f /t\n"
  --pane3:send_text "top\n"
  --pane4:send_text "ssh -p port user@ip\n"
end)

config.set_environment_variables = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use OSC 7 as per the above example
  config.set_environment_variables['prompt'] = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m '
  -- use a more ls-like output format for dir
  config.set_environment_variables['DIRCMD'] = '/d'
  -- And inject clink into the command prompt
  config.default_prog =
    { 'cmd.exe', '/s', '/K', 'c:/tools/cmder/vendor/init.bat /t /f' }
end

-------------------
-- Key config
-------------------
config.keys = {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  { key = "E", mods ="CTRL", action=wezterm.action_callback(function(window, pane)
                    local ansi = window:get_selection_escapes_for_pane(pane);
                    window:copy_to_clipboard(ansi)
                end)},
}


-------------------
-- Default cmd
-------------------
-- Cmder
-- config.default_prog = {'cmd.exe','/K', 'C:/tools/cmder/vendor/init.bat', '/f', '/t'  }

-------------------
-- Launch menu
-------------------
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    local msys2_start_args = {
        "C:\\tools\\msys64\\usr\\bin\\env.exe",
        "MSYS=enable_pcon", -- Enable pseudo console API for msys (maybe not needed under wezterm?) Actually, needed - without it, Ctrl-D does not close the terminal!
        "MSYSTEM=MINGW64",
        "MSYS2_PATH_TYPE=inherit",
        "/bin/bash", "--login",
    }
    config.launch_menu = {
      {
        label = 'Cmder',
        args = {'cmd.exe','/K', 'C:/tools/cmder/vendor/init.bat', '/f', '/t'  },
      },
      {
          label = "COM",
          args = {'cmd.exe', '/K','sh', 'com_connect.sh'},
      },
      {
          label = "mingw64",
          args = msys2_start_args,
      },
    }
end
return config
