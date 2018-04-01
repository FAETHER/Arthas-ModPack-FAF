--[[#######################################################################
#  File     :  /units/Labos/RAB7302/RAB7302_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Special Aeon Science Lab Script
#  **  Made From Aeon Manufacturing Center, Ver1
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  17 février 2010
#  Rev.Date :  18 février 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local ALandResearchLabUnit = import( MyModPath .. '/hook/lua/aeonunits.lua').ALandResearchLabUnit

RAB7302 = Class( ALandResearchLabUnit ) {
	SwitchAnims = true,
}

TypeClass = RAB7302

