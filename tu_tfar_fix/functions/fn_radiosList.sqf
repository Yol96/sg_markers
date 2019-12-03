/*
 	Name: TFAR_fnc_radiosList
 	
 	Author(s):
		NKey

 	Description:
		List of all the player's SW radios.
	
	Parameters:
		0: OBJECT: unit
 	
 	Returns:
		ARRAY - List of all the player's SW radios.
 	
 	Example:
		_radios = TFAR_currentUnit call TFAR_fnc_radiosList;
*/
private _fetchItems = {
    private _allItems = (assignedItems _this);
    _allItems append ((getItemCargo (uniformContainer _this)) select 0);
    _allItems append ((getItemCargo (vestContainer _this)) select 0);
    _allItems append ((getItemCargo (backpackContainer _this)) select 0);
    _allItems = _allItems arrayIntersect _allItems;//Remove duplicates

    private _result = [];
    {
        if (_x call TFAR_fnc_isRadio) then {
            _result pushBack _x;
        };
        true;
    } count _allItems;
    _result
};

if (!hasInterface || isNil "TFAR_currentUnit" || { _this != TFAR_currentUnit } ) then  
{	
	_this call _fetchItems
} else {
	if(isNil { tf_radiosList }) then {
		tf_radiosList = _this call _fetchItems;
	};
	tf_radiosList
};

