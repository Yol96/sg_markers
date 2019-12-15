// Made by Drill
#include "main.hpp"

#define PATH_PREFIX "\xx\addons\d_map_adv_markers\"


[] spawn
{

	[] call compile preprocessFileLineNumbers (PATH_PREFIX + "persistentMarkers.sqf");

	if (!isDedicated) then
	{
		[] call compile preprocessFileLineNumbers (PATH_PREFIX + "ui_common.sqf");
	};

	[] call compile preprocessFileLineNumbers (PATH_PREFIX + "functions.sqf");


	if (isServer) then
	{
		[] call compile preprocessFileLineNumbers (PATH_PREFIX + "server.sqf");
	};

	if (!isDedicated) then
	{
		[] call compile preprocessFileLineNumbers (PATH_PREFIX + "client.sqf");
		execVM (PATH_PREFIX + "ui_map.sqf");
		execVM (PATH_PREFIX + "ui_im.sqf");
	};


};

[] spawn {	
	d_restr_enable_freeze = false;
	sleep .1;
	if (GVAR(restrictMarkers)) then {
		GVAR(game_startedEh) = ["tu_platform_game_started", {
			d_restr_enable_freeze = true;
			["tu_platform_game_started", GVAR(game_startedEh)] call CBA_fnc_removeEventHandler;
		}] call CBA_fnc_addEventHandler;
		
		["created", { 
			params ["_newMarker"];
			if (markerShape(_newMarker) == "POLYLINE") then {
				deleteMarker _newMarker;
			};
		}] call CBA_fnc_addMarkerEventHandler;

		waituntil {sleep 3.15; !(isNil "a3a_var_started") or !(isnil "Serp_warbegins")};
		if (!isNil "a3a_var_started") then {
				waituntil {sleep 3.15; a3a_var_started};
				d_restr_enable_freeze = true;
		} else {
			if (!isnil "Serp_warbegins") then {
				waituntil {sleep 3.15; Serp_warbegins == 1};
				d_restr_enable_freeze = true;
			};
		};

	};
};

if(hasInterface) then {
	player createDiarySubject ["Markers", localize "STR_Addons__d_map_adv_markers__Subject"];

	if(!isMultiplayer) then {
		player createDiaryRecord ["Markers", [localize "STR_Addons__d_map_adv_markers__Saved", 
			format["<execute expression = 'call %1'>%2</execute>", QFUNC(insertMarkersFromClipboard), localize "STR_Addons__d_map_adv_markers__Insert"]]];		
	};

	if(isServer ||  player == ( (playableUnits select { side _x == side player }) select 0 )) then {
		player createDiaryRecord ["Markers", [localize "STR_Addons__d_map_adv_markers__Saved", 
			format["<execute expression = 'call %1'>%2</execute>", QFUNC(saveMarkers), localize "STR_Addons__d_map_adv_markers__Save"]]];		
		{
			_x call FUNC(addSavedMarkersToDiary);
		} forEach (profileNamespace getVariable [QGVAR(SavedMarkersNew), []]);		
	};
};