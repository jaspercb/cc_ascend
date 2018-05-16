script "cc_glover.ash"


void glover_initializeDay(int day)
{
}

void glover_initializeSettings()
{
	if(cc_my_path() == "G-Lover")
	{
		set_property("cc_ballroomsong", "finished");
		set_property("cc_getBeehive", false);
		set_property("cc_getBoningKnife", false);
		set_property("cc_cubeItems", true);
		set_property("cc_dakotaFanning", true);
		set_property("cc_getStarKey", true);
		set_property("cc_grimstoneOrnateDowsingRod", false);
		set_property("cc_holeinthesky", true);
		set_property("cc_ignoreFlyer", true);
		set_property("cc_shenCopperhead", true);
		set_property("cc_spookyfertilizer", "finished");
		set_property("cc_spookymap", "finished");
		set_property("cc_spookysapling", "finished");
		set_property("cc_swordfish", "finished");
		set_property("cc_treecoin", "finished");
		set_property("cc_useCubeling", true);
		set_property("cc_wandOfNagamar", true);
	}
}

boolean glover_usable(string it)
{
	if(cc_my_path() != "G-Lover")
	{
		return true;
	}
	if(contains_text(it, "g"))
	{
		return true;
	}
	if(contains_text(it, "G"))
	{
		return true;
	}
	return false;
}

boolean LM_glover()
{
	foreach it in $items[Turtle Wax]
	{
		if(item_amount(it) > 0)
		{
			put_closet(item_amount(it), it);
		}
	}
	return false;
}
