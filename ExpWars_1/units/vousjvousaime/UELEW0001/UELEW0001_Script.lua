#****************************************************************************
#**
#**  File     :  /cdimage/units/UELEW0001/UELEW0001_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**					Modified By Asdrubaelvect
#**  Summary  :  UEF Heavy Fortress Tech 1 Experimentale Wars Mods Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher

UELEW0001 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {},
		AAGun = Class(TAALinkedRailgun) {
           -- FxMuzzleFlashScale = 0.50,
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'AxeAA01', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(320)
                    end
                    TAALinkedRailgun.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TAALinkedRailgun.PlayFxWeaponPackSequence(self)
                end,
            },
		AAGun02 = Class(TAALinkedRailgun) {
           -- FxMuzzleFlashScale = 0.50,
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'AxeAA02', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(320)
                    end
                    TAALinkedRailgun.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TAALinkedRailgun.PlayFxWeaponPackSequence(self)
                end,
            },
		AAGun03 = Class(TAALinkedRailgun) {
           -- FxMuzzleFlashScale = 0.50,
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'AxeAA03', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(320)
                    end
                    TAALinkedRailgun.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TAALinkedRailgun.PlayFxWeaponPackSequence(self)
                end,
            },
        MissileWeapon = Class(TIFCruiseMissileUnpackingLauncher) 
        {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
        },
    },
}

TypeClass = UELEW0001