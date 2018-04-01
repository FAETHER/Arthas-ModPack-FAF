#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2201/URB2201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Light Artillery Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#######################################################################
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#######################################################################


local CStructureUnit = import( MyModPath .. '/hook/lua/cybranunits.lua').CStructureUnit

local cWeapons = import('/lua/cybranweapons.lua')

local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01
local CIFSmartCharge = cWeapons.CIFSmartCharge


URB2201 = Class(CStructureUnit) {
	
    Weapons = {
        Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
		AntiTorpedo = Class(CIFSmartCharge) {},
    },


}

TypeClass = URB2201