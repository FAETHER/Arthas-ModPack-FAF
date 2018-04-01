#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0103/UEL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Mobile Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TIFHighBallisticMortarWeapon = import('/lua/terranweapons.lua').TIFHighBallisticMortarWeapon

local Buff = import('/lua/sim/Buff.lua')

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

UEL0103 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TIFHighBallisticMortarWeapon) {
                
                CreateProjectileAtMuzzle = function(self, muzzle)
                    local proj = TIFHighBallisticMortarWeapon.CreateProjectileAtMuzzle(self, muzzle)
                    local data = {
                        Radius = self:GetBlueprint().CameraVisionRadius or 5,
                        Lifetime = self:GetBlueprint().CameraLifetime or 5,
                        Army = self.unit:GetArmy(),
                    }
                    if proj and not proj:BeenDestroyed() then
                        proj:PassData(data)
                    end
                end,
            },
        Main01GunUpgrade01 = Class(TIFHighBallisticMortarWeapon) {
                CreateProjectileAtMuzzle = function(self, muzzle)
                    local proj = TIFHighBallisticMortarWeapon.CreateProjectileAtMuzzle(self, muzzle)
                    local data = {
                        Radius = self:GetBlueprint().CameraVisionRadius or 5,
                        Lifetime = self:GetBlueprint().CameraLifetime or 5,
                        Army = self.unit:GetArmy(),
                    }
                    if proj and not proj:BeenDestroyed() then
                        proj:PassData(data)
                    end
                end,
            },
        Main01GunUpgrade02 = Class(TIFHighBallisticMortarWeapon) {
                CreateProjectileAtMuzzle = function(self, muzzle)
                    local proj = TIFHighBallisticMortarWeapon.CreateProjectileAtMuzzle(self, muzzle)
                    local data = {
                        Radius = self:GetBlueprint().CameraVisionRadius or 5,
                        Lifetime = self:GetBlueprint().CameraLifetime or 5,
                        Army = self.unit:GetArmy(),
                    }
                    if proj and not proj:BeenDestroyed() then
                        proj:PassData(data)
                    end
                end,
            },
    },

    OnCreate = function(self)
        TLandUnit.OnCreate(self)
			self:HideBone('Turret_Barrel01', true)  
			self:HideBone('Turret_Barrel_Recoil01', true)
			self:HideBone('Turret_Barrel02', true)
			self:HideBone('Turret_Barrel_Recoil02', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('MainGun', true)
	        self:SetWeaponEnabledByLabel('Main01GunUpgrade01', false)  # Sera activé via auto-upgrade
			self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
       self.WeaponsEnabled = true
	   self:AddUnitCallback(self.OnVeteran, 'OnVeteran') # Ajouter 1 Trigger pour lancer Enhancement
    end,

	
	#Level#
	OnVeteran = function ( self )
		local wep = self:GetWeaponByLabel('Main01GunUpgrade01')
		if not wep then return end

        local bp = self:GetBlueprint()
		local enh = 'VeterancyI'
		local bpEnh = bp.ExpeWars_Enhancement[enh]
		if not bpEnh then return end
        local bpEnhEAVLevel = bpEnh.EnabledAtVeterancyLevel
		if bpEnhEAVLevel and bpEnhEAVLevel > 0 and ( self.VeteranLevel == bpEnhEAVLevel ) then
			if enh =='VeterancyI' then
				local wep = self:GetWeaponByLabel('Main01GunUpgrade01')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				self:SetWeaponEnabledByLabel('Main01GunUpgrade01', true)
				self:SetWeaponEnabledByLabel('Main01GunUpgrade02', false)
				self:SetWeaponEnabledByLabel('MainGun', false)
				self:HideBone('Turret_Barrel', true)
				self:HideBone('Turret_Barrel_Recoil', true)
				self:ShowBone('Turret_Barrel02', true)
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
				local wep = self:GetWeaponByLabel('Main01GunUpgrade01')
    		    --wep:AddDamageMod(bpEnh.BolterDamageMod)        
        		--wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 44)
				wep:ChangeRateOfFire(bp.NewRateOfFire or 0.3)
				--self:SetWeaponEnabledByLabel('Bolter', true)
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
				local wep = self:GetWeaponByLabel('Main01GunUpgrade01')
				
    		    wep:AddDamageMod(bpEnh.BolterDamageMod)       
				--wep:AddDamageMod(bp.AdditionalDamage)				
        		--wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 44)
				--wep:ChangeRateOfFire(bp.NewRateOfFire or 2)
				--self:SetWeaponEnabledByLabel('Bolter', true)
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
				local wep = self:GetWeaponByLabel('Main01GunUpgrade02')
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				self:SetWeaponEnabledByLabel('Main01GunUpgrade02', true)
				self:SetWeaponEnabledByLabel('Main01GunUpgrade01', false)
				self:SetWeaponEnabledByLabel('MainGun', false)
				self:HideBone('Turret_Barrel02', true)
				self:HideBone('Turret_Barrel_Recoil02', true)
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
				local wep = self:GetWeaponByLabel('Main01GunUpgrade02')
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

TypeClass = UEL0103