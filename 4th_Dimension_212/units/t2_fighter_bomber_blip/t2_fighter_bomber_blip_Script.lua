#*************************************************************************
#** 
#**  File     :  t2_fighter_bomber_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T2 Fighter / Bomber Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
TAirUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TAirUnit )

t2_fighter_bomber_blip = Class(TAirUnit) {}

TypeClass = t2_fighter_bomber_blip