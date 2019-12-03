#ifndef __ADDON_HPP_
#define __ADDON_HPP_


#define __ADDON_NAME__ d_map_adv_markers
#define BASENAME amm
#define __BASENAME__ Addons__##__ADDON_NAME__
#define __PREFIX__ "\xx\addons\d_map_adv_markers"
#define __PREFIXC__ "\xx\addons\d_map_adv_markers\code\"

#define FUNC(x) BASENAME##_fnc_##x
#define GVAR(x) BASENAME##_##x
#define Q(x) #x
#define QGVAR(x) Q(GVAR(x))
#define QFUNC(x) Q(FUNC(x))


#define LOCALIZE_PREFIX "STR_Addons__d_map_adv_markers__"
#define LOCALIZE(x) (localize (LOCALIZE_PREFIX + (x)))





#endif
