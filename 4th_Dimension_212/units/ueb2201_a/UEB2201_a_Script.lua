#**************************************************************************** 
#** 
#**  File     :  ueb2201_a_script.lua 
#**  Author(s):  Resin_Smoker 
#** 
#**  Summary  :  Terran Ripper Gun Tower Script, "A" unit 
#** 
#**  Copyright © 2009 
#**************************************************************************** 

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit 
local TDFPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFPlasmaCannonWeapon

ueb2201_a = Class(TStructureUnit) { 

    Weapons = {
        MainGun = Class(TDFPlasmaCannonWeapon){},
    },

    OnStopBeingBuilt = function(self, builder, layer) 
        TStructureUnit.OnStopBeingBuilt(self, builder, layer)
         ### Disables weapons 
         self:SetWeaponEnabledByLabel('MainGun', false)
         
         ### Calls the needed thread to spawn the turret 
         self.SpawnTrigger = true 
         self:ForkThread(self.TurretSpawn) 
    end, 

    TurretSpawn = function(self) 
        ### Only spawns the Ripper "B" turret only if the Ripper "A" Structure is not dead 
        if not self:IsDead() then 

            ### Gets the current orientation of the Ripper "A" in the game world 
            local myOrientation = self:GetOrientation() 

            ### Gets the current position of the Ripper "A" in the game world 
            local location = self:GetPosition() 

            ### Gets the current health the Ripper "A" 
            local health = self:GetHealth() 

            ### Creates our Ripper "B" at the Ripper "A" location & direction 
            local ripperB = CreateUnit('ueb2201_b', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Land') 

            ### Passes the health of the Unit "A" to unit "B" 
            ripperB:SetHealth(self,health) 

            ### Nil's local ripperB 
            ripperB = nil 
  
            ###Ripper "A" removal scripts 
            self:Destroy() 
        end 
    end, 

    OnDamage = function(self, instigator, amount, vector, damagetype) 
        if self:IsDead() == false and not self.SpawnTrigger then 
            ### 50% reduction while turret not deployed 
            self.DamageReduction = 0.5 
            amount = math.ceil(amount*self.DamageReduction) 
        end 
        TStructureUnit.OnDamage(self, instigator, amount, vector, damagetype) 
    end, 
} 

TypeClass = ueb2201_a