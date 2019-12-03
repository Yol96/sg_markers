// Made by Drill

#include "main.hpp"
#include "settings.hpp"

GVAR(SMarkersCount) = 0;
GVAR(SMarkerNextUID) = 1;

#define MIN_PENDING_FREE_IDS 2000

GVAR(ServerFreeMarkersPending) = [];
GVAR(ServerFreeMarkersCurrent) = [];
GVAR(ServerFreeMarkersCurrentIndex) = 0;

#define ALLMARKERS_ARRAY_RESIZE_STEP 2000
GVAR(SAllMarkers) = [];

GVAR(SAllMarkers) resize ALLMARKERS_ARRAY_RESIZE_STEP;



//#define REM_PL_CHK(x)  ( isPlayer x || {time <= 0 && (owner x) > 2} )

// for radio-mod
// #define REM_PL_CHK(x)  ( isPlayer x || {time <= 0} )



#define REM_PL_CHK(x)  ( isPlayer x || {time <= 0 && (owner x) > 2} )


// channel-specific conditions
FUNC(CheckSides) = {
	private _s1 = side (group _this);
	private _s2 = MAR_CHANDATA(_mark);
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

// conditions for SAddLineMarker
GVAR(SALMChanConds) = [
	{true}, // global
	{ _this call FUNC(CheckSides) }, // side
	{ _this call FUNC(CheckSides) }, // command
	{ group _this == MAR_CHANDATA(_mark) }, // group
	{ vehicle _this == MAR_CHANDATA(_mark) }, // vehicle
	{ time > 0 && (_this call FUNC(CheckSides)) && {(eyePos _this) vectorDistance (eyePos _spl)  < 60} }  // direct
];

// conditions for SDelLineMarker
GVAR(SDLMChanConds) = [
	{true}, // global
	{ side (group _this) == _chandata }, // side
	{ side (group _this) == _chandata }, // command
	{group _this == _chandata }, // group
	{ vehicle _this == _chandata }, // vehicle
	{ false }  // direct
];



// takes [marker, source player]
FUNC(SAddLineMarker) =
{
	params ["_mark", "_spl"];		
	private _i = 0;	
	
	if (count GVAR(ServerFreeMarkersCurrent) > 0) then
	{
		_i = GVAR(ServerFreeMarkersCurrent) select GVAR(ServerFreeMarkersCurrentIndex);
		
		GVAR(ServerFreeMarkersCurrentIndex) = GVAR(ServerFreeMarkersCurrentIndex) + 1;
		
		if (GVAR(ServerFreeMarkersCurrentIndex) >= count GVAR(ServerFreeMarkersCurrent)) then
		{
			GVAR(ServerFreeMarkersCurrent) = [];
		};
	}
	else
	{
		_i = GVAR(SMarkersCount);
		GVAR(SMarkersCount) = GVAR(SMarkersCount) + 1;
		
		if ((count GVAR(SAllMarkers)) <= GVAR(SMarkersCount)) then
		{
			GVAR(SAllMarkers) resize (
				(count GVAR(SAllMarkers)) + ALLMARKERS_ARRAY_RESIZE_STEP
			);
		};
	};
	

	
	
	// warning - have to set marker id just in _mark for performance. Don't know if
	// there's any problems with it
	_mark set [0, _i];
	
	
	// setting UID
	_mark set [1, GVAR(SMarkerNextUID)];
	GVAR(SMarkerNextUID) = GVAR(SMarkerNextUID) + 1;
	
	
	
	
	// storing marker info to the array
	GVAR(SAllMarkers) set [_i, _mark];

	

	// setting up conditions 
	private _chan_cond = { false };

	if ( MAR_CHAN(_mark) in [0, 1, 2, 3, 4, 5] ) then
	{
		_chan_cond = GVAR(SALMChanConds) select MAR_CHAN(_mark);
	};


	private _players = playableUnits;
	_players = _players select { _x == _spl || _x call _chan_cond };

	if ((time == 0) || {!d_restr_enable_freeze}) then
	{
		[_mark, false, _spl] remoteExec [QFUNC(CAddLineMarker), _players select {isPlayer _x }];
		_players apply { [_x, MAR_ID(_mark), MAR_UID(_mark)] call FUNC(SStorePlayerSeenMarker); };
	}
	else
	{
		[_mark, true, _spl] remoteExec [QFUNC(CAddLineMarker), _players select {isPlayer _x }];
	}
	

	// add log entry about adding the marker
	// diag_log text format ["Line-marker %1 added at moment %2 by %3", _i, 
	//	diag_tickTime, _mark select 3];

};


FUNC(SUpdateMarker) = {
	params ["_mark", "_spl"];
	
	GVAR(SAllMarkers) set [_mark select 0, _mark];

	private _chan_cond = { false };

	if ( MAR_CHAN(_mark) in [0, 1, 2, 3, 4, 5] ) then
	{
		_chan_cond = GVAR(SALMChanConds) select MAR_CHAN(_mark);
	};
	
	private _players = playableUnits;
	_players = _players select { _x == _spl || _x call _chan_cond };

	if ((time == 0) || {!d_restr_enable_freeze}) then
	{
		[_mark, false, _spl] remoteExec [QFUNC(CAddLineMarker), _players select {isPlayer _x }];
	}
	else
	{
		[_mark, true, _spl] remoteExec [QFUNC(CAddLineMarker), _players select {isPlayer _x }];
	}
};
	






// takes [marker, channel, channel data] as argument
FUNC(SDelLineMarker) =
{
	params ["_id", "_chan", "_chandata"];		
	if (!isNil {GVAR(SAllMarkers) select _id}) then
	{
		
		GVAR(SAllMarkers) set [_this select 0, nil];
	
		
		
		
		GVAR(ServerFreeMarkersPending) set [count GVAR(ServerFreeMarkersPending), _this select 0];
		if (count GVAR(ServerFreeMarkersPending) > MIN_PENDING_FREE_IDS && 
			count GVAR(ServerFreeMarkersCurrent) == 0) then
		{
			GVAR(ServerFreeMarkersCurrent) = GVAR(ServerFreeMarkersPending);
			GVAR(ServerFreeMarkersCurrentIndex) = 0;
			GVAR(ServerFreeMarkersPending) = [];
		};
		


		// setting up conditions 
		private _chan_cond = {false};

		if ( _chan in [0, 1, 2, 3, 4, 5] ) then
		{
			_chan_cond = GVAR(SDLMChanConds) select _chan;
		};
		
		
		
		// send delete request to players according to _chan_cond
		private _players = playableUnits ;
		_players = _players select {_x call _chan_cond };
		[_id] remoteExec [QFUNC(CDelLineMarker),  _players select {isPlayer _x }];

		// add log entry about deleting the marker
		// diag_log text format ["Line-marker %1 deleted at moment %2 by %3", _this select 0,
		//	diag_tickTime, _this select 1];
	};

};





// [player, marker id, marker uid]
FUNC(SStorePlayerSeenMarker) =
{
	private _pl = _this select 0;
	
	if (isNil {_pl getVariable MARKERS_VAR_IN_PLAYER}) then
	{
		_pl setVariable [MARKERS_VAR_IN_PLAYER, []];
	};
	
	(_pl getVariable MARKERS_VAR_IN_PLAYER) 
		pushBack [_this select 1, _this select 2];
};




// takes the calling player's object as the argument
FUNC(SRequestMarkersForPlayer) =
{
	params ["_p"];
	if (!isNull _p) then
	{
		private _allpm = _p getVariable [MARKERS_VAR_IN_PLAYER, []];
		private _i = 0;
		private _nn = count _allpm;
		
		while {_i < _nn} do
		{
			private _xx = _allpm select _i;
			private _id = _xx select 0;
			private _uid = _xx select 1;
			private _el = GVAR(SAllMarkers) select _id;
			
			if (!isNil {_el}) then
			{
				if (MAR_UID(_el) == _uid) then
				{
					[_el, false] remoteExec [QFUNC(CAddLineMarker), _p];
				}
				else
				{
					_allpm deleteAt _i;
					_i = _i - 1;
					_nn = _nn - 1;
				};
			}
			else
			{
				_allpm deleteAt _i;
				_i = _i - 1;
				_nn = _nn - 1;
			};
			
			_i = _i + 1;
		};
		
	};
};




V_SERVER_READY = true;
publicVariable 'V_SERVER_READY';



