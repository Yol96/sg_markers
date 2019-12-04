// receives [marker]

#include "main.hpp"

#define CUT_LAYER 2344223

params ["_mark", "_data"];
private _chan = _mark select 2;

if (d_restr_enable_freeze) then { // Если фриз закончился то ...
	if (MAR_CHAN(_mark) in [CHAN_VEHICLE, CHAN_DIRECT]) exitWith {true};
	
	if(isnil {_data}) exitWith { false };

	private _orig_chan = _mark select 12;
	
	/*
	if(GVAR(can_send_marker) == 2)  exitWith { // Нельзя ставить маркеры по рации - CBA(can_send_marker)
		2344223 cutText [
		localize "STR_Addons__d_map_adv_markers__send_not_allowed_all", 
		"PLAIN", 0.2, true];
		false
	};
	*/
	if(!(call TFAR_fnc_haveLRRadio) && !((_orig_chan == 3) || (_orig_chan == 2 && (_data select 3) == "SW")))  exitWith { // Нет ДВ для отправки маркеров - CBA(can_send_marker)
		2344223 cutText [
		localize "STR_Addons__d_map_adv_markers__send_not_allowed_noLR", 
		"PLAIN", 0.2, true];
		false
	};
	/*
	if(GVAR(can_send_marker) == 1 && (_orig_chan == 3 or ( _orig_chan == 2 && (_data select 3) == "SW")))  exitWith { // Нельзя отправить маркер по КВ - CBA(can_send_marker)
		2344223 cutText [
		localize "STR_Addons__d_map_adv_markers__send_not_allowed_SW", 
		"PLAIN", 0.2, true];
		false
	};
	*/
	/*
	CHAN_GLOBAL 0
	CHAN_SIDE 1
	CHAN_COMMAND 2
	CHAN_GROUP 3
	CHAN_VEHICLE 4
	CHAN_DIRECT 5
	*/

	if (_orig_chan in [1, 2,3] ) exitWith 
	{
		if (TFAR_currentUnit call TFAR_fnc_canUseRadio) then
		{
			true
		}
		else
		{
			2344223 cutText [
			localize "STR_Addons__d_map_adv_markers__send_not_allowed_cant_use_radio", // Для отправки маркера необходима работающая рация
			"PLAIN", 0.2, true];
			false			
		}
	};
	true
} else {

	if (MAR_CHAN(_mark) == CHAN_GLOBAL) exitWith
	{ // Отправка маркеров на общий канал запрещена
		CUT_LAYER cutText [
			localize "STR_Addons__d_map_adv_markers__send_not_allowed_glob_chan", 
			"PLAIN", 0.2, true];
		false

	};

	true
}
