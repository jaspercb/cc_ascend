script "cc_groundhog.ash"

void groundhog_initializeSettings()
{
	if(cc_my_path() == "Live. Ascend. Repeat.")
	{
		set_property("cc_ballroomsong", "finished");
		set_property("cc_cubeItems", true);
		set_property("cc_getStarKey", true);
		set_property("cc_grimstoneOrnateDowsingRod", false);
		set_property("cc_holeinthesky", true);
		set_property("cc_useCubeling", true);
		set_property("cc_wandOfNagamar", true);
	}
}

boolean groundhogSafeguard()
{
	if(cc_my_path() == "Live. Ascend. Repeat.")
	{
		string repeats = get_property("lastEncounter");
		if((repeats == "Skull, Skull, Skull") || (repeats == "Urning Your Keep") || (repeats == "Turn Your Head and Coffin") || (repeats == "Curtains") || (repeats == "There's No Ability Like Possibility") || (repeats == "Putting Off Is Off-Putting") || (repeats == "Huzzah!"))
		{
			if(get_property("_cc_groundhogSkip").to_int() == my_turncount())
			{
				set_property("_cc_groundhogSkipCounter", get_property("_cc_groundhogSkipCounter").to_int()+1);
			}
			if(get_property("_cc_groundhogSkipCounter").to_int() > 6)
			{
				abort("You have a non-combat that can infinitely loop and we are going to infintely loop on it like a groundhog. Maybe you should spend this adventure somewhere to ease the pain for all of us.");
			}
			set_property("_cc_groundhogSkip", my_turncount());
		}
		else
		{
			set_property("_cc_groundhogSkipCounter", 0);
			set_property("_cc_groundhogSkip", -1);
		}
	}
	return false;
}

boolean canGroundhog(location loc)
{
	if(cc_my_path() == "Live. Ascend. Repeat.")
	{
		if($locations[The Castle In The Clouds In The Sky (Ground Floor), The Defiled Alcove, The Defiled Niche, The Defiled Nook, The Haunted Ballroom] contains loc)
		{
			if(get_property("_cc_groundhogSkip").to_int() == my_turncount())
			{
				return false;
			}
		}
	}
	return true;
}