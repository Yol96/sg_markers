class CfgPatches
{
	class tu_tfar_fix
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"task_force_radio", "task_force_radio_items"};
		author = "[GG]hitman";
		mail = "";
	};
};

class CfgFunctions
{
	class TFAR
	{
		class Radio
		{
			class TaskForceArrowheadRadioInit {
				file = "tu_tfar_fix\functions\fn_TaskForceArrowheadRadioInit.sqf";
				postInit = 1;				
			};
			class setSwSettings {
				file = "tu_tfar_fix\functions\fn_setSwSettings.sqf";
			};
			class setRadioOwner {
				file = "tu_tfar_fix\functions\fn_setRadioOwner.sqf";
			};
			class replaceRadios {
				file = "tu_tfar_fix\functions\fn_replaceRadios.sqf";
			};
			class replaceRadiosIntl {
				file = "tu_tfar_fix\functions\fn_replaceRadiosIntl.sqf";
			};
			class radioReplaceProcess {
				file = "tu_tfar_fix\functions\fn_radioReplaceProcess.sqf";
			};
			class processRespawn {
				file = "tu_tfar_fix\functions\fn_processRespawn.sqf";
			};
			class isPrototypeRadio {
				file = "tu_tfar_fix\functions\fn_isPrototypeRadio.sqf";
			};
			class getSwSettings {
				file = "tu_tfar_fix\functions\fn_getSwSettings.sqf";
			};
			class getLrSettings {
				file = "tu_tfar_fix\functions\fn_getLrSettings.sqf";
			};
			class getDefaultRadioClasses {
				file = "tu_tfar_fix\functions\fn_getDefaultRadioClasses.sqf";
			};
			class ClientInit {
				file = "tu_tfar_fix\functions\fn_ClientInit.sqf";
			};
			class initialiseEnforceUsageModule {
				file = "tu_tfar_fix\functions\fn_initialiseEnforceUsageModule.sqf";
			};
			class TaskForceArrowheadRadioInitParams {
				file = "tu_tfar_fix\functions\fn_parameters.sqf";
				preInit = 1;
			};

			class canUseRadio {
				file = "tu_tfar_fix\functions\fn_canUseRadio.sqf";
			};

			class isRadio {
				file = "tu_tfar_fix\functions\fn_isRadio.sqf";
			};

			class hasPrototypeRadio {
				file = "tu_tfar_fix\functions\fn_hasPrototypeRadio.sqf";
			};

			class getConfigProperty {
				file = "tu_tfar_fix\functions\fn_getConfigProperty.sqf";
			};

			class radiosList {
				file = "tu_tfar_fix\functions\fn_radiosList.sqf";
			};

		};
	};
};

class CfgVehicles
{
	class Module_F;
	class tfar_ModuleTaskForceRadioEnforceUsage: Module_F
	{
		class Arguments {
			class TeamLeaderRadio
			{
				displayName = "$STR_TFAR_Mod_GiveTLradio";
				description = "$STR_TFAR_Mod_GiveTLradioTT";
				typeName = "BOOL";
				defaultValue = 0;
			};			
			class RiflemanRadio
			{
				displayName = "$STR_TFAR_Mod_GiveRiflemanRadio";
				description = "$STR_TFAR_Mod_GiveRiflemanRadioTT";
				typeName = "BOOL";
				defaultValue = 0;
			};			
			class GiveMicroDAGR
			{
				displayName = "Выдавать MicroDAGR";
				description = "Выдавать программатор рации";
				typeName = "BOOL";
				defaultValue = 1;
			};
		};
	};
	class TFAR_Bag_Base;
	class tf_bussole: TFAR_Bag_Base
    {
    model = "\tu_tfar_fix\models\tf_bussole.p3d";
	// hiddenSelectionsTextures[] = {"\task_force_radio_items\models\data\clf_nicecomm2_rhs_digital_co.paa"};
	};
};
