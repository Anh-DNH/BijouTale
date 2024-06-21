var	sprint = false,
		//sprint = input("shift", 1),	//Uncomment this line for sprinting feature
		spd = 1.5 * delta_spd
		;

var	vInput = input("down", 1) - input("up", 1),
		vSpd = vInput * (spd + sprint)
		;

var	hInput = input("right", 1) - input("left", 1),
		hSpd = hInput * (spd + sprint)
		;

#region Levelling platfrom

	if position_meeting(x, y, area_levelling)
	and (hInput != 0)
	{
		var lvllingID = instance_position(x, y, area_levelling);
		var len = hInput * (spd + sprint);
		hSpd = lengthdir_x(len, lvllingID.move_angle);
		vSpd = lengthdir_y(len, lvllingID.move_angle) + (vInput * (spd + sprint));
	}

#endregion

#region Block collision
	
	if place_meeting(x + hSpd, y, area_solid)
	{
		while !place_meeting(x + sign(hSpd), y, area_solid)
			{ x += sign(hSpd); }
		hSpd = 0; hInput = 0;
		vInput = input("down", 1) - input("up", 1);
	}
	
	if place_meeting(x, y + vSpd, area_solid)
	{
		while !place_meeting(x, y + sign(vSpd), area_solid)
			{ y += sign(vSpd); }
		vSpd = 0; vInput = 0;
		hInput = input("right", 1) - input("left", 1);
	}

#endregion

#region Slope Collision

	if place_meeting(x + hSpd, y + vSpd, area_slope)
	{
		var slopeID = instance_place(x + hSpd, y + vSpd, area_slope);
		var x_slope = sign(slopeID.image_xscale);
		var y_slope = sign(slopeID.image_yscale);
		
		x += (x_slope + hInput) * (spd + sprint);
		y += (y_slope + vInput) * (spd + sprint);
		
		if (hInput == -x_slope) and (vInput == -y_slope)
			{ hSpd = 0; vSpd = 0; }
	}

#endregion Somehow I eliminated the Frisk dance glitch... Should I be happy or sad about this?

#region Movement

if !(flag & McFlag.MOVEABLE)
	{ hInput = 0; vInput = 0; hSpd = 0; vSpd = 0; }

//Position
x += hSpd;
y += vSpd;
status =	(x - xprevious != 0) or (y - yprevious != 0) ?
			status | McStatus.MOVING :
			status & ~McStatus.MOVING
			;
var moving = status & McStatus.MOVING;

#endregion

#region Interaction
interactX = (bbox_left + bbox_right) / 2 + lengthdir_x((bbox_right - bbox_left + 2) / 2, plyDir);
interactY = (bbox_top + bbox_bottom) / 2 + lengthdir_y((bbox_bottom - bbox_top + 2) / 2, plyDir);

status =	input("accept") and flag & McFlag.INTERACTABLE ? 
			status | McStatus.INTERACTING :
			status & ~McStatus.INTERACTING
			;

#endregion

#region Animation

hSide = (hInput != 0) ? hInput : hSide;
vSide = (vInput != 0) ? vInput : vSide;

var angle = 360 div array_length(animSPR);
if (hInput != 0) or (vInput != 0)
{
	//----------------Get direction----------------//
	tarDir = point_direction(0, 0, hInput, vInput);
	var funkyDir = 360 - (angle / 2);
	
	var dirMinRad = max(plyDir - (angle / 2), 0);
	var dirMaxRad = plyDir + (angle / 2);
			
	if (tarDir == funkyDir)
		{ plyDir = (plyDir > funkyDir - 180) ? 360 - angle : 0; }
	else if (tarDir != clamp(tarDir, dirMinRad, dirMaxRad))
		{ plyDir = tarDir == 360 ? 0 : (tarDir div angle) * angle; }
}

sprite_index = animSPR[plyDir div angle];
image_index = moving * image_index;
image_speed = moving * 1;


#endregion

layer_depth(layer, -y);











