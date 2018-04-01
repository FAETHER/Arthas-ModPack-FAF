#*************************************************************************
#** 
#**  File     :  t2_gatling_bot_blip_Script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T2 Gat Bot Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
TWalkingLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TWalkingLandUnit )

t2_gatling_bot_blip = Class(TWalkingLandUnit) {}

TypeClass = t2_gatling_bot_blip