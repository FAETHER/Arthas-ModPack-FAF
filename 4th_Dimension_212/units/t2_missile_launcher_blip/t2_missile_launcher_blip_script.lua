#*************************************************************************
#** 
#**  File     :  t2_missile_launcher_blip_script.lua 
#**  Author   :  Resin_Smoker
#**  Summary  :  T2 Missile Launcher Hologram
#** 
#**  Copyright © 2009
#*************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
TLandUnit = import('/mods/4th_Dimension_212/hook/lua/AdvancedJamming.lua').AdvancedJammerHologram( TLandUnit )

t2_missile_launcher_blip = Class(TLandUnit) {}

TypeClass = t2_missile_launcher_blip