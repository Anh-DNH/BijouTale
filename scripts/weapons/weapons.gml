
function item_weapon() : item() constructor
{
	//For bsys_DamageDealer
	//This function will play an animation before
	//the monster got hit and display damage number with
	//healthbar
	//Return true if the animation ended
	function strike_anim(_frame, _x, _y)
	{
		if (floor(_frame) == 0)
			{ audio_play_sound(sfx_laz, 1000, false); }
		draw_sprite_ext(spr_strike, _frame, _x, _y, 0.5, 0.5, 0, c_white, 1);
		if (_frame > sprite_get_number(spr_strike))
			{ return true; }
		return false;
	}
	
	Targeter = bsys_targeter_default;
}

function item_wpn_stick() : item_weapon()
constructor
{
	function name(short = false)
		{ return global.TextData.wpn_stick_name; }
	
	function desc()
		{ return global.TextData.wpn_stick_desc; }
	
	function use()
		{ return global.TextData.wpn_stick_use; }
}