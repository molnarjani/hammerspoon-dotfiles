config = require('config')

function maximize ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end

hs.hotkey.bind(config.hyper, "Up", function()
	hs.window.switcher.nextWindow()
end)

hs.hotkey.bind(config.hyper, "Down", function()
	hs.window.switcher.previousWindow()
end)

hs.hotkey.bind(config.hyper, "M", function()
    maximize()
end)
