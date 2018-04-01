#****************************************************************************
#**
#**  File     :  ????
#**  Author(s):  modified by Asdrubaelvect
#**
#**  Summary  :  Aeon Orbital Heavy Lazer Cannon projectile 
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************


#######################################################################
local Game = import('/lua/game.lua')

#VARIABLE ''GLOBALE'' (par Manimal)
local MyModPath = Game.MyModPath
#######################################################################

local AOblivionCannonProjectile = import( MyModPath .. '/hook/lua/modprojectiles.lua').AOrbitalHeavyLazerProjectile


ADFOblivionCannon02 = Class(AOblivionCannonProjectile) {}

TypeClass = ADFOblivionCannon02
