#****************************************************************************
#**
#**  File     :  /cdimage/lua/modules/modweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos modified by Asdrubaelvect
#**
#**  Summary  :  Mod specific weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local CollisionBeamFile = import('/mods/ExpWars_1/hook/lua/defaultcollisionbeams.lua')


--ANTI ORBITAL LOURD TEK1
TIFArtillery01Weapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
}

CDFHeavyElectronBolter01Weapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash02,
}

ADFCannonOblivion01Weapon = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = EffectTemplate.AOblivionCannonMuzzleFlash02,
    FxChargeMuzzleFlash = EffectTemplate.AOblivionCannonChargeMuzzleFlash02,

}
########################
#Anti Nuke Experimental#
########################
CDFHeavyMicrowaveLaserGeneratorCom = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectsScale = 5,
	FxUpackingChargeEffectScale = 5,
	FxMuzzleFlashScale = 5,
	FxChargeMuzzleFlash = 5,

}