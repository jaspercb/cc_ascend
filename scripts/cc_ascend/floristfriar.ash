script "floristfriar.ash"

void florist_initializeSettings()
{
	if(florist_available())
	{
		#Florist Friar Settings
		#FIXME: Upgrade this a String container (see cc_combat.ash)
		set_property("cc_airshipplant", "");
		set_property("cc_alcoveplant", "");
		set_property("cc_ballroomplant", "");
		set_property("cc_barplant", "");
		set_property("cc_bathroomplant", "");
		set_property("cc_battleFratplant", "");
		set_property("cc_battleHippyplant", "");
		set_property("cc_boilerroomplant", "");
		set_property("cc_castlegroundplant", "");
		set_property("cc_castlebasementplant", "");
		set_property("cc_coveplant", "");
		set_property("cc_desertplant", "");
		set_property("cc_hiddenapartmentplant", "");
		set_property("cc_hiddenbowlingplant", "");
		set_property("cc_hiddenhospitalplant", "");
		set_property("cc_hiddenofficeplant", "");
		set_property("cc_knobplant", "");
		set_property("cc_massivezigguratplant", "");
		set_property("cc_nicheplant", "");
		set_property("cc_nookplant", "");
		set_property("cc_oilpeakplant", "");
		set_property("cc_pyramidmiddleplant", "");
		set_property("cc_pyramidupperplant", "");
		set_property("cc_secretLaboratoryPlant", "");
		set_property("cc_spookyplant", "");
	}
}

boolean didWePlantHere(location loc)
{
	string [location, 3] places = get_florist_plants();
	foreach place in places
	{
		if(loc == place)
		{
			return true;
		}
	}
	return false;
}

