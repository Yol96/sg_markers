/*
 	Name: TFAR_fnc_isRadio
 	
 	Author(s):
		NKey
		L-H

 	Description:
		Checks whether the passed radio is a TFAR radio.
	
	Parameters:
		STRING - Radio classname
 	
 	Returns:
		BOOLEAN
 	
 	Example:
		_isRadio = "NotARadioClass" call TFAR_fnc_isRadio;
*/
#define CACHE_PREFIX "TFAR_cache_isRadio_"
#define CACHE_NAMESPACE missionNamespace

private _r = 	CACHE_NAMESPACE getVariable (CACHE_PREFIX+_this);
if(isNil {_r}) then {
	_r = (configFile >> "CfgWeapons" >> _this >> "tf_radio") call BIS_fnc_getCfgDataBool;
	CACHE_NAMESPACE setVariable [CACHE_PREFIX+_this, _r];
};
_r