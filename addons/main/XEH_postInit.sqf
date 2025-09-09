// Ensure component macros are available and functions are compiled.
#include "script_component.hpp"

// Recompile/compile functions at postInit as a safeguard
PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (!hasInterface) exitWith {};

// Load blacklist via our function for consistency
private _blacklistedItems = [] call FUNC(loadHiddenItems);
// Store in missionNamespace to avoid scope/timing issues
missionNamespace setVariable ["arsenal_hider_blacklistedItems", _blacklistedItems];

// Apply blacklist when ACE arsenal opens. Use execNextFrame to ensure
// the display is initialized before modifying contents (ACE + BI).
["ace_arsenal_displayOpened", {
    [{
        private _items = missionNamespace getVariable ["arsenal_hider_blacklistedItems", []];
        [ace_arsenal_currentBox, _items] call FUNC(hideItems);
    }] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

// Also apply blacklist when an ACE arsenal box initializes.
["ace_arsenal_boxInitialized", {
    params ["_box"];
    private _items = missionNamespace getVariable ["arsenal_hider_blacklistedItems", []];
    [_box, _items] call FUNC(hideItems);
}] call CBA_fnc_addEventHandler;
