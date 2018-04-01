#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0104/UEL0104_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  UEF Mobile Anti-Air Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

UEL0104 = Class(TLandUnit) {
    Weapons = {
        AAGun = Class(TAALinkedRailgun) {
            FxMuzzleFlashScale = 0.25,
        },
        AAGun01 = Class(TAALinkedRailgun) {
            FxMuzzleFlashScale = 0.25,
        },
    },

    OnCreate = function(self)
        TLandUnit.OnCreate(self)
			self:HideBone('Turret_Barrel01', true)  
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
        TLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('AAGun', true)
	        self:SetWeaponEnabledByLabel('AAGun01', false)  # Sera activé via auto-upgrade
			#self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,

	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('AAGun')
		if not wep then return end

        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				local wep = self:GetWeaponByLabel('AAGun')
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
				local wep = self:GetWeaponByLabel('AAGun')
				wep:ChangeRateOfFire(bp.NewRateOfFire or 1.9)
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
				local wep = self:GetWeaponByLabel('AAGun')
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
				local wep = self:GetWeaponByLabel('AAGun01')
				self:SetWeaponEnabledByLabel('AAGun01', true)
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				self:SetWeaponEnabledByLabel('AAGun', false)
				self:ShowBone('Turret_Barrel01', true)
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
				local wep = self:GetWeaponByLabel('AAGun01')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 45)
				wep:AddDamageMod(bpEnh.BolterIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 1.8)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
			end
		end
	end,

}

TypeClass = UEL0104