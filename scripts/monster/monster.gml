enum MONSTER_STATE
{
	IDLE,
	HURT,
	SPARE,
	DIE
}

function monster() constructor
{
	X = 0;
	Y = 0;
	W = 0;
	H = 0;
	
	NAME = "UNDEFINED";
	HP = [1, 1];	//[Current, Max]
	
	ACT_option = ["* Check"];
	ACT_receive = -1;
	ACT_respond = ["* UNDEFINED - ATK ? DEF ?"];
	
	State = MONSTER_STATE.IDLE;
	Finish = false;
	
	function step()
	{
	}
	
	function draw()
	{
	}
}
