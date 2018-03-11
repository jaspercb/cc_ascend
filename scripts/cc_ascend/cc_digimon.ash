script "cc_digimon.ash"


void digimon_initializeDay(int day)
{
	digimon_makeTeam();
}

void digimon_initializeSettings()
{
	if(cc_my_path() == "Pocket Familiars")
	{
		set_property("cc_ballroomsong", "finished");
		set_property("cc_getBeehive", false);
		set_property("cc_getBoningKnife", false);
		set_property("cc_cubeItems", false);
		set_property("cc_getStarKey", true);
		set_property("cc_grimstoneOrnateDowsingRod", false);
		set_property("cc_hippyInstead", true);
		set_property("cc_holeinthesky", true);
		set_property("cc_ignoreFlyer", true);
		set_property("cc_swordfish", "finished");
		set_property("cc_useCubeling", false);
		set_property("cc_wandOfNagamar", false);
		januaryToteAcquire($item[Makeshift Garbage Shirt]);
		if(possessEquipment($item[Makeshift Garbage Shirt]))
		{
			string temp = visit_url("inv_equip.php?pwd&which=2&action=equip&whichitem=" + to_int($item[Makeshift Garbage Shirt]));
		}
		digimon_makeTeam();
	}
}


boolean digimon_makeTeam()
{
	if(cc_my_path() == "Pocket Familiars")
	{
		string temp = visit_url("famteam.php", false);

		if(have_familiar($familiar[Space Jellyfish]))
		{
			temp = visit_url("famteam.php?slot=3&fam=" + to_int($familiar[Space Jellyfish]) + "&pwd&action=slot");
			if(get_property("_digimonBack") != $familiar[Space Jellyfish])
			{
				set_property("_digimonBack", $familiar[Space Jellyfish]);
			}
		}
		else
		{
			temp = visit_url("famteam.php?slot=3&fam=" + to_int($familiar[Killer Bee]) + "&pwd&action=slot");
			if(get_property("_digimonBack") != $familiar[Killer Bee])
			{
				set_property("_digimonBack", $familiar[Killer Bee]);
			}
		}



		familiar midFam = $familiar[Scary Death Orb];
		foreach fam in $familiars[Bad Vibe, Restless Cow Skull, Mariachi Chihuahua]
		{
			if(!have_familiar(fam))
			{
				continue;
			}
			if(contains_text(temp, "Lv. 5 " + fam))
			{
				continue;
			}
			if(fam.poke_level == 5)
			{
				continue;
			}
			if(my_poke_fam(2) == fam)
			{
				continue;
			}
			midFam = fam;
			break;
		}

		temp = visit_url("famteam.php?slot=2&fam=" + to_int(midFam) + "&pwd&action=slot");
		if(get_property("_digimonMiddle") != midFam)
		{
			set_property("_digimonMiddle", midFam);
		}


		familiar newFam = $familiar[El Vibrato Megadrone];
		foreach fam in $familiars[]
		{
			if(!have_familiar(fam))
			{
				continue;
			}
			if(contains_text(temp, "Lv. 5 " + fam))
			{
				continue;
			}

			if(my_poke_fam(2) == fam)
			{
				continue;
			}
			if(my_poke_fam(1) == fam)
			{
				continue;
			}
			if(fam.poke_level == 5)
			{
				continue;
			}
			newFam = fam;
			break;
		}

		foreach fam in $familiars[Clockwork Grapefruit, Mini-Crimbot, MagiMechTech MicroMechaMech, Autonomous Disco Ball, Software Bug, Robortender, Putty Buddy]
		{
			if(!have_familiar(fam))
			{
				continue;
			}
			if(contains_text(temp, "Lv. 5 " + fam))
			{
				continue;
			}
			if(fam.poke_level == 5)
			{
				continue;
			}
			if(my_poke_fam(2) == fam)
			{
				continue;
			}
			if(my_poke_fam(1) == fam)
			{
				continue;
			}
			newFam = fam;
			break;
		}

		print("I choose you! " + newFam.name + " the " + newFam + "!!!!", "green");
#		temp = visit_url("famteam.php?slot=1&fam=" + to_int($familiar[El Vibrato Megadrone]) + "&pwd&action=slot");
		temp = visit_url("famteam.php?slot=1&fam=" + to_int(newFam) + "&pwd&action=slot");
		if(get_property("_digimonFront") != newFam)
		{
			set_property("_digimonFront", newFam);
		}



	}
	return true;
}


