#*************************************************************************
#** 
#**  File     :  t1_anti_air_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T1 Engineer Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
TConstructionUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TConstructionUnit )

t1_engineer_blip = Class(TConstructionUnit) {}

TypeClass = t1_engineer_blip