#region Camera
	
	view_enabled = true;
	view_set_visible(global.mcam.ID, true);
	global.mcam.cam_size();
	camera_set_begin_script(global.mcam.ID, global.mcam.cam_pos);
	cam_room_bound();
	
#endregion












