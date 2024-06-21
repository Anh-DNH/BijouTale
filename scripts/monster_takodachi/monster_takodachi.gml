function monster_takodachi() : monster()
constructor
{
	NAME = global.TextData.takodachi_name;
	HP = [20, 20, 20];	//[Current, Max, Prev];
	
	DIALOGUE = [
		[ global.TextData.takodachi_diag_1 ]
	];
	
	ACT_option = ["* Check", "* Pet", "* Bonk"];
	
	ACT_receive = -1;
	ACT_respond = [
		global.TextData.battle_ACT_respond_tako1,
		global.TextData.battle_ACT_respond_tako2,
		global.TextData.battle_ACT_respond_tako3
	];
	
	function draw_idle()
	{
		//Responder: Turn to hurt draw if there is a change in healthpoint
		if (HP[2] != HP[0])
		{
			HP[2] = HP[0];
			HurtCooldown = 50;
			draw = draw_hurt;
		}
		
		var _frame = get_timer() / 4_500_000;
		_frame -= (_frame div 1);
		
		var _x = global.mcam.X[1] + X;
		var _y =	global.mcam.Y[1] + Y +
					animcurve_channel_evaluate(
						animcurve_get_channel(anicv_tako, 0), _frame
					)
					;
		
		W = 43;
		H = 58;
						
		//Body
		draw_sprite(spr_tako_body, 0, _x + 22, _y + 50);
		
		//Left flap
		draw_sprite_ext(
			spr_tako_flap, 0,
			_x + 12, _y + 21,
			1, 1,
			animcurve_channel_evaluate(
				animcurve_get_channel(anicv_tako, 1), _frame
			),
			draw_get_color(), draw_get_alpha()
		);
		
		//Right flap
		draw_sprite_ext(
			spr_tako_flap, 0,
			_x + 32, _y + 21,
			-1, 1,
			-animcurve_channel_evaluate(
				animcurve_get_channel(anicv_tako, 1), _frame
			),
			draw_get_color(), draw_get_alpha()
		);
		
		//Face
		draw_sprite(
			spr_tako_faces, 0,
			_x + 22, _y + 49 + animcurve_channel_evaluate(
				animcurve_get_channel(anicv_tako, 3), _frame
			)
		);
		
		//Halo
		_frame = (get_timer() / 4_500_000) - 0.075;
		_frame -= (_frame div 1);
		_y =	global.mcam.Y[1] + Y +
				animcurve_channel_evaluate(
					animcurve_get_channel(anicv_tako, 0), _frame
				);
		draw_sprite(spr_tako_halo, 0, _x + 22, _y + 6);
	}
	
	HurtCooldown = 0;
	function draw_hurt()
	{
		HurtCooldown -= (HurtCooldown > 0);
		if (HurtCooldown <= 0)
			{ draw = draw_idle; }
		
		var _x =	global.mcam.X[1] + X + 
					(max(HurtCooldown, 8) / 100) * 3 *
					(sin(get_timer() / 1_000) >= 0 ? 1 : -1)
					;
		var _y = global.mcam.Y[1] + Y;
		
		W = 43;
		H = 51;
				
		draw_sprite(spr_tako_body, 0, _x + 22, _y + 48);
		draw_sprite(spr_tako_flap, 0, _x + 12, _y + 19);
		draw_sprite_ext(spr_tako_flap, 0, _x + 32, _y + 19, -1, 1, 0, #ffffff, 1);
		draw_sprite(spr_tako_faces, 2, _x + 22, _y + 25);
		draw_sprite(spr_tako_halo, 0, _x + 22, _y + 4);
	}
	
	function draw_die()
	{
		var _x =	global.mcam.X[1] + X + 
					(max(HurtCooldown, 8) / 100) * 3 *
					(sin(get_timer() / 1_000) >= 0 ? 1 : -1)
					;
		var _y = global.mcam.Y[1] + Y;
		
		W = 43;
		H = 51;
		
		draw_set_color(#00ff00);
		draw_rectangle(_x, _y, _x + W, _y + H, false);
		draw_set_color(#ffffff);
		
		draw_sprite(spr_tako_body, 0, _x + 22, _y + 48);
		draw_sprite(spr_tako_flap, 0, _x + 12, _y + 19);
		draw_sprite_ext(spr_tako_flap, 0, _x + 32, _y + 19, -1, 1, 0, #ffffff, 1);
		draw_sprite(spr_tako_faces, 2, _x + 22, _y + 25);
		draw_sprite(spr_tako_halo, 0, _x + 22, _y + 4);
	}
	
	draw = draw_idle;
}

