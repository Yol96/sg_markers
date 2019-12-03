#include "main.hpp"

if((isServer ||  player == ( (playableUnits select { side _x == side player }) select 0 ))  && time == 0) then {//только на локальном сервере
	private _ms = (call FUNC(GetAllMarkers)) apply {
		_x params ["", "", "_chan", "", "_player", "_text", "_type", "_color", "_thick", "_coords", "", "", "_orig_chan"];
		if(!isnil {_orig_chan}) then {
			_chan = _orig_chan;
		};
		[_chan, _text, _type, _color, _thick, _coords]
	};
	if(count _ms > 0) then {
		private _savedMarkers = profileNamespace getVariable [QGVAR(SavedMarkersNew), []];
		private _lastId = if(count _savedMarkers == 0) then {0} else { (_savedMarkers select (count _savedMarkers - 1)) select 0};
		private _m = [_lastId + 1, worldName, briefingName, _ms];
		_savedMarkers pushBack _m;
		profileNamespace setVariable [QGVAR(SavedMarkersNew), _savedMarkers];
		saveProfileNamespace;	
		//100 cutText [format [localize "STR_Addons__d_map_adv_markers__MarkersSaved", _m select 1, _m select 2 ], "PLAIN", -1, true];
		_m call FUNC(addSavedMarkersToDiary);
	};
};