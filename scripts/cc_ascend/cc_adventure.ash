script "cc_adventure.ash"
import<cc_ascend/cc_ascend_header.ash>

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

boolean ccAdv()
{
	if(my_location() == $location[none])
	{
		return ccAdv(1, $location[Noob Cave], "");
	}
	return ccAdv(1, my_location(), "");
}

boolean ccAdv(location loc)
{
	return ccAdv(1, loc, "");
}

boolean ccAdvBypass(string url, location loc)
{
	return ccAdvBypass(url, loc, "");
}

#boolean ccAdvBypass(string[int] url, location loc)
#{
#	return ccAdvBypass(url, loc, "");
#}

boolean ccAdvBypass(string url, location loc, string option)
{
	string[int] urlConvert;
	urlConvert[0] = url;
	return ccAdvBypass(0, urlConvert, loc, option);
}

# Preserved to remind us of this issue.
#boolean ccAdvBypass(int becauseStringIntIsSomehowJustString, string[int] url, location loc, string option)
#
#	urlGetFlags allows us to force visit_url(X, false). It is a bit field.
#
boolean ccAdvBypass(int urlGetFlags, string[int] url, location loc, string option)
{
	set_property("nextAdventure", loc);
	cli_execute("precheese");
#	handlePreAdventure(loc);
	if(my_class() == $class[Ed])
	{
		ed_preAdv(1, loc, option);
	}

	print("About to start a combat indirectly at " + loc + "... (" + count(url) + ") accesses required.", "blue");
	string page;
	foreach idx, it in url
	{
		if((urlGetFlags & 1) == 1)
		{
			print("Visit_url(" + it + ") override to false", "red");
			//When using this, you may have to add my_hash yourself.
			//We can probably do this (but is it possible that a search for "pwd" can cause false positives?)
			page = visit_url(it, false);
		}
		else
		{
			page = visit_url(it);
		}
		urlGetFlags /= 2;
	}
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
	if(get_property("lastEncounter") == "Arboreal Respite")
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
#boolean ccAdvBypass(string[int] url)
#{
#	return ccAdvBypass(url, $location[Noob Cave]);
#}
boolean ccAdvBypass(int snarfblat, string option)
{
	return ccAdvBypass(snarfblat, $location[Noob Cave], option);
}
boolean ccAdvBypass(string url, string option)
{
	return ccAdvBypass(url, $location[Noob Cave], option);
}
#boolean ccAdvBypass(string[int] url, string option)
#{
#	return ccAdvBypass(url, $location[Noob Cave], option);
#}





boolean preAdvXiblaxian(location loc)
{
	if((equipped_item($slot[acc3]) == $item[Xiblaxian Holo-Wrist-Puter]) && (howLongBeforeHoloWristDrop() <= 1))
	{
		string area = loc.environment;
		# This is an attempt to farm Ultraburrito stuff.

#		item replace = $item[none];
#		if((item_amount($item[Pirate Fledges]) > 0) && (can_equip($item[Pirate Fledges])))
#		{
#			replace = $item[Pirate Fledges];
#		}

		# If we migrate all Ed workaround combats to the bypasser, we don't need to check main.php
		if(my_class() == $class[Ed])
		{
			if(contains_text(visit_url("main.php"), "Combat"))
			{
				print("As Ed, I was not bypassed into this combat correctly (but it'll be ok)", "red");
				return false;
			}
		}

		# For overriden adventures, we should use a place with a similar location profile.
		# However, that means we\'d lose the Noob Cave canaray
		if(loc == $location[Noob Cave])
		{
			replaceBaselineAcc3();
			#equip($slot[acc3], replace);
			return true;
		}

		if((area == "indoor") && (item_amount($item[Xiblaxian Circuitry]) > 0))
		{
			replaceBaselineAcc3();
#			equip($slot[acc3], replace);
		}
		else if((area == "outdoor") && (item_amount($item[Xiblaxian Polymer]) > 0))
		{
			replaceBaselineAcc3();
#			equip($slot[acc3], replace);
		}
		else if((area == "underground") && (item_amount($item[Xiblaxian Alloy]) > 2))
		{
			replaceBaselineAcc3();
#			equip($slot[acc3], replace);
		}
		else
		{
			print("We should be getting a Xiblaxian wotsit this combat. Beep boop.", "green");
		}
	}
	return true;
}
