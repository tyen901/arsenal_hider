#define MAINPREFIX z
#define PREFIX ace
#define COMPONENT arsenal_hider

#include "\x\cba\addons\main\script_macros_common.hpp"

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers QUOTE(PATHTOF(functions\DOUBLES(fnc,var1).sqf))
#else
    #undef PREP
    #define PREP(var1) [QUOTE(PATHTOF(functions\DOUBLES(fnc,var1).sqf)), QUOTE(TRIPLES(ADDON,fnc,var1))] call cba_fnc_compileFunction
#endif

#define PREP_RECOMPILE_START    if (isNil 'DOUBLES(PREFIX,ADDON)') then { DOUBLES(PREFIX,ADDON) = false; }; if (DOUBLES(PREFIX,ADDON)) then {
#define PREP_RECOMPILE_END      };