void oldPeoplePlantStuff()
{
	if(!florist_available())
	{
		if(my_path() != "Community Service")
		{
			return;
		}
		if(!get_property("cc_haveFlorist").to_boolean())
		{
			return;
		}
	}

	if(didWePlantHere(my_location()))
	{
		return;
	}

	if(my_path() == "Community Service")
	{
		if(florist_available())
		{
			if(my_location() == $location[The Velvet / Gold Mine])
			{
				cli_execute("florist plant horn of plenty");
				cli_execute("florist plant max headshroom");
				cli_execute("florist plant foul toadstool");
			}
			else if(my_location() == $location[The Secret Government Laboratory])
			{
				cli_execute("florist plant pitcher plant");
				cli_execute("florist plant spider plant");
				cli_execute("florist plant stealing magnolia");
			}
			else if(my_location() == $location[The Bubblin\' Caldera])
			{
				cli_execute("florist plant seltzer watercress");
				cli_execute("florist plant lettuce spray");
				cli_execute("florist plant skunk cabbage");
			}
			else if(my_location() == $location[The Skeleton Store])
			{
				cli_execute("florist plant canned spinach");
				cli_execute("florist plant aloe guv'nor");
			}
			else if(my_location() == $location[LavaCo&trade; Lamp Factory])
			{
				cli_execute("florist plant impatiens");
				cli_execute("florist plant red fern");
				cli_execute("florist plant bamboo!");
			}
			else if(my_location() == $location[8-bit realm])
			{
				cli_execute("florist plant rad-ish radish");
				cli_execute("florist plant smoke-ra");
				cli_execute("florist plant deadly cinnamon");
			}
		}
		else
		{
			if(my_location() == $location[The Velvet / Gold Mine])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=22");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=30");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=27");
			}
			else if(my_location() == $location[The Secret Government Laboratory])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=15");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=20");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=12");
			}
			else if(my_location() == $location[The Bubblin\' Caldera])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=10");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=9");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=6");
			}
			else if(my_location() == $location[The Skeleton Store])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=19");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=13");
			}
			else if(my_location() == $location[LavaCo&trade; Lamp Factory])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=14");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=16");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=17");
			}
			else if(my_location() == $location[8-bit realm])
			{
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=3");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=5");
				visit_url("choice.php?whichchoice=720&pwd=&option=4");
				visit_url("choice.php?whichchoice=720&pwd=&option=1&plant=7");
			}
		}
		return;
	}


	if((my_location() == $location[The Outskirts of Cobb\'s Knob]))
	{
		cli_execute("florist plant rad-ish radish");
		cli_execute("florist plant celery stalker");
	}
	else if((my_location() == $location[The Spooky Forest]))
	{
		cli_execute("florist plant seltzer watercress");
		cli_execute("florist plant lettuce spray");
		cli_execute("florist plant deadly cinnamon");
	}
	else if((my_location() == $location[The Haunted Bathroom]))
	{
		cli_execute("florist plant war lily");
		cli_execute("florist plant Impatiens");
		cli_execute("florist plant arctic moss");
	}
	else if((my_location() == $location[The Haunted Ballroom]))
	{
		cli_execute("florist plant stealing magnolia");
		cli_execute("florist plant aloe guv'nor");
		cli_execute("florist plant pitcher plant");
	}
	else if((my_location() == $location[The Defiled Nook]))
	{
		cli_execute("florist plant horn of plenty");
	}
	else if((my_location() == $location[The Defiled Alcove]))
	{
		cli_execute("florist plant shuffle truffle");
	}
	else if((my_location() == $location[The Defiled Niche]))
	{
		cli_execute("florist plant wizard's wig");
	}
	else if((my_location() == $location[The Obligatory Pirate\'s Cove]))
	{
		cli_execute("florist plant rabid dogwood");
		cli_execute("florist plant artichoker");
	}
	else if((my_location() == $location[Barrrney\'s Barrr]))
	{
		cli_execute("florist plant spider plant");
		cli_execute("florist plant red fern");
		cli_execute("florist plant bamboo!");
	}
	else if((my_location() == $location[The Penultimate Fantasy Airship]))
	{
		cli_execute("florist plant rutabeggar");
		cli_execute("florist plant smoke-ra");
		cli_execute("florist plant skunk cabbage");
	}
	else if((my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) && (my_daycount() == 1))
	{
		cli_execute("florist plant blustery puffball");
		cli_execute("florist plant dis lichen");
		cli_execute("florist plant max headshroom");
	}
	else if((my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)]))
	{
		cli_execute("florist plant canned spinach");
	}
	else if((my_location() == $location[Oil Peak]))
	{
		cli_execute("florist plant rabid dogwood");
		cli_execute("florist plant artichoker");
		cli_execute("florist plant celery stalker");
	}
	else if((my_location() == $location[The Haunted Boiler Room]))
	{
		cli_execute("florist plant war lily");
		cli_execute("florist plant red fern");
		cli_execute("florist plant arctic moss");
	}
	else if((my_location() == $location[A Massive Ziggurat]))
	{
		cli_execute("florist plant skunk cabbage");
		cli_execute("florist plant deadly cinnamon");
	}
	else if((my_location() == $location[The Arid\, Extra-Dry Desert]))
	{
		cli_execute("florist plant rad-ish radish");
		cli_execute("florist plant lettuce spray");
	}
	else if((my_location() == $location[The Hidden Apartment Building]))
	{
		cli_execute("florist plant impatiens");
		cli_execute("florist plant spider plant");
		cli_execute("florist plant pitcher plant");
	}
	else if((my_location() == $location[The Hidden Office Building]))
	{
		cli_execute("florist plant canned spinach");
	}
	else if((my_location() == $location[The Hidden Bowling Alley]))
	{
		cli_execute("florist plant Stealing Magnolia");
	}
	else if((my_location() == $location[The Hidden Hospital]))
	{
		cli_execute("florist plant bamboo!");
		cli_execute("florist plant aloe guv'nor");
	}
	else if((my_location() == $location[The Upper Chamber]))
	{
		cli_execute("florist plant Blustery Puffball");
		cli_execute("florist plant Loose Morels");
		cli_execute("florist plant Foul Toadstool");
	}
	else if((my_location() == $location[The Middle Chamber]))
	{
		cli_execute("florist plant Horn of Plenty");
		cli_execute("florist plant max headshroom");
		cli_execute("florist plant Dis Lichen");
	}
	else if((my_location() == $location[The Battlefield (Frat Uniform)]))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Smoke-ra");
		cli_execute("florist plant Rutabeggar");
	}
	else if((my_location() == $location[The Secret Government Laboratory]) && (my_daycount() == 1))
	{
		cli_execute("florist plant Pitcher Plant");
		cli_execute("florist plant Canned Spinach");
	}
	else if((my_location() == $location[Hippy Camp]) && (my_daycount() == 1))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Rad-ish Radish");
	}
	else if((my_location() == $location[Pirates of the Garbage Barges]) && (my_daycount() == 1))
	{
		cli_execute("florist plant Pitcher Plant");
		cli_execute("florist plant Canned Spinach");
	}
	else if((my_location() == $location[The Battlefield (Hippy Uniform)]))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Smoke-ra");
		cli_execute("florist plant Rutabeggar");
	}


}
