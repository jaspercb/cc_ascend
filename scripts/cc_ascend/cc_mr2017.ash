script "cc_mr2017.ash"

#   This is meant for items that have a date of 2017.
#   Handling: Space Jellyfish

boolean getSpaceJelly();





boolean getSpaceJelly()
{
	if(get_property("_seaJellyHarvested").to_boolean())
	{
		return false;
	}
	if(!have_familiar($familiar[Space Jellyfish]))
	{
		return false;
	}
	if(my_level() < 11)
	{
		return false;
	}
	if(my_path() != "Standard")
	{
		if(!get_property("kingLiberated").to_boolean())
		{
			return false;
		}
	}

	if(internalQuestStatus("questS01OldGuy") < 0)
	{
		string temp = visit_url("oldman.php");
		temp = visit_url("place.php?whichplace=sea_oldman&action=oldman_oldman");
	}
	familiar old = my_familiar();
	use_familiar($familiar[Space Jellyfish]);
	string temp = visit_url("place.php?whichplace=thesea");
	temp = visit_url("place.php?whichplace=thesea&action=thesea_left2");
	temp = visit_url("choice.php?pwd=&whichchoice=1219&option=1");
	use_familiar(old);
	return true;
}
