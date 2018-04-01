#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0202/UAS0202_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Aeon Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AeonWeapons = import('/lua/aeonweapons.lua')
local ASubUnit = import('/lua/aeonunits.lua').ASubUnit
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon

UAS0202 = Class(ASubUnit) {
    Weapons = {
        FrontTurret = Class(ADFCannonQuantumWeapon) {},
		Torpedo01 = Class(AANChronoTorpedoWeapon) {},
    },

    --BackWakeEffect = {},
}

TypeClass = UAS0202