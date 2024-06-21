#region Text box

if (textBox != undefined)
{
	textBox.update();
	if textBox.EndDiag
	{
		textBox = undefined;
		call_later(
			10, time_source_units_frames,
			function() { obj_mainchara.flag = McFlag.ENABLE_ALL; },
			false
		);
	}
}

if keyboard_check_pressed(vk_insert)
	{ global.TextData = json_load(global.TextDir[0]); }

#endregion

#region Room transition
if !is_undefined(rmTransit.Data)
{
with rmTransit
{
	if (Timer < 1)
		{ Timer += 0.05 * delta_spd; }
	else
	{
		Data = undefined;
		Timer = -1;
	}
		
	if (Timer == 0)
	{
		with obj_mainchara
		{
			x = other.Data.X;
			y = other.Data.Y;
			flag = McFlag.ENABLE_ALL;
		}
		room_goto(Data.Room);
	}
}
}
#endregion

#region Pause menu

if is_undefined(pauseMenu)
{
	if input("menu")
	and (flag & GctrlFlag.PAUSE_MENU)
	{
		audio_play_sound(sfx_squeak, 1000, false);
		obj_mainchara.flag = McFlag.DISABLE_ALL;
		pauseMenu = new pause_menu();
	}
}
else
{
	pauseMenu.update();
	if (pauseMenu.Finish)
	{
		pauseMenu = pauseMenu.flush();
		obj_mainchara.flag = McFlag.ENABLE_ALL;
	}
}

#endregion

#region Layer Ordering

var layerCheck = layer_get_all()
if (layerCheck[0] != layer)
	{ layer_depth(layer, layer_get_depth(layerCheck[0]) - 1); }

#endregion
