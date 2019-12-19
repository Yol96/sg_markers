#include "config_macros.hpp"
#include "main.hpp"

#define RECOMPILE 0

class CfgPatches {

	class d_map_adv_markers {
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"A3_UI_F", "tu_tfar_fix"};
		author= "Drill";
		addon_version = 11;
	};
};

class CfgMarkers {
	class swt_sw {
		color[] = {0.9,0,0,1};
		scope = 2;
		swt_show = 1;
		name = $STR_SG_M_SW;
		icon = "\xx\addons\d_map_adv_markers\data\marker_sw_ca.paa";
		markerClass = "draw";
		size = 29;
		shadow = 1;
	};
	
	class swt_lr : swt_sw {
		color[] = {0.9,0,0,1};
		scope = 1;
		name = $STR_SG_M_LR;
		icon = "\xx\addons\d_map_adv_markers\data\marker_lr_ca.paa";
		markerClass = "draw";
	};
	class Flag;
	class o_unknown: Flag {color[] = {0.9,0,0,1}; name = $STR_SG_M_GR; scope = 2; shadow = 1;};
	class o_inf: o_unknown {color[] = {0.9,0,0,1}; scope = 2; shadow = 1;};
	class o_armor: o_unknown {color[] = {0.9,0,0,1}; scope = 2; shadow = 1;};
	
	class o_motor_inf: o_unknown {scope = 1; shadow = 1;};
	class o_mech_inf: o_unknown {scope = 1; shadow = 1;};
	class o_recon: o_unknown {scope = 1; shadow = 1;};
	class o_air: o_unknown {scope = 1; shadow = 1;};
	class o_plane: o_unknown {scope = 1; shadow = 1;};
	class o_uav: o_unknown {scope = 1; shadow = 1;};
	class o_naval: o_unknown {scope = 1; shadow = 1;};
	class o_med: o_unknown {scope = 1; shadow = 1;};
	class o_art: o_unknown {scope = 1; shadow = 1;};
	class o_mortar: o_unknown {scope = 1; shadow = 1;};
	class o_hq: o_unknown {scope = 1; shadow = 1;};
	class o_support: o_unknown {scope = 1; shadow = 1;};
	class o_maint: o_unknown {scope = 1; shadow = 1;};
	class o_service: o_unknown {scope = 1; shadow = 1;};
	class o_installation: o_unknown {scope = 1; shadow = 1;};
	class o_antiair: o_unknown {scope = 1; shadow = 1;};
	class o_Ordnance: o_unknown {scope = 1; shadow = 1;};
	
