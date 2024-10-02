// File: init.sqf
// Author: Olympus Entertainment

waitUntil {!isNull player && player == player};
waitUntil {!(isNull (findDisplay 46))};

[] call compile PreprocessFileLineNumbers "core\configuration.sqf";

diag_log "Display 46 Found";
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call life_fnc_keyHandler"];

[] call JDEV_fnc_setupEVH;