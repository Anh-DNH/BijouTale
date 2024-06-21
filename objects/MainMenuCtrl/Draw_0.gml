draw_set_align(1, 1);
draw_set_font(fnt_title);
draw_text_transformed(global.mcam.X[0], global.mcam.Y[0], Title, 3, 3, 0);
if floor(ShowIntruction)
{
	draw_set_font(fnt_small);
	draw_set_color(c_gray);
	draw_text(
		global.mcam.X[0], global.mcam.Y[0] + 64,
		$"[{global.TextData.title_instruction}]"
	);
}
draw_set_color(c_white);
draw_set_font(-1);
draw_set_align(0, 0);

//Tako.draw_idle(mouse_x, mouse_y);
