#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2303/UAB2303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Artillery Installation Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local WeaponsFile = import('/Mods/ExpWars_1/hook/lua/modweapons.lua')
local ADFCannonOblivion01Weapon = WeaponsFile.ADFCannonOblivion01Weapon

UAB2303 = Class(AStructureUnit) {

    Weapons = {
        MainGun = Class(ADFCannonOblivion01Weapon) {
		FxMuzzleFlashScale = 2.5,
		},
    },
}

TypeClass = UAB2303