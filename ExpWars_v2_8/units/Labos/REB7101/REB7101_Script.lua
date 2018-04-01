--[[#######################################################################
#  File     :  /units/Labos/REB7101/REB7101_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Special Earth Science Lab Script
#  -----------------------------
#  Modif.by :  Manimal
#  Rev.Date :  19 janvier 2010
#  Rev.Date :  17 février 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local TLandResearchLabUnit = import( MyModPath .. '/hook/lua/terranunits.lua').TLandResearchLabUnit


REB7101 = Class( TLandResearchLabUnit ) {
	SwitchAnims = true,

    OnStopBeingBuilt = function(self,builder,layer)
	TLandResearchLabUnit.OnStopBeingBuilt(self,builder,layer)
		self.Effect1 = CreateAttachedEmitter(self,'Effect_01',self:GetArmy(), '/effects/emitters/economy_electricity_01_emit.bp')
		self.Trash:Add(self.Effect1)	
		self.Effect2 = CreateAttachedEmitter(self,'Effect_02',self:GetArmy(), '/effects/emitters/economy_electricity_01_emit.bp')
		self.Trash:Add(self.Effect2)
		self.Effect3 = CreateAttachedEmitter(self,'Effect_03',self:GetArmy(), '/effects/emitters/economy_electricity_01_emit.bp')
		self.Trash:Add(self.Effect3)
		self.Effect4 = CreateAttachedEmitter(self,'Effect_04',self:GetArmy(), '/effects/emitters/economy_electricity_01_emit.bp')
		self.Trash:Add(self.Effect4)
    end,
}

TypeClass = REB7101

