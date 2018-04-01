#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0103/URL0103_script.lua
#**  Author(s):  John Comes, David Tomandl
#**			Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Cybran Mobile Mortar Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CIFGrenadeWeapon = CybranWeaponsFile.CIFGrenadeWeapon

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

URL0103 = Class(CWalkingLandUnit) {
    DestructionTicks = 400,

    Weapons = {
        MainGun = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        MainGunUpgrade = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        MainGunUpgrade02 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
    },
	
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
			self:HideBone('Chassis_Upgrade_01', true)  
			self:HideBone('Turret01', true)
			self:HideBone('Turret_Barrel02', true)
			self:HideBone('Turret_Barrel_Recoil02', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('MainGun', true)
	        self:SetWeaponEnabledByLabel('MainGunUpgrade', false)  # Sera activé via auto-upgrade
			self:SetWeaponEnabledByLabel('MainGunUpgrade02', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,

	
	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('MainGunUpgrade')
		if not wep then return end

        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				local wep = self:GetWeaponByLabel('MainGun')
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)       
				hasHEBI = true    # Signale HEB INSTALLÉ
				hasHEBII = false
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
			end
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
				local wep = self:GetWeaponByLabel('MainGunUpgrade')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				self:HideBone('Turret_Barrel', true)
				self:HideBone('Turret_Barrel_Recoil', true)
				self:SetWeaponEnabledByLabel('MainGun', false)
				self:SetWeaponEnabledByLabel('MainGunUpgrade', true)
				self:ShowBone('Turret_Barrel02', true)
				self:ShowBone('Turret_Barrel_Recoil02', true)
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
				local wep = self:GetWeaponByLabel('MainGunUpgrade')
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.3)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = false
				hasHEBV = false
			end
		end	
		######################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyIV'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		# ADDS MY CUSTOM ENHANCEMENT !
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIV' then
			local wep = self:GetWeaponByLabel('MainGunUpgrade02')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				self:ShowBone('Chassis_Upgrade_01', true)  --Turret01
				self:ShowBone('Turret01', true)
				self:ShowBone('Turret_Barrel01', true)
				self:ShowBone('Turret_Barrel_Recoil01', true)
				self:SetWeaponEnabledByLabel('MainGunUpgrade02', true)
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
				local wep = self:GetWeaponByLabel('MainGun')
				local wep = self:GetWeaponByLabel('MainGunUpgrade02')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 45)
				wep:AddDamageMod(bpEnh.BolterIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.2)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
			end
		end		
	end,
		
}

TypeClass = URL0103

