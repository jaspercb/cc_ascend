script "cc_mr2016.ash"
import<cc_ascend/cc_adventure.ash>

#	This is meant for items that have a date of 2016.
#	Handling: Witchess Set, Snojo, Source Terminal
#

boolean snojoFightAvailable();
boolean cc_advWitchess(string target);
boolean cc_advWitchess(string target, string option);

boolean cc_haveWitchess();
boolean cc_haveSourceTerminal();
boolean cc_sourceTerminalRequest(string request);
boolean cc_sourceTerminalEnhance(string request);
int cc_sourceTerminalEnhanceLeft();
int[string] cc_sourceTerminalStatus();


//Supplemental
int cc_advWitchessTargets(string target);




boolean snojoFightAvailable()
{
	if(!is_unrestricted($item[X-32-F Snowman Crate]))
	{
		return false;
	}
	if(!get_property("snojoAvailable").to_boolean())
	{
		return false;
	}

	if(!get_property("kingLiberated").to_boolean())
	{
		int[string] controls;
		controls["MUSCLE"] = 1;
		controls["MYSTICALITY"] = 2;
		controls["MOXIE"] = 3;
		controls["Muscle"] = 1;
		controls["Mysticality"] = 2;
		controls["Moxie"] = 3;

		//List the three desired goals and then a "final" state that we stay in
		string[int] standard;
		standard[0] = "Moxie";
		standard[1] = "Mysticality";
		standard[2] = "Muscle";
		standard[3] = "Moxie";

		if((my_path() == "Avatar of Boris") && (possessEquipment($item[Boris\'s Helm]) || possessEquipment($item[Boris\'s Helm (Askew)])))
		{
			standard[0] = "Muscle";
			standard[1] = "Mysticality";
			standard[2] = "Moxie";
			standard[3] = "Mysticality";
		}
		if(my_path() == "Community Service")
		{
			standard[0] = "Mysticality";
			standard[1] = "Moxie";
			standard[2] = "Muscle";
			standard[3] = "Mysticality";
		}

		if((get_property("snojo" + standard[0] + "Wins").to_int() < 14) && (get_property("snojoSetting") != to_upper_case(standard[0])))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(controls[standard[0]]);
		}
		if((get_property("snojoSetting") == to_upper_case(standard[0])) && (get_property("snojo" + standard[0] + "Wins").to_int() >= 14) && (get_property("snojoSetting") != to_upper_case(standard[1])) && (get_property("snojo" + standard[1] + "Wins").to_int() < 14))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(controls[standard[1]]);
		}
		if((get_property("snojoSetting") == to_upper_case(standard[1])) && (get_property("snojo" + standard[1] + "Wins").to_int() >= 14) && (get_property("snojoSetting") != to_upper_case(standard[2])) && (get_property("snojo" + standard[2] + "Wins").to_int() < 14))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(controls[standard[2]]);
		}
		if((get_property("snojoSetting") == to_upper_case(standard[2])) && (get_property("snojo" + standard[2] + "Wins").to_int() >= 11) && (get_property("snojoSetting") != to_upper_case(standard[3])))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(controls[standard[3]]);
		}


/*
		if((get_property("snojoMoxieWins").to_int() < 14) && (get_property("snojoSetting") != "MOXIE"))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(3);
		}
		if((get_property("snojoSetting") == "MOXIE") && (get_property("snojoMoxieWins").to_int() >= 14) && (get_property("snojoSetting") != "MYSTICALITY") && (get_property("snojoMysticalityWins").to_int() < 14))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(2);
		}
		if((get_property("snojoSetting") == "MYSTICALITY") && (get_property("snojoMysticalityWins").to_int() >= 14) && (get_property("snojoSetting") != "MUSCLE") && (get_property("snojoMuscleWins").to_int() < 14))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(1);
		}
		if((get_property("snojoSetting") == "MUSCLE") && (get_property("snojoMuscleWins").to_int() >= 11) && (get_property("snojoSetting") != "MOXIE"))
		{
			string temp = visit_url("place.php?whichplace=snojo&action=snojo_controller");
			temp = run_choice(3);
		}
*/
	}
	if(get_property("snojoSetting") == "NONE")
	{
		print("Snojo not set, attempting to set to " + my_primestat(), "blue");
		visit_url("place.php?whichplace=snojo&action=snojo_controller");
	}
	return (get_property("_snojoFreeFights").to_int() < 10);
}


