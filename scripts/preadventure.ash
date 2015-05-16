script "preadventure.ash";
import <zlib.ash>
import <cc_util.ash>

void handlePreAdventure()
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

	if((get_property("_bittycar") == "") && (item_amount($item[Bittycar Meatcar]) > 0))
	{
		use(1, $item[bittycar meatcar]);
	}

	if((have_effect($effect[Coated in Slime]) > 0) && (my_location() != $location[The Slime Tube]))
	{
		visit_url("clan_slimetube.php?action=chamois&pwd");
	}

	if((my_location() == $location[The Broodling Grounds]) && (my_class() == $class[Seal Clubber]))
	{
		uneffect($effect[Spiky Shell]);
		uneffect($effect[Scarysauce]);
	}


	if(my_path() == "Actually Ed the Undying")
	{
		if((my_location() == $location[The Penultimate Fantasy Airship]) ||
			(my_location() == $location[Twin Peak]) ||
			(my_location() == $location[The Poop Deck]) ||
			(my_location() == $location[The Haunted Ballroom]) ||
			(my_location() == $location[The Haunted Billiards Room]) ||
			(my_location() == $location[The Haunted Gallery]) ||
			(my_location() == $location[The Haunted Bathroom]) ||
			(my_location() == $location[The Hidden Hospital]) ||
			(my_location() == $location[Inside the Palindome]) ||
			(my_location() == $location[The Dark Neck of the Woods]) ||
			(my_location() == $location[The Dark Heart of the Woods]) ||
			(my_location() == $location[The Dark Elbow of the Woods]) ||
			(my_location() == $location[The Defiled Cranny]) ||
			(my_location() == $location[The Defiled Alcove]) ||
			(my_location() == $location[The Spooky Forest]) ||
			(my_location() == $location[Inside the Palindome]) ||
			(my_location() == $location[The Hidden Hospital]) ||
			(my_location() == $location[The Obligatory Pirate\'s Cove]) ||
			(my_location() == $location[Wartime Hippy Camp]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Top Floor)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)])
		)
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
	if((my_location() == $location[The F\'c\'le]) ||
		(my_location() == $location[Sonofa Beach]) ||
		(my_location() == $location[The Black Forest])
	)
	{
		uneffect($effect[The Sonata Of Sneakiness]);
		buffMaintain($effect[Hippy Stench], 0, 1, 10);
		buffMaintain($effect[Musk of the Moose], 15, 1, 2);
		buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
	}
	#+C Maintenance
	if(my_location() == $location[Barrrney\'s Barrr])
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
	if((my_location() == $location[The Penultimate Fantasy Airship]) ||
		(my_location() == $location[Twin Peak]) ||
		(my_location() == $location[A Maze of Sewer Tunnels]) ||
		(my_location() == $location[The Poop Deck]) ||
		(my_location() == $location[The Haunted Ballroom]) ||
		(my_location() == $location[The Haunted Billiards Room]) ||
		(my_location() == $location[The Haunted Gallery]) ||
		(my_location() == $location[The Haunted Bathroom]) ||
		(my_location() == $location[The Hidden Hospital]) ||
		(my_location() == $location[Inside the Palindome]) ||
		(my_location() == $location[The Dark Neck of the Woods]) ||
		(my_location() == $location[The Dark Heart of the Woods]) ||
		(my_location() == $location[The Dark Elbow of the Woods]) ||
		(my_location() == $location[The Defiled Cranny]) ||
		(my_location() == $location[The Defiled Alcove]) ||
		(my_location() == $location[The Upper Chamber]) ||
		(my_location() == $location[The Spooky Forest]) ||
		(my_location() == $location[The Middle Chamber]) ||
		(my_location() == $location[Inside the Palindome]) ||
		(my_location() == $location[The Hidden Hospital]) ||
		(my_location() == $location[The Obligatory Pirate\'s Cove]) ||
		(my_location() == $location[Wartime Hippy Camp]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Top Floor)]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)])
	)
	{
		buffMaintain($effect[Smooth Movements], 15, 1, 2);
		buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
	}

	if((monster_level_adjustment() > 120) && ((my_hp() * 10) < (my_maxhp() * 8)) && (my_mp() >= 20))
	{
		useCocoon();
	}
	print("Pre Adventure done, beep.", "orange");
}

void main(){
	handlePreAdventure();
}
