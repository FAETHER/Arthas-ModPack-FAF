#****************************************************************************
#**
#**  File     :  /lua/cybranweapons.lua
#**  Author(s):  David Tomandl, John Comes, Gordon Duclos
#**
#**  Summary  :  Cybran weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

# ORIGINAL = LIGNES

--[[
]]--
#######################################################################
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#######################################################################

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local CollisionBeamFile = import( MyModPath .. '/hook/lua/defaultcollisionbeams.lua' )
local TractorClawCollisionBeam = CollisionBeamFile.TractorClawCollisionBeam
local TractorClawCollisionBeam02 = CollisionBeamFile.TractorClawCollisionBeam02
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Explosion = import('/lua/defaultexplosions.lua')
local Util = import('/lua/utilities.lua')


CDFHvyBFGWeapon = Class(DefaultProjectileWeapon) {
    FxChargeMuzzleFlash = {
		'/effects/emitters/disintegrator_muzzle_charge_01_emit.bp',		
		'/effects/emitters/disintegrator_muzzle_charge_02_emit.bp',
		'/effects/emitters/disintegrator_muzzle_charge_03_emit.bp',
		'/effects/emitters/disintegrator_muzzle_charge_04_emit.bp',
        '/effects/emitters/disintegrator_muzzle_charge_05_emit.bp',
    },
	FxChargeMuzzleFlashScale = 4,

    FxMuzzleFlash = {

		
		'/effects/emitters/disintegratorhvy_muzzle_flash_01_emit.bp',
		'/effects/emitters/disintegratorhvy_muzzle_flash_02_emit.bp',
		'/effects/emitters/disintegratorhvy_muzzle_flash_03_emit.bp',
		'/effects/emitters/disintegratorhvy_muzzle_flash_04_emit.bp',
		'/effects/emitters/disintegratorhvy_muzzle_flash_05_emit.bp',
		
		'/effects/emitters/disintegrator_muzzle_flash_04_emit.bp',
        '/effects/emitters/disintegrator_muzzle_flash_05_emit.bp',
		'/effects/emitters/disintegrator_muzzle_flash_01_emit.bp',
		'/effects/emitters/laserturret_muzzle_flash_01_emit.bp',
		'/effects/emitters/disintegrator_muzzle_flash_02_emit.bp',
		'/effects/emitters/disintegrator_muzzle_flash_03_emit.bp',
	},
	FxMuzzleFlashScale = 4,
}
--[[





]]--
