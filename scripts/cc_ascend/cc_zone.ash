script "cc_zone.ash"

//All functions should fail if the king is liberated?
//Zone functions come here.

generic_t zone_needItem(location loc);
generic_t zone_combatMod(location loc);
generic_t zone_delay(location loc);
generic_t zone_available(location loc);
location[int] zone_list();
int[location] zone_delayable();
boolean zone_isAvailable(location loc);


boolean zone_isAvailable(location loc)
{
	return zone_available(loc)._boolean;
}

int[location] zone_delayable()
{
	location[int] locs = zone_list();
	int[location] retval;
	foreach idx, loc in locs
	{
		generic_t locValue = zone_delay(loc);
		if(locValue._boolean && zone_isAvailable(loc))
		{
			retval[loc] = locValue._int;
		}
	}
	return retval;
}

/*
record generic_t
{
	boolean _error;
	boolean _boolean;
	int _int;
	float _float;
	string _string;
	item _item;
	location _location;
	class _class;
	stat _stat;
	skill _skill;
	effect _effect;
	familiar _familiar;
	slot _slot;
	monster _monster;
	element _element;
	phylum _phylum;
};
*/

generic_t zone_needItem(location loc)
{
	generic_t retval;
	float value = 0.0;
	switch(loc)
	{
	case $location[The Oasis]:
		value = 10000.0/30.0;
		break;
	case $location[The Middle Chamber]:
		value = 10000.0/20.0;
		break;
	case $location[The Deep Machine Tunnels]:
		value = 10000.0/30.0;			#Just a guess.
		break;
	case $location[The Haunted Laundry Room]:
	case $location[The Haunted Wine Cellar]:
		value = 10000.0/5.0;
		break;
	case $location[The Hidden Park]:
	case $location[The Hidden Apartment Building]:
	case $location[The Hidden Office Building]:
		if((get_property("hiddenTavernUnlock").to_int() < my_ascensions()) && !contains_text(get_property("banishedMonsters"), $monster[Pygmy Janitor]))
		{
			value = 10000.0/20.0;
		}
		break;
	case $location[The Hidden Bowling Alley]:
		// Should actually check if we have used 4/5 already.
		if(item_amount($item[Bowling Ball]) == 0)
		{
			value = 10000.0/40.0;
		}
		//Once we have completed the Bowling Alley, we do not care about this anymore.
		if((get_property("hiddenTavernUnlock").to_int() < my_ascensions()) && !contains_text(get_property("banishedMonsters"), $monster[Pygmy Janitor]))
		{
			value = 10000.0/20.0;
		}
		break;
	case $location[The Hidden Temple]:
		//Only if we need stone wool manually for some reason.
		//Or via the semi-rare!		(100/50/20 for SR, 25 Sheep)
		break;
	case $location[8-Bit Realm]:
		value = 10000.0/60.0;
		break;
	case $location[The Black Forest]:
		//Is it possible we want blackberries?
		break;
	case $location[The Beanbat Chamber]:
		if(item_amount($item[Enchanted Bean]) == 0)
		{
			value = 10000.0/50.0;
		}
		if(internalQuestStatus("questL04Bat") < 3)
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[The Batrat And Ratbat Burrow]:
		if(internalQuestStatus("questL04Bat") < 3)
		{
			value = 10000.0/15.0;
		}
		break;
	case $location[The Bat Hole Entrance]:
	case $location[Guano Junction]:
		if(internalQuestStatus("questL04Bat") < 3)
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[Inside the Palindome]:
		if((item_amount($item[Stunt Nuts]) == 0) && (item_amount($item[Wet Stew]) == 0))
		{
			value = 10000.0/32.0;
		}
		break;
	case $location[Cobb\'s Knob Harem]:
		if(item_amount($item[Knob Goblin Perfume]) == 0)
		{
			value = 10000.0/25.0;
		}
		if(!have_outfit("Knob Goblin Harem Girl Disguise"))
		{
			value = 10000.0/20.0;
		}
		break;
	case $location[The Dark Neck of the Woods]:
	case $location[The Dark Heart of the Woods]:
	case $location[The Dark Elbow of the Woods]:
		if(item_amount($item[Hot Wing]) < 3)
		{
			value = 10000.0/30.0;
		}
		break;
	case $location[The Defiled Nook]:
		// Handle for a gravy boat?
		if(get_property("cyrptNookEvilness").to_int() > 26)
		{
			value = 10000.0/20.0;
		}
		break;
	case $location[Barrrney\'s Barrr]:
		if(item_amount($item[Cocktail Napkin]) == 0)
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[The F\'c\'le]:
		if((item_amount($item[Ball Polish]) == 0) || (item_amount($item[Mizzenmast Mop]) == 0) ||(item_amount($item[Rigging Shampoo]) == 0))
		{
			value = 10000.0/30.0;
		}
		break;
	case $location[The Hatching Chamber]:
	case $location[The Feeding Chamber]:
	case $location[The Royal Guard Chamber]:
		value = 10000.0/10.0;
		break;
	case $location[The Smut Orc Logging Camp]:
		if(item_amount($item[Ten-Leaf Clover]) == 0)
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[A-Boo Peak]:
		{
			int progress = get_property("booPeakProgress").to_int();
			progress -= (30 * item_amount($item[A-Boo Clue]));
			if(get_property("cc_aboopending").to_int() != 0)
			{
				progress -= 30;
			}
			if(progress > 4)
			{
				value = 10000.0/15.0;
			}
		}
		break;
	case $location[Twin Peak]:
		value = 10000.0/15.0;
		break;
	case $location[Oil Peak]:
		// Should probably also check for Twin Peak completion here.
		if((item_amount($item[Bubblin\' Crude]) < 12) && (item_amount($item[Jar Of Oil])  == 0))
		{
			if(monster_level_adjustment() > 100)
			{
				value = 10000.0/10.0;
			}
			else if(monster_level_adjustment() > 50)
			{
				value = 10000.0/30.0;
			}
		}
		break;
	case $location[Itznotyerzitz Mine]:
		if(item_amount($item[Ten-Leaf Clover]) == 0)
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[The Goatlet]:
		value = 10000.0/40.0;
		break;

	case $location[The Extreme Slope]:
		if(!have_outfit("extreme cold-weather gear"))
		{
			value = 10000.0/10.0;
		}

	case $location[The Penultimate Fantasy Airship]:
		if(!possessEquipment($item[Amulet Of Extreme Plot Significance]) && !possessEquipment($item[Titanium Assault Umbrella]))
		{
			value = 10000.0/10.0;
		}
		if(!possessEquipment($item[Mohawk Wig]))
		{
			value = 10000.0/10.0;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Basement)]:
		//Should we care about Heavy D?
		break;
	case $location[The Castle in the Clouds in the Sky (Top Floor)]:
		//Should we care about Thin Black Candles?
		break;
	case $location[The Hole in the Sky]:
		if((item_amount($item[Star]) < 8) || (item_amount($item[Line]) < 7))
		{
			value = 10000.0/30.0;
		}
		break;
	case $location[Barf Mountain]:
		retval._float = 10000.0/15.0;
		break;
	default:
		retval._error = true;
		break;
	}

	if(value != 0.0)
	{
		retval._boolean = true;
		retval._float = value;
	}
	return retval;
}

generic_t zone_combatMod(location loc)
{
	generic_t retval;
	generic_t delay = zone_delay(loc);
	int value = 0;
	switch(loc)
	{
	case $location[The Upper Chamber]:
		value = -85;
		break;
	case $location[Super Villain\'s Lair]:
		if(!get_property("_villainLairColorChoiceUsed").to_boolean() || !get_property("_villainLairDoorChoiceUsed").to_boolean() || !get_property("_villainLairSymbologyChoiceUsed").to_boolean())
		{
			value = -70;
		}
		break;
	case $location[The Haunted Gallery]:
		if((delay._int == 0) || (!contains_text(get_property("relayCounters"), "Garden Banished")))
		{
			value = -80;
		}
		break;
	case $location[The Haunted Bathroom]:
		if(delay._int == 0)
		{
			value = -90;
		}
		break;
	case $location[The Haunted Ballroom]:
		if((delay._int == 0) && (loc.turns_spent > 0))
		{
			value = -90;
		}
		break;
	case $location[The Typical Tavern Cellar]:
		//We could cut it off early if the Rat Faucet is the last one
		//And marginally if we know the 3rd/6th square are forced events.
		value = -75;
		break;
	case $location[The Spooky Forest]:
		if(delay._int == 0)
		{
			value = -85;
		}
		break;
	case $location[The Black Forest]:
		value = 5;
		break;
	case $location[Inside the Palindome]:
		if((item_amount($item[Photograph Of A Red Nugget]) == 0) || (item_amount($item[Photograph Of An Ostrich Egg]) == 0) || (item_amount($item[Photograph Of God]) == 0))
		{
			value = -70;
		}
		break;
	case $location[The Dark Neck of the Woods]:
		value = -85;
		break;
	case $location[The Dark Heart of the Woods]:
		value = -85;
		break;
	case $location[The Dark Elbow of the Woods]:
		value = -85;
		break;
	case $location[The Defiled Cranny]:
		value = -85;
		break;
	case $location[The Defiled Alcove]:
		value = -85;
		break;
	case $location[Barrrney\'s Barrr]:
		if(internalQuestStatus("questM12Pirate") >= 0)
		{
			value = 20;
		}
		break;
	case $location[The F\'c\'le]:
		if((item_amount($item[Ball Polish]) == 0) || (item_amount($item[Mizzenmast Mop]) == 0) ||(item_amount($item[Rigging Shampoo]) == 0))
		{
			value = 20;
		}
		break;
	case $location[The Poop Deck]:
		value = -80;
		break;
	case $location[Wartime Hippy Camp (Frat Disguise)]:
		value = -80;
		break;
	case $location[The Extreme Slope]:
		value = -95;
		break;
	case $location[Lair of the Ninja Snowmen]:
		value = 80;
		break;
	case $location[Sonofa Beach]:
		value = 90;
		break;
	case $location[Twin Peak]:
		value = -80;
		break;
	case $location[The Penultimate Fantasy Airship]:
		if(delay._int == 0)
		{
			value = -80;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Basement)]:
		value = -95;
		break;
	case $location[The Castle in the Clouds in the Sky (Ground Floor)]:
		value = -95;
		break;
	case $location[The Castle in the Clouds in the Sky (Top Floor)]:
		value = -95;
		break;
	default:
		retval._error = true;
		break;
	}

	if(value != 0)
	{
		retval._boolean = true;
		retval._int = value;
	}
	return retval;
}

generic_t zone_delay(location loc)
{
	generic_t retval;
	int value = 0;
	switch(loc)
	{
	case $location[The Oasis]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Upper Chamber]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Middle Chamber]:
		value = 10 - loc.turns_spent;
		break;
	case $location[The Haunted Gallery]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Haunted Bathroom]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Haunted Bedroom]:
		value = 6 - loc.turns_spent;
		break;
	case $location[The Haunted Ballroom]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Hidden Park]:
		if(!possessEquipment($item[Antique Machete]) || !possessEquipment($item[Muculent Machete]))
		{
			value = 6 - loc.turns_spent;
		}
		break;
	case $location[The Hidden Apartment Building]:
		value = 8 - loc.turns_spent;
		retval._item = $item[Clara\'s Bell];
		//Special case this
		break;
	case $location[The Hidden Office Building]:
		value = 10 - loc.turns_spent;
		retval._item = $item[Clara\'s Bell];
		//Special case?
		break;
	case $location[The Spooky Forest]:
		value = 5 - loc.turns_spent;
		break;
	case $location[The Boss Bat\'s Lair]:
		value = 4 - loc.turns_spent;
		break;
	case $location[The Outskirts of Cobb\'s Knob]:
		value = 10 - loc.turns_spent;
		break;
	case $location[The Penultimate Fantasy Airship]:
		if(get_property("questL10Garbage") == "step2")
		{
			value = 5 - loc.turns_spent;
		}
		else if(get_property("questL10Garbage") == "step3")
		{
			value = 10 - loc.turns_spent;
		}
		else if(get_property("questL10Garbage") == "step4")
		{
			value = 15 - loc.turns_spent;
		}
		else if(get_property("questL10Garbage") == "step5")
		{
			value = 20 - loc.turns_spent;
		}
		else if(get_property("questL10Garbage") == "step6")
		{
			value = 25 - loc.turns_spent;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Ground Floor)]:
		value = 10 - loc.turns_spent;
		break;
	default:
		retval._error = true;
		break;
	}

	if(value > 0)
	{
		retval._boolean = true;
		retval._int = value;
	}
	return retval;
}

generic_t zone_available(location loc)
{
	generic_t retval;

	switch(loc)
	{
	case $location[Super Villain\'s Lair]:
		if((cc_my_path() == "License to Adventure") && (get_property("_villainLairProgress").to_int() < 999) && (get_property("_cc_bondBriefing") == "started"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Shore\, Inc. Travel Agency]:
		if(get_property("lastDesertUnlock").to_int() == my_ascensions())
		{
			retval._boolean = true;
		}
		break;
	case $location[The Arid\, Extra-Dry Desert]:
		if(internalQuestStatus("questL11Desert") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Oasis]:
		if($location[The Arid\, Extra-Dry Desert].turns_spent > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Upper Chamber]:
		if(internalQuestStatus("questL11Pyramid") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Middle Chamber]:
		retval._boolean = get_property("middleChamberUnlock").to_boolean();
		break;
	case $location[The Lower Chambers]:
		retval._boolean = get_property("lowerChamberUnlock").to_boolean();
		break;
	case $location[The Daily Dungeon]:
		retval._boolean = get_property("dailyDungeonDone").to_boolean();
		break;
	case $location[The Skeleton Store]:
		if(internalQuestStatus("questM23Meatsmith") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Madness Bakery]:
		if(internalQuestStatus("questM25Armorer") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Deep Machine Tunnels]:
		if(have_familiar($familiar[Machine Elf]) || (have_effect($effect[Inside The Snowglobe]) > 0))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Pantry]:
	case $location[The Haunted Kitchen]:
	case $location[The Haunted Conservatory]:
		if(internalQuestStatus("questM20Necklace") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Gallery]:
	case $location[The Haunted Bathroom]:
	case $location[The Haunted Bedroom]:
		if(internalQuestStatus("questM21Dance") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Billiards Room]:
		if(item_amount($item[Spookyraven Billiards Room Key]) > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Library]:
		if(item_amount($item[[7302]Spookyraven Library Key]) > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Ballroom]:
		if(internalQuestStatus("questM21Dance") >= 3)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Haunted Boiler Room]:
	case $location[The Haunted Laundry Room]:
	case $location[The Haunted Wine Cellar]:
		if(internalQuestStatus("questL11Manor") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[Summoning Chamber]:
		if(internalQuestStatus("questL11Manor") >= 11)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Park]:
	case $location[An Overgrown Shrine (Northwest)]:
	case $location[An Overgrown Shrine (Southwest)]:
	case $location[An Overgrown Shrine (Northeast)]:
	case $location[An Overgrown Shrine (Southeast)]:
	case $location[A Massive Ziggurat]:
		if(internalQuestStatus("questL11Worship") >= 3)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Apartment Building]:
		if(internalQuestStatus("questL11Curses") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Hospital]:
		if(internalQuestStatus("questL11Doctor") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Office Building]:
		if(internalQuestStatus("questL11Business") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Bowling Alley]:
		if(internalQuestStatus("questL11Spare") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Typical Tavern Cellar]:
		if(internalQuestStatus("questL03Rat") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Spooky Forest]:
		if((internalQuestStatus("questL02Larva") >= 0) || (internalQuestStatus("questG02Whitecastle") >= 0))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hidden Temple]:
		if(get_property("lastTempleUnlock").to_int() == my_ascensions())
		{
			retval._boolean = true;
		}
		break;
	case $location[8-Bit Realm]:
		if(possessEquipment($item[Continuum Transfunctioner]) && ((internalQuestStatus("questL02Larva") >= 0) || (internalQuestStatus("questG02Whitecastle") >= 0)))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Black Forest]:
		if(internalQuestStatus("questL11MacGuffin") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Bat Hole Entrance]:
		if(internalQuestStatus("questL04Bat") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Guano Junction]:
		if(elemental_resist($element[stench]) >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Batrat And Ratbat Burrow]:
		if(internalQuestStatus("questL04Bat") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Beanbat Chamber]:
		if(internalQuestStatus("questL04Bat") >= 2)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Boss Bat\'s Lair]:
		if(internalQuestStatus("questL04Bat") >= 3)
		{
			retval._boolean = true;
		}
		break;
	case $location[The VERY Unquiet Garves]:
		if(get_property("questL07Cyrptic") == "finished")
		{
			retval._boolean = true;
		}
		break;
	case $location[Inside the Palindome]:
		if(possessEquipment($item[Talisman O\' Namsilat]))
		{
			retval._boolean = true;
		}
		break;
	case $location[Noob Cave]:
	case $location[The Outskirts of Cobb\'s Knob]:
		retval._boolean = true;
		break;
	case $location[Cobb\'s Knob Harem]:
	case $location[Cobb\'s Knob Treasury]:
	case $location[Throne Room]:
		if(internalQuestStatus("questL05Goblin") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Dark Neck of the Woods]:
	case $location[The Dark Heart of the Woods]:
	case $location[The Dark Elbow of the Woods]:
		if(internalQuestStatus("questL06Friar") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Defiled Nook]:
	case $location[The Defiled Cranny]:
	case $location[The Defiled Alcove]:
	case $location[The Defiled Niche]:
		if(internalQuestStatus("questL07Cyrptic") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Barrrney\'s Barrr]:
		if((have_outfit("swashbuckling getup") || possessEquipment($item[Pirate Fledges])) && (get_property("lastIslandUnlock").to_int() == my_ascensions()))
		{
			if((get_property("questL12War") == "unstarted") || (get_property("questL12War") == "finished"))
			{
				retval._boolean = true;
			}
		}
		break;
	case $location[The F\'c\'le]:
		if((have_outfit("swashbuckling getup") || possessEquipment($item[Pirate Fledges])) && (get_property("lastIslandUnlock").to_int() == my_ascensions()) && (internalQuestStatus("questM12Pirate") >= 5))
		{
			if((get_property("questL12War") == "unstarted") || (get_property("questL12War") == "finished"))
			{
				retval._boolean = true;
			}
		}
		break;
	case $location[The Poop Deck]:
		if((have_outfit("swashbuckling getup") || possessEquipment($item[Pirate Fledges])) && (get_property("lastIslandUnlock").to_int() == my_ascensions()) && (internalQuestStatus("questM12Pirate") >= 6) && (get_property("cc_mcmuffin") != ""))
		{
			if((get_property("questL12War") == "unstarted") || (get_property("questL12War") == "finished"))
			{
				retval._boolean = true;
			}
		}
		break;
	case $location[Belowdecks]:
		if((have_outfit("swashbuckling getup") || possessEquipment($item[Pirate Fledges])) && (get_property("lastIslandUnlock").to_int() == my_ascensions()) && (get_property("questM12Pirate") == "finished") && (get_property("cc_mcmuffin") != ""))
		{
			if((get_property("questL12War") == "unstarted") || (get_property("questL12War") == "finished"))
			{
				retval._boolean = true;
			}
		}
		break;
	case $location[The Smut Orc Logging Camp]:
		if(internalQuestStatus("questL09Topping") >= 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[A-Boo Peak]:
	case $location[Twin Peak]:
	case $location[Oil Peak]:
		if(internalQuestStatus("questL09Topping") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[Wartime Hippy Camp (Frat Disguise)]:
		if((internalQuestStatus("questL12War") == 0) && have_outfit("frat warrior fatigues"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Battlefield (Frat Uniform)]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("hippiesDefeated").to_int() < 1000) && have_outfit("frat warrior fatigues") && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[Next to that Barrel with Something Burning in it]:
	case $location[Near an Abandoned Refrigerator]:
	case $location[Over Where the Old Tires Are]:
	case $location[Out by that Rusted-Out Car]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestJunkyardCompleted") == "none") && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[Sonofa Beach]:
		if(internalQuestStatus("questL12War") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Themthar Hills]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestNunsCompleted") == "none") && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hatching Chamber]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestOrchardCompleted") == "none") && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Feeding Chamber]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestOrchardCompleted") == "none") && (have_effect($effect[Filthworm Larva Stench]) > 0) && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Royal Guard Chamber]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestOrchardCompleted") == "none") && (have_effect($effect[Filthworm Drone Stench]) > 0) && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[The Filthworm Queen\'s Chamber]:
		if((internalQuestStatus("questL12War") >= 1) && (get_property("sidequestOrchardCompleted") == "none") && (item_amount($item[Heart Of The Filthworm Queen]) == 0) && (have_effect($effect[Filthworm Guard Stench]) > 0) && (get_property("questL12War") != "finished"))
		{
			retval._boolean = true;
		}
		break;
	case $location[Itznotyerzitz Mine]:
	case $location[The Goatlet]:
		if(internalQuestStatus("questL08Trapper") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Extreme Slope]:
	case $location[Lair of the Ninja Snowmen]:
		if(internalQuestStatus("questL08Trapper") >= 2)
		{
			retval._boolean = true;
		}
		break;
	case $location[Mist-Shrouded Peak]:
		if(internalQuestStatus("questL08Trapper") >= 3)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Icy Peak]:
		if(internalQuestStatus("questL08Trapper") >= 6)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Penultimate Fantasy Airship]:
		if(internalQuestStatus("questL10Garbage") >= 1)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Basement)]:
		if(item_amount($item[S.O.C.K.]) > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Ground Floor)]:
		if(get_property("lastCastleGroundUnlock").to_int() == my_ascensions())
		{
			retval._boolean = true;
		}
		break;
	case $location[The Castle in the Clouds in the Sky (Top Floor)]:
		if(get_property("lastCastleTopUnlock").to_int() == my_ascensions())
		{
			retval._boolean = true;
		}
		break;
	case $location[The Hole in the Sky]:
		if(item_amount($item[Steam-Powered Model Rocketship]) > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Fastest Adventurer Contest]:
		if(get_property("nsContestants1").to_int() > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Smartest Adventurer Contest]:
	case $location[Strongest Adventurer Contest]:
	case $location[Smoothest Adventurer Contest]:
		if(get_property("nsContestants2").to_int() > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Coldest Adventurer Contest]:
	case $location[Hottest Adventurer Contest]:
	case $location[Sleaziest Adventurer Contest]:
	case $location[Spookiest Adventurer Contest]:
	case $location[Stinkiest Adventurer Contest]:
		if(get_property("nsContestants3").to_int() > 0)
		{
			retval._boolean = true;
		}
		break;
	case $location[Barf Mountain]:
		retval._boolean = get_property("stenchAirportAlways").to_boolean() || get_property("_stenchAirportToday").to_boolean();
		break;
	case $location[The Bubblin\' Caldera]:
		retval._boolean = get_property("hotAirportAlways").to_boolean() || get_property("_hotAirportToday").to_boolean();
		break;
	case $location[The X-32-F Combat Training Snowman]:
		retval._boolean = get_property("snojoAvailable").to_boolean();
		break;
	case $location[Through the Spacegate]:
		retval._boolean = get_property("spacegateAlways").to_boolean() || get_property("_spacegateToday").to_boolean();
		break;
	case $location[Gingerbread Upscale Retail District]:
		retval._boolean = get_property("gingerbreadCityAvailable").to_boolean() || get_property("_gingerbreadCityToday").to_boolean();
		break;
	}

	return retval;
}
location[int] zone_list()
{
	return List($locations[8-Bit Realm, A-Boo Peak, The Arid\, Extra-Dry Desert, Barf Mountain, Barrrney\'s Barrr, The Bat Hole Entrance, The Batrat And Ratbat Burrow, The Battlefield (Frat Uniform), The Beanbat Chamber, Belowdecks, The Black Forest, The Boss Bat\'s Lair, The Bubblin\' Caldera, The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), Cobb\'s Knob Harem, Cobb\'s Knob Treasury, Coldest Adventurer Contest, The Daily Dungeon, The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Deep Machine Tunnels, The Defiled Alcove, The Defiled Cranny, The Defiled Niche, The Defiled Nook, The Extreme Slope, The F\'c\'le, Fastest Adventurer Contest, The Feeding Chamber, The Filthworm Queen\'s Chamber, Gingerbread Upscale Retail District, The Goatlet, Guano Junction, The Hatching Chamber, The Haunted Ballroom, The Haunted Bathroom, The Haunted Bedroom, The Haunted Billiards Room, The Haunted Boiler Room, The Haunted Conservatory, The Haunted Gallery, The Haunted Kitchen, The Haunted Laundry Room, The Haunted Library, The Haunted Pantry, The Haunted Wine Cellar, The Hidden Apartment Building, The Hidden Bowling Alley, The Hidden Hospital, The Hidden Office Building, The Hidden Park, The Hidden Temple, The Hole in the Sky, Hottest Adventurer Contest, The Icy Peak, Inside the Palindome, Itznotyerzitz Mine, Lair of the Ninja Snowmen, The Lower Chambers, Madness Bakery, A Massive Ziggurat, The Middle Chamber, Mist-Shrouded Peak, Near an Abandoned Refrigerator, Next to that Barrel with Something Burning in it, Noob Cave, The Oasis, Oil Peak, Out by that Rusted-Out Car, The Outskirts of Cobb\'s Knob, Over Where the Old Tires Are, An Overgrown Shrine (Northeast), An Overgrown Shrine (Northwest), An Overgrown Shrine (Southeast), An Overgrown Shrine (Southwest), The Penultimate Fantasy Airship, The Poop Deck, The Royal Guard Chamber, The Shore\, Inc. Travel Agency, The Skeleton Store, Sleaziest Adventurer Contest, Smartest Adventurer Contest, Smoothest Adventurer Contest, Spookiest Adventurer Contest, Stinkiest Adventurer Contest, Strongest Adventurer Contest, The Smut Orc Logging Camp, Sonofa Beach, The Spooky Forest, Summoning Chamber, Super Villain\'s Lair, The Themthar Hills, Throne Room, Through the Spacegate, Twin Peak, The Typical Tavern Cellar, The Upper Chamber, The VERY Unquiet Garves, The X-32-F Combat Training Snowman, Wartime Hippy Camp (Frat Disguise)]);
}



/*
	case $location[The Oasis]:
	case $location[The Arid\, Extra-Dry Desert]:
	case $location[The Shore\, Inc. Travel Agency]:
	case $location[The Upper Chamber]:
	case $location[The Middle Chamber]:
	case $location[The Lower Chambers]:
	case $location[The Daily Dungeon]:
	case $location[The Skeleton Store]:
	case $location[Madness Bakery]:
	case $location[The Deep Machine Tunnels]:
	case $location[Super Villain\'s Lair]:
	case $location[The Haunted Kitchen]:
	case $location[The Haunted Conservatory]:
	case $location[The Haunted Gallery]:
	case $location[The Haunted Bathroom]:
	case $location[The Haunted Bedroom]:
	case $location[The Haunted Ballroom]:
	case $location[The Haunted Boiler Room]:
	case $location[The Haunted Laundry Room]:
	case $location[The Haunted Wine Cellar]:
	case $location[Summoning Chamber]:
	case $location[The Hidden Park]:
	case $location[The Hidden Apartment Building]:
	case $location[The Hidden Hospital]:
	case $location[The Hidden Office Building]:
	case $location[The Hidden Bowling Alley]:
	case $location[An Overgrown Shrine (Northwest)]:
	case $location[An Overgrown Shrine (Southwest)]:
	case $location[An Overgrown Shrine (Northeast)]:
	case $location[An Overgrown Shrine (Southeast)]:
	case $location[A Massive Ziggurat]:
	case $location[The Typical Tavern Cellar]:
	case $location[The Spooky Forest]:
	case $location[The Hidden Temple]:
	case $location[8-Bit Realm]:
	case $location[The Black Forest]:
	case $location[The Beanbat Chamber]:
	case $location[The Bat Hole Entrance]:
	case $location[The Batrat And Ratbat Burrow]:
	case $location[Guano Junction]:
	case $location[The Boss Bat\'s Lair]:
	case $location[The VERY Unquiet Garves]:
	case $location[Inside the Palindome]:
	case $location[The Outskirts of Cobb\'s Knob]:
	case $location[Cobb\'s Knob Harem]:
	case $location[Cobb\'s Knob Treasury]:
	case $location[Throne Room]:
	case $location[The Dark Neck of the Woods]:
	case $location[The Dark Heart of the Woods]:
	case $location[The Dark Elbow of the Woods]:
	case $location[The Defiled Nook]:
	case $location[The Defiled Cranny]:
	case $location[The Defiled Alcove]:
	case $location[The Defiled Niche]:
	case $location[Barrrney\'s Barrr]:
	case $location[The F\'c\'le]:
	case $location[The Poop Deck]:
	case $location[Belowdecks]:
	case $location[The Battlefield (Frat Uniform)]:
	case $location[Wartime Hippy Camp (Frat Disguise)]:
	case $location[Next to that Barrel with Something Burning in it]:
	case $location[Near an Abandoned Refrigerator]:
	case $location[Over Where the Old Tires Are]:
	case $location[Out by that Rusted-Out Car]:
	case $location[The Extreme Slope]:
	case $location[Lair of the Ninja Snowmen]:
	case $location[Sonofa Beach]:
	case $location[The Themthar Hills]:
	case $location[The Hatching Chamber]:
	case $location[The Feeding Chamber]:
	case $location[The Royal Guard Chamber]:
	case $location[The Filthworm Queen\'s Chamber]:
	case $location[Noob Cave]:
	case $location[The Smut Orc Logging Camp]:
	case $location[A-Boo Peak]:
	case $location[Twin Peak]:
	case $location[Oil Peak]:
	case $location[Itznotyerzitz Mine]:
	case $location[The Goatlet]:
	case $location[Mist-Shrouded Peak]:
	case $location[The Icy Peak]:
	case $location[The Penultimate Fantasy Airship]:
	case $location[The Castle in the Clouds in the Sky (Basement)]:
	case $location[The Castle in the Clouds in the Sky (Ground Floor)]:
	case $location[The Castle in the Clouds in the Sky (Top Floor)]:
	case $location[The Hole in the Sky]:
	case $location[Fastest Adventurer Contest]:
	case $location[Smartest Adventurer Contest]:
	case $location[Hottest Adventurer Contest]:
	case $location[Barf Mountain]:
	case $location[The Bubblin\' Caldera]:
	case $location[The X-32-F Combat Training Snowman]:
	case $location[Through the Spacegate]:

	case $location[Gingerbread Upscale Retail District]:
	default:


*/