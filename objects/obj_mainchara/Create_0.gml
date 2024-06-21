if !instance_unique()
	{ return; }

enum McFlag
{
	MOVEABLE		= 0b_01,
	INTERACTABLE	= 0b_10,
	
	ENABLE_ALL		= 0b_11,
	DISABLE_ALL		= 0b_00,
}

enum McStatus
{
	IDLE			= 0b_00,
	
	MOVING			= 0b_01,
	INTERACTING		= 0b_10,
}

if !instance_unique()
	{ return; }

flag = McFlag.ENABLE_ALL;
status = McStatus.IDLE;

NAME = "Bijou";

HP		=	[1, 20];	//[Current, Max]
LV		=	1;
EXP		=	[0, 10];	//[Current, Next]
G		=	0;
AT		=	[0, 0];		//[Player's attack point, weapon's additional point]
DF		=	[0, 0];		//[Player's defend point, armor's additional point]
WEAPON	= new item_wpn_stick();	/*new item_wpn_stick();*/
ARMOR	= undefined;				/*new item_arm_bandage();*/
ITEMS	= [
	new item_wpn_stick(),
	new item_monstercandy(),
	new item_monstercandy(),
	new item_spiderdonut(),
	new item_spidercider(),
	new item_spiderdonut(),
	new item_spidercider()
];
CELL = [];

animSPR = [
	spr_biboo_w0,	// 0 / 90 = 0 -> Left
	spr_biboo_w1,		// 90 / 90 = 1 -> Up
	spr_biboo_w2,		// 180 / 90 = 2 -> Right
	spr_biboo_w3		// 270 / 9 = 3 -> Down
];

//Direction
tarDir = 270;
plyDir = 270;
spinDir = 270;
hSide = 1;
vSide = 1;

//Interaction
//interactS = false;	// S stands for Status
interactX = x;
interactY = y;

//Layer
if !layer_exists("BijouLayer")
	{ layer = layer_create(0, "BijouLayer"); }

global.mcam.Follower = id;








