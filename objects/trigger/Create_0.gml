enum TTYPE
{
	//Explaination of 5 different types of trigger:
	ONCE,	//Execute code only once, then never execute again.
	TOGGLE,	//Execute code depends on an on/off switch.
	HOLD,	//Keep executing code as long as the condition function returns true
	LOOP,	//Execute code indefinitely after triggered
	REPEAT	//Execute code once every time condition function returns true
}

if !script_exists(condition_function)
	{ error("condition_function is not valid!\n"); }
if !script_exists(execute_function)
	{ error("execute_function is not valid!\n"); }
if sprite_exists(sprite_mask)
	{ sprite_index = sprite_mask; }

active = false;