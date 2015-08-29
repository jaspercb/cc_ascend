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

void oldPeoplePlantStuff()
{
	if(!florist_available())
	{
		return;
	}

	if((my_location() == $location[The Outskirts of Cobb\'s Knob]) && (get_property("cc_knobplant") == ""))
	{
		cli_execute("florist plant rad-ish radish");
		cli_execute("florist plant celery stalker");
		set_property("cc_knobplant", "plant");
	}
	else if((my_location() == $location[The Spooky Forest]) && (get_property("cc_spookyplant") == ""))
	{
		cli_execute("florist plant seltzer watercress");
		cli_execute("florist plant lettuce spray");
		cli_execute("florist plant deadly cinnamon");
		set_property("cc_spookyplant", "finished");
	}
	else if((my_location() == $location[The Haunted Bathroom]) && (get_property("cc_bathroomplant") == ""))
	{
		cli_execute("florist plant war lily");
		cli_execute("florist plant Impatiens");
		cli_execute("florist plant arctic moss");
		set_property("cc_bathroomplant", "plant");
	}
	else if((my_location() == $location[The Haunted Ballroom]) && (get_property("cc_ballroomplant") == ""))
	{
		cli_execute("florist plant stealing magnolia");
		cli_execute("florist plant aloe guv'nor");
		cli_execute("florist plant pitcher plant");
		set_property("cc_ballroomplant", "plant");
	}
	else if((my_location() == $location[The Defiled Nook]) && (get_property("cc_nookplant") == ""))
	{
		cli_execute("florist plant horn of plenty");
		set_property("cc_nookplant", "plant");
	}
	else if((my_location() == $location[The Defiled Alcove]) && (get_property("cc_alcoveplant") == ""))
	{
		cli_execute("florist plant shuffle truffle");
		set_property("cc_alcoveplant", "plant");
	}
	else if((my_location() == $location[The Defiled Niche]) && (get_property("cc_nicheplant") == ""))
	{
		cli_execute("florist plant wizard's wig");
		set_property("cc_nicheplant", "plant");
	}
	else if((my_location() == $location[The Obligatory Pirate\'s Cove]) && (get_property("cc_coveplant") == ""))
	{
		cli_execute("florist plant rabid dogwood");
		cli_execute("florist plant artichoker");
		set_property("cc_coveplant", "plant");
	}
	else if((my_location() == $location[Barrrney\'s Barrr]) && (get_property("cc_barplant") == ""))
	{
		cli_execute("florist plant spider plant");
		cli_execute("florist plant red fern");
		cli_execute("florist plant bamboo!");
		set_property("cc_barplant", "plant");
	}
	else if((my_location() == $location[The Penultimate Fantasy Airship]) && (get_property("cc_airshipplant") == ""))
	{
		cli_execute("florist plant rutabeggar");
		cli_execute("florist plant smoke-ra");
		cli_execute("florist plant skunk cabbage");
		set_property("cc_airshipplant", "plant");
	}
	else if((my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) && (get_property("cc_castlebasementplant") == ""))
	{
		if(my_daycount() == 1)
		{
			cli_execute("florist plant blustery puffball");
			cli_execute("florist plant dis lichen");
			cli_execute("florist plant max headshroom");
		}
		set_property("cc_castlebasementplant", "plant");
	}
	else if((my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)]) && (get_property("cc_castlegroundplant") == ""))
	{
		cli_execute("florist plant canned spinach");
		set_property("cc_castlegroundplant", "plant");
	}
	else if((my_location() == $location[Oil Peak]) && (get_property("cc_oilpeakplant") == ""))
	{
		cli_execute("florist plant rabid dogwood");
		cli_execute("florist plant artichoker");
		cli_execute("florist plant celery stalker");
		set_property("cc_oilpeakplant", "plant");
	}
	else if((my_location() == $location[The Haunted Boiler Room]) && (get_property("cc_boilerroomplant") == ""))
	{
		cli_execute("florist plant war lily");
		cli_execute("florist plant red fern");
		cli_execute("florist plant arctic moss");
		set_property("cc_boilerroomplant", "plant");
	}
	else if((my_location() == $location[A Massive Ziggurat]) && (get_property("cc_massivezigguratplant") == ""))
	{
		cli_execute("florist plant skunk cabbage");
		cli_execute("florist plant deadly cinnamon");
		set_property("cc_massivezigguratplant", "plant");
	}
	else if((my_location() == $location[The Arid\, Extra-Dry Desert]) && (get_property("cc_desertplant") == ""))
	{
		cli_execute("florist plant rad-ish radish");
		cli_execute("florist plant lettuce spray");
		set_property("cc_desertplant", "plant");
	}
	else if((my_location() == $location[The Hidden Apartment Building]) && (get_property("cc_hiddenapartmentplant") == ""))
	{
		cli_execute("florist plant impatiens");
		cli_execute("florist plant spider plant");
		cli_execute("florist plant pitcher plant");
		set_property("cc_hiddenapartmentplant", "plant");
	}
	else if((my_location() == $location[The Hidden Office Building]) && (get_property("cc_hiddenofficeplant") == ""))
	{
		cli_execute("florist plant canned spinach");
		set_property("cc_hiddenofficeplant", "plant");
	}
	else if((my_location() == $location[The Hidden Bowling Alley]) && (get_property("cc_hiddenbowlingplant") == ""))
	{
		cli_execute("florist plant Stealing Magnolia");
		set_property("cc_hiddenbowlingplant", "plant");
	}
	else if((my_location() == $location[The Hidden Hospital]) && (get_property("cc_hiddenhospitalplant") == ""))
	{
		cli_execute("florist plant bamboo!");
		cli_execute("florist plant aloe guv'nor");
		set_property("cc_hiddenhospitalplant", "plant");
	}
	else if((my_location() == $location[The Upper Chamber]) && (get_property("cc_pyramidupperplant") == ""))
	{
		cli_execute("florist plant Blustery Puffball");
		cli_execute("florist plant Loose Morels");
		cli_execute("florist plant Foul Toadstool");
		set_property("cc_pyramidupperplant", "plant");
	}
	else if((my_location() == $location[The Middle Chamber]) && (get_property("cc_pyramidmiddleplant") == ""))
	{
		cli_execute("florist plant Horn of Plenty");
		cli_execute("florist plant max headshroom");
		cli_execute("florist plant Dis Lichen");
		set_property("cc_pyramidmiddleplant", "plant");
	}
	else if((my_location() == $location[The Battlefield (Frat Uniform)]) && (get_property("cc_battleFratplant") == ""))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Smoke-ra");
		cli_execute("florist plant Rutabeggar");
		set_property("cc_battleFratplant", "plant");
	}
	else if((my_location() == $location[The Secret Government Laboratory]) && (get_property("cc_secretLaboratoryPlant") == "") && (my_daycount() == 1))
	{
		cli_execute("florist plant Pitcher Plant");
		cli_execute("florist plant Canned Spinach");
		set_property("cc_secretLaboratoryPlant", "plant");
	}
	else if((my_location() == $location[Hippy Camp]) && (get_property("cc_secretLaboratoryPlant") == "") && (my_daycount() == 1))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Rad-ish Radish");
		set_property("cc_secretLaboratoryPlant", "plant");
	}
#	else if((my_location() == $location[Pirates of the Garbage Barges]) && (get_property("cc_secretLaboratoryPlant") == "") && (my_daycount() == 1))
	else if((my_location() == $location[Pirates of the Garbage Barges]) && (get_property("cc_secretLaboratoryPlant") == "") && (my_daycount() == 1))
	{
		cli_execute("florist plant Pitcher Plant");
		cli_execute("florist plant Canned Spinach");
		set_property("cc_secretLaboratoryPlant", "plant");
	}
	else if((my_location() == $location[The Battlefield (Hippy Uniform)]) && (get_property("cc_battleFratplant") == ""))
	{
		cli_execute("florist plant Seltzer Watercress");
		cli_execute("florist plant Smoke-ra");
		cli_execute("florist plant Rutabeggar");
		set_property("cc_battleFratplant", "plant");
	}


}
