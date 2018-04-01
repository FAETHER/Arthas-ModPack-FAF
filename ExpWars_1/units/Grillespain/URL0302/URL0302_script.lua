#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0301/URL0301_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Sub Commander Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CWeapons = import('/lua/cybranweapons.lua')

local CAAMissileNaniteWeapon = CWeapons.CAAMissileNaniteWeapon
local CDFLaserDisintegratorWeapon = CWeapons.CDFLaserDisintegratorWeapon02
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local CDFLaserHeavyWeapon = CWeapons.CDFLaserHeavyWeapon

URL0302 = Class(CWalkingLandUnit) {
   
	ShieldEffects = {
                '/effects/emitters/cybran_shield_01_generator_01_emit.bp',
                '/effects/emitters/cybran_shield_01_generator_02_emit.bp',
                '/effects/emitters/cybran_shield_01_generator_03_emit.bp',
                },
    
    Weapons = {
		LaserArmsG = Class(CDFLaserHeavyWeapon) {},
		LaserArmsD = Class(CDFLaserHeavyWeapon) {},
        DeathWeapon = Class(SCUDeathWeapon) {},
		RightDisintegrator = Class(CDFLaserDisintegratorWeapon) {
        },
		RightDisintegrator01 = Class(CDFLaserDisintegratorWeapon) {
        },
		Disintegrator = Class(CDFLaserDisintegratorWeapon) {
        },
        NMissile = Class(CAAMissileNaniteWeapon) {},
    },

    # ********
    # Creation
    # ********
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        self:SetCapturable(false)
        self.IntelButtonSet = true
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self.RightArmUpgrade = 'Disintegrator'
		self.ShieldEffectsBag = {}
        self.DelayedCloakThread = self:ForkThread(self.CloakDelayed)
    end,
	
    CloakDelayed = function(self)
        if not self.Dead then
            WaitSeconds(2)
            self.IntelDisables['RadarStealth']['ToggleBit5'] = true
            self.IntelDisables['Cloak']['ToggleBit8'] = true
            self:EnableUnitIntel('ToggleBit5', 'RadarStealth')
            self:EnableUnitIntel('ToggleBit8', 'Cloak')
        end
        KillThread(self.DelayedCloakThread)
        self.DelayedCloakThread = nil
    end,

    # *****
    # Death
    # *****
    OnKilled = function(self, instigator, type, overkillRatio)
        local bp
        for k, v in self:GetBlueprint().Buffs do
            if v.Add.OnDeath then
                bp = v
            end
        end 
        #if we could find a blueprint with v.Add.OnDeath, then add the buff 
        if bp ~= nil then 
            #Apply Buff
			self:AddBuff(bp)
        end
        #otherwise, we should finish killing the unit
        CWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,   
         
}

TypeClass = URL0302
