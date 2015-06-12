-- Zylla's Survival Hunter Rotation. v1.9a
--
-- For use with Probably Engine. A World of Warcraft Rotation Bot.
-- This "addon" uses protected LUA functions, and will need a LUA unlocker to be used.
--
-- Rotations are currently in ALPHA STAGE.
-- I'm a new developer, who is working on several rotations, and different LUA scripts.
-- As i am new to the LUA scene, and i'm still learning, there will most likely exist bugs, and things that can be improved upon.
-- That's where YOU come in the picture!
-- I would appreciate it if you told me all about these bugs so i can fix them. And please give me feedback on the rotations!
--
-- Zylla / adde88 @ OwnedCore forums.
-- http://www.ownedcore.com/forums/members/379314-adde88.html
--
-- Recommended spec: SF, CR, LP, Shadowstep, IB, Anticipation, Shadow Reflection, MOAR DPS!
--
ProbablyEngine.rotation.register_custom(259, "|cff00FFFFZylla's|r - [|cff00FF96Assassination v1.9a|r]", {
      
      -- Tricks of the Trade on FOCUS
      { "Tricks of the Trade", {
            "focus.exists",
            "toggle.tricks",
      }, "focus" },
      
      -- Potion Check in Combat, just in case!
      { "Deadly Poison", "!player.buff(Deadly Poison)" }, 
      { "Leeching Poison", {
            "!player.buff(Leeching Poison)",
            "talent(3,2)",
      }},
      { "Crippling Poison", {
            "!player.buff(Crippling Poison)",
            "!talent(3,2)",
      }},
      
      -- Keybinds
      { "Throw", { "modifier.lshift" }, "target" },
      { "pause", "modifier.lcontrol" },
      { "Shadowstep", "modifier.lalt" },
      
      -- Check for Greater Draenic Agility Flask, Potions and Runes in combat.
      {{
            { "#Hyper Augment Rune", "!player.buff(Hyper Augmentation)" },
            { "#Greater Draenic Agility Flask", {
                  "!player.buff(Whispers of Insanity",
                  "!player.buff(Greater Draenic Agility Flask)",
            }},
      }, "toggle.flasks", "player" },
      
      -- Auto Target if toggled ON
      {{
            { "/targetenemy [noexists]" },
            { "/targetenemy [dead]", "target.dead" },
      }, "toggle.autotarget", "target.exists" },
      
      -- Survival
      { "Recuperate", {
            "player.health < 60",
            "player.combopoints = 5",
            "target.debuff(Rupture).duration > 8",
            "player.buff(Recuperate).duration < 10",
            "!toggle.noheal",
      }},
      { "Evasion", "player.health <= 75" },
      { "Combat Readiness", "player.health <= 75" },
      { "#Healthstone", { "player.health <= 45" }, "player" }, -- Healthstone below 45% HP
      { "Vanish", {
            "player.health <= 20",
            "toggle.pvp",
      }, "player" }, -- Vanish below 20% HP in PvP
      { "Shiv", {
            "target.dispellable(Shiv)",
            "!target.cc",
      }, "target" },
      { "Feint", {
            "toggle.feint",
            "!player.buff(Feint)",
      }, "player" }, -- Keep Feint up at all times in combat, if toggled on! (Elusiveness recommended)
      
      {{ -- PvP Trinket
            { "#trinket2", "player.state.fear" }, -- Fear.
            { "#trinket2", "player.state.stun" },    -- Stun.
            { "#trinket2", "player.state.root" },    -- Root.
            { "#trinket2", "player.state.horror" },    -- Horrify.
            { "#trinket2", "player.state.charm" },    -- Charm.
            { "#trinket2", "player.state.sleep" },    -- Sleep.
            { "#trinket2", "player.state.incapacitated" },    -- Incapacitation.
            { "#trinket2", "player.state.disorient" },    -- Disorient
            { "#trinket2", "player.state.snare" },    -- Snare.
      }, "toggle.pvp", "player" },
      
      -- Interrupts
      { "Kick", "target.interruptAt(50)", "modifier.interrupts", "target" },
	  { "Deadly Throw", {
		"player.combopoints > 4",
		"talent(2,1)",
		"target.range < 28",
		"target.interruptAt(50)",
		"modifier.interrupts",
	  }, "target" },
      {{
            { "Gouge", {
                  "player.spell(Kick).cooldown",
            }, "target" },
            { "Kidney Shot", {
                  "player.combopoints > 0",
                  "player.spell(Kick).cooldown",
                  "player.spell(Gouge).cooldown",
            }, "target" },
            { "Blind", {
                  "player.spell(Kick).cooldown",
                  "player.spell(Gouge).cooldown",
                  "player.spell(Kidney Shot).cooldown",
            }, "target" },
      }, "modifier.interrupts", "target.interruptAt(50)", "toggle.pvp" },
      
      -- Cooldowns
      {{
            { "#Draenic Agility Potion", {
                  "player.combopoints = 5",
                  "toggle.flasks",
            }, "player" },
            { "#trinket1", {
                  "player.combopoints = 5",
            }, "player" },
            { "Shadow Reflection", {
                  "player.combopoints = 5",
				  "talent(7,2)",
            }, "target" },
            { "Vendetta", {
                  "player.combopoints = 5",
                  "target.debuff(Shadow Reflection)",
            }, "target" },
			{ "Vendetta", {
                  "player.combopoints = 5",
                  "!talent(7,2)",
            }, "target" },
			{ "Marked for Death", {
				"talent(6,2)",
				"player.combopoints < 1",
			}, "target" },
      }, "modifier.cooldowns" },
      
      -- Multi-target rotation
      {{
            { "Fan of Knives", "player.combopoints < 5" },
            { "Crimson Tempest", "player.combopoints = 5" },
         }, (function() return UnitsAroundUnit('player', 9) >= 5 end), },
      
      -- Standard Rotation!
      {{
            { "Mutilate", "target.health > 35" },
            { "Dispatch", "player.buff(Blindside)" },
            { "Rupture", { 
                  "target.debuff(Rupture).duration <= 8", 
                  "player.combopoints = 5",
            }},
            { "Envenom", "player.combopoints = 5" },
			{ "Death from Above", "talent(7,3)", "player.combopoints = 5" },
            { "Dispatch", "target.health < 35" },
			{ "Deadly Throw", {
					"player.combopoints > 0",
					"talent(2,1)",
					"target.range < 28",
					"target.range > 8",
			}, "target" },
			{ "Shuriken Toss", {
					"talent(6,1)",
					"target.range < 29",
					"target.range > 8",
			}, "target" },
         }, (function() return UnitsAroundUnit('player', 9) <= 4 end), },
   },
   
   -- Out of Combat
   {
      { "Deadly Poison", "!player.buff(Deadly Poison)" }, 
      { "Leeching Poison", {
            "!player.buff(Leeching Poison)",
            "talent(3,2)",
      }},
      { "Crippling Poison", {
            "!player.buff(Crippling Poison)",
            "!talent(3,2)",
      }},
      { "Throw", "modifier.lshift", "target" },
      {{
            { "#Hyper Augment Rune", "!player.buff(Hyper Augmentation)" },
            { "#Greater Draenic Agility Flask", {
                  "!player.buff(Whispers of Insanity",
                  "!player.buff(Greater Draenic Agility Flask)",
            }},
      }, "toggle.flasks", "player" },
      
      -- Opener
      { "Stealth", "!player.buff(Stealth)", "player" },
      { "Ambush", {
            "target.enemy",
            "target.range <= 5",
            "player.buff(Stealth)",
      }, "target" },
   },
   
   -- CUSTOM CODE RUN ONCE
   function()
      ProbablyEngine.toggle.create(
         'pvp',
         'Interface\\Icons\\achievement_featsofstrength_gladiator_06',
         'PvP Mode',
         'Automatically use the PvP Freedom Trinket. Put it as second trinket!'
      )
      ProbablyEngine.toggle.create(
         'noheal',
         'Interface\\Icons\\spell_holy_heal',
         'No Recuperate',
         'Never use Recuperate. Toggle this on when you have a healer with you!'
      )
      ProbablyEngine.toggle.create(
         'autotarget',
         'Interface\\Icons\\inv_misc_spyglass_02',
         'Auto-Target.',
         'Toggle on/off auto targeting.'
      )
      ProbablyEngine.toggle.create(
         'feint',
         'Interface\\Icons\\ability_rogue_feint',
         'Keep feint up.',
         'Toggle on to automatically keep Feint up. Useful if you have the Elusiveness talent!'
      )
      ProbablyEngine.toggle.create(
         'tricks',
         'Interface\\Icons\\ability_rogue_tricksofthetrade',
         'Use Tricks of the Trade on Focus target.',
         'Toggle on to automatically keep Tricks of the Trade up on your focus target.'
      )
      ProbablyEngine.toggle.create(
         'flasks',
         'Interface\\Icons\\trade_alchemy_dpotion_c12',
         'Use Agi. Flask, and Agi. Potion.',
         'Toggle on to automatically use Agility flask, and the Potion. Make sure you have them!'
      )      
end)