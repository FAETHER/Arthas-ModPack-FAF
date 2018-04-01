#****************************************************************************
#**
#**  File     :  /cdimage/units/XRB3301/XRB3301_script.lua
#**  Author(s):  Dru Staltman, Ted Snook
#**
#**  Summary  :  Cybran Vision unit thing
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CRadarUnit = import('/lua/cybranunits.lua').CRadarUnit
local CybranWeaponsFile = import('/Mods/ExpWars_1/hook/lua/modweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom

XRB3301 = Class(CRadarUnit) {   
    Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom) {
            },
    },
}

TypeClass = XRB3301