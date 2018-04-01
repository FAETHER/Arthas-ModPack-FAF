--[[#######################################################################
#  File     :  /units/Ingenieurs/UAS0105/UAS0105_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  Aeon T1 Engineer Script
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

local AConstructionUnit = import( MyModPath .. '/hook/lua/aeonunits.lua').AConstructionUnit


UAS0105 = Class( AConstructionUnit ) {

    OnStopBeingBuilt = function( self, builder, layer )
        AConstructionUnit.OnStopBeingBuilt( self, builder, layer )
        self.Trash:Add(  CreateRotator( self, 'Panel_04', 'y', nil, 360, 0, 180 )  )
	end

}

TypeClass = UAS0105
