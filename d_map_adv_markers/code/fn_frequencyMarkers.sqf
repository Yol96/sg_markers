if !(isServer) exitWith {};
if !(isClass (configFile >> "CfgPatches" >> "d_map_adv_markers")) exitWith {diag_log "d_map_adv_markers not loaded"};
if (toLower(missionName select [0,4]) != "mace") exitWith {};


private _all_sides = [east,west,resistance,civilian];
private _frequencies = _all_sides apply {[]};

private _radio_marker_pos = getMarkerPos "tu_radios";
if ((_radio_marker_pos select 0) == 0) then {

	private _default_positions = [
		["Altis",[14001.3,14998.8]],
		["Bootcamp_ACR",[3999.98,2814.03]],
		["Woodland_ACR",[7997.27,4662.42]],
		["Chernarus",[14000.5,7364.36]],
		["Fallujah",[-1003.75,7255.18]],
		["fallujahint",[-1003.75,7255.18]],
		["pja310",[4002.5,3000.97]],
		["pja314",[114.752,16758.4]],
		["lythium",[990.265,19999.4]],
		["malden",[9004.71,9998.22]],
		["Napf",[988.522,17999.2]],
		["ProvingGrounds_PMC",[2000.81,1768.26]],
		["ruha",[18.0441,3990.76]],
		["Stratis",[5992.29,2995.3]],
		["Takistan",[12990.8,12013.1]],
		["Tanoa",[13999.6,15016.3]],
		["Utes",[1004.73,4114.96]],
		["Zargabad",[6001.7,6016.57]],
		[worldName,[95,7000]]	// catch-all
	];
	_radio_marker_pos = ((_default_positions select {_x select 0 == worldName}) select 0) select 1;
};

{
	private _side = side _x;
	private _side_index = _all_sides find _side;
	private _squad_name = (name leader _x); // splitString "[]" select 0;
	diag_log (_x getVariable ["tf_sw_frequency",0]);
	private _fq = call compile ((_x getVariable ["tf_sw_frequency",[0,0,["0"]]]) select 2 select 0);
	if (_fq != 0 && _side_index >= 0) then {
		private _callsign = groupId _x;
		private _shift = 0;
		while {_shift == 0 || (_fq + _shift * 4) > 511 || (_fq + _shift * 4) < 33 } do {
			_shift = (floor(random [-30,1,30])) * selectRandom [0.1,1,10];
		};
		private _plus = if (_shift > 0) then {"+"} else {""};
		private _txt = format ["%1 %2: %3 %4%5",_callsign, _squad_name,_fq,_plus,_shift];
		(_frequencies select _side_index) pushBack [_radio_marker_pos,_txt];
		_radio_marker_pos = [_radio_marker_pos select 0, (_radio_marker_pos select 1) - 200];
	};
} forEach allGroups;

[_frequencies] spawn {
	params [["_frequencies",[]]];

	// If you ask yourself "WTF is markerLogic" 
	// see addons/d_map_adv_markers/persistentMarkers.sqf

	private _timeout = time + 10;
	waitUntil {(!isNil "markerLogic") || (time > _timeout)};
	if (isNil "markerLogic") exitWith {diag_log "no markerLogic"};
	{
		private _i = 0;
		private _side = _x;
		while {count(markerLogic getVariable [format ['pers_marker%1%2',_side,_i],[]])!=0} do {
			_i = _i + 1;
		};
		{
			markerLogic setVariable [format ['pers_marker%1%2',_side,_i],_x,true];
			markerLogic setVariable [format ['pers_marker_count%1',_side],_i,true];
			_i = _i + 1;
		} forEach (_frequencies select _forEachIndex);
	} forEach [east,west,resistance,civilian];

	c_persistent_markers_update = true;
	publicVariable "c_persistent_markers_update";
};
