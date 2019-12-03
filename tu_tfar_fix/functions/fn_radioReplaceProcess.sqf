/*
 	Name: TFAR_fnc_radioReplaceProcess

 	Author(s):
		NKey

 	Description:
		Replaces a player's radios if there are any prototype radios.

	Parameters:
		Nothing

 	Returns:
		Nothing

 	Example:
		[] spawn TFAR_fnc_radioReplaceProcess;
*/
private ["_currentPlayerFlag", "_active_sw_radio", "_active_lr_radio", "_set", "_controlled"];
while {true} do {
	TFAR_currentUnit = call TFAR_fnc_currentUnit;
	if ((isNil "TFAR_previouscurrentUnit") or {TFAR_previouscurrentUnit != TFAR_currentUnit}) then {
		TFAR_previouscurrentUnit = TFAR_currentUnit;
		_set = (TFAR_currentUnit getVariable "tf_handlers_set");
		if (isNil "_set") then {
			TFAR_currentUnit addEventHandler ["Take", {
				params ["_unit", "_container", "_item"];
				if (_item call TFAR_fnc_isRadio) then {
					[_unit, _item, getPlayerUID player] call TFAR_fnc_setRadioOwner;
				};
				if(_item call TFAR_fnc_isPrototypeRadio) then {
			 		[_unit, (_unit call TFAR_fnc_getDefaultRadioClasses) select 2] remoteExec ["TFAR_fnc_replaceRadiosIntl", 2];
				};
			}];
			TFAR_currentUnit addEventHandler ["Put", {
				params ["_unit", "_container", "_item"];
				if (_item call TFAR_fnc_isRadio) then {
					[_unit, _item, ""] call TFAR_fnc_setRadioOwner;
				};
			}];
			TFAR_currentUnit addEventHandler ["Killed", {
				params ["_unit"];				
				private _items = (assignedItems _unit) + (items _unit);
				{
					private _class = ConfigFile >> "CfgWeapons" >> _x;
					if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
						[_unit, _x, ""] call TFAR_fnc_setRadioOwner;
					};
					true;
				} count _items;
				//Bug fix for spectator mode, player continue transmit in teamspeak after being killed during radio transmission 
				"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", name _unit]);
			}];
			TFAR_currentUnit setVariable ["tf_handlers_set", true];
		};
	};
	if (TFAR_currentUnit != player) then {
		_controlled = player getVariable "tf_controlled_unit";
		if (isNil "_controlled") then {
			player setVariable ["tf_controlled_unit", TFAR_currentUnit, true];
			if (isMultiplayer) then {
				"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", name player]);
			};
		};
	} else {
		_controlled = player getVariable "tf_controlled_unit";
		if !(isNil "_controlled") then {
			player setVariable ["tf_controlled_unit", nil, true];
			if (isMultiplayer) then {
				"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", name player]);
			};
		};
	};
	
		// hide curator players
	{
		if (_x call TFAR_fnc_isForcedCurator) then {
			_x enableSimulation false;
			_x hideObject true;
		};
		true;
	} count (call BIS_fnc_listCuratorPlayers);

	if !(TF_use_saved_sw_setting) then {
		if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveSWRadio)) then {
			_active_sw_radio = call TFAR_fnc_activeSwRadio;
			if !(isNil "_active_sw_radio") then {
				TF_saved_active_sw_settings = _active_sw_radio call TFAR_fnc_getSwSettings;
			} else {
				TF_saved_active_sw_settings = nil;
			};
		} else {
			TF_saved_active_sw_settings = nil;
		};
	};

	if !(TF_use_saved_lr_setting) then {
		if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveLRRadio)) then {
			_active_lr_radio = call TFAR_fnc_activeLrRadio;
			if !(isNil "_active_lr_radio") then {
				TF_saved_active_lr_settings = _active_lr_radio call TFAR_fnc_getLrSettings;
			} else {
				TF_saved_active_lr_settings = nil;
			};
		} else {
			TF_saved_active_lr_settings = nil;
		};
	};

	if (((time - (TFAR_currentUnit getVariable ["tf_proto_last_check", 0])) > 10) and (alive TFAR_currentUnit) and tf_needCheckInventory) then {
		if(TFAR_currentUnit call TFAR_fnc_hasPrototypeRadio) then {
	 		[TFAR_currentUnit] remoteExec ["TFAR_fnc_replaceRadios",2];
		};		
		TFAR_currentUnit setVariable ["tf_proto_last_check", time];
		tf_needCheckInventory = false;
	};

	sleep 2;	
};
