#include "main.hpp"

[_this select 0] spawn {
	// chat channel determination
	private _text = ctrlText ((_this select 0) displayCtrl 101);
	
	if (_text == GVAR(str_c_gr)) then { GVAR(UICurrentChannel) = CHAN_GROUP; };
	if (_text == GVAR(str_c_si)) then { GVAR(UICurrentChannel) = CHAN_SIDE; };
	if (_text == GVAR(str_c_gl)) then { GVAR(UICurrentChannel) = CHAN_GLOBAL; };
	if (_text == GVAR(str_c_ve)) then { GVAR(UICurrentChannel) = CHAN_VEHICLE; };
	if (_text == GVAR(str_c_co)) then { GVAR(UICurrentChannel) = CHAN_COMMAND; };
	if (_text == GVAR(str_c_di)) then { GVAR(UICurrentChannel) = CHAN_DIRECT; };

	GVAR(str_localized_cur_channel) = _text;
};