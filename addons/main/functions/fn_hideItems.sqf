#include "..\script_component.hpp"
/*
 * Author: Tyen
 * Applies blacklist to ACE Arsenal using the ACE Arsenal Framework pattern.
 *
 * Arguments:
 * 0: Arsenal object <OBJECT>
 * 1: Array of blacklisted items <ARRAY>
 *
 * Return Value: None
 *
 * Example:
 * [_box, _blacklistedItems] call arsenal_hider_fnc_hideItems
 *
 * Public: Yes
 */

params [["_object", objNull, [objNull]], ["_blacklistedItems", [], [[]]]];

if (isNull _object) exitWith {
    diag_log "[Arsenal Hider] hideItems: Object is null";
};

if (_blacklistedItems isEqualTo []) exitWith {
    diag_log "[Arsenal Hider] hideItems: No items to blacklist";
};

diag_log format ["[Arsenal Hider] hideItems: Removing %1 blacklisted items from %2", count _blacklistedItems, _object];

[_object, _blacklistedItems, false] call ace_arsenal_fnc_removeVirtualItems;

diag_log "[Arsenal Hider] hideItems: Blacklist applied successfully";
