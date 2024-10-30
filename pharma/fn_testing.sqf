private _pharmaEnd = _this;
_pharmaEnd addAction
[
	"Deliver pharma",
	{  
        params ["_target", "_caller", "_actionId", "_arguments"];
	private _deliverTimer = 10;

	while {_deliverTimer >= 0} do {
	hint format ["The Pharma is being deliverd and will be completed in %1 seconds", _deliverTimer];
	uiSleep 1;
	_deliverTimer = _deliverTimer - 1;

	if (damage pharmaTruck == 1) exitWith {
	hint "The Pharma Truck has been destoryed!";
	};
	
	if (_deliverTimer == 0) exitWith { 
		hint "Congrats the vehicle has been delivered!";
		deleteVehicle pharmaTruck;
		pharmaPhase = 3;
	};
	};
},
	nil,
	1.5,
	true,
	true,
	"",
	"player distance pharmaEndNpc <= 2 || pharmaTruck distance pharmaEndNpc <= 25" 
];