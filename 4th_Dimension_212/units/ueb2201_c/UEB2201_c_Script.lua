#****************************************************************************
#**
#**  File     :  ueb2201_c_script.lua
#**  Author(s):  Resin_Smoker
#**
#**  Summary  :  Terran Ripper Gun Tower Script, "C" unit
#**
#**  Copyright © 2009
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFPlasmaCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

ueb2201_c = Class(TStructureUnit) {
    Weapons = {
        MainGun = Class(TDFPlasmaCannonWeapon) 
        {     
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'barrel', 'z', nil, 270, 500, 250)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(1000)
                end
                TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            FxChassisMuzzleFlash = {'/effects/emitters/phalanx_shells_01_emit.bp',},

            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit:GetArmy()			
                for k, v in self.FxChassisMuzzleFlash do
                    CreateAttachedEmitter(self.unit, 'eject', army, v):ScaleEmitter(0.5)
                end
            end,             
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'barrel', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = TDFPlasmaCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(2000)
                end
            end,

            OnLostTarget = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'barrel', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TDFPlasmaCannonWeapon.OnLostTarget(self)
            end,
        },
    },

    OnCreate = function(self,builder,layer)
        TStructureUnit.OnCreate(self,builder,layer)
        if not self:IsDead() then
            ### Disables weapons 
            self:SetWeaponEnabledByLabel('MainGun', false)

            ### Global Varibles 
            self.HitsTaken = 0
            self.DmgTotal = 0
            
            #Sets up radar economy
            self:SetMaintenanceConsumptionActive()
            self:SetScriptBit('RULEUTC_IntelToggle', false)

            ### Unpacks our unit 
            self:ForkThread(self.WeaponUnpackDelay)
        end 
    end,

    WeaponUnpackDelay = function(self)
        if not self:IsDead() then

            ### Enables weapons after a short delay to allow the turrets supports to extend
            WaitSeconds(2.5)
            if not self:IsDead() then
                self:SetWeaponEnabledByLabel('MainGun', true)

                ### Sets up global variables and heartbeat checks
                self.MyTarget = {}
            end
        end 
    end,

    OnDamage = function(self, instigator, amount, vector, damagetype) 
        ### Check to make sure that the ripper isn't already dead and what just damaged it is a unit we can attack
        if self:IsDead() == false and instigator and IsUnit(instigator) then 

            ### Update of global Variables 
            self.HitsTaken = self.HitsTaken + 1 
            self.DmgTotal = self.DmgTotal + amount 

            ### Attack trigger command 
            if self.DmgTotal >= 500 or self.HitsTaken >= 50 then

               ###Issues the retaliation command to the ripper
               if table.find(instigator:GetBlueprint().Categories,'LAND') or table.find(instigator:GetBlueprint().Categories,'STRUCTURE') or table.find(instigator:GetBlueprint().Categories,'AIR') or table.find(instigator:GetBlueprint().Categories,'NAVAL') then
                    IssueAttack(self, instigator)
               end 

               ### Reset of global Variables 
               self.HitsTaken = 0 
               self.DmgTotal = 0 

            end
        end 
    TStructureUnit.OnDamage(self, instigator, amount, vector, damagetype) 
    end,
}

TypeClass = ueb2201_c