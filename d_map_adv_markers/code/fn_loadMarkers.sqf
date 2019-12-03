#include "main.hpp"
params ["_id"];


if(time == 0 && (isServer || player == ( (playableUnits select { side _x == side player }) select 0 ) ) ) then { //Только на брифинге и КС
	private _savedMarkers = profileNamespace getVariable [QGVAR(SavedMarkersNew), []];
	private _mms = _savedMarkers select { _x select 0 == _id};
	if(count _mms == 0) exitWith { false };

	{
		private _ids = missionNamespace getVariable [QGVAR(loadedMarkerIds), []];
		private _ids1 = (_ids select { (diag_tickTime - (_x select 1)) < 60  }) apply { _x select 0 };
		if(!((_x select 0) in _ids1)) then {
			private _ms = _x select 3;
			if(count _ms < 300) then {
				{
					_x params ["_chan", "_text", "_type", "_color", "_thick", "_coords"];
					private _val = [-1, -1, _chan, _chan call FUNC(UIgetPlayerChanData),
						name player, _text, _type,
						_color, _thick, _coords,
						daytime];
					[_val, player] remoteExec [QFUNC(SAddLineMarker),2];
				} foreach _ms;
				//100 cutText [format [localize "STR_Addons__d_map_adv_markers__MarkersLoaded", _x select 1, _x select 2 ], "PLAIN", -1, true];
				_ids pushBack [(_x select 0), diag_tickTime]; 
				missionNamespace setVariable [QGVAR(loadedMarkerIds), _ids];
			};		
		};
	} forEach _mms;		
	true
};
