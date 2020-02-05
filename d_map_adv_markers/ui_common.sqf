disableSerialization;
#include "main.hpp"
#include "settings.hpp"
GVAR(UICurrentChannel) = CHAN_GROUP;
GVAR(UIMarkerTypes) = [];

_cfgt = configFile >> "CfgMarkers"; 
_whiteList = ["hd_dot", "hd_objective", "hd_flag", "hd_destroy", "hd_end","hd_start", "hd_pickup", "hd_warning", "hd_unknown", "o_unknown", "o_inf","sg_complete","o_armor", "swt_sw"]; // Список доступных маркеров
for "_i" from 0 to ((count _cfgt) - 1) do 
{ 
	if ((configName (_cfgt select _i)) in _whiteList) then 
	{ 
		GVAR(UIMarkerTypes) set [count GVAR(UIMarkerTypes), configName (_cfgt select _i)]; 
	}; 
};
GVAR(UIMarkerTypeID) = 0;
GVAR(UIMarkerType) = GVAR(UIMarkerTypes) select GVAR(UIMarkerTypeID);
GVAR(UIMarkerColors) = CLIENT_MARKER_COLOR_AR;
/*_cfgt = configFile >> "CfgMarkerColors";
for "_i" from 0 to ((count _cfgt) - 1) do
{
	GVAR(UIMarkerColors) set [count GVAR(UIMarkerColors), configName (_cfgt select _i)];
};*/

GVAR(UIMarkerColorID) = 0;
GVAR(UIMarkerColor) = GVAR(UIMarkerColors) select GVAR(UIMarkerColorID);
GVAR(UIMarkerThicks) = CLIENT_MARKER_THICKNESS_AR;
GVAR(UIMarkerThickID) = CLIENT_MARKER_DEFAULT_THICKNESS;
GVAR(UIMarkerThick) = GVAR(UIMarkerThicks) select GVAR(UIMarkerThickID);
GVAR(UIMouseMapPosDblClick) = [0, 0];
// update current chat channel (see fn__onEachFrameBody.sqf)
FUNC(UIgetPlayerChanData) =
{
	_retval = objNull;
	if (_this == CHAN_GROUP) then {_retval = group player};
	if (_this == CHAN_SIDE) then {_retval = playerSide};
	if (_this == CHAN_COMMAND) then {_retval = playerSide};
	if (_this == CHAN_GLOBAL) then {_retval = ""};
	if (_this == CHAN_VEHICLE) then {_retval = vehicle player};
	if (_this == CHAN_DIRECT) then {_retval = playerSide};

	
	_retval;
};

GVAR(UIHotkeysLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
FUNC(UIKeyCombToString) =
{
	private _shift = if (_this select 2) then {1} else {0};
	private _ctrl = if (_this select 3) then {1} else {0};
	private _alt = if (_this select 4) then {1} else {0};
	format["%1_%2%3%4", _this select 1, _shift, _ctrl, _alt];	
};
#define CHECK_HOTKEY(x) ([_this select 1, _this select 2, _this select 3, _this select 4] isEqualTo (x))
FUNC(UICheckHotkey_relaxed) =
{
	params ["_ehd", "_hk"];
	(_ehd select 1) == _hk
	// private _ehd = _this select 0;
	// private _hk = _this select 1;
	// private _e = [_ehd select 1, _ehd select 2, _ehd select 3, _ehd select 4];
	
	// if ((_e select 0) in [0x2A, 0x36]) then
	// {
	// 	_e set [1, true];
	// };

	// if ((_e select 0) in [0x1D, 0x9D]) then
	// {
	// 	_e set [2, true];
	// };

	// if ((_e select 0) in [0x38, 0xB8]) then
	// {
	// 	_e set [3, true];
	// };
	
	// {
	// 	if (!(_hk select _x)) then
	// 	{
	// 		_e set [_x, false];
	// 	};
	// } forEach [1, 2, 3];
	
	// _e isEqualTo _hk;
};



