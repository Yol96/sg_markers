// Made by Drill

#include "main.hpp"
#include "settings.hpp"









waitUntil {!(isNil 'V_SERVER_READY')};



GVAR(CSideMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
GVAR(CCommandMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
GVAR(CGroupMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
GVAR(CGlobalMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
GVAR(CVehicleMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];
GVAR(CDirectMarkersLogic) = "Logic" createVehicleLocal [-10000,-10000,0];


GVAR(CTempMarkers) = [];


GVAR(CMarkerChannelToChar) = MARKER_CHANNEL_TO_CHAR_AR;


GVAR(CMarkerTagNameVisibilityTemporaryOn) = false;



// args: [marker array, base marker name]
FUNC(CapplyMarkerVisibility) =
{
	params ["_mar","_m"];	
	private _text = MAR_TEXT(_mar);
	
	// line marker
	if (count MAR_COORDS(_mar) > 1) then
	{
		if (  GVAR(CLineMarkerTagNameVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagNameVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagNameVisibility) == MTAG_OFF )
			 ) then
		{
			_text = MAR_NAME(_mar) + " " + _text;
		};


		if (  GVAR(CLineMarkerTagDaytimeVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagDaytimeVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagDaytimeVisibility) == MTAG_OFF )
			 ) then
		{
			private _dt = MAR_DAYTIME(_mar);

			private _h = floor _dt;
			private _ht = str _h;
			if ((count _ht) < 2) then {_ht = "0" + _ht;};
			
			private _m = floor ((_dt - _h) * 60);
			private _mt = str _m;
			if ((count _mt) < 2) then {_mt = "0" + _mt;};
			
			
			_text = _ht + ":" + _mt + " " + _text;
		};



		if (  GVAR(CLineMarkerTagChannelVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagChannelVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CLineMarkerTagChannelVisibility) == MTAG_OFF )
			 ) then
		{
			
			if (d_restr_enable_freeze) then {
				if (_mar select 12 == 1) then {
				_text = (GVAR(CMarkerChannelToChar) select MAR_CHAN(_mar)) + " " + _text;
				} else
				{
				_text = ((_mar select 11) select 0) + " " + _text;
				};
			} else {
				_text = (GVAR(CMarkerChannelToChar) select MAR_CHAN(_mar)) + " " + _text;
			};
		};
		
		
	}
	else // ordinal marker
	{
		
		if (  GVAR(CMarkerTagNameVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagNameVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagNameVisibility) == MTAG_OFF )
			 ) then
		{
			_text = MAR_NAME(_mar) + " " + _text;
		};


		if (  GVAR(CMarkerTagDaytimeVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagDaytimeVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagDaytimeVisibility) == MTAG_OFF )
			 ) then
		{
			private _dt = MAR_DAYTIME(_mar);

			private _h = floor _dt;
			private _ht = str _h;
			if ((count _ht) < 2) then {_ht = "0" + _ht;};
			
			private _m = floor ((_dt - _h) * 60);
			private _mt = str _m;
			if ((count _mt) < 2) then {_mt = "0" + _mt;};
			
			
			_text = _ht + ":" + _mt + " " + _text;
		};
		
		

		if (  GVAR(CMarkerTagChannelVisibility) == MTAG_ALWAYS_ON ||
			( !GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagChannelVisibility) == MTAG_ON ) ||
			( GVAR(CMarkerTagNameVisibilityTemporaryOn) && GVAR(CMarkerTagChannelVisibility) == MTAG_OFF )
			 ) then
		{
			
			if (d_restr_enable_freeze) then {
				if (_mar select 12 == 1) then {
				_text = (GVAR(CMarkerChannelToChar) select MAR_CHAN(_mar)) + " " + _text;
				} else
				{
				_text = ((_mar select 11) select 0) + " " + _text;
				};
			} else {
				_text = (GVAR(CMarkerChannelToChar) select MAR_CHAN(_mar)) + " " + _text;
			};
		};		
	};
		
	if(!isNil {_text}) then {
		_m setMarkerTextLocal _text;
	};	
};

FUNC(CupdateAllMarkersVisibility) = 
{
	{
		private _y = _x;
		private _ids = _y getVariable ["ids", []];
		
		{
			private _mar = _y getVariable [str _x, []];
			
			if (count _mar > 0) then
			{
				[_mar, M_MARKER(_x, 0)] call FUNC(CapplyMarkerVisibility);
			};
			
		} forEach _ids;
	
	} forEach [GVAR(CSideMarkersLogic), GVAR(CCommandMarkersLogic), GVAR(CGroupMarkersLogic), 
			   GVAR(CGlobalMarkersLogic), GVAR(CVehicleMarkersLogic), GVAR(CDirectMarkersLogic)];	
};












