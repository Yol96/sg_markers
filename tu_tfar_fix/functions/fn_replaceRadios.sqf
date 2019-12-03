params ["_unit"];

private _classes = _unit call TFAR_fnc_getDefaultRadioClasses;
private _lrRadio = _classes select 0;
private _personalRadio = _classes select 1;
private _riflemanRadio = _classes select 2;
private _defaultRadio = _riflemanRadio;


//LR Radio
if (leader _unit == _unit) then {	
	if (tf_no_auto_long_range_radio or {backpack _unit == "B_Parachute"} or {_unit call TFAR_fnc_isForcedCurator}) exitWith {};
	if ([(backpack _unit), "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty == 1) exitWith {};
	
	private _items = backpackItems _unit;
	private _backPack = unitBackpack _unit;
	_unit addBackpackGlobal _lrRadio;
	clearItemCargoGlobal _backPack;
	{
		if (_unit canAddItemToBackpack _x) then {
			_unit addItemToBackpack _x;
		}else{
			_backPack addItemCargoGlobal [_x, 1]
		};
		true;
	} forEach _items;			
};

//Programmator
if (TF_give_microdagr_to_soldier)  then {
	_unit linkItem "tf_microdagr";
};

//SW Radios
if ((TF_give_personal_radio_to_regular_soldier) or {leader _unit == _unit} or {rankId _unit >= 2}) then {
	_defaultRadio = _personalRadio;
};
[_unit, _defaultRadio] call TFAR_fnc_replaceRadiosIntl