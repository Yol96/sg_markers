params ["_chan"];
private _tf_chan = "D";
private _tf_prot = "";
private _tf_range = 5;
private _tf_type = "";
private _tf_reb = call TFAR_fnc_getTransmittingDistanceMultiplicator;
private _tf_rs;
private _tf_rs2;
private _tf_alt;
private _ok = true;

switch (_chan) do {
	case 1: {
		_tf_rs = call TFAR_fnc_activeLrRadio;

		if(isNil {_tf_rs}) exitWith {
			titletext [localize "STR_Addons__d_map_adv_markers__send_not_allowed_side_chan","PLAIN"];	\
			_ok = false;
		};

		_tf_chan = call TFAR_fnc_currentLRFrequency;
		_tf_prot = _tf_rs call TFAR_fnc_getLrRadioCode;
		_tf_range = ([_tf_rs select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty)  * _tf_reb;
		_tf_type = "LR";
	};
	case 2: {
		_tf_rs = call TFAR_fnc_activeSwRadio;
		_tf_rs2 = call TFAR_fnc_activeLrRadio;

		if(isNil {_tf_rs} && isNil {_tf_rs2}) exitWith {
			titletext [localize "STR_Addons__d_map_adv_markers__send_not_allowed_comm_chan","PLAIN"];						
			_ok = false;
		};

		_tf_prot = _tf_rs call TFAR_fnc_getSwRadioCode;				
		_tf_range = getNumber(configFile >> "CfgWeapons" >> _tf_rs >> "tf_range")  * _tf_reb;
		_tf_chan = call TFAR_fnc_currentSWFrequency;
		_tf_alt = _tf_rs call TFAR_fnc_getAdditionalSwChannel;
		_tf_type = "SW";
		if (_tf_alt > -1) then {
			_tf_chan = [_tf_rs, _tf_alt + 1] call TFAR_fnc_GetChannelFrequency;
		} else {
			_tf_alt = _tf_rs2 call TFAR_fnc_getAdditionalLrChannel;
			if (_tf_alt > -1) then {
				titletext ["Нет альт. КВ, отправляю на альт ДВ","PLAIN"];
				_tf_range = ([_tf_rs2 select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty)  * _tf_reb;
				_tf_chan = [_tf_rs2, _tf_alt + 1] call TFAR_fnc_GetChannelFrequency;
				_tf_prot = _tf_rs2 call TFAR_fnc_getLrRadioCode;
				_tf_type = "LR";
			} else {
				titletext ["Нет альт КВ и ДВ, отправляю на КВ","PLAIN"];
			};
		};					
	};
	case 3: {
		_tf_rs = call TFAR_fnc_activeSwRadio;

		if(isNil {_tf_rs}) exitWith {
			titletext [localize "STR_Addons__d_map_adv_markers__send_not_allowed_grou_chan","PLAIN"];						
			_ok = false;
		};

		_tf_chan = call TFAR_fnc_currentSWFrequency;
		_tf_prot = _tf_rs call TFAR_fnc_getSwRadioCode;				
		_tf_range = getNumber(configFile >> "CfgWeapons" >> _tf_rs >> "tf_range")  * _tf_reb;
		_tf_type = "SW";
	};
	case 4: {
		_tf_chan = "V";
	};
	case 5: {
		_tf_chan = "D";
	};
};

if(_ok) then {
	[_tf_chan,_tf_prot,_tf_range,_tf_type, TF_speak_volume_meters]
}