#****************************************************************************
#**
#**  File     : /lua/terranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  TERRAN PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat
local DefaultExplosion = import('/lua/defaultexplosions.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Projectile = import('/lua/sim/projectile.lua').Projectile
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local util = import('/lua/utilities.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local MultiCompositeEmitterProjectile = DefaultProjectileFile.MultiCompositeEmitterProjectile
local NullShell = DefaultProjectileFile.NullShell
local MultiBeamProjectile = DefaultProjectileFile.MultiBeamProjectile

###############################################################################################
#			##		##		########		   ##	 		##			  ## 	##		##	  #
#			##		##		########		  ####			 ##			 ##		 ##	   ##	  #
#			## 	 	##		##				 ##	 ##			  ##		##		  ##  ##	  #
#			##########		########		##	  ##		   ##	   ##		   ####		  #
#			##########		########       ##########	        ##    ##			##        #
#			##		##		##			  ############			 ##  ##            ##         #
#			##		##		########	 ##	         ##           ####			  ##	      #
#			##	 	##		########	##			  ##		   ##			 ##			  #
###############################################################################################
#	#######		########	##########	 #########	   ####		##	 ###########   ########## #								 	
#	#########	########	##########	 #########	   #### 	##	 ###########   ########## #					 
#	##	   ##	##			##			 ##			   ## ##	##   ##            ##         # 
#	##	   ##	########	#######		 #########	   ##  ##   ##	 ###########   ########## #
#   ##     ##	########	#######      #########     ##   ##  ##   ###########   ########## #
#	##	   ##	##			##	         ##            ##    ## ##            ##   ##         #
#	#########   ########    ##			 #########     ##     ####   ###########   ########## #
#	#######		########	##			 #########	   ##	   ###   ###########   ########## #
###############################################################################################

#------------------------------------------------------------------------
#  TERRAN ORBITAL HEAVY PLASMA CANNON PROJECTILES
#------------------------------------------------------------------------
TOrbitalHeavyPlasmaCannonProjectile = Class(MultiPolyTrailProjectile) {
    FxTrails = EffectTemplate.TPlasmaCannonHeavyMunition,
	FxTrailScale = 9,   --TPlasmaCannonHeavyMunition02
    RandomPolyTrails = 5,
    PolyTrailOffset = {0,0,0},
    PolyTrails = EffectTemplate.TPlasmaCannonHeavyPolyTrails,
	PolyTrailsScale = 20,
	FxImpactAirUnit = EffectTemplate.TPlasmaCannonHeavyHitUnit01,    --EffectTemplate.TAAGinsuHitUnit
    FxAirUnitHitScale = 13,
}

#------------------------------------------------------------------------
#  CYBRAN ORBITAL HEAVY BOLTER CANNON PROJECTILES
#------------------------------------------------------------------------

COrbitalHeavyBolterCanonProjectile = Class(MultiPolyTrailProjectile) {

    PolyTrails = {
		'/effects/emitters/electron_bolter_trail_01_emit.bp',
		'/effects/emitters/default_polytrail_05_emit.bp',
	},
	PolyTrailOffset = {0,0},  
    FxTrails = {'/effects/emitters/electron_bolter_munition_02_emit.bp',},
	FxTrailScale = 4,
	
	# Hit Effects
	FxUnitHitScale = 20,
    FxImpactAirUnit = EffectTemplate.CElectronBolterHit04,
	FxAirUnitHitScale = 13,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        CreateLightParticle( self, -1, army, 12, 28, 'glow_03', 'ramp_proton_flash_02' )
        CreateLightParticle( self, -1, army, 8, 22, 'glow_03', 'ramp_antimatter_02' )
        if targetType == 'Terrain' then
            CreateSplat( self:GetPosition(), 0, 'scorch_011_albedo', 12, 12, 150, 200, army )
        end

        local blanketSides = 12
        local blanketAngle = (2*math.pi) / blanketSides
        local blanketStrength = 1
        local blanketVelocity = 6.25

        for i = 0, (blanketSides-1) do
            local blanketX = math.sin(i*blanketAngle)
            local blanketZ = math.cos(i*blanketAngle)
            self:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', blanketX, 0.5, blanketZ, blanketX, 0, blanketZ)
                :SetVelocity(blanketVelocity):SetAcceleration(-0.3)
        end

        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}


#------------------------------------------------------------------------
#  AEON ORBITAL HEAVY LAZER CANNON PROJECTILES
#------------------------------------------------------------------------

AOrbitalHeavyLazerProjectile = Class(MultiPolyTrailProjectile) {
	FxImpactTrajectoryAligned = false,
    PolyTrails = {
		'/effects/emitters/aeon_laser_trail_02_emit.bp',
		'/effects/emitters/default_polytrail_03_emit.bp',
	},
	PolyTrailOffset = {0,0},
	--PolyTrailScale = 10,
	FxTrails = {
        '/effects/emitters/oblivion_cannon_munition_01_emit.bp',
        '/effects/emitters/quantum_cannon_munition_04_emit.bp',
    },
	--FxTrails = {'/effects/emitters/oblivion_cannon_munition_01_emit.bp'},
	--FxTrails = EffectTemplate.AMiasmaMunition01,
	FxTrailScale = 10,
	
# Hit Effects
    FxImpactUnit = EffectTemplate.AQuarkBombHitUnit01,
    FxImpactProp = EffectTemplate.AQuarkBombHitUnit01,
    FxImpactAirUnit = EffectTemplate.AQuarkBombHitAirUnit01,
    FxImpactLand = EffectTemplate.AQuarkBombHitLand01,
	FxAirUnitHitScale = 5,
    FxImpactUnderWater = {},
    FxSplatScale = 5,

    OnImpact = function(self, TargetType, targetEntity)
        CreateLightParticle(self, -1,self:GetArmy(), 26, 6, 'sparkle_white_add_08', 'ramp_white_02' )
        DefaultExplosion.CreateScorchMarkSplat( self, 3 )

        EmitterProjectile.OnImpact( self, TargetType, targetEntity )
    end,
}

#------------------------------------------------------------------------
#  SERAPHIM HEAVY QUARNON ORBITAL CANNON
#------------------------------------------------------------------------

SHeavyQuarnonOrbitalCannon = Class(MultiPolyTrailProjectile) {
    FxImpactNone = EffectTemplate.SHeavyQuarnonCannonHit,   
    FxImpactAirUnit = EffectTemplate.SHeavyQuarnonCannonUnitHit,
    PolyTrails = EffectTemplate.SHeavyQuarnonCannonProjectilePolyTrails,
	PolyTrailsScale = 5,
    PolyTrailOffset = {0,0,0},
    FxTrails = EffectTemplate.SHeavyQuarnonCannonProjectileFxTrails,
	FxTrailScale = 5,
	FxAirUnitHitScale = 5,
}

###############################################################################################
###############################################################################################
###############                     AIR DROP								 ##################
###############################################################################################
###############################################################################################

TShieldProjectile = Class(SinglePolyTrailProjectile) {
    DestroyOnImpact = false,
    FxTrails = EffectTemplate.TMissileExhaust02,
    FxTrailOffset = -1,
    BeamName = '/effects/emitters/missile_munition_exhaust_beam_01_emit.bp',

    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactUnderWater = {},

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
    end,

}

###############################################################################################
###############################################################################################
###############                     ARTY TECH 02							 ##################
###############################################################################################
###############################################################################################

TArtilleryAntiMatterSmallProjectile = Class(SinglePolyTrailProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_07_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.TShipGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.TShipGaussCannonHit01,
    FxImpactLand = EffectTemplate.TShipGaussCannonHit01,
    FxLandHitScale = 1.5,
	FxUnitHitScale = 1.5,
	FxPropHitScale = 1.5,
    FxImpactUnderWater = {},
    FxSplatScale = 1.8,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale, self.FxSplatScale, 150, 50, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 2, self.FxSplatScale * 2, 150, 50, army )
            --self:ShakeCamera(20, 1, 0, 1)
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
		DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

###############################################################################################
###############################################################################################
###############                     AEON MISSILE LAUNCHER EMP				 ##################
###############################################################################################
###############################################################################################

AMissileSerpentine01Projectile = Class(SingleCompositeEmitterProjectile) {
    PolyTrail = '/effects/emitters/serpentine_missile_trail_emit.bp',
    BeamName = '/effects/emitters/serpentine_missle_exhaust_beam_01_emit.bp',
	FxTrails = {'/effects/emitters/oblivion_cannon_munition_01_emit.bp'},
    PolyTrailOffset = -0.05,
	PolyTrailScale = 3,
	FxTrailsScale = 3,

    FxImpactUnit = EffectTemplate.AOblivionCannonHit01,
    FxImpactProp = EffectTemplate.AOblivionCannonHit01,
    FxImpactLand = EffectTemplate.AOblivionCannonHit01,
    FxImpactUnderWater = {},
    FxUnitHitScale = 5,
    FxLandHitScale = 5,
    FxWaterHitScale = 5,
    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 10.0)
        SingleCompositeEmitterProjectile.OnCreate(self)
    end,

}

###############################################################################################
###############################################################################################
###############                     CYBRAN MISSILE  EMP						 ##################
###############################################################################################
###############################################################################################

CEMPMissileProjectile = Class(SingleCompositeEmitterProjectile) {
    # Emitter Values
    FxInitial = {},
    TrailDelay = 1,
	FxTrailScale = 5,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = -0.1,

    BeamName = '/effects/emitters/missile_sam_munition_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 2,
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,    
    FxLandHitScale = 2,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},

    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleBeamProjectile.OnCreate(self)
    end,
}
