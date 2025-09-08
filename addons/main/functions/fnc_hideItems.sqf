#include "..\script_component.hpp"
/*
 * Author: Tyen
 * Applies a blacklist to any arsenal object.  Unlike the original
 * implementation which only called the ACE arsenal function,
 * this version removes the specified classes from both ACE arsenals
 * and BI’s Virtual Arsenal.  The removal is performed globally so that
 * all clients see the same filtered inventory.
 *
 * Arguments:
 * 0: Arsenal object <OBJECT>
 * 1: Array of class names to blacklist <ARRAY>
 *
 * Return Value: None
 *
 * Example:
 * [_box, ["arifle_MX_F", "U_B_CombatUniform_mcam"]] call arsenal_hider_fnc_hideItems
 *
 * Public: Yes
 */

params [["_object", objNull, [objNull]], ["_blacklistedItems", [], [[]]]];

// Sanity checks
if (isNull _object) exitWith {
    diag_log "[Arsenal Hider] hideItems: Object is null";
};

if (_blacklistedItems isEqualTo []) exitWith {
    diag_log "[Arsenal Hider] hideItems: No items to blacklist";
};

diag_log format ["[Arsenal Hider] hideItems: Removing %1 blacklisted items from %2", count _blacklistedItems, _object];

/*
 * Remove blacklisted items from ACE Arsenal
 *
 * The ACE function ace_arsenal_fnc_removeVirtualItems accepts three
 * parameters: the target object, an array of class names or a boolean,
 * and a boolean to indicate whether the removal should be broadcast
 * globally.  According to the ACE3 documentation, setting the third
 * parameter to true will ensure all clients see the filtered items
 *【347684744663646†L675-L696】.  Passing an array of strings removes only
 * those classes, whereas passing true removes everything.  We pass
 * our blacklist and set global removal to true.
 */
if !(isNil "ace_arsenal_fnc_removeVirtualItems") then {
    try {
        [_object, _blacklistedItems, true] call ace_arsenal_fnc_removeVirtualItems;
        diag_log "[Arsenal Hider] hideItems: ACE arsenal blacklist applied";
    } catch {
        diag_log format ["[Arsenal Hider] hideItems: Error applying ACE blacklist: %1", _exception];
    };
} else {
    diag_log "[Arsenal Hider] hideItems: ACE removal function not available";
};

/*
 * Remove blacklisted items from BI Virtual Arsenal
 *
 * Bohemia Interactive provide a series of BIS_fnc_removeVirtual… commands
 * to remove specific categories of virtual cargo from an object.  Each
 * function accepts an object, an array of class names (or single class
 * name), and an optional boolean which, when true, removes the classes
 * globally【641347218732356†L182-L216】【150875975402475†L182-L202】.  We call
 * each removal function with our blacklist to ensure that weapons,
 * magazines, miscellaneous items and backpacks are all removed from
 * vanilla arsenals.  Some categories may not contain the given class
 * names; these functions will safely ignore unknown classes.  We wrap
 * each call in a try–catch and guard with isNil to avoid errors if the
 * functions are unavailable (e.g. if Virtual Arsenal isn’t present).
 */
private _callRemovalFunction = {
    params ["_fncName"];
    // Only proceed if the function exists in the current namespace
    if (isNil _fncName) exitWith {};
    // Retrieve the function from the mission namespace. If the variable
    // doesn't exist it will return nil.
    private _fnc = missionNamespace getVariable [_fncName, nil];
    if (isNil "_fnc") exitWith {};
    try {
        [_object, _blacklistedItems, true] call _fnc;
        diag_log format ["[Arsenal Hider] hideItems: %1 blacklist applied", _fncName];
    } catch {
        diag_log format ["[Arsenal Hider] hideItems: Error calling %1: %2", _fncName, _exception];
    };
};

// List of BI removal functions to call.  Each call passes the function name
// as an argument to _callRemovalFunction.  Using call instead of apply
// avoids creating intermediate arrays and ensures the code executes
// immediately.
["BIS_fnc_removeVirtualWeaponCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualMagazineCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualItemCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualBackpackCargo"] call _callRemovalFunction;

diag_log "[Arsenal Hider] hideItems: Blacklist applied successfully";
