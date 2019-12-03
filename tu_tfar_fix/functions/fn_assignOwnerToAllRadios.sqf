params ["_unit"];
if(alive _unit && !isNil {TFAR_currentUnit} && {TFAR_currentUnit == _unit}) then {
	{
		[_unit, _x, getPlayerUID player, true] call TFAR_fnc_setRadioOwner;
	} forEach (_unit call TFAR_fnc_radiosList);
};