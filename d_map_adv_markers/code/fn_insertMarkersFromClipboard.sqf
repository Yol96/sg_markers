#include "main.hpp"

if(!isMultiplayer) then {
	try {
		private _m = parseSimpleArray copyFromClipboard;	
		private _savedMarkers = profileNamespace getVariable [QGVAR(SavedMarkersNew), []];
		private _lastId = if(count _savedMarkers == 0) then {0} else { (_savedMarkers select (count _savedMarkers - 1)) select 0};
		_m set [0, _lastId + 1];
		_savedMarkers pushBack _m;
		profileNamespace setVariable [QGVAR(SavedMarkersNew), _savedMarkers];
		saveProfileNamespace;	
		//100 cutText [format [localize "STR_Addons__d_map_adv_markers__MarkersSaved", _m select 1, _m select 2 ], "PLAIN", -1, true];
		_m call FUNC(addSavedMarkersToDiary);
	} catch {
		[_exception] call BIS_fnc_guiMessage;		
	}
};
