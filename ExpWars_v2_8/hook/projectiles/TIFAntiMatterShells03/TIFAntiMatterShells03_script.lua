#
# UEF Anti-Matter Shells
#

#######################################################################
local Game = import('/lua/game.lua')

#VARIABLE ''GLOBALE'' (par Manimal)
local MyModPath = Game.MyModPath
#######################################################################

local TArtilleryAntiMatterProjectile = import( MyModPath .. '/hook/lua/modprojectiles.lua' ).TArtilleryAntiMatterProjectile

TIFAntiMatterShells01 = Class(TArtilleryAntiMatterProjectile) {
}

TypeClass = TIFAntiMatterShells01
