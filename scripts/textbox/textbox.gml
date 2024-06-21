global.TestText = [
	"<voice(TXT1)>* The year's at the spring<wait(1)><dnl()>And day's at the morn;",
	"* Morning's at seven;",
	"* The hill-side's dew-pearled;",
	"* The lark's on the wing;",
	"* The snail's on the thorn:<voice(TXT2)>",
	"<rgb[99](255, 0, 0)>* <shake[3](2, 2)><rgb[3](255, 255, 0)>God's in his <rainbow2[6]()><wave[6](1, 0.5)>heaven--<waitinput()><dnl()>" +
	"All's <rgb[5](153, 250, 95)>right with the <rgb[5](0, 152, 220)>world!"
];
//global.TextBox = undefined;

function typewriter(text) constructor
{
	RawText = is_string(text) ? [text] : text;
	Line = 0;
	TextSpd = 1;
	WaitTime = -1;
	
	EndDiag = false;
	
	TWE = undefined;
	if (array_length(RawText) > 0)
		{ TWE = new TWE_system(0, 0, RawText[0], 0, self); }
	
	function update()
	{
		if (TWE == undefined)
			{ EndDiag = true; return; }
		var totalLen = string_length(TWE.DisplayTxt) + 1;
		
		if (WaitTime > -1)
			{ WaitTime--; }
		
		if (TWE.TextAmount < totalLen) and (WaitTime <= 0)
			{ TWE.TextAmount += TextSpd; }
		
		//Show all text
		if input("deny")
			{ TWE.TextAmount = totalLen; }
		
		//While typewriter animation is still running
		if (TWE.TextAmount >= totalLen) and input("accept")	//Go to next line
		{
			//Next line
			if (Line < array_length(RawText) - 1)
			{
				Line++;
				TWE.convert(RawText[Line]);
				TWE.TextAmount = 0;
				Skipper = totalLen;
			}
			else
				{ EndDiag = true; }
		}
	}
		
	function draw()
	{
		if (TWE == undefined)
			{ return; }
		
		TWE.draw();
	}
}

function textbox(text, side) : typewriter(text)
constructor
{
	// 0: Bottom 1: Top;
	Side = side ?? (obj_mainchara.y > global.mcam.Y[1] + 160);
	
	Portrait = -1;
	Voice = undefined;
	VoTick = 0;
	Progress = -1;
	
	obj_mainchara.moveable = false;
	obj_mainchara.interactable = false;
	
	function update()
	{
		if (TWE == undefined)
			{ EndDiag = true; return; }
		var totalLen = string_length(TWE.DisplayTxt) + 1;
		
		if (WaitTime > -1)
			{ WaitTime--; }
		
		if (TWE.TextAmount < totalLen) and (WaitTime <= 0)
			{ TWE.TextAmount += TextSpd; }
		
		//Show all text
		if input("deny")
			{ TWE.TextAmount = totalLen; }
		
		//While typewriter animation is still running
		if (TWE.TextAmount >= totalLen) and input("accept")	//Go to next line
		{
			//Next line
			if (Line < array_length(RawText) - 1)
			{
				Line++;
				TWE.convert(RawText[Line]);
				TWE.TextAmount = 0;
				Skipper = totalLen;
			}
			else
			{
				EndDiag = true;
				obj_mainchara.moveable = true;
				obj_mainchara.interactable = true;
			}
		}
	}
	
	function draw()
	{
		if (TWE == undefined)
			{ return; }
		
		var _x = global.mcam.X[1] + 16;
		var _y = global.mcam.Y[1] + (Side == 0 ? 160 : 6);
		
		//Holder
		draw_sprite_stretched(spr_holder, 0, _x, _y, 288, 75);
		
		//Text
		TWE.X = _x + (sprite_exists(Portrait) ? 72 : 14);
		TWE.Y = _y + 12;
		TWE.draw();
		
		//Voice (Sound effect)
		//Put this code under here because at some point the voice will be changed using TWE function
		if (Voice != undefined) and (WaitTime <= 0)
		and (TWE.TextAmount < string_length(TWE.DisplayTxt) + 1)
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

function textbubble(text) : typewriter(text)
constructor
{
	function draw()
	{
		if (TWE == undefined)
			{ return; }
		
		var _x = global.mcam.X[1] + 16;
		var _y = global.mcam.Y[1] + (Side == 0 ? 160 : 6);
		
		//Holder
		draw_sprite_stretched(spr_holder, 0, _x, _y, 288, 75);
		
		//Text
		TWE.X = _x + (sprite_exists(Portrait) ? 72 : 14);
		TWE.Y = _y + 12;
		TWE.draw();
		
		//Voice (Sound effect)
		//Put this code under here because at some point the voice will be changed using TWE function
		if (Voice != undefined) and (WaitTime <= 0)
		and (TWE.TextAmount < string_length(TWE.DisplayTxt) + 1)
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

function display_textbox(text_array)
{
	if is_undefined(GeneralCtrl.textBox)
	{
		GeneralCtrl.textBox = new textbox(text_array);
		obj_mainchara.flag = McFlag.DISABLE_ALL;
	}
}