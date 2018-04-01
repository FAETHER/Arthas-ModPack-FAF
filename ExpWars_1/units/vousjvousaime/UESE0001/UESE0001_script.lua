#****************************************************************************
#**
#**  File     :  /Mods/units/UEO1102/UEO1102_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix  
#**					Modified By Asdrubaelvect
#**  Summary  :  FTU tech 1 spaceships experimental
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************


local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TWeapons = import('/lua/terranweapons.lua')
local TDFHeavyPlasmaCannonWeapon = TWeapons.TDFHeavyPlasmaCannonWeapon

UEO1102 = Class(TAirUnit) {
    Weapons = {
        AAGun = Class(TAALinkedRailgun) {},
		Plasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
    },
}


TypeClass = UEO1102