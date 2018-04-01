--[[#######################################################################
#  File     :  /units/Labos/REB8100/REB8100_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Special Earth Science Lab Script
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  19 janvier 2010
#  Rev.Date :  17 f�vrier 2010
#  -----------------------------
#  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local TAirResearchLabUnit = import( MyModPath .. '/hook/lua/terranunits.lua').TAirResearchLabUnit

REB8100 = Class( TAirResearchLabUnit ) {
	SwitchAnims = true,
}

TypeClass = REB8100

