#include "..\script_component.hpp"
/*
 * Author: Tyen
 * Load blacklisted item classnames from data/hiddenItems.txt. Returns array.
 */

private _filePath = "data\hiddenItems.txt";
private _fullPath = format ["z\tc\addons\arsenal_hider\%1", _filePath];
diag_log format ["[Arsenal Hider] Loading blacklist from: %1", _fullPath];

private _fileContent = loadFile _fullPath;
diag_log format ["[Arsenal Hider] File content loaded: %1 characters", count _fileContent];

if (isNil "_fileContent" || _fileContent == "") exitWith {
    diag_log "[Arsenal Hider] Failed to load blacklist file or file is empty";
    []
};

private _lines = _fileContent splitString toString [13, 10];
private _blacklistedItems = [];

{
    private _line = _x call CBA_fnc_trim;
    diag_log format ["[Arsenal Hider] Processing line: '%1'", _line];
    
    if (_line != "" && !(_line select [0, 1] == "#" || _line select [0, 2] == "//")) then {
        _blacklistedItems pushBack _line;
        diag_log format ["[Arsenal Hider] Added item: %1", _line];
    };
} forEach _lines;

diag_log format ["[Arsenal Hider] Final blacklist: %1 items: %2", count _blacklistedItems, _blacklistedItems];

_blacklistedItems