	class flag_NATO: Flag {scope = 1; shadow = 1;};
	class RedCrystal: Flag {scope = 1; shadow = 1;};
	class White: Flag {scope = 1; shadow = 1;};
	class hd_dot: Flag
	{
		name = "$STR_CFG_MARKERS_DOT";
		icon = "\A3\ui_f\data\map\markers\military\dot_CA.paa";
		color[] = {0,0,0,1};
		size = 32;
		shadow = 2;
		scope = 2;
		markerClass = "draw";
	};
	class sg_complete: hd_dot
	{
		name = "$STR_sg_complete";
		icon = "\A3\ui_f\data\Map\Diary\Icons\taskSucceeded_ca.paa";
	};
	class hd_objective: hd_dot
	{
		name = "$STR_sg_arta";
		icon = "\A3\ui_f\data\Map\GroupIcons\selector_selectedMission_ca.paa";
	};
};
class CfgMarkerColors
{
	class Default
	{
		name = "$STR_CFG_MARKERCOL_DEFAULT";
		color[] = {0,0,0,1};
		scope = 1;
	};
	class ColorBlack: Default
	{
		name = "$STR_CFG_MARKERCOL_BLACK";
		color[] = {0,0,0,1};
		scope = 2;
	};
	class ColorGrey: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorGrey_0";
		color[] = {0.5,0.5,0.5,1};
		scope = 2;
	};
	class ColorRed: Default
	{
		name = "$STR_CFG_MARKERCOL_RED";
		color[] = {0.9,0,0,1};
		scope = 2;
	};
	class ColorBrown: Default
	{
		scope = 0;
		name = "$STR_A3_CfgMarkerColors_ColorBrown_0";
		color[] = {0.5,0.25,0,1};
	};
	class ColorOrange: Default
	{
		scope = 0;
		name = "$STR_CFG_MARKERCOL_ORANGE";
		color[] = {0.85,0.4,0,1};
	};
	class ColorYellow: Default
	{
		name = "$STR_CFG_MARKERCOL_YELLOW";
		color[] = {0.85,0.85,0,1};
		scope = 2;
	};
	class ColorKhaki: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorKhaki_0";
		color[] = {0.5,0.6,0.4,1};
		scope = 0;
	};
	class ColorGreen: Default
	{
		name = "$STR_CFG_MARKERCOL_GREEN";
		color[] = {0,0.8,0,1};
		scope = 2;
	};
	class ColorBlue: Default
	{
		name = "$STR_CFG_MARKERCOL_BLUE";
		color[] = {0,0,1,1};
		scope = 2;
	};
	class ColorPink: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorPink_0";
		color[] = {1,0.3,0.4,1};
		scope = 0;
	};
	class ColorWhite: Default
	{
		name = "$STR_CFG_MARKERCOL_WHITE";
		color[] = {1,1,1,1};
		scope = 2;
	};
	class ColorWEST: Default
	{
		name = "$STR_WEST";
		color[] = {"(profilenamespace getvariable ['Map_BLUFOR_R',0])","(profilenamespace getvariable ['Map_BLUFOR_G',1])","(profilenamespace getvariable ['Map_BLUFOR_B',1])","(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"};
		scope = 0;
	};
	class ColorEAST: Default
	{
		name = "$STR_EAST";
		color[] = {"(profilenamespace getvariable ['Map_OPFOR_R',0])","(profilenamespace getvariable ['Map_OPFOR_G',1])","(profilenamespace getvariable ['Map_OPFOR_B',1])","(profilenamespace getvariable ['Map_OPFOR_A',0.8])"};
		scope = 0;
	};
	class ColorGUER: Default
	{
		name = "$STR_GUERRILA";
		color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};
		scope = 0;
	};
	class ColorCIV: Default
	{
		name = "$STR_CIVILIAN";
		color[] = {"(profilenamespace getvariable ['Map_Civilian_R',0])","(profilenamespace getvariable ['Map_Civilian_G',1])","(profilenamespace getvariable ['Map_Civilian_B',1])","(profilenamespace getvariable ['Map_Civilian_A',0.8])"};
		scope = 0;
	};
	class ColorUNKNOWN: Default
	{
		name = "$STR_SIDE_UNKNOWN";
		color[] = {"(profilenamespace getvariable ['Map_Unknown_R',0])","(profilenamespace getvariable ['Map_Unknown_G',1])","(profilenamespace getvariable ['Map_Unknown_B',1])","(profilenamespace getvariable ['Map_Unknown_A',0.8])"};
		scope = 0;
	};
};

class CfgFunctions
{
	class amm //Сокрашение для advenced map markers
	{
		class Init
		{
			file = "\xx\addons\d_map_adv_markers\code";
			class _init {
				preInit = 0;
				postInit = 1;
				recompile = RECOMPILE;
			};
			class preInit {
				//preInit = 1;
				postInit = 0;
				recompile = RECOMPILE;
			};

			class getRadioData {recompile = RECOMPILE;};
			
			class _onIMDLoad {recompile = RECOMPILE;};
			
			class _UIIM_initDialog {recompile = RECOMPILE;};
			
			
			class _CCheckIfMarkerAllowedSend {recompile = 1;};
			class _CCheckIfMarkerAllowedReceive {recompile = 1;};
			
			class _CGetIMDChannel {recompile = RECOMPILE;};
			class determine_current_channel {recompile = RECOMPILE;};
			class saveMarkers {recompile = RECOMPILE;};
			class loadMarkers {recompile = RECOMPILE;};
			class deleteSavedMarkers {recompile = RECOMPILE;};
			class copyMarkersToClipboard {recompile = RECOMPILE;};
			class insertMarkersFromClipboard {recompile = RECOMPILE;};
			class addSavedMarkersToDiary {recompile = RECOMPILE;};	
			class frequencyMarkers { postInit=1;};			
		};
	};
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = Q(call FUNC(preInit));
    };
};
class RscPicture;
class RscText;
class RscStructuredText;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscButtonMenu;
class RscEdit;
class RscCombo;
class RscSlider;

class RscDisplayChannel
{
	onLoad = "call amm_fnc_determine_current_channel";
};


#include "config_ui.hpp"

