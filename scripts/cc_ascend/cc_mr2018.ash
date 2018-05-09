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
	if(get_property("_lobsterFights").to_int() >= 3)
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
		set_property("_lobsterFights", 3);
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
			if(str == search)
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
	set_property("_lobsterFights", get_property("_lobsterFights").to_int() + 1);
	cli_execute("postcheese");
	return true;
}
