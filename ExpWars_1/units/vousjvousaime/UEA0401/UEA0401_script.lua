#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0401/UEA0401_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos, Greg Kohne
#**					Modified By Asdrubaelvect
#**  Summary  :  UEF Spaceships Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TDFHiroPlasmaCannon = import('/lua/terranweapons.lua').TDFHiroPlasmaCannon
local TOrbitalDeathLaserBeamWeapon = import('/lua/terranweapons.lua').TOrbitalDeathLaserBeamWeapon

UEO1103 = Class(TAirUnit) {
    Weapons = {
	    MissileRack01 = Class(TSAMLauncher) {},
		HiroCannonFront = Class(TDFHiroPlasmaCannon) {},
		HiroCannonBack = Class(TDFHiroPlasmaCannon) {},
		OrbitalDeathLaserWeapon = Class(TOrbitalDeathLaserBeamWeapon){  		
		},
	},
}
TypeClass = UEO1103