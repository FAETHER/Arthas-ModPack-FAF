#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0306/UEA0306_script.lua
#**  Author(s):  John Comes, David Tomandl
#**				Modified By Asdrubaelvect for Experiementals Wars.
#**  Summary  :  UEF Tech 3 fighter bomber
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAAGinsuRapidPulseWeapon = import('/lua/terranweapons.lua').TAAGinsuRapidPulseWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher

UEO306 = Class(TAirUnit) {
	
	Weapons = {
	    AABeam = Class(TAAGinsuRapidPulseWeapon) {},
		AABeam2 = Class(TAAGinsuRapidPulseWeapon) {},
        MissileWeapon = Class(TIFCruiseMissileUnpackingLauncher) {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
		IdleState = State (TIFCruiseMissileUnpackingLauncher.IdleState) {
                Main = function(self)
                    TIFCruiseMissileUnpackingLauncher.IdleState.Main(self)
                end,
                
                OnGotTarget = function(self)
                    self.unit:SetBreakOffTriggerMult(2.0)
                    self.unit:SetBreakOffDistanceMult(8.0)
                    self.unit:SetSpeedMult(1)
                    TIFCruiseMissileUnpackingLauncher.IdleState.OnGotTarget(self)
                end,            
            },
        
            OnGotTarget = function(self)
                self.unit:SetBreakOffTriggerMult(2.0)
                self.unit:SetBreakOffDistanceMult(8.0)
                self.unit:SetSpeedMult(1)
                TIFCruiseMissileUnpackingLauncher.OnGotTarget(self)
            end,
        
            OnLostTarget = function(self)
                self.unit:SetBreakOffTriggerMult(1.0)
                self.unit:SetBreakOffDistanceMult(1.0)
                self.unit:SetSpeedMult(1.0)
                TIFCruiseMissileUnpackingLauncher.OnLostTarget(self)
            end,
        },
    },
	
}

TypeClass = UEO306
