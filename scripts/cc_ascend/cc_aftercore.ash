script "cc_aftercore.ash"
import <cc_ascend.ash>

#Prototypes
boolean cc_sloppySecondsDiner();
boolean cc_fingernail();
boolean cc_packOfSmokes();
boolean cc_goreBucket();
boolean cc_junglePuns();
boolean cc_jungleSandwich();
boolean cc_toxicMascot();
boolean cc_nastyBears();
boolean cc_toxicGlobules();
boolean cc_sexismReduction();
boolean cc_racismReduction();
boolean cc_lubeBarfMountain();
boolean cc_trashNet();
boolean cc_doWalford();
boolean cc_mtMolehill();
boolean cc_acquireKeycards();
boolean cc_dailyDungeon();
item cc_guildEpicWeapon();
boolean cc_guildUnlock();
boolean cc_guildClown();
boolean cc_nemesisCave();
boolean cc_nemesisIsland();
boolean cc_cheesePostCS();
boolean cc_cheesePostCS(int leave);
boolean cc_cheeseAftercore(int leave);
boolean cc_aftercore();
boolean cc_aftercore(int leave);
boolean cc_ascendIntoCS();
boolean cc_ascendIntoBond();
boolean cc_doCS();

#Definitons here
void cc_combatTest()
{
	string macro = "skill toss; repeat";
	visit_url("fight.php?action=macro&macrotext=" + url_encode(macro), true, true);
}

string simpleCombatFilter(int round, string opp, string text)
{
	#throw_item($item[Seal Tooth]);
	#return "item seal tooth";
	print("I've been called at on round: " + round, "green");
	#return url_encode("\"item seal tooth; repeat\"");
	return "\"item seal tooth; repeat\"";
}

boolean cc_dailyDungeon()
{
	item lastequip = equipped_item($slot[acc2]);
	equip($slot[acc2], $item[ring of detect boring doors]);
	while((get_property("_lastDailyDungeonRoom").to_int() != 15) && (my_adventures() > 0) && (item_amount($item[eleven-foot pole]) > 0) && (item_amount($item[pick-o-matic lockpicks]) > 0))
	{
		ccAdv(1, $location[The Daily Dungeon]);
	}
	equip($slot[acc2], lastequip);
	return true;
}

boolean cc_sloppySecondsDiner()
{
	if(get_property("_sloppyDinerBeachBucks").to_int() >= 4)
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}

	while((my_adventures() > 0) && (get_property("_sloppyDinerBeachBucks").to_int() < 4))
	{
		ccAdv(1, $location[Sloppy Seconds Diner]);
	}
	return true;
}

boolean cc_fingernail()
{
	if(get_property("fingernailsClipped").to_int() >= 23)
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(item_amount($item[Military-Grade Fingernail Clippers]) == 0)
	{
		return false;
	}
	while((get_property("fingernailsClipped").to_int() < 23) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Mansion of Dr. Weirdeaux]);
	}
	return true;
}

boolean cc_packOfSmokes()
{
	if(item_amount($item[pack of smokes]) >= 10)
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	while((item_amount($item[pack of smokes]) < 10) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Deep Dark Jungle]);
	}
	return true;
}

boolean cc_goreBucket()
{
	if(!possessEquipment($item[Gore Bucket]))
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("goreCollected").to_int() >= 100)
	{
		return false;
	}
	if(equipped_item($slot[Off-Hand]) != $item[Gore Bucket])
	{
		equip($item[Gore Bucket]);
	}
	while((get_property("goreCollected").to_int() < 100) && (my_adventures() > 0))
	{
		if(!ccAdv(1, $location[The Secret Government Laboratory]))
		{
			abort("Could not adventure in the lab, aborting");
		}
	}
	return true;
}

boolean cc_junglePuns()
{
	if(!possessEquipment($item[Encrypted Micro-Cassette Recorder]))
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("junglePuns").to_int() >= 11)
	{
		return false;
	}
	if(equipped_item($slot[Off-Hand]) != $item[Encrypted Micro-Cassette Recorder])
	{
		equip($item[Encrypted Micro-Cassette Recorder]);
	}
	while((get_property("junglePuns").to_int() < 11) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Deep Dark Jungle]);
	}
	return true;
}

boolean cc_sexismReduction()
{
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("dinseySocialJusticeIProgress").to_int() >= 15)
	{
		return false;
	}
	while((get_property("dinseySocialJusticeIProgress").to_int() < 15) && (my_adventures() > 0))
	{
		ccAdv(1, $location[Pirates of the Garbage Barges]);
	}
	return true;
}

boolean cc_racismReduction()
{
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("dinseySocialJusticeIIProgress").to_int() >= 15)
	{
		return false;
	}
	while((get_property("dinseySocialJusticeIIProgress").to_int() < 15) && (my_adventures() > 0))
	{
		ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
	}
	return true;
}


boolean cc_nastyBears()
{
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("dinseyNastyBearsDefeated").to_int() >= 8)
	{
		return false;
	}
	while((get_property("dinseyNastyBearsDefeated").to_int() < 8) && (my_adventures() > 0))
	{
		ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
	}
	return true;
}



boolean cc_toxicGlobules()
{
	if(my_adventures() == 0)
	{
		return false;
	}
	if(item_amount($item[Toxic Globule]) >= 20)
	{
		return false;
	}
	while((item_amount($item[Toxic Globule]) < 20) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Toxic Teacups]);
	}
	return true;
}



