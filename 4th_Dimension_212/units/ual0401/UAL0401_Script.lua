#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  Aeon Galactic Colossus Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import ('/lua/aeonweapons.lua')
local ADFPhasonLaser = WeaponsFile.ADFPhasonLaser
local ADFTractorClaw = WeaponsFile.ADFTractorClaw
local utilities = import('/lua/utilities.lua')
local explosion = import('/lua/defaultexplosions.lua')

UAL0401 = Class(AWalkingLandUnit) {
    Weapons = {
        EyeWeapon = Class(ADFPhasonLaser) {},
        RightArmTractor = Class(ADFTractorClaw) {},
        LeftArmTractor = Class(ADFTractorClaw) {},
        
    },
    
    OnAnimCollision = function(self, bone, x, y, z)
        AWalkingLandUnit.OnAnimCollision(self, bone, x, y, z)
        
        
    end,
    --[[
        self.detector:WatchBone('Right_Leg_B02')
        self.detector:WatchBone('Left_Leg_B02')
        self.detector:WatchBone('Right_Arm_B02')
        self.detector:WatchBone('Left_Arm_B02')
        self.detector:WatchBone('Right_Arm_B01')
        self.detector:WatchBone('Left_Arm_B01')       
        ]]--    
        
    OnKilled = function(self, instigator, type, overkillRatio)
        AWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
        local wep = self:GetWeaponByLabel('EyeWeapon')
        local bp = wep:GetBlueprint()
        if bp.Audio.BeamStop then
            wep:PlaySound(bp.Audio.BeamStop)
        end
        if bp.Audio.BeamLoop and wep.Beams[1].Beam then
            wep.Beams[1].Beam:SetAmbientSound(nil, nil)
        end
        for k, v in wep.Beams do
            v.Beam:Disable()
        end     
    end,
        
    DeathThread = function( self, overkillRatio , instigator)
        self:PlayUnitSound('Destroyed')            
        explosion.CreateDefaultHitExplosionAtBone( self, 'Torso', 4.0 )
        WaitSeconds(0.2)                 
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B02', 1.0 )
        WaitSeconds(0.2)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Left_Arm_B02', 2.0 )
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Arm_B01', 1.0 )
                
        WaitSeconds(2.5)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B02', 1.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )
        WaitSeconds(0.1)
        self:PlayUnitSound('Destroyed')
        explosion.CreateDefaultHitExplosionAtBone( self, 'Left_Arm_B02', 3.0 )
        WaitSeconds(0.3)
        self:PlayUnitSound('Destroyed')
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Arm_B01', 1.0 )
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )
        local bp = self:GetBlueprint()
        for i, numWeapons in bp.Weapon do
            if(bp.Weapon[i].Label == 'CollossusDeath') then
                DamageArea(self, self:GetPosition(), bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end
        WaitSeconds(2.5)        
        self:PlayUnitSound('Destroyed')
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B02', 2.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Left_Arm_B02', 1.0 )
        WaitSeconds(0.3)
        self:PlayUnitSound('Destroyed')        
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Arm_B01', 1.0 )
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 2.0 )
        WaitSeconds(2)
        self:PlayUnitSound('Destroyed')
 
        explosion.CreateDefaultHitExplosionAtBone( self, 'Torso', 6.0 )  
        WaitSeconds(0.1)
        self:PlayUnitSound('Destroyed')

        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B02', 4.0 )               

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end

    
        self:DestroyAllDamageEffects()
        self:CreateWreckage( overkillRatio )

        # CURRENTLY DISABLED UNTIL DESTRUCTION
        # Create destruction debris out of the mesh, currently these projectiles look like crap,
        # since projectile rotation and terrain collision doesn't work that great. These are left in
        # hopes that this will look better in the future.. =)
        if( self.ShowUnitDestructionDebris and overkillRatio ) then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris( self, true, true, true )
            else #VAPORIZED
                self.CreateUnitDestructionDebris( self, true, true, true )
            end
        end

        self:PlayUnitSound('Destroyed')
        self:Destroy()
    end,
    
}

TypeClass = UAL0401