if array_length(parallax_layers) != array_length(x_amount)
or array_length(parallax_layers) != array_length(y_amount)
	{ show_error("parallax_layer_ctrl: parallax_layers[], x_amount[], y_amount[] does not synchronized!", false) }
