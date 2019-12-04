// receives [marker, additional data]

// if time == 0, this function won't be called (assummed to return true always)

#include "main.hpp"
#define VOLUME_OFFSET 1

params ["_mark", "_targ"];

if (_targ != TFAR_currentUnit) then {

	if (d_restr_enable_freeze) then { // Если фриз закончился то ... 
		private _data = _mark select 11;
		private _tf_voice_volume_meters = (_data select 4) * (TFAR_currentUnit getVariable ["tf_globalVolume",1]);		
		private _tf_ok = false;
		private _vehicle = vehicle TFAR_currentUnit;
		private _canHear = (_vehicle == TFAR_currentUnit) || !(TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside);
		private _canSpeak = (vehicle _targ == _targ) || !(_targ call TFAR_fnc_vehicleIsIsolatedAndInside);

		private _d = getPosASL (_vehicle) vectorDistance (getPosASL _targ);

		if ((_d < _tf_voice_volume_meters && _canHear && _canSpeak) || (_vehicle == vehicle _targ) ) then { //Если дистанция меньше громкости голоса и не изолированы или в одной машинеы
			_tf_ok = true;  //голос слышно
		};
		
		if (!_tf_ok && ((_mark select 2) in [1, 2, 3]) ) then {
			private _tf_chan = _data select 0;
			private _tf_prot = _data select 1;
			private _tf_range = (_data select 2) *  (TFAR_currentUnit getVariable ["tf_receivingDistanceMultiplicator", 1]) ;
			private _tf_type = _data select 3;
			private _tf_ti = _targ call TFAR_fnc_calcTerrainInterception;
			
			// эффективная дальность по TFAR с учетом рельефа
			//(bob distance player) + (bob call TFAR_fnc_calcTerrainInterception) * 7 + (bob call TFAR_fnc_calcTerrainInterception) * 7 * ((bob distance player) / 2000.0) 
			_d = _d + _tf_ti * TF_terrain_interception_coefficient + _tf_ti * TF_terrain_interception_coefficient * (_d / 2000.0);

			//Если оглох, то "слышимость" меток понижается 
			_d = _d * (TFAR_currentUnit getVariable ["tf_globalVolume",1]);

			//if(_d > _tf_range) exitWith { false };
			
			if (!_tf_ok && (_mark select 2 == 1)) exitWith { true }; // Если метка в ДВ
			
			/*{
				if (group TFAR_currentUnit == group _x) exitWith { true };	// Если группа юнита совпадает
			} forEach playableUnits; // +select side???? -> playableUnits select {(side _x == const?)}
			*/

			private _tf_isMatch= {
				private _vol = _this select VOLUME_OFFSET;

				//Громкости рации         0 10 20   30   40   50 60 70 80 90 100
				private _volRangeCoeff = [0, 0, 0, 0.3, 0.7, 0.9, 1, 1, 1, 1, 1] select _vol;

				private _chan = (_this select 2) select (_this select 0);
				private _altchan = _chan;
				private _prot = _this select 4;
				private _alt = _this select 5;
				if (_alt > -1) then {
					_altchan = (_this select 2) select (_this select 5);
				};
				
				_tf_chan in [_chan,_altchan] and (_tf_prot == _prot) and _d < (_tf_range * _volRangeCoeff)
			};

 
			//Есть ли рация на нужной частоте
			if (TFAR_currentUnit call TFAR_fnc_canUseRadio) then {
				private _lrs = (TFAR_currentUnit call TFAR_fnc_lrRadiosList) apply { _x call TFAR_fnc_getLrSettings };
				private _sws = (TFAR_currentUnit call TFAR_fnc_radiosList) apply  { _x call TFAR_fnc_getSwSettings };

				{
					if(_tf_ok) exitWith {};
					_tf_ok = _x call _tf_isMatch;
				} forEach (_lrs+_sws);
			};

			if(_tf_ok) exitWith {true};

			//Проверка на слышимость рации на динамиках

			private _eyePos = eyePos TFAR_currentUnit;
			private _speakerHearingDistance = TF_speakerDistance;
			if(_vehicle != TFAR_currentUnit) then {
				 _speakerHearingDistance = _speakerHearingDistance * (1-([(typeof _vehicle), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty));
			};

			//Машины в радиусе слышимости динамиков рации
			private _vehs = TFAR_currentUnit nearEntities [["LandVehicle", "Air", "Ship"], _speakerHearingDistance];

			//Экипажи\пассажиры машин
			private _unitsInVehicles = [];
			{
				{ _unitsInVehicles pushBack _x;	} forEach crew _x;
			} forEach _vehs;


			//есть ли рядом человек живой или мертвый в машине или на земле с рацией на нужной частоте на динамиках
			private _units = (_unitsInVehicles+(TFAR_currentUnit nearObjects ["Man", _speakerHearingDistance])) select { 
				 _x != TFAR_currentUnit 
				 && ((_x getVariable ["tf_lr_speakers", false]) || (_x getVariable ["tf_sw_speakers", false])) 
				 && (_x call TFAR_fnc_canUseRadio)				 
			};

			{
				if(_tf_ok) exitWith {};
				private _ds = _eyePos vectorDistance (getPosASL _x);				
				private _v = vehicle _x;

				if(_x != _v && _v != _vehicle) then { //Человек в машине и не в машине игрока
						private _i = [(typeof _v), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty;				
						if(!isTurnedOut _x || {!(_x call TFAR_fnc_isTurnedOut)}) then {
							if(_i < 1)	then {
								_ds = _ds/(1-_i); //Увеличиваем "расстояние" до слушателя на величину изоляции						
							} else {
								_ds = 10000; //Очень далеко
							};						
						};
						if( _ds > _speakerHearingDistance  ) exitWith {}; 
				};
				
				private _lrs = [];
				private _b = _x call TFAR_fnc_backpackLr;
				if(!(_b isEqualTo [])) then {
					_lrs = [_b] apply { _x call TFAR_fnc_getLrSettings } select { _x select TF_LR_SPEAKER_OFFSET };
				};
				private _sws = (_x call TFAR_fnc_radiosList) apply { _x call TFAR_fnc_getSwSettings } select { _x select TF_SW_SPEAKER_OFFSET };
				{
					if(_tf_ok) exitWith {};
					if(_ds < _speakerHearingDistance * (_x select VOLUME_OFFSET) / 10) then {
						_tf_ok = _x call _tf_isMatch;
					};
				} forEach (_lrs+_sws);
			} forEach _units;

			if(_tf_ok) exitWith {true};

			//Есть ли рядом рации на динамиках, выброшенные на землю
			private _holders = nearestObjects [TFAR_currentUnit, ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated"], _speakerHearingDistance];
			{
				if(_tf_ok) exitWith {};
				
				private _pos = getPosASL _x;
				private _ds = _eyePos vectorDistance _pos;				

				if (_pos select 2 >= TF_UNDERWATER_RADIO_DEPTH) then {	
					private _lrs = (everyBackpack _x) select {([typeOf _x, "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty) == 1}  apply { [_x, "radio_settings"] call TFAR_fnc_getLrSettings } select { _x select TF_LR_SPEAKER_OFFSET };
					private _sws = ((getItemCargo _x) select 0) select {_x call TFAR_fnc_isRadio}  apply { _x call TFAR_fnc_getSwSettings } select { _x select TF_SW_SPEAKER_OFFSET };
					{
						if(_tf_ok) exitWith {};
						if(_ds < _speakerHearingDistance * (_x select VOLUME_OFFSET) / 10) then {
							_tf_ok = _x call _tf_isMatch;
						};
					} forEach (_lrs+_sws);
				};
			} forEach _holders;
			
			//Есть ли рядом живая техника с рациями на динамиках
			_vehs = _vehs select { (_x getVariable ["tf_lr_speakers", false]) and {_x call TFAR_fnc_hasVehicleRadio} };
			{
				if(_tf_ok) exitWith {};
				private _pos = getPosASL _x;
				private _ds = _eyePos vectorDistance _pos;				

				if(_x != _vehicle) then { //Не машина игрока
					private _i = [(typeof _x), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty;
					if(_i < 1)	then {
						_ds = _ds/(1-_i); //Увеличиваем "расстояние" до слушателя на величину изоляции						
					} else {
						_ds = 10000; //Очень далеко
					};
					if( _ds > _speakerHearingDistance  ) exitWith {}; 				
				};


				if (_pos select 2 >= TF_UNDERWATER_RADIO_DEPTH) then {	
					_lrs = [];
					if (count (_x getVariable ["gunner_radio_settings", []]) > 0) then {
						_lrs pushBack [_x, "gunner_radio_settings"];
					};
					if (count (_x getVariable ["driver_radio_settings", []]) > 0) then {
						_lrs pushBack [_x, "driver_radio_settings"];
					};		
					if (count (_x getVariable ["commander_radio_settings", []]) > 0) then {
						_lrs pushBack [_x, "commander_radio_settings"];
					};
					if (count (_x getVariable ["turretUnit_0_radio_setting", []]) > 0) then {
						_lrs pushBack [_x, "turretUnit_0_radio_setting"];
					};
					_lrs = _lrs apply { _x call TFAR_fnc_getLrSettings } select { _x select TF_LR_SPEAKER_OFFSET };
					{
						if(_tf_ok) exitWith {};
						if(_ds < _speakerHearingDistance * (_x select VOLUME_OFFSET) / 10) then {
							_tf_ok = _x call _tf_isMatch;
						};
					} forEach (_lrs);					
				};
			} forEach _vehs;

		};
		_tf_ok;		
	} else {
		true;
	};
} else {
	true;
}