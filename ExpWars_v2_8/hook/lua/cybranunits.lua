--[[#######################################################################
#  File     :  /hook/lua/CybranUnits.lua
#  Author(s):  GPG Devs
#  Summary  :  Default definitions of Cybran units
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  14 décembre 2009
#  Rev.Date :  17 mars 2010  -- REMADE THIS FILE FOR BETTER HOOKING
#  Rev.Date :  07 avril 2010
#  Rev.Date :  28 mai 2010
#  Rev.Date :  15 juin 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

# ORIGINAL = 559 LIGNES

--[[
]]--
#######################################################################
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#######################################################################


#--------------------------------------------------------------------------
# CYBRAN DEFAULT UNITS
#--------------------------------------------------------------------------
local DefaultUnitsFile = import( MyModPath .. '/hook/lua/defaultunits.lua' )  --local DefaultUnitsFile = import('defaultunits.lua')
local AirStagingPlatformUnit = DefaultUnitsFile.AirStagingPlatformUnit
local AirUnit = DefaultUnitsFile.AirUnit
local ConcreteStructureUnit = DefaultUnitsFile.ConcreteStructureUnit
local ConstructionUnit = DefaultUnitsFile.ConstructionUnit
local EnergyStorageUnit = DefaultUnitsFile.EnergyStorageUnit
local SeaUnit = DefaultUnitsFile.SeaUnit
local ShieldLandUnit = DefaultUnitsFile.ShieldLandUnit
local ShieldStructureUnit = DefaultUnitsFile.ShieldStructureUnit
local StructureUnit = DefaultUnitsFile.StructureUnit
local RadarJammerUnit = DefaultUnitsFile.RadarJammerUnit

local EffectTemplate = import( '/lua/EffectTemplates.lua' )
local EffectUtil = import( '/lua/EffectUtilities.lua' )
local CreateCybranBuildBeams = EffectUtil.CreateCybranBuildBeams


# AJOUT ET MODIF DE MANIMAL
local EnergyCreationUnit = DefaultUnitsFile.EnergyCreationUnit
local HoverLandUnit = DefaultUnitsFile.HoverLandUnit
local LandUnit = DefaultUnitsFile.LandUnit
local MassCollectionUnit = DefaultUnitsFile.MassCollectionUnit
local MassFabricationUnit = DefaultUnitsFile.MassFabricationUnit
local MassStorageUnit = DefaultUnitsFile.MassStorageUnit
local RadarUnit = DefaultUnitsFile.RadarUnit
local SonarUnit = DefaultUnitsFile.SonarUnit
local SubUnit = DefaultUnitsFile.SubUnit
local TransportBeaconUnit = DefaultUnitsFile.TransportBeaconUnit
local WalkingLandUnit = DefaultUnitsFile.WalkingLandUnit
local WallStructureUnit = DefaultUnitsFile.WallStructureUnit


# AJOUT DE MANIMAL
local EW_DefaultUnits = import( MyModPath .. '/hook/lua/EW_DefaultUnits.lua' ) 

# MODIF DE MANIMAL
local AirFactoryUnit = EW_DefaultUnits.AirFactoryUnit
local LandFactoryUnit = EW_DefaultUnits.LandFactoryUnit
local QuantumGateUnit = EW_DefaultUnits.QuantumGateUnit
local SeaFactoryUnit = EW_DefaultUnits.SeaFactoryUnit
local SubFactoryUnit = EW_DefaultUnits.SubFactoryUnit

# AJOUT DE MANIMAL
local PortalFactoryUnit = EW_DefaultUnits.PortalFactoryUnit
local HeroWalkingLandUnit = EW_DefaultUnits.HeroWalkingLandUnit

# AJOUT DE MANIMAL
local LandResearchLabUnit = EW_DefaultUnits.LandResearchLabUnit
local AirResearchLabUnit = EW_DefaultUnits.AirResearchLabUnit
local NavalResearchLabUnit = EW_DefaultUnits.NavalResearchLabUnit




#-------------------------------------------------------------
#  AIR FACTORY STRUCTURES
#-------------------------------------------------------------
CAirFactoryUnit = Class(AirFactoryUnit) {

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        if not unitBeingBuilt then return end
        WaitSeconds( 0.1 )
        EffectUtil.CreateCybranFactoryBuildEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones, self.BuildEffectsBag )
    end,
    
    StartBuildFx = function(self, unitBeingBuilt)
        if not unitBeingBuilt then return end
        
        # Start build process
        if not self.BuildAnimManip then
            self.BuildAnimManip = CreateAnimator(self)
            self.BuildAnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild, true):SetRate(0)
            self.Trash:Add(self.BuildAnimManip)
        end
        self.BuildAnimManip:SetRate(1)
    end,
    
    StopBuildFx = function(self)
        if self.BuildAnimManip then
            self.BuildAnimManip:SetRate(0)
        end
    end,
    
    OnPaused = function(self)
        AirFactoryUnit.OnPaused(self)
        self:StopBuildFx()
    end,
    
    OnUnpaused = function(self)
        AirFactoryUnit.OnUnpaused(self)
        if self:GetNumBuildOrders(categories.ALLUNITS) > 0 and not self:IsUnitState('Upgrading') then
            self:StartBuildFx( self:GetFocusUnit() )
        end
    end,

    OnStartBuild = function( self, unitBeingBuilt, order )
        AirFactoryUnit.OnStartBuild( self, unitBeingBuilt, order )
        if order != 'Upgrade' then
            self:StartBuildFx( self:GetFocusUnit() )
        end
    end,
   
    OnFailedToBuild = function(self)
        AirFactoryUnit.OnFailedToBuild(self)
        self:StopBuildFx()
    end,

}


