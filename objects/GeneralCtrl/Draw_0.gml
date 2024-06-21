//Text box
if !is_undefined(textBox)
	{ textBox.draw(); }

//Room Transition
if !is_undefined(rmTransit.Data)
{
	with global.mcam
	{
		draw_set_alpha(1 - abs(other.rmTransit.Timer));
		draw_set_color(#000000);
		draw_rectangle(X[1] - 2, Y[1] - 2, X[2] + 2, Y[2] + 2, false);
		draw_set_alpha(1);
		draw_set_color(#ffffff);
	}
}

//Pause menu
if !is_undefined(pauseMenu)
	{ pauseMenu.draw(); }