#****************************************************************************
#** 
#**  File     :  ueb0209_script.lua 
#**  Author(s):  Resin_Smoker & Optimus_Prime 
#** 
#**  Summary  :  UEF Advanced Land Mine Script 
#** 
#**  Copyright © 2008 4TH Dimension.  All rights reserved.
#****************************************************************************
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local util = import('/lua/utilities.lua')
local CMobileKamikazeBombWeapon = import('/lua/cybranweapons.lua').CMobileKamikazeBombWeapon
local CMobileKamikazeBombDeathWeapon = import('/lua/cybranweapons.lua').CMobileKamikazeBombDeathWeapon

ueb0209 = Class(TStructureUnit) {
    DestroyOnKilled = false,
    Weapons = {
        DeathWeapon = Class(CMobileKamikazeBombDeathWeapon) {},   
        Suicide = Class(CMobileKamikazeBombWeapon) {        
            OnFire = function(self)			
                ### Disable death weapon after initial firing
                if not self.unit.AlreadyDetonated then
                    self.unit.AlreadyDetonated = true
                end
                self.unit:SetDeathWeaponEnabled(false)

                ### Detonation effects
                self.unit:MineDetonation()
                CMobileKamikazeBombWeapon.OnFire(self)
            end,
        },
    },

    OnCreate = function(self,builder,layer)
        TStructureUnit.OnCreate(self)
        ### enable cloaking and stealth  
        self:EnableIntel('Cloak') 
        self:EnableIntel('RadarStealth')
    end,

    DeathThread = function(self)
        ### Removes unused bones after the unit has detonated
        self:HideBone('ueb0209', true)

        ### Disables cloaking and stealth
        self:DisableIntel('Cloak') 
        self:DisableIntel('RadarStealth')

        ### Short delay to allow detonation effects to complete
        WaitSeconds(2)

        ### Removes the unwanted damage effects and whats left of the mine after detonation
        self:DestroyAllDamageEffects() 
        self:Destroy()
    end,

    OnDamage = function(self, instigator, amount, vector, damagetype)
        ### Detonate our mine should it be hit with damage greater then its current hitpoint total
        if IsUnit(instigator) and damagetype == 'Normal' then
            if amount >= self:GetHealth() then 
                if not self.AlreadyDetonated then
                    self.AlreadyDetonated = true
                    self:GetWeaponByLabel('Suicide'):FireWeapon()
                end
            end
        end
        TStructureUnit.OnDamage(self, instigator, amount, vector, damagetype)
    end,

    MineDetonation = function(self)
        ### Mine detonation and special effects
        self:ShakeCamera(6, 2.0, 1.0, 2)

        ### Explosion
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/cybran_kamibomb_hit_04_emit.bp'):ScaleEmitter(2.0):OffsetEmitter(0,0.1,0) 

        ### Concussion ring
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/destruction_explosion_concussion_ring_01_emit.bp'):ScaleEmitter(1.0):OffsetEmitter(0,0.1,0) 

        ### Debris from explosion
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/destruction_explosion_debris_01_emit.bp'):ScaleEmitter(1.0):OffsetEmitter(0,0.1,0) 
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/destruction_explosion_debris_02_emit.bp'):ScaleEmitter(1.0):OffsetEmitter(0,0.1,0) 
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/destruction_explosion_debris_03_emit.bp'):ScaleEmitter(1.0):OffsetEmitter(0,0.1,0) 
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/dirtchunks_01_emit.bp'):ScaleEmitter(2.0):OffsetEmitter(0,0.1,0) 
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/dust_cloud_05_emit.bp'):ScaleEmitter(2.0):OffsetEmitter(0,0.1,0) 

        ### Smoke
        CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/cybran_kamibomb_hit_11_emit.bp'):ScaleEmitter(1.0):OffsetEmitter(0,0.1,0) 

        ### Scorch marks
        local pos = self:GetPosition()
        CreateDecal( pos, util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', 5, 5, 100, 50, self:GetArmy() )
        CreateDecal( pos, util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', 8, 8, 100, 50, self:GetArmy() )
        DamageArea(self, pos, 8, 1, 'Force', false)
    end,
}

TypeClass = ueb0209

