--[[#######################################################################
#  File     :  /units/Labos/RRB9303/RRB9303_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Special Cybran Science Lab Script
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  17 février 2010
#  Rev.Date :  18 février 2010
#  -----------------------------
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  18 juillet 2010  faute de frappe : CLandResearchLabUnit => CNavalResearchLabUnit
#  Derived From /units/XRC2201/XRC2201_script.lua 
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local CNavalResearchLabUnit = import( MyModPath .. '/hook/lua/cybranunits.lua').CNavalResearchLabUnit

RRB9303 = Class( CNavalResearchLabUnit ) {

}

TypeClass = RRB9303
