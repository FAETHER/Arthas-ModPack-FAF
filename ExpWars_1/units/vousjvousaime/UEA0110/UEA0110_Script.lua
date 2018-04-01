#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0103/UEA0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran Carpet Bomber Unit Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# Terran Bomber Script : UEA0103
#
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher

UEA0103 = Class(TAirUnit) {
    Weapons = {
        Bomb = Class(TIFCruiseMissileLauncher) {
            },
        },
}

TypeClass = UEA0103
