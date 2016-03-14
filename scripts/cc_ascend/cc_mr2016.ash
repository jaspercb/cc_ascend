script "cc_mr2016.ash"

import<cc_ascend/cc_adventure.ash>

boolean cc_advWitchess(string target);
boolean cc_haveWitchess();


//Supplemental
int cc_advWitchessTargets(string target);


boolean cc_haveWitchess()
{
	if(!is_unrestricted($item[Witchess Set]))
	{
		return false;
	}
	return (get_campground() contains $item[Witchess Set]);
}

boolean cc_advWitchess(string target)
{
	if(!cc_haveWitchess())
	{
		return false;
	}

	int goal = cc_advWitchessTargets(target);
	if(goal == 0)
	{
		return false;
	}

	//Tracking Stuff (Someday we can remove this).
	if(my_daycount() != get_property("cc_witchessBattleDay").to_int())
	{
		set_property("cc_witchessBattles", 0);
		set_property("cc_witchessBattleDay", my_daycount());
	}

	if(get_property("cc_witchessBattles").to_int() >= 5)
	{
		return false;
	}
	set_property("cc_witchessBattles", get_property("cc_witchessBattles").to_int() + 1);

	string[int] pages;
	pages[0] = "campground.php?action=witchess";
	pages[1] = "choice.php?whichchoice=1181&pwd=&option=1";
	pages[2] = "choice.php?pwd=" + my_hash() + "&whichchoice=1182&option=1&piece=" + goal;

	// We use 4 to cause pages[2] to use GET.
	return ccAdvBypass(4, pages, $location[Noob Cave], "");
}


int cc_advWitchessTargets(string target)
{
	target = to_lower_case(target);
	if((target == "knight") || (target == "meat") || (target == "food"))
	{
		return 1936;
	}
	if((target == "pawn") || (target == "spleen") || (target == "init"))
	{
		return 1935;
	}
	if((target == "bishop") || (target == "item") || (target == "booze"))
	{
		return 1942;
	}
	if((target == "rook") || (target == "ml") || (target == "stats"))
	{
		return 1938;
	}

	if((target == "ox") || (target == "ox-head shield") || (target == "shield") || (target == "pvp") || (target == "hp") || (target == "resist") || (target == "resistance"))
	{
		return 1937;
	}

	if((target == "king") || (target == "dented scepter") || (target == "scepter") || (target == "club") || (target == "muscle") || (target == "hpregen"))
	{
		return 1940;
	}

	if((target == "witch") || (target == "battle broom") || (target == "broom") || (target == "myst") || (target == "mpregen") || (target == "spell"))
	{
		return 1941;
	}

	if((target == "queen") || (target == "very pointy crown") || (target == "crown") || (target == "adv") || (target == "moxie") || (target == "nc") || (target == "noncombat") || (target == "non-combat"))
	{
		return 1939;
	}



	return 0;
}
