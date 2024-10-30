private _pharmaStart = _this;


_pharmaStart addAction ["Start Pharma", {    // Function to check if the action can be activated
	private _currentTime = diag_tickTime;
	private _cooldownTime = 10;

	//Can do this same thing w mag types or make a file dedicated to checking someones weapon type.
	_approvedCalibre = ["6.5","7.62"];
	_calibre =  (currentMagazineDetail player) splitString  " mm";

	if !((_calibre select 0) in _approvedCalibre) exitWith {hint "The clerk stands on business. You will need a 7.62 weapon for this"};

   _canActivateAction = if ((_currentTime - lastActivationTime) >=  _cooldownTime) then {
		lastActivationTime = _currentTime;
		true;
	} else {
		false;
	};

	if (!_canActivateAction) exitWith {
		hint format ["The Pharma Company is on high alert please wait %1 seconds before trying again", (_cooldownTime- (diag_tickTime - lastActivationTime))];
		uiSleep 1; 
	};
	private _exit = false;
	private _pharmaTimer = 5;
	private _pharmaStart = _this select 0;

		 while {_pharmaTimer > 0} do {
		if ((player distance _pharmaStart) > 5) exitWith {
			_exit = true;
			hint "You have gone too far away!";
		};

		hint format ["Pharma truck is inbound and arriving in %1 seconds. Defend from the cops!", _pharmaTimer];
		uiSleep 1;  
		_pharmaTimer = _pharmaTimer - 1;  
	};

	if (_exit) exitWith {};

	private _spawnPosition = [15331.4, 16105.9, 4.4];
	private _pharmaTruckClass = "O_Truck_03_transport_F";


	pharmaTruck = createVehicle [_pharmaTruckClass, _spawnPosition, [], 0, "CAN_COLLIDE"];
	pharmaTruck setDir 75;  
	pharmaTruck setVariable ["pharma", true, true];


	private _eventTimer = 1200; 
	private _destroyTimer = 15; 
	

	while {_eventTimer > 0} do {
		hint format ["You have %1 seconds to complete the escort", [_eventTimer, "MM:SS"]
		call BIS_fnc_secondsToString];
		uiSleep 1;
		_eventTimer = _eventTimer - 1;
		if (pharmaPhase == 3) exitWith {};

		if (damage pharmaTruck == 1) exitWith {
		hint "The Pharma Truck has been destoryed!";
		};
	
		if(_eventTimer == 0) exitWith {

			while {_destroyTimer >= 0} do {

				hint format ["The Pharma vehicle will be destroyed in %1 min's", _destroyTimer];
				uiSleep 1;
				_destroyTimer = _destroyTimer -1;
							if (_destroyTimer == 0) exitWith {
								hint "The Pharma vehicle has been destroyed!";
				pharmaTruck setDamage 1;
			};
			};

		};
	};
},
	nil,
	1.5,
	true,
	true,
	"",
	"player distance pharmaStartNpc <= 2"
];
