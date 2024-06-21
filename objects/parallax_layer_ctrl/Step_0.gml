for (var i = 0; i < array_length(parallax_layers); i++)
{
	var cx = (global.mcam.X[1] + global.mcam.X[2]) / 2;
	var cy = (global.mcam.Y[1] + global.mcam.Y[2]) / 2;
	layer_x(parallax_layers[i], cx * x_amount[i]);
	layer_y(parallax_layers[i], cy * y_amount[i]);
}
