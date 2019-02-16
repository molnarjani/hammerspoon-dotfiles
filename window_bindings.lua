function shift (direction)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.w = max.w / 2

	if direction == "Left" then
		f.x = max.x
		win:setFrame(f)
	end

	if direction == "Right" then
		f.x = max.w - (max.w / 2)
		win:setFrame(f)
	end
end

function maximize ()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    shift("Left")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    shift("Right")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
	hs.window.switcher.nextWindow()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
	hs.window.switcher.nextWindow()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
    maximize()
end)

