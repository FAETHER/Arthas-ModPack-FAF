#*************************************************************************
#** 
#**  File     :  t1_fighter_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Fighter Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
TAirUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TAirUnit )

t1_fighter_blip = Class(TAirUnit) {}

TypeClass = t1_fighter_blip