#-------------------------------------------------------------
#  AIR STAGING STRUCTURES
#-------------------------------------------------------------
CAirStagingPlatformUnit = Class( AirStagingPlatformUnit ) {}


#-------------------------------------------------------------
#  AIR UNITS
#-------------------------------------------------------------
CAirUnit = Class( AirUnit ) {}


#-------------------------------------------------------------
#  WALL  STRUCTURES
#-------------------------------------------------------------
CConcreteStructureUnit = Class(ConcreteStructureUnit) {}

#-------------------------------------------------------------
#  CONSTRUCTION UNITS
#-------------------------------------------------------------
CConstructionUnit = Class( ConstructionUnit ){


    OnStopBeingBuilt = function(self,builder,layer)
        ConstructionUnit.OnStopBeingBuilt(self,builder,layer)
        # If created with F2 on land, then play the transform anim.
        if(self:GetCurrentLayer() == 'Water') then
            self.TerrainLayerTransitionThread = self:ForkThread(self.TransformThread, true)
        end
    end,

    OnLayerChange = function(self, new, old)
        ConstructionUnit.OnLayerChange(self, new, old)
        if self:GetBlueprint().Display.AnimationWater then
            if self.TerrainLayerTransitionThread then
                self.TerrainLayerTransitionThread:Destroy()
                self.TerrainLayerTransitionThread = nil
            end
            if (new == 'Land') and (old != 'None') then
                self.TerrainLayerTransitionThread = self:ForkThread(self.TransformThread, false)
            elseif (new == 'Water') then
                self.TerrainLayerTransitionThread = self:ForkThread(self.TransformThread, true)
            end
        end
    end,

    TransformThread = function(self, water)
        
        if not self.TransformManipulator then
            self.TransformManipulator = CreateAnimator(self)
            self.Trash:Add( self.TransformManipulator )
        end

        if water then
            self.TransformManipulator:PlayAnim(self:GetBlueprint().Display.AnimationWater)
            self.TransformManipulator:SetRate(1)
            self.TransformManipulator:SetPrecedence(0)
        else
            self.TransformManipulator:SetRate(-1)
            self.TransformManipulator:SetPrecedence(0)
            WaitFor(self.TransformManipulator)
            self.TransformManipulator:Destroy()
            self.TransformManipulator = nil
        end
    end,
    
    CreateBuildEffects = function( self, unitBeingBuilt, order )
        local buildbots = EffectUtil.SpawnBuildBots( self, unitBeingBuilt, table.getn(self:GetBlueprint().General.BuildBones.BuildEffectBones), self.BuildEffectsBag )
        EffectUtil.CreateCybranEngineerBuildEffects( self, self:GetBlueprint().General.BuildBones.BuildEffectBones, buildbots, self.BuildEffectsBag )
    end,
}

