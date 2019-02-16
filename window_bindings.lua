function maximize ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
	hs.window.switcher.nextWindow()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
	hs.window.switcher.previousWindow()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
    maximize()
end)
