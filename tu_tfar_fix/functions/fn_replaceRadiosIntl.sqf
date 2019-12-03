params ["_unit", "_defaultRadio"];

private _replaceRadio = {
		params ["_radio"];
		if (_radio == "ItemRadio") then {
			_radio = _defaultRadio;
		};

		private _count = -1;

		{
			if ((_x select 0) == _radio) exitWith {
				_x set [1, (_x select 1) + 1];
				_count = (_x select 1);
			};
		} forEach TF_Radio_Count;

		if (_count == -1) then {
			TF_Radio_Count pushBack [_radio,1];
			_count = 1;
		};
		format["%1_%2", _radio, _count];
};

private _replacedRadios = [];

{
    if (_x call TFAR_fnc_isPrototypeRadio) then {
		//replace
		private _r = (_x call _replaceRadio);
		_unit linkItem _r;
		_replacedRadios pushBack _r;
    };	
} forEach (assignedItems _unit);

{
    if (_x call TFAR_fnc_isPrototypeRadio) then {
		private _r = (_x call _replaceRadio);
		_unit removeItem _x;					
		_unit addItem _r;
		_replacedRadios pushBack _r;
    };
} forEach (items _unit);


["OnRadiosReceived", _unit, [_unit, _replacedRadios]] remoteExec ["TFAR_fnc_fireEventHandlers", _unit];