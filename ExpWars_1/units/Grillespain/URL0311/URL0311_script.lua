#****************************************************************************
#**
#**  File     :  /units/URL0311/URL0311_script.lua
#**  Author(s):  Dru Staltman, Eric Williamson, Gordon Duclos
#**					Modified by Asdrubaelvect
#**  Summary  :  Cybran Missile TEch3 Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************



URL0311 = Class(import('/lua/cybranunits.lua').CWalkingLandUnit) {
    Weapons = {
        CruiseMissile = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
    },
}
TypeClass = URL0311

