#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0303/URL0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local cWeapons = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01
local CDFElectronBolterWeapon = cWeapons.CDFElectronBolterWeapon
local CIFMissileLoaWeapon = import('/lua/cybranweapons.lua').CIFMissileLoaWeapon
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon

URLEW0001 = Class(CWalkingLandUnit) 
{
    --PlayEndAnimDestructionEffects = false,

    Weapons = {
		Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
        HeavyBolter = Class(CDFElectronBolterWeapon) {},
		MissileRack = Class(CIFMissileLoaWeapon) {},
		Missile01 = Class(CAAMissileNaniteWeapon) {},
    },
    
   OnCreate = function(self)
		CWalkingLandUnit.OnCreate(self)
		self:SetWeaponEnabledByLabel('HeavyBolter', true)
		self:SetWeaponEnabledByLabel('Missile01', true)
		self:SetWeaponEnabledByLabel('Disintigrator', true)
		self:SetWeaponEnabledByLabel('MissileRack', false)
		--self:SetOnScriptBitSet(true)
    end,

    TransformThread = function(self, land)
        if( not self.AnimManip ) then
            self.AnimManip = CreateAnimator(self)
        end
        local bp = self:GetBlueprint()
        local scale = bp.Display.UniformScale or 1

        if( land ) then
			self:SetWeaponEnabledByLabel('HeavyBolter', false)
            self:SetSpeedMult(bp.Physics.LandSpeedMultiplier)
            self:SetImmobile(true)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetRate(1)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
           -- self.SwitchAnims = true
            self.Trash:Add(self.AnimManip)
			self:SetWeaponEnabledByLabel('MissileRack', true)
			
        else
            self:SetImmobile(true)
            self:SetWeaponEnabledByLabel('MissileRack', false)
            self:SetSpeedMult(1)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetAnimationFraction(1)
            self.AnimManip:SetRate(-1)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
            self.AnimManip:Destroy()
            self.AnimManip = nil
            self:SetImmobile(false)
            self.Walking = false
			self:SetWeaponEnabledByLabel('HeavyBolter', true)
        end
    end,
	
    OnScriptBitSet = function(self, bit)
        CWalkingLandUnit.OnScriptBitSet(self, bit)
		local bp = self:GetBlueprint()
        if bit == 1 then 
            --self:SetWeaponEnabledByLabel('HeavyBolter', false)
			self.AT1 = self:ForkThread(self.TransformThread, true)
            --self:SetWeaponEnabledByLabel('MissileRack', true)
        end
    end,

    OnScriptBitClear = function(self, bit)
        CWalkingLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
            --self:SetWeaponEnabledByLabel('HeavyBolter', true)
            --self:SetWeaponEnabledByLabel('MissileRack', false)
			self.AT1 = self:ForkThread(self.TransformThread, false)
        end
    end,
}

TypeClass = URLEW0001