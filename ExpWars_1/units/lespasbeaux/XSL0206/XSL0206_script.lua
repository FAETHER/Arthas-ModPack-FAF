#****************************************************************************
#**
#**  File     :  /units/XSL0206/XSL0206_script.lua
#**  Author(s):  Aaron Lundquist And Asdrubaelvect
#**
#**  Summary  :  Seraphim Iashavoh Mobile Torpille Launcher
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local SANUallCavitationTorpedo = import('/lua/seraphimweapons.lua').SANUallCavitationTorpedo

XSL0206 = Class(SLandUnit) {
    Weapons = {
        MainGun = Class(SDFOhCannon) {},
		Torpedo01 = Class(SANUallCavitationTorpedo) {},
    },
}
TypeClass = XSL0206