--[[#######################################################################
#  File     :  /units/Ingenieurs/URS0105/URS0105_script.lua
#  Author(s):  David Tomandl
#  Summary  :  Cybran T1 Engineer Script
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmm aaaa
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  17 mars 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local CConstructionUnit = import( MyModPath .. '/hook/lua/cybranunits.lua' ).CConstructionUnit

URS0105 = Class( CConstructionUnit ) {}

TypeClass = URS0105
