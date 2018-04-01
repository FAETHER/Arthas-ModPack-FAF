--[[#######################################################################
#  File     :  /units/Labos/RSB8100/RSB8100_script.lua
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

local SAirResearchLabUnit = import( MyModPath .. '/hook/lua/seraphimunits.lua' ).SAirResearchLabUnit

RSB8100 = Class( SAirResearchLabUnit ) {

}

TypeClass = RSB8100