boolean LM_digimon()
{
	if(cc_my_path() == "Pocket Familiars")
	{
		digimon_makeTeam();
		if((my_primestat() == $stat[Muscle]) && !possessEquipment($item[Dented Scepter]) && (my_level() < 13))
		{
			cc_advWitchess("king");
		}
	}
	return false;
}

boolean digimon_ccAdv(int num, location loc, string option)
{
	if(cc_my_path() != "Pocket Familiars")
	{
		abort("Can not use Digimon protocols without Digimon!");
	}

	if(option == "")
	{
		#Yeah, this is not a thing right now.
	}

#	boolean retval = adv1(loc, 0, option);
	string temp = visit_url(to_url(loc), false);

	if((get_property("cc_mcmuffin") == "ed") && (cc_my_path() == "Pocket Familiars") && (loc == $location[The Lower Chambers]))
	{
		temp = visit_url(to_url(loc) + "a", false);
	}

	print("[Insert Punch Out music here]", "green");
	temp = visit_url("fambattle.php");
	int choiceLimiter = 0;
	while(contains_text(temp, "whichchoice value=") || contains_text(temp, "whichchoice="))
	{
		print("Digimon hit a choice adventure (" + loc + "), trying....", "red");
		matcher choice_matcher = create_matcher("(?:whichchoice value=(\\d+))|(?:whichchoice=(\\d+))", temp);
		if(choice_matcher.find())
		{
			int choice = choice_matcher.group(1).to_int();
			if(choice == 0)
			{
				choice = choice_matcher.group(2).to_int();
			}

			if($ints[89, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 914] contains choice)
			{
				return adv1(loc, 0, option);
			}

			temp = visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=" + choice + "&option=" + get_property("choiceAdventure" + choice).to_int());
		}
		choiceLimiter += 1;
		if(choiceLimiter > 5)
		{
			abort("Choice chain too long or I'm stuck!");
		}
	}
	temp = visit_url("fambattle.php");

	if(!contains_text(temp, "Fight!"))
	{
		return false;
	}

	if(svn_info("Ezandora-Helix-Fossil-branches-Release").revision > 0)
	{
		print("Consulting the Helix Fossil....", "green");
		boolean ignore = cli_execute("ashq import 'Pocket Familiars'; buffer temp = PocketFamiliarsFight();");
		if($locations[The Defiled Alcove, The Defiled Cranny, The Defiled Niche, The Defiled Nook] contains my_location())
		{
			if(item_amount($item[Evilometer]) > 0)
			{
				use(1, $item[Evilometer]);
			}
		}
		cli_execute("postcheese");
		return true;
	}

	if(get_property("_digimonFront") == "")
	{
		set_property("_digimonFront", my_poke_fam(0));
	}
	if(get_property("_digimonMiddle") == "")
	{
		set_property("_digimonMiddle", my_poke_fam(1));
	}
	if(get_property("_digimonBack") == "")
	{
		set_property("_digimonBack", my_poke_fam(2));
	}


	familiar blastFam = to_familiar(get_property("_digimonBack"));
	familiar midFam = to_familiar(get_property("_digimonMiddle"));
#	familiar blastFam = $familiar[Space Jellyfish];
#	if(!have_familiar($familiar[Space Jellyfish]))
#	{
#		blastFam = $familiar[Killer Bee];
#	}

	if(contains_text(temp, "famaction[ult_crazyblast-" + to_int(blastFam) + "]"))
	{
		temp = visit_url("fambattle.php?pwd&famaction[ult_crazyblast-" + to_int(blastFam) + "]=ULTIMATE%3A+Spiky+Burst");
	}
	else
	{
		temp = visit_url("fambattle.php?pwd&famaction[backstab-" + to_int(blastFam) + "]=Backstab");
	}
	int action = 1;
	

	while(!contains_text(temp, "<!--WINWINWIN-->"))
	{
		if((action & 1) == 1)
		{
			temp = visit_url("fambattle.php?pwd&famaction[backstab-" + to_int(midFam) + "]=Backstab");
		}
		else
		{
			temp = visit_url("fambattle.php?pwd&famaction[backstab-" + to_int(blastFam) + "]=Backstab");
		}
		action++;
		if(contains_text(temp, "dejected and defeated"))
		{
			break;
		}
		if(action > 40)
		{
			abort("Can not win this Digimon Battle!");
		}
	}

	if($locations[The Defiled Alcove, The Defiled Cranny, The Defiled Niche, The Defiled Nook] contains my_location())
	{
		if(item_amount($item[Evilometer]) > 0)
		{
			use(1, $item[Evilometer]);
		}
	}
	cli_execute("postcheese");
	return true;
}
