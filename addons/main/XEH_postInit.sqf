if (!hasInterface) exitWith {};

// Load blacklist from file
private _filePath = "data\hiddenItems.txt";
private _fullPath = format ["z\tc\addons\arsenal_hider\main\%1", _filePath];
private _fileContent = loadFile _fullPath;
private _blacklistedItems = [];

if (!isNil "_fileContent" && _fileContent != "") then {
    private _lines = _fileContent splitString toString [13, 10];
    
    {
        private _line = _x call CBA_fnc_trim;
        if (_line != "" && !(_line select [0, 1] == "#" || _line select [0, 2] == "//")) then {
            _blacklistedItems pushBack _line;
        };
    } forEach _lines;
};

arsenal_hider_blacklistedItems = _blacklistedItems;

["ace_arsenal_displayOpened", {
    [{
        [ace_arsenal_currentBox, arsenal_hider_blacklistedItems, false] call ace_arsenal_fnc_removeVirtualItems;
    }] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;
