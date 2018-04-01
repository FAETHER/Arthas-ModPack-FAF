#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0402/UEA0402_script.lua
#**  Author(s):  David Tomandl
#** 				Modified by Asdrubaelvect
#**
#**  Summary  :  UEF tier 4 Heavy Air Transport
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEA0402 = Class(TAirUnit) {    

    Weapons = {
        MissileRack01 = Class(TSAMLauncher) {},
    },
	
	
    OnCreate = function(self)
        TAirUnit.OnCreate(self)
    end,
    
}

TypeClass = UEA0402