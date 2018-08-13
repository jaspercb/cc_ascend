script "cc_mr2018.ash"

#	This is meant for items that have a date of 2018.

int januaryToteTurnsLeft(item it)
{
	if(item_amount($item[January\'s Garbage Tote]) == 0)
	{
		return 0;
	}
	if(!is_unrestricted($item[January\'s Garbage Tote]))
	{
		return 0;
	}

	int score = 0;
	switch(it)
	{
	case $item[Deceased Crimbo Tree]:		score = get_property("_garbageTreeCharge").to_int();		break;
	case $item[Broken Champagne Bottle]:	score = get_property("_garbageChampagneCharge").to_int();	break;
	case $item[Makeshift Garbage Shirt]:	score = get_property("_garbageShirtCharge").to_int();		break;
	}
	return score;
}

boolean januaryToteAcquire(item it)
{
	if(possessEquipment(it))
	{
		return false;
	}
	if(item_amount($item[January\'s Garbage Tote]) == 0)
	{
		return false;
	}
	if(!is_unrestricted($item[January\'s Garbage Tote]))
	{
		return false;
	}

	int choice = 0;
	switch(it)
	{
	case $item[Deceased Crimbo Tree]:			choice = 1;		break;
	case $item[Broken Champagne Bottle]:		choice = 2;		break;
	case $item[Tinsel Tights]:					choice = 3;		break;
	case $item[Wad Of Used Tape]:				choice = 4;		break;
	case $item[Makeshift Garbage Shirt]:		choice = 5;		break;
	case $item[Letter For Melvign The Gnome]:	choice = 7;		break;
	}

	if((choice == 5) && !hasTorso())
	{
		return false;
	}

	if(choice == 0)
	{
		return false;
	}

	if(choice == 7)
	{
		if(get_property("questM22Shirt") != "unstarted")
		{
			return false;
		}
		if(hasTorso())
		{
			return false;
		}
		if(item_amount($item[Letter For Melvign The Gnome]) > 0)
		{
			return false;
		}
		choice = 5;
	}

	string temp = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9690", false);
	temp = visit_url("choice.php?pwd=&whichchoice=1275&option=" + choice);

	return true;
}

boolean godLobsterCombat()
{
	return godLobsterCombat($item[none]);
}

boolean godLobsterCombat(item it)
{
	return godLobsterCombat(it, 3);
}

boolean godLobsterCombat(item it, int goal)
{
	return godLobsterCombat(it, goal, "");
}

boolean godLobsterCombat(item it, int goal, string option)
{
	if(!have_familiar($familiar[God Lobster]))
	{
		return false;
	}
	if(!is_unrestricted($familiar[God Lobster]))
	{
		return false;
	}
	if(is100FamiliarRun($familiar[God Lobster]))
	{
		return false;
	}
	if((goal < 1) || (goal > 3))
	{
		return false;
	}
	if(get_property("_godLobsterFights").to_int() >= 3)
	{
		return false;
	}
	if((it != $item[none]) && (available_amount(it) == 0))
	{
		return false;
	}
	if((goal == 1) && (it == $item[God Lobster\'s Crown]))
	{
		return false;
	}

	familiar last = my_familiar();
	handleFamiliar($familiar[God Lobster]);
	use_familiar($familiar[God Lobster]);

	item lastGear = equipped_item($slot[familiar]);

	if(lastGear != it)
	{
		equip($slot[familiar], it);
	}

	set_property("cc_disableAdventureHandling", true);

	string temp = visit_url("main.php?fightgodlobster=1");
	if(contains_text(temp, "You can't challenge your God Lobster anymore"))
	{
		set_property("_godLobsterFights", 3);
	}
	else
	{
		ccAdv(1, $location[Noob Cave], option);
		temp = visit_url("main.php");

		string search = "I'd like part of your regalia.";
		if(goal == 2)
		{
			search = "I'd like a blessing.";
		}
		else if(goal == 3)
		{
			search = "I'd like some experience.";
		}

		int choice = 0;
		foreach idx, str in available_choice_options()
		{
			if(contains_text(str,search))
			{
				choice = idx;
			}
		}
		backupSetting("choiceAdventure1310", choice);
		temp = visit_url("choice.php?pwd=&whichchoice=1310&option=" + choice, true);
		restoreSetting("choiceAdventure1310");
	}

	set_property("cc_disableAdventureHandling", false);
	if(equipped_item($slot[familiar]) != lastGear)
	{
		equip($slot[familiar], lastGear);
	}
	if(my_familiar() != last)
	{
		use_familiar(last);
	}
	cli_execute("postcheese");
	return true;
}


boolean fantasyRealmToken()
{
	if(!is_unrestricted($item[FantasyRealm membership packet]))
	{
		return false;
	}

	if((get_property("frAlways").to_boolean() || get_property("_frToday").to_boolean()) && !possessEquipment($item[FantasyRealm G. E. M.]))
	{
		int option = 1;
		switch(my_primestat())
		{
		case $stat[Muscle]:			option = 1;		break;
		case $stat[Mysticality]:	option = 2;		break;
		case $stat[Moxie]:			option = 3;		break;
		}
		visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter", false);
		visit_url("choice.php?whichchoice=1280&pwd=&option=" + option);
	}

	if(!possessEquipment($item[FantasyRealm G. E. M.]))
	{
		return false;
	}

	if(contains_text(get_property("_frMonstersKilled"), "fantasy bandit"))
	{
		foreach idx, it in split_string(get_property("_frMonstersKilled"), ",")
		{
			print(it);
			if(contains_text(it, "fantasy bandit"))
			{
				int count = to_int(split_string(it, ":")[1]);
				if(count >= 5)
				{
					return false;
				}
			}
		}
	}

	if(is100familiarRun())
	{
		return false;
	}
	set_property("cc_familiarChoice", "none");
	use_familiar($familiar[none]);

	if(possessEquipment($item[FantasyRealm G. E. M.]))
	{
		if(!have_equipped($item[FantasyRealm G. E. M.]))
		{
			equip($slot[acc3], $item[FantasyRealm G. E. M.]);
		}
	}

	//This does not appear to check that we no longer need to adventure there...

	ccAdv(1, $location[The Bandit Crossroads]);
	return true;
}

boolean songboomSetting(string goal)
{
	int option = 6;

	if((goal ≈ "eye of the giger") || (goal ≈ "spooky") || (goal ≈ "nightmare") || (goal ≈ $item[Nightmare Fuel]) || (goal ≈ "stats"))
	{
		option = 1;
	}
	else if((goal ≈ "food vibrations") || (goal ≈ "food") || (goal ≈ "food drops") || (goal ≈ $item[Special Seasoning]) || (goal ≈ "spell damage") || (goal ≈ "adventures") || (goal ≈ "adv"))
	{
		option = 2;
	}
	else if((goal ≈ "remainin\' alive") || (goal ≈ "dr") || (goal ≈ "damage reduction") || (goal ≈ $item[Shielding Potion]) || (goal ≈ "delevel"))
	{
		option = 3;
	}
	else if((goal ≈ "these fists were made for punchin\'") || (goal ≈ "weapon damage") || (goal ≈ "prismatic damage") || (goal ≈ $item[Punching Potion]) || (goal ≈ "prismatic"))
	{
		option = 4;
	}
	else if((goal ≈ "total eclipse of your meat") || (goal ≈ "meat") || (goal ≈ "meat drop") || (goal ≈ $item[Gathered Meat-Clip]) || (goal ≈ "base meat"))
	{
		option = 5;
	}
	else if((goal ≈ "silence") || (goal ≈ "none") || (goal == ""))
	{
		option = 6;
	}

	return songboomSetting(option);
}


boolean songboomSetting(int option)
{
	if(!is_unrestricted($item[SongBoom&trade; BoomBox]))
	{
		return false;
	}
	if(item_amount($item[SongBoom&trade; BoomBox]) == 0)
	{
		return false;
	}
	if(get_property("_boomBoxSongsLeft").to_int() == 0)
	{
		if(option != 6)
		{
			# Always allow turning off the song, if that is really something we want to do.
			return false;
		}
	}
	if((option < 0) || (option > 6))
	{
		return false;
	}

	string currentSong = get_property("boomBoxSong");
	if((option == 1) && (currentSong == "Eye of the Giger"))
	{
		return false;
	}
	else if((option == 2) && (currentSong == "Food Vibrations"))
	{
		return false;
	}
	else if((option == 3) && (currentSong == "Remainin\' Alive"))
	{
		return false;
	}
	else if((option == 4) && (currentSong == "These Fists Were Made for Punchin\'"))
	{
		return false;
	}
	else if((option == 5) && (currentSong == "Total Eclipse of Your Meat"))
	{
		return false;
	}
	else if((option == 6) && (currentSong == ""))
	{
		return false;
	}

	int boomsLeft = 0;
	string page = visit_url("inv_use.php?pwd=&which=3&whichitem=9919");
	matcher boomMatcher = create_matcher("You grab your boombox and select the soundtrack for your life,  which you can do <b>(?:-?)(\\d+)", page);
	if(boomMatcher.find())
	{
		boomsLeft = to_int(boomMatcher.group(1));
	}
	else
	{
		print("Could not find how many songs we have left...", "red");
		option = 6;
	}

	page = visit_url("choice.php?whichchoice=1312&option=" + option);
	if(contains_text(page, "don\'t want to break this thing"))
	{
		print("Unable to change BoomBoxen songen!", "red");
		return false;
	}
	if(option != 6)
	{
		boomsLeft--;
	}
	print("Change successful to " + get_property("boomBoxSong") + "We have " + boomsLeft + " SongBoom BoomBoxen songens left!", "green");
	return true;
}

boolean cheeseWarMachine(int stats, int it, int buff, int potion)
{
	if(!is_unrestricted($item[Bastille Battalion Control Rig]))
	{
		return false;
	}
	if(item_amount($item[Bastille Battalion Control Rig]) == 0)
	{
		return false;
	}
	if(get_property("_cheeseWarMachine").to_boolean())
	{
		return false;
	}

	if(stats == 0)
	{
		switch(my_primestat())
		{
		case $stat[Muscle]:			stats = 2;			break;
		case $stat[Mysticality]:	stats = 1;			break;
		case $stat[Moxie]:			stats = 3;			break;
		}
	}

	if((stats < 1) || (stats > 3))
	{
		return false;
	}
	if((it < 1) || (it > 3))
	{
		return false;
	}
	if((buff < 1) || (buff > 3))
	{
		return false;
	}
	if((potion < 1) || (potion > 3))
	{
		return false;
	}
	string page = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9928", false);

	matcher first = create_matcher("/bbatt/barb(\\d).png", page);
	if(first.find())
	{
		int setting = first.group(1).to_int();
		while(setting != stats)
		{
			string temp = visit_url("choice.php?whichchoice=1313&option=1&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)
			{
				setting = 1;
			}
		}
	}

	matcher second = create_matcher("/bbatt/bridge(\\d).png", page);
	if(second.find())
	{
		int setting = second.group(1).to_int();
		while(setting != it)
		{
			string temp = visit_url("choice.php?whichchoice=1313&option=2&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)
			{
				setting = 1;
			}
		}
	}

	matcher third = create_matcher("/bbatt/holes(\\d).png", page);
	if(third.find())
	{
		int setting = third.group(1).to_int();
		while(setting != buff)
		{
			string temp = visit_url("choice.php?whichchoice=1313&option=3&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)
			{
				setting = 1;
			}
		}
	}

	matcher fourth = create_matcher("/bbatt/moat(\\d).png", page);
	if(fourth.find())
	{
		int setting = fourth.group(1).to_int();
		while(setting != potion)
		{
			string temp = visit_url("choice.php?whichchoice=1313&option=4&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)
			{
				setting = 1;
			}
		}
	}

	string temp = visit_url("choice.php?whichchoice=1313&option=5&pwd=" + my_hash(), false);

	for(int i=0; i<5; i++)
	{
		visit_url("choice.php?whichchoice=1314&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1319&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1314&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1319&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1315&option=3&pwd=" + my_hash());
	}

	visit_url("choice.php?whichchoice=1316&option=3&pwd=" + my_hash());
	set_property("_cheeseWarMachine", true);
	return true;
}
