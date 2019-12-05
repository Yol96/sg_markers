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
		scope = 1;
		swt_show = 1;
		name = $STR_SG_M_SW;
		icon = "\xx\addons\d_map_adv_markers\data\marker_sw_ca.paa";
		markerClass = "draw";
		color[] = {1, 0, 0, 1};
		size = 29;
		shadow = 1;
	};
	
	class swt_lr : swt_sw {
		name = $STR_SG_M_LR;
		icon = "\xx\addons\d_map_adv_markers\data\marker_lr_ca.paa";
		markerClass = "draw";
	};
	class Flag;
	class o_unknown: Flag {scope = 2; shadow = 1;};
	class o_inf: o_unknown {scope = 2; shadow = 1;};
	class o_armor: o_unknown {scope = 2; shadow = 1;};
	
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

