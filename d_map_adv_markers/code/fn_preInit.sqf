#include "main.hpp"
#include "..\main.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

GVAR(str_c_gr) = localize "str_channel_group";
GVAR(str_c_si) = localize "str_channel_side";
GVAR(str_c_gl) = localize "str_channel_global";
GVAR(str_c_ve) = localize "str_channel_vehicle";
GVAR(str_c_co) = localize "str_channel_command";
GVAR(str_c_di) = localize "str_channel_direct";

GVAR(str_localized_cur_channel) = GVAR(str_c_gl);

//Client settings
[QGVAR(CModKeyForLineMarkers), "LIST", localize "STR_Addons__d_map_adv_markers__uac_ModForLineMarkers", localize "STR_Addons__d_map_adv_markers__uac_section", [
	[4,5,6],
	["Shift","Ctrl","Alt"],
	1
], 2] call CBA_Settings_fnc_init;

[QGVAR(CActivateAlternativeTagVisibilityModeKey), "LIST", localize "STR_Addons__d_map_adv_markers__uac_ActivateAltTagVisKey", localize "STR_Addons__d_map_adv_markers__uac_section", [
	[DIK_LSHIFT, DIK_RSHIFT, DIK_LCONTROL, DIK_RCONTROL, DIK_LALT, DIK_RALT],
	["LShift","RShift","LCtrl","RCtrl","LAlt","RAlt"],
	0
], 2] call CBA_Settings_fnc_init;

{
	[_x select 0, "LIST", localize (_x select 1), localize "STR_Addons__d_map_adv_markers__uac_section", [
		[MTAG_ALWAYS_OFF, MTAG_OFF, MTAG_ON, MTAG_ALWAYS_ON],
		[
			localize "STR_Addons__d_map_adv_markers__opt_always_off",
			localize "STR_Addons__d_map_adv_markers__opt_off",
			localize "STR_Addons__d_map_adv_markers__opt_on",
			localize "STR_Addons__d_map_adv_markers__opt_always_on"
		], 
		_x select 2
	], 2] call CBA_Settings_fnc_init;
} forEach [
		[QGVAR(CMarkerTagNameVisibility), "STR_Addons__d_map_adv_markers__uac_MarkerTagNameVisibility", 3],
		[QGVAR(CMarkerTagChannelVisibility), "STR_Addons__d_map_adv_markers__uac_MarkerTagChannelVisibility", 3],
		[QGVAR(CMarkerTagDaytimeVisibility), "STR_Addons__d_map_adv_markers__uac_MarkerTagDaytimeVisibility", 1],
		[QGVAR(CLineMarkerTagNameVisibility), "STR_Addons__d_map_adv_markers__uac_LineMarkerTagNameVisibility", 1],
		[QGVAR(CLineMarkerTagChannelVisibility), "STR_Addons__d_map_adv_markers__uac_LineMarkerTagChannelVisibility", 0],
		[QGVAR(CLineMarkerTagDaytimeVisibility), "STR_Addons__d_map_adv_markers__uac_LineMarkerTagDaytimeVisibility", 1]
	];

//Server/mission setting
[QGVAR(restrictMarkers), "CHECKBOX", localize "STR_Addons__d_map_adv_markers__restriction", localize "STR_Addons__d_map_adv_markers__uac_section", true, true] call CBA_Settings_fnc_init;

[QGVAR(can_see_marker), "LIST", localize "STR_Addons__d_map_adv_markers__mod_setting_visibility_name", localize "STR_Addons__d_map_adv_markers__uac_section", [
	[0,1,2],
	[
		localize "STR_Addons__d_map_adv_markers__mod_setting_visibility_value_side",
		localize "STR_Addons__d_map_adv_markers__mod_setting_visibility_value_friendly",
		localize "STR_Addons__d_map_adv_markers__mod_setting_visibility_value_all"
	],
	0
], true] call CBA_Settings_fnc_init;

[QGVAR(can_send_marker), "LIST", localize "STR_Addons__d_map_adv_markers__mod_setting_ability_name", localize "STR_Addons__d_map_adv_markers__uac_section", [
	[0,1,2],
	[
		localize "STR_Addons__d_map_adv_markers__mod_setting_ability_value_all",
		localize "STR_Addons__d_map_adv_markers__mod_setting_ability_value_lr",
		localize "STR_Addons__d_map_adv_markers__mod_setting_ability_value_none"
	],
	0
], true] call CBA_Settings_fnc_init;

