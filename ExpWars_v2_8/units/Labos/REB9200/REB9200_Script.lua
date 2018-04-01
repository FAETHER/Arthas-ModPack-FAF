--[[#######################################################################
#  File     :  /units/Labos/REB9200/REB9200_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Special Earth Science Lab Script
#  -----------------------------
#  Modif.by :  Manimal
#  Mod.Date :  19 janvier 2010
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  17 février 2010
#  -----------------------------
#  Revis.by :  Asdrubaelvect
#  Rev.Date :  27 février 2010
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  02 mars 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local TNavalResearchLabUnit = import( MyModPath .. '/hook/lua/terranunits.lua').TNavalResearchLabUnit

REB9200 = Class( TNavalResearchLabUnit ) {

}

TypeClass = REB9200