#-------------------------------------------------------------
#  ENERGY CREATION UNITS
#-------------------------------------------------------------
CEnergyCreationUnit = Class( EnergyCreationUnit ) {
    
    OnStopBeingBuilt = function(self,builder,layer)
        DefaultUnitsFile.EnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        if self.AmbientEffects then
            for k, v in EffectTemplate[self.AmbientEffects] do
                CreateAttachedEmitter(self, 0, self:GetArmy(), v)
            end
        end
    end,
}

#-------------------------------------------------------------
# ENERGY STORAGE STRUCTURES
#-------------------------------------------------------------
CEnergyStorageUnit = Class( EnergyStorageUnit ) {}

#-------------------------------------------------------------
#  LAND FACTORY STRUCTURES
#-------------------------------------------------------------
CLandFactoryUnit = Class( LandFactoryUnit ) {
   
    CreateBuildEffects = function( self, unitBeingBuilt, order )
        if not unitBeingBuilt then return end
        WaitSeconds( 0.1 )
        EffectUtil.CreateCybranFactoryBuildEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones, self.BuildEffectsBag )
    end,   
   
    StartBuildFx = function(self, unitBeingBuilt)
        if not unitBeingBuilt then
            unitBeingBuilt = self:GetFocusUnit()
        end
        
        # Start build process
        if not self.BuildAnimManip then
            self.BuildAnimManip = CreateAnimator(self)
            self.BuildAnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild, true):SetRate(0)
            self.Trash:Add(self.BuildAnimManip)
        end

        self.BuildAnimManip:SetRate(1)
    end,
    
    StopBuildFx = function(self)
        if self.BuildAnimManip then
            self.BuildAnimManip:SetRate(0)
        end
    end,
    
    OnPaused = function(self)
        LandFactoryUnit.OnPaused(self)
        self:StopBuildFx(self:GetFocusUnit())
    end,

    OnUnpaused = function(self)
        LandFactoryUnit.OnUnpaused(self)
        if self:IsUnitState('Building') then
            self:StartBuildFx(self:GetFocusUnit())
        end
    end,
}

#-------------------------------------------------------------
#  LAND UNITS
#-------------------------------------------------------------
CLandUnit = Class( LandUnit ) {}

#-------------------------------------------------------------
#  MASS COLLECTION UNITS
#-------------------------------------------------------------
CMassCollectionUnit = Class( MassCollectionUnit ) {}

#-------------------------------------------------------------
#   MASS FABRICATION UNITS
#-------------------------------------------------------------
CMassFabricationUnit = Class( MassFabricationUnit ) {}

#-------------------------------------------------------------
#   MASS STORAGE UNITS
#-------------------------------------------------------------
CMassStorageUnit = Class( MassStorageUnit ) {}

#-------------------------------------------------------------
#  RADAR STRUCTURES
#-------------------------------------------------------------
CRadarUnit = Class( RadarUnit ) {}

#-------------------------------------------------------------
#  SONAR STRUCTURES
#-------------------------------------------------------------
CSonarUnit = Class( SonarUnit ) {}

