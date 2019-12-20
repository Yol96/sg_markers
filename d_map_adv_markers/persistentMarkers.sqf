		//////////////////////////////
		// For tu_markers support
		//////////////////////////////


c_persistent_markers_showMarkers = {
	private["_data"];
	_side = side player;
	_i = 0;

	while {_data = markerLogic getVariable [format ['pers_marker%1%2',_side,_i],[]];(count(_data)!=0)} do {
		_name = "pers_marker"+str(_side) + str(_i);
		if ((markerType _name) == '') then {
			_pos = _data select 0;
			_text = _data select 1;
			_playerName = _data select 2;
			_flag = _text select [0,2];
			_text = _text select [2, count _text];
			_text = _playerName + ' ' + _text;
			createMarkerLocal [_name,_pos];
			_markerTypeLrFlags = ["LR", "DV"];
			if (_flag in _markerTypeLrFlags) then {
				_name setMarkerTypeLocal "swt_lr"; // mil_marker
			} else {
				_name setMarkerTypeLocal "swt_sw";
			};
			_name setMarkerSizeLocal [0.8, 0.8];
			_name setMarkerTextLocal _text;
			_name setMarkerColorLocal "ColorRed";
			_name setMarkerAlphaLocal 1;

			player createDiaryRecord ["Markers", [localize "STR_Addons__d_map_adv_markers__Persistent", format["<marker name = '%1'>%2</marker> %3",_name,mapGridPosition _pos,_text]]];
		};
		_i = _i + 1;
	};
	c_persistent_markers_update = false;
};

c_persistent_markers_markerHandle = {
	_control = ((findDisplay 54) displayCtrl 101);
	_name = (name player);
	_text = (ctrlText _control);
	_control ctrlSetText '';
	_ctrlPos = ctrlPosition _control;

	_mapDisplay = ({if !(isNull(findDisplay _x)) exitWith {findDisplay _x}} forEach [12,37,52,53]);
	_pos = (_mapDisplay displayCtrl 51) ctrlMapScreenToWorld [(_ctrlPos select 0) - 0.025, (_ctrlPos select 1) + 0.02];

	_side = side player;
	_i = 0;
	while {count(markerLogic getVariable [format ['pers_marker%1%2',_side,_i],[]])!=0} do {
		_i = _i + 1;
	};

	markerLogic setVariable [format ['pers_marker%1%2',_side,_i],[_pos,_text,_name],true];
	markerLogic setVariable [format ['pers_marker_count%1',_side],_i,true];
	[] call c_persistent_markers_showMarkers;
	c_persistent_markers_update = true;publicVariable "c_persistent_markers_update";
};


if (isServer) then {
	markerLogic = (createGroup sideLogic createUnit ["logic", [0, 0], [], 0, "form"]);
	publicVariable "markerLogic";
	{
		markerLogic setVariable [format ['pers_marker_count%1',_x],0,true];
	} forEach [east,west,resistance,civilian];
	c_persistent_markers_update = false;publicVariable "c_persistent_markers_update";
	if (isNull markerLogic) then {diag_log (__FILE__+" - something wrong")};
};
if (!isDedicated) then {
	"c_persistent_markers_update" addPublicVariableEventHandler {
		[] call c_persistent_markers_showMarkers;
	};
	[] spawn {
		waitUntil {!isNil{markerLogic}};
		waitUntil {(markerLogic getVariable [format ['pers_marker_count%1',side player],-1])>=0};
		waitUntil {count(markerLogic getVariable [format ['pers_marker%1%2',side player,(markerLogic getVariable [format ['pers_marker_count%1',side player],-1])],[]])>0};
		[] call c_persistent_markers_showMarkers;
	};
};
