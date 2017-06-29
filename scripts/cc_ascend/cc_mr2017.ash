script "cc_mr2017.ash"

#   This is meant for items that have a date of 2017.
#   Handling: Space Jellyfish, heart-shaped crate

boolean getSpaceJelly();
boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem);
boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem, string option);
boolean solveKGBMastermind();
boolean kgbDial(int dial, int curVal, int target);
boolean kgbSetup();

boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem)
{
	return loveTunnelAcquire(enforcer, statItem, engineer, loveEffect, equivocator, giftItem, "");
}

boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem, string option)
{
	if(get_property("_loveTunnelUsed").to_boolean())
	{
		return false;
	}
	if((loveEffect < 0) || (loveEffect > 4))
	{
		return false;
	}
	if((giftItem < 0) || (giftItem > 7))
	{
		return false;
	}
	if((giftItem == 6) && !have_familiar($familiar[Space Jellyfish]))
	{
		return false;
	}
	if((loveEffect == 2) && !have_familiar($familiar[Mosquito]))
	{
		loveEffect = 3;
	}

//	set_property("_cc_loveTunnelDone", true);

	string temp = visit_url("place.php?whichplace=town_wrong");
	if(!(contains_text(temp, "townwrong_tunnel")))
	{
		return false;
	}

	#string temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	if(contains_text(temp, "Come back tomorrow!"))
	{
		print("Already visited L.O.V.E. Tunnel. Can't be visiting again.", "red");
		temp = visit_url("choice.php?pwd=&whichchoice=1222&option=2");
		return false;
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1222&option=1");

	if(enforcer || engineer || equivocator)
	{
		set_property("cc_disableAdventureHandling", "yes");
	}

	if(enforcer)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1223&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1223&option=2");
	}


	int statValue = 4;
	if(statItem == $stat[none])
	{
		statItem = my_primestat();
	}
	switch(statItem)
	{
	case $stat[Muscle]:			statValue = 1;		break;
	case $stat[Mysticality]:	statValue = 2;		break;
	case $stat[Moxie]:			statValue = 3;		break;
	}

	if(!have_skill($skill[Torso Awaregness]) && !have_skill($skill[Best Dressed]) && (statValue == 1))
	{
		if(possessEquipment($item[Protonic Accelerator Pack]))
		{
			statValue = 3;
		}
		else
		{
			statValue = 2;
		}
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1224&option=" + statValue);
#1		Cardigan,			LOV Eardigan	Shirt - 25% Muscle Stats, 8-12HP Regen, +25ML, End of Day
#2		Epaulettes,			LOV Epaulettes	Back  - 25% Myst Stats, 4-6MP Regen, -3MPCombatSkills, End of Day
#3		Earrings			LOV Earrings	Acc   - 25% Moxie Stats, +3 PrismRes, +50% Meat, End of Day
#4		Nothing


	if(engineer)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1225&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1225&option=2");
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1226&option=" + loveEffect);
#1	Lovebotamy					+10 stats per fight
#2	Open Heart Surgery			+10 familiar weight (50 adventures)
#3	Wandering Eye Surgery		+50% item drops (50 adventures)
#4	Nothing

	if(equivocator)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1227&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1227&option=2");
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1228&option=" + giftItem);
#1		Boomerang			LOV Enamorang (combat item) stagger, consumed (15 turn later copy?)
#2		Toy Dart Gun		LOV Emotionizer (usable self/others)
#3		Chocolate			LOV Extraterrestrial Chocolate (+3/2/1 advs, independent chocolate?)
#4		Flowers				LOV Echinacea Bouquet (Spleen). (stats + small hp/mp, 1 toxicity)
#5		Plush Elephant		LOV Elephant (Shield, DR+10)
#6		Toast? Only with Space Jellyfish?
#7		Nothing

	if(enforcer || engineer || equivocator)
	{
		set_property("cc_disableAdventureHandling", "no");
		cli_execute("postcheese");
	}

	return true;
}


boolean kgbSetup()
{
	if(!possessEquipment($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}
	if(!is_unrestricted($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}
	if(get_property("_cc_kgbSetup").to_boolean())
	{
		return false;
	}

	if(my_daycount() != 1)
	{
		return false;
	}

	set_property("_cc_kgbSetup", true);

	string page = visit_url("place.php?whichplace=kgb");
	if(contains_text(page, "kgb_drawer") || contains_text(page, "kgb_crank") || contains_text(page, "kgb_button"))
	{
		return false;
	}
	kgbDial(1, -1, 6);
	kgbDial(2, -1, 6);
	kgbDial(3, -1, 6);
	kgbDial(4, -1, 6);
	kgbDial(5, -1, 6);
	kgbDial(6, -1, 6);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 1, false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 2, false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_handledown", false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_handleup", false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 2, false);
	//Crank extruded.
	if(!contains_text(page, "kgb_crank"))
	{
		abort("Failed to unlock kgb_crank");
	}
	page = visit_url("place.php?whichplace=kgb&action=kgb_handledown", false);
	for(int i=0; i<11; i++)
	{
		page = visit_url("place.php?whichplace=kgb&action=kgb_crank", false);
	}
	if(!contains_text(page, "..........."))
	{
		abort("11 cranks failed");
	}
	page = visit_url("place.php?whichplace=kgb&action=kgb_handleup", false);

	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 1, false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_handledown", false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 1, false);
	if(!contains_text(page, "kgb_dispenser"))
	{
		abort("Failed to unlock kgb_dispenser");
	}
	//Martini Hose extruded.

	page = visit_url("place.php?whichplace=kgb&action=kgb_handleup", false);
	kgbDial(1, -1, 3);
	kgbDial(2, -1, 3);
	kgbDial(3, -1, 3);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 1, false);
	if(!contains_text(page, "kgb_drawer2"))
	{
		abort("Failed to unlock kgb_drawer2");
	}
	page = visit_url("place.php?whichplace=kgb&action=kgb_drawer2", false);

	kgbDial(4, -1, 2);
	kgbDial(5, -1, 2);
	kgbDial(6, -1, 2);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 2, false);
	if(!contains_text(page, "kgb_drawer1"))
	{
		abort("Failed to unlock kgb_drawer1");
	}
	page = visit_url("place.php?whichplace=kgb&action=kgb_drawer1", false);


	kgbDial(1, -1, 7);
	kgbDial(2, -1, 9);
	kgbDial(3, -1, 8);
	kgbDial(4, -1, 8);
	kgbDial(5, -1, 9);
	kgbDial(6, -1, 7);
	page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + 1, false);
	if(!contains_text(page, "kgb_button"))
	{
		abort("Failed to unlock kgb_button");
	}

	int button = -1;
	page = visit_url("place.php?whichplace=kgb&action=kgb_handledown", false);
	for(int i=1; i<=6; i++)
	{
		print("Hitting tab modification button: " + i, "blue");
		page = visit_url("place.php?whichplace=kgb&action=kgb_button" + i, false);
		matcher tabCount = create_matcher("kgb_tab(\\d)(?:.*?)otherimages/kgb/tab(\\d+).gif", page);
		int count = 0;
		int height = 0;
		while(tabCount.find())
		{
			count++;
			height += to_int(tabCount.group(2));
		}

		if(count >= 3)
		{
			button = i;
			i--;
		}

		if(height >= 11)
		{
			break;
		}
	}


	//Do verification instead.

	int have = item_amount($item[Splendid Martini]);
	page = visit_url("place.php?whichplace=kgb&action=kgb_dispenser", false);
	if(have == item_amount($item[Splendid Martini]))
	{
		abort("Failed to get a splendid martini");
	}
	page = visit_url("place.php?whichplace=kgb&action=kgb_dispenser", false);
	page = visit_url("place.php?whichplace=kgb&action=kgb_dispenser", false);

	return true;

}

