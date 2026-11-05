require("hs.ipc")

local ghosttyBundleID = "com.mitchellh.ghostty"
local englishSourceID = "com.apple.keylayout.ABC"

ghosttyLayoutWatcher = hs.application.watcher
	.new(function(_, eventType, appObject)
		if eventType == hs.application.watcher.activated and appObject:bundleID() == ghosttyBundleID then
			hs.keycodes.currentSourceID(englishSourceID)
		end
	end)
	:start()
