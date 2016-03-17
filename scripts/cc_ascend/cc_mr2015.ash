script "cc_mr2015.ash"
import<cc_ascend/cc_ascend_header.ash>
import<cc_ascend/cc_elementalPlanes.ash>

#	This is meant for items that have a date of 2015
#	Handling: shrine to the Barrel God, Chateau Mantegna Room Key, Deck of Every Card
#



boolean cc_barrelPrayers();

boolean chateaumantegna_available();
void chateaumantegna_useDesk();
boolean chateaumantegna_havePainting();
boolean chateaumantegna_usePainting(string option);
boolean chateaumantegna_usePainting();
boolean[item] chateaumantegna_decorations();
void chateaumantegna_buyStuff(item toBuy);
boolean chateaumantegna_nightstandSet();

boolean deck_available();
int deck_draws_left();
boolean deck_draw();
boolean deck_cheat(string cheat);
boolean deck_useScheme(string action);



//Supplemental





boolean cc_barrelPrayers()
{
	if(!is_unrestricted($item[Shrine to the Barrel God]))
	{
		return false;
	}
	if(get_property("_barrelPrayer").to_boolean())
	{
		return false;
	}
	if(!get_property("barrelShrineUnlocked").to_boolean())
	{
		string temp = visit_url("da.php");
		if(!get_property("barrelShrineUnlocked").to_boolean())
		{
			return false;
		}
	}
	if(get_property("kingLiberated").to_boolean())
	{
		return false;
	}

	boolean[string] prayers;

	if(my_path() == "Avatar of West of Loathing")
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Glamour, Vigor, Protection];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}
	else if(my_path() == "Community Service")
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Glamour, Vigor, Protection];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}
	else if(my_path() == "Actually Ed the Undying")
	{
		if((elementalPlanes_access($element[spooky])) && (get_property("edPoints").to_int() >= 2))
		{
			switch(my_daycount())
			{
			case 1:				prayers = $strings[Protection, Glamour, Vigor];		break;
			case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
			case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
			case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
			}
		}
		else
		{
			switch(my_daycount())
			{
			case 1:				prayers = $strings[Glamour, Vigor, Protection];		break;
			case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
			case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
			case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
			}
		}
	}
	else
	{
		switch(my_daycount())
		{
		case 1:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 2:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 3:				prayers = $strings[Protection, Glamour, Vigor];		break;
		case 4:				prayers = $strings[Protection, Glamour, Vigor];		break;
		}
	}

	foreach prayer in prayers
	{
		if(!get_property("prayedFor" + prayer).to_boolean())
		{
			boolean buff = cli_execute("barrelprayer " + prayer);
			return true;
		}
	}

	return false;
}






boolean chateaumantegna_available()
{
	if(get_property("chateauAvailable").to_boolean() && is_unrestricted($item[Chateau Mantegna Room Key]))
	{
		return true;
	}
	if(contains_text(visit_url("mountains.php"),"whichplace=chateau") && is_unrestricted($item[Chateau Mantegna Room Key]))
	{
		return true;
	}
	return false;
}

