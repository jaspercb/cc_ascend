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
			abort("You have a non-combat in the crypt and we are going to infintely loop on it like a groundhog. Maybe you should spend this adventure somewhere to ease the pain for all of us.");
		}
	}
	return false;
}