#-------------------------------------------------------------
#  SEA FACTORY STRUCTURES
#-------------------------------------------------------------
CSeaFactoryUnit = Class( SeaFactoryUnit ) {
    
    StartBuildingEffects = function( self, unitBeingBuilt, order )
        self.BuildEffectsBag:Add( self:ForkThread( EffectUtil.CreateCybranBuildBeams, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag ) )
    end,

    OnPaused = function(self)
        SeaFactoryUnit.OnPaused(self)
        self:StopArmsMoving()
    end,
    
    OnUnpaused = function(self)
        SeaFactoryUnit.OnUnpaused(self)
        if self:GetNumBuildOrders(categories.ALLUNITS) > 0 and not self:IsUnitState('Upgrading') and self:IsUnitState('Building') then
            self:StartArmsMoving()
        end
    end,

    OnStartBuild = function( self, unitBeingBuilt, order )
        SeaFactoryUnit.OnStartBuild( self, unitBeingBuilt, order )
        if order != 'Upgrade' then
            self:StartArmsMoving()
        end
    end,
    
	--# Fixed up parameters
    OnStopBuild = function( self, unitBeingBuilt, order )
        SeaFactoryUnit.OnStopBuild( self, unitBeingBuilt, order )
        self:StopArmsMoving()
    end,

    OnFailedToBuild = function(self)
        SeaFactoryUnit.OnFailedToBuild(self)
        self:StopArmsMoving()
    end,
   
    StartArmsMoving = function(self)
        self.ArmsThread = self:ForkThread(self.MovingArmsThread)
    end,

    MovingArmsThread = function(self)
    end,
    
    StopArmsMoving = function(self)
        if self.ArmsThread then
            KillThread(self.ArmsThread)
            self.ArmsThread = nil
        end
    end,
}

#-------------------------------------------------------------
#  SEA UNITS
#-------------------------------------------------------------
CSeaUnit = Class(SeaUnit) {}


#-------------------------------------------------------------
#  SHIELD LAND UNITS
#-------------------------------------------------------------
CShieldLandUnit = Class(ShieldLandUnit) {}

#-------------------------------------------------------------
#  SHIELD STRUCTURES
#-------------------------------------------------------------
CShieldStructureUnit = Class(ShieldStructureUnit) {}

#-------------------------------------------------------------
#  STRUCTURES
#-------------------------------------------------------------
CStructureUnit = Class(StructureUnit) {}

#-------------------------------------------------------------
#  SUBMARINE UNITS
#-------------------------------------------------------------
CSubUnit = Class( SubUnit ) {}

#-------------------------------------------------------------
#  TRANSPORT BEACON UNITS
#-------------------------------------------------------------
CTransportBeaconUnit = Class( TransportBeaconUnit ) {}

#-------------------------------------------------------------
#  WALKING LAND UNITS
#-------------------------------------------------------------
CWalkingLandUnit = Class( WalkingLandUnit ) {
    WalkingAnimRate = 1,
    IdleAnimRate = 1,
    DisabledBones = {},
}

#-------------------------------------------------------------
#  WALL  STRUCTURES
#-------------------------------------------------------------
CWallStructureUnit = Class( WallStructureUnit ) {}

#-------------------------------------------------------------
#  CIVILIAN STRUCTURES
#-------------------------------------------------------------
CCivilianStructureUnit = Class( CStructureUnit ) {}

#-------------------------------------------------------------
#  QUANTUM GATE UNITS
#-------------------------------------------------------------
CQuantumGateUnit = Class( QuantumGateUnit ) {}

#-------------------------------------------------------------
#  RADAR JAMMER UNITS
#-------------------------------------------------------------
CRadarJammerUnit = Class( RadarJammerUnit ) {}


#-------------------------------------------------------------
#  EGG UNITS
#-------------------------------------------------------------

