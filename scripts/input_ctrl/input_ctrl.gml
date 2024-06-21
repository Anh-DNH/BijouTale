function assign_input(key, gpad_input, gpad_axis, gpad_side)
constructor
{
	timer = 0;
	keyboard = key;
	gp_input = gpad_input;
	gp_axis = gpad_axis;
	gp_dir = gpad_side;
}

global.InputCont = {
	up				:	new assign_input(vk_up, noone, gp_axislv, -1),
	down			:	new assign_input(vk_down, noone, gp_axislv, 1),
	left			:	new assign_input(vk_left, noone, gp_axislh, -1),
	right			:	new assign_input(vk_right, noone, gp_axislh, 1),
	
	accept		:	new assign_input(ord("Z"), gp_face1, -4, -4),
	deny			:	new assign_input(ord("X"), gp_face2, -4, -4),
	menu			:	new assign_input(ord("C"), gp_face3, -4, -4),
	shift			:	new assign_input(vk_shift, gp_face4, -4, -4),
}

function input_updater()
{
	var nameList = variable_struct_get_names(global.InputCont);
	for (var i = 0; i < array_length(nameList); ++i)
	{
		var bton = global.InputCont[$ nameList[i]];
		var signal = keyboard_check(bton.keyboard)
		or gamepad_button_check(0, bton.gp_input)
		or (round(gamepad_axis_value(0, bton.gp_axis)) == bton.gp_dir)
		bton.timer = signal ? bton.timer + 1 : 0;
	}
}
global.InputUpdater = time_source_create(
	time_source_global, 1, time_source_units_frames, input_updater, [], -1
);
time_source_start(global.InputUpdater);


/**
@arg {String} name			input attribute inside global.InputCon
@arg {Real} delay			delay time (in frame)
@arg {Real} knockback	how many frames to get back after the timer reach equal or above delay time
**/
function input(name, delay = infinity, knockback = 0)
{
	var bton = global.InputCont[$ name];
	var kRange = max(delay - knockback, 1)
	return (bton.timer == 1)
	or ((bton.timer >= kRange) and (wrap(bton.timer, kRange, delay) == delay));
}
