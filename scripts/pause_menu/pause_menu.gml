function pause_menu() constructor
{
	//drawpage_Main = false;
	PauseOption = new option_pause();
	PauseOption.Visible = true;
	List = undefined;
	ItemAction = undefined;
	
	Finish = false;
	
	function page_Main()	// ITEM; STAT; CELL
	{
		//Select pause option
		var _s = PauseOption.Selector;
		PauseOption.choose_option(input("up"), input("down"), false, false);
		if (_s != PauseOption.Selector)
			{ audio_play_sound(sfx_squeak, 1000, false); }
		
		if input("deny") or input("menu")
		{
			audio_play_sound(sfx_squeak, 1000, false);
			
			PauseOption.Visible = false;
			
			obj_mainchara.moveable = true;
			obj_mainchara.interactable = true;
			
			Finish = true;
		}
		
		if input("accept")
		{
			audio_play_sound(sfx_select, 1000, false);
			switch PauseOption.Selector
			{
				case 0:	//ITEM
					page_Main_selectOption_ITEM();
					return;
				
				case 1:	//STAT
					page_Main_selectOption_STAT();
					return;
				
				//case 2:	//CELL
				//	List = new option_sprite_cursor(obj_mainchara.CELL);
				//	List.style(undefined, fnt_main, spr_heart);
				//	List.Border = [0, 0, 0, 0];
				//	List.place(global.mcam.X[1] + 104, global.mcam.Y[1] + 44);
				//	List.update_option();

				//	List.SpaceH = 16;
				//	List.TxtXoff = 12;
				//	List.TxtYoff = -4;
				
				//	PauseOption.Cursor = -1;
					
				//	update = page_Cell;
				//	drawPage = drawPage_Cell;
				//	return;
			}
		}
	}
	function page_Main_selectOption_ITEM()
	{
		if (array_length(obj_mainchara.ITEMS) == 0)
			{ return; }
		
		//Item's list
		List = new option_sprite_cursor([]);
		for (var i = 0; i < array_length(obj_mainchara.ITEMS); i++)
			{ List.List[i] = obj_mainchara.ITEMS[i].name(); }
		List.style(undefined, fnt_main, spr_heart);
		List.Border = [0, 0, 0, 0];
		List.place(global.mcam.X[1] + 104, global.mcam.Y[1] + 44);
		List.update_option();

		List.SpaceH = 16;
		List.TxtXoff = 12;
		List.TxtYoff = -2;
		
		ItemAction = new option_item_action();
					
		PauseOption.Cursor = -1;
					
		update = page_Item;
		drawPage = drawPage_Item;
	}
	function page_Main_selectOption_STAT()
	{
		PauseOption.Cursor = -1;
		
		update = page_Stat;
		drawPage = drawPage_Stat;
	}
	function page_Main_selectOption_CELL()
	{
	}
	
	function page_Item()
	{	
		//Select Item
		var _s = List.Selector;
		List.choose_option(input("up"), input("down"), false, false);
		if (_s != List.Selector)
			{ audio_play_sound(sfx_squeak, 1000, false); }
		
		if input("deny")		//To page_Main
		{
			audio_play_sound(sfx_squeak, 1000, false);
			PauseOption.Cursor = spr_heart;
			
			List.flush();	delete List;
			drawPage = undefined;
			update = page_Main;
			return;
		}
		
		if input("accept")	//To page_ItemAction
		{
			audio_play_sound(sfx_select, 1000, false);
			List.Cursor = -1;
			ItemAction.Cursor = spr_heart;
			
			update = page_ItemAction;
			return;
		}
	}
	function page_ItemAction()	//USE; INFO; DROP
	{
		//Select Actions
		var _s = ItemAction.Selector;
		ItemAction.choose_option(false, false, input("left"), input("right"));
		if (_s != ItemAction.Selector)
			{ audio_play_sound(sfx_squeak, 1000, false); }
		
		if input("deny")  //To page_Item
		{
			audio_play_sound(sfx_squeak, 1000, false);
			List.Cursor = spr_heart;
			ItemAction.Cursor = -1;
			
			update = page_Item;
		}
		
		if input("accept")  //Select action
		{
			switch ItemAction.Selector
			{
				case 0:	//USE
					page_ItemAction_selectOption_USE();
					break;
				
				case 1:	//INFO
					page_ItemAction_selectOption_INFO();
					break;
				
				case 2:	//DROP
					page_ItemAction_selectOption_DROP()
					break;
			}
			
			update = page_ItemText;
			drawPage = undefined;
			return;
		}
	}
	function page_ItemAction_selectOption_USE()
	{
		GeneralCtrl.textBox = new textbox(
			obj_mainchara.ITEMS[List.Selector].use()
		);
		
		delete obj_mainchara.ITEMS[List.Selector];
		array_delete(obj_mainchara.ITEMS, List.Selector, 1);
		
		//Play sound
		audio_play_sound(sfx_swallow, 1000, false);
		call_later(
			ceil(audio_sound_length(sfx_swallow) * game_get_speed(gamespeed_fps)) + 4,
			time_source_units_frames,
			function()
				{ audio_play_sound(sfx_heal_c, 1000, false); }
		);
	}
	function page_ItemAction_selectOption_INFO()
	{
		GeneralCtrl.textBox = new textbox(
			obj_mainchara.ITEMS[List.Selector].desc()
		);
	}
	function page_ItemAction_selectOption_DROP()
	{
		GeneralCtrl.textBox = new textbox(
			obj_mainchara.ITEMS[List.Selector].drop()
		);
		
		delete obj_mainchara.ITEMS[List.Selector];
		array_delete(obj_mainchara.ITEMS, List.Selector, 1);
	}
	function page_ItemText()
	{
		if (GeneralCtrl.textBox == undefined)
		{
			ItemAction.flush();
			delete ItemAction;
			
			List.flush();
			delete List;
						
			PauseOption.Cursor = spr_heart;
			PauseOption.Visible = false;
			
			obj_mainchara.moveable = true;
			obj_mainchara.interactable = true;
			
			Finish = true;
			return;
		}
	}
	
	function page_Stat()	//Simply show player's statistics
	{
		if input("deny")
		{
			audio_play_sound(sfx_squeak, 1000, false);
			PauseOption.Cursor = spr_heart;
			
			drawPage = undefined;
			update = page_Main;
			return;
		}
	}
	function page_Cell()	//Cellphone options
	{
		if input("deny")
		{
			audio_play_sound(sfx_squeak, 1000, false);
			PauseOption.Cursor = spr_heart;
			
			List.flush();	delete List;
			drawPage = undefined;
			update = page_Main;
			return;
		}
	}
	
	function drawPage_Item()	//Draw list of item and item options
	{
		//Holder
		draw_sprite_stretched(
			spr_holder, 0,
			global.mcam.X[1] + 94, global.mcam.Y[1] + 26,
			173, 181
		);
		
		//Item list
		if (List != undefined)
			{ List.draw_option(); }
		
		//USE; INFO; DROP
		if (ItemAction != undefined)
			{ ItemAction.draw_option(); }
	}
	function drawPage_Stat()	//Draw player's status
	{
		//Holder
		var camx = global.mcam.X[1], camy = global.mcam.Y[1];
		draw_sprite_stretched(spr_holder, 0, camx + 94, camy + 26, 173, 209);

		draw_set_font(fnt_main);
		
		with obj_mainchara
		{
			//Name
			draw_text(camx + 108, camy + 44, $"\"{NAME}\"");
		
			//Level (of violence)
			draw_text(camx + 108, camy + 74, "LV");
			draw_text(camx + 128, camy + 74, LV);
		
			//Healthpoint
			draw_text(camx + 108, camy + 90, "HP");
			draw_text(camx + 128, camy + 90, $"{HP[0]} / {HP[1]}");
		
			//Attack point
			draw_text(camx + 108, camy + 122, "AT");
			draw_text(camx + 128, camy + 122, $"{AT[0]} ({AT[1]})");
		
			//Defend point
			draw_text(camx + 108, camy + 138, "DF");
			draw_text(camx + 128, camy + 138, $"{DF[0]} ({DF[1]})");
		
			//Ex(ecution point)perience
			draw_text(camx + 192, camy + 122, $"EXP: {EXP[0]}");
		
			//Max EXP to leveled up
			draw_text(camx + 192, camy + 138, $"NEXT: {EXP[1]}");
		
			//Equipments
			var _str = !is_undefined(WEAPON) ? WEAPON.name() : "";
			draw_text(camx + 108, camy + 168, $"WEAPON: {_str}");
			_str = !is_undefined(ARMOR) ? ARMOR.name() : "";
			draw_text(camx + 108, camy + 184, $"ARMOR: {_str}");
		
			//Gold
			draw_text(camx + 108, camy + 202, $"GOLD: {G}");
		}
		draw_set_font(-1);
	}
	function drawPage_Cell()	//Draw list of person to call
	{
		//Holder
		draw_sprite_stretched(
			spr_holder, 0,
			global.mcam.X[1] + 94, global.mcam.Y[1] + 26,
			173, 181
		);
	}
	drawPage = undefined;
	
	//Main functions
	update = page_Main;
	
	function flush()
	{
		PauseOption.flush();
		delete PauseOption;
	}
		
	function draw()
	{
		//Draw pause menu
		if (PauseOption.Visible)
		{
			//Pause Option
			PauseOption.place(global.mcam.X[1] + 16, global.mcam.Y[1] + 84);
			PauseOption.draw_option();

			//Player's Status
			with obj_mainchara
			{
				var _x = global.mcam.X[1] + 16;
				var _y = global.mcam.Y[1] + (y > global.mcam.Y[1] + 160 ? 161 : 26);
				draw_sprite_stretched(spr_holder, 0, _x, _y, 71, 55);
				draw_set_font(fnt_main);
				draw_text(_x + 7, _y + 6, NAME);
				draw_set_font(fnt_small);
				draw_text(_x + 7, _y + 21, "LV");
				draw_text(_x + 25, _y + 21, LV);
				draw_text(_x + 7, _y + 30, "HP");
				draw_text(_x + 25, _y + 30, $"{HP[0]}/{HP[1]}");
				draw_text(_x + 7, _y + 39, "G");
				draw_text(_x + 25, _y + 39, G);
				draw_set_font(-1);
			}
		}
		
		//Pause Page
		if (drawPage != undefined)
			{ drawPage(); }
		
	}
	
	//end
}

