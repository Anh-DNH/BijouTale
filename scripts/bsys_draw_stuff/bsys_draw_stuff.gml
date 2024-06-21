//Show exclamation icon
function bsys_draw_intro_1()	
{
	with (obj_mainchara)
		{ draw_sprite(spr_alert, 0, x, y - sprite_height - 2); }
}
	
//Set black background while keeping player's sprite visible
function bsys_draw_intro_2()	
{
	draw_set_color(c_black);
	draw_rectangle(global.mcam.X[1], global.mcam.Y[1], global.mcam.X[2], global.mcam.Y[2], false);
	draw_set_color(c_white);
	with (obj_mainchara)
		{ draw_sprite(sprite_index, 0, x, y); }
}

//Keep black background, hide player's sprite
function bsys_draw_intro_3()
{
	draw_set_color(c_black);
	draw_rectangle(global.mcam.X[1], global.mcam.Y[1], global.mcam.X[2], global.mcam.Y[2], false);
	draw_set_color(c_white);
}

//Main battle drawer
function bsys_draw_main()
{
	if !surface_exists(Sface.ID)
		{ Sface.ID = surface_create(640, 480); }
	
	surface_set_target(Sface.ID);
			
		draw_clear(c_black);
		
		//BACKGROND
		draw_sprite(spr_bsys_bg, 0, 17, 11);
			
		//FOUR BUTTONS OF BATTLE
		var ybase = 432;
		draw_sprite(spr_bsys_bton_FIGHT, Action == 0, 32, ybase);	//FIGHT
		draw_sprite(spr_bsys_bton_ACT, Action == 1, 185, ybase);	//ACT
		draw_sprite(spr_bsys_bton_ITEM, Action == 2, 345, ybase);	//ITEM
		draw_sprite(spr_bsys_bton_MERCY, Action == 3, 500, ybase);	//SPARE
		
		//Player's stat
		draw_set_font(fnt_curs);
		with obj_mainchara
		{
			//Name + Sprites
			draw_text(30, 402, $"{NAME}   LV {LV}");
				
			var hpX = 275, hpY = 400;
			//Max HP bar
			draw_set_color(c_red);
			draw_rectangle(hpX, hpY, hpX + HP[1] * 1.2, hpY + 20, false);
			//Current HP bar
			draw_set_color(c_yellow);
			draw_rectangle(hpX, hpY, hpX + HP[0] * 1.2, hpY + 20, false);
			//Health Point
			draw_set_color(c_white);
			draw_sprite(spr_hp, 0, 244, 405);
			draw_text(290 + (HP[1] * 1.2), 400, $"{HP[0] < 10 ? "0" : ""}{HP[0]} / {HP[1]}");
		}
		draw_set_font(-1);
		
	surface_reset_target();
	
	draw_set_color(c_black);
	draw_rectangle(global.mcam.X[1], global.mcam.Y[1], global.mcam.X[2], global.mcam.Y[2], false);
	draw_set_color(c_white);
	
	draw_surface_ext(Sface.ID, global.mcam.X[1], global.mcam.Y[1], 0.5, 0.5, 0, c_white, Sface.Alpha);
			
	draw_set_alpha(Sface.Alpha);
	
	//Monsters
	for (var i = 0; i < array_length(Monster); i++)
		{ Monster[i].draw(); }
	
	//Textbox / Soul's move area
	draw_sprite_stretched(
		spr_holder, 0,
		MoveArea.X1, MoveArea.Y1,
		MoveArea.X2 - MoveArea.X1, MoveArea.Y2 - MoveArea.Y1
	);
	
	//Targeter
	if !is_undefined(Targeter)
	{
		Targeter.draw(
			(MoveArea.X1 + MoveArea.X2) / 2,
			(MoveArea.Y1 + MoveArea.Y2) / 2
		);
	}
	
	//Textbox
	if !is_undefined(Dialoguer)
	{
		if is_string(Dialoguer)
		{
			draw_set_font(fnt_maintext);
			draw_text(global.mcam.X[1] + 50, global.mcam.Y[1] + 137, Dialoguer);
			draw_set_font(-1);
		}
		else if (instanceof(Dialoguer) == "textbox_battle")
			{ Dialoguer.draw(); }
	}
	
	//Options
	if !is_undefined(Option)
	{
		Option.draw_option();
				
		//Monster's Health
		if (bsys_step == bsys_step_Player_SelectMonster) and (Action == 0) //FIGHT
		{
			var monsterNum = array_length(Monster);
			var xBase = Option.OptX + Option.SpaceW + 30;
			var yBase = Option.OptY + 3;
			var barW = 50;	var barH = 8;
			for (var i = 0; i < monsterNum; i++)
			{
				var _monster = Monster[i];
				draw_set_color(c_red);
				draw_rectangle(xBase, yBase, xBase + barW, yBase + barH, false);
				draw_set_color(c_lime);
				draw_rectangle(xBase, yBase, xBase + ((_monster.HP[0] / _monster.HP[1]) * barW), yBase + barH, false);
				yBase += 16;
			}
			draw_set_color(c_white);
		}
		else if (bsys_step == bsys_step_Player_ITEM_Option)
		{
			draw_set_font(fnt_maintext);
			draw_text(global.mcam.X[1] + 195, global.mcam.Y[1] + 171, $"PAGE {Option.Page + 1}");
			draw_set_font(-1);
		}
	}
	
	//Damage Counter
	if !is_undefined(DamageDealer)
		{ DamageDealer.draw(); }

	//draw_text(
	//	mouse_x, mouse_y, $"{mouse_x - global.mcam.X[1]}\n{mouse_y - global.mcam.Y[1]}"
	//);
	
	draw_set_alpha(1);
}

function bsys_draw_outro()
{
	draw_set_color(c_black);	draw_set_alpha(1 + Sface.Alpha);
	draw_rectangle(global.mcam.X[1], global.mcam.Y[1], global.mcam.X[2], global.mcam.Y[2], false);
	draw_set_color(c_white);	draw_set_alpha(1);
}