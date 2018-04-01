#*************************************************************************
#** 
#**  File     :  t1_sub_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Sub Hologram
#** 
#**  Copyright © 2009 
#*************************************************************************

local TSubUnit = import('/lua/terranunits.lua').TSubUnit
TSubUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TSubUnit )

t1_sub_blip = Class(TSubUnit) {}

TypeClass = t1_sub_blip