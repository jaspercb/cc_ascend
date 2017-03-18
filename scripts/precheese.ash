script "precheese.ash";
import<cc_ascend/cc_ascend_header.ash>
import<cc_ascend/cc_util.ash>
import<cc_ascend/cc_edTheUndying.ash>
import<cc_ascend/cc_adventure.ash>
import<cc_ascend/cc_mr2016.ash>


//	handlePreAdventure methods, first allows explicit location declaration
//	second uses my_location(), this is called defaultly by preadventure.
//	Primarily, we use the explicit location declaration whenever we bypass adv1
void handlePreAdventure(location place);
void handlePreAdventure();



void handlePreAdventure()
{
	handlePreAdventure(my_location());
}

void handlePreAdventure(location place)
{

	if((place == $location[The Deep Machine Tunnels]) && (my_familiar() != $familiar[Machine Elf]))
	{
		if(!have_familiar($familiar[Machine Elf]))
		{
			abort("Massive failure, we don't use snowglobes.");
		}
		print("Somehow we are considering the DMT without a Machine Elf...", "red");
	}

	if(get_property("cc_bedroomHandler2") == "yes")
	{
		set_property("cc_bedroomHandler2", "no");
		if(contains_text(visit_url("main.php"), "choice.php"))
		{
			print("Preadventure skipped by bedroom handler.", "green");
			return;
		}
	}

	if(get_property("cc_disableAdventureHandling") == "yes")
	{
		print("Preadventure skipped by standard adventure handler.", "green");
		return;
	}

	if(last_monster().random_modifiers["clingy"])
	{
		print("Preadventure skipped by clingy modifier.", "green");
		return;
	}

	if(place == $location[The Lower Chambers])
	{
		print("Preadventure skipped by Ed the Undying!", "green");
		return;
	}

	familiar famChoice = to_familiar(get_property("cc_familiarChoice"));
	if((famChoice != $familiar[none]) && !is100FamiliarRun() && (internalQuestStatus("questL13Final") < 13))
	{
		if((famChoice != my_familiar()) && !get_property("kingLiberated").to_boolean())
		{
#			print("FAMILIAR DIRECTIVE ERROR: Selected " + famChoice + " but have " + my_familiar(), "red");
			use_familiar(famChoice);
		}
	}

	if((place == $location[The Deep Machine Tunnels]) && (my_familiar() != $familiar[Machine Elf]))
	{
		if(!have_familiar($familiar[Machine Elf]))
		{
			abort("Massive failure, we don't use snowglobes.");
		}
		print("Somehow we are going to the DMT without a Machine Elf...", "red");
		use_familiar($familiar[Machine Elf]);
	}

	if(my_familiar() == $familiar[Trick-Or-Treating Tot])
	{
		if($locations[A-Boo Peak, The Haunted Kitchen] contains place)
		{
			if(equipped_item($slot[Familiar]) != $item[Li\'l Candy Corn Costume])
			{
				if(item_amount($item[Li\'l Candy Corn Costume]) > 0)
				{
					equip($slot[Familiar], $item[Li\'l Candy Corn Costume]);
				}
			}
		}
	}

	preAdvXiblaxian(place);

	if(get_floundry_locations() contains place)
	{
		buffMaintain($effect[Baited Hook], 0, 1, 1);
	}

	if((my_mp() < 30) && ((my_mp()+20) < my_maxmp()) && (item_amount($item[Psychokinetic Energy Blob]) > 0))
	{
		use(1, $item[Psychokinetic Energy Blob]);
	}

	if((get_property("_bittycar") == "") && (item_amount($item[Bittycar Meatcar]) > 0))
	{
		use(1, $item[bittycar meatcar]);
	}

	if((have_effect($effect[Coated in Slime]) > 0) && (place != $location[The Slime Tube]))
	{
		visit_url("clan_slimetube.php?action=chamois&pwd");
	}

	if((place == $location[The Broodling Grounds]) && (my_class() == $class[Seal Clubber]))
	{
		uneffect($effect[Spiky Shell]);
		uneffect($effect[Scarysauce]);
	}

	if(my_path() == $class[Avatar of Boris])
	{
		if((have_effect($effect[Song of Solitude]) == 0) && (have_effect($effect[Song of Battle]) == 0))
		{
			//When do we consider Song of Cockiness?
			buffMaintain($effect[Song of Fortune], 10, 1, 1);
			if(have_effect($effect[Song of Fortune]) == 0)
			{
				buffMaintain($effect[Song of Accompaniment], 10, 1, 1);
			}
		}
		else if((place.turns_spent > 1) && (place != get_property("cc_priorLocation").to_location()))
		{
			//When do we consider Song of Cockiness?
			buffMaintain($effect[Song of Fortune], 10, 1, 1);
			if(have_effect($effect[Song of Fortune]) == 0)
			{
				buffMaintain($effect[Song of Accompaniment], 10, 1, 1);
			}
		}
	}


	if(my_class() == $class[Ed])
	{
		if($locations[The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Defiled Alcove, The Defiled Cranny, The Haunted Ballroom, The Haunted Bathroom, The Haunted Billiards Room, The Haunted Gallery, The Hidden Hospital, Inside the Palindome, The Obligatory Pirate\'s Cove, The Penultimate Fantasy Airship, The Poop Deck, The Spooky Forest, Twin Peak, Wartime Hippy Camp] contains place)
		{
			if((have_effect($effect[Shelter of Shed]) == 0) && (my_mp() < 15))
			{
				if(item_amount($item[Magical Mystery Juice]) > 0)
				{
					use(1, $item[Magical Mystery Juice]);
				}
				else if(item_amount($item[Grogpagne]) > 0)
				{
					use(1, $item[Grogpagne]);
				}
				else if(item_amount($item[Phonics Down]) > 0)
				{
					use(1, $item[Phonics Down]);
				}
				else if(item_amount($item[Tiny House]) > 0)
				{
					use(1, $item[Tiny House]);
				}
				else if(item_amount($item[Holy Spring Water]) > 0)
				{
					use(1, $item[Holy Spring Water]);
				}
				else if(item_amount($item[Spirit Beer]) > 0)
				{
					use(1, $item[Spirit Beer]);
				}
				else if(item_amount($item[Sacramental Wine]) > 0)
				{
					use(1, $item[Sacramental Wine]);
				}
			}
			buffMaintain($effect[Shelter of Shed], 15, 1, 1);
		}
	}

	if(!get_property("kingLiberated").to_boolean())
	{
		#+C Maintenance
		if($locations[The Black Forest, The F\'c\'le, Sonofa Beach] contains place)
		{
			providePlusCombat(25);
			uneffect($effect[The Sonata Of Sneakiness]);
			shrugAT($effect[Carlweather\'s Cantata of Confrontation]);
			buffMaintain($effect[Hippy Stench], 0, 1, 10);
			buffMaintain($effect[Musk of the Moose], 15, 1, 2);
			buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
		}
		#+C Maintenance
		if(place == $location[Barrrney\'s Barrr])
		{
			if(numPirateInsults() < 7)
			{
				providePlusCombat(25);
				uneffect($effect[The Sonata Of Sneakiness]);
				shrugAT($effect[Carlweather\'s Cantata of Confrontation]);
				buffMaintain($effect[Musk of the Moose], 15, 1, 2);
				buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
			}
			else
			{
				providePlusNonCombat(25);
				uneffect($effect[Carlweather\'s Cantata Of Confrontation]);
				shrugAT($effect[The Sonata of Sneakiness]);
				buffMaintain($effect[Smooth Movements], 15, 1, 2);
				buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
			}
		}
		#+NC Maintenance
		if($locations[A Maze of Sewer Tunnels, The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Defiled Alcove, The Defiled Cranny, The Haunted Ballroom, The Haunted Bathroom, The Haunted Billiards Room, The Haunted Gallery, The Hidden Hospital, The Ice Hotel, Inside the Palindome, The Middle Chamber, The Obligatory Pirate\'s Cove, The Penultimate Fantasy Airship, The Poop Deck, The Spooky Forest, Twin Peak, The Upper Chamber, Wartime Hippy Camp] contains place)
		{
			providePlusNonCombat(25);
			uneffect($effect[Carlweather\'s Cantata Of Confrontation]);
			shrugAT($effect[The Sonata of Sneakiness]);
			buffMaintain($effect[Smooth Movements], 15, 1, 2);
			buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
			buffMaintain($effect[Patent Invisibility], 0, 1, 1);
			buffMaintain($effect[Song of Solitude], 22, 1, 1);
			buffMaintain($effect[Inked Well], 45, 1, 1);
		}
	}

	if((monster_level_adjustment() > 120) && ((my_hp() * 10) < (my_maxhp() * 8)) && (my_mp() >= 20))
	{
		useCocoon();
	}

	if(in_hardcore() && (my_class() == $class[Sauceror]) && (my_mp() < 32) && (my_maxmp() >= 32))
	{
		while((my_meat() > 2500) && (my_mp() < 32))
		{
			if(guild_store_available() && (my_level() >= 5))
			{
				buyUpTo(1, $item[Magical Mystery Juice], 100);
				use(1, $item[Magical Mystery Juice]);
			}
			else if(isGalaktikAvailable())
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic], 90);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			else
			{
				break;
			}
		}
	}

	if(in_hardcore() && (my_class() == $class[Sauceror]) && (my_mp() < 32))
	{
		print("Warning, we don't have a lot of MP but we are chugging along anyway", "red");
	}
	set_property("cc_priorLocation", place);
	print("Pre Adventure at " + place + " done, beep.", "blue");
}

void main(){
	handlePreAdventure();
}
