function trigger_cond_auto()
{
	return true;
}

function trigger_cond_player_touch()
{
	return place_meeting(x, y, obj_mainchara);
}

function trigger_cond_player_pos_inside()
{
	return position_meeting(x, y, obj_mainchara);
}

function trigger_cond_player_interact()
{
	return (obj_mainchara.status & McStatus.INTERACTING)
	and position_meeting(obj_mainchara.interactX, obj_mainchara.interactY, id);
}
