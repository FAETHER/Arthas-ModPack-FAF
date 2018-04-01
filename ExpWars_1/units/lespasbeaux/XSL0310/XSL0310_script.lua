#****************************************************************************
#**
#**  File     :  /units/XSL0307/XSL0307_script.lua
#**
#**  Summary  :  Seraphim Mobile Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SShieldHoverLandUnit = import('/lua/seraphimunits.lua').SShieldHoverLandUnit
local SIFInainoWeapon = import('/lua/seraphimweapons.lua').SIFInainoWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SLaanseMissileWeapon = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon

XSL0307 = Class(SShieldHoverLandUnit) {
    Weapons = {
        InainoMissiles = Class(SIFInainoWeapon) { 
        
            # launch charge
			LaunchEffects = function(self)   
				###LOG ("launch effects") 
				local FxLaunch = EffectTemplate.SIFInainoPreLaunch01 
				
				WaitSeconds(1.5)
 				self.unit:PlayUnitAmbientSound( 'NukeCharge' )
				for k, v in FxLaunch do
					CreateEmitterAtEntity( self.unit, self.unit:GetArmy(), v )
				end
				WaitSeconds(9.5)
				self.unit:StopUnitAmbientSound( 'NukeCharge' )

			end,   
		  
			PlayFxWeaponUnpackSequence = function(self)
				self:ForkThread(self.LaunchEffects)
				SIFInainoWeapon.PlayFxWeaponUnpackSequence(self)
			end,  
        },
        CruiseMissile = Class(SLaanseMissileWeapon) {},
    },
}

TypeClass = XSL0307
