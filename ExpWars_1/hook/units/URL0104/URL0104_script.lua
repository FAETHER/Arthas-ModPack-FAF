#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0104/URL0104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

local hasHEBI = false
local hasHEBII = false
local hasHEBIII = false
local hasHEBIV = false
local hasHEBV = false

URL0104 = Class(CLandUnit) {
    Weapons = {
        AAGun = Class(CAANanoDartWeapon) {},
        GroundGun = Class(CAANanoDartWeapon) {
            SetOnTransport = function(self, transportstate)
                CAANanoDartWeapon.SetOnTransport(self, transportstate)
                self.unit:SetScriptBit('RULEUTC_WeaponToggle', false)
            end,
        },
        AAGun01 = Class(CAANanoDartWeapon) {},
        GroundGun01 = Class(CAANanoDartWeapon) {
            SetOnTransport = function(self, transportstate)
                CAANanoDartWeapon.SetOnTransport(self, transportstate)
                self.unit:SetScriptBit('RULEUTC_WeaponToggle', false)
            end,
        },
    },
    
    OnCreate = function(self)
        CLandUnit.OnCreate(self)
        self:SetWeaponEnabledByLabel('GroundGun', false)
		self:SetWeaponEnabledByLabel('GroundGun01', false)
			self:HideBone('Turret_Barrel01', true)  
			self:HideBone('Turret01', true)
			#self:HideBone('Turret_Barrel02', true)
			#self:HideBone('Turret_Barrel_Recoil02', true)
			self.hasHEBI = false
			self.hasHEBII = false
			self.hasHEBIII = false
			self.hasHEBIV = false
			self.hasHEBV = false
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        CLandUnit.OnStopBeingBuilt(self,builder,layer)
	        self:SetWeaponEnabledByLabel('AAGun', true)
	        self:SetWeaponEnabledByLabel('AAGun01', false)  # Sera activé via auto-upgrade
			self:SetWeaponEnabledByLabel('GroundGun01', false)
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
				local wep2 = self:GetWeaponByLabel('GroundGun')
				wep2:ChangeMaxRadius(bpEnh.NewMaxRadius2 or 25)
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
				local wep2 = self:GetWeaponByLabel('GroundGun')
				wep:ChangeRateOfFire(bp.NewRateOfFire or 2.5)
				wep2:ChangeRateOfFire(bp.NewRateOfFire2 or 2.5)
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
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				local wep2 = self:GetWeaponByLabel('GroundGun')
				wep2:ChangeMaxRadius(bpEnh.NewMaxRadius2 or 25)			
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
				local wep2 = self:GetWeaponByLabel('GroundGun01')
				self:SetWeaponEnabledByLabel('AAGun01', true)
				self:SetWeaponEnabledByLabel('GroundGun01', true)
				wep:ChangeMaxRadius(bpEnh.NewMaxRadius or 40)
				wep2:ChangeMaxRadius(bpEnh.NewMaxRadius or 25)
				self:SetWeaponEnabledByLabel('AAGun', false)
				self:SetWeaponEnabledByLabel('GroundGun', false)
				self:ShowBone('Turret_Barrel01', true)
				self:ShowBone('Turret01', true)
				self:HideBone('Turret_Barrel', true)
				self:HideBone('Turret', true)
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
				wep:ChangeRateOfFire(bp.NewRateOfFire or 2.3)
				hasHEBI = true
				hasHEBII = true    # Signale HEB INSTALLÉ
				hasHEBIII = true
				hasHEBIV = true
				hasHEBV = true
			end
		end
	end,
	
    OnScriptBitSet = function(self, bit)
        CLandUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('GroundGun', true)
            self:SetWeaponEnabledByLabel('AAGun', false)
            self:GetWeaponManipulatorByLabel('GroundGun'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('AAGun'):GetHeadingPitch() )
        end
    end,

    OnScriptBitClear = function(self, bit)
        CLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('GroundGun', false)
            self:SetWeaponEnabledByLabel('AAGun', true)
            self:GetWeaponManipulatorByLabel('AAGun'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('GroundGun'):GetHeadingPitch() )
        end
    end,
}
TypeClass = URL0104

