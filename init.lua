hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall

hyper = {"cmd", "alt", "ctrl"}
hyperShift = {"cmd", "alt", "ctrl", "shift"}

Install:andUse('WindowScreenLeftAndRight')
Install:andUse('WindowHalfsAndThirds')

spoon.WindowScreenLeftAndRight:bindHotkeys({
    screen_left = { hyper, "N" },
    screen_right= { hyper, "P" },
})

spoon.WindowHalfsAndThirds:bindHotkeys({
    left_half   = { hyper, "Left" },
    right_half  = { hyper, "Right" },
})

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

require('window_bindings')
require('spotify_bindings')
