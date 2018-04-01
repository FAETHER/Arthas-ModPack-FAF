#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0106/UEL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Light Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local Unit = import('/lua/sim/Unit.lua').Unit
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

UEL0106 = Class(TWalkingLandUnit) {
    Weapons = {
        ArmCannonTurret = Class(TDFMachineGunWeapon) {
            DisabledFiringBones = {
                'Torso', 'Head',  'Arm_Right_B01', 'Arm_Right_B02','Arm_Right_Muzzle',
                'Arm_Left_B01', 'Arm_Left_B02','Arm_Left_Muzzle'
                },
        },
		MissileRack01 = Class(TSAMLauncher) {},
    },

    OnCreate = function(self)
		TWalkingLandUnit.OnCreate(self)
			self:HideBone('MiniMissileRack', true)  
			#self:HideBone('Turret_Barrel_Recoil01', true)
			#self:HideBone('Turret_Barrel02', true)
			#self:HideBone('Turret_Barrel_Recoil02', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('ArmCannonTurret', true)
	        self:SetWeaponEnabledByLabel('MissileRack01', false)  # Sera activé via auto-upgrade
			#self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,

	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('ArmCannonTurret')
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
				local wep = self:GetWeaponByLabel('ArmCannonTurret')
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
				local wep = self:GetWeaponByLabel('ArmCannonTurret')
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
				self:SetWeaponEnabledByLabel('MissileRack01', true)
				self:ShowBone('MiniMissileRack', true)
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
				local wep = self:GetWeaponByLabel('MissileRack01')
				local wep2 = self:GetWeaponByLabel('ArmCannonTurret')
				wep2:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep:AddDamageMod(bpEnh.BolterIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.5)
				wep2:ChangeRateOfFire(bp.NewRateOfFireII or 6.5)
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
TypeClass = UEL0106

