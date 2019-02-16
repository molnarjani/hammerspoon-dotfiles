config = require('config')
function reloadConfig(files)
    local doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


hs.loadSpoon("SpoonInstall")

Install=spoon.SpoonInstall

Install:andUse('WindowScreenLeftAndRight')
Install:andUse('WindowHalfsAndThirds')

Install:andUse('BingDaily')
Install:andUse('HCalendar')
Install:andUse('CircleClock')
Install:andUse('Commander')
Install:andUse('CountDown')
Install:andUse('PasswordGenerator')
Install:andUse('PopupTranslateSelection')

spoon.WindowScreenLeftAndRight:bindHotkeys({
    screen_left = { config.hyper, "N" },
    screen_right= { config.hyper, "P" },
})

spoon.WindowScreenLeftAndRight:bindHotkeys({
    screen_left = { config.hyper, "N" },
    screen_right= { config.hyper, "P" },
})

spoon.PasswordGenerator:bindHotkeys({
    paste  = { config.hyper, "V" },
})

spoon.PopupTranslateSelection:bindHotkeys({
    translate = { { "ctrl", "alt", "cmd" }, "e" },
})

hs.hotkey.bind(config.hyper, "C", function()
    spoon.Commander:show()
end)

require('window_bindings')
require('spotify_bindings')
