#*************************************************************************
#** 
#**  File     :  t1_bot_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Bot Hologram
#** 
#**  Copyright © 2009 
#*************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
TWalkingLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TWalkingLandUnit )

t1_bot_blip = Class(TWalkingLandUnit) {}

TypeClass = t1_bot_blip