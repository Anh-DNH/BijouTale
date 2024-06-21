if !instance_unique()
	{ return; }

enum GctrlFlag
{
	PAUSE_MENU = 0b_1,
	
	ENABLE_ALL		= 0b_11,
	DISABLE_ALL		= 0b_00,
}
flag = GctrlFlag.ENABLE_ALL;

#region Textbox

textBox = undefined;

#endregion

#region Room transition
rmTransit = {};
with rmTransit
{
	Data = undefined;
	Timer = -1;
}
#endregion

#region Pause Menu

pauseMenu = undefined;

#endregion