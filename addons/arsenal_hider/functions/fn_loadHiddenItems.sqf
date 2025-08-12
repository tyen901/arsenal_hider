/*
 * Author: Tyen
 * Loads items to hide from a text file.
 *
 * Arguments:
 * 0: File path relative to addon folder <STRING>
 *
 * Return Value: Array of item classnames <ARRAY>
 *
 * Example:
 * private _items = ["data\hiddenItems.txt"] call arsenal_hider_fnc_loadHiddenItems
 *
 * Public: Yes
 */

params [["_filePath", "", [""]]];

if (_filePath == "") exitWith {
    diag_log "[Arsenal Hider] loadHiddenItems: No file path provided";
    []
};

private _fullPath = format ["\z\ace\addons\arsenal_hider\%1", _filePath];
diag_log format ["[Arsenal Hider] loadHiddenItems: Attempting to load file: %1", _fullPath];

private _fileContent = loadFile _fullPath;

if (isNil "_fileContent" || _fileContent == "") exitWith {
    diag_log format ["[Arsenal Hider] loadHiddenItems: Failed to load file or file is empty: %1", _fullPath];
    []
};

diag_log format ["[Arsenal Hider] loadHiddenItems: File loaded successfully, content length: %1", count _fileContent];

private _lines = _fileContent splitString toString [13, 10];
private _items = [];

{
    private _line = _x;
    _line = _line call CBA_fnc_trim;
    
    if (_line != "" && !(_line select [0, 1] == "#" || _line select [0, 2] == "//")) then {
        _items pushBack _line;
        diag_log format ["[Arsenal Hider] loadHiddenItems: Added item: %1", _line];
    };
} forEach _lines;

diag_log format ["[Arsenal Hider] loadHiddenItems: Loaded %1 items from file", count _items];

_items
