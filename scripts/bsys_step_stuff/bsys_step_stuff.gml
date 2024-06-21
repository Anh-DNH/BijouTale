function bsys_step_prologue()
{
	if instance_exists(obj_mainchara)
		{ encounterTriggerNum += (obj_mainchara.status & McStatus.MOVING); }
	if (encounterTriggerNum == encounterTriggerGoal)
	{
		bsys_step = bsys_step_intro;
		bsys_draw = bsys_draw_intro_1;
	}
}

//--	--		--		--		--//

function bsys_step_intro()
{
	obj_mainchara.flag = McFlag.DISABLE_ALL;
	GeneralCtrl.flag ^= GctrlFlag.PAUSE_MENU;
	
	audio_play_sound(sfx_battle_alarm, 1000, false);
	var func = [];
		
	func[0] = function()
	{ 
		audio_play_sound(sfx_test, 1000, false);
		Soul = instance_create_depth(
			((obj_mainchara.bbox_left + obj_mainchara.bbox_right) - sprite_get_width(spr_bsys_soul)) / 2,
			((obj_mainchara.bbox_top + obj_mainchara.bbox_bottom) - sprite_get_height(spr_bsys_soul)) / 2,
			-1000, obj_bsys_heart,
			{ image_speed : 0 }
		);
		
		bsys_draw = bsys_draw_intro_2;
		//draw = intro_Draw1;
	}
	func[1] = function()
		{ Soul.visible = false; }
	call_later(40 / delta_spd, time_source_units_frames, func[0]);
	call_later(44 / delta_spd, time_source_units_frames, func[1]);
		
	func[0] = function()
	{
		audio_play_sound(sfx_test, 1000, false);
		Soul.visible = true;
	}
	call_later(48 / delta_spd, time_source_units_frames, func[0]);
	call_later(52 / delta_spd, time_source_units_frames, func[1]);
		
	call_later(56 / delta_spd, time_source_units_frames, func[0]);
	call_later(60 / delta_spd, time_source_units_frames, func[1]);
		
	func[0] = function() //Soul start to move to FIGHT button
	{
		audio_play_sound(sfx_battle_fall, 1000, false);
		Soul.visible = true;
		bsys_step = bsys_step_MoveSoulToFIGHT;
		bsys_draw = bsys_draw_intro_3;
	}
	call_later(64 / delta_spd, time_source_units_frames, func[0]);
	
	bsys_step = function() {};
}

function bsys_step_MoveSoulToFIGHT()
{
	with Soul
	{
		var time = 0.5 * game_get_speed(gamespeed_fps);
		var x_goal = global.mcam.X[1] + 20;
		var xlen = x_goal - ((obj_mainchara.bbox_left + obj_mainchara.bbox_right) - sprite_get_width(spr_bsys_soul)) / 2;
		if (x != x_goal)
			{ x += min(abs(xlen) / time, abs(x_goal - x)) * sign(xlen); }
				
		var y_goal = global.mcam.Y[1] + 222;
		var ylen = y_goal - ((obj_mainchara.bbox_top + obj_mainchara.bbox_bottom) - sprite_get_height(spr_bsys_soul)) / 2;
		if (y != y_goal)
			{ y += min(abs(ylen) / time, abs(y_goal - y)) * sign(ylen); }
		
		if (x == x_goal) and (y == y_goal)
		{
			BattleSystem.bsys_step = bsys_step_StartBattle;
			BattleSystem.bsys_draw = bsys_draw_main;
		}
	}
}

function bsys_step_StartBattle()
{
	MoveArea.X1 = global.mcam.X[1] + 16;
	MoveArea.Y1 = global.mcam.Y[1] + 125;
	MoveArea.X2 = global.mcam.X[2] - 16;
	MoveArea.Y2 = global.mcam.Y[2] - 44;
		
	if (Sface.Alpha < 1)
	{
		//show_debug_message("Hello Abyss");
		Sface.Alpha += 0.25 / delta_spd;
	}
	else
	{
		Sface.Alpha = 1;
		audio_play_sound(BGM, 1000, true);
		bsys_step = bsys_step_Player_SelectAction;
	}
}

//--	--		--		--		--//

function bsys_step_Player_SelectAction()
{
	var _a = Action
	Action = clamp(Action + input("right") - input("left"), 0, 3);
	if (_a != Action)
		{ audio_play_sound(sfx_squeak, 1000, false); }
	
	var xpos = [20, 185 / 2 + 4, 345 / 2 + 4, 254];
	with Soul
	{
		x = global.mcam.X[1] + xpos[other.Action];
		y = global.mcam.Y[1] + 222;
	}
			
	Dialoguer ??= new textbox_battle(BattleSystem.narrator());
	Dialoguer.update();
			
	if input("accept")
	{
		delete Dialoguer;
		if (Action == PACTION.FIGHT) or (Action == PACTION.ACT)
		{
			var _name = [];
			for (var i = 0; i < array_length(Monster); i++)
				{ _name[i] = "* " + Monster[i].NAME; }
			Option = new option_battle(_name);
			bsys_step = bsys_step_Player_SelectMonster;
		}
		else if (Action == PACTION.ITEM) 
		{
			var itemName = [];
			for (var i = 0; i < array_length(obj_mainchara.ITEMS); i++)
				{ itemName[i] = "* " + obj_mainchara.ITEMS[i].name(true); }
			Option = new option_battle_item(itemName);
			bsys_step = bsys_step_Player_ITEM_Option;
		}
		else if (Action == PACTION.MERCY) 
		{
			Option = new option_battle(["* Spare", "* Flee"]);
			bsys_step = bsys_step_Player_MERCY_Option;
		}
		
		audio_play_sound(sfx_select, 1000, false);
	}
}
	
