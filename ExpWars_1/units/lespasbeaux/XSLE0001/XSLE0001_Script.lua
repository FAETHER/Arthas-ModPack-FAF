#****************************************************************************
#**
#**  File     :  /units/XSL0202/XSL0202_script.lua
#**
#**  Summary  :  Seraphim Heavy Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SDFAireauBolterWeapon = import('/lua/seraphimweapons.lua').SDFAireauBolterWeapon02
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon
local SDFChronotronOverChargeCannonWeapon = import('/lua/seraphimweapons.lua').SDFChronotronCannonOverChargeWeapon

XSL0202 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SDFAireauBolterWeapon) {},
		AAGun = Class(SAAOlarisCannonWeapon) {},
		OverCharge = Class(SDFChronotronOverChargeCannonWeapon) {},
    },
}
TypeClass = XSL0202