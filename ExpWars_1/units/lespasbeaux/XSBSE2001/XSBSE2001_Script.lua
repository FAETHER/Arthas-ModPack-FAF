#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2303/UAB2303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Artillery Installation Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit

local SDFHeavyQuarnon01Cannon = import('/Mods/ExpWars_1/hook/lua/seraphweapons.lua').SDFHeavyQuarnon01Cannon


XSBSE2001 = Class(SStructureUnit) {

    Weapons = {
        MainGun = Class(SDFHeavyQuarnon01Cannon) {},
    },
}

TypeClass = XSBSE2001