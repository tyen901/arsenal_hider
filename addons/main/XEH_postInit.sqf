/*
 * Arsenal Hider - global blacklist for ACE Arsenal
 * Runs on every client.
 */

// CBA macros (QPATHTOF, etc.)
#include "script_component.hpp"

// 1) Load persistent blacklist
BlackList = call compile preprocessFileLineNumbers QPATHTOF(blacklist.sqf);
BlackList = BlackList arrayIntersect BlackList; // de-dup

// Helper to strip blacklist from a given box
// Uses ACE helper to remove virtual items by classname.
arsenal_hider_fnc_strip = {
    params ["_box"];
    if (isNil "_box") exitWith {};
    [_box, BlackList] call ace_arsenal_fnc_removeVirtualItems;
};

// A) When any ACE Arsenal UI opens, remove listed items from the current box
["ace_arsenal_displayOpened", {
    // Defer one frame to ensure ace_arsenal_currentBox is set up
    [{ 
        if (!isNil "ace_arsenal_currentBox") then {
            [ace_arsenal_currentBox] call arsenal_hider_fnc_strip;
        };
    }, []] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

// B) When any ACE Arsenal box initializes, strip blacklisted items immediately
["ace_arsenal_boxInitialized", {
    params ["_box"];
    [_box] call arsenal_hider_fnc_strip;
}] call CBA_fnc_addEventHandler;
