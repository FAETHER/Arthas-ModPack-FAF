#**************************************************************************** 
#** 
#**  File     :  ueb2201_b_script.lua 
#**  Author(s):  Resin_Smoker 
#** 
#**  Summary  :  Terran Ripper Gun Tower Script, "B" unit 
#** 
#**  Copyright © 2009 
#**************************************************************************** 

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFPlasmaCannonWeapon

ueb2201_b = Class(TStructureUnit) { 

    Weapons = {
        MainGun = Class(TDFPlasmaCannonWeapon){},
    },
    
    OnCreate = function(self,builder,layer) 
        TStructureUnit.OnCreate(self, builder, layer)
         ### Disables weapons 
         self:SetWeaponEnabledByLabel('MainGun', false)
    end, 

   OnScriptBitSet = function(self, bit) 
       TStructureUnit.OnScriptBitSet(self, bit) 
       if bit == 1 then 
           ### Calls the needed thread to spawn the turret 
           self:ForkThread(self.TurretSpawn) 
       end 
   end, 

   TurretSpawn = function(self) 
       ### Only spawns the Ripper "C" turret only if the Ripper "B" Structure is not dead 
       if not self:IsDead() then 

           ### Gets the current orientation of the Ripper "B" in the game world 
           local myOrientation = self:GetOrientation() 

           ### Gets the current position of the Ripper "B" in the game world 
           local location = self:GetPosition() 

           ### Gets the current health the Ripper "B" 
           local health = self:GetHealth() 

           ### Creates our Ripper "C" at the Ripper "B" location & direction 
           local ripperC = CreateUnit('ueb2201_C', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Land') 

           ### Passes the health of the Unit "B" to unit "C" 
           ripperC:SetHealth(self,health) 

           ### Nil's local ripperB 
           ripperC = nil 

           ###Ripper "B" removal scripts 
           self:Destroy() 
       end 
   end, 

   OnDamage = function(self, instigator, amount, vector, damagetype) 
       if self:IsDead() == false and not self:IsUnitState('Attached') and not self.SpawnTrigger then 
           ### 50% reduction while turret not deployed 
           self.DamageReduction = 0.5 
           amount = math.ceil(amount*self.DamageReduction) 
       end 

       if self:IsDead() == false and not self:IsUnitState('Attached') and not self.SpawnTrigger then 
           local maxHealth = self:GetMaxHealth () 
           local dmgHealth = self:GetHealth() 
           if dmgHealth <= maxHealth * 0.75 then 
               ### Calls the needed thread to spawn the turret if health drops below 50% 
               self.SpawnTrigger = true 
               self:ForkThread(self.TurretSpawn) 
           end 
       end 
       TStructureUnit.OnDamage(self, instigator, amount, vector, damagetype) 
   end, 
} 

TypeClass = ueb2201_b