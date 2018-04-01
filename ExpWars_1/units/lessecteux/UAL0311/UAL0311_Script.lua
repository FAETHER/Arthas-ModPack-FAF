#****************************************************************************
#**
#**  File     :  /cdimage/units/DAL0310/DAL0310_script.lua
#**  Author(s):  Dru Staltman, Matt Vainio
#**
#**  Summary  :  Aeon Shield Disruptor Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local ACruiseMissileWeapon = import('/lua/aeonweapons.lua').ACruiseMissileWeapon

DAL0310 = Class(ALandUnit) {
    Weapons = {
        MissileRack = Class(ACruiseMissileWeapon) {},
    },
}
TypeClass = DAL0310

