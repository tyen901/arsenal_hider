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

if (isNull _object) exitWith {};

private _itemsToHide = [
    "arifle_Katiba_F",
    "srifle_DMR_07_blk_F",
    "arifle_TRG21_F",
    "H_PASGT_basic_black_F",
    "arifle_MX_SW_F"
];

[{
    !isNil {(_this select 0) getVariable "ace_arsenal_virtualItems"}
}, {
    params ["_object", "_itemsToHide"];
    
    private _virtualItems = _object getVariable "ace_arsenal_virtualItems";
    if (isNil "_virtualItems") exitWith {};
    
    {
        [_object, [_x], false] call ace_arsenal_fnc_removeVirtualItems;
    } forEach _itemsToHide;

    ["ace_arsenal_refresh", _object] call CBA_fnc_globalEvent;
}, [_object, _itemsToHide], 10] call CBA_fnc_waitUntilAndExecute;
