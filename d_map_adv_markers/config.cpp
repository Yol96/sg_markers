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

