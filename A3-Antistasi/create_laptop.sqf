if(!(isNil {laptop_order})) then {
		if(alive laptop_order) then {
			deleteVehicle laptop_order;
		};
	};
	if(!(isNil {laptop_table})) then {
		if(alive laptop_table) then {
			deleteVehicle laptop_table;
		};
	};
	laptop_table = "Land_CampingTable_small_F" createVehicle (getPos mapa); 
	laptop_order = "Land_Laptop_unfolded_F" createVehicle position laptop_table; 
	laptop_table allowDamage false;
	laptop_order allowDamage false;
	laptop_order attachTo [laptop_table, [0,0,0.55]];
	
	[laptop_table, ["Remove table", {deleteVehicle laptop_order; deleteVehicle laptop_table;
	},nil,0,false,true,"","(_this == theBoss) and (petros == leader group petros)"]] remoteExec ["addAction", 0, true];
	
	[laptop_order, ["<t color='#55ccff'>Email Extreme Sports Tours</t>", { enable_halo = _this select 2;
	[[laptop_order,1500,90] ,"MGI_HALO.sqf"] remoteExec ["execVM", 0, true];
	},nil,0,false,true,"","(_this == theBoss) and (petros == leader group petros)"]] remoteExec ["addAction", 0, true];
	
	[laptop_order,["<t color='#B9E1F8'>Open</t><t color='#0068AC'>University</t>: Study Medicine <t color='#ffc400'>150€</t>", {
		if((player getVariable "dinero") >= 150) then {
			player setUnitTrait ["medic",true]; 
			player setVariable ["dinero",(player getVariable "dinero")-150,true];
			hint "Paid 150 €. You are now a Medic. That was quick.";
		} else {
			hint "Not enough €";
		}
	},nil,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos) and !(player getUnitTrait ""engineer"") and !(player getUnitTrait ""medic"")"]] remoteExec ["addAction", 0, true];

	[laptop_order,["<t color='#B9E1F8'>Open</t><t color='#0068AC'>University</t>: Study Engineering <t color='#ffc400'>150€</t>", {
		if((player getVariable "dinero") >= 150) then {
			player setUnitTrait ["engineer",true]; 
			player setVariable ["dinero",(player getVariable "dinero")-150,true];
			hint "Paid 150 €. You are now an Engineer. That was quick.";
		} else {
			hint "Not enough €";
		}
	},nil,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos) and !(player getUnitTrait ""engineer"") and !(player getUnitTrait ""medic"")"]] remoteExec ["addAction", 0, true];
	
	[laptop_order,["<t color='#B9E1F8'>Open</t><t color='#0068AC'>University</t>: Transfer Enrolment <t color='#ffc400'>100€</t>", {
		if((player getVariable "dinero") >= 100) then {
			player setVariable ["dinero",(player getVariable "dinero")-100,true];
			if (player getUnitTrait "medic") then {
				player setUnitTrait ["engineer",true]; 
				player setUnitTrait ["medic",false]; 
				hint "Paid 100 €. You are now an Engineer. That was quick.";
			} else {
				player setUnitTrait ["engineer",false]; 
				player setUnitTrait ["medic",true]; 
				hint "Paid 100 €. You are now a Medic. That was quick.";
			}
		} else {
			hint "Not enough €";
		}
	},nil,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos) and ((player getUnitTrait ""engineer"") or (player getUnitTrait ""medic""))"]] remoteExec ["addAction", 0, true];
	
	[laptop_table,["Move this asset", "moveHQObject.sqf",nil,0,true,true,"","(_this == theBoss)"]] remoteExec ["addAction", 0, true];
	
	_modVeh = [["I_UAV_01_F",75],["C_Quadbike_01_F",100]];
	{
		_veh = _x select 0;
		_price = _x select 1;
		server setVariable [_veh,_price,true];
		[laptop_order,[format ["<t color='#DE3036'>e</t><t color='#0061CB'>B</t><t color='#EDAA02'>a</t><t color='#82B216'>y</t>: %1 <t color='#ffc400'> %2 €</t>",getText (configFile >> "CfgVehicles" >> _veh >> "displayName"),_price], {
			[_this select 3] spawn A3A_fnc_addFIAVeh
		},_veh,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos)"]] remoteExec ["addAction", 0, true];
	}
	forEach _modVeh;
	
	//[laptop_order,[format["<t color='#DE3036'>e</t><t color='#0061CB'>B</t><t color='#EDAA02'>a</t><t color='#82B216'>y</t>: ATV Quadbike <t color='#ffc400'>%1 €</t>",["C_Quadbike_01_F"] call A3A_fnc_vehiclePrice], {
	//	["C_Quadbike_01_F"] spawn A3A_fnc_addFIAVeh
	//},nil,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos)"]] remoteExec ["addAction", 0, true];
	