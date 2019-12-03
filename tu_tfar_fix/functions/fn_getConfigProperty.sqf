/*
 	Name: TFAR_fnc_getConfigProperty
 	
 	Author(s):
		NKey
		L-H
 	
 	Description:
	Gets a config property (getNumber/getText)
	Only works for CfgVehicles.
 	
 	Parameters: 
 	0: STRING - Item classname
	1: STRING - property
	2: ANYTHING - Default (Optional)
 	
 	Returns:
 	NUMBER or TEXT - Result
 	
 	Example:
		[_LRradio, "tf_hasLrRadio", 0] call TFAR_fnc_getConfigProperty;
 */
#define CACHE_NAMESPACE missionNamespace
#define CACHE_NIL_VALUE (-12345)

params ["_item", "_prop", ["_default", "", [0,""]]];

private _key = format ["TFAR_cache_getConfigProperty_%1_%2", _item, _prop];
private _r = CACHE_NAMESPACE getVariable _key;

if(isNil { _r } ) then {
	_r = (ConfigFile >> "CfgVehicles" >> _item >> _prop ) call BIS_fnc_getCfgData;
	if(isNil { _r } ) then {
		_r = (ConfigFile >> "CfgVehicles" >> _item >> _prop + "_api") call BIS_fnc_getCfgData;
	};
	if(isNil { _r } ) then {
		_r = CACHE_NIL_VALUE;
		CACHE_NAMESPACE setVariable [_key, _r];
	};	
	CACHE_NAMESPACE setVariable [_key, _r];
};

if( _r isEqualTo CACHE_NIL_VALUE ) then {
	_r = _default;
};
_r