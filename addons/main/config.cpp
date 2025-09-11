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
        init = "call compile preprocessFileLineNumbers '\\z\\arsenal_hider\\addons\\main\\XEH_postInit.sqf'";
    };
};
