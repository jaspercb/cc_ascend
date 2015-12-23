script "precheese.ash";
import <cc_ascend/cc_util.ash>


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
	if(get_property("cc_bedroomHandler2") == "yes")
	{
		set_property("cc_bedroomHandler2", "no");
		if(contains_text(visit_url("main.php"), "choice.php"))
		{
			return;
		}
	}

	if(get_property("cc_disableAdventureHandling") == "yes")
	{
		return;
	}

	if(last_monster().random_modifiers["clingy"])
	{
		return;
	}

	if(place == $location[The Lower Chambers])
	{
		return;
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


	if(my_path() == "Actually Ed the Undying")
	{
		if($locations[The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Defiled Alcove, The Defiled Cranny, The Haunted Ballroom, The Haunted Bathroom, The Haunted Billiards Room, The Haunted Gallery, The Hidden Hospital, Inside the Palindome, The Obligatory Pirate\'s Cove, The Penultimate Fantasy Airship, The Poop Deck, The Spooky Forest, Twin Peak, Wartime Hippy Camp] contains place)
		{
			if((have_effect($effect[Shelter of Shed]) == 0) && (my_mp() < 15))
			{
				if(item_amount($item[Magical Mystery Juice]) > 0)
				{
					use(1, $item[Magical Mystery Juice]);
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
			}
			buffMaintain($effect[Shelter of Shed], 15, 1, 1);
		}
		return;
	}


	#+C Maintenance
	if($locations[The Black Forest, The F\'c\'le, Sonofa Beach] contains place)
	{
		uneffect($effect[The Sonata Of Sneakiness]);
		buffMaintain($effect[Hippy Stench], 0, 1, 10);
		buffMaintain($effect[Musk of the Moose], 15, 1, 2);
		buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
	}
	#+C Maintenance
	if(place == $location[Barrrney\'s Barrr])
	{
		if(numPirateInsults() < 7)
		{
			uneffect($effect[The Sonata Of Sneakiness]);
			buffMaintain($effect[Musk of the Moose], 15, 1, 2);
			buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
		}
		else
		{
			uneffect($effect[Carlweather\'s Cantata Of Confrontation]);
			buffMaintain($effect[Smooth Movements], 15, 1, 2);
			buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
		}
	}

	#+NC Maintenance
	if($locations[A Maze of Sewer Tunnels, The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Defiled Alcove, The Defiled Cranny, The Haunted Ballroom, The Haunted Bathroom, The Haunted Billiards Room, The Haunted Gallery, The Hidden Hospital, The Ice Hotel, Inside the Palindome, The Middle Chamber, The Obligatory Pirate\'s Cove, The Penultimate Fantasy Airship, The Poop Deck, The Spooky Forest, Twin Peak, The Upper Chamber, Wartime Hippy Camp] contains place)
	{
		buffMaintain($effect[Smooth Movements], 15, 1, 2);
		buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
	}

	if((monster_level_adjustment() > 120) && ((my_hp() * 10) < (my_maxhp() * 8)) && (my_mp() >= 20))
	{
		useCocoon();
	}

	if(in_hardcore() && (my_class() == $class[Sauceror]) && (my_mp() < 32))
	{
		while((my_meat() > 100) && (my_mp() < 32))
		{
			if(guild_store_available() && (my_level() >= 5))
			{
				buyUpTo(1, $item[Magical Mystery Juice], 50);
				use(1, $item[Magical Mystery Juice]);
			}
			else
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic], 25);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
		}
	}

	if(in_hardcore() && (my_class() == $class[Sauceror]) && (my_mp() < 32))
	{
		print("Warning, we don't have a lot of MP but we are chugging along anyway", "red");
	}

	print("Pre Adventure done, beep.", "blue");
}

void main(){
	handlePreAdventure();
}
