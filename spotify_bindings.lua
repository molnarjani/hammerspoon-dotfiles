config = require('config')

spotify_status = hs.menubar.new()
function setSpotifyDisplay()
	state = hs.spotify.getPlaybackState()
    if state == hs.spotify.state_playing then
		track = hs.spotify.getCurrentTrack()
		spotify_status:setTitle(track)
	end	

    if state == hs.spotify.state_paused then
		spotify_status:setTitle('||')
	end	

end

if spotify_status then
    hs.timer.doEvery(0.1, setSpotifyDisplay) 
end

hs.hotkey.bind(config.hyper, "space", function()
	hs.spotify.playpause()
end)

