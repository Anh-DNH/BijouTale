/*
								---OPTION SYSTEM---								
					(quick and easy way to create a option)
	This system was designed for quick and easy use for beginner user
	and allow modificitation and enhancement for expert GameMaker user.
*/

///Basic features allow you to choose, select and draw options with holder and highlighted selector.
//@author AnhDNH
function option_default(array_string) constructor
{
	//Read the "Attribute" and "Method" region to gain supreme power
	
	#region Attributes (Recommended reading through all of this)
	
		List		= array_string;		//-	List of string to create a option
		Selector	= 0;					//-	This small fella helps you select ption, as well as tells
											//	draw method to highlight selecting option
		Column	= 1;					//-	Set how many collum you want for your option
		
		Line		= 1;					//-	This one will auto-generate base on collum and list's length so
											//	you don't need to change this
											
		Font		= draw_get_font();	//-	Set font for your option
		
		X			= -999;				//-	X position of the option in room
		Y			= -999;				//-	Y position of the option in room
											//	(Changing is NOT recommended, use method place(x, y) instead);
											
		W			= -999;				//-	Width of your option (Changing is NOT recommended)
		H			= -999;				//-	Height of your option (Changing is NOT recommended)
		
		Holder	= -1;					//-	This one holds sprite asset to draw at the background
		Border	= [4, 4, 4, 4];		//-	Size of your holder's border (left, right, top, bottom)
		Halign		= fa_left;				//-	Horizontal alignment for your option
		Valign		= fa_top;				//-	Vertical alignment for your option
		
		
		OptX		= 0;					//-	X coordinate of your text table
		OptY		= 0;					//-	Y coordinate of your text table
											//	(Changing is NOT recommended, unless you want to make 4th wall breaking stuff)
											//	(Even if you want to do that. I cannot guaranteed a good-looking result)
											
		TxtSize	= 1;					//-	Size of your option's text
		TxtCol	= c_white;				//-	Color of your text
		TxtHalign = fa_left;				//-	Horizontal alignment for your text
		TxtValign = fa_top;				//-	Vertical alignment for your text
		TxtXoff	= 0;					//- X offset of the text
		TxtYoff	= 0;					//- Y offset of the text
											
		SpaceW	= 0;					//-	Width of evey single options of the option
		SpaceH	= 0;					//-	Height of evey single options of the option
		
	#endregion
	
	#region Methods
		
		//Resizing SpaceW and SpaceH
		//(Not recommended using outside)
		function resize_text_area()
		{
			//Get the longest string to decide the width and height of the text
			var longestStr = "", strW = 0, strH = 0;
	
			draw_set_font(Font);
	
			for (var i = 0; i < array_length(List); i++)	//Searching for the longest string
			{
				if (strW <= string_width(List[i]) * TxtSize)
					{ longestStr = List[i]; }
				
				strW = string_width(longestStr) * TxtSize;
				strH = string_height(longestStr) * TxtSize;
			}
	
			//Set width and height for the text space
			SpaceW =	strW;
			SpaceH = strH;
	
			draw_set_font(noone);
		}
	
		///Call this method whenever you changed something,
		///As it will update anything left
		function update_option()
		{
			Column = max(Column, 1);
			Line = ceil(array_length(List) / Column);
			
			resize_text_area();
			SpaceW += 5;
			SpaceH += 2;
		
			W = (SpaceW * Column) + (Border[0] + Border[1]);
			H = (SpaceH * Line) + (Border[2] + Border[3]);
		
			OptX = X + Border[0];
			OptY = Y + Border[1];
		
			Selector = clamp(Selector, 0, array_length(List) - 1);
		}
		
		///Call this method before you use keyword "delete" to
		///delete the option.
		function flush()
		{
			if sprite_exists(Holder)
				{ sprite_delete(Holder); }
		}
		
		/**
		Set Holder, Font for your option
		@arg {Asset.GMSprite}		[holder]	Holder's sprite
		@arg {Asset.GMFont}		[font]		Option's font
		**/
		function style(_holder, _font)
		{
			if (_holder != undefined) and sprite_exists(_holder)
			{
				if sprite_exists(Holder)
					{ sprite_delete(Holder); }
				Holder = sprite_duplicate(_holder);
				var nslice = sprite_get_nineslice(Holder);
				Border = [nslice.left, nslice.right, nslice.top, nslice.bottom];
			}
			
			Font = is_undefined(_font) and font_exists(_font) ? Font : _font;
		}
		
		/**
		 Set option's position inside room (Or the game's screen if you're using Draw GUI)
		 @arg {Real} x		x coordinate to draw
		 @arg {Real} y		x coordinate to draw
		**/
		function place(x, y)
		{
			X = x - ((W / 2) * Halign);
			Y = y - ((H / 2) * Valign);
		
			OptX = X + Border[0];
			OptY = Y + Border[1];
		}
		
		/**
		 Allows you to change Selector via 4 input.
		 @arg {Bool} up		
		 @arg {Bool} down	
		 @arg {Bool} left
		 @arg {Bool} right
		 @return {Real}
		**/
		//Supply those with keyboard_check_pressed(...) for example
		function choose_option(up, down, left, right)
		{
			//4-buttons input
			var hInput,vInput;
			hInput = right - left;
			vInput = down - up;
			Selector = clamp(Selector + hInput + (vInput * Column), 0, array_length(List) - 1);
	
			return real(Selector);
		}
		
		/**
		 Allows you to change Selector via mouse selection.
		 @return {Real}
		**/
		function choose_option_by_mouse()
		{
			if mouse_in_rectangle(X, Y, 0, 0, W, H)
			{
				var cellX = min(max(mouse_x - OptX, 0) div SpaceW, Column - 1);
				var cellY = min(max(mouse_y - OptY, 0) div SpaceH, Line - 1);
				
				Selector = cellX + (cellY * Column);
			}
			
			return real(Selector);
		}
		
		//Draw the holder
		//(Not recommended using outside)
		function draw_holder()
		{
			if sprite_exists(Holder)
			{
				//var nslice	=	sprite_get_nineslice(Holder);
				//nslice.left		=	clamp(ceil(W / 2), 0, Border[0]);
				//nslice.right	=	clamp(floor(W / 2), 0, Border[1]);
				//nslice.top		=	clamp(ceil(H / 2), 0, Border[2]);
				//nslice.bottom	=	clamp(floor(H / 2), 0, Border[3]);
				draw_sprite_stretched(Holder, 0, X, Y, W, H);
			}
		}
		
		//Draw list table
		//(Not recommended using outside)
		function draw_option_list()
		{
			var	txt_x = array_create(array_length(List), OptX),
					txt_y = array_create(array_length(List), OptY)
					;
					
			//Text
			draw_set_font(Font);
			draw_set_color(TxtCol);
			draw_set_halign(TxtHalign);
			draw_set_valign(TxtValign);
	
			for (var i = 0; i < array_length(List); i++)
			{
				//Text positioning
				if ( txt_x[i] >= OptX + (SpaceW * (Column - 1)) )
				{
					txt_x[i + 1] = txt_x[0];
					txt_y[i + 1] = txt_y[i] + SpaceH;
				}
				else
				{
					txt_x[i + 1] = txt_x[i] + SpaceW;
					txt_y[i + 1] = txt_y[i];
				}
				
				//Texts
				var txt_w = (string_width(List[i]) * TxtSize);
				draw_text_transformed(
					//txt_x[i]/* + sprite_get_width(Cursor)*/ + 5,
					txt_x[i] + ((SpaceW / 2) * TxtHalign) + TxtXoff,
					txt_y[i] + ((SpaceH / 2) * TxtValign) + TxtYoff,
					List[i],
					TxtSize, TxtSize,
					0
				);
				
				//Highlight
				if (Selector == i)
				{
					//draw_set_font(fnt)
					draw_set_alpha(abs(sin(get_timer() / 400_000)));
					draw_rectangle(
						txt_x[i], txt_y[i],
						txt_x[i] + SpaceW - 1,
						txt_y[i] + SpaceH - 1,
						false
					);
					draw_set_alpha(1);
				}
				
				//End
			}
			
			draw_set_font(-1);
			draw_set_color(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		
		///Draw the option onto screen
		function draw_option()
		{
			if (array_length(List) != 0)
			{
				draw_holder();
				draw_option_list();
			}
		}
		
	#endregion
}

///Custom option that replace highlight bar with sprite
//@author AnhDNH
function option_sprite_cursor(array_string) : option_default(array_string)
constructor
{
	#region Attributes
		
		Cursor = noone;		//-	Sprite
		
		CursorX = 0;			//-	X coordinate of the cursor
		CursorY = 0;			//-	Y coordinate of the cursor
								//	(DON'T CHANGE THESE)
	
	#endregion
	
	/**
	 Set Holder, Font, Cursor for your option
	 @arg {Asset.GMSprite}		[holder]	Holder's sprite
	 @arg {Asset.GMFont}			[font]		Option's font
	 @arg {Asset.GMSprite}		[cursor]	Cursor's sprite
	**/
	//@Override
	function style(_holder, _font, _cursor)
	{
		if (_holder != undefined) and sprite_exists(_holder)
		{
			if sprite_exists(Holder)
				{ sprite_delete(Holder); }
			Holder = sprite_duplicate(_holder);
			var nslice = sprite_get_nineslice(Holder);
			Border = [nslice.left, nslice.right, nslice.top, nslice.bottom];
		}
		Font = is_undefined(_font) and font_exists(_font) ? Font : _font;
		Cursor =	is_undefined(_cursor) and sprite_exists(_cursor) ? Cursor : _cursor;
	}
	
	///Call this method whenever you changed something
	//@Override
	function update_option()
	{
		Column = max(Column, 1);
		Line = ceil(array_length(List) / Column);
			
		resize_text_area();
		SpaceW += sprite_get_width(Cursor) + 2;
		SpaceH = max(sprite_get_height(Cursor), SpaceH) + 2;
		TxtXoff = sprite_get_width(Cursor) + 2;
		
		W = (SpaceW * Column) + (Border[0] + Border[1]);
		H = (SpaceH * Line) + (Border[2] + Border[3]);
		
		OptX = X + Border[0];
		OptY = Y + Border[1];
		
		Selector = clamp(Selector, 0, array_length(List) - 1);
	}
	
	//@Override
	function draw_option_list()
	{
		var	txt_x = array_create(array_length(List), OptX),
				txt_y = array_create(array_length(List), OptY)
				;
		
		//Text
		draw_set_font(Font);
		draw_set_color(TxtCol);
		draw_set_halign(TxtHalign);
		draw_set_valign(TxtValign);
	
		for (var i = 0; i < array_length(List); i++)
		{
			//Text positioning
			if txt_x[i] >= OptX + (SpaceW * (Column - 1))
			{
				txt_x[i + 1] = txt_x[0];
				txt_y[i + 1] = txt_y[i] + SpaceH;
			}
			else
			{ 
				txt_x[i + 1] = txt_x[i] + SpaceW;
				txt_y[i + 1] = txt_y[i];
			}
			
			//*Cursor (Replace highlight)
			if (Selector == i) and sprite_exists(Cursor)
			{
				CursorX = txt_x[Selector] + Border[0];
				CursorY = txt_y[Selector] + Border[1];
				draw_sprite(Cursor, 0, CursorX, CursorY);
			}
			//*/
			
			//Texts
			//var txt_w = (string_width(List[i]) * TxtSize);
			draw_text_transformed(
				txt_x[i] + ((SpaceW / 2) * TxtHalign) + TxtXoff,
				txt_y[i] + ((SpaceH / 2) * TxtValign) + TxtYoff,
				List[i],
				TxtSize, TxtSize,
				0
			);
		}
			
		draw_set_font(noone);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}