boolean cc_toxicMascot()
{
	if(!possessEquipment($item[Dinsey Mascot Mask]))
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("dinseyFunProgress").to_int() >= 15)
	{
		return false;
	}
	if(equipped_item($slot[Hat]) != $item[Dinsey Mascot Mask])
	{
		equip($item[Dinsey Mascot Mask]);
	}
	while((get_property("dinseyFunProgress").to_int() < 15) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Toxic Teacups]);
	}
	return true;
}

boolean cc_trashNet()
{
	if(!possessEquipment($item[Trash Net]))
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(get_property("dinseyFilthLevel").to_int() <= 0)
	{
		return false;
	}
	if(equipped_item($slot[Weapon]) != $item[Trash Net])
	{
		equip($item[Trash Net]);
	}
	while((get_property("dinseyFilthLevel").to_int() > 0) && (my_adventures() > 0))
	{
		ccAdv(1, $location[Pirates of the Garbage Barges]);
	}
	return true;
}

boolean cc_lubeBarfMountain()
{
	if(!possessEquipment($item[lube-shoes]))
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	if(equipped_item($slot[acc2]) != $item[lube-shoes])
	{
		equip($slot[acc2], $item[lube-shoes]);
	}
	while(my_adventures() > 0)
	{
		if(contains_text(get_property("lastEncounter"), "A Rollercoaster Baby Baby"))
		{
			return true;
		}
		ccAdv(1, $location[Barf Mountain]);
	}
	return true;
}

boolean cc_acquireKeycards()
{
	while(my_adventures() > 0)
	{
		if(item_amount($item[Keycard &delta;]) == 0)
		{
			ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
		}
		else if(item_amount($item[Keycard &alpha;]) == 0)
		{
			ccAdv(1, $location[Barf Mountain]);
		}
		else if(item_amount($item[Keycard &beta;]) == 0)
		{
			ccAdv(1, $location[Pirates of the Garbage Barges]);
		}
		else if(item_amount($item[Keycard &gamma;]) == 0)
		{
			ccAdv(1, $location[The Toxic Teacups]);
		}
		else
		{
			return false;
		}
	}
	return false;
}

boolean cc_jungleSandwich()
{
	if(item_amount($item[Project T. L. B.]) != 0)
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	while((item_amount($item[Project T. L. B.]) == 0) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The Deep Dark Jungle]);
	}
	return true;
}

boolean cc_mtMolehill()
{
	if(have_effect($effect[Shape of...Mole!]) == 0)
	{
		return false;
	}
	if(my_adventures() == 0)
	{
		return false;
	}
	while((have_effect($effect[Shape of...Mole!]) > 0) && (my_adventures() > 0))
	{
		ccAdv(1, $location[Mt. Molehill]);
	}
	return true;
}

