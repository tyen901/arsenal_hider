// CBA macros for path helpers
#include "script_component.hpp"

class CfgPatches {
    class arsenal_hider_main {
        name = "Arsenal Hider";
        author = "Tyen";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.10;
        requiredAddons[] = {"cba_main", "ace_arsenal"};
        version = "1.0.0";
    };
};

class Extended_PostInit_EventHandlers {
    class arsenal_hider_main {
        // Wrap path in single quotes inside the quoted string to avoid nested quotes
        init = QUOTE(call compile preprocessFileLineNumbers 'PATHTOF(XEH_postInit.sqf)');
    };
};
