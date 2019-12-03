/*
	Name: TFAR_fnc_isPrototypeRadio
	
	Author(s): Garth de Wet (LH)
	
	Description:
	Returns if a radio is a prototype radio.
	
	Parameters: 
	0: STRING - Radio classname
	
	Returns:
	BOOLEAN - True if prototype, false if actual radio.
	
	Example:
	if ("tf_148jem" call TFAR_fnc_isPrototypeRadio) then {
		hint "Prototype";
	};
*/

#define CACHE_PREFIX "TFAR_cache_isPrototypeRadio_"
#define CACHE_NAMESPACE missionNamespace
if (_this == "ItemRadio") exitWith {true};

private _result = 	CACHE_NAMESPACE getVariable (CACHE_PREFIX+_this);
if (isNil {_result}) then {
	_result = getNumber (configFile >> "CfgWeapons" >> _this >> "tf_prototype");
	CACHE_NAMESPACE setVariable [CACHE_PREFIX+_this, _result];
};

(_result == 1)