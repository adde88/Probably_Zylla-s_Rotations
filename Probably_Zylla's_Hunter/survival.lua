-- Zylla's Survival Hunter Rotation. v1.0a
--
-- For use with Probably Engine. A World of Warcraft Rotation Bot.
-- This "addon" uses protected LUA functions, and will need a LUA unlocker to be used.
--
-- Rotation is currently in ALPHA STAGE.
-- I'm a new developer, who is working on several rotations, and different LUA scripts.
-- As i am new to the LUA scene, and i'm still learning, there will most likely exist bugs, and things that can be improved upon.
-- That's where YOU come in the picture!
-- I would appreciate it if you told me all about these bugs so i can fix them. And please give me feedback on the rotations!
--
-- Zylla / adde88 @ OwnedCore forums.
-- http://www.ownedcore.com/forums/members/379314-adde88.html
--
ProbablyEngine.rotation.register_custom(255, "Zylla's Survival Hunter Rotation v1.0a", {

	-- Cooldowns
	{ "#115749", "modifier.cooldowns" }, -- Set PvP Conquest agility use trinket as a cooldown.
	
	-- Buffs!
	{ "Lone Wolf: Quickness of the Dragonhawk", "!player.buff(Lone Wolf: Quickness of the Dragonhawk)" }, -- Make sure that Lone Wolf: Multistrike is up!
	{ "Trap Launcher", "!player.buff(Trap Launcher)" }, -- Make sure Trap Launcher is activated.
	
    -- Pause Rotation
    { "pause", "modifier.rshift" }, -- Pause rotation if right shift is pressed.
    { "pause","player.buff(Feign Death)" }, -- Pause rotation for Feign Death
	
    -- Interrupts
    { "Counter Shot", "target.interruptAt(85)", "modifier.interrupts" }, -- Counter Shot at 15% cast time left
	{ "Tranquilizing Shot", { "target.dispellable(Tranquilizing Shot)", "!target.charmed", "!target.state.charm", "!target.debuff(Touch of Y'Shaarj)", "!target.debuff(Empowered Touch of Y'Shaarj)", "!target.buff(Touch of Y'Shaarj)", "!target.buff(Empowered Touch of Y'Shaarj)" }, "target" },
      
    -- Defensive Cooldowns
	{ "#115156", "player.state.fear" }, -- Use PvP Trinket if player is feared.
	{ "#115156", "player.state.stun" },	-- Use PvP Trinket if player is stunned.
	{ "#115156", "player.state.root" },	-- Use PvP Trinket if player is rooted.
	{ "#115156", "player.state.horror" },	-- Use PvP Trinket if player is horrified.
	{ "Deterrence", "player.health < 30" }, -- Deterrence if HP is under 30%
	{ "Gift of the Naaru", "player.health < 40" }, -- Gift of the Naaru if HP is under 40%
	{ "#5512", "player.health < 45" }, -- Healthstone if HP is under 45%
     
    -- Traps
    { "Explosive Trap", "modifier.lcontrol", "mouse.ground" }, -- Explosive Trap on mouseover if left control is pressed.
    { "Ice Trap", "modifier.lshift", "mouse.ground" }, -- Ice Trap on mouseover if left shift is pressed.
    { "Freezing Trap", "modifier.rcontrol", "mouse.ground" }, -- Freezing Trap on mouseover if right control is pressed.
    { "Binding Shot", "modifier.lalt", "mouse.ground" }, -- Binding Shot on mouseover if left alt is pressed.

	-- Crowd Control your focus target!
	{ "Freezing Trap", { "focus.exists", "focus.debuff(Freezing Trap).duration < 10" }, "focus.ground" },
	
    -- Multi-target Rotation
    {{            
        -- If there are more than 5 units/enemies.
        {{
            { "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
            { "Explosive Shot", "player.buff(Lock and Load)" }, -- Explosive Shot when Lock and Load is up.
            { "A Murder of Crows"}, -- Use A Murder of Crows.
            { "Barrage"}, -- Barrage!
            { "Multi-Shot", "!target.debuff(Serpent Sting)" }, -- Multi-shot Shot to keep Serpent Sting up.
            { "Multi-Shot", "player.focus > 50" }, -- Multi-Shot focus dump
            { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot.
                  
            }, { (function() return UnitsAroundUnit('target', 8) >= 5 end) },
        },
        -- If there are between 2-4 units/enemies.
			{ "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
            { "Explosive Shot", "player.buff(Lock and Load)" }, -- Explosive Shot when Lock and Load is up.
            { "A Murder of Crows"}, -- Use A Murder of Crows.
            { "Barrage"}, -- Barrage!
            { "Multi-Shot", "!target.debuff(Serpent Sting)" }, -- Multi-shot Shot to keep Serpent Sting up.
            { "Multi-Shot", "player.focus > 60" }, -- Multi-Shot focus dump
            { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot.
            
	} , "modifier.multitarget" },
    -- Single Target Rotation!
    {{
		{ "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
		{ "Explosive Shot"}, -- Explosive Shot.
		{ "A Murder of Crows"}, -- Use A Murder of Crows.
		{ "Barrage"}, -- Barrage!
		{ "Arcane Shot", "player.buff(Thrill of the Hunt)" }, -- Arcane Shot if Thrill of the Hunt is up.
		{ "Cobra Shot", "player.focus < 60" }, -- Cobra Shot if player focus is lower than 60.
	
    } , "!modifier.multitarget" },
},
   
   -- Out of Combat
{
    { "pause","player.buff(Feign Death)" }, -- Pause for Feign Death      
})