#include "main.hpp"
params ["_id"];
private _savedMarkers = profileNamespace getVariable [QGVAR(SavedMarkersNew), []];
private _idx = 0;
while { _idx < count _savedMarkers} do {
	private _m = (_savedMarkers select _idx);
	if(_m select 0 == _id) then {
		_savedMarkers deleteAt _idx;
		//100 cutText [format [localize "STR_Addons__d_map_adv_markers__MarkersDeleted", _m select 1, _m select 2 ], "PLAIN", -1, true];
	} else 	{
		_idx = _idx + 1;
	}
};
profileNamespace setVariable [QGVAR(SavedMarkersNew), _savedMarkers];
saveProfileNamespace;	
