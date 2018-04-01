#*************************************************************************
#** 
#**  File     :  t1_bomber_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Bomber Jamming Blip
#** 
#**  Copyright © 2009 4th Dimension
#*************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
TAirUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TAirUnit )

t1_bomber_blip = Class(TAirUnit) {}

TypeClass = t1_bomber_blip