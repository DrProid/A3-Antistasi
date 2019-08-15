//////////////create
if(_this select 1) then {
	if(!(isNil {garbage_dispose})) then {
		if(alive garbage_dispose) then {
			deleteVehicle garbage_dispose;
		};
	};
	garbage_dispose = "Land_GarbageBarrel_01_F" createVehicle (getPos mapa); 
	garbage_dispose allowDamage false;
	[garbage_dispose,["<t color='#FF0000'>Dispose of evidence</t>", {
	[[player,false],"burn_identity.sqf"] remoteExec ["execVM", 2];
	},nil,0,false,true,"","(isPlayer _this) and (side (group _this) == buenos) and (dateToNumber date < player getVariable ""compromised"")"]] remoteExec ["addAction", 0, true];
	[garbage_dispose, ["Remove garbage", {deleteVehicle garbage_dispose; deleteVehicle garbage_dispose;
	},nil,0,false,true,"","(_this == theBoss) and (petros == leader group petros)"]] remoteExec ["addAction", 0, true];
	[garbage_dispose,["Move this asset", "moveHQObject.sqf",nil,0,true,true,"","(_this == theBoss)"]] remoteExec ["addAction", 0, true];
} else {
	/////////////use
	private ["_plyr"];
	_plyr = _this select 0;
	_plyr playAction "PutDown";
	removeUniform _plyr;
	hint "They won't recognise you without those clothes.";

	sleep(3.5);
	hintSilent "";
	hint "Now to burn the evidence.";
	_fire = "#particlesource" createVehicle (getPos garbage_dispose);
	_fire setParticleClass "SmallFireBarrel";
	_fire attachTo [garbage_dispose,[0,0,0]];

	sleep(0.5);
	_plyr setVariable ["compromised",0];
	[] spawn A3A_fnc_statistics;
	_smoke = "#particlesource" createVehicle (getPos garbage_dispose);
	_smoke setParticleClass "MediumSmoke";
	_smoke attachTo [garbage_dispose,[0,0,1.3]];

	sleep(10);
	deleteVehicle _fire;

	sleep(1.5);
	deleteVehicle _smoke;
}


