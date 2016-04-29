/**
* Logs a message to the RPT log with the origin as it's prefix
* 
* @param The type of this log (0 = ERROR, 1 = INFO)
* @param The name of the script the error occured in (optional)
* @param The message to log
*/

scopeName "rvn_fnc_log";

private _type = "";
private _typeNumber = -2;
private _script = "Unknown";
private _message = "";

private _argumentCount = count _this;

if(_argumentCount == 2) then {
	// no script is specified
	_typeNumber = param [0, -1, [0]];
	_message = param [1, "Failed At retrieving message", ["String"]];
	
	//TODO: use _fnc_scriptNameParent
} else {
	if(_argumentCount != 3) then {
		// log this error instead of the given message
		_typeNumber = 0;
		_script = "rvn_fnc_log";
		_message = "Invalid argument count (" + _argumentCount + ")!";
	} else {
		_typeNumber = param [0, -1, [0]];
		_script = "(" + param [1, "Unknown", ["String"]] + ")";
		_message = param [2, "Failed At retrieving message", ["String"]];
	};
};

switch (_typeNumber) do {
	// set type
	case 0: {_type = "[ERROR]"};
	case 1: {_type = "[INFO]"};
	default {_type = "[?]"};
};

// assemble logMessage
private _logMessage = "OurAltis " + _type + ": " + _script + " " + _message;

// log message
diag_log _logMessage;
