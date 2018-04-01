--[[#######################################################################
#  File     :  /units/Ingenieurs/UES0105/UES0105_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  Terran T1 Engineer Script
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

local TConstructionUnit = import( MyModPath .. '/hook/lua/terranunits.lua' ).TConstructionUnit

UES0105 = Class( TConstructionUnit ) {}

TypeClass = UES0105
