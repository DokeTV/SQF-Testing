private _npc = _this;
lastActivationTime = 0;

_npc addAction ["Start Pharma", {    // Function to check if the action can be activated
	private _currentTime = diag_tickTime;
	private _cooldownTime = 10;
   _canActivateAction = if ((_currentTime - lastActivationTime) >=  _cooldownTime) then {
		lastActivationTime = _currentTime;
		true;
	} else {
		false;
	};

	if (!_canActivateAction) exitWith {
		hint format ["The Pharma Company is on high alert please wait %1 seconds before trying again", (_cooldownTime- (diag_tickTime - lastActivationTime))];
		uiSleep 1; 
 //       exitWith {}; // some dumb ass issue with exit with i still dont understand this good
	};
	private _exit = false;
	private _pharmaTimer = 5;
	private _npc = _this select 0;

		 while {_pharmaTimer > 0} do {
		if ((player distance _npc) > 5) exitWith {
			_exit = true;
			hint "You have gone too far away!";
		};

		hint format ["Pharma truck is inbound and arriving in %1 seconds. Defend from the cops!", _pharmaTimer];
		uiSleep 1;  // Pause the script for 1 second
		_pharmaTimer = _pharmaTimer - 1;  // Decrease the timer by 1 second
	};

	if (_exit) exitWith {};

	private _spawnPosition = [15331.4, 16105.9, 4.4];
	private _pharmaTruckClass = "O_Truck_03_transport_F";
	

	private _pharmaTruck = createVehicle [_pharmaTruckClass, _spawnPosition, [], 0, "CAN_COLLIDE"];
	_pharmaTruck setDir 75;  // Set initial direction of the Pharma truck

	private _eventTimer = 20;  // 1200 seconds = 20 minutes
	private _destroyTimer = 15; 

	while {_eventTimer > 0} do {

		if (damage _pharmaTruck == 1) exitWith {
			hint "The Pharma vehicle has been destroyed!";
		};

		hint format ["You have %1 seconds to complete the escort", _eventTimer];
		uiSleep 1;
		_eventTimer = _eventTimer - 1;

		if(_eventTimer == 0) exitWith {

			while {_destroyTimer > 0} do {

				hint format ["The Pharma vehicle will be destroyed in %1 Seconds", _destroyTimer];
				uiSleep 1;
				_destroyTimer = _destroyTimer -1;
			};
		_pharmaTruck setDamage 1;
		};
	};
}];