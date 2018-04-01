--[[#######################################################################
#  File     :  /units/Labos/RRB9202/RRB9202_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Special Cybran Science Lab Script
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  17 f�vrier 2010
#  Rev.Date :  18 f�vrier 2010
#  -----------------------------
#  Derived From /units/XRC2201/XRC2201_script.lua 
#  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local CNavalResearchLabUnit = import( MyModPath .. '/hook/lua/cybranunits.lua').CNavalResearchLabUnit

RRB9202 = Class( CNavalResearchLabUnit ) {

}

TypeClass = RRB9202
