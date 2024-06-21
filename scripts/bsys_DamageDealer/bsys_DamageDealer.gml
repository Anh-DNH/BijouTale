
/**
Showing the damage number or "missed" if damage is equals to 0
@arg hp Health Point
@arg damage Damage
**/
function bsys_DamageDealer(_monster, _damage) constructor
{
	Monster = _monster;
	DMG = _damage;
	HPreducer = (Monster.HP[0] - DMG) < 0 ? Monster.HP[0] : DMG;
	
	Finish = false;
	
	StrikeAnimFrame = 0;
	function draw_weapon_anim()
	{
		if (DMG == 0)
		{
			draw = draw_damage;
			return;
		}
		
		var _x =	global.mcam.X[1] + 
					Monster.X +
					(Monster.W / 2);
					
		var _y =	global.mcam.Y[1] + 
					Monster.Y + 
					(Monster.H / 2);
		
		StrikeAnimFrame += 0.5;
		if obj_mainchara.WEAPON.strike_anim(StrikeAnimFrame, _x, _y)
		{
			Monster.HP[0] -= HPreducer;
			audio_play_sound(sfx_damage, 1000, false);
			draw = draw_damage;
			return;
		}
	}
	
	DmgAnimFrame = 0;
	function draw_damage()
	{
		var _x =	global.mcam.X[1] +
					Monster.X +
					(Monster.W / 2);
					
		var _y =	global.mcam.Y[1] +
					Monster.Y - 16;
		
		
		HPreducer -= (HPreducer > 0);
		if (HPreducer <= 0)
			{ Finish = true; }
		
		if (DMG != 0)
		{
			//Damage number
			draw_set_color(#ff0000);
			draw_set_align(1, 2);
			var _pfont = draw_get_font();
			draw_set_font(global.fnt_dmg);
			
			DmgAnimFrame += (DmgAnimFrame < 23);
			draw_text(_x, _y + (sqr((DmgAnimFrame / 3) - 3.8) - 15), DMG);
			
			draw_set_font(_pfont);
			draw_set_align(0, 0);
			
			//Healthbar bar
			var _w = 48;
			var _h = 6;
			var _x1 = _x - (_w / 2);
			var _y1 = _y - (_h / 2) + 8;
			var _x2 = _x1 + _w;
			var _y2 = _y1 + _h;
			
			draw_set_color(#000000);
			draw_rectangle(_x1 - 1, _y1 - 1, _x2, _y2, false);
			draw_set_color(#666666);
			draw_rectangle(_x1, _y1, _x2 - 1, _y2 - 1, false);
			draw_set_color(#00ff00);
			draw_rectangle(
				_x1, _y1,
				_x1 + (_w * ((Monster.HP[0] + HPreducer) / Monster.HP[1])) - 1,
				_y2 - 1, false
			);
			draw_set_color(#ffffff);
		}
		else
			{ draw_sprite_ext(spr_dmgmiss, 0, _x, _y, 0.5, 0.5, 0, #777777, 1); }
	}
	
	draw = draw_weapon_anim;
}