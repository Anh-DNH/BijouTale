//Put here everything you want to be created from the start of the game
#macro delta_spd (60 / game_get_speed(gamespeed_fps))

global.sprfnt[0] = font_add_sprite_ext(
	sprfont_title, "abcdefghijklmnopqrstuvwxyz0123456789,.!?-\"\u25af\ABDOPQR", true, 1
);
#macro fnt_title global.sprfnt[0]

randomize();
audio_group_set_gain(audiogroup_default, 0.8, 0);

#region Common functions

///Make this object create only one instance in a room
function instance_unique()
{
	if (instance_number(object_index) > 1)
		{ instance_destroy(id); return false; }
	return true;
}

/**
Returns a rounded number between "from" and "to"
@arg {Real} val		The value to wrap
@arg {Real} from	Minimum value
@arg {Real} to		Maximum value
**/
function wrap(val, from, to)
{
	if (to < from)
		{ var temp = to; to = from; from = temp; }
	val = (floor(val) - from) % (to - from + 1);
	if (val < 0)
		{ return to + val + 1; }
	else
		{ return from + val; }
}

/**
Loads a .json file from the directory and turns it to struct
@arg {String} dir directory to the file
@return {Struct}
**/
function json_load(dir)
{
	var	json_file = file_text_open_read(dir),
			json_str = ""
			;
	
	while !file_text_eof(json_file)
	{
		json_str += file_text_read_string(json_file) + "\n";
		file_text_readln(json_file)
	}
	
	file_text_close(json_file);
	
	return json_parse(json_str);
}

/**
Turns a struct into a .json data and saves it to a file
@arg {String} dir directory to the file
@arg {Struct} struct struct to save
**/
function json_save(dir, struct)
{
	if file_exists(dir)
		{ file_delete(dir); }
	var jsonFile = file_text_open_write(dir);
		file_text_write_string(jsonFile, json_stringify(struct, true));
	file_text_close(jsonFile);
}

#endregion

#region Project's functions

function error(str)
{
	show_error(str, false);
}

function draw_set_align(halign, valign)
	{ draw_set_halign(halign); draw_set_valign(valign); }

function room_transition(_rm, _x, _y)
{
	with GeneralCtrl
	{
		rmTransit.Data = {
			Room	: _rm,
			X		: _x,
			Y		: _y,
		}
	}
	
	obj_mainchara.flag = McFlag.DISABLE_ALL;
}

#endregion