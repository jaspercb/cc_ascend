script "cc_adventure.ash"
import <cc_ascend/cc_ascend_header.ash>


# num is not handled properly anyway, so we'll just reject it.
boolean ccAdv(location loc, string option)
{
	return ccAdv(1, loc, option);
}

# num is not handled properly anyway, so we'll just reject it.
boolean ccAdv(int num, location loc, string option)
{
	if(option == "")
	{
		option = "cc_combatHandler";
	}
	if(cc_my_path() == "Actually Ed the Undying")
	{
		return ed_ccAdv(num, loc, option);
	}

#	boolean retval = adv1(loc, num, option);
	boolean retval = adv1(loc, 0, option);
	if(cc_my_path() == "One Crazy Random Summer")
	{
		if(last_monster().random_modifiers["clingy"])
		{
			int oldDesert = get_property("desertExploration").to_int();
			retval = ccAdv(num, loc, option);
			if(my_location() == $location[The Arid\, Extra-Dry Desert])
			{
				set_property("desertExploration", oldDesert);
			}
		}
	}
	return retval;
}

boolean ccAdv(int num, location loc)
{
	return ccAdv(num, loc, "");
}

boolean ccAdv(location loc)
{
	return ccAdv(1, loc, "");
}

boolean ccAdvBypass(string url, location loc)
{
	return ccAdvBypass(url, loc, "");
}

boolean ccAdvBypass(string url, location loc, string option)
{
	handlePreAdventure(loc);
	if(my_class() == $class[Ed])
	{
		ed_preAdv(1, loc, option);
	}

	print("About to start a combat indirectly at " + loc + "...", "blue");
	string page = visit_url(url);
	if((my_hp() == 0) || (get_property("_edDefeats").to_int() == 1) || (have_effect($effect[Beaten Up]) > 0))
	{
		print("Uh oh! Died when starting a combat indirectly.", "red");
		if(my_class() == $class[Ed])
		{
			return ed_ccAdv(1, loc, option, true);
		}
		abort("ccAdvBypass override abort");
	}
	if(contains_text(page, "Combat"))
	{
		return ccAdv(1, loc, option);
	}

	# Encounters that need to generate a false so we handle them manually should go here.
	if(get_property("lastEncounter") == "Fitting In")
	{
		return false;
	}

	if(contains_text(page, "whichchoice value=") || contains_text(page, "whichchoice="))
	{
		return ccAdv(1, loc, option);
	}

	return false;
}

boolean ccAdvBypass(int snarfblat, location loc)
{
	string page = "adventure.php?snarfblat=" + snarfblat + "&confirm=on";
	return ccAdvBypass(page, loc);
}
boolean ccAdvBypass(int snarfblat, location loc, string option)
{
	string page = "adventure.php?snarfblat=" + snarfblat + "&confirm=on";
	return ccAdvBypass(page, loc, option);
}

boolean ccAdvBypass(int snarfblat)
{
	return ccAdvBypass(snarfblat, $location[Noob Cave]);
}
boolean ccAdvBypass(string url)
{
	return ccAdvBypass(url, $location[Noob Cave]);
}
boolean ccAdvBypass(int snarfblat, string option)
{
	return ccAdvBypass(snarfblat, $location[Noob Cave], option);
}
boolean ccAdvBypass(string url, string option)
{
	return ccAdvBypass(url, $location[Noob Cave], option);
}