boolean cc_doWalford()
{
	if(!get_property("_walfordQuestStartedToday").to_boolean())
	{
		if(!elementalPlanes_takeJob($element[cold]))
		{
			return false;
		}
	}

	if(get_property("walfordBucketProgress").to_int() >= 100)
	{
		return false;
	}

	if((item_amount($item[Fishy Pipe]) > 0) && !get_property("_fishyPipeUsed").to_boolean())
	{
		use(1, $item[Fishy Pipe]);
	}
	if((item_amount($item[Bag O\' Tricks]) > 0) && !get_property("_bagOTricksUsed").to_boolean())
	{
		use(1, $item[Bag O\' Tricks]);
	}
	getDiscoStyle(7);

	if(get_property("cc_dinseyGarbageMoney").to_int() < my_daycount())
	{
		set_property("cc_dinseyGarbageMoney", my_daycount());
		visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
		visit_url("choice.php?pwd=&whichchoice=1067&option=6",true);
		visit_url("main.php");
	}

	if((item_amount($item[Platinum Yendorian Express Card]) > 0) && !get_property("expressCardUsed").to_boolean())
	{
		use(1, $item[Platinum Yendorian Express Card]);
	}


	if(get_property("_hipsterAdv").to_int() <= 2)
	{
		handleFamiliar($familiar[Artistic Goth Kid]);
		if(equipped_item($slot[Familiar]) != $item[Das Boot])
		{
			equip($slot[Familiar], $item[Das Boot]);
		}
	}
	else
	{
		handleFamiliar($familiar[Grouper Groupie]);
		if((equipped_item($slot[Familiar]) != $item[Snow Suit]) && (item_amount($item[Snow Suit]) > 0))
		{
			equip($slot[Familiar], $item[Snow Suit]);
		}
	}

	if(equipped_item($slot[Hat]) != $item[The Crown of Ed the Undying])
	{
		equip($item[The Crown of Ed the Undying]);
		adjustEdHat("fish");
	}
	if(equipped_item($slot[Back]) != $item[Camp Scout Backpack])
	{
		equip($item[Camp Scout Backpack]);
	}
	if((equipped_item($slot[Weapon]) != $item[Garbage Sticker]) && can_equip($item[Garbage Sticker]))
	{
		equip($item[Garbage Sticker]);
	}
	if(equipped_item($slot[Pants]) != $item[Pantsgiving])
	{
		equip($item[Pantsgiving]);
	}
	if(equipped_item($slot[Shirt]) != $item[Sneaky Pete\'s Leather Jacket])
	{
		if(item_amount($item[Sneaky Pete\'s Leather Jacket]) > 0)
		{
			equip($item[Sneaky Pete\'s Leather Jacket]);
		}
		else if(item_amount($item[Sneaky Pete\'s Leather Jacket (Collar Popped)]) > 0)
		{
			equip($item[Sneaky Pete\'s Leather Jacket (Collar Popped)]);
		}
	}
	if((equipped_item($slot[acc1]) != $item[Space Trip Safety Headphones]) && can_equip($item[Space Trip Safety Headphones]))
	{
		equip($slot[acc1], $item[Space Trip Safety Headphones]);
	}
	if(equipped_item($slot[acc2]) != $item[Mayfly Bait Necklace])
	{
		equip($slot[acc2], $item[Mayfly Bait Necklace]);
	}
	if((equipped_item($slot[acc3]) != $item[Mr. Cheeng\'s Spectacles]) && can_equip($item[Mr. Cheeng\'s Spectacles]))
	{
		equip($slot[acc3], $item[Mr. Cheeng\'s Spectacles]);
	}

	if(equipped_item($slot[Off-Hand]) != $item[Walford\'s Bucket])
	{
		equip($item[Walford\'s Bucket]);
	}
	while((get_property("walfordBucketProgress").to_int() < 100) && (my_adventures() > 0))
	{
		if(!ccAdv(1, $location[The Ice Hole]))
		{
			abort("Could not adventure in the Ice Hole, aborting");
		}
		if(!didWePlantHere($location[The Ice Hole]) && florist_available())
		{
			cli_execute("florist plant snori");
			cli_execute("florist plant kelptomaniac");
			cli_execute("florist plant up sea daisy");
		}

	}

	if(get_property("walfordBucketProgress").to_int() >= 100)
	{
		visit_url("place.php?whichplace=airport_cold&action=glac_walrus");
		visit_url("choice.php?pwd=&whichchoice=1114&option=1",true);
		return true;
	}
	return false;
}


item cc_guildEpicWeapon()
{
	item toMake = $item[none];
	switch(my_class())
	{
	case $class[Turtle Tamer]:			toMake = $item[Chelonian Morningstar];					break;
	case $class[Seal Clubber]:			toMake = $item[Hammer of Smiting];			break;
	case $class[Pastamancer]:			toMake = $item[Greek Pasta Spoon Of Peril];			break;
	case $class[Sauceror]:				toMake = $item[17-Alarm Saucepan];			break;
	case $class[Accordion Thief]:		toMake = $item[Squeezebox Of The Ages];					break;
	case $class[Disco Bandit]:			toMake = $item[Shagadelic Disco Banjo];					break;
	}
	return toMake;
}

boolean cc_guildUnlock()
{
	if(get_property("lastGuildStoreOpen").to_int() >= my_ascensions())
	{
		return false;
	}
	if(my_adventures() < 6)
	{
		return false;
	}

	switch(my_class())
	{
	case $class[Turtle Tamer]:
	case $class[Seal Clubber]:
		visit_url("guild.php?place=challenge");
		while((item_amount($item[11-inch Knob Sausage]) == 0) && (my_adventures() > 0))
		{
			ccAdv(1, $location[The Outskirts of Cobb\'s Knob]);
		}
		visit_url("guild.php?place=challenge");
		return true;
	case $class[Pastamancer]:
	case $class[Sauceror]:
		break;
	case $class[Accordion Thief]:
	case $class[Disco Bandit]:
		break;
	default:
		break;
	}
	return false;
}

boolean cc_guildClown()
{
	if(get_property("lastGuildStoreOpen").to_int() < my_ascensions())
	{
		return false;
	}

	if(!possessEquipment($item[Clownskin Buckler]))
	{
		pullXWhenHaveY($item[Clownskin Buckler], 1, 0);
	}
	if(!possessEquipment($item[Clownskin Harness]))
	{
		pullXWhenHaveY($item[Clownskin Harness], 1, 0);
	}
	equip($item[Clownskin Buckler]);
	equip($item[Clownskin Harness]);


	item toGet = $item[none];
	switch(my_class())
	{
	case $class[Turtle Tamer]:			toGet = $item[Turtle Chain];					break;
	case $class[Seal Clubber]:			toGet = $item[Distilled Seal Blood];			break;
	case $class[Pastamancer]:			toGet = $item[High-Octane Olive Oil];			break;
	case $class[Sauceror]:				toGet = $item[Peppercorns of Power];			break;
	case $class[Accordion Thief]:		toGet = $item[Golden Reeds];					break;
	case $class[Disco Bandit]:			toGet = $item[Vial of Mojo];					break;
	}
	if(toGet == $item[none])
	{
		return false;
	}

	visit_url("guild.php?place=scg");
	visit_url("guild.php?place=scg");
	while((item_amount(toGet) == 0) && (my_adventures() > 0))
	{
		ccAdv(1, $location[The \"Fun\" House]);
	}

	item toMake = cc_guildEpicWeapon();
	if(toMake == $item[none])
	{
		abort("Somehow started the guild Clown sequence but we have nothing to make.");
		return false;
	}
	cli_execute("make " + toMake);
	visit_url("guild.php?place=scg");
	equipBaseline();
	return true;
}

boolean cc_nemesisCave()
{
	if(get_property("lastGuildStoreOpen").to_int() < my_ascensions())
	{
		return false;
	}
	if(get_property("questG04Nemesis") != "step4")
	{
		return false;
	}
	if(!possessEquipment(cc_guildEpicWeapon()))
	{
		return false;
	}
	equipBaseline();
	switch(my_class())
	{
	case $class[Turtle Tamer]:
		pullXWhenHaveY($item[Viking Helmet], 1, 0);
		pullXWhenHaveY($item[Insanely Spicy Bean Burrito], 1, 0);
		pullXWhenHaveY($item[Clownskin Buckler], 1, 0);
#		abort("The door handling does not work so don't do it.");
		visit_url("cave.php?pwd=&action=dodoor1&whichitem=" + to_int($item[Viking Helmet]), true);
		visit_url("cave.php?pwd=&action=dodoor2&whichitem=" + to_int($item[Insanely Spicy Bean Burrito]), true);
		visit_url("cave.php?pwd=&action=dodoor3&whichitem=" + to_int($item[Clownskin Buckler]), true);
		break;
	case $class[Seal Clubber]:
		pullXWhenHaveY($item[Viking Helmet], 1, 0);
		pullXWhenHaveY($item[Insanely Spicy Bean Burrito], 1, 0);
		pullXWhenHaveY($item[Clown Whip], 1, 0);
#		abort("The door handling does not work so don't do it.");
		visit_url("cave.php?pwd=&action=dodoor1&whichitem=" + to_int($item[Viking Helmet]), true);
		visit_url("cave.php?pwd=&action=dodoor2&whichitem=" + to_int($item[Insanely Spicy Bean Burrito]), true);
		visit_url("cave.php?pwd=&action=dodoor3&whichitem=" + to_int($item[Clown Whip]), true);
		break;
	case $class[Pastamancer]:
		pullXWhenHaveY($item[Stalk of Asparagus], 1, 0);
		pullXWhenHaveY($item[Insanely Spicy Enchanted Bean Burrito], 1, 0);
		pullXWhenHaveY($item[Boring Spaghetti], 1, 0);
#		abort("The door handling does not work so don't do it.");
		visit_url("cave.php?pwd=&action=dodoor1&whichitem=" + to_int($item[Stalk of Asparagus]), true);
		visit_url("cave.php?pwd=&action=dodoor2&whichitem=" + to_int($item[Insanely Spicy Enchanted Bean Burrito]), true);
		visit_url("cave.php?pwd=&action=dodoor3&whichitem=" + to_int($item[Boring Spaghetti]), true);
		break;
	case $class[Sauceror]:
	case $class[Accordion Thief]:
	case $class[Disco Bandit]:
		return false;
	}

	while(my_adventures() > 0)
	{
		int count = 0;
		count = count + item_amount($item[A Creased Paper Strip]);
		count = count + item_amount($item[A Crinkled Paper Strip]);
		count = count + item_amount($item[A Crumpled Paper Strip]);
		count = count + item_amount($item[A Folded Paper Strip]);
		count = count + item_amount($item[A Rumpled Paper Strip]);
		count = count + item_amount($item[A Ripped Paper Strip]);
		count = count + item_amount($item[A Torn Paper Strip]);
		count = count + item_amount($item[A Ragged Paper Strip]);
		if(count >= 8)
		{
			break;
		}
#		if(!ccAdv(1, $location[Nemesis Cave]))
#		{
			abort("Can not access area, aborting.");
#		}
	}
	equip(cc_guildEpicWeapon());
	visit_url("cave.php?pwd=action=door4");
	abort("Currently, must handle password manually, big sad");
#	ccAdv(1, $location[Noob Cave]);

	visit_url("guild.php?place=scg");
	equipBaseline();
	return true;
}


boolean cc_nemesisIsland()
{
	if(get_property("lastGuildStoreOpen").to_int() < my_ascensions())
	{
		return false;
	}
	if(get_property("questG04Nemesis") != "step14")
	{
		return false;
	}
	if(!possessEquipment(cc_guildEpicWeapon()))
	{
		return false;
	}
//	equipBaseline();

	location nemesisArea = $location[none];

	switch(my_class())
	{
	case $class[Turtle Tamer]:
		return false;
	case $class[Seal Clubber]:
		nemesisArea = $location[The Broodling Grounds];
		break;
	case $class[Pastamancer]:
	case $class[Sauceror]:
	case $class[Accordion Thief]:
	case $class[Disco Bandit]:
		return false;
	}

	while(my_adventures() > 0)
	{
		int count = 0;
		count = count + min(item_amount($item[Hellseal Hide]),6);
		count = count + min(item_amount($item[Hellseal Brain]),6);
		count = count + min(item_amount($item[Hellseal Sinew]),6);
		if(count >= 18)
		{
			break;
		}
		if(!ccAdv(1, nemesisArea))
		{
			abort("Can not access area, aborting.");
		}
	}
	return true;
}

boolean cc_ascendIntoBond()
{
	if(!get_property("_workshedItemUsed").to_boolean())
	{
		if(!(cc_get_campground() contains $item[Asdon Martin Keyfob]))
		{
			if(item_amount($item[Asdon Martin Keyfob]) > 0)
			{
				use(1, $item[Asdon Martin Keyfob]);
			}
		}
	}

	if(my_inebriety() <= inebriety_limit())
	{
		return false;
	}

	declineTrades();

	string temp = visit_url("ascend.php?pwd=&confirm=on&confirm2=on&action=ascend&submit=Ascend", true);
	if(contains_text(temp, "You may not enter the Astral Gash again until tomorrow."))
	{
		print("Could not ascend, refractory period required.", "red");
		return false;
	}
	temp = visit_url("afterlife.php?action=pearlygates");

	string permery_text = visit_url("afterlife.php?place=permery");
	if(!permery_text.contains_text("It looks like you've already got all of the skills from your last life marked permanent."))
	{
		abort("perm a skill");
		return false;
	}

	temp = visit_url("afterlife.php?action=buydeli&whichitem=" + to_int($item[Carton Of Astral Energy Drinks]), true);

	temp = visit_url("afterlife.php?place=armory");
	if(contains_text(temp, "astral pet sweater"))
	{
		temp = visit_url("afterlife.php?action=buyarmory&whichitem=5040", true);
	}
	else
	{
		temp = visit_url("afterlife.php?action=buyarmory&whichitem=5037", true);
	}
	temp = visit_url("afterlife.php?place=reincarnate");
	int gender = 1;
	if(contains_text(temp, "option selected value=2>Female"))
	{
		gender = 2;
	}
	temp = visit_url("afterlife.php?action=ascend&asctype=2&whichclass=" + to_int($class[Seal Clubber]) +"&gender=" + gender + "&whichpath=30&whichsign=3", true);
	temp = visit_url("afterlife.php?action=ascend&confirmascend=1&asctype=2&whichclass=" + to_int($class[Seal Clubber]) + "&gender=" + gender + "&whichpath=30&whichsign=3&noskillsok=1&lamesignok=1&nopetok=1", true);


	temp = visit_url("choice.php?pwd=&whichchoice=1257&option=1");
	temp = visit_url("choice.php?pwd=&whichchoice=1258&option=2");
	temp = visit_url("main.php");
	temp = visit_url("api.php?what=status&for=4", false);

	return true;
}



boolean cc_ascendIntoCS()
{
	if(my_inebriety() <= inebriety_limit())
	{
		return false;
	}
	if(my_adventures() >= 3)
	{
		return false;
	}

	declineTrades();

	string temp = visit_url("ascend.php?pwd=&confirm=on&confirm2=on&action=ascend&submit=Ascend", true);
	temp = visit_url("afterlife.php?action=pearlygates");

	string permery_text = visit_url("afterlife.php?place=permery");
	if(!permery_text.contains_text("It looks like you've already got all of the skills from your last life marked permanent."))
	{
		abort("perm a skill");
		return false;
	}

	temp = visit_url("afterlife.php?action=buydeli&whichitem=5046", true);

	temp = visit_url("afterlife.php?place=armory");
	if(contains_text(temp, "astral pet sweater"))
	{
		temp = visit_url("afterlife.php?action=buyarmory&whichitem=5040", true);
	}
	else
	{
		temp = visit_url("afterlife.php?action=buyarmory&whichitem=5037", true);
	}
	temp = visit_url("afterlife.php?place=reincarnate");
	int gender = 1;
	if(contains_text(temp, "option selected value=2>Female"))
	{
		gender = 2;
	}
	temp = visit_url("afterlife.php?action=ascend&asctype=3&whichclass=4&gender=" + gender + "&whichpath=25&whichsign=2", true);
	temp = visit_url("afterlife.php?action=ascend&confirmascend=1&asctype=3&whichclass=4&gender=" + gender + "&whichpath=25&whichsign=2&noskillsok=1", true);

	return true;
}

boolean cc_aftercore()
{
	return cc_cheeseAftercore(0);
}
boolean cc_aftercore(int leave)
{
	return cc_cheeseAftercore(leave);
}

boolean cc_cheeseAftercore(int leave)
{
	return cc_cheesePostCS(leave);
}

boolean cc_cheesePostCS()
{
	return cc_cheesePostCS(0);
}

boolean cc_cheesePostCS(int leave)
{
	int startMeat = my_meat();
	if(!didWePlantHere($location[Barf Mountain]) && florist_available() && (my_adventures() > 0) && (inebriety_left() >= 0))
	{
		ccAdv(1, $location[Barf Mountain]);
		cli_execute("florist plant stealing magnolia");
		cli_execute("florist plant pitcher plant");
		cli_execute("florist plant aloe guv'nor");
	}

	location loc = $location[Barf Mountain];
	if(get_property("eldritchFissureAvailable").to_boolean())
	{
//		loc = $location[An Eldritch Fissure];
	}
	if(get_property("eldritchHorrorAvailable").to_boolean())
	{
//		loc = $location[An Eldritch Horror];
//		loc = $location[An Eldritch Fissure];
	}

	if(hippy_stone_broken())
	{
		deck_cheat("fites");
	}
	deck_cheat("Ancestral Recall");
	deck_cheat("Island");
	deck_cheat("Year of Plenty");

	if(item_amount($item[Time-Spinner]) > 0)
	{
		if(!get_property("_timeSpinnerReplicatorUsed").to_boolean())
		{
			cli_execute("FarFuture booze");
		}

		while(get_property("_timeSpinnerMinutesUsed").to_int() <= 8)
		{
			cli_execute("FarFuture none");
		}
	}

	while(lx_witchess());
	while(lx_freecombats());

    if(!get_property("_pottedTeaTreeUsed").to_boolean() && (get_campground() contains $item[Potted Tea Tree]))
	{
		cli_execute("teatree cuppa royal tea");
		put_closet(item_amount($item[Cuppa Royal Tea]), $item[Cuppa Royal Tea]);
	}


	while((get_property("_sourceTerminalExtrudes").to_int() < 3) && contains_text(get_property("sourceTerminalExtrudeKnown"),"booze.ext") && (item_amount($item[Source Essence]) >= 10))
	{
		cc_sourceTerminalExtrude($item[Hacked Gibson]);
	}
	while((my_mp() < 100) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available() && (inebriety_left() > 0))
	{
		doRest();
	}

	take_storage(storage_amount($item[Cold Hi Mein]), $item[Cold Hi Mein]);
	while((fullness_left() >= 5) && (item_amount($item[Cold Hi Mein]) > 0) && (my_level() >= 13))
	{
		buffMaintain($effect[Got Milk], 0, 1, 5);
		eat(1, $item[Cold Hi Mein]);
	}

	while((inebriety_left() >= 1) && (item_amount($item[Astral Pilsner]) > 0))
	{
		buffMaintain($effect[Ode to Booze], 50, 1, 1);
		drink(1, $item[Astral Pilsner]);
	}


	while((inebriety_left() >= 4) && (item_amount($item[Hacked Gibson]) > 0))
	{
		buffMaintain($effect[Ode to Booze], 50, 1, 4);
		drink(1, $item[Hacked Gibson]);
	}
	while((inebriety_left() >= 1) && (item_amount($item[Sacramento Wine]) > 0))
	{
		buffMaintain($effect[Ode to Booze], 50, 1, 1);
		drink(1, $item[Sacramento Wine]);
	}

	while((spleen_left() >= 4) && (item_amount($item[Agua de Vida]) > 0))
	{
		chew(1, $item[Agua de Vida]);
	}
	while((spleen_left() >= 4) && (item_amount($item[Unconscious Collective Dream Jar]) > 0))
	{
		chew(1, $item[Unconscious Collective Dream Jar]);
	}
	while((spleen_left() >= 3) && (item_amount($item[Carrot Juice]) > 0))
	{
		chew(1, $item[Carrot Juice]);
	}
	while((spleen_left() >= 1) && (item_amount($item[Twinkly Wad]) > 0))
	{
		chew(1, $item[Twinkly Wad]);
	}

	cc_sourceTerminalEducate($skill[Extract], $skill[Turbo]);
	cc_sourceTerminalEnhance("meat");
	cc_sourceTerminalEnhance("meat");
	cc_sourceTerminalEnhance("items");


	boolean oldGarbage = get_property("cc_getDinseyGarbageMoney").to_boolean();
	set_property("cc_getDinseyGarbageMoney", true);
	dinseylandfill_garbageMoney();
	set_property("cc_getDinseyGarbageMoney", oldGarbage);

	getDiscoStyle(7);
	volcano_bunkerJob();
	change_mcd(0);

	if(my_daycount() == 2)
	{

	}

	if((item_amount($item[Confusing LED Clock]) > 0) && hippy_stone_broken() && (my_adventures() >= 6) && !get_property("_confusingLEDClockUsed").to_boolean())
	{
		use(1, $item[Confusing LED Clock]);
		if(cc_get_campground() contains $item[Confusing LED Clock])
		{
			visit_url("campground.php?action=rest");
			if(cc_get_campground() contains $item[Confusing LED Clock])
			{
				print("Was unable to use Confusing LED Clock", "red");
			}
			else
			{
				set_property("_confusingLEDClockUsed", true);
			}
		}
		else
		{
			print("Could not place a Confusing LED Clock", "red");
		}
	}
	if(item_amount($item[The Crown of Ed the Undying]) > 0)
	{
		equip($item[The Crown of Ed the Undying]);
		adjustEdHat("meat");
	}
	if(item_amount($item[Camp Scout Backpack]) > 0)
	{
		equip($item[Camp Scout Backpack]);
	}
	if(item_amount($item[Buddy Bjorn]) > 0)
	{
		equip($item[Buddy Bjorn]);
		bjornify_familiar($familiar[Warbear Drone]);
	}
	if(item_amount($item[Sneaky Pete\'s Leather Jacket]) > 0)
	{
		equip($item[Sneaky Pete\'s Leather Jacket]);
	}
	if(item_amount($item[Thor\'s Pliers]) > 0)
	{
		equip($item[Thor\'s Pliers]);
	}
	if((item_amount($item[Garbage Sticker]) > 0) && can_equip($item[Garbage Sticker]))
	{
		equip($item[Garbage Sticker]);
	}
	if(item_amount($item[Operation Patriot Shield]) > 0)
	{
		equip($item[Operation Patriot Shield]);
	}
	if((item_amount($item[Silver Cow Creamer]) > 0) && can_equip($item[Silver Cow Creamer]))
	{
		equip($item[Silver Cow Creamer]);
	}
	if(item_amount($item[Pantsgiving]) > 0)
	{
		equip($item[Pantsgiving]);
	}
	if(item_amount($item[Cheap Sunglasses]) > 0)
	{
		equip($slot[acc1], $item[Cheap Sunglasses]);
	}
	if(item_amount($item[Incredibly Dense Meat Gem]) > 0)
	{
		equip($slot[acc2], $item[Incredibly Dense Meat Gem]);
	}
	else if(item_amount($item[Sister Accessory]) > 0)
	{
		equip($slot[acc2], $item[Sister Accessory]);
	}
	if(item_amount($item[Mr. Screege\'s Spectacles]) > 0)
	{
		equip($slot[acc3], $item[Mr. Screege\'s Spectacles]);
	}
	else if(item_amount($item[Mr. Cheeng\'s Spectacles]) > 0)
	{
		equip($slot[acc3], $item[Mr. Cheeng\'s Spectacles]);
	}

	while((my_adventures() > leave) && (inebriety_left() >= 0))
	{
		print("Have " + my_adventures() + " with target of " + leave + " adventures.", "orange");
		buffMaintain($effect[Polka of Plenty], 10, 1, 1);
		buffMaintain($effect[Leisurely Amblin\'], 50, 1, 1);
		buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		asdonBuff($effect[Driving Observantly]);
		if(have_effect($effect[meat.enh]) == 0)
		{
			cc_sourceTerminalEnhance("meat");
		}

		if(get_property("cc_interrupt").to_boolean())
		{
			set_property("cc_interrupt", false);
			abort("Abort requested.");
		}
		if((fullness_left() > 0) && (item_amount($item[Jumping Horseradish]) > 0))
		{
			eatsilent(1, $item[Jumping Horseradish]);
		}

		if((closet_amount($item[Infinite BACON Machine]) > 0) && !get_property("_baconMachineUsed").to_boolean())
		{
			take_closet(1, $item[Infinite BACON Machine]);
			use(1, $item[Infinite BACON Machine]);
			put_closet(1, $item[Infinite BACON Machine]);
		}


		if(item_amount($item[Infinite BACON Machine]) > 0)
		{
			if(have_familiar($familiar[Hobo Monkey]))
			{
				handleFamiliar($familiar[Hobo Monkey]);
			}
			else
			{
				handleFamiliar($familiar[Golden Monkey]);
			}
		}
		else
		{
			handleFamiliar($familiar[Intergnat]);
		}
		if(item_amount($item[Snow Suit]) > 0)
		{
			equip($item[Snow Suit]);
		}
		foreach fam in $familiars[Unconscious Collective, Li\'l Xenomorph, Bloovian Groose, Golden Monkey, Rogue Program, Space Jellyfish, Grim Brother, Fist Turkey, Rockin\' Robin, Optimistic Candle, Intergnat]
		{
			if(($familiars[Rockin\' Robin] contains fam) && (get_property("rockinRobinProgress").to_int() >= 25))
			{
				handleFamiliar(fam);
				break;
			}
			if(($familiars[Optimistic Candle] contains fam) && (get_property("optimisticCandleProgress").to_int() >= 25))
			{
				handleFamiliar(fam);
				break;
			}
			if(($familiars[Intergnat] contains fam) && (item_amount($item[BACON]) < 150000) && (available_amount($item[First Post Shirt - Cir Senam]) == 0))
			{
				handleFamiliar(fam);
				break;
			}
			if($familiars[Unconscious Collective, Li\'l Xenomorph, Bloovian Groose, Golden Monkey, Rogue Program, Grim Brother, Fist Turkey] contains fam)
			{
				if(fam.drops_today < 5)
				{
					handleFamiliar(fam);
					break;
				}
			}
			if(($familiars[Space Jellyfish] contains fam) && (get_property("_spaceJellyfishDrops").to_int() < 3) && (loc == $location[Barf Mountain]))
			{
				handleFamiliar(fam);
				break;
			}
		}

		boolean restoreEquip = false;
		item acc1 = equipped_item($slot[acc1]);
		item acc2 = equipped_item($slot[acc2]);
		item acc3 = equipped_item($slot[acc3]);
		item back = equipped_item($slot[back]);
		if(get_property("dinseyRollercoasterNext").to_boolean())
		{
			restoreEquip = true;
			if(item_amount($item[Lucky Crimbo Tiki Necklace]) > 0)
			{
				equip($slot[acc1], $item[Lucky Crimbo Tiki Necklace]);
			}
			if(item_amount($item[Lucky Crimbo Tiki Necklace]) > 0)
			{
				equip($slot[acc2], $item[Lucky Crimbo Tiki Necklace]);
			}
			if(item_amount($item[Lucky Crimbo Tiki Necklace]) > 0)
			{
				equip($slot[acc3], $item[Lucky Crimbo Tiki Necklace]);
			}
		}

		if(expectGhostReport())
		{
			if((back != $item[Protonic Accelerator Pack]) && (item_amount($item[Protonic Accelerator Pack]) > 0))
			{
				equip($slot[back], $item[Protonic Accelerator Pack]);
			}
		}

		if(loc == $location[An Eldritch Fissure])
		{
			if(equipped_item($slot[off-hand]) != $item[Science Notebook])
			{
				equip($slot[off-hand], $item[Science Notebook]);
			}
			if(equipped_item($slot[hat]) != $item[Eldritch Scanner])
			{
				equip($slot[hat], $item[Eldritch Scanner]);
			}
			#buffMaintain($effect[Eldritch Alignment], 0, 1, 1);
		}

		ccAdv(1, loc);
		LX_ghostBusting();

		if((back != $item[Protonic Accelerator Pack]) && (equipped_item($slot[back]) == $item[Protonic Accelerator Pack]))
		{
			equip($slot[back], back);
		}

		if(restoreEquip)
		{
			if(equipped_item($slot[acc1]) == $item[Lucky Crimbo Tiki Necklace])
			{
				equip($slot[acc1], acc1);
			}
			if(equipped_item($slot[acc2]) == $item[Lucky Crimbo Tiki Necklace])
			{
				equip($slot[acc2], acc2);
			}
			if(equipped_item($slot[acc3]) == $item[Lucky Crimbo Tiki Necklace])
			{
				equip($slot[acc3], acc3);
			}
		}

		doNumberology("fites3");

		if(have_effect($effect[How to Scam Tourists]) == 2)
		{
			while((my_adventures() > 0) && volcano_lavaDogs());
			if(have_effect($effect[Drenched in Lava]) > 0)
			{
				doHottub();
			}
		}

		if((my_adventures() > leave) && (get_property("lastDMTDuplication").to_int() < my_ascensions()) && (item_amount($item[Clara\'s Bell]) > 0))
		{
			item toGet = $item[Eldritch Elixir];
			if(item_amount(toGet) == 0)
			{
				take_storage(1, toGet);
			}
			if((get_property("lastDMTDuplication").to_int() < my_ascensions()) && (item_amount(toGet) > 0))
			{
				if(!get_property("_claraBellUsed").to_boolean())
				{
					use(1, $item[Clara\'s Bell]);
				}
				handleFamiliar($familiar[Machine Elf]);
				use_familiar($familiar[Machine Elf]);
				string temp = visit_url("adventure.php?snarfblat=458");
				temp = visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1119&option=4");
				temp = visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1125&option=1&iid=" + to_int(toGet));
				set_property("lastDMTDuplication", my_ascensions());
			}
			put_closet(item_amount(toGet), toGet);
		}
	}

	if(item_amount($item[Infinite BACON Machine]) > 0)
	{
		if(have_familiar($familiar[Hobo Monkey]))
		{
			handleFamiliar($familiar[Hobo Monkey]);
		}
		else
		{
			handleFamiliar($familiar[Golden Monkey]);
		}
	}
	else
	{
		handleFamiliar($familiar[Intergnat]);
	}
	if(item_amount($item[Snow Suit]) > 0)
	{
		equip($item[Snow Suit]);
	}


	while((inebriety_left() >= 5) && get_property("cc_breakstone").to_boolean())
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
			break;
		}
		drink(1, $item[5-Hour Acrimony]);
	}


	while((inebriety_left() >= 2) && get_property("cc_breakstone").to_boolean())
	{
		if(!buyUpTo(1, $item[Beery Blood], 500))
		{
			print("Could not buy Beery Blood, price too high", "red");
			break;
		}
		drink(1, $item[Beery Blood]);
	}

	if(fullness_left() > 0)
	{
		put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
		tryPantsEat();
		cli_execute("refresh all");
	}

	while((my_adventures() > leave) && (inebriety_left() >= 0))
	{
		if(loc == $location[Barf Mountain])
		{
			buffMaintain($effect[Polka of Plenty], 10, 1, 1);
			buffMaintain($effect[Leisurely Amblin\'], 50, 1, 1);
			buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		}
		ccAdv(1, loc);
	}

	if(fullness_left() > 0)
	{
		put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
		tryPantsEat();
		cli_execute("refresh all");
	}

	while((my_adventures() > leave) && (inebriety_left() >= 0))
	{
		if(loc == $location[Barf Mountain])
		{
			buffMaintain($effect[Polka of Plenty], 10, 1, 1);
			buffMaintain($effect[Leisurely Amblin\'], 50, 1, 1);
			buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		}
		ccAdv(1, loc);
	}

	if(fullness_left() > 0)
	{
		put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
		tryPantsEat();
		cli_execute("refresh all");
	}

	while((my_adventures() > leave) && (inebriety_left() >= 0))
	{
		if(loc == $location[Barf Mountain])
		{
			buffMaintain($effect[Polka of Plenty], 10, 1, 1);
			buffMaintain($effect[Leisurely Amblin\'], 50, 1, 1);
			buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		}
		ccAdv(1, loc);
	}
	#use_barrels();

	if((item_amount($item[CSA fire-starting kit]) > 0) && !get_property("_fireStartingKitUsed").to_boolean() && hippy_stone_broken())
	{
		set_property("choiceAdventure595", 1);
		use(1, $item[CSA fire-starting kit]);
	}

	if((item_amount($item[Rain-Doh Indigo Cup]) > 0) && (item_amount($item[Spooky Putty Sheet]) > 0))
	{
		//Use Spooky Putty Sheet and Rain-Doh Indigo Cup to make copies of a fax monster and fight it
		//Black Crayon Fish or something seems good (or other free monster?)
	}

	if((my_adventures() > 0) && (my_inebriety() <= inebriety_limit()))
	{
		print("Adventures are leftover, not finishing overdrinking and PVP", "red");
		return true;
	}

	if((item_amount($item[School of Hard Knocks Diploma]) > 0) && (!get_property("_hardKnocksDiplomaUsed").to_boolean()))
	{
		use(1, $item[School of Hard Knocks Diploma]);
	}

	if((item_amount($item[5-hour acrimony]) == 0) && hippy_stone_broken())
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
		}
	}
	if(hippy_stone_broken())
	{
		if((item_amount($item[5-hour acrimony]) > 0) && (my_inebriety() <= inebriety_limit()))
		{
			cli_execute("drink 5-hour acrimony");
		}
		if(get_property("cc_pvpOutfit") != "")
		{
			cli_execute("/outfit " + get_property("cc_pvpOutfit"));
		}
		cli_execute("pvp loot 10");
	}
	int endMeat = my_meat();
	int gainedMeat = endMeat - startMeat;
	print("Meat gained:  " + gainedMeat, "blue");
	cli_execute("cc_ascend");
	print("Meat gained:  " + gainedMeat, "blue");
	return true;
}

boolean cc_doCS()
{
	cli_execute("cc_ascend");
	cc_aftercore();
	cc_ascendIntoCS();
	cli_execute("cc_ascend");
	return true;
}
