/*
	Allowed Targets:
		0: can target all machines (default)
		1: can target only clients, execution on server is denied
		2: can target only server, execution on clients is denied

	JIP:
		0: JIP flag cannot be set
		1: JIP flag can be set (default)

	Modes:
		0: remote execution is blocked
		1: only whitelisted functions/commands are allowed for remote execution
		2: remote execution fully opened

	Whitelist Debug: class BIS_fnc_debugConsoleExec {allowedTargets = 0;};
*/

class Commands {
	mode = 0;
	jip = 0;
};

class Functions {
	mode = 1;
	jip = 0;

};