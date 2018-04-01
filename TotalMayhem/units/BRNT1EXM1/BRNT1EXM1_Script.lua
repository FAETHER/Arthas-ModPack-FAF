----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Scavenger Medium Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRNT1EXM1 = Class(TLandUnit) {

    Weapons = {
        autoattack = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.0,
        },
        MainGun = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 1.5,
            FxMuzzleFlash = {
                '/effects/emitters/proton_artillery_muzzle_01_emit.bp',
                '/effects/emitters/proton_artillery_muzzle_03_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
            FxGroundEffect = EffectTemplate.ConcussionRingLrg01,
            FxVentEffect3 = EffectTemplate.CDisruptorGroundEffect,
            FxVentEffect = EffectTemplate.CDisruptorVentEffect,
            FxVentEffect2 = EffectTemplate.WeaponSteam01,
            FxVentEffect4 = EffectTemplate.THeavyFragmentationGrenadeHit,
            FxMuzzleEffect = EffectTemplate.TGaussCannonFlash,
            FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()
                for k, v in self.FxGroundEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT1EXM1', army, v):ScaleEmitter(1.2))
                end
                for k, v in self.FxVentEffect3 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'BRNT1EXM1', army, v):ScaleEmitter(1.0))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(2.15))
                end
                for k, v in self.FxMuzzleEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle2', army, v):ScaleEmitter(2.15))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent01', army, v):ScaleEmitter(1.2))
                end
                for k, v in self.FxVentEffect do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'vent02', army, v):ScaleEmitter(1.2))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(1.15))
                end
                for k, v in self.FxVentEffect2 do
                    self.unit.Trash:Add(CreateAttachedEmitter(self.unit, 'Turret_Muzzle', army, v):ScaleEmitter(1.15))
                end
            end,
        },
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.45,
        },
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0.45,
        },
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TLandUnit.OnStopBeingBuilt(self,builder,layer)
        self.SetAIAutoattackWeapon(self)
    end,

    OnDetachedFromTransport = function(self, transport, bone)
        TLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,

    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,

}

TypeClass = BRNT1EXM1