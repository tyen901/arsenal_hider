class CfgPatches {
    class arsenal_hider {
        name = "Arsenal Hider";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.02;
        requiredAddons[] = {"ace_arsenal"};
        author = "Tyen";
        authors[] = {"Tyen"};
        url = "";
        version = "1.0.0";
        versionStr = "1.0.0";
        versionAr[] = {1,0,0};
    };
};

class CfgFunctions {
    class arsenal_hider {
        class functions {
            file = "\z\ace\addons\arsenal_hider\functions";
            class hideItems {};
        };
    };
};

class Extended_PostInit_EventHandlers {
    class arsenal_hider {
        init = "if (hasInterface) then { ['ace_arsenal_displayOpened', { params ['_display']; private _box = ace_arsenal_currentBox; if (!isNull _box) then { [_box] call arsenal_hider_fnc_hideItems; }; }] call CBA_fnc_addEventHandler; };";
    };
};
