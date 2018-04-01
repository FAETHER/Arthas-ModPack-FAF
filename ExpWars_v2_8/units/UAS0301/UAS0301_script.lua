--[[#######################################################################
#  File     :  /units/UAS0301/UAS0301_script.lua
#  Author(s):  David Tomandl
#  Summary  :  Aeon Cruiser Script UAS0202
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local Game = import( '/lua/game.lua' )

# VARIABLE ''GLOBALE'' ( par Manimal )
local MyModPath = Game.MyModPath
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local ASubUnit = import( MyModPath .. '/hook/lua/aeonunits.lua' ).ASubUnit

local AeonWeapons = import('/lua/aeonweapons.lua')
local AANChronoTorpedoWeapon = AeonWeapons.AANChronoTorpedoWeapon
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AAMWillOWisp = AeonWeapons.AAMWillOWisp

UAS0301 = Class( ASubUnit ) {
    Weapons = {
        FrontTurret = Class(ADFCannonQuantumWeapon) {},
		Torpedo01 = Class(AANChronoTorpedoWeapon) {},
    },

    --BackWakeEffect = {},
}

TypeClass = UAS0301
