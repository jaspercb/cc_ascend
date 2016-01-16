script "cc_aftercore.ash"
import "cc_ascend.ash"

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
boolean cc_ascendIntoCS();
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
		adv1($location[The Daily Dungeon], 1, "cc_combatHandler");
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

	if(!get_property("_fishyPipeUsed").to_boolean())
	{
		use(1, $item[Fishy Pipe]);
	}
	if(!get_property("_bagOTricksUsed").to_boolean())
	{
		use(1, $item[Bag O\' Tricks]);
	}
	getDiscoStyle(6);
	visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");

	if(get_property("cc_dinseyGarbageMoney").to_int() < my_daycount())
	{	
		set_property("cc_dinseyGarbageMoney", my_daycount());
		visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
		visit_url("choice.php?pwd=&whichchoice=1067&option=6",true);
		visit_url("main.php");
	}

	handleFamiliar($familiar[Artistic Goth Kid]);
	if(equipped_item($slot[Familiar]) != $item[Das Boot])
	{
		equip($item[Das Boot]);
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

boolean cc_ascendIntoCS()
{
	if(my_inebriety() <= inebriety_limit())
	{
		return false;
	}
	visit_url("ascend.php?pwd=&confirm=on&confirm2=on&action=ascend&submit=Ascend", true);
	visit_url("afterlife.php?action=pearlygates");
	visit_url("afterlife.php?action=buydeli&whichitem=5046", true);
	visit_url("afterlife.php?action=buyarmory&whichitem=5037", true);
	string page = visit_url("afterlife.php?place=reincarnate");
	int gender = 1;
	if(contains_text(page, "option selected value=2>Female"))
	{
		gender = 2;
	}
	visit_url("afterlife.php?action=ascend&asctype=3&whichclass=4&gender=" + gender + "&whichpath=25&whichsign=2", true);
	visit_url("afterlife.php?action=ascend&confirmascend=1&asctype=3&whichclass=4&gender=" + gender + "&whichpath=25&whichsign=2&noskillsok=1", true);

	return true;
}


boolean cc_cheesePostCS()
{
	if(!didWePlantHere($location[Barf Mountain]) && florist_available())
	{
		ccAdv(1, $location[Barf Mountain]);
		cli_execute("florist plant stealing magnolia");
		cli_execute("florist plant pitcher plant");
		cli_execute("florist plant aloe guv'nor");
	}

	while(((my_spleen_use() + 4) <= spleen_limit()) && (item_amount($item[Unconscious Collective Dream Jar]) > 0))
	{
		chew(1, $item[Unconscious Collective Dream Jar]);
	}
	while(((my_spleen_use() + 1) <= spleen_limit()) && (item_amount($item[Twinkly Wad]) > 0))
	{
		chew(1, $item[Twinkly Wad]);
	}

	boolean oldGarbage = get_property("cc_getDinseyGarbageMoney").to_boolean();
	set_property("cc_getDinseyGarbageMoney", true);
	dinseylandfill_garbageMoney();
	set_property("cc_getDinseyGarbageMoney", oldGarbage);

	getDiscoStyle();
	visit_url("place.php?whichplace=airport_hot&action=airport4_zone1");
	run_choice(7);


	if((item_amount($item[Confusing LED Clock]) > 0) && get_property("cc_breakstone").to_boolean())
	{
		use(1, $item[Confusing LED Clock]);
		visit_url("campground.php?action=rest");
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
	if(item_amount($item[Sneaky Pete\'s Leather Jacket]) > 0)
	{
		equip($item[Sneaky Pete\'s Leather Jacket]);
	}
	if(item_amount($item[Thor\'s Pliers]) > 0)
	{
		equip($item[Thor\'s Pliers]);
	}
	if(item_amount($item[Operation Patriot Shield]) > 0)
	{
		equip($item[Operation Patriot Shield]);
	}
	if(item_amount($item[Pantsgiving]) > 0)
	{
		equip($item[Pantsgiving]);
	}
	if(item_amount($item[Cheap Sunglasses]) > 0)
	{
		equip($slot[acc1], $item[Cheap Sunglasses]);
	}
	if(item_amount($item[Sister Accessory]) > 0)
	{
		equip($slot[acc2], $item[Sister Accessory]);
	}
	if(item_amount($item[Mr. Cheeng\'s Spectacles]) > 0)
	{
		equip($slot[acc3], $item[Mr. Cheeng\'s Spectacles]);
	}
	handleFamiliar($familiar[Golden Monkey]);
	if(item_amount($item[Snow Suit]) > 0)
	{
		equip($item[Snow Suit]);
	}

#	use(1 + ((my_adventures() + 9)/20), $item[How to Avoid Scams]);
	while(my_adventures() > 0)
	{
		buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		ccAdv(1, $location[Barf Mountain]);
	}

	while(((my_inebriety() + 5) <= inebriety_limit()) && get_property("cc_breakstone").to_boolean())
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
			break;
		}
		drink(1, $item[5-Hour Acrimony]);
	}


	while(((my_inebriety() + 2) <= inebriety_limit()) && get_property("cc_breakstone").to_boolean())
	{
		if(!buyUpTo(1, $item[Beery Blood], 500))
		{
			print("Could not buy Beery Blood, price too high", "red");
			break;
		}
		drink(1, $item[Beery Blood]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		ccAdv(1, $location[Barf Mountain]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		ccAdv(1, $location[Barf Mountain]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
		ccAdv(1, $location[Barf Mountain]);
	}
	use_barrels();

	if((item_amount($item[CSA fire-starting kit]) > 0) && !get_property("_fireStartingKitUsed").to_boolean() && get_property("cc_breakstone").to_boolean())
	{
		set_property("choiceAdventure595", 1);
		use(1, $item[CSA fire-starting kit]);
	}

	if((item_amount($item[5-hour acrimony]) == 0) && get_property("cc_breakstone").to_boolean())
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
		}
	}
	if(get_property("cc_breakstone").to_boolean())
	{
		cli_execute("drink 5-hour acrimony");
		cli_execute("pvp loot 1");
	}
	cli_execute("cc_ascend");
	return true;
}


boolean cc_cheesePostCSWalford()
{
	while(((my_spleen_use() + 4) <= spleen_limit()) && (item_amount($item[Unconscious Collective Dream Jar]) > 0))
	{
		chew(1, $item[Unconscious Collective Dream Jar]);
	}
	while(((my_spleen_use() + 1) <= spleen_limit()) && (item_amount($item[Twinkly Wad]) > 0))
	{
		chew(1, $item[Twinkly Wad]);
	}

	boolean oldGarbage = get_property("cc_getDinseyGarbageMoney").to_boolean();
	set_property("cc_getDinseyGarbageMoney", true);
	dinseylandfill_garbageMoney();
	set_property("cc_getDinseyGarbageMoney", oldGarbage);

	getDiscoStyle(6);

	//Equip Ice Hole Equipment

	if(!didWePlantHere($location[The Ice Hole]) && (my_location() == $location[The Ice Hole]))
	{
		ccAdv(1, $location[The Ice Hole]);
		cli_execute("florist plant kelptomaniac");
		cli_execute("florist plant orca orchid");
		cli_execute("florist plant snori");
	}

	//While bucket < 100 and enough adventures, Ice Hole
	//Return bucket, get new bucket
	//While bucket < 100 and enough adventures, Ice Hole

	//Ice Hotel Equipment
	//Assume mayfly
	//Until adventures > 0, Ice Hotel
	//Set Choice == 5, when previous adv == choice 5, set choice 4

	//set choice back to 0


	if(item_amount($item[Confusing LED Clock]) > 0)
	{
		use(1, $item[Confusing LED Clock]);
		visit_url("campground.php?action=rest");
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
	if(item_amount($item[Sneaky Pete\'s Leather Jacket]) > 0)
	{
		equip($item[Sneaky Pete\'s Leather Jacket]);
	}
	if(item_amount($item[Thor\'s Pliers]) > 0)
	{
		equip($item[Thor\'s Pliers]);
	}
	if(item_amount($item[Operation Patriot Shield]) > 0)
	{
		equip($item[Operation Patriot Shield]);
	}
	if(item_amount($item[Pantsgiving]) > 0)
	{
		equip($item[Pantsgiving]);
	}
	if(item_amount($item[Cheap Sunglasses]) > 0)
	{
		equip($slot[acc1], $item[Cheap Sunglasses]);
	}
	if(item_amount($item[Sister Accessory]) > 0)
	{
		equip($slot[acc2], $item[Sister Accessory]);
	}
	if(item_amount($item[Mr. Cheeng\'s Spectacles]) > 0)
	{
		equip($slot[acc3], $item[Mr. Cheeng\'s Spectacles]);
	}
	handleFamiliar($familiar[Golden Monkey]);
	if(item_amount($item[Snow Suit]) > 0)
	{
		equip($item[Snow Suit]);
	}

	use(1 + ((my_adventures() + 9)/20), $item[How to Avoid Scams]);
	while(my_adventures() > 0)
	{
		ccAdv(1, $location[Barf Mountain]);
	}

	while((my_inebriety() + 5) <= inebriety_limit())
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
			break;
		}
		drink(1, $item[5-Hour Acrimony]);
	}


	while((my_inebriety() + 2) <= inebriety_limit())
	{
		if(!buyUpTo(1, $item[Beery Blood], 500))
		{
			print("Could not buy Beery Blood, price too high", "red");
			break;
		}
		drink(1, $item[Beery Blood]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		ccAdv(1, $location[Barf Mountain]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		ccAdv(1, $location[Barf Mountain]);
	}

	put_closet(item_amount($item[Deviled Egg]), $item[Deviled Egg]);
	tryPantsEat();
	cli_execute("refresh all");

	while(my_adventures() > 0)
	{
		ccAdv(1, $location[Barf Mountain]);
	}
	use_barrels();

	if((item_amount($item[CSA fire-starting kit]) > 0) && !get_property("_fireStartingKitUsed").to_boolean())
	{
		set_property("choiceAdventure595", 1);
		use(1, $item[CSA fire-starting kit]);
	}

	if(item_amount($item[5-hour acrimony]) == 0)
	{
		if(!buyUpTo(1, $item[5-Hour Acrimony], 5000))
		{
			print("Could not buy 5-Hour Acrimony, price too high", "red");
		}
	}
	cli_execute("drink 5-hour acrimony");

	cli_execute("pvp loot 1");
	cli_execute("cc_ascend");
	return true;
}


boolean cc_doCS()
{
	cli_execute("cc_ascend");
//	if(item_amount($item[Blood-Drive Sticker]) > 0)
//	{
//		cc_cheesePostCSWalford();
//	}
//	else
//	{
		cc_cheesePostCS();
//	}
	cc_ascendIntoCS();
	cli_execute("cc_ascend");
	return true;
}

