#
# UEF Anti-Matter Shells
#

#######################################################################
local Game = import('/lua/game.lua')

#VARIABLE ''GLOBALE'' (par Manimal)
local MyModPath = Game.MyModPath
#######################################################################

local TArtilleryAntiMatterProjectile = import( MyModPath .. '/hook/lua/modprojectiles.lua' ).TArtilleryAntiMatterSmallProjectile

TIFAntiMatterShells02 = Class(TArtilleryAntiMatterProjectile) {
}

TypeClass = TIFAntiMatterShells02