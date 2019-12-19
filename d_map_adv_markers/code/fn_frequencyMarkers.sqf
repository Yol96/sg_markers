if !(isServer) exitWith {};
if !(isClass (configFile >> "CfgPatches" >> "d_map_adv_markers")) exitWith {diag_log "d_map_adv_markers not loaded"};
if (toLower(missionName select [0,4]) != "mace") exitWith {};


private _all_sides = [east,west,resistance,civilian];
private _frequencies = _all_sides apply {[]};

private _radio_marker_pos = getMarkerPos "tu_radios";
if ((_radio_marker_pos select 0) == 0) then {

	private _default_positions = [
		["Altis",[309,105]],
		["Chernarus",[15400,10500]],
		["Chernarus_Winter",[15400,10500]],
		["Bozcaada",[20900,11900]],
		["pja310",[4002.5,3000.97]],
		["pja314",[114.752,16758.4]],
		["FDF_Isle1_a",[20900,05900]],
		["pja310",[20900,15000]],
		["lythium",[21000,14700]],
		["malden",[9004.71,9998.22]],
		["ProvingGrounds_PMC",[02000,01400]],
		["Tembelan",[10300,06700]],
		["Stratis",[08300,05800]],
		["Takistan",[14700,08200]],
		["tem_anizay",[10400,07100]],
		["WL_Rosche",[20600,74700]],
		["pulau",[12400,08100]],
		["mbg_celle2",[72000,20000]],
		["hellanmaa",[08200,06500]],
		["hellanmaaw",[08200,06500]],
		["Shapur_BAF",[02200,01400]],
		["Sara_dbe1",[20800,14200]],
		["Sara",[20800,14200]],
		["Utes",[05200,03500]],
		["Zargabad",[08300,05800]],
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