boolean cc_haveSourceTerminal()
{
	if(!is_unrestricted($item[Source Terminal]))
	{
		return false;
	}
	return (cc_get_campground() contains $item[Source Terminal]);
}

boolean cc_sourceTerminalRequest(string request)
{
	//enhance <effect>.enh		[meat|items|init|critical]
	//enquiry <effect>.enq		[familiar|monsters]
	//educate <skill>.edu		[digitize|extract]
	//extrude <item>.ext		[food|booze|goggles]

	print("Source Terminal request: " + request, "green");

	if(cc_haveSourceTerminal())
	{
		string temp = visit_url("campground.php?action=terminal");
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=reset");
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=" + request);
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=reset");
		return true;
	}
	return false;
}



boolean cc_sourceTerminalEnhance(string request)
{
	if(!cc_haveSourceTerminal())
	{
		return false;
	}
	if(cc_sourceTerminalEnhanceLeft() == 0)
	{
		return false;
	}
	string actual = "";
	switch(request)
	{
	case "meat":
	case "meat.enh":		actual = "meat";			break;
	case "item":
	case "items":
	case "item.enh":
	case "items.enh":		actual = "items";			break;
	case "init":
	case "initiative":		actual = "init";			break;
	case "critical":		actual = "critical";		break;
	default:			return false;
	}

	if(cc_sourceTerminalStatus() contains (actual + ".enh"))
	{
		return cc_sourceTerminalRequest("enhance " + actual + ".enh");
	}
	return false;
}
int cc_sourceTerminalEnhanceLeft()
{
	if(cc_haveSourceTerminal())
	{
		int used = get_property("_sourceTerminalEnhanceUses").to_int();

		int total = 1;
		if(get_property("sourceTerminalChips") != "")
		{
			string[int] chips = split_string(get_property("sourceTerminalChips"), ",");
			foreach index in chips
			{
				string chip = trim(chips[index]);
				if((chip == "CRAM") || (chip == "SCRAM"))
				{
					total += 1;
				}
			}
		}
		return total - used;
	}
	return 0;

}


int[string] cc_sourceTerminalStatus()
{
	int[string] status;
	if(cc_haveSourceTerminal())
	{
		string temp = visit_url("campground.php?action=terminal");
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=reset");
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=status");
		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=ls");

		matcher ramMatcher = create_matcher("<div>((?:[A-Z]*?)?[RP]AM) (chip(?:s?)) installed([:,]) ((?:\\d+)|(?:\\w))", temp);
		while(ramMatcher.find())
		{
			if(ramMatcher.group(3) == ",")
			{
				status[ramMatcher.group(1)] = 1;
			}
			else
			{
				status[ramMatcher.group(1)] = ramMatcher.group(4).to_int();
			}
		}

		matcher extrude = create_matcher("\\b((?:\\w+?)[.](?:ext|enh|edu|enq))", temp);
		while(extrude.find())
		{
			status[extrude.group(1)] = 1;
		}

		temp = visit_url("choice.php?pwd=&whichchoice=1191&option=1&input=reset");
		status["enhanceBuff"] = 25 + (25 * status["INGRAM"]) + (5 * status["PRAM"]);
		status["enhanceUses"] = 1 + status["CRAM"] + status["SCRAM"];
		status["enhance"] = status["enhanceBuff"] + status["enhanceUses"];
		status["enquiry"] = 50 + ((status["DIAGRAM"] + 1) * status["GRAM"] * 10);
		status["educate"] = 1 + status["DRAM"];
		status["digitize"] = 1 + status["TRIGRAM"] + status["TRAM"];
		status["mpReduce"] = (5 * status["ASHRAM"]) + status["SPAM"];
	}
	return status;
}

