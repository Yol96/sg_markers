if (isNil "tf_radio_channel_name") then {
	tf_radio_channel_name = "TaskForceRadio";
};
if (isNil "tf_radio_channel_password") then {
	tf_radio_channel_password = "123";
};
if (isNil "tf_west_radio_code") then {
	tf_west_radio_code = "_bluefor";
};
if (isNil "tf_east_radio_code") then {
	tf_east_radio_code = "_opfor";
};
if (isNil "tf_guer_radio_code") then {
	tf_guer_radio_code = "_independent";

	// if (([west, resistance] call BIS_fnc_areFriendly) and {!([east, resistance] call BIS_fnc_areFriendly)}) then {
	// 	tf_guer_radio_code = "_bluefor";
	// };

	// if (([east, resistance] call BIS_fnc_areFriendly) and {!([west, resistance] call BIS_fnc_areFriendly)}) then {
	// 	tf_guer_radio_code = "_opfor";
	// };
};
if (isNil "TF_defaultWestBackpack") then {
	TF_defaultWestBackpack = "tf_rt1523g";
};
if (isNil "TF_defaultEastBackpack") then {
	TF_defaultEastBackpack = "tf_mr3000";
};
if (isNil "TF_defaultGuerBackpack") then {
	TF_defaultGuerBackpack = "tf_anprc155";
};

if (isNil "TF_defaultWestPersonalRadio") then {
	TF_defaultWestPersonalRadio = "tf_anprc152";
};
if (isNil "TF_defaultEastPersonalRadio") then {
	TF_defaultEastPersonalRadio = "tf_fadak";
};
if (isNil "TF_defaultGuerPersonalRadio") then {
	TF_defaultGuerPersonalRadio = "tf_anprc148jem";
};

if (isNil "TF_defaultWestRiflemanRadio") then {
	TF_defaultWestRiflemanRadio = "tf_rf7800str";
};
if (isNil "TF_defaultEastRiflemanRadio") then {
	TF_defaultEastRiflemanRadio = "tf_pnr1000a";
};
if (isNil "TF_defaultGuerRiflemanRadio") then {
	TF_defaultGuerRiflemanRadio = "tf_anprc154";
};

if (isNil "TF_defaultWestAirborneRadio") then {
	TF_defaultWestAirborneRadio = "tf_anarc210";
};
if (isNil "TF_defaultEastAirborneRadio") then {
	TF_defaultEastAirborneRadio = "tf_mr6000l";
};
if (isNil "TF_defaultGuerAirborneRadio") then {
	TF_defaultGuerAirborneRadio = "tf_anarc164";
};

if (isServer) then {
	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "tf_no_auto_long_range_radio")) then {
		tf_no_auto_long_range_radio_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "tf_no_auto_long_range_radio") == 1;
	} else {
		tf_no_auto_long_range_radio_server = true;
	};
	publicVariable "tf_no_auto_long_range_radio_server";
	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "TF_give_personal_radio_to_regular_soldier")) then {
		TF_give_personal_radio_to_regular_soldier_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "TF_give_personal_radio_to_regular_soldier") == 1;
	} else {
		TF_give_personal_radio_to_regular_soldier_server = false;
	};
	publicVariable "TF_give_personal_radio_to_regular_soldier_server";
	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_sw_frequencies_for_side")) then {
		tf_same_sw_frequencies_for_side_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_sw_frequencies_for_side") == 1;
	} else {
		tf_same_sw_frequencies_for_side_server = false;
	};
	publicVariable "tf_same_sw_frequencies_for_side_server";
	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_lr_frequencies_for_side")) then {
		tf_same_lr_frequencies_for_side_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_lr_frequencies_for_side") == 1;
	} else {
		tf_same_lr_frequencies_for_side_server = false;
	};
	publicVariable "tf_same_lr_frequencies_for_side_server";
	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_dd_frequencies_for_side")) then {
		tf_same_dd_frequencies_for_side_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "tf_same_dd_frequencies_for_side") == 1;
	} else {
		tf_same_dd_frequencies_for_side_server = false;
	};
	publicVariable "tf_same_dd_frequencies_for_side_server";


	if (isNumber (ConfigFile >> "task_force_radio_settings" >> "TF_give_microdagr_to_soldier")) then {
		TF_give_microdagr_to_soldier_server = getNumber (ConfigFile >> "task_force_radio_settings" >> "TF_give_microdagr_to_soldier") == 1;
	} else {
		TF_give_microdagr_to_soldier_server = true;
	};
	publicVariable "TF_give_microdagr_to_soldier_server";
};

if (isNil "tf_no_auto_long_range_radio") then {
	if (!isNil "tf_no_auto_long_range_radio_server") then {
		tf_no_auto_long_range_radio = tf_no_auto_long_range_radio_server;
	}else{
		tf_no_auto_long_range_radio = true;
	};
};
if (isNil "TF_give_personal_radio_to_regular_soldier") then {
	if (!isNil "TF_give_personal_radio_to_regular_soldier_server") then {
		TF_give_personal_radio_to_regular_soldier = TF_give_personal_radio_to_regular_soldier_server;
	}else{
		TF_give_personal_radio_to_regular_soldier = false;
	};
};
if (isNil "TF_give_microdagr_to_soldier") then {
	if (!isNil "TF_give_microdagr_to_soldier_server") then {
		TF_give_microdagr_to_soldier = TF_give_microdagr_to_soldier_server;
	}else{
		TF_give_microdagr_to_soldier = true;
	};
};
if (isNil "tf_same_sw_frequencies_for_side") then {
	if (!isNil "tf_same_sw_frequencies_for_side_server") then {
		tf_same_sw_frequencies_for_side = tf_same_sw_frequencies_for_side_server;
	}else{
		tf_same_sw_frequencies_for_side = false;
	};
};
if (isNil "tf_same_lr_frequencies_for_side") then {
	if (!isNil "tf_same_lr_frequencies_for_side_server") then {
		tf_same_lr_frequencies_for_side = tf_same_lr_frequencies_for_side_server;
	}else{
		tf_same_lr_frequencies_for_side = true;
	};
};
if (isNil "tf_same_dd_frequencies_for_side") then {
	if (!isNil "tf_same_dd_frequencies_for_side_server") then {
		tf_same_dd_frequencies_for_side = tf_same_dd_frequencies_for_side_server;
	}else{
		tf_same_dd_frequencies_for_side = true;
	};
};