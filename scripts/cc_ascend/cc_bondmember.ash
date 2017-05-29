script "cc_bondmember.ash"

void bond_initializeSettings()
{
	if(my_path() == "License to Adventure")
	{
		set_property("cc_100familiar", $familiar[Egg Benedict]);
		set_property("cc_getBeehive", true);
		set_property("cc_cubeItems", true);
		set_property("cc_getStarKey", true);
		set_property("cc_grimstoneOrnateDowsingRod", true);
		set_property("cc_holeinthesky", true);
		set_property("cc_useCubeling", true);
		set_property("cc_wandOfNagamar", false);
		set_property("choiceAdventure1261", 1);
	}
}


boolean bond_buySkills()
{
	if(my_path() != "License to Adventure")
	{
		return false;
	}
	return true;
}


boolean LM_bond()
{
	if(my_path() != "License to Adventure")
	{
		return false;
	}

	if(get_property("_cc_bondBriefing") == "finished")
	{
		return false;
	}

	if(get_property("_cc_bondBriefing") == "started")
	{
		boolean retval = ccAdv($location[Super Villain\'s Lair]);
		if(!retval)
		{
			set_property("_cc_bondBriefing", "finished");
		}
		return retval;
	}

	bond_buySkills();

	return false;
}

item[int] bondDrinks()
{
	item[int] retval = itemList();

	foreach it in $items[]
	{
		if((it.smallimage == "martini.gif") && is_unrestricted(it))
		{
			retval = retval.ListInsert(it);
		}
	}
	return retval;

}