boolean cc_haveWitchess()
{
	if(!is_unrestricted($item[Witchess Set]))
	{
		return false;
	}
	return (cc_get_campground() contains $item[Witchess Set]);
}

boolean cc_advWitchess(string target)
{
	return cc_advWitchess(target, "");
}

boolean cc_advWitchess(string target, string option)
{
	if(!cc_haveWitchess())
	{
		return false;
	}

	if(my_adventures() == 0)
	{
		return false;
	}

	int goal = cc_advWitchessTargets(target);
	if(goal == 0)
	{
		return false;
	}

	if(get_property("_cc_witchessBattles").to_int() >= 5)
	{
		return false;
	}

//	if(get_property("_witchessFights").to_int() >= 5)
//	{
//		return false;
//	}

//	if(get_property("_witchessFights").to_int() > get_property("_cc_witchessBattles").to_int())
//	{
//		print("_witchessFights is greater than our tracking, it is probably more accurate at this point (assuming manual Witchess combats).", "red");
//		set_property("_cc_witchessBattles", get_property("_witchessFights"));
//	}

	set_property("_cc_witchessBattles", get_property("_cc_witchessBattles").to_int() + 1);

	string temp = visit_url("campground.php?action=witchess");
	if(!contains_text(temp, "Examine the shrink ray"))
	{
		set_property("_cc_witchessBattles", 5);
		return false;
	}
	temp = visit_url("choice.php?whichchoice=1181&pwd=&option=1");
	matcher witchessMatcher = create_matcher("You can fight (\\d) more piece(s?) today", temp);
	if(witchessMatcher.find())
	{
		int consider = (5 - witchessMatcher.group(1).to_int()) + 1;
		if(consider > get_property("_cc_witchessBattles").to_int())
		{
			set_property("_cc_witchessBattles", consider);
		}
	}
	else
	{
		set_property("_cc_witchessBattles", 5);
		return false;
	}
	temp = visit_url("choice.php?pwd=&option=2&whichchoice=1182");

	string[int] pages;
	pages[0] = "campground.php?action=witchess";
	pages[1] = "choice.php?whichchoice=1181&pwd=&option=1";
	pages[2] = "choice.php?pwd=" + my_hash() + "&whichchoice=1182&option=1&piece=" + goal;

	// We use 4 to cause pages[2] to use GET.
	return ccAdvBypass(4, pages, $location[Noob Cave], option);
}


int cc_advWitchessTargets(string target)
{
	target = to_lower_case(target);
	if((target == "knight") || (target == "meat") || (target == "food"))
	{
		return 1936;
	}
	if((target == "pawn") || (target == "spleen") || (target == "init"))
	{
		return 1935;
	}
	if((target == "bishop") || (target == "item") || (target == "booze"))
	{
		return 1942;
	}
	if((target == "rook") || (target == "ml") || (target == "stats"))
	{
		return 1938;
	}

	if((target == "ox") || (target == "ox-head shield") || (target == "shield") || (target == "pvp") || (target == "hp") || (target == "resist") || (target == "resistance"))
	{
		return 1937;
	}

	if((target == "king") || (target == "dented scepter") || (target == "scepter") || (target == "club") || (target == "muscle") || (target == "hpregen"))
	{
		return 1940;
	}

	if((target == "witch") || (target == "battle broom") || (target == "broom") || (target == "myst") || (target == "mpregen") || (target == "spell"))
	{
		return 1941;
	}

	if((target == "queen") || (target == "very pointy crown") || (target == "crown") || (target == "adv") || (target == "moxie") || (target == "nc") || (target == "noncombat") || (target == "non-combat"))
	{
		return 1939;
	}



	return 0;
}