///Custom option 1 (ITEM, STAT, CELL), Use ONLY for Pause Menu
function option_pause() : option_sprite_cursor([])
constructor
{
	List = [
		global.TextData.ITEM,
		global.TextData.STAT
		/*, "CELL"*/
	];
	Visible = false;
	
	Holder = sprite_duplicate(spr_holder);
	Cursor = spr_heart;
	
	Border = [12, 14, 0, 0];
	
	W = 71;
	H = 74;
	
	function draw_option_list()
	{
		var	txt_x = [OptX, OptX, OptX],
				txt_y = [OptY, OptY + 18, OptY + 36]
				;
		
		//Text
		draw_set_font(fnt_main);
		draw_set_halign(TxtHalign);
		draw_set_valign(TxtValign);
		
		//Cursor
		if sprite_exists(Cursor)
			{ draw_sprite(Cursor, 0, txt_x[Selector], txt_y[Selector]); }
		
		for (var i = 0; i < array_length(List); i++)
		{
			//Gray ITEMs (if inventory is empty)
			draw_set_color(
				(i == 0) and (array_length(obj_mainchara.ITEMS) == 0) ?
					#888888 : #ffffff
			);
				
			//Text
			draw_text(txt_x[i] + 14, txt_y[i] - 2, List[i]);
		}
			
		draw_set_font(noone);
		draw_set_color(c_white);
	}
}

///Custom option 2, (USE, INFO, DROP), Use ONLY for Pause Menu
function option_item_action() : option_sprite_cursor([])
constructor
{
	List = [
		global.TextData.USE,
		global.TextData.INFO,
		global.TextData.DROP
	];
	place(global.mcam.X[1] + 104, global.mcam.Y[1] + 184);
	
	//@Override
	function draw_option_list()
	{
		var	txt_x = [X, X + 48, X + 105],
				txt_y = [Y, Y, Y]
				;
		
		draw_set_font(fnt_main);
	
		//Cursor
		if sprite_exists(Cursor)
			{ draw_sprite(Cursor, 0, txt_x[Selector], txt_y[Selector]); }
		
		for (var i = 0; i < array_length(List); i++)
		{
			//Text
			draw_text(txt_x[i] + 12, txt_y[i] - 2, List[i]);
		}
			
		draw_set_font(-1);
	}
}
