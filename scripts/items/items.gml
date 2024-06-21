//Template
function item() constructor
{
	function name(short = false)
		{ return !short ? "undefined" : "undf"; }
	
	function desc()
		{ return "* I feel a disturbance in,<mononextline()><diagtab()>the code."; }
	
	function use()
		{ return "Nothing happened..." }
	
	function drop()
		{ return string(global.TextData.drop_item_def, name()); }
}



function item_monstercandy() : item()
constructor
{
	function name(short = false)
	{
		return	!short ?
				global.TextData.item_1_name0 :
				global.TextData.item_1_name1;
	}
	
	function desc()
		{ return global.TextData.item_1_desc; }
	
	function use()
	{
		with obj_mainchara
		{
			var prevHP = HP[0];
			HP[0] += min(HP[1] - HP[0], 10);
		
			var rnum = irandom(100);
			
			return	global.TextData.item_1_use0 +
					(rnum == clamp(rnum, 50, 90) ? global.TextData.item_1_use1 : "") +
					(rnum > 90 ? global.TextData.item_1_use2 : "") +
					(HP[0] == HP[1] ? global.TextData.max_hp : string(global.TextData.recovered_hp, 10))
					;
		}
	}
}

function item_spiderdonut() : item()
constructor
{
	function name(short = false)
		{ return !short ? global.TextData.item_7_name0 : global.TextData.item_7_name1; }
	
	function desc()
		{ return global.TextData.item_7_desc; }
	
	function use()
	{
		with obj_mainchara
		{
			var prevHP = HP[0];
			HP[0] += min(HP[1] - HP[0], 10);
		
			var rnum = irandom(100);
			
			return	global.TextData.item_7_use0 +
						(irandom(100) > 50 ? global.TextData.item_7_use1 : "") +
						(HP[0] == HP[1] ? global.TextData.max_hp : string(global.TextData.recovered_hp, 10))
						;
		}
	}
}

function item_spidercider() : item()
constructor
{
	function name(short = false)
		{ return !short ? global.TextData.item_10_name0 : global.TextData.item_10_name1; }
	
	function desc()
		{ return global.TextData.item_10_desc; }
	
	function use()
	{
		with obj_mainchara
		{
			var prevHP = HP[0];
			HP[0] += min(HP[1] - HP[0], 24);
			
			return	global.TextData.item_10_use0 + 
						(HP[0] == HP[1] ? global.TextData.max_hp : string(global.TextData.recovered_hp, 24))
						;
		}
	}
}
