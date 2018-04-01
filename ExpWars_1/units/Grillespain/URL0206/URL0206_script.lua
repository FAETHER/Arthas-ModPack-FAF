#****************************************************************************
#**
#**  File     :  /units/URL0206/URL0206_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix And Asdrubaelvect
#**
#**  Summary  :  Cybran Ambphibious Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon

URL0206 = Class(CLandUnit) {

    Weapons = {
        Bolter = Class(CDFElectronBolterWeapon) {},
		Bolter02 = Class(CDFElectronBolterWeapon) {},
        --Rocket = Class(CDFMissileMesonWeapon) {},
       -- Torpedo = Class(CANTorpedoLauncherWeapon) {},
    },
    
    OnStopBeingBuilt = function(self, builder, layer)
        CLandUnit.OnStopBeingBuilt(self,builder,layer)
        # If created with F2 on land, then play the transform anim.
        if(self:GetCurrentLayer() == 'Land') then
			# Enable Land weapons
	        self:SetWeaponEnabledByLabel('Bolter', true)
			self:SetWeaponEnabledByLabel('Bolter02', true)
        elseif (self:GetCurrentLayer() == 'Seabed') then
			# Disable Land Weapons
	        self:SetWeaponEnabledByLabel('Bolter', false)
			self:SetWeaponEnabledByLabel('Bolter02', false)
        end
       self.WeaponsEnabled = true
    end,

	OnLayerChange = function(self, new, old)
		CLandUnit.OnLayerChange(self, new, old)
		if self.WeaponsEnabled then
			if( new == 'Land' ) then
				# Enable Land weapons
				self:SetWeaponEnabledByLabel('Bolter', true)
				self:SetWeaponEnabledByLabel('Bolter02', true)
			elseif ( new == 'Seabed' ) then
				# Disable Land Weapons
				self:SetWeaponEnabledByLabel('Bolter', false)
				self:SetWeaponEnabledByLabel('Bolter02', false)
			end
		end
	end,
}
TypeClass = URL0206