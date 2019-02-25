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
    logger.df('Spotify play toggled')
	hs.spotify.playpause()
end)

hs.hotkey.bind(config.hyper, ",", function()
	logger.df('Spotify previous')
	hs.spotify.previous()
end)

hs.hotkey.bind(config.hyper, ".", function()
	logger.df('Spotify next')
	hs.spotify.next()
end)

