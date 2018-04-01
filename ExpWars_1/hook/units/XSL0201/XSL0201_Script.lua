#****************************************************************************
#**
#**  File     :  /data/units/XSL0201/XSL0201_script.lua
#**  Author(s):  Jessica St. Croix, Greg Kohne, Aaron Lundquist
#**
#**  Summary  :  Seraphim Medium Tank Script
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local SDFPhasicAutoGunWeapon = import('/lua/seraphimweapons.lua').SDFPhasicAutoGunWeapon
local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

XSL0201 = Class(SLandUnit) {
    Weapons = {
        MainGun = Class(SDFOhCannon) {},
		MainGun01 = Class(SDFOhCannon) {},
		MainGun02 = Class(SDFPhasicAutoGunWeapon) {},
		MainGun03 = Class(SDFPhasicAutoGunWeapon) {},
		MainGun04 = Class(SDFPhasicAutoGunWeapon) {},
    },
	
    OnCreate = function(self)
		SLandUnit.OnCreate(self)
			self:HideBone('Turret_Barrel01', true)  
			self:HideBone('Armure', true)  
			self:HideBone('Turret01', true)  
			self:HideBone('Turret02', true)  
			self:HideBone('Turret03', true)  
			self:HideBone('Object01', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        SLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('MainGun', true)
			self:SetWeaponEnabledByLabel('MainGun01', false)
	        self:SetWeaponEnabledByLabel('MainGun02', false)  # Sera activ� via auto-upgrade
			self:SetWeaponEnabledByLabel('MainGun03', false)
			self:SetWeaponEnabledByLabel('MainGun04', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,

	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('MainGun')
		if not wep then return end

        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				self:ShowBone('Armure', true)
				hasHEBI = true    # Signale HEB INSTALL�
				hasHEBII = false
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
                BuffBlueprint {
                    Name = 'UEFHEALTHBUFF',
                    DisplayName = 'UEFHEALTHBUFF',
                    BuffType = 'MAXHEALTH',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.5,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1.0,
                        },
                    },
                }
            end
			Buff.ApplyBuff(self, 'UEFHEALTHBUFF')
		end	
		######################	
        local bp = self:GetBlueprint()
		local enh = 'VeterancyII'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyII' then
				self:SetWeaponEnabledByLabel('MainGun', false)
				self:SetWeaponEnabledByLabel('MainGun01', true)
				self:ShowBone('Object01', true)
				self:ShowBone('Turret_Barrel01', true)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALL�
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
			end
		end
		######################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyIII'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIII' then
				local wep = self:GetWeaponByLabel('MainGun01')
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)       
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALL�
				hasHEBIII = true
				hasHEBIV = false
				hasHEBV = false
			end
		end
		#######################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyIV'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIV' then
				self:SetWeaponEnabledByLabel('MainGun02', true)
				self:SetWeaponEnabledByLabel('MainGun03', true)
				self:SetWeaponEnabledByLabel('MainGun04', true)
				self:ShowBone('Turret01', true)
				self:ShowBone('Turret02', true)
				self:ShowBone('Turret03', true)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALL�
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = false
			end
		end
		#######################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyV'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyV' then
				local wep = self:GetWeaponByLabel('MainGun01')
				local wep2 = self:GetWeaponByLabel('MainGun02')
				local wep3 = self:GetWeaponByLabel('MainGun03')
				local wep4 = self:GetWeaponByLabel('MainGun04')
				wep4:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep3:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep2:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep:AddDamageMod(bpEnh.BolterIIDamageMod)  
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALL�
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
                BuffBlueprint {
                    Name = 'UEFHEALTHBUFFII',
                    DisplayName = 'UEFHEALTHBUFFII',
                    BuffType = 'MAXHEALTH',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 2.2,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1.0,
                        },
                    },
                }
            end
			Buff.ApplyBuff(self, 'UEFHEALTHBUFFII')
		end
	end,
	
}
TypeClass = XSL0201
