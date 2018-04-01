--[[#######################################################################
#  File     :  /units/Ingenieurs/UES0208/UES0208_script.lua
#  Author(s):  John Comes, David Tomandl, Gordon Duclos
#  Summary  :  Terran T2 Engineer Script
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


UES0208 = Class( TConstructionUnit ) {}

TypeClass = UES0208
