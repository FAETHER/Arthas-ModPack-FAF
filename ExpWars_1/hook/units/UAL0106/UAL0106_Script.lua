#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0106/UAL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local ADFSonicPulsarWeapon = import('/lua/aeonweapons.lua').ADFSonicPulsarWeapon
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

UAL0106 = Class(AWalkingLandUnit) {
    Weapons = {
        ArmLaserTurret = Class(ADFSonicPulsarWeapon) {},
		ArmLaserTurretMod = Class(ADFLaserLightWeapon) {},
		ArmLaserTurretMod02 = Class(ADFLaserLightWeapon) {},
    },
	
    OnCreate = function(self)
		AWalkingLandUnit.OnCreate(self)
			self:HideBone('Turret02', true)  
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('ArmLaserTurretMod', true)
			self:SetWeaponEnabledByLabel('ArmLaserTurretMod02', false)
	        self:SetWeaponEnabledByLabel('ArmLaserTurret', false)  # Sera activé via auto-upgrade
			#self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,
	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('ArmLaserTurretMod')
		if not wep then return end

        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		--local bp = self:GetBlueprint().Enhancements[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				hasHEBI = true    # Signale HEB INSTALLÉ
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
                            Mult = 2,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1,
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
				local wep = self:GetWeaponByLabel('ArmLaserTurretMod')
				wep:ChangeRateOfFire(bp.NewRateOfFire or 5)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
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
				local wep = self:GetWeaponByLabel('ArmLaserTurretMod')
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)       
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
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
				self:SetWeaponEnabledByLabel('ArmLaserTurretMod', true)
				self:SetWeaponEnabledByLabel('ArmLaserTurretMod02', true)
				self:ShowBone('Turret02', true)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
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
				local wep = self:GetWeaponByLabel('ArmLaserTurretMod')
				wep:AddDamageMod(bpEnh.BolterIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 1.8)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
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
                            Mult = 2.1,
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


TypeClass = UAL0106