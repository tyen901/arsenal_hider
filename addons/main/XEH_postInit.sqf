// Ensure component macros are available and functions are compiled.
#include "script_component.hpp"

// Recompile/compile functions at postInit as a safeguard
PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Fallback: ensure functions exist even if PREP didn't run yet
if (isNil QFUNC(hideItems)) then {
    diag_log "[Arsenal Hider] postInit: hideItems not compiled via PREP, compiling now";
    ["\z\tc\addons\arsenal_hider\functions\fnc_hideItems.sqf", QFUNC(hideItems)] call CBA_fnc_compileFunction;
};
if (isNil QFUNC(loadHiddenItems)) then {
    diag_log "[Arsenal Hider] postInit: loadHiddenItems not compiled via PREP, compiling now";
    ["\z\tc\addons\arsenal_hider\functions\fnc_loadHiddenItems.sqf", QFUNC(loadHiddenItems)] call CBA_fnc_compileFunction;
};

if (!hasInterface) exitWith {};

// Load blacklist via our function for consistency
private _blacklistedItems = [] call FUNC(loadHiddenItems);
// Store in missionNamespace to avoid scope/timing issues
missionNamespace setVariable ["arsenal_hider_blacklistedItems", _blacklistedItems];

// Apply blacklist when an ACE arsenal is opened. We call our unified
// hideItems function via execNextFrame to ensure the arsenal is fully
// initialized before we remove content. This will remove items from
// both ACE and BI arsenals on the opened box for all clients.
["ace_arsenal_displayOpened", {
    [{
        private _items = missionNamespace getVariable ["arsenal_hider_blacklistedItems", []];
        [ace_arsenal_currentBox, _items] call FUNC(hideItems);
    }] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

// Also apply blacklist when an ACE arsenal box is created. This ensures
// that newly spawned boxes have the blacklist applied before players
// interact with them.
["ace_arsenal_boxInitialized", {
    params ["_box"];
    private _items = missionNamespace getVariable ["arsenal_hider_blacklistedItems", []];
    [_box, _items] call FUNC(hideItems);
}] call CBA_fnc_addEventHandler;
