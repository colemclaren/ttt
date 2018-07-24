InfectConfig = {}
--These are default recommended settings :), feel free to play game designer here though
--READ EACH, ALL ARE IMPORTANT
--This will control the zombie type that spawns. 
--Only works for the AI!!
--There are two options - "fast" and "classic"
InfectConfig.ZombieType = "classic"
--This allows you to choose if zombies are player controlled or not.
--Personally... Keep this on, it's so much more fun that ai zombies.
--The choices are true/false
InfectConfig.PZ = true
--This allows the player zombie to infect people by simply touching them!
--The choices are true/false
InfectConfig.TouchInfect = false
--This is the radius that the touch infect will infect people from.
--If you notice people getting infected through walls or something turn this down a notch
--until you're happy :)
InfectConfig.TouchInfectRadius = 45
--This controls whether or not the player's screen will tick when infected
--The choices are true/false
InfectConfig.ScreenTick = true
--This controls whether T's can get infected by the player zombies
--The choices are true/false
InfectConfig.TInfect = true
--This controls whether the bioball *sploosh* noise is silent
--The choices are true/false
InfectConfig.Silent = false
--This controls whether or not the player recieves the message telling him he's infected
--The choices are true/false
InfectConfig.InfectMessage = true
--This sets the minimum time it takes for you to turn into a zombie
InfectConfig.InfectTimeMin = 1
--This sets the maximum time it takes for you to turn into a zombie
InfectConfig.InfectTimeMax = 30
--Sets the infection chance for the zombie's scratch
--The chance is 1 out of -this-, so default chance is 1 out of 1, or 100%
--For a chance of 50% you'd set the variable to 2
InfectConfig.InfectScratchChance = 1
--Sets zombie to be headshot only
--The choices are true/false
InfectConfig.HeadshotOnly = false
--Sets zombie's damage
InfectConfig.ZombieDamage = 10
--Sets how often the screen ticks when infected
--This number means every -this- seconds, the screen will tick
InfectConfig.ScreenTickFreq = 0.2
--Sets how much health the zombie has
InfectConfig.Health = 150
--ON SOME POINTSHOP SERVERS WITH PLAYER CHOSEN MODELS, THE ZOMBIE WON'T APPEAR AS A ZOMBIE.
--FLIP THIS TO FIX IT, BUT BE AWARE: IT WILL MAKE CONTROLLING ZOMBIES SLIGHTLY JANKY
--DUE TO A LAG!!!!!!!!!!!
--The choices are true/false
InfectConfig.FixZombieModels = false