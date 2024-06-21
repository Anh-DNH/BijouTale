var _signal = condition_function();
var _exec = false;
switch type
{
	case TTYPE.ONCE:
		if _signal and !active
		{
			_exec = true;
			active = true;
		}
		break;
	case TTYPE.TOGGLE:
		if _signal
		{
			active = !active;
			if active
				{ _exec = true; }
		}
		break;
	case TTYPE.HOLD :
		if _signal
			{ _exec = true; }
		break;
	case TTYPE.LOOP :
		if _signal or active
			{ active = true; _exec = true; }
		break;
	case TTYPE.REPEAT : 
		if _signal and active
			{ _exec = true; }
		active = !_signal;
		break;
}

if _exec
	{ script_execute_ext(execute_function, exec_func_param); }
