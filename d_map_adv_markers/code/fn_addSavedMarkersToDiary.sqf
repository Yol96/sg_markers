#include "main.hpp"
params ["_id", "_island", "_mission"];
player createDiaryRecord ["Markers", [localize "STR_Addons__d_map_adv_markers__Saved", 
	format["#%1 - %3 (%2) (<execute expression = '%1 call %4'>%5</execute> | <execute expression = '%1 call %6'>%7</execute> | <execute expression = '%1 call %8'>%9</execute>)", 
	_id, _island, _mission,
	QFUNC(loadMarkers), localize "STR_Addons__d_map_adv_markers__load",
	QFUNC(deleteSavedMarkers), localize "STR_Addons__d_map_adv_markers__delete",
	QFUNC(copyMarkersToClipboard), localize "STR_Addons__d_map_adv_markers__clipboard"]]];		
