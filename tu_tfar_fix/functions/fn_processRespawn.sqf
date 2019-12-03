/*
 	Name: TFAR_fnc_processRespawn
 	
 	Author(s):
		NKey
		L-H

 	Description:
		Handles getting switching radios, handles whether a manpack must be added to the player or not.
	
	Parameters:
		BOOLEAN force replace all presonal radios, default - true
 	
 	Returns:
		Nothing
 	
 	Example:
		call TFAR_fnc_processRespawn;
*/
[] spawn {	
	waitUntil {!(isNull player)};	
	TFAR_currentUnit = call TFAR_fnc_currentUnit;
	TF_respawnedAt = time;
	if (alive TFAR_currentUnit) then {
		[TFAR_currentUnit] remoteExec ["TFAR_fnc_replaceRadios",2];
	}
};