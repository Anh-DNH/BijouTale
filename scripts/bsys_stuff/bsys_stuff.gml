function textbox_battle(text) : typewriter(text)
constructor
{
	Voice = global.CharaVoice.TXT2;
	VoTick = 0;
	
	function draw()
	{
		if (TWE == undefined)
			{ return; }
		
		//Text
		TWE.X = global.mcam.X[1] + 26;
		TWE.Y = global.mcam.Y[1] + 137;
		TWE.draw();
		
		//Voice (Sound effect)
		//Put this code under here because at some point the voice will be changed using TWE function
		if (WaitTime <= 0) and (TWE.TextAmount < string_length(TWE.DisplayTxt) + 1)
		{
			if (VoTick >= Voice.Length)
			{
				VoTick = 0;
				audio_stop_sound(Voice.Audio);
				audio_play_sound(Voice.Audio, 1000, false);
			}
			else
				{ VoTick += min(TextSpd, Voice.Speed); }
		}
	}
}

function option_battle(array_string) : option_default(array_string)
constructor
{
	OptX = global.mcam.X[1] + 50;
	OptY = global.mcam.Y[1] + 137;
	
	Font = fnt_maintext;
	
	draw_set_font(Font);
	for (var i = 0; i < array_length(array_string); i++)
		{ SpaceW = max(SpaceW, string_width(array_string[i])); }
	draw_set_font(-1);
	SpaceH = 16;
	
	function draw_option_list()
	{
		var	txt_x = array_create(array_length(List), OptX),
				txt_y = array_create(array_length(List), OptY)
				;
					
		//Text
		draw_set_font(Font);
		draw_set_color(TxtCol);
		draw_set_halign(TxtHalign);
		draw_set_valign(TxtValign);
	
		for (var i = 0; i < array_length(List); i++)
		{
			//Text positioning
			if ( txt_x[i] >= OptX + (SpaceW * (Column - 1)) )
			{
				txt_x[i + 1] = txt_x[0];
				txt_y[i + 1] = txt_y[i] + SpaceH;
			}
			else
			{
				txt_x[i + 1] = txt_x[i] + SpaceW;
				txt_y[i + 1] = txt_y[i];
			}
				
			//Texts
			var txt_w = (string_width(List[i]) * TxtSize);
			draw_text_transformed(
				//txt_x[i]/* + sprite_get_width(Cursor)*/ + 5,
				txt_x[i] + ((SpaceW / 2) * TxtHalign) + TxtXoff,
				txt_y[i] + ((SpaceH / 2) * TxtValign) + TxtYoff,
				List[i],
				TxtSize, TxtSize,
				0
			);
			
			//End
		}
			
		draw_set_font(-1);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	function choose_option(up, down, left, right)
	{
		//4-buttons input
		var hInput,vInput;
		hInput = right - left;
		vInput = down - up;
		if (hInput != 0 or vInput != 0)
			{ audio_play_sound(sfx_squeak, 1000, false); }
		Selector = wrap(Selector + hInput + (vInput * Column), 0, array_length(List) - 1);
	
		return real(Selector);
	}
}

function option_battle_2column(array_string) : option_battle(array_string)
constructor
{
	Column = 2;
	SpaceW = 128;
}

function option_battle_item(array_string) : option_battle_2column(array_string)
constructor
{
	Page = 0;
	
	function choose_option(up, down, left, right)
	{
		//4-buttons input
		var hInput,vInput;
		hInput = right - left;
		vInput = down - up;
		
		if (hInput != 0 or vInput != 0)
			{ audio_play_sound(sfx_squeak, 1000, false); }
		Selector = clamp(Selector + hInput + (vInput * Column), 0, array_length(List) - 1);
		Page = (Selector div 4);
		
		return Selector;
	}
	
	function draw_option_list()
	{
		var	txt_x = array_create(array_length(List), OptX),
				txt_y = array_create(array_length(List), OptY)
				;
					
		//Text
		draw_set_font(Font);
		draw_set_color(TxtCol);
		draw_set_halign(TxtHalign);
		draw_set_valign(TxtValign);
		
		for (var i = 0; i < min(4, array_length(List) - (Page * 4)); i++)
		{
			//Text positioning
			if ( txt_x[i] >= OptX + (SpaceW * (Column - 1)) )
			{
				txt_x[i + 1] = txt_x[0];
				txt_y[i + 1] = txt_y[i] + SpaceH;
			}
			else
			{
				txt_x[i + 1] = txt_x[i] + SpaceW;
				txt_y[i + 1] = txt_y[i];
			}
				
			//Texts
			//var txt_w = (string_width(List[i]) * TxtSize);
			draw_text_transformed(
				//txt_x[i]/* + sprite_get_width(Cursor)*/ + 5,
				txt_x[i] + ((SpaceW / 2) * TxtHalign) + TxtXoff,
				txt_y[i] + ((SpaceH / 2) * TxtValign) + TxtYoff,
				List[i + Page],
				TxtSize, TxtSize,
				0
			);
			
			//End
		}
			
		draw_set_font(-1);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

global.fnt_dmg = font_add_sprite_ext(spr_dmgnum, "0123456789", true, 0);
