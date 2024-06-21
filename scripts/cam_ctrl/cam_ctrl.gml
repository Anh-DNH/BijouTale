global.mcam = undefined;

function cam_ctrl(view_number, res_width, res_height, follower = noone)
constructor
{
	Port = view_number;
	ID = view_camera[view_number];
	Follower = follower;
	
	//Resolution, also window's size
	ResW = res_width;
	ResH = res_height;
	
	//[Camera's position, Camera's top left corner, Camera's bottom right corner]
	X = [0, 0, 0];
	Y = [0, 0, 0];
	Z = 2;	//Zoom
	W = ResW / Z;
	H = ResH / Z;
	
	//Camera's border. Default is unlimited
	AreaX = [-infinity, infinity];
	AreaY = [-infinity, infinity];
	
	Smooth = false; //Move smoothly or not
	
	function cam_size(res_w = ResW, res_h = ResH)
	{
		W = res_w / Z;
		H = res_h / Z;
		ResW = res_w;
		ResH = res_h;
		window_set_size(res_w, res_h);
		camera_set_view_size(ID, W, H);
		surface_resize(application_surface, res_w, res_h);
	}
	cam_size();
	window_set_position(
		(display_get_width() - ResW) / 2,
		(display_get_height() - ResH) / 2
	);
	
	function cam_pos()
	{
		if instance_exists(Follower)
		{
			X[0] = Follower.x;
			Y[0] = Follower.y;
		}
		
		var x_tar = clamp(X[0], AreaX[0], AreaX[1]) - (W / 2);
		var y_tar = clamp(Y[0], AreaY[0], AreaY[1]) - (H / 2);
		
		if Smooth
		{
			camera_set_view_pos(
				ID,
				camera_get_view_x(ID) + ((x_tar - camera_get_view_x(ID)) * 0.1),
				camera_get_view_y(ID) + ((y_tar - camera_get_view_y(ID)) * 0.1)
			);
		}
		else
			{ camera_set_view_pos(ID, x_tar, y_tar); }
		
		X[1] = camera_get_view_x(ID);
		Y[1] = camera_get_view_y(ID);
		X[2] = X[1] + camera_get_view_width(ID);
		Y[2] = Y[1] + camera_get_view_height(ID);
	}
	camera_set_begin_script(ID, self.cam_pos);
}

///Free bounding for main camera
function cam_free_bound()
{
	global.mcam.AreaX = [-infinity, infinity];
	global.mcam.AreaY = [-infinity, infinity];
}

///Bound main camera's move area so it would only move inside range of the room
function cam_room_bound()
{
	global.mcam.AreaX = [
		min(room_width / 2, global.mcam.W / 2),
		room_width - min(room_width / 2, global.mcam.W / 2)
	];
	global.mcam.AreaY = [
		min(room_height / 2, global.mcam.H / 2),
		room_height - min(room_height / 2, global.mcam.H / 2)
	];
}