params ["_unit"];
private _hasPrototype = false;
private _allItems = (assignedItems _unit);
_allItems append ((getItemCargo (uniformContainer _unit)) select 0);
_allItems append ((getItemCargo (vestContainer _unit)) select 0);
_allItems append ((getItemCargo (backpackContainer _unit)) select 0);
_allItems = _allItems arrayIntersect _allItems;//Remove duplicates

for "_i" from 0 to (count _allItems - 1) do {
	if((_allItems select _i) call TFAR_fnc_isPrototypeRadio) exitWith { _hasPrototype = true; true };
};
_hasPrototype