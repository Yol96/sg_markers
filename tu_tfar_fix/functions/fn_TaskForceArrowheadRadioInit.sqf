/*
 	Name: TFAR_fnc_TaskForceArrowheadRadioInit

 	Author(s):
		NKey
		L-H

 	Description:
		Initialises TFAR, server and client.

 	Parameters:
		Nothing

 	Returns:
		Nothing

 	Example:
		Called by ArmA via functions library.
*/
TF_ADDON_VERSION = "0.9.12";

#include "common.sqf"
// cba settings
#include "cba_settings.sqf"

if (isServer) then {
	TF_Radio_Count = [];
	TF_radio_request_mutex = false;
	call TFAR_fnc_processGroupFrequencySettings;

	{ _x call TFAR_fnc_replaceRadios; } forEach playableUnits;


	[] spawn {
		sleep 5;
		while {true} do {		
			call TFAR_fnc_processGroupFrequencySettings;
			sleep 10;
		};
	};
};

if (hasInterface) then {
	[] spawn TFAR_fnc_ClientInit;
};
