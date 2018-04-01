--[[################################################################################
#  File     :  /hook/lua/game.lua
#  Author(s):  John Comes
#  Summary  :  Script full of overall game functions
#  -----------------------------
#  Modif.by :  Manimal
#  Mod.Date :  05 novembre 2008
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  27 mai 2010
#  Rev.Date :  31 janvier 2011 11:34 -> M à J  myMod_UID.
#  Rev.Date :  23 mars 2011 18:43 -> Ajout Variable Globale EW_Enhancements.
#  Rev.Date :  20 juillet 2011 -> Refonte pour compatibilité maximale.
#  Rev.Date :  22 juillet 2011 -> Ajout du script CBFP v4 pour compatibilité.
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc. All rights reserved.
################################################################################]]--

# NBR LIGNES ORIGINAL = 52

do


# =============================================================================
# AJOUT PAR MANIMAL : MOD LOCATOR
# =============================================================================

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local myMod_UID = "e403c941-1faa-42a5-bcce-4762af26140a"  --UID of The Mod
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--[[################################################################################
# Manimal's Mod Locator script
# The function MyActiveModLocation = function( byName, byUID, byAuthor ) will
# avoid making a list of units which is not convenient to maintain up-to-date
# each time someone creates and adds a new unit in his mod.
# This function will require the current Mod's UID ONLY in order to get the
# current active mod's location, that's more convenient as it won't change.
# It could work also by mod NAME or AUTHOR name, but this is not accurate.
################################################################################]]--

local GetMyActiveMod = function( byName, byUID, byAuthor )
	for i, leMod in __active_mods do
		if (byName   and ( byName   == leMod.name   )) 
		or (byUID    and ( byUID    == leMod.uid    ))
		or (byAuthor and ( byAuthor == leMod.author )) then
			--LOG("MANIMAL\'s DEBUG: Mod infos = "..repr(leMod))
			return leMod
		end
	end
	WARN("MANIMAL\'s MOD FINDER:  Unable to get Mod Infos ! Either your mod is not installed or you have mistyped its name, UID or author.")
	return {}
end

local GetMyActiveModLocation = function( leMod )
	if leMod and (type(leMod) == 'table') then
		--LOG("MANIMAL\'s DEBUG: Mod Location = " .. leMod.location)
		return leMod.location
	end
	WARN("MANIMAL\'s MOD LOCATOR:  Unable to get Mod Infos ! Either your mod is not installed or you have mistyped its name, UID or author.")
	return ''
end


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# VARIABLES GLOBALES !!!

MonMod = GetMyActiveMod( false, myMod_UID, false )
MyModPath = GetMyActiveModLocation( MonMod )
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--local mesUtiles = import( MyModPath .. '/schook/lua/system/mesUtiles.lua' )
--local TraceurTable = mesUtiles.table.AfficheTraceur

# =============================================================================
# FIN AJOUT PAR MANIMAL : MOD LOCATOR
# =============================================================================





# =============================================================================
# AJOUT PAR MANIMAL : 
# =============================================================================

-- À AMÉLIORER : RETROUVER LE Niveau Max de Veteran PAR UN AUTRE MOYEN ?
NiveauVetMax = table.getsize( VeteranDefault )


EW_Enhancements = { 'VeterancyI', 'VeterancyII', 'VeterancyIII', 'VeterancyIV', 'VeterancyV' }

# =============================================================================
# FIN AJOUT PAR MANIMAL : 
# =============================================================================



##############################################################################################
# AJOUT CBFP v4 PAR MANIMAL : 
# ===========================
# J'AI INCLUS DES PORTIONS DE SCRIPT DU CBFP V4 À CAUSE DE LA STRUCTURE DU MOD EXPWARS.
# MES TRAVAUX SUR LES SCRIPTS SONT AMÉLIORABLES MAIS JE N'AI PAS BEAUCOUP DE TEMPS LIBRE...
# I HAD TO INCLUDE SOME SCRIPT PORTIONS OF THE CBFP V4 BECAUSE OF THE WAY EXPWARS IS WORKING.
# MY SCRIPT WORKS CAN BE IMPROVED BUT I DO NOT HAVE MUCH FREE TIME...
##############################################################################################

# new global vars
CBFP_ModUID = '04F84894-5E6A-11DD-A058-5D6456D89593'


# -------------------------------------------------------------------------------------------------------------
# DON'T CHANGE THESE

CBFP_Path = '' # auto-filled-in below
SpecialWepRestricted = false
UnitCatRestricted = false
_UnitRestricted_cache = {}

# -------------------------------------------------------------------------------------------------------------
# MISC FUNCTIONS

# thanks to Manimal! Returns location to mod using mod Id. Edited by Brute51
function GetActiveModLocation( mod_Id, silent )
    for k, mod in __active_mods do
        if  mod_Id == mod.uid then
            return mod.location
        end
    end
	--# MADE CONDITIONAL BY MANIMAL
	if  ( silent == false )  or  ( silent == nil )  then
		WARN("Unable to get mod directory! Wrong or missing UID. Searched for UID "..repr(mod_Id))
	end
	--# FIXED UP BY MANIMAL
	return ''
end


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# REWORKED BY MANIMAL :
# ~~~~~~~~~~~~~~~~~~~~~
# -------------------------------------------------------------------------------------------------------------
# MISC FUNCTION CALLS


function CBFPv4_IsActive()     --# ADDED BY MANIMAL :
	local CBFP_Chemin = ''
	CBFP_Chemin = GetActiveModLocation( CBFP_ModUID, true )
	return ( string.len( CBFP_Chemin ) > 0 )
end


if  CBFPv4_IsActive()  and  DiskGetFileInfo( CBFP_Path .. '/lua/CBFPinit.lua' )  then
	--# MADE CONDITIONAL BY MANIMAL
	CBFP_Path = GetActiveModLocation( CBFP_ModUID, false )
	
	--# MADE CONDITIONAL BY MANIMAL
	doscript( CBFP_Path .. '/lua/CBFPinit.lua' ) --# haven't found a better place to put this call yet
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# -------------------------------------------------------------------------------------------------------------
# UNIT RESTRICTION FUNCTIONS   [119] [157]


function UnitRestricted(unit)
    --# checks if the unit is allowed to be build in the current game.

    if not CheckUnitRestrictionsEnabled() then     --# if no restrictions defined then dont bother
        return false
    end

    local unitId = unit:GetUnitId()
    if _UnitRestricted_cache[unitId] then          --# use cache if available
        return _UnitRestricted_cache[unitId]
    end

    CacheRestrictedUnitLists()
    _UnitRestricted_cache[unitId] = false
    for k, cat in UnitCatRestricted do
        if EntityCategoryContains( cat, unitId ) then   --# because of this function we need the unit, not the unitId
            _UnitRestricted_cache[unitId] = true
            break
        end
    end

    return _UnitRestricted_cache[unitId]
end


function WeaponRestricted(weaponLabel)
    --# tells you whether a weapon should be disabled (according to the unit restrictions)

    if not CheckUnitRestrictionsEnabled() then     --# if no restrictions defined then dont bother
        return false
    end
    CacheRestrictedUnitLists()
    return SpecialWepRestricted[weaponLabel]
end


function NukesRestricted()
    return WeaponRestricted('StrategicMissile')
end


function TacticalMissilesRestricted()
    return WeaponRestricted('TacticalMissile')
end


# -------------------------------------------------------------------------------------------------------------
# HELPER FUNCTIONS

function CheckUnitRestrictionsEnabled()
    --# tells you whether unit restrictions are enabled
    if ScenarioInfo.Options.RestrictedCategories then return true end
    return false
end

function CacheRestrictedUnitLists()
    --# create tables of restricted units and special weapons. Only need to run once per game

    --# check if we need to do this function at all
    if type(UnitCatRestricted) == 'table' then
        return
    end

    SpecialWepRestricted = {}
    UnitCatRestricted = {}
    local restrictedUnits = import('/lua/ui/lobby/restrictedUnitsData.lua').restrictedUnits
    local c

    --# loops through enabled restrictions
    for k, restriction in ScenarioInfo.Options.RestrictedCategories do 

        --# create a list of all unit category restrictions. TO be clear, this results in a table of categories
        --# So, for example:   { categories.TECH1, categories.TECH2, categories.MASSFAB }
        if restrictedUnits[restriction].categories then
            for l, cat in restrictedUnits[restriction].categories do
                c = cat
                if type(c) == 'string' then c = ParseEntityCategory(c) end
                table.insert( UnitCatRestricted, c )
            end
        end

        --# create a list of restricted special weapons (nukes, tactical missiles)
        if restrictedUnits[restriction].specialweapons then   
            for l, cat in restrictedUnits[restriction].specialweapons do

                --# strategic missiles
                if cat == 'StrategicMissile' or cat == 'strategicmissile' or cat == 'sm' or cat == 'SM' then
                    SpecialWepRestricted['StrategicMissile'] = true

                --# tactical missiles
                elseif cat == 'TacticalMissile' or cat == 'tacticalmissile' or cat == 'tm' or cat == 'TM' then
                    SpecialWepRestricted['TacticalMissile'] = true

                --# mod added weapons
                else
                    SpecialWepRestricted[cat] = true
                end
            end
        end
    end
end

# -------------------------------------------------------------------------------------------------------------

##############################################################################################
# AJOUT CBFP PAR MANIMAL : 
##############################################################################################

end