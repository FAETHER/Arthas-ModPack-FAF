#****************************************************************************
#**
#**  File     :  /Mods/ExpWars_1/units/UALEW0001/UALEW0001_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Destroyer Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon


UALEW0001 = Class(AHoverLandUnit) {
    Weapons = {
		MainGun = Class(ADFGravitonProjectorWeapon) {},
		AntiAirMissiles = Class(AAAZealotMissileWeapon) {},
    },
}

TypeClass = UALEW0001