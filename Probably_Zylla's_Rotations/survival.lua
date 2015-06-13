-- Zylla's Survival Hunter Rotation. v1.9a
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
--Exotic Munitions?! I Gotta figure out somthing smart about that talent... Please give me some time to come up with something smart.
-- For now just use it yourself.
--
-- Recommended spec: LONE WOLF, BARRAGE,AMoC,TotH,Iron Hawk,Binding Shot,CTHC! MOAR DPS!
--
ProbablyEngine.rotation.register_custom(255, "|cff00FFFFZylla's|r - [|cff00FF96Hunter Rotation v1.9a|r]", {
      
      -- Misdirection on Focus if Toggled ON
      { "Misdirection", {
            "focus.exists",
            "toggle.misdirect",
      }, "focus" },
      { "Trap Launcher", "!player.buff(Trap Launcher)" },
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
      
      -- Pet stuff. I know it sucks but hey...
      {{
            { "Heart of the Phoenix", {
                  "pet.dead",
            }},
            { "Revive Pet", {
                  "pet.dead",     
            }},
            { "Mend Pet", { -- Mend Pet
                  "pet.health <= 75",
                  "pet.exists",
                  "!pet.dead",
                  "!pet.buff(Mend Pet)",
            }},
            { "Master's Call", "player.state.stun" },
            { "Master's Call", "player.state.root" },
            { "Master's Call", "player.state.snare" },
      }, "toggle.pet" },
      
      -- Cooldowns
      {{
            { "#Draenic Agility Potion", {
                  "toggle.flasks",
            }, "player" },
            { "#trinket1", "modifier.cooldowns" },
            { "Stampede", {
                  "talent(5,3)",
            }},
            { "Dire Beast", {
                  "talent(4,2)",
                  "player.focus < 15",
            }},
      }, "modifier.cooldowns" },
      
      -- Pause Rotation
      { "/stopattack\n/petfollow", "modifier.rshift" }, -- Pause rotation if right shift is pressed.
      { "/stopattack\n/petfollow","player.buff(Feign Death)" }, -- Pause rotation for Feign Death
      { "/stopattack\n/petfollow", "player.buff(Food)" }, -- Pause if eating,
      { "/stopattack\n/petfollow", "player.buff(Drink)" }, -- Pause if drinking
      { "/stopattack\n/petfollow", "target.state.incapacitated" }, -- Pause if target is incapacitated.      
      
      -- Interrupts and Dispells
      { "Counter Shot", {
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" },
      { "Tranquilizing Shot", {
            "target.dispellable(Tranquilizing Shot)",
            "!target.cc",
      }, "target" },
      { "Wyvern Sting", {
            "talent(2,2)",
            "player.spell(Counter Shot).cooldown",
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" },
      { "Intimidation", {
            "talent(2,3)",
            "player.spell(Counter Shot).cooldown",
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" },
      
      -- Racial traits.
      {{
            { "Every Man for Himself", "player.state.fear" },
            { "Every Man for Himself", "player.state.stun" },
            { "Every Man for Himself", "player.state.root" },
            { "Every Man for Himself", "player.state.horror" },
            { "Every Man for Himself", "player.state.charm" },
            { "Every Man for Himself", "player.state.sleep" },
            { "Every Man for Himself", "player.state.incapacitated" },
            { "Every Man for Himself", "player.state.disorient" },
            { "Every Man for Himself", "player.state.snare" },
      }, "player.spell(Every Man for Himself).exists", "player" },
      { "Stoneform", "player.spell(Stoneform).exists", "player.health <= 65" },
      { "Gift of the Naaru", "player.spell(Gift of the Naaru).exists", "player.health < 40", "player" },
      { "Will of the Forsaken", "player.spell(Will of the Forsaken).exists", "player.state.fear" },
      { "Will of the Forsaken", "player.spell(Will of the Forsaken).exists", "player.state.charm" },
      { "Will of the Forsaken", "player.spell(Will of the Forsaken).exists", "player.state.sleep" },
      { "Arcane Torrent", {
            "target.interruptAt(50)",
            "player.spell(Counter Shot).cooldown",
            "modifier.interrupts",
      }, "target" },
      { "Blood Fury", "player.spell(Blood Fury).exists", "modifier.cooldowns" },
      { "Berserking", "player.spell(Berserking).exists", "modifier.cooldowns" },
      { "Rocket Barrage", "target.range <= 28", "player.spell(Rocket Barrage).exists", "modifier.cooldowns" },
      
      -- Camouflage / PvP Mode!
      { "Camouflage", {
            "toggle.pvp",
            "player.glyph(Glyph of Camouflage)",
            "!player.buff(Camouflage)",
            "!player.debuff(Orb of Power)",
      }},
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
      
      -- Defensive Cooldowns
      { "Deterrence", "player.health < 30" },
      { "#Healthstone", "player.health < 45" },
      { "Exhilaration", "talent(3,1)", "player.health < 78" },
      { "Binding Shot", {
            "toggle.bs",
            "talent(2,1)",
            "target.range <= 15",
      }, "target.ground" },
      { "Explosive Trap", {
            "toggle.bs",
            "target.range <= 36",
      }, "target.ground" },
      
      -- Traps at your current mouseover with keybinds.
      { "Explosive Trap", "modifier.lcontrol", "mouse.ground" },
      { "Ice Trap", "modifier.lshift", "mouse.ground" },
      { "Snake Trap", "player.spell(Snake Trap).exists", "modifier.lshift", "mouse.ground" },
      { "Freezing Trap", "modifier.rcontrol", "mouse.ground" },
      { "Binding Shot", { "modifier.lalt", "talent(2,1)" }, "mouse.ground" }, 
      
      -- Rotation START
      { "Black Arrow", "!target.debuff(Black Arrow)", "target" },
      { "Concussive Shot", {
            "toggle.slow",
            "target.range < 40",
            "!target.debuff(Concussive Shot)",
      }, "target" }, -- Only if toggled ON!
      { "Explosive Shot" },
      { "A Murder of Crows", "talent(5,1)", "target" },
      -- ADVANCED AoE OR NON AoE Functions START --            
      { "Barrage", {
            "talent(6,3)",
            "target.range <= 38",
            (function() return UnitsAroundUnit('target', 35) >= 3 end),
      }, "target" },
      { "Glaive Toss", "talent(6,1)", "target" },
      { "Powershot", {                
            "talent(6,1)",
            "target.range <= 38",
            "!player.moving",
            (function() return UnitsAroundUnit('target', 15) >= 3 end),
      }, "target" }, -- Powershot!
      {{
            { "Multi-Shot", "player.buff(Thrill of the Hunt)" }, --Multi-Shot if Thrill of the Hunt is up.
            { "Multi-Shot", "!target.debuff(Serpent Sting)" }, -- Multi-shot Shot to keep Serpent Sting up.
            { "Multi-Shot", "player.focus > 60" }, -- Multi-Shot focus dump    
         }, (function() return UnitsAroundUnit('target', 8) >= 3 end), "target.range <= 38", "player" },
      {{            
            { "Arcane Shot", "player.buff(Thrill of the Hunt)" }, -- Arcane Shot if Thrill of the Hunt is up.
            { "Arcane Shot", "!target.debuff(Serpent Sting)" }, -- Arcane shot Shot to keep Serpent Sting up.
            { "Arcane Shot", "player.focus > 60" }, -- Arcane Shot focus dump    
         }, (function() return UnitsAroundUnit('target', 8) < 3 end), "target.range <= 38", "player" },
      -- ADVANCED AoE OR NON AoE Functions STOP --    
      
      { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot if player focus is lower than 60.
      { "Focusing Shot", "player.focus < 50", "talent(7,2)", "!player.moving" }, -- Focusing Shot if under 50 focus.
   },
   
   -- Out of Combat Stuff!
   {
      { "pause","player.buff(Feign Death)" },
      { "Auto Shot", "modifier.lshift", "target" },
      { "Trap Launcher", "!player.buff(Trap Launcher)" },
      {{
            { "#Hyper Augment Rune", "!player.buff(Hyper Augmentation)" },
            { "#Greater Draenic Agility Flask", {
                  "!player.buff(Whispers of Insanity",
                  "!player.buff(Greater Draenic Agility Flask)",
            }},
      }, "toggle.flasks", "player" },
   },
   
   function()
      ProbablyEngine.toggle.create(
         'pvp',
         'Interface\\Icons\\achievement_featsofstrength_gladiator_06',
         'PvP Mode.',
         'PvP Mode. Auto uses freedom trinket, Uses Camouflage if you have the glyph. And others!'
      )
      ProbablyEngine.toggle.create(
         'pet',
         'Interface\\Icons\\inv_box_petcarrier_01',
         'Pet Mode.',
         'Toggle this on if you are using a pet!'
      )
      ProbablyEngine.toggle.create(
         'autotarget',
         'Interface\\Icons\\inv_misc_spyglass_02',
         'Auto-Target.',
         'Toggle on/off auto targeting.'
      )
      ProbablyEngine.toggle.create(
         'bs',
         'Interface\\Icons\\spell_shaman_bindelemental',
         'Auto Binding Shot.',
         'Toggle on to automatically use Binding Shot, and Explosive Trap on the target location, if the enemy gets closer than 15/35 yards.'
      )
      ProbablyEngine.toggle.create(
         'misdirect',
         'Interface\\Icons\\ability_hunter_misdirection',
         'Use Misdirection on Focus target.',
         'Toggle on to automatically keep Misdirection up on your focus target.'
      )
      ProbablyEngine.toggle.create(
         'slow',
         'Interface\\Icons\\spell_frost_stun',
         'Use Concussive Shot.',
         'Toggle on to automatically use Concussive Shot, useful in PvP!'
      )
      ProbablyEngine.toggle.create(
         'flasks',
         'Interface\\Icons\\trade_alchemy_dpotion_c12',
         'Use agility flask, and potion.',
         'Toggle on to automatically use Agility flask, and the Potion. Make sure you have them!'
      )
end)