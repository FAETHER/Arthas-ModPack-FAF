#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0103/XSL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Aaron Lundquist
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Seraphim Mobile Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SIFThunthoCannonWeapon = import('/lua/seraphimweapons.lua').SIFThunthoCannonWeapon

local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

XSL0103 = Class(SHoverLandUnit) {
    Weapons = {
        MainGun = Class(SIFThunthoCannonWeapon) {}
    },

    OnCreate = function(self)
        SHoverLandUnit.OnCreate(self)
			self:HideBone('Object01', true)  
			self:HideBone('Object02', true)
			self:HideBone('Object03', true)
			self:HideBone('Turret01', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        SHoverLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('MainGun', true)
	        --self:SetWeaponEnabledByLabel('Main01GunUpgrade01', false)  # Sera activé via auto-upgrade
			--self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
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
				self:ShowBone('Object01', true)
				hasHEBI = true    # Signale HEB INSTALLÉ
				hasHEBII = false
				hasHEBIII = false
				hasHEBIV = false
				hasHEBV = false
			end
		end		
	##############################################
        local bp = self:GetBlueprint()
		local enh = 'VeterancyII'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyII' then
				local wep = self:GetWeaponByLabel('MainGun')
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.55)
				self:ShowBone('Object02', true)
				hasHEBI = true    # Signale HEB INSTALLÉ
				hasHEBII = true
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
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)   
				self:ShowBone('Object03', true)				
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
				local wep = self:GetWeaponByLabel('MainGun')
    		    wep:AddDamageMod(bpEnh.BolterIIDamageMod)   
				self:ShowBone('Turret01', true)				
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
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 55)
				--wep:AddDamageMod(bpEnh.BolterIIIDamageMod)  
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.65)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
			end
		end
	end,
	
}

TypeClass = XSL0103