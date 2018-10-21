-- nothing really to configure sorry if u were expecting more

---- Enable the addon?
-- true: server will run everything
-- false: server wont run the addon
---- (recommended: true)
SHR.Config.Enabled = true

---- Should clients automatically use our new hit registration? (doesn't run if addon disabled)
-- 1: new players will auomatically use the new hitreg
-- 0: new players will not auomatically use the new hitreg
---- (recommended: 1)
SHR.Config.ClientDefault = 1

---- Chat Command to enable/disable the hitreg.
-- table or string: the chat commands for players to easily enable/disable the hitreg
-- commands can be ran with a "/" or a "!" before them
---- (recommended: {"hitreg"})
SHR.Config.Commands = {"hitreg"}
-- comment out the above line if you don't want a command


---- Wall Checks
-- true: server will make sure there is no wall between a player and the thing he shot
-- false: server will damage thing player hit regardless if wall was detected
---- (recommended: true)
SHR.Config.WallChecks = true