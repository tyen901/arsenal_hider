#include "script_component.hpp"

if (!hasInterface) exitWith {};

[QEGVAR(arsenal,displayOpened), {
    params ["_display"];
    private _box = EGVAR(arsenal,currentBox);
    if (isNull _box) exitWith {};
    
    [{
        params ["_box"];
        [_box, false] call FUNC(hideItems);
    }, [_box]] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;