void chateaumantegna_useDesk()
{
	if(chateaumantegna_available())
	{
		string chateau = visit_url("place.php?whichplace=chateau");
		if(contains_text(chateau, "chateau_desk1"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk1");
		}
		else if(contains_text(chateau, "chateau_desk2"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk2");
		}
		else if(contains_text(chateau, "chateau_desk3"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk3");
		}
	}
}

boolean chateaumantegna_havePainting()
{
	if(chateaumantegna_available())
	{
		return !get_property("_chateauMonsterFought").to_boolean();
	}
	return false;
}



boolean chateaumantegna_usePainting(string option)
{
	if(!chateaumantegna_available())
	{
		return false;
	}
	if(get_property("_chateauMonsterFought").to_boolean())
	{
		return false;
	}

	if(get_property("chateauMonster") == $monster[lobsterfrogman])
	{
		if(item_amount($item[Barrel of Gunpowder]) >= 5)
		{
			return false;
		}
		if(get_property("sidequestLighthouseCompleted") != "none")
		{
			return false;
		}
	}
	if(get_property("chateauMonster") == $monster[Bram the Stoker])
	{
		if(have_equipped($item[Bram\'s Choker]) || (item_amount($item[Bram\'s Choker]) > 0))
		{
			return false;
		}
	}
	if(get_property("chateauMonster") == $monster[Writing Desk])
	{
		if(get_property("writingDesksDefeated").to_int() >= 5)
		{
			return false;
		}
	}
	if(get_property("chateauMonster") == $monster[Ninja Snowman Assassin])
	{
		if((item_amount($item[Ninja Carabiner]) > 0) && (item_amount($item[Ninja Crampons]) > 0) && (item_amount($item[Ninja Rope]) > 0))
		{
			return false;
		}
	}
	if(get_property("chateauMonster") == $monster[Mountain Man])
	{
		if((get_property("cc_trapper") == "yeti") || (get_property("cc_trapper") == "finished"))
		{
			return false;
		}
		item oreGoal = to_item(get_property("trapperOre"));
		if(item_amount(oreGoal) >= 3)
		{
			return false;
		}
	}
	if(chateaumantegna_available())
	{
		return ccAdvBypass("place.php?whichplace=chateau&action=chateau_painting", $location[Noob Cave], option);
#		visit_url("place.php?whichplace=chateau&action=chateau_painting");
#		return contains_text(visit_url("main.php"), "Combat");
	}
	return false;
}

boolean chateaumantegna_usePainting()
{
	return chateaumantegna_usePainting("");
}

boolean[item] chateaumantegna_decorations()
{
	boolean[item] retval;
	if(!chateaumantegna_available())
	{
		return retval;
	}
	string chateau = to_lower_case(visit_url("place.php?whichplace=chateau"));
	if(contains_text(chateau, "electric muscle stimulator"))
	{
		retval[$item[Electric Muscle Stimulator]] = true;
	}
	else if(contains_text(chateau, "foreign language tapes"))
	{
		retval[$item[Foreign Language Tapes]] = true;
	}
	else if(contains_text(chateau, "bowl of potpourri"))
	{
		retval[$item[Bowl of Potpourri]] = true;
	}
	if(contains_text(chateau, "antler chandelier"))
	{
		retval[$item[Antler Chandelier]] = true;
	}
	else if(contains_text(chateau, "artificial skylight"))
	{
		retval[$item[Artificial Skylight]] = true;
	}
	else if(contains_text(chateau, "ceiling fan"))
	{
		retval[$item[Ceiling Fan]] = true;
	}
	if(contains_text(chateau, "continental juice bar"))
	{
		retval[$item[Continental Juice Bar]] = true;
	}
	else if(contains_text(chateau, "fancy stationery set"))
	{
		retval[$item[Fancy Stationery Set]] = true;
	}
	else if(contains_text(chateau, "swiss piggy bank"))
	{
		retval[$item[Swiss Piggy Bank]] = true;
	}
	return retval;
}

void chateaumantegna_buyStuff(item toBuy)
{
	if(!chateaumantegna_available())
	{
		return;
	}

	if((toBuy == $item[Electric Muscle Stimulator]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=411&quantity=1", true);
	}
	if((toBuy == $item[Foreign Language Tapes]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=412&quantity=1", true);
	}
	if((toBuy == $item[Bowl of Potpourri]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=413&quantity=1", true);
	}

	if((toBuy == $item[Antler Chandelier]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=415&quantity=1", true);
	}
	if((toBuy == $item[Artificial Skylight]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=416&quantity=1", true);
	}
	if((toBuy == $item[Ceiling Fan]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=414&quantity=1", true);
	}

	if((toBuy == $item[Continental Juice Bar]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=418&quantity=1", true);
	}
	if((toBuy == $item[Fancy Calligraphy Pen]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=419&quantity=1", true);
	}
	if((toBuy == $item[Swiss Piggy Bank]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=417&quantity=1", true);
	}

	if((toBuy == $item[Alpine Watercolor Set]) && (my_meat() >= 5000))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=420&quantity=1", true);
	}
}


boolean chateaumantegna_nightstandSet()
{
	if(!chateaumantegna_available())
	{
		return false;
	}

	stat myStat = my_primestat();
	if(myStat == $stat[none])
	{
		return false;
	}
	if(get_property("kingLiberated").to_boolean())
	{
		return false;
	}

	boolean[item] furniture = chateaumantegna_decorations();
	item need = $item[none];
	if(myStat == $stat[Muscle])
	{
		need = $item[Electric Muscle Stimulator];
	}
	else if(myStat == $stat[Mysticality])
	{
		need = $item[Foreign Language Tapes];
	}
	else if(myStat == $stat[Moxie])
	{
		need = $item[Bowl of Potpourri];
	}

	if(furniture[need])
	{
		return false;
	}
	if(my_meat() < 500)
	{
		return false;
	}
	print("We have the wrong Chateau Nightstand item, replacing.", "blue");
	chateaumantegna_buyStuff(need);
	return true;
}



boolean deck_available()
{
	return ((item_amount($item[Deck of Every Card]) > 0) && is_unrestricted($item[Deck of Every Card]));
}

int deck_draws_left()
{
	if(!deck_available())
	{
		return 0;
	}
	if(my_hp() == 0)
	{
		return 0;
	}
	return 15 - get_property("_deckCardsDrawn").to_int();
}


boolean deck_draw()
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() <= 0)
	{
		return false;
	}
	if(my_hp() == 0)
	{
		return false;
	}
	string page = visit_url("inv_use.php?pwd=&which=3&whichitem=8382");
	page = visit_url("choice.php?pwd=&whichchoice=1085&option=1", true);
	return true;
}

boolean deck_cheat(string cheat)
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() <= 0)
	{
		return false;
	}
	if(my_hp() == 0)
	{
		return false;
	}
	static int [string] cards;
	cards["X of Clubs"] = 1;
	cards["X of Hearts"] = 2;
	cards["X of Diamonds"] = 3;
	cards["X of Spades"] = 4;
	cards["X of Cups"] = 5;
	cards["X of Wands"] = 6;
	cards["X of Swords"] = 7;
	cards["X of Coins"] = 8;
	cards["XIII - Death"] = 9;
	cards["Goblin Sapper"] = 10;

	cards["The Hive"] = 11;
	cards["Hunky Fireman Card"] = 12;
	cards["V - The Hierophant"] = 13;
	cards["XVIII - The Moon"] = 14;
	cards["Werewolf"] = 15;
	cards["XV - The Devil"] = 16;
	cards["Fire Elemental"] = 17;
	cards["Slimer Trading Card"] = 18;
	cards["VII - The Chariot"] = 19;
	cards["II - The High Priestess"] = 20;


	cards["XII - The Hanged Man"] = 21;
	cards["Plantable Greeting Card"] = 22;
	cards["Pirate Birthday Card"] = 23;
	cards["XIV - Temperance"] = 24;
	cards["Unstable Portal"] = 25;
	cards["XVII - The Star"] = 26;
	cards["Suit Warehouse Discount Card"] = 27;
	cards["Christmas Card"] = 28;
	cards["Go Fish"] = 29;
	cards["Aquarius Horoscope"] = 30;

	cards["Plains"] = 31;
	cards["Swamp"] = 32;
	cards["Mountain"] = 33;
	cards["Forest"] = 34;
	cards["Island"] = 35;
	cards["Healing Salve"] = 36;
	cards["Dark Ritual"] = 37;
	cards["Lightning Bolt"] = 38;
	cards["Giant Growth"] = 39;
	cards["Ancestral Recall"] = 40;

	cards["Gift Card"] = 41;
	cards["X of Papayas"] = 42;
	cards["X of Salads"] = 43;
	cards["IX - The Hermit"] = 44;
	cards["IV - The Emperor"] = 45;
	cards["Green Card"] = 46;
	cards["XVI - The Tower"] = 47;
	cards["The Race Card"] = 48;
	cards["0 - The Fool"] = 49;
	cards["I - The Magician"] = 50;

	cards["XI - Strength"] = 51;
	cards["Lead Pipe"] = 52;
	cards["Rope"] = 53;
	cards["Wrench"] = 54;
	cards["Candlestick"] = 55;
	cards["Knife"] = 56;
	cards["Revolver"] = 57;
	cards["1952 Mickey Mantle"] = 58;
	cards["Spare Tire"] = 59;
	cards["Extra Tank"] = 60;

	cards["Sheep"] = 61;
	cards["Year of Plenty"] = 62;
	cards["Mine"] = 63;
	cards["Laboratory"] = 64;
	cards["X of Kumquats"] = 65;
	cards["Professor Plum"] = 66;
	cards["X - The Wheel of Fortune"] = 67;
	cards["XXI - The World"] = 68;
	cards["VI - The Lovers"] = 69;
	cards["III - The Empress"] = 70;




	cards["PVP"] = 1;
	cards["fites"] = 1;
	cards["spade"] = 4;
	cards["white mana"] = 31;
	cards["black mana"] = 32;
	cards["red mana"] = 33;
	cards["green mana"] = 34;
	cards["blue mana"] = 36;
	cards["key"] = 47;
	cards["init"] = 48;
	cards["moxie buff"] = 49;
	cards["myst buff"] = 50;
	cards["mysticality buff"] = 50;
	cards["meat"] = 58;
	cards["muscle buff"] = 51;
	cards["stone wool"] = 61;
	cards["ore"] = 63;
	cards["items"] = 67;
	cards["muscle stat"] = 68;
	cards["Muscle stat"] = 68;
	cards["moxie stat"] = 69;
	cards["Moxie stat"] = 69;
	cards["myst stat"] = 70;
	cards["Myst stat"] = 70;
	cards["mysticality stat"] = 70;
	cards["Mysticality stat"] = 70;


	string page = visit_url("inv_use.php?cheat=1&pwd=&whichitem=8382");

	//	Check that a valid card was selected, otherwise this wastes 5 draws.
	int card = cards[cheat];
	if(card != 0)
	{
		string page = visit_url("choice.php?pwd=&option=1&whichchoice=1086&which=" + card, true);
		page = visit_url("choice.php?pwd=&whichchoice=1085&option=1", true);
		//	Check if a combat has been started and try to resolve it? Can we resolve it here?
		//	If we had #includes, we probably could resolve it here... hmm...
		#print(page, "red");
		return true;
	}
	return false;
}


boolean deck_useScheme(string action)
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() < 15)
	{
		return false;
	}
	if(my_hp() == 0)
	{
		return false;
	}
	if((action == "turns") && (my_daycount() <= 2))
	{
		deck_cheat("Ancestral Recall");
		deck_cheat("Island");
		if((get_property("cc_trapper") == "") || (get_property("cc_trapper") == "start"))
		{
			deck_cheat("Mine");
		}
		while(item_amount($item[Blue Mana]) > 0)
		{
			use_skill(1, $skill[Ancestral Recall]);
		}
		return true;
	}
	if((action == "sc1") || (action == "hc1"))
	{
		if(!is_unrestricted($item[The Smith\'s Tome]))
		{
			switch(my_class())
			{
			case $class[Seal Clubber]:		deck_cheat("Lead Pipe");	break;
			case $class[Turtle Tamer]:		deck_cheat("Lead Pipe");	break;
			case $class[Pastamancer]:		deck_cheat("Wrench");		break;
			case $class[Sauceror]:			deck_cheat("Candlestick");	break;
			case $class[Disco Bandit]:		deck_cheat("Knife");		break;
			case $class[Accordion Thief]:
				deck_cheat("key");
				set_property("cc_cubeItems", "done");
				break;
			}
		}
		else
		{
			if(my_class() == $class[Ed])
			{
				deck_cheat("ore");
			}
			else
			{
				deck_cheat("key");
				set_property("cc_cubeItems", "done");
			}
		}
		deck_cheat(my_primestat() + " stat");
		deck_cheat("1952 Mickey Mantle");
		autosell(1, $item[1952 Mickey Mantle Card]);
		return true;
	}
	if((action == "sc2") || (action == "hc2"))
	{
		if(!is_unrestricted($item[The Smith\'s Tome]))
		{
			switch(my_class())
			{
			case $class[Seal Clubber]:		deck_cheat("Lead Pipe");	break;
			case $class[Turtle Tamer]:		deck_cheat("Lead Pipe");	break;
			case $class[Pastamancer]:		deck_cheat("Wrench");		break;
			case $class[Sauceror]:			deck_cheat("Candlestick");	break;
			case $class[Disco Bandit]:		deck_cheat("Knife");		break;
			case $class[Accordion Thief]:	deck_cheat("key");			break;
			}
		}
		else if(my_class() == $class[Ed])
		{
			deck_cheat("ore");
		}
		else
		{
			deck_cheat("key");
		}
		if(item_amount($item[Stone Wool]) == 0)
		{
			deck_cheat("Sheep");
		}
		else
		{
			deck_cheat("Island");
		}
		deck_cheat("ore");
		return true;
	}
	if(action == "farming")
	{
		deck_cheat("Ancestral Recall");
		deck_cheat("Island");
		deck_cheat("1952 Mickey Mantle");
		while(item_amount($item[Blue Mana]) > 0)
		{
			use_skill(1, $skill[Ancestral Recall]);
		}
		return true;
	}
	if(action == "HC1stats")
	{
		deck_cheat("key");
		deck_cheat("ore");
		deck_cheat("" + my_primestat() + " stat");
		return true;
	}
	if(action == "HC2")
	{
		deck_cheat("ore");
		deck_cheat("key");
		deck_cheat("stone wool");
		return true;
	}
	if(action == "hc3")
	{
		if(!is_unrestricted($item[The Smith\'s Tome]))
		{
			switch(my_class())
			{
			case $class[Seal Clubber]:		deck_cheat("Lead Pipe");	break;
			case $class[Turtle Tamer]:		deck_cheat("Lead Pipe");	break;
			case $class[Pastamancer]:		deck_cheat("Wrench");		break;
			case $class[Sauceror]:			deck_cheat("Candlestick");	break;
			case $class[Disco Bandit]:		deck_cheat("Knife");		break;
			case $class[Accordion Thief]:	deck_cheat("Island");		break;
			}
		}
		else
		{
			deck_cheat("Island");
		}
		deck_cheat("key");
		deck_cheat("Ancestral Recall");
		return true;
	}

	return false;
}
