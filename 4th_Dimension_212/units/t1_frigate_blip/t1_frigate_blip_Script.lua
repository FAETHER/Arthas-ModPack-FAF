#*************************************************************************
#** 
#**  File     :  t1_frigate_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 frigate Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
TSeaUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TSeaUnit )

t1_frigate_blip = Class(TSeaUnit) {}

TypeClass = t1_frigate_blip