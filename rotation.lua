ProbablyEngine.library.register('coreHealing', {
   needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(105, "Repaired's Resto Druid", {

--Incarnation Modifier
 { "Incarnation: Tree of Life", "modifier.rshift" },
 
--Tranquility Modifier
 { "Tranquility", "modifier.rcontrol" },
 
--Genesis
 { "Genesis", "modifier.lcontrol" },
 
--Shrooms
 { "Wild Mushroom", "modifier.lalt", "ground" },
 { "Wild Mushroom: Bloom", "modifier.ralt" },
 
--Innervate
 { "Innervate", "player.mana <= 75", "player" },
 
--Rebirth MouseOver
 { "Rebirth", "!mouseover.alive", "mouseover" },
 
---------INCARNATION!---------
--Regrowth
 { "Regrowth", {
   "player.buff(33891)",
   "lowest.health <= 80",
   "!lowest.range > 40"
 }, "lowest" },

--Wildgrowth
 { "48438", {
   "player.buff(33891)",
   "@coreHealing.needsHealing(90, 3)",
   "!lowest.range > 40"
 }, "lowest" },
 
--Mmm Dat Lifebloom Spam
 { "33763", {
   "player.buff(33891)",
   "lowest.health < 99",
   "lowest.buff(33763).count < 3",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "33763", {
   "player.buff(33891)",
   "lowest.buff(33763).duration <= 2",
   "!lowest.range > 40"
 }, "lowest" },
 
-------------------------------

--JK shit still needs to get implemented
--OH SHIT INSANT TANK REBIRTH
 
-- { "Rebirth", {
--   "player.buff(132158)",
--   "!tank.alive",
--   "!tank.range > 40"
-- }, "tank" },

-- { "Nature's Swiftness", {
--   "!tank.alive",
--   "!tank.range > 40"
-- }, "tank" },

 
--Or... Not instant if player does not have Nature's Swiftness

-- { "Rebirth", {
--   "!player.buff(Nature's Swiftness)",
--   "!tank.alive",
--   "!tank.range > 40"
-- }, "tank" },
 
--Shit shit shit fuck shit shit 
--Dicorienting Roar, Barkskin, Ursoc, Renewal, Ironbark, Cenarion ward SELF!

 { "Disorienting Roar", "target.threat >= 40" },
 
 { "Barkskin", "player.health <= 60" },
 
 { "Might of Ursoc", "player.health < 30" },
 { "/cancelform", "player.buff(Might of Ursoc)" },
 
 { "Renewal", "player.health <= 30", "player" },
 
 { "Ironbark", "player.health < 55", "player" },
 
 { "102351", "player.health < 50", "player" },
 
 
--Nature's Swiftness 
 { "Nature's Swiftness", {
   "lowest.health < 30",
   "!lowest.range > 40"
 }, "lowest" },

--Healing Touch with NS. BOOM HEALZ SON!
 { "Healing Touch", {
   "player.buff(Nature's Swiftness)",
   "lowest.health < 30",
   "!lowest.range > 40"
 }, "lowest" },

--Iron Bark for Tank
 { "Ironbark", {
   "tank.health < 65",
   "!tank.range > 40"
 }, "tank" },
 
--Cenarion Ward for Tank
 { "102351", {
   "tank.health < 70", 
   "!tank.range > 40"
 }, "tank" },
 
--Tank Rejuvenation
 { "Rejuvenation", {
   "tank.health <= 99",
   "!tank.buff(Rejuvenation)",
   "!tank.range > 40"
 }, "tank" },
 
--Life Bloom Tank
 { "33763", {
   "tank.buff(33763).count < 3",
   "!tank.range > 40"
 }, "tank" },
 
 { "33763", {
   "tank.buff(33763).duration < 2",
   "!tank.range > 40"
 }, "tank" },
   
--Rejuvenation
 { "Rejuvenation", {
   "lowest.health <= 85",
   "!lowest.buff(Rejuvenation)",
   "!lowest.range > 40"
 }, "lowest" },
 
--Swiftmend
 { "Swiftmend", {
   "lowest.buff(Rejuvenation)",
   "lowest.health <= 75",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "Swiftmend", {
   "lowest.buff(Regrowth)",
   "lowest.health <= 75",
   "!lowest.range > 40"
 }, "lowest" },
 
--Regrowth
 { "Regrowth", {
   "lowest.health <= 55",
   "!lowest.range > 40"
 }, "lowest" },
 
--Regrowth Clearcasting
 { "Regrowth", { 
   "player.buff(16870)", 
   "lowest.health < 60",
   "!lowest.range > 40"
 }, "lowest" },
 
--Dat Tranq 
 { "Tranquility", {
   "@coreHealing.needsHealing(60, 3)",
   "!lowest.range > 40"
 }, "lowest" },
 
--Wildgrowth
 { "48438", {
   "@coreHealing.needsHealing(90, 3)",
   "!lowest.range > 40"
 }, "lowest" },
 
--Healing Touch
 { "Healing Touch", {
   "lowest.health < 60",
   "!lowest.range > 40"
 }, "lowest" },

--Healing Touch (Clearcasting)
 { "Healing Touch", {
   "player.buff(16870)",
   "lowest.health <= 75",
   "!lowest.range > 40"
 }, "lowest" },

}, {

-----------------------------------
--| Out of Combat Healing/Buffing |--
-----------------------------------
--MOTW
 { "Mark of the Wild", "!player.buff(Mark of the Wild)" },
 
--Shrooms
 { "Wild Mushroom", "modifier.lalt", "ground" },
 { "Wild Mushroom: Bloom", "modifier.ralt" },
 
--Rejuve, Swiftmend, Regrowth, Healing Touch, Wild Growth,
--and *Constant Lifebloom on tank* if you're into that

 { "Rejuvenation", {
   "lowest.health < 80",
   "!lowest.buff(Rejuvenation)",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "Swiftmend", {
   "lowest.buff(Rejuvenation)",
   "lowest.health <= 70",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "Regrowth", {
   "lowest.health < 40",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "Healing Touch", {
   "lowest.health < 60",
   "!lowest.range > 40"
 }, "lowest" },
 
 { "48438", {
   "@coreHealing.needsHealing(95, 3)",
   "!lowest.range > 40"
 }, "lowest" },

---MMM Constant HoTs on Tank
 { "33763", {
   "tank.buff(33763).count < 3",
   "!tank.range > 40"
 }, "tank" },
 
 { "33763", {
   "tank.buff(33763).duration <= 2",
   "!tank.range > 40"
 }, "tank" },
  
}) --fuck yeah rdruid
