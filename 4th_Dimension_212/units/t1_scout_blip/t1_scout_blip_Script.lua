#*************************************************************************
#** 
#**  File     :  t1_scout_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Scout Hologram
#** 
#**  Copyright © 2009
#*************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
TLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TLandUnit )

t1_scout_blip = Class(TLandUnit) {}

TypeClass = t1_scout_blip