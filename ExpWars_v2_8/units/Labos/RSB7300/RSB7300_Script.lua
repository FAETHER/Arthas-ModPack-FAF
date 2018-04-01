--[[#######################################################################
#  File     :  /units/Labos/RSB7300/RSB7300_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Special Seraphim Science Lab Script
#  **  Made From Aeon Manufacturing Center, Ver1
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  17 février 2010
#  Rev.Date :  18 février 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local SLandResearchLabUnit = import( MyModPath .. '/hook/lua/seraphimunits.lua' ).SLandResearchLabUnit

local SeraphimAirStagePlat01 = import('/lua/EffectTemplates.lua').SeraphimAirStagePlat01
local SeraphimAirStagePlat02 = import('/lua/EffectTemplates.lua').SeraphimAirStagePlat02


RSB7300 = Class( SLandResearchLabUnit ) {
	SwitchAnims = true,
	
    OnCreate = function(self)
        SLandResearchLabUnit.OnCreate(self)
        self.Rotator1 = CreateRotator(self, 'B01', 'y', nil, 45, 0, 0)
        self.Trash:Add(self.Rotator1)
		self.Rotator2 = CreateRotator(self, 'B02', 'y', nil, 45, 0, 0)
        self.Trash:Add(self.Rotator2)
		self.Rotator3 = CreateRotator(self, 'B03', 'y', nil, 45, 0, 0)
        self.Trash:Add(self.Rotator3)
		self.Rotator4 = CreateRotator(self, 'B04', 'y', nil, 45, 0, 0)
        self.Trash:Add(self.Rotator4)
		self.Rotator5 = CreateRotator(self, 'B05', 'y', nil, 45, 0, 0)
        self.Trash:Add(self.Rotator5)
		self.Rotator6 = CreateRotator(self, 'B06', 'y', nil, -45, 0, 0)
        self.Trash:Add(self.Rotator6)
		self.Rotator7 = CreateRotator(self, 'B07', 'y', nil, -45, 0, 0)
        self.Trash:Add(self.Rotator7)
		self.Rotator8 = CreateRotator(self, 'B08', 'y', nil, -45, 0, 0)
        self.Trash:Add(self.Rotator8)
		self.Rotator9 = CreateRotator(self, 'B09', 'y', nil, -45, 0, 0)
        self.Trash:Add(self.Rotator9)
		self.Rotator10 = CreateRotator(self, 'B10', 'y', nil, -45, 0, 0)
        self.Trash:Add(self.Rotator10)
		self.Rotator11 = CreateRotator(self, 'Object03', 'y', nil, -25, 0, 0)
        self.Trash:Add(self.Rotator11)
		
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        self.Rotator1:SetSpeed(0)
		self.Rotator2:SetSpeed(0)
		self.Rotator3:SetSpeed(0)
		self.Rotator4:SetSpeed(0)
		self.Rotator5:SetSpeed(0)
		self.Rotator6:SetSpeed(0)
		self.Rotator7:SetSpeed(0)
		self.Rotator8:SetSpeed(0)
		self.Rotator9:SetSpeed(0)
		self.Rotator10:SetSpeed(0)
		self.Rotator11:SetSpeed(0)
        SLandResearchLabUnit.OnKilled(self, instigator, type, overkillRatio)
    end,		

    OnStopBeingBuilt = function(self,builder,layer)
		for k, v in SeraphimAirStagePlat02 do
            CreateAttachedEmitter(self, 'Object02', self:GetArmy(), v)
        end
        for k, v in SeraphimAirStagePlat01 do
            CreateAttachedEmitter(self, 'Light01', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light02', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light03', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light04', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light05', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light06', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light07', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light08', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light09', self:GetArmy(), v)
			CreateAttachedEmitter(self, 'Light10', self:GetArmy(), v)
        end
        SLandResearchLabUnit.OnStopBeingBuilt(self, builder, layer)
    end,			
					
		
	
}

TypeClass = RSB7300


