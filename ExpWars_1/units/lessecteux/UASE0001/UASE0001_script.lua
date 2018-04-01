#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0103/UAS0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Frigate Script: UAS0103
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAS0103 = Class(AAirUnit) {

    Weapons = {
        AAGun = Class(AAASonicPulseBatteryWeapon) {
            FxMuzzleScale = 2.25,
        },
		MainGun = Class(import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        }
    },
}

TypeClass = UAS0103
