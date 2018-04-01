#****************************************************************************
#**
#**  File     :  /cdimage/units/XSS0103/XSS0103_script.lua
#**
#**  Summary  :  Seraphim Frigate Script: XSS0103
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon
local SDFUltraChromaticBeamGenerator = import('/Mods/ExpWars_1/hook/lua/seraphweapons.lua').SDFUltraChromaticBeamGenerator

XSO1104 = Class(SAirUnit) {
    Weapons = {
        MainGun = Class(SDFUltraChromaticBeamGenerator) {},
        AAGun = Class(SAAShleoCannonWeapon) {},
    },
}
TypeClass = XSO1104
