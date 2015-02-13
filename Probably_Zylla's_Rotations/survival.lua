-- Zylla's Survival Hunter Rotation. v1.2a
--
-- For use with Probably Engine. A World of Warcraft Rotation Bot.
-- This "addon" uses protected LUA functions, and will need a LUA unlocker to be used.
--
-- Rotation are currently in ALPHA STAGE.
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
ProbablyEngine.rotation.register_custom(255, "Zylla's Survival Hunter Rotation v1.2a", {

      { "Trap Launcher", "!player.buff(Trap Launcher)" }, -- Make sure Trap Launcher is activated in combat.
      { "#Greater Draenic Agility Flask", {
            "!player.buff(Greater Draenic Agility Flask)",
            "toggle.flasks",
      }, "player" }, -- Check for Greater Draenic Agility Flask in combat.

      -- AutoTarget
      { "/targetenemy [noexists]", {
            "toggle.autotarget",
            "!target.exists",
      }},
      { "/targetenemy [dead]", {
            "toggle.autotarget",
            "target.exists",
            "target.dead",
      }},
      
      -- Pet stuff. I know it sucks, and Lone Wolf rocks. But i gotta give the people what they want!
      { "Heart of the Phoenix", {
            "pet.dead",
            "toggle.pet",
      }},
      { "Revive Pet", {
            "pet.dead",
            "toggle.pet",        
      }},
      { "Mend Pet", { -- Mend Pet
            "toggle.pet",
            "pet.health <= 75",
            "pet.exists",
            "!pet.dead",
            "!pet.buff(Mend Pet)",
      }},
      { "Master's Call", "toggle.pet", "player.state.stun" },
      { "Master's Call", "toggle.pet", "player.state.root" },
      { "Master's Call", "toggle.pet", "player.state.snare" },
      
      -- Cooldowns
      { "#Draenic Agility Potion", {
            "modifier.cooldowns",
            "toggle.flasks",
      }, "player" }, -- Use Draenic Agility Potion with cooldowns
      { "#trinket1", "modifier.cooldowns" }, -- Sets the first trinket as a cooldown. In case it has a use effect.
      { "Stampede", {
            "player.spell(Stampede).exists",
            "modifier.cooldowns",
      }}, -- Stampede
      { "Dire Beast", {
            "player.spell(Dire Beast).exists",
            "player.focus < 15",
            "modifier.cooldowns"
      }}, -- Use Dire Beast if player focus is lower than 15.

      
      -- Pause Rotation
      { "/stopattack\n/petfollow", "modifier.rshift" }, -- Pause rotation if right shift is pressed.
      { "/stopattack\n/petfollow","player.buff(Feign Death)" }, -- Pause rotation for Feign Death
      { "/stopattack\n/petfollow", "player.buff(Food)", }, -- Pause if eating,
      { "/stopattack\n/petfollow", "player.buff(Drink)", }, -- Pause if drinking
      { "/stopattack\n/petfollow", "target.state.root", }, -- Pause if target is rooted.
      { "/stopattack\n/petfollow", "target.state.snare", }, -- Pause if target is snared.
      { "/stopattack\n/petfollow", "target.state.incapacitated", }, -- Pause if target is incapacitated.      
      
      -- Interrupts and Dispells
      { "Counter Shot", {
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" }, -- Counter Shot at 50% cast time left
      { "Tranquilizing Shot", {
            "target.dispellable(Tranquilizing Shot)",
            "!target.state.charm",
            "!player.state.sleep",
            "!player.state.incapacitated",
            "!player.state.disorient",
      }, "target" },
      { "Wyvern Sting", {
            "player.spell(Wyvern Sting).exists",
            "player.spell(Counter Shot).cooldown",
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" }, -- Wyvern Sting at 50% cast time left, if Counter Shot is on cooldown.
      { "Intimidation", {
            "player.spell(Intimidation).exists",
            "player.spell(Counter Shot).cooldown",
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" }, -- Intimidation at 50% cast time left, if Counter Shot is on cooldown.
      
      -- Racials
      { "Stoneform", "player.health < 65" },
      { "Every Man for Himself", "player.state.charm" },
      { "Every Man for Himself", "player.state.fear" },
      { "Every Man for Himself", "player.state.incapacitate" },
      { "Every Man for Himself", "player.state.sleep" },
      { "Every Man for Himself", "player.state.stun" },
      { "Gift of the Naaru", "player.health < 40", "player" },
      { "Escape Artist", "player.state.root" },
      { "Escape Artist", "player.state.snare" },
      { "Will of the Forsaken", "player.state.fear" },
      { "Will of the Forsaken", "player.state.charm" },
      { "Will of the Forsaken", "player.state.sleep" },

      -- PvP Mode
      { "Camouflage", {
            "toggle.pvp",
            "player.glyph(Glyph of Camouflage)",
            "!player.buff(Camouflage)",
            "!player.debuff(Orb of Power)",
      }},

      { "#trinket1", "modifier.cooldowns","toggle.pvp" }, -- Set PvP Conquest agility use trinket as a cooldown.
      { "#trinket2", { "player.state.fear", "toggle.pvp" }, "player" }, -- Use PvP Trinket if player is feared.
      { "#trinket2", { "player.state.stun", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is stunned.
      { "#trinket2", { "player.state.root", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is rooted.
      { "#trinket2", { "player.state.horror", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is horrified.
      { "#trinket2", { "player.state.charm", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is charmed
      { "#trinket2", { "player.state.sleep", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is sleeping.
      { "#trinket2", { "player.state.incapacitated", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is incapacitated.
      { "#trinket2", { "player.state.disorient", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is disoriented..
      { "#trinket2", { "player.state.snare", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is snared.
      
      -- Defensive Cooldowns
      { "Deterrence", "player.health < 30" }, -- Deterrence if HP is under 30%
      { "#5512", "player.health < 45" }, -- Healthstone if HP is under 45%
      { "Exhilaration", "player.health < 78" }, -- Exhilaration if HP is under 78%
      { "Binding Shot", {
            "toggle.bs",
            "player.spell(Binding Shot).exists",
            "target.range <= 15",
      }, "target.ground" }, -- Auto binding shot if closer than 15 yards. (Might not work! Just testing it out!)
    
      -- Trap at your current mouseover with keybinds
      { "Explosive Trap", "modifier.lcontrol", "mouse.ground" }, -- Explosive Trap on ground if left control is pressed.
      { "Ice Trap", "modifier.lshift", "mouse.ground" }, -- Ice Trap on mouseover if left shift is pressed.
      { "Snake Trap", "player.spell(Snake Trap).exists", "modifier.lshift", "mouse.ground" }, -- Ice Trap on mouseover if left shift is pressed.
      { "Freezing Trap", "modifier.rcontrol", "mouse.ground" }, -- Freezing Trap on mouseover if right control is pressed.
      { "Binding Shot", "modifier.lalt", "mouse.ground" }, -- Binding Shot on mouseover if left alt is pressed.
      
      -- Multi-target Rotation
      {{            
            -- If there are more than 5 units/enemies.
            {{
                  { "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
                  { "Explosive Shot", "player.buff(Lock and Load)" }, -- Explosive Shot when Lock and Load is up.
                  { "A Murder of Crows", "player.spell(A Murder of Crows).exists" }, -- Use A Murder of Crows.                  
                  { "Barrage", "player.spell(Barrage).exists" }, -- Barrage!
                  { "Glaive Toss", "player.spell(Glaive Toss).exists" }, -- Glaive Toss!
                  { "Multi-Shot", "player.buff(Thrill of the Hunt)" }, --Multi-Shot if Thrill of the Hunt is up.
                  { "Multi-Shot", "!target.debuff(Serpent Sting)" }, -- Multi-shot Shot to keep Serpent Sting up.
                  { "Multi-Shot", "player.focus > 50" }, -- Multi-Shot focus dump
                  { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot.
                  { "Focusing Shot", "player.focus < 50" }, -- Focusing Shot if under 50 focus.
               }, { (function() return UnitsAroundUnit('target', 8) >= 5 end) },
            },
            -- If there are between 2-4 units/enemies.
            { "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
            { "Explosive Shot" }, -- Explosive Shot.
            { "A Murder of Crows", "player.spell(A Murder of Crows).exists" }, -- Use A Murder of Crows.
            { "Barrage", "player.spell(Barrage).exists" }, -- Barrage!
            { "Glaive Toss", "player.spell(Glaive Toss).exists" }, -- Glaive Toss!
            { "Multi-Shot", "player.buff(Thrill of the Hunt)" }, --Multi-Shot if Thrill of the Hunt is up.
            { "Multi-Shot", "!target.debuff(Serpent Sting)" }, -- Multi-shot Shot to keep Serpent Sting up.
            { "Multi-Shot", "player.focus > 60" }, -- Multi-Shot focus dump
            { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot.
            { "Focusing Shot", "player.focus < 50" }, -- Focusing Shot if under 50 focus.
      } , "modifier.multitarget" },
      -- Single Target Rotation!
      {{
            { "Black Arrow", "!target.debuff(Black Arrow)" }, -- Black Arrow
            { "Explosive Shot"}, -- Explosive Shot.
            { "A Murder of Crows", "player.spell(A Murder of Crows).exists" }, -- Use A Murder of Crows.
            { "Arcane Shot", "player.buff(Thrill of the Hunt)" }, -- Arcane Shot if Thrill of the Hunt is up.
            { "Arcane Shot", "!target.debuff(Serpent Sting)" }, -- Arcane shot Shot to keep Serpent Sting up.
            { "Cobra Shot", "player.focus < 60" }, -- Cobra Shot if player focus is lower than 60.
            { "Focusing Shot", "player.focus < 50" }, -- Focusing Shot if under 50 focus.
      } , "!modifier.multitarget" },
   },
   
   -- Out of Combat Stuff!
   {
      { "pause","player.buff(Feign Death)" }, -- Pause for Feign Death 
      { "Auto Shot", "modifier.lshift", "target" }, -- Press Left Shift while out of combat to Auto Shot your current target!
      { "Trap Launcher", "!player.buff(Trap Launcher)" }, -- Make sure Trap Launcher is activated while out of combat.
      { "#Greater Draenic Agility Flask", {
            "!player.buff(Greater Draenic Agility Flask)",
            "toggle.flasks",
      }, "player" }, -- Check for Greater Draenic Agility Flask out of combat.
      -- AutoTarget while OOC
      { "/targetenemy [noexists]", {
            "toggle.autotarget",
            "!target.exists",
      }},
      { "/targetenemy [dead]", {
            "toggle.autotarget",
            "target.exists",
            "target.dead",
      }},
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
         'Toggle on to automatically use Binding Shot on the target location, if the enemy gets closer than 15 yards.'
      )
      ProbablyEngine.toggle.create(
         'flasks',
         'Interface\\Icons\\trade_alchemy_dpotion_c12',
         'Use agility flask, and potion.',
         'Toggle on to automatically use Agility flask, and the Potion. Make sure you have them!'
      )
end)