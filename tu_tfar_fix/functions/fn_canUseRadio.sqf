params ["_u"];
private _i = _u call TFAR_fnc_vehicleIsIsolatedAndInside;
private _d = _u call TFAR_fnc_eyeDepth;

(call TFAR_fnc_haveSWRadio && { [_u, _i, [_i, _d] call TFAR_fnc_canSpeak, _d] call TFAR_fnc_canUseSWRadio}) 
	or (call TFAR_fnc_haveLRRadio && {[_u, _i, _d] call TFAR_fnc_canUseLRRadio  });
