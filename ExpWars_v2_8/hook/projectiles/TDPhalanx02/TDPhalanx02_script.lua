#
# Terran Phalanx basic projectile
#

#######################################################################
local Game = import('/lua/game.lua')

#VARIABLE ''GLOBALE'' (par Manimal)
local MyModPath = Game.MyModPath
#######################################################################


local TShellPhalanx02Projectile = import( MyModPath .. '/hook/lua/modprojectiles.lua').TShellPhalanx02Projectile

TDPhalanx01 = Class( TShellPhalanx02Projectile ) { }

TypeClass = TDPhalanx01

