#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0103/UAL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Model By Asdrubaelvect, Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Aeon Mobile Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AIFMortarWeapon = import('/lua/aeonweapons.lua').AIFMortarWeapon

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

UAL0103 = Class(AHoverLandUnit) {
    Weapons = {
        MainGun = Class(AIFMortarWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/aeon_mortar_flash_01_emit.bp',
                '/effects/emitters/aeon_mortar_flash_02_emit.bp',
            },
        },
        MainGunUpgrade01 = Class(AIFMortarWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/aeon_mortar_flash_01_emit.bp',
                '/effects/emitters/aeon_mortar_flash_02_emit.bp',
            },
        },
    },
    OnCreate = function(self)
        AHoverLandUnit.OnCreate(self)
			self:HideBone('Turret_Barrel01', true)  
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        AHoverLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('MainGun', true)
	        self:SetWeaponEnabledByLabel('MainGunUpgrade01', false)  # Sera activé via auto-upgrade
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
				local wep = self:GetWeaponByLabel('MainGun')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
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
				local wep = self:GetWeaponByLabel('MainGun')
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)        
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
				local wep = self:GetWeaponByLabel('MainGun')
    		    wep:AddDamageMod(bpEnh.BolterIIDamageMod)        
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = false
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
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyIV' then
				local wep = self:GetWeaponByLabel('MainGunUpgrade01')
				self:SetWeaponEnabledByLabel('MainGunUpgrade01', true)
				self:SetWeaponEnabledByLabel('MainGun', false)
				self:HideBone('Turret_Barrel', true)
				self:ShowBone('Turret_Barrel01', true)
				hasHEBI = true    # Signale HEB INSTALLÉ
				hasHEBII = true
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
				local wep = self:GetWeaponByLabel('MainGunUpgrade01')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 42)
				wep:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.6)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
			end
		end		
	end,
}

TypeClass = UAL0103