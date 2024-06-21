function bsys_config_ruins_1()
{
	Monster[0] = new monster_takodachi();
	Monster[0].X = 106;
	Monster[0].Y = 54;
	
	BGM = bgm_battle1;
	
	function narrator()
	{
		return [
			global.TextData.battle_narrator_takodachi1
		];
	}
}

function bsys_config_ruins_2()
{
	Monster.Data = [
		new monster_takodachi(),
		new monster_takodachi(),
		new monster_takodachi()
	];
		
	BGM = choose(bgm_battle_custom, bgm_battle1);
	
	function narrator()
	{
		return [
			global.TextData.battle_narrator_takodachi2
		];
	}
}