boolean kgbDial(int dial, int curVal, int target)
{
	if(!possessEquipment($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}
	if(!is_unrestricted($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}

	if(curVal == target)
	{
		return true;
	}

	while(curVal != target)
	{
		string page = visit_url("place.php?whichplace=kgb&action=kgb_dial" + dial, false);
		int[int] dials;
		matcher dial_matcher = create_matcher("title=\"Weird Character (.)", page);
		int count = 1;
		while(dial_matcher.find())
		{
			string temp = dial_matcher.group(1);
			if(temp == "a")
			{
				dials[count] = 10;
			}
			else
			{
				dials[count] = to_int(dial_matcher.group(1));
			}
			count++;
		}
		curVal = dials[dial];
		print("Clicking " + dial + " and now: " + curVal, "blue");
	}
	return true;
}


boolean solveKGBMastermind()
{
	if(!possessEquipment($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}
	if(!is_unrestricted($item[Kremlin\'s Greatest Briefcase]))
	{
		return false;
	}

	string page = visit_url("place.php?whichplace=kgb");
	if(contains_text(page, "A pair of antennae"))
	{
		return false;
	}
	if(contains_text(get_property("_cc_kgbScoresLeft"), "3 0"))
	{
		if(contains_text(get_property("_cc_kgbScoresRight"), "3 0"))
		{
			return false;
		}
	}

	if(contains_text(page, "kgb_handledown"))
	{
		string temp = visit_url("place.php?whichplace=kgb&action=kgb_handledown");
	}
	if(!contains_text(page, "kgb_handleup"))
	{
		abort("KGB Handle borken!!");
	}

	string guessString = "";
	int clicks = 0;
	while(!contains_text(page, "A pair of antennae"))
	{
		int[int] dials;
		int count = 0;
		matcher dial_matcher = create_matcher("title=\"Weird Character (.)", page);
		while(dial_matcher.find())
		{
			string temp = dial_matcher.group(1);
			if(temp == "a")
			{
				dials[count] = 10;
			}
			else
			{
				dials[count] = to_int(dial_matcher.group(1));
			}
			count++;
		}

		print("Left side: " + dials[0] + " " + dials[1] + " " + dials[2], "green");
		print("Right side: " + dials[3] + " " + dials[4] + " " + dials[5], "green");

		int[int] guess;
		if(guessString == "")
		{
			guess[1] = 0;
			guess[2] = 1;
			guess[3] = 2;
		}
		else
		{
			string[int] digits = split_string(guessString, " ");
			guess[1] = to_int(digits[count(digits)-3]);
			guess[2] = to_int(digits[count(digits)-2]);
			guess[3] = to_int(digits[count(digits)-1]);
		}

		string prop = "_cc_kgbScoresLeft";
		int dialOffset = 0;
		string action = "1";

		if(contains_text(get_property("_cc_kgbScoresLeft"), "3 0"))
		{
			prop = "_cc_kgbScoresRight";
			dialOffset = 3;
			string action = "2";
		}

		//Which one are we doing, if ScoresLeft has 3 0, we are done with it.
		print("About to guess: " + guess[1] + ", " + guess[2] + ", " + guess[3], "green");
		for(int i=1; i<=3; i++)
		{
			kgbDial(dialOffset+i, dials[dialOffset + i], guess[i]);
#			while(dials[dialOffset + i] != guess[i])
#			{
#				print("Clicking: " + i);
#				page = visit_url("place.php?whichplace=kgb&action=kgb_dial" + (i+1), false);
#				dials[dialOffset + i] = (dials[dialOffset + i] + 1) % 11;
#			}
		}

		//Verify the dials are correct before pushing anything!
		int[int] vDials;
		int vCount = 0;
		matcher vDial_matcher = create_matcher("title=\"Weird Character (.)", page);
		while(vDial_matcher.find())
		{
			string temp = vDial_matcher.group(1);
			if(temp == "a")
			{
				vDials[vCount] = 10;
			}
			else
			{
				vDials[vCount] = to_int(vDial_matcher.group(1));
			}
			vCount++;
		}

		if((vDials[dialOffset+1] != guess[1]) || (vDials[dialOffset+2] != guess[2]) || (vDials[dialOffset+3] != guess[3]))
		{
			abort("Dials not set correctly");
		}

		string page = visit_url("place.php?whichplace=kgb&action=kgb_actuator" + action, false);
		if(contains_text(page, "Nothing happens"))
		{
			print("Out of clicks. Derp.", "red");
			return false;
		}
		int correct = 0;
		int blink = 0;
		matcher light_match = create_matcher("kgb_mastermind(\\d)(?:.*?)A light (.*?)\"", page);
		while(light_match.find())
		{
			int bulb = to_int(light_match.group(1));
			string status = light_match.group(2);
			print("Light " + bulb + ": " + status, "blue");
			if(status == "(on)")
			{
				correct++;
			}
			if(status == "(blinking)")
			{
				blink++;
			}
		}
		print("Correct: " + correct + " Blinking: " + blink, "blue");

		clicks++;

		if(get_property(prop) == "")
		{
			set_property(prop, correct + " " + blink);
		}
		else
		{
			set_property(prop, get_property(prop) + " " + correct + " " + blink);
		}

		guessString = visit_url("http://cheesellc.com/kol/kgb.php?data=" + url_encode(get_property(prop)), false);
		print("Subresult: " + guessString, "green");

		if(contains_text(guessString, "3 0"))
		{
			guessString = "";
		}
	}
	print("Clicks used: " + clicks, "red");

	return contains_text(page, "A pair of antennae");
}




boolean getSpaceJelly()
{
	if(is100FamiliarRun($familiar[Space Jellyfish]))
	{
		return false;
	}
	if(get_property("_seaJellyHarvested").to_boolean())
	{
		return false;
	}
	if(!have_familiar($familiar[Space Jellyfish]))
	{
		return false;
	}
	if(my_level() < 11)
	{
		return false;
	}
	if(my_path() != "Standard")
	{
		if(!get_property("kingLiberated").to_boolean())
		{
			return false;
		}
	}

	if(internalQuestStatus("questS01OldGuy") < 0)
	{
		string temp = visit_url("oldman.php");
		temp = visit_url("place.php?whichplace=sea_oldman&action=oldman_oldman");
	}
	familiar old = my_familiar();
	use_familiar($familiar[Space Jellyfish]);
	string temp = visit_url("place.php?whichplace=thesea");
	temp = visit_url("place.php?whichplace=thesea&action=thesea_left2");
	temp = visit_url("choice.php?pwd=&whichchoice=1219&option=1");
	use_familiar(old);
	return true;
}
