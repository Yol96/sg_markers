#include "main.hpp"

params ["_id"];

private _savedMarkers = profileNamespace getVariable [QGVAR(SavedMarkersNew), []];
private _mms = _savedMarkers select { _x select 0 == _id};
{
	copyToClipboard str _x;
} forEach _mms;		
