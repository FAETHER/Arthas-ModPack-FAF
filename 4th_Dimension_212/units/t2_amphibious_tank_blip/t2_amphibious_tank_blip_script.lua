#*************************************************************************
#** 
#**  File     :  t2_amphibious_tank_blip_Script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T2 Amphibious Tank Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local THoverLandUnit = import('/lua/terranunits.lua').THoverLandUnit
THoverLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( THoverLandUnit )

t2_amphibious_tank_blip = Class(THoverLandUnit) {}

TypeClass = t2_amphibious_tank_blip