CConstructionEggUnit = Class( LandFactoryUnit ) { --###Correction Asdru : Ajout de LandFactoryUnit a la place de CStructureUnit parce que bug in game###--
    OnStopBeingBuilt = function(self, builder, layer)
        LandFactoryUnit.OnStopBeingBuilt(self,builder,layer)
        local bp = self:GetBlueprint()
        local buildUnit = bp.Economy.BuildUnit
        
        local pos = self:GetPosition()
        
        local aiBrain = self:GetAIBrain()
        CreateUnitHPR(
            buildUnit,
            aiBrain.Name,
            pos[1], pos[2], pos[3],
            0, 0, 0
        )
        ForkThread( function()
                        self.OpenAnimManip = CreateAnimator(self)
                        self.Trash:Add(self.OpenAnimManip)
                        self.OpenAnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen, false):SetRate(0.1)
                        
                        
                        
                        self:PlaySound(bp.Audio['EggOpen'])
                        WaitFor(self.OpenAnimManip)
                        
                        #CreateSlider(unit, bone, [goal_x, goal_y, goal_z, [speed,
                        self.EggSlider = CreateSlider(self, 0, 0, -20, 0, 5)
                        self.Trash:Add(self.EggSlider)
                        
                        self:PlaySound(bp.Audio['EggSink'])
                        WaitFor(self.EggSlider)
                        
                        self:Destroy()
                    end
                  )
        
        #ChangeState( self, self.EggConstruction )
    end,
    
    EggConstruction = State {
        Main = function(self)
            local bp = self:GetBlueprint()
            local buildUnit = bp.Economy.BuildUnit
            self:GetAIBrain():BuildUnit( self, buildUnit, 1 )
        end,
    },
    
    OnStopBuild = function( self, unitBeingBuilt, order )
        if unitBeingBuilt:GetFractionComplete() == 1 then
            ForkThread(function()
                WaitSeconds(0.1)
                self:Destroy()
            end)
        end
    end,
}


#TODO: This should be made more general and put in defaultunits.lua in case other factions get similar buildings
##############################################################
#  CConstructionStructureUnit
##############################################################
CConstructionStructureUnit = Class( CStructureUnit ) {   
    OnCreate = function(self)
        #-- Structure stuff
        CStructureUnit.OnCreate(self)

        #--Construction stuff   
        self.EffectsBag = {}
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end

        if self:GetBlueprint().Display.AnimationBuild then
            self.BuildingOpenAnim = self:GetBlueprint().Display.AnimationBuild
        end

        if self.BuildingOpenAnim then
            self.BuildingOpenAnimManip = CreateAnimator(self)
            self.BuildingOpenAnimManip:SetPrecedence(1)
            self.BuildingOpenAnimManip:PlayAnim(self.BuildingOpenAnim, false):SetRate(0)
            if self.BuildArmManipulator then
                self.BuildArmManipulator:Disable()
            end
        end
        self.BuildingUnit = false
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        local buildbots = EffectUtil.SpawnBuildBots( self, unitBeingBuilt, table.getn(self:GetBlueprint().General.BuildBones.BuildEffectBones), self.BuildEffectsBag )
        EffectUtil.CreateCybranEngineerBuildEffects( self, self:GetBlueprint().General.BuildBones.BuildEffectBones, buildbots, self.BuildEffectsBag )
    end,
    
    OnStartBuild = function( self, unitBeingBuilt, order )
        local unitid = self:GetBlueprint().General.UpgradesTo
        
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
                       
        CStructureUnit.OnStartBuild( self,unitBeingBuilt, order )
    end,
    
    #-- This will only be called if not in StructureUnit's upgrade state
    OnStopBuild = function( self,unitBeingBuilt, order )
        CStructureUnit.OnStopBuild( self,unitBeingBuilt, order )

        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil

        if self.BuildingOpenAnimManip and self.BuildArmManipulator then
            self.StoppedBuilding = true
        elseif self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end

        self.BuildingUnit = false
    end,
    
    OnStopBeingBuilt = function( self, builder, layer )
        CStructureUnit.OnStopBeingBuilt( self, builder, layer )
        # If created with F2 on land, then play the transform anim.
        if(self:GetCurrentLayer() == 'Water') then
            self.TerrainLayerTransitionThread = self:ForkThread(self.TransformThread, true)
        end
    end,
    
    OnPaused = function(self)
        #When factory is paused take some action
        self:StopUnitAmbientSound( 'ConstructLoop' )
        CStructureUnit.OnPaused(self)
        if self.BuildingUnit then
            CStructureUnit.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            self:PlayUnitAmbientSound( 'ConstructLoop' )
            CStructureUnit.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        CStructureUnit.OnUnpaused(self)
    end,
    
    StartBuildingEffects = function(self, unitBeingBuilt, order)
        CStructureUnit.StartBuildingEffects(self, unitBeingBuilt, order)
    end,
    
    StopBuildingEffects = function(self, unitBeingBuilt)
        CStructureUnit.StopBuildingEffects(self, unitBeingBuilt)
    end,
    
    WaitForBuildAnimation = function(self, enable)
        if self.BuildArmManipulator then
            WaitFor(self.BuildingOpenAnimManip)
            if (enable) then
                self.BuildArmManipulator:Enable()
            end
        end
    end,

    OnPrepareArmToBuild = function(self)
        CStructureUnit.OnPrepareArmToBuild(self)

        #LOG( 'OnPrepareArmToBuild' )
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(self:GetBlueprint().Display.AnimationBuildRate or 1)
            if self.BuildArmManipulator then
                self.StoppedBuilding = false
                ForkThread( self.WaitForBuildAnimation, self, true )
            end
        end
    end,

    OnStopBuilderTracking = function(self)
        CStructureUnit.OnStopBuilderTracking(self)

        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
        end
    end,
    
    CheckBuildRestriction = function(self, target_bp)
        if self:CanBuild(target_bp.BlueprintId) then
            return true
        else
            return false
        end
    end,
       
    CreateReclaimEffects = function( self, target )
		EffectUtil.PlayReclaimEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.ReclaimEffectsBag )
    end,
    
    CreateReclaimEndEffects = function( self, target )
        EffectUtil.PlayReclaimEndEffects( self, target )
    end,         
    
    CreateCaptureEffects = function( self, target )
		EffectUtil.PlayCaptureEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.CaptureEffectsBag )
    end,    
}


#############################################################################################
#############################################################################################
#     E X P   W A R S   v   2 
#############################################################################################
#############################################################################################


#-------------------------------------------------------------
#  SUB FACTORY STRUCTURES
#-------------------------------------------------------------
CSubFactoryUnit = Class( SubFactoryUnit ) {}



#-------------------------------------------------------------
#  PORTAL FACTORY STRUCTURES
#-------------------------------------------------------------


CPortalFactoryUnit = Class( PortalFactoryUnit ) {

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        if not unitBeingBuilt then return end
        WaitSeconds( 0.1 )
        EffectUtil.CreateCybranFactoryBuildEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones, self.BuildEffectsBag )
    end,
    
}   



#-------------------------------------------------------------
#  HERO WALKING LAND UNITS
#-------------------------------------------------------------

CHeroWalkingLandUnit = Class( HeroWalkingLandUnit ) {}


#-------------------------------------------------------------
#  LAND RESEARCH LAB UNITS
#-------------------------------------------------------------

CLandResearchLabUnit = Class( LandResearchLabUnit ) {}


#-------------------------------------------------------------
#  AIR RESEARCH LAB UNIT
#-------------------------------------------------------------

CAirResearchLabUnit = Class( AirResearchLabUnit ) {}


#-------------------------------------------------------------
#  NAVAL UNIT RESEARCH LAB
#-------------------------------------------------------------

CNavalResearchLabUnit = Class( NavalResearchLabUnit ) {}


