if global.RegConvert
{
	var sprElmID = undefined;

	if is_string(sprite_element_name)
		{ sprElmID = layer_sprite_get_id(sprite_layer, sprite_element_name); }
	else if layer_sprite_exists(sprite_layer, sprite_element_name)
		{ sprElmID = sprite_element_name; }

	if layer_sprite_exists(sprite_layer, sprElmID)
	{
		x = layer_sprite_get_x(sprElmID);
		y = layer_sprite_get_y(sprElmID);
		sprite_index = layer_sprite_get_sprite(sprElmID);
		layer_sprite_destroy(sprElmID);
	}
	else
		{ instance_destroy(id); }
}