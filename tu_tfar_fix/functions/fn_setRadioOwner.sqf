/*
 	Name: TFAR_fnc_setRadioOwner
 	
 	Author(s):
		L-H
 	
 	Description:
		Sets the owner of a SW radio.
 	
 	Parameters:
		0: OBJECT - _unit
		1: STRING - radio classname
		2: STRING - UID of owner
		3: BOOLEAN - Local only
 	
 	Returns:
		Nothing
 	
 	Example:
		[(call TFAR_fnc_activeSwRadio),player] call TFAR_fnc_setRadioOwner;
*/
#include "script.h"
params ["_unit", "_radio", "_owner", ["_local", false, [false]]];

private _settings = _radio call TFAR_fnc_getSwSettings;
if((_settings select RADIO_OWNER) != _owner) then {
	_settings set [RADIO_OWNER, _owner];
	[_radio, _settings, _local] call TFAR_fnc_setSwSettings;
	//							owner, radio ID
	["OnRadioOwnerSet", _unit, [_unit, _radio]] call TFAR_fnc_fireEventHandlers;
}