function bsys_step_Player_SelectMonster()
{
	with Option
	{
		choose_option(input("up"), input("down"), false, false);
				
		other.Soul.x = OptX - 18;
		other.Soul.y = OptY + (Selector * SpaceH) + 2;
	}
			
	if input("accept")
	{
		Mselector = Option.Selector;
		Option = undefined;
		
		if (Action == PACTION.FIGHT)	
		{
			Targeter = new bsys_targeter_default();
			bsys_step = bsys_step_Player_FIGHT_Targeter;
		}
		else if (Action == PACTION.ACT)	
		{
			Option = new option_battle_2column(
				Monster[Mselector].ACT_option
			);
			bsys_step = bsys_step_Player_ACT_Option;
		}
		audio_play_sound(sfx_select, 1000, false);
	}
	else if input("deny")
	{
		Option = undefined;
		bsys_step = bsys_step_Player_SelectAction;
	}
}
		
function bsys_step_Player_FIGHT_Targeter()
{
	Soul.visible = false;
	Targeter.action();
	
	if (Targeter.Power != -1)
	{
		DamageDealer = new bsys_DamageDealer(
			Monster[Mselector],
			round(Targeter.Power * 19)
		);
		Targeter.Power = -1;
	}
	
	if Targeter.Finish
		{ bsys_step = bsys_step_Enemy_TextBubble; }
}

function bsys_step_Player_ACT_Option()
{
	with Option
	{
		choose_option(input("up"), input("down"), input("left"), input("right"));
				
		other.Soul.x = OptX + ((Selector mod Column) * SpaceW) - 18;
		other.Soul.y = OptY + ((Selector div Column) * SpaceH) + 2;
	}
	
	if input("deny")
	{
		Option = undefined;
		var _name = [];
		for (var i = 0; i < array_length(BattleSystem.Monster); i++)
			{ _name[i] = "* " + BattleSystem.Monster[i].NAME; }
		Option = new option_battle(_name);
				
		bsys_step = bsys_step_Player_SelectMonster;
	}
}
		
function bsys_step_Player_ITEM_Option()
{
	with Option
	{
		choose_option(input("up"), input("down"), input("left"), input("right"));
				
		other.Soul.x = OptX + (((Selector - (Page * 4)) mod Column) * SpaceW) - 18;
		other.Soul.y = OptY + (((Selector - (Page * 4)) div Column) * SpaceH) + 2;
	}
				
	if input("deny")
	{
		Option = undefined;
		bsys_step = bsys_step_Player_SelectAction;
	}
}

function bsys_step_Player_MERCY_Option()
{	
	with Option
	{
		self.choose_option(input("up"), input("down"), false, false);
				
		other.Soul.x = OptX - 18;
		other.Soul.y = OptY + (Selector * SpaceH) + 2;
	}
	
	if input("accept")
	{
		if (Option.Selector == 0) // * Spare
			{ /*update = bsys_step_Player_SelectAction;*/ }
		else if (Option.Selector == 1) // * Flee
		{
			audio_play_sound(sfx_escape, 1000, false);
			Dialoguer = choose(
				global.TextData.battle_flee1,
				global.TextData.battle_flee2
			);
			bsys_step = bsys_step_outro_flee;
		}
		
		Option = undefined;
	}
	else if input("deny")
	{
		Option = undefined;
		bsys_step = bsys_step_Player_SelectAction;
	}
}

//--	--		--		--		--//

function bsys_step_Enemy_TextBubble()
{
	Soul.visible = true;
	Soul.x = (MoveArea.X1 + MoveArea.X2) / 2;
	Soul.y = (MoveArea.Y1 + MoveArea.Y2) / 2;
	if !is_undefined(Targeter)
	{
		Targeter.action();
		if Targeter.Close
			{ delete Targeter; }
	}
}

function bsys_step_Enemy_Attack()
{
	
}

//--	--		--		--		--//

function bsys_step_outro_flee()
{
	with Soul
	{
		sprite_index = spr_bsys_soul_leg;
		image_speed = 1.8;
		x -= 1.5;
				
		if (x < global.mcam.X[1] - abs(sprite_width))
			{ BattleSystem.bsys_step = bsys_step_outro_HideBattle; }
	}
}
		
function bsys_step_outro_HideBattle()
{
	if (Sface.Alpha == 0)
	{
		instance_destroy(Soul);
		obj_mainchara.flag = McFlag.ENABLE_ALL;
		GeneralCtrl.flag ^= GctrlFlag.PAUSE_MENU;
		
		bsys_draw = bsys_draw_outro;
	}
			
	if (Sface.Alpha > -1)
	{
		Sface.Alpha -= 0.25 / delta_spd;
		audio_sound_gain(BattleSystem.BGM, max(Sface.Alpha, 0), 0);
	}
	else
		{ bsys_step_epilogue(); }
}

//--	--		--		--		--//

function bsys_step_epilogue()
{
	Sface.Alpha = -1;
	audio_sound_gain(BattleSystem.BGM, 1, 0);
	audio_stop_sound(BattleSystem.BGM);
		
	Dialoguer = undefined;
	Option = undefined;	
	Action = 0;
	MoveArea = { X1 : 0, Y1 : 0, X2 : 0, Y2 : 0 }
	bsys_step = bsys_step_prologue;
	bsys_draw = function() {};
	
	Monster = [];
	BGM = choose(bgm_battle_custom, bgm_battle1);//-1;
	
	encounterTriggerNum = 0;
	encounterTriggerGoal += irandom_range(15, 27);
	
	config();
}