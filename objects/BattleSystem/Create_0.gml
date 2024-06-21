enum PACTION
{
	FIGHT,
	ACT,
	ITEM,
	MERCY
}
Action = PACTION.FIGHT;

Soul = noone;

Dialoguer = undefined;
Option = undefined;

Targeter = undefined;
DamageDealer = undefined;

MoveArea = { X1 : 0, Y1 : 0, X2 : 0, Y2 : 0 }
Sface = { ID : -1, Alpha : 0 }

Monster = [];
Mselector = 0;
BGM = -1;

encounterTriggerNum	= 0;
encounterTriggerGoal = irandom_range(130, 150);

function narrator()
	{ return []; }

config();

bsys_step = bsys_step_prologue;
bsys_draw = function() {};
