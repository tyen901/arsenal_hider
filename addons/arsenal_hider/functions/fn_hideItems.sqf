/*
 * Author: Tyen
 * Hides predefined items from ACE Arsenal virtual items.
 *
 * Arguments:
 * 0: Arsenal object <OBJECT>
 *
 * Return Value: None
 *
 * Example:
 * [_box] call arsenal_hider_fnc_hideItems
 *
 * Public: Yes
 */

params [["_object", objNull, [objNull]]];

if (isNull _object) exitWith {
    diag_log "[Arsenal Hider] hideItems: Object is null, exiting";
};

diag_log format ["[Arsenal Hider] hideItems: Starting hideItems for object: %1", _object];

private _itemsToHide = ["data\hiddenItems.txt"] call arsenal_hider_fnc_loadHiddenItems;

diag_log format ["[Arsenal Hider] hideItems: Items to hide count: %1", count _itemsToHide];

[{
    !isNil {(_this select 0) getVariable "ace_arsenal_virtualItems"}
}, {
    params ["_object", "_itemsToHide"];
    
    diag_log "[Arsenal Hider] hideItems: Arsenal virtual items available, proceeding with hiding";
    
    private _virtualItems = _object getVariable "ace_arsenal_virtualItems";
    if (isNil "_virtualItems") exitWith {
        diag_log "[Arsenal Hider] hideItems: Virtual items variable is nil, exiting";
    };
    
    private _hiddenCount = 0;
    {
        diag_log format ["[Arsenal Hider] hideItems: Hiding item: %1", _x];
        [_object, [_x], false] call ace_arsenal_fnc_removeVirtualItems;
        _hiddenCount = _hiddenCount + 1;
    } forEach _itemsToHide;

    diag_log format ["[Arsenal Hider] hideItems: Successfully hidden %1 items", _hiddenCount];
    ["ace_arsenal_refresh", _object] call CBA_fnc_globalEvent;
}, [_object, _itemsToHide], 10] call CBA_fnc_waitUntilAndExecute;