// takes Marker id as the argument
FUNC(CDelLineMarker) =
{	
	params ["_id"];
	private _dat = [];
	
	{
		
		_dat = _x getVariable [str _id, []];
		
		if (count _dat > 0) then
		{
			for "_y" from 0 to ((count MAR_COORDS(_dat)) - 1) do
			{
				deleteMarkerLocal M_MARKER(_id, _y);
			};
			
			_x setVariable ["ids", (_x getVariable ["ids", []]) - [_id]];
			_x setVariable [str _id, []];
		};
	
	} forEach [GVAR(CSideMarkersLogic), GVAR(CCommandMarkersLogic), GVAR(CGroupMarkersLogic), 
			   GVAR(CGlobalMarkersLogic), GVAR(CVehicleMarkersLogic), GVAR(CDirectMarkersLogic)];
};









FUNC(CheckSidesClient) = {
	private _s1 = playerSide;
	private _s2 = MAR_CHANDATA(_this);
	private _cond = GVAR(can_see_marker);
	if( _cond == 2) then {
		if((time == 0) || {!d_restr_enable_freeze }) then {
			_cond = 1;
		};
	}; 

	if(_cond == 0) exitWith { _s1 == _s2 };
	if(_cond == 1) exitWith { [_s1, _s2] call BIS_fnc_areFriendly };
	true
};



FUNC(C_isMarkerVisibleToPlayer) = 
{
	MAR_CHAN(_this) == CHAN_GLOBAL   ||	
		(MAR_CHAN(_this) == CHAN_SIDE  &&  {call FUNC(CheckSidesClient)})   ||
		(MAR_CHAN(_this) == CHAN_COMMAND  &&  {call FUNC(CheckSidesClient)})   ||
		(MAR_CHAN(_this) == CHAN_GROUP  &&  {side (MAR_CHANDATA(_this)) == side group player})  ||
		(MAR_CHAN(_this) == CHAN_VEHICLE  &&  {MAR_CHANDATA(_this) == vehicle player})  ||
		(MAR_CHAN(_this) == CHAN_DIRECT  &&  {call FUNC(CheckSidesClient)});
};







FUNC(C_addMarkerToLogic) =
{
	params ["_mid","_dat","_logic"];
	
	_logic setVariable [str _mid, _dat];
	_logic setVariable ["ids", (_logic getVariable ["ids", []]) + [_mid]];	
};



