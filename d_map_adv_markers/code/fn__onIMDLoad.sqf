#include "addon.hpp"
#include "main.hpp"
params ["_ctrl"];

disableSerialization;

[FUNC(_UIIM_initDialog), [_ctrl]] call CBA_fnc_execNextFrame;
	
	
//////////////////////////////
// For tu_markers support
//////////////////////////////

if (//isClass (configFile >> "CfgPatches" >> "tu_markers") &&
	!isNil "c_persistent_markers_markerHandle") then
{

	_ctrl displayAddEventHandler ["KeyDown", {
		if (d_restr_enable_freeze) then
		{
			false;
		}
		else
		{
			if(_this select 1 == 28 && _this select 3) then
			{
				[_this select 0] call c_persistent_markers_markerHandle;
				
				(findDisplay 54) closeDisplay 0;
				
				true;
			}
			else
			{
				false;
			};
		};
	
	}];
	
};

//////////////////////////////
//
//////////////////////////////
