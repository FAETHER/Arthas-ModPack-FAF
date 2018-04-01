--[[#######################################################################
#  File     :  /units/Ingenieurs/XSS0105/XSS0105_script.lua
#  Author(s):  Jessica St. Croix, Gordon Duclos
#  Summary  :  Seraphim Naval T1 Engineer Script
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmm aaaa
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  17 mars 2010
#  -----------------------------
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local SConstructionUnit = import( MyModPath .. '/hook/lua/seraphimunits.lua' ).SConstructionUnit

XSS0105 = Class( SConstructionUnit ) {
}

TypeClass = XSS0105
