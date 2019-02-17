--- Audio-related stuff

spotify_is_playing = false
spotify_was_playing = false


function spotify_pause()
    logger.df("Pausing Spotify")
    hs.spotify.pause()
end
function spotify_play()
    logger.df("Playing Spotify")
    hs.spotify.play()
end

-- Testing the new audiodevice watcher
function audiowatch (arg)
    local headphones = hs.audiodevice.findDeviceByName('External Headphones')
    dev = hs.audiodevice.defaultOutputDevice()
    if not headphones then
        dev:setOutputMuted(true)
    else
        dev:setOutputMuted(false)
    end
--    local spotify_is_playing = state == hs.spotify.state_playing
--    if not headphones and spotify_is_playing then
--        spotify_pause()
--        spotify_was_playing = true
--    elseif not headphones and not spotify_is_playing then
--        spotify_was_playing = false
--    elseif headphones and spotify_was_playing then
--        spotify_play()
--    end
end

hs.audiodevice.watcher.setCallback(audiowatch)
hs.audiodevice.watcher.start()

for i,dev in ipairs(hs.audiodevice.allOutputDevices()) do
    dev:watcherCallback(audiodevwatch):watcherStart()
    logger.df("Setting up watcher for audio device %s", dev:name())
end
