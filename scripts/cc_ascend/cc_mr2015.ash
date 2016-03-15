script "cc_mr2015.ash"

import<cc_ascend/cc_adventure.ash>

boolean cc_barrelPrayers();



//Supplemental





boolean cc_barrelPrayers()
{
	if(!is_unrestricted($item[Shrine to the Barrel God]))
	{
		return false;
	}
	if(get_property("_barrelPrayer").to_boolean())
	{
		return false;
	}
	if(!get_property("barrelShrineUnlocked").to_boolean())
	{
		string temp = visit_url("da.php");
		if(!get_property("barrelShrineUnlocked").to_boolean())
		{
			return false;
		}
	}
	if(get_property("kingLiberated").to_boolean())
	{
		return false;
	}

	boolean[string] prayers;

	if(my_path() == "Avatar of West of Loathing")
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Glamour, Vigor, Protection];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}
	else if(my_path() == "Community Service")
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Glamour, Vigor, Protection];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}
	else
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}

	foreach prayer in prayers
	{
		if(!get_property("prayedFor" + prayer).to_boolean())
		{
			boolean buff = cli_execute("barrelprayer " + prayer);
			return true;
		}
	}

	return false;
}