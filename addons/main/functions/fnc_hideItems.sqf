#include "..\script_component.hpp"
/*
 * Author: Tyen
 * Hide blacklisted items from both ACE and BI Virtual Arsenal.
 * Args: 0: object, 1: array of classnames. Returns: none.
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

// Remove from ACE Arsenal via ACE API (global removal)
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

// Remove from BI Virtual Arsenal categories (global removal)
private _callRemovalFunction = {
    params ["_fncName"];
    // Retrieve function from missionNamespace if present
    private _fnc = missionNamespace getVariable [_fncName, nil];
    if (isNil "_fnc") exitWith {};
    try {
        [_object, _blacklistedItems, true] call _fnc;
        diag_log format ["[Arsenal Hider] hideItems: %1 blacklist applied", _fncName];
    } catch {
        diag_log format ["[Arsenal Hider] hideItems: Error calling %1: %2", _fncName, _exception];
    };
};

// Call each BI removal function
["BIS_fnc_removeVirtualWeaponCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualMagazineCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualItemCargo"] call _callRemovalFunction;
["BIS_fnc_removeVirtualBackpackCargo"] call _callRemovalFunction;

diag_log "[Arsenal Hider] hideItems: Blacklist applied successfully";

