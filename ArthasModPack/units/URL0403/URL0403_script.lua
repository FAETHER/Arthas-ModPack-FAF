#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0402/URL0402_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Spider Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

#######################################################################
local Game = import('/lua/game.lua')

#VARIABLE ''GLOBALE'' (par Manimal)

#######################################################################


--local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

local DefaultUnitsFile = import( '/lua/defaultunits.lua' ) 
local WalkingLandUnit = DefaultUnitsFile.WalkingLandUnit

--local Weapon = import('/lua/sim/Weapon.lua').Weapon
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
--local CDFHeavyMicrowaveLaserGenerator = CybranWeaponsFile.CDFHeavyMicrowaveLaserGenerator
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon
local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CANTorpedoLauncherWeapon = CybranWeaponsFile.CANTorpedoLauncherWeapon
local Entity = import('/lua/sim/Entity.lua').Entity

local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon

local CollisionBeam = import( '/lua/sim/CollisionBeam.lua' ).CollisionBeam
local CollisionBeamFile = import( '/lua/defaultcollisionbeams.lua' )
local SCCollisionBeam = CollisionBeamFile.SCCollisionBeam

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

CDFHeavyMicrowaveLaserGenerator =  Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam01,
    FxMuzzleFlash = {'/effects/emitters/laserturret_muzzle_flash_01_emit.bp',},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.5,

    PlayFxWeaponUnpackSequence = function( self )
        if not self:EconomySupportsBeam() then return end
        local army = self.unit:GetArmy()
        local bp = self:GetBlueprint()
        for k, v in self.FxUpackingChargeEffects do
            for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do 
                CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)  
            end
        end
        DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
    end,
}


URL0403 = Class(WalkingLandUnit) {

    WalkingAnimRate = 1,
    IdleAnimRate = 1,
    DisabledBones = {},
	
 Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGenerator) {},
		ParticleGun = Class(CDFHvyProtonCannonWeapon) {},
		LaserTurretI = Class(CDFElectronBolterWeapon) {},
		LaserTurretII = Class(CDFElectronBolterWeapon) {},
		ParticleGunG = Class(CDFHvyProtonCannonWeapon) {},
		ParticleGunD = Class(CDFHvyProtonCannonWeapon) {},
		LaserTurretIII = Class(CDFElectronBolterWeapon) {},
		LaserTurretIV = Class(CDFElectronBolterWeapon) {},
		LaserTurretV = Class(CDFElectronBolterWeapon) {},
		LaserTurretVI = Class(CDFElectronBolterWeapon) {},
		LaserTurretVII = Class(CDFElectronBolterWeapon) {},
		LaserTurretVIII = Class(CDFElectronBolterWeapon) {},
		AntiAirMissileI = Class(CAAMissileNaniteWeapon) {},
		AntiAirMissileII = Class(CAAMissileNaniteWeapon) {},
		AntiAirMissileIII = Class(CAAMissileNaniteWeapon) {},
		AntiAirMissileIV = Class(CAAMissileNaniteWeapon) {},
    },
	

    OnStartBeingBuilt = function(self, builder, layer)
        WalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,
     
    OnStopBeingBuilt = function(self,builder,layer)
        WalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(0.7)
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end        
        self:SetMaintenanceConsumptionActive()
        local layer = self:GetCurrentLayer()
        self.WeaponsEnabled = true
    end,	
	
	
}

TypeClass = URL0403
