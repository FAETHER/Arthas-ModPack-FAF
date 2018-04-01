#****************************************************************************
#**
#**  File     :  /units/UAL0305/UAL0305_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Heavy Tank Tech3 Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon

UAL0305 = Class(ALandUnit) {
    Weapons = {
        MainGun = Class(ADFQuantumAutogunWeapon) {
            FxMuzzleFlash = { 
                '/effects/emitters/aeon_heavy_artillery_flash_01_emit.bp', 
                '/effects/emitters/aeon_heavy_artillery_flash_02_emit.bp', 
            },
        },
    },

}

TypeClass = UAL0305