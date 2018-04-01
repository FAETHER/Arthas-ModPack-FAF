#*************************************************************************
#** 
#**  File     :  t2_heavy_tank_blip_Script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T2 Heavy Tank Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
TLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TLandUnit )

t2_heavy_tank_blip = Class(TLandUnit) {}

TypeClass = t2_heavy_tank_blip