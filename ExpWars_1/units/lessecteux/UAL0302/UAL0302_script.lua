#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0301/UAL0301_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon Sub Commander Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit

local AWeapons = import('/lua/aeonweapons.lua')
local ADFReactonCannon = AWeapons.ADFReactonCannon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon

UAL0302 = Class(AWalkingLandUnit) {    
    Weapons = {
        RightReactonCannon = Class(ADFReactonCannon) {},
        DeathWeapon = Class(SCUDeathWeapon) {
        },
    },   
}

TypeClass = UAL0302
