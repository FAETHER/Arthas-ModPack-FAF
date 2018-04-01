--[[#######################################################################
#  File     :  /units/Labos/RSB9100/RSB9100_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Special Seraphim Science Lab Script
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

local SNavalResearchLabUnit = import( MyModPath .. '/hook/lua/seraphimunits.lua' ).SNavalResearchLabUnit

RSB9100 = Class( SNavalResearchLabUnit ) {
	SwitchAnims = true,
}

TypeClass = RSB9100


