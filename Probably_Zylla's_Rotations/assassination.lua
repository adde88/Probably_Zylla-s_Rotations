-- Zylla's Survival Hunter Rotation. v1.2a
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
ProbablyEngine.rotation.register_custom(259, "Zylla's Assassination Rotation v1.0a", {
      
      -- Potion Check in Combat, just in case!
      { "Deadly Poison", "!player.buff(Deadly Poison)" }, 
      { "Leeching Poison", {
            "!player.buff(Leeching Poison)",
            "player.spell(Leeching Poison).exists",
      }},
      { "Crippling Poison", {
            "!player.buff(Crippling Poison)",
            "!player.spell(Leeching Poison).exists",
      }},
      
      -- Keybinds
      { "Throw", { "modifier.lshift" }, "target" },
      { "pause", "modifier.lcontrol" },
      { "Shadowstep", "modifier.lalt" },
      

      -- Check for Greater Draenic Agility Flask in combat.
      { "#Greater Draenic Agility Flask", {
            "!player.buff(Greater Draenic Agility Flask)",
            "toggle.flasks",
      }, "player" },

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

      -- Survival
      { "Recuperate", {
            "player.health < 60",
            "player.combopoints = 5",
            "target.debuff(Rupture).duration > 8",
            "player.buff(Recuperate).duration < 10",
            "!toggle.noheal",
      }},
      { "Evasion", "player.health < 75" },
      { "Combat Readiness", "player.health < 75" },
      { "#Healthstone", { "player.health < 45" }, "player" }, -- Healthstone below 45% HP
      { "Vanish", {
            "player.health < 20",
            "toggle.pvp",
      }, "player" }, -- Vanish below 20% HP in PvP
      { "Shiv", {
            "target.dispellable(Shiv)",
            "!target.state.charm",
            "!target.state.sleep",
            "!target.state.incapacitated",
            "!target.state.disorient",
      }, "target" },
      { "Feint", {
            "toggle.feint",
            "!player.buff(Feint)",
      }, "player" }, -- Keep Feint up at all times in combat, if toggled on! (Elusiveness?)
      
      -- PvP Freedom Trinket
      { "#trinket2", { "player.state.fear", "toggle.pvp" }, "player" }, -- Use PvP Trinket if player is feared.
      { "#trinket2", { "player.state.stun", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is stunned.
      { "#trinket2", { "player.state.root", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is rooted.
      { "#trinket2", { "player.state.horror", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is horrified.
      { "#trinket2", { "player.state.charm", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is charmed
      { "#trinket2", { "player.state.sleep", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is sleeping.
      { "#trinket2", { "player.state.incapacitated", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is incapacitated.
      { "#trinket2", { "player.state.disorient", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is disoriented..
      { "#trinket2", { "player.state.snare", "toggle.pvp" }, "player" },    -- Use PvP Trinket if player is snared.
      
      -- Interrupts
      { "Kick", {
            "target.interruptAt(50)",
            "modifier.interrupts",
      }, "target" },
      { "Gouge", {
            "target.interruptAt(50)",
            "player.spell(Kick).cooldown",
            "modifier.interrupts",
            "toggle.pvp",
      }, "target" },
      { "Kidney Shot", {
            "target.interruptAt(50)",
            "player.combopoints > 0",
            "player.spell(Kick).cooldown",
            "player.spell(Gouge).cooldown",
            "modifier.interrupts",
            "toggle.pvp",
      }, "target" },
      { "Blind", {
            "target.interruptAt(50)",
            "player.spell(Kick).cooldown",
            "player.spell(Gouge).cooldown",
            "player.spell(Kidney Shot).cooldown",
            "modifier.interrupts",
            "toggle.pvp",
      }, "target" },
      { "Vanish", {
            "target.interruptAt(50)",
            "player.spell(Kick).cooldown",
            "player.spell(Gouge).cooldown",
            "player.spell(Kidney Shot).cooldown",
            "player.spell(Blind).cooldown",
            "modifier.interrupts",
            "toggle.pvp",
      }, "target" },
      
      -- Cooldowns
      { "#Draenic Agility Potion", {
            "player.combopoints = 5",
            "modifier.cooldowns",
            "toggle.flasks",
      }, "player" }, -- Use Draenic Agility Potion with cooldowns
      { "#trinket1", {
            "player.combopoints = 5",
            "modifier.cooldowns",
      }, "player" }, -- Use the first trinket together with cooldowns!
      { "Shadow Reflection", {
            "player.combopoints = 5",
            "modifier.cooldowns",
      }, "target" },
      { "Vendetta", {
            "player.combopoints = 5",
            "target.debuff(Shadow Reflection)",
            "modifier.cooldowns",
      }, "target" },
      --[[
      { "Vendetta", {
            "player.combopoints = 5",
            "!player.spell(Shadow Reflection).exists",
            "modifier.cooldowns",
      }, "target" },
      --]]
      
      -- Multi-target rotation
      {{            
            -- If there are more than 5 units/enemies.
            {{
                  { "Fan of Knives", "player.combopoints < 5" },
                  { "Crimson Tempest", "player.combopoints = 5" },
               }, { (function() return UnitsAroundUnit('player', 9) >= 5 end) },
            },
            -- If there are between 2-4 units/enemies.
            { "Mutilate", "target.health > 35", },
            { "Dispatch", "player.buff(Blindside)" },
            { "Rupture", { 
                  "target.debuff(Rupture).duration < 8", 
                  "player.combopoints = 5",
            }},
            { "Envenom", "player.combopoints = 5" },
            { "Dispatch", "target.health < 35" },
            
      } , "modifier.multitarget" },
      
      -- Single Target Rotation!
      {{
            { "Mutilate", "target.health > 35" },
            { "Dispatch", "player.buff(Blindside)" },
            { "Rupture", { 
                  "target.debuff(Rupture).duration <= 8", 
                  "player.combopoints = 5",
            }},
            { "Envenom", "player.combopoints = 5" },
            { "Dispatch", "target.health < 35" },
            
      } , "!modifier.multitarget" },
   },
   
   -- Out of Combat
   {
      { "Deadly Poison", "!player.buff(Deadly Poison)" }, 
      { "Leeching Poison", {
            "!player.buff(Leeching Poison)",
            "player.spell(Leeching Poison).exists",
      }},
      { "Crippling Poison", {
            "!player.buff(Crippling Poison)",
            "!player.spell(Leeching Poison).exists",
      }},
      { "Throw", { "modifier.lshift" }, "target" },
      { "#Greater Draenic Agility Flask", {
            "!player.buff(Greater Draenic Agility Flask)",
            "toggle.flasks",
      }, "player" }, -- Check for Greater Draenic Agility Flask out of combat.

      -- Opener
      { "Stealth", {
            "target.enemy",
            "!player.buff(Stealth)",
      }},
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
            'flasks',
            'Interface\\Icons\\trade_alchemy_dpotion_c12',
            'Use Agi. Flask, and Agi. Potion.',
            'Toggle on to automatically use Agility flask, and the Potion. Make sure you have them!'
      )      
end)