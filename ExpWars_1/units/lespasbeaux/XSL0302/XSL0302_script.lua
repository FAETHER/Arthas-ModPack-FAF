#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0301/XSL0301_script.lua
#**  Author(s):  Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Seraphim Sub Commander Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local SDFLightChronotronCannonWeapon = SWeapons.SDFLightChronotronCannonWeapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon

XSL0302 = Class(SWalkingLandUnit) {
    
    Weapons = {
        LightChronatronCannon = Class(SDFLightChronotronCannonWeapon) {},
        DeathWeapon = Class(SCUDeathWeapon) {},
    },
    
     OnCreate = function(self)
        SWalkingLandUnit.OnCreate(self)
        self.Rotator1 = CreateRotator(self, 'Left_Leg_B03', 'y', nil, 200, 100, 200)
        self.Trash:Add(self.Rotator1)
        self:SetCapturable(false)
        self:SetupBuildBones()
    end,
}

TypeClass = XSL0302