// takes [marker, check if allowed/send storing request (true/false),
//   optional data for the check]
FUNC(CAddLineMarker) = 
{
	params ["_mark", "_check", "_spl"];
	private _marker_allowed = true;
	
	if (_check) then
	{
		_marker_allowed = [_mark, _spl] call FUNC(_CCheckIfMarkerAllowedReceive);
		
		if (_marker_allowed) then
		{
			[player, MAR_ID(_mark), MAR_UID(_mark)] remoteExec [QFUNC(SStorePlayerSeenMarker),2];
		};
	};
	
	
	if (!_marker_allowed) exitWith {};
	

	private _mid = MAR_ID(_mark);
	
	// delete previous marker with the same id if it happens somehow to be there
	_mid call FUNC(CDelLineMarker);
	
	
	if ( _mark call FUNC(C_isMarkerVisibleToPlayer) ) then
	{
		_crd = MAR_COORDS(_mark);
		_crdc = count _crd;
		
		private _col = MAR_COLOR(_mark);
		private _th = MAR_THICKNESS(_mark);
		

		createMarkerLocal [M_MARKER(_mid, 0), _crd select 0];		
		M_MARKER(_mid, 0) setMarkerShapeLocal "ICON";
		M_MARKER(_mid, 0) setMarkerTypeLocal MAR_TYPE(_mark);
		M_MARKER(_mid, 0) setMarkerColorLocal _col;
		
		[_mark, M_MARKER(_mid, 0)] call FUNC(CapplyMarkerVisibility);
		
	/*	if (_crdc > 1) then
		{
			M_MARKER(_mid, 0) setMarkerDirLocal (
				[_crd select 0, _crd select 1] call FUNC(dirTo));
		}
		else
		{*/
		M_MARKER(_mid, 0) setMarkerDirLocal 0;
		//};
		
		
		for "_x" from 1 to (_crdc - 1) do
		{
			createMarkerLocal [M_MARKER(_mid, _x), [
				(((_crd select (_x-1)) select 0) + ((_crd select _x) select 0)) / 2,
				(((_crd select (_x-1)) select 1) + ((_crd select _x) select 1)) / 2
				] ];
				
			M_MARKER(_mid, _x) setMarkerShapeLocal "RECTANGLE";
			M_MARKER(_mid, _x) setMarkerColorLocal _col;
			M_MARKER(_mid, _x) setMarkerBrushLocal "Solid";
			M_MARKER(_mid, _x) setMarkerSizeLocal [ _th,
				( [_crd select (_x - 1), _crd select _x] call FUNC(distance2D) )/2 ];
			M_MARKER(_mid, _x) setMarkerDirLocal (
				[_crd select (_x - 1), _crd select _x] call FUNC(dirTo));
		};
		
		
		
		if (MAR_CHAN(_mark) == CHAN_SIDE) then
		{
			[_mid, _mark, GVAR(CSideMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};

		if (MAR_CHAN(_mark) == CHAN_COMMAND) then
		{
			[_mid, _mark, GVAR(CCommandMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};
			
		if (MAR_CHAN(_mark) == CHAN_GROUP) then
		{
			[_mid, _mark, GVAR(CGroupMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};		
		
		if (MAR_CHAN(_mark) == CHAN_GLOBAL) then
		{
			[_mid, _mark, GVAR(CGlobalMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};
		
		if (MAR_CHAN(_mark) == CHAN_VEHICLE) then
		{
			[_mid, _mark, GVAR(CVehicleMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};

		if (MAR_CHAN(_mark) == CHAN_DIRECT) then
		{
			[_mid, _mark, GVAR(CDirectMarkersLogic)] call FUNC(C_addMarkerToLogic);
		};
		
		
		
		
		
		// check if there's same temporary marker
		
		{
			private _mar = _x select 0;
			private _same = true;
			
			
			private _i = 0;
			for "_i" from 2 to ((count _mark) - 1) do
			{
				if (!((_mark select _i) isEqualTo (_mar select _i))) then
				{
					_same = false;
				};
				
			};
								
			if (_same) exitWith
			{
				_forEachIndex call FUNC(CRemoveTemporaryMarker);
			};
		} forEach GVAR(CTempMarkers);
		
	};
	
	
	
	
	
};







FUNC(CRemoveTemporaryMarker) =
{
	params ["_idx"];
	private _mar = (GVAR(CTempMarkers) deleteAt _idx) select 0;
	private _mid = -_idx - 1;
	
	for "_y" from 0 to ((count MAR_COORDS(_mar)) - 1) do
	{
		deleteMarkerLocal M_MARKER(_mid, _y);
	};
};





// takes Marker array as the argument 
FUNC(CAddLineMarker_Temporary) = 
{
	private _mid = - (count GVAR(CTempMarkers)) - 1;
	GVAR(CTempMarkers) pushBack [_this, diag_tickTime];
	
	
	
	private _crd = MAR_COORDS(_this);
	private _crdc = count _crd;
	
	private _col = MAR_COLOR(_this);
	private _th = MAR_THICKNESS(_this);
	

	createMarkerLocal [M_MARKER(_mid, 0), _crd select 0];		
	M_MARKER(_mid, 0) setMarkerShapeLocal "ICON";
	M_MARKER(_mid, 0) setMarkerTypeLocal MAR_TYPE(_this);
	M_MARKER(_mid, 0) setMarkerColorLocal _col;
	
	[_this, M_MARKER(_mid, 0)] call FUNC(CapplyMarkerVisibility);
	
/*	if (_crdc > 1) then
	{
		M_MARKER(_mid, 0) setMarkerDirLocal (
			[_crd select 0, _crd select 1] call FUNC(dirTo));
	}
	else
	{*/
	M_MARKER(_mid, 0) setMarkerDirLocal 0;
	//};
	
	
	for "_x" from 1 to (_crdc - 1) do
	{
		createMarkerLocal [M_MARKER(_mid, _x), [
			(((_crd select (_x-1)) select 0) + ((_crd select _x) select 0)) / 2,
			(((_crd select (_x-1)) select 1) + ((_crd select _x) select 1)) / 2
			] ];
			
		M_MARKER(_mid, _x) setMarkerShapeLocal "RECTANGLE";
		M_MARKER(_mid, _x) setMarkerColorLocal _col;
		M_MARKER(_mid, _x) setMarkerBrushLocal "Solid";
		M_MARKER(_mid, _x) setMarkerSizeLocal [ _th,
			( [_crd select (_x - 1), _crd select _x] call FUNC(distance2D) )/2 ];
		M_MARKER(_mid, _x) setMarkerDirLocal (
			[_crd select (_x - 1), _crd select _x] call FUNC(dirTo));
	};


	

};




// remove temporary markers by timeout
[] spawn 
{
	while {true} do {

		private _i = 0;
		while {_i < count GVAR(CTempMarkers)} do
		{
			private _t = GVAR(CTempMarkers) select _i;
			if (count _t > 0 && {_t select 1 <
				diag_tickTime - TEMPORARY_MARKERS_TIMEOUT} ) then
			{
				_i call FUNC(CRemoveTemporaryMarker);
			}
			else
			{
				_i = _i + 1;
			};
		};
		sleep 1.21;
	};
};




// for JIP player
if (!isServer) then
{	
	[] spawn
	{
		waitUntil {!isNull player};
		[player] remoteExec [QFUNC(SRequestMarkersForPlayer),2];
	};
};






