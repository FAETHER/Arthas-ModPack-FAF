#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0302/UAA0302_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Spy Plane Script
#**
#**  Copyright © 2009 4th Dimension.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
SAirUnit = import('/mods/4th_Dimension_212/hook/lua/UnitPhasing.lua').UnitPhasing( SAirUnit )

XSA0302 = Class(SAirUnit) {}
TypeClass = XSA0302