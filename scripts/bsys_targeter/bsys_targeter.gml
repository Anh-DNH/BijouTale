function bsys_targeter_template() constructor
{
	Power = -1;
	Finish = false;
	Close = false;
	
	function action() {}
	
	function draw() {}
}

///Default targeter (spr_targetchoice go from the left to right on spr_target)
function bsys_targeter_default() : bsys_targeter_template()
constructor
{
	Aimer = -190;
	ScaleX = 1;
		
	function action_aim()
	{
		if (Aimer >= 190)	//Missed
		{
			Power = 0;
			action = action_close;
			return;
		}
		Aimer += 6;
		
		if input("accept")	//Hit
		{
			ScaleX = 2.5;
			Power = max(140 - abs(Aimer), 0) / 140;
			action = action_close;
			return;
		}
	}
	
	function action_close()
	{
		ScaleX -= 1 / 30;
		if (ScaleX <= 1)
			{ Finish = true; }
		if (ScaleX <= 0)
			{ Close = true; }
	}
	
	action = action_aim;
	
	function draw(_x, _y)
	{
		//Target background
		draw_sprite_ext(
			spr_target, 0,
			_x, _y,
			0.5 * min(ScaleX, 1), 0.5, 0, #ffffff, min(ScaleX, 1)
		);
		
		//Target choicer
		if (ScaleX >= 1)
		{
			draw_sprite_ext(
				spr_targetchoice,
				(action == action_close) * (get_timer() / 100_000),
				_x + Aimer, _y,
				0.5, 0.5, 0, #ffffff, 1
			);
		}
	}
}

//function bsys_targeter_UTyellow() : bsys_targeter_template()
//constructor
//{
//}