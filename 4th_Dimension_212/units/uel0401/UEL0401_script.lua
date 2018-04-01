#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

# This unit needs to not be allowed to build while underwater
# Additionally, if it goes underwater while building it needs to cancel the
# current order

### cALLED LUA, EFFECTS AND UTILITIES ###
local TMobileFactoryUnit = import('/lua/terranunits.lua').TMobileFactoryUnit
local utilities = import('/lua/utilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateUEFBuildSliceBeams = EffectUtil.CreateUEFBuildSliceBeams
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone

### wEAPONS ###
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler



UEL0401 = Class(TMobileFactoryUnit) {
   Weapons = {
       RightTurret01 = Class(TDFGaussCannonWeapon) {},
       RightTurret02 = Class(TDFGaussCannonWeapon) {},
       LeftTurret01 = Class(TDFGaussCannonWeapon) {},
       LeftTurret02 = Class(TDFGaussCannonWeapon) {},
       RightRiotgun = Class(TDFRiotWeapon) {
           FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
       },
       LeftRiotgun = Class(TDFRiotWeapon) {
           FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
       },
       RightAAGun = Class(TAALinkedRailgun) {},
       LeftAAGun = Class(TAALinkedRailgun) {},
       Torpedo = Class(TANTorpedoAngler) {},
   },

   FxDamageScale = 2.5,
   PrepareToBuildAnimRate = 5,
   BuildAttachBone = 'Build_Attachpoint',

   BuildBones = {
       BuildEffectBones = { 'Arm_Right01_Build_Emitter','Arm_Right02_Build_Emitter','Arm_Right03_Build_Emitter',
                            'Arm_Left01_Build_Emitter','Arm_Left02_Build_Emitter','Arm_Left03_Build_Emitter',},
   },

MechDestructionEffectBones = {
 'UEL0401','Turret_Right01','Turret_Right02','Turret_Left01','Turret_Left01','Turret_Right_AA','Turret_Left_AA','Riot_Gun_Right','Riot_Gun_Left','Turret_Right_AA_Barrel','Turret_Left_AA_Barrel','Riot_Gun_Right_Barrel','Riot_Gun_Left_Barrel','Front_Core','Rear_Core','Wheel_Left01','Wheel_Left02','Wheel_Right01','Wheel_Right02','Bay_Lower','Bay_Cover','Ramp','Arm_Right01','Arm_Right02','Arm_Left01','Arm_Left02',
       },    
   
   RollOffBones = { 'Arm_Right03_Build_Emitter', 'Arm_Left03_Build_Emitter',},

   OnStopBeingBuilt = function(self,builder,layer)
       TMobileFactoryUnit.OnStopBeingBuilt(self,builder,layer)
       self.EffectsBag = {}
       self.PrepareToBuildManipulator = CreateAnimator(self)
       self.PrepareToBuildManipulator:PlayAnim(self:GetBlueprint().Display.AnimationBuild, false):SetRate(0)
       self.ReleaseEffectsBag = {}
       self.Moving = false
       self:ForkThread(self.HeartBeatCrushCheck)
       ChangeState(self, self.IdleState)
   end,

   HeartBeatCrushCheck = function(self)
       ### Checks to see if the Fatboy is moving and if so apply damage to the area under it
       while self and not self:IsDead() do
           WaitSeconds(1)
           if not self:IsDead() and self.Moving == true then
               self.FatboyPos = self:GetPosition()
               local radius = 5  
               local targetlist = utilities.GetEnemyUnitsInSphere(self, self.FatboyPos, radius)
               if table.getsize (targetlist) > 0 then
                   # Apply damage
                   DamageRing(self, self.FatboyPos, 0.1, 5, 10000, 'Normal', false)
                   # Create ground decals
                   local orientation = utilities.GetRandomFloat( 0, 2 * math.pi )
                   CreateDecal(self.FatboyPos, orientation, 'nuke_scorch_003_albedo', '', 'Albedo', 5, 5, 50, 0, self:GetArmy())
               end
           end
       end
   end,

   OnMotionHorzEventChange = function(self, new, old)
       ###Updates the gloabal variable for when the Fatboys movement changes
       if not self:IsDead() and new == 'Stopped' then
           self.Moving = false
       elseif not self:IsDead() then
           self.Moving = true
       end              
       TMobileFactoryUnit.OnMotionHorzEventChange(self, new, old)
   end,

   OnFailedToBuild = function(self)
       TMobileFactoryUnit.OnFailedToBuild(self)
       ChangeState(self, self.IdleState)
   end,

   OnLayerChange = function(self, new, old)
       TMobileFactoryUnit.OnLayerChange(self, new, old)
       if new == 'Land' then
           self:RestoreBuildRestrictions()
           self:RequestRefreshUI()
       elseif new == 'Seabed' then
           self:AddBuildRestriction(categories.ALLUNITS)
           self:RequestRefreshUI()
       end
   end,
   OnCreate = function(self,builder,layer)
       TMobileFactoryUnit.OnCreate(self)

       # Creating Global Variables
       Army = self:GetArmy()
   end,
   IdleState = State {
       OnStartBuild = function(self, unitBuilding, order)
           TMobileFactoryUnit.OnStartBuild(self, unitBuilding, order)
           self.UnitBeingBuilt = unitBuilding
           self.PrepareToBuildManipulator:SetRate(self.PrepareToBuildAnimRate)
           ChangeState(self, self.BuildingState)
       end,

       Main = function(self)
           self.PrepareToBuildManipulator:SetRate(-self.PrepareToBuildAnimRate)
           self:DetachAll(self.BuildAttachBone)
           self:SetBusy(false)
       end,

   },


   BuildingState = State {

       Main = function(self)
           local unitBuilding = self.UnitBeingBuilt
           self.PrepareToBuildManipulator:SetRate(self.PrepareToBuildAnimRate)
           self:SetBusy(true)
           local bone = self.BuildAttachBone
           self:DetachAll(bone)
           if not self.UnitBeingBuilt:IsDead() then
               unitBuilding:AttachBoneTo( -2, self, bone )
               if self.AttachmentSliderManip == nil then
                   self.AttachmentSliderManip = CreateSlider(self, self.BuildAttachBone)
               end
               local unitHeight = unitBuilding:GetBlueprint().SizeY
               self.AttachmentSliderManip:SetGoal(0, unitHeight, 0 )
               self.AttachmentSliderManip:SetSpeed(-1)
           end
           WaitFor( self.PrepareToBuildManipulator )
           local unitBuilding = self.UnitBeingBuilt
           self.UnitDoneBeingBuilt = false
       end,

       OnStopBuild = function(self, unitBeingBuilt)
           TMobileFactoryUnit.OnStopBuild(self, unitBeingBuilt)

           ChangeState(self, self.RollingOffState)
       end,

   },

   RollingOffState = State {

       Main = function(self)
           self:SetBusy(true)
           self:CreateRollOffEffects()
           self.AttachmentSliderManip:SetSpeed(10)
           self.AttachmentSliderManip:SetGoal(0, 0, 17)
           WaitFor( self.AttachmentSliderManip )
           self.AttachmentSliderManip:SetGoal(0, -3, 17)
           WaitFor( self.AttachmentSliderManip )
           local unitBuilding = self.UnitBeingBuilt
           if not unitBuilding:IsDead() then
               unitBuilding:DetachFrom(true)
               self:DetachAll(self.BuildAttachBone)
               local  worldPos = self:CalculateWorldPositionFromRelative({0, 0, -15})
               IssueMoveOffFactory({unitBuilding}, worldPos)
           end
           if self.AttachmentSliderManip then
               self.AttachmentSliderManip:Destroy()
               self.AttachmentSliderManip = nil
           end
           self:DestroyRollOffEffects()
           self:SetBusy(false)
           ChangeState(self, self.IdleState)
       end,
   },

   CreateRollOffEffects = function(self)
       local army = self:GetArmy()
       local unitB = self.UnitBeingBuilt
       for k, v in self.RollOffBones do
           local fx = AttachBeamEntityToEntity(self, v, unitB, -1, army, EffectTemplate.TTransportBeam01)
           table.insert( self.ReleaseEffectsBag, fx)
           self.Trash:Add(fx)
           fx = AttachBeamEntityToEntity( unitB, -1, self, v, army, EffectTemplate.TTransportBeam02)
           table.insert( self.ReleaseEffectsBag, fx)
           self.Trash:Add(fx)
           fx = CreateEmitterAtBone( self, v, army, EffectTemplate.TTransportGlow01)
           table.insert( self.ReleaseEffectsBag, fx)
           self.Trash:Add(fx)
       end
   end,

   DestroyRollOffEffects = function(self)
       for k, v in self.ReleaseEffectsBag do
           v:Destroy()
       end
       self.ReleaseEffectsBag = {}
       if not self.UnitBeingBuilt:IsDead() then
           IssueGuard({self.UnitBeingBuilt}, self)
       end
   end,    
   
}

TypeClass = UEL0401