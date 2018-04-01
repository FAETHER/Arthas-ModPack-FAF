--[[#######################################################################
#  File     :  /hook/lua/aeonunits.lua
#  Author(s):  John Comes, Dave Tomandl, Gordon Duclos
#  Summary  :  Definitions of Terran units
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  26 novembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  14 décembre 2009
#  Rev.Date :  17 mars 2010
#  Rev.Date :  07 avril 2010
#  Rev.Date :  28 mai 2010
#  Rev.Date :  26 juin 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

--[[
]]--

#######################################################################
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#######################################################################


#--------------------------------------------------------------------------
# AEON DEFAULT UNITS
#--------------------------------------------------------------------------

local DefaultUnitsFile = import( MyModPath .. '/hook/lua/defaultunits.lua' )  --local DefaultUnitsFile = import('defaultunits.lua')

local AirStagingPlatformUnit = DefaultUnitsFile.AirStagingPlatformUnit
local AirUnit = DefaultUnitsFile.AirUnit
local ConcreteStructureUnit = DefaultUnitsFile.ConcreteStructureUnit
local ConstructionUnit = DefaultUnitsFile.ConstructionUnit
local EnergyCreationUnit = DefaultUnitsFile.EnergyCreationUnit
local EnergyStorageUnit = DefaultUnitsFile.EnergyStorageUnit
local MassCollectionUnit = DefaultUnitsFile.MassCollectionUnit
local MassFabricationUnit = DefaultUnitsFile.MassFabricationUnit
local MassStorageUnit = DefaultUnitsFile.MassStorageUnit
local RadarUnit = DefaultUnitsFile.RadarUnit
local ShieldHoverLandUnit = DefaultUnitsFile.ShieldHoverLandUnit
local ShieldLandUnit = DefaultUnitsFile.ShieldLandUnit
local ShieldStructureUnit = DefaultUnitsFile.ShieldStructureUnit
local SonarUnit = DefaultUnitsFile.SonarUnit
local StructureUnit = DefaultUnitsFile.StructureUnit
local RadarJammerUnit = DefaultUnitsFile.RadarJammerUnit

local EffectTemplate = import( '/lua/EffectTemplates.lua' )
local EffectUtil = import( '/lua/EffectUtilities.lua' )
local CreateAeonFactoryBuildingEffects = EffectUtil.CreateAeonFactoryBuildingEffects


# AJOUT ET MODIF DE MANIMAL
local HoverLandUnit = DefaultUnitsFile.HoverLandUnit
local LandUnit = DefaultUnitsFile.LandUnit
local SeaUnit = DefaultUnitsFile.SeaUnit
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
local HeroWalkingLandUnit = EW_DefaultUnits.HeroWalkingLandUnit
local PortalFactoryUnit = EW_DefaultUnits.PortalFactoryUnit

# AJOUT DE MANIMAL
local AirResearchLabUnit = EW_DefaultUnits.AirResearchLabUnit
local LandResearchLabUnit = EW_DefaultUnits.LandResearchLabUnit
local NavalResearchLabUnit = EW_DefaultUnits.NavalResearchLabUnit




#-------------------------------------------------------------
#  AIR STRUCTURES
#-------------------------------------------------------------
AAirFactoryUnit = Class( AirFactoryUnit ) {
    StartBuildFx = function( self, unitBeingBuilt )
        local thread = self:ForkThread( EffectUtil.CreateAeonFactoryBuildingEffects, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, 'Attachpoint', self.BuildEffectsBag )
        unitBeingBuilt.Trash:Add( thread )        
    end,
}

#-------------------------------------------------------------
#  AIR UNITS
#-------------------------------------------------------------
AAirUnit = Class(AirUnit) {}

#-------------------------------------------------------------
#  AIR STAGING STRUCTURES
#-------------------------------------------------------------
AAirStagingPlatformUnit = Class(AirStagingPlatformUnit) {}

#-------------------------------------------------------------
#  WALL  STRUCTURES
#-------------------------------------------------------------
AConcreteStructureUnit = Class(ConcreteStructureUnit) {
    AdjacencyBeam = false,

}

#-------------------------------------------------------------
#  Construction Units
#-------------------------------------------------------------
AConstructionUnit = Class(ConstructionUnit) {
    CreateBuildEffects = function( self, unitBeingBuilt, order )
        EffectUtil.CreateAeonConstructionUnitBuildingEffects( self, unitBeingBuilt, self.BuildEffectsBag )
    end,  
}


#-------------------------------------------------------------
#  ENERGY CREATION UNITS
#-------------------------------------------------------------
AEnergyCreationUnit = Class(EnergyCreationUnit) {

    OnCreate = function(self)
        EnergyCreationUnit.OnCreate(self)
        self.NumUsedAdjacentUnits = 0
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        EnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        local army =  self:GetArmy()
        if self.AmbientEffects then
            for k, v in EffectTemplate[self.AmbientEffects] do
                CreateAttachedEmitter(self, 0, army, v)
            end
        end
    end,
}

#-------------------------------------------------------------
# ENERGY STORAGE STRUCTURES
#-------------------------------------------------------------
AEnergyStorageUnit = Class(EnergyStorageUnit) {
}

#-------------------------------------------------------------
#  HOVERING LAND UNITS
#-------------------------------------------------------------
AHoverLandUnit = Class( HoverLandUnit ) {
    FxHoverScale = 1,
    HoverEffects = nil,
    HoverEffectBones = nil,
}

#-------------------------------------------------------------
#  LAND FACTORY STRUCTURES
#-------------------------------------------------------------
ALandFactoryUnit = Class(LandFactoryUnit) {
    StartBuildFx = function( self, unitBeingBuilt )
        local thread = self:ForkThread( EffectUtil.CreateAeonFactoryBuildingEffects, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, 'Attachpoint', self.BuildEffectsBag )
        unitBeingBuilt.Trash:Add( thread )
    end,
}

#-------------------------------------------------------------
#  LAND UNITS
#-------------------------------------------------------------
ALandUnit = Class( LandUnit ) { }

#-------------------------------------------------------------
#  MASS COLLECTION UNITS
#-------------------------------------------------------------
AMassCollectionUnit = Class(MassCollectionUnit) {
}

#-------------------------------------------------------------
#  MASS FABRICATION STRUCTURES
#-------------------------------------------------------------
AMassFabricationUnit = Class(MassFabricationUnit) {
}

#-------------------------------------------------------------
#  MASS STORAGE UNITS
#-------------------------------------------------------------
AMassStorageUnit = Class(MassStorageUnit) {
}

#-------------------------------------------------------------
#  RADAR STRUCTURES
#-------------------------------------------------------------
ARadarUnit = Class(RadarUnit) {
}

#-------------------------------------------------------------
#  RADAR STRUCTURES
#-------------------------------------------------------------
ASonarUnit = Class(SonarUnit) {}

#-------------------------------------------------------------
#  SEA FACTORY STRUCTURES
#-------------------------------------------------------------
ASeaFactoryUnit = Class(SeaFactoryUnit) {
    StartBuildFx = function( self, unitBeingBuilt )
        local thread = self:ForkThread( EffectUtil.CreateAeonFactoryBuildingEffects, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, 'Attachpoint01', self.BuildEffectsBag )
        unitBeingBuilt.Trash:Add( thread )    
    end,	
}


#-------------------------------------------------------------
#  SEA UNITS
#-------------------------------------------------------------
ASeaUnit = Class( SeaUnit ) {}

#-------------------------------------------------------------
#  SHIELD LAND UNITS
#-------------------------------------------------------------
AShieldHoverLandUnit = Class(ShieldHoverLandUnit) {}

#-------------------------------------------------------------
#  SHIELD LAND UNITS
#-------------------------------------------------------------
AShieldLandUnit = Class(ShieldLandUnit) {}

#-------------------------------------------------------------
#  SHIELD STRUCTURES
#-------------------------------------------------------------
AShieldStructureUnit = Class(ShieldStructureUnit) {
    
    RotateSpeed = 60,
    
    OnShieldEnabled = function(self)
        ShieldStructureUnit.OnShieldEnabled(self)
        local bp = self:GetBlueprint()
        local bpAnim = bp.Display.AnimationOpen
        if not bpAnim then return end
        if not self.OpenAnim then
            self.OpenAnim = CreateAnimator(self)
            self.OpenAnim:PlayAnim(bpAnim)
            self.Trash:Add(self.OpenAnim)
        end
        if not self.Rotator then
            self.Rotator = CreateRotator(self, 'Pod', 'z', nil, 0, 50, 0)
            self.Trash:Add(self.Rotator)
        end
        self.Rotator:SetSpinDown(false)
        self.Rotator:SetTargetSpeed(self.RotateSpeed)
        self.OpenAnim:SetRate(1)
    end,

    OnShieldDisabled = function(self)
        ShieldStructureUnit.OnShieldDisabled(self)
        if self.OpenAnim then
            self.OpenAnim:SetRate(-1)
        end
        if self.Rotator then
            
            self.Rotator:SetTargetSpeed(0)
        end
    end,    

}

#-------------------------------------------------------------
#  STRUCTURES
#-------------------------------------------------------------
AStructureUnit = Class(StructureUnit) {}

#-------------------------------------------------------------
#  SUBMARINE UNITS
#-------------------------------------------------------------
ASubUnit = Class( SubUnit ) {

    IdleSubBones = {},
    IdleSubEffects = {}
}


#-------------------------------------------------------------
#  TRANSPORT BEACON UNITS
#-------------------------------------------------------------
ATransportBeaconUnit = Class( TransportBeaconUnit ) {}

#-------------------------------------------------------------
#  WALKING LAND UNITS
#-------------------------------------------------------------
AWalkingLandUnit = Class( WalkingLandUnit ) {
    DisabledBones = {},
}

#-------------------------------------------------------------
#  WALL  STRUCTURES
#-------------------------------------------------------------
AWallStructureUnit = Class( WallStructureUnit ) {}

#-------------------------------------------------------------
#  CIVILIAN STRUCTURES
#-------------------------------------------------------------
ACivilianStructureUnit = Class(AStructureUnit) {}

#-------------------------------------------------------------
#  QUANTUM GATE UNITS
#-------------------------------------------------------------
AQuantumGateUnit = Class(QuantumGateUnit) {}

#-------------------------------------------------------------
#  RADAR JAMMER UNITS
#-------------------------------------------------------------
ARadarJammerUnit = Class(RadarJammerUnit) {
    
    RotateSpeed = 60,
    
    OnStopBeingBuilt = function(self, builder, layer)
        RadarJammerUnit.OnStopBeingBuilt(self, builder, layer)
        local bp = self:GetBlueprint()
        local bpAnim = bp.Display.AnimationOpen
        if not bpAnim then return end
        if not self.OpenAnim then
            self.OpenAnim = CreateAnimator(self)
            self.OpenAnim:PlayAnim(bpAnim)
            self.Trash:Add(self.OpenAnim)
        end
        if not self.Rotator then
            self.Rotator = CreateRotator(self, 'B02', 'z', nil, 0, 50, 0)
            self.Trash:Add(self.Rotator)
        end
    end,
    
    OnIntelEnabled = function(self)
        RadarJammerUnit.OnIntelEnabled(self)
        if self.OpenAnim then
            self.OpenAnim:SetRate(1)
        end
        if not self.Rotator then
            self.Rotator = CreateRotator(self, 'B02', 'z', nil, 0, 50, 0)
            self.Trash:Add(self.Rotator)
        end
        self.Rotator:SetSpinDown(false)
        self.Rotator:SetTargetSpeed(self.RotateSpeed)
    end,

    OnIntelDisabled = function(self)
        RadarJammerUnit.OnIntelDisabled(self)
        if self.OpenAnim then
            self.OpenAnim:SetRate(-1)
        end
        if self.Rotator then            
            self.Rotator:SetTargetSpeed(0)
        end
    end,    

}

#######################################################################
#######################################################################
#      E X P   W A R S   v  2
#######################################################################
#######################################################################


#-------------------------------------------------------------
#  SUB FACTORY STRUCTURES
#-------------------------------------------------------------
ASubFactoryUnit = Class( SubFactoryUnit ) {}



#-------------------------------------------------------------
#  PORTAL FACTORY STRUCTURES
#-------------------------------------------------------------

APortalFactoryUnit = Class( PortalFactoryUnit ) {}



#-------------------------------------------------------------
#  HERO WALKING LAND UNITS
#-------------------------------------------------------------

AHeroWalkingLandUnit = Class( HeroWalkingLandUnit ) {}


#-------------------------------------------------------------
#  LAND RESEARCH LAB UNITS
#-------------------------------------------------------------

ALandResearchLabUnit = Class( LandResearchLabUnit ) {}


#-------------------------------------------------------------
#  AIR RESEARCH LAB UNIT
#-------------------------------------------------------------

AAirResearchLabUnit = Class( AirResearchLabUnit ) {}


#-------------------------------------------------------------
#  NAVAL UNIT RESEARCH LAB
#-------------------------------------------------------------

ANavalResearchLabUnit = Class( NavalResearchLabUnit ) {}

