script "cc_bondmember.ash"

void bond_initializeSettings()
{
	if(my_path() == "License to Adventure")
	{
		set_property("cc_100familiar", $familiar[Egg Benedict]);
		set_property("cc_getBeehive", true);
		set_property("cc_cubeItems", true);
		set_property("cc_getStarKey", true);
		set_property("cc_grimstoneOrnateDowsingRod", true);
		set_property("cc_holeinthesky", true);
		set_property("cc_useCubeling", true);
		set_property("cc_wandOfNagamar", false);
		set_property("choiceAdventure1258", 2);
		set_property("choiceAdventure1261", 1);
		set_property("cc_familiarChoice", "");
	}

	if(get_property("cc_dickstab").to_boolean())
	{
		pullXWhenHaveY($item[Improved Martini], 10, 0);
		pullXWhenHaveY($item[Splendid Martini], 3, 0);
		pullXWhenHaveY($item[The Crown of Ed the Undying], 1, 0);
		pullXWhenHaveY($item[Infinite BACON Machine], 1, 0);
		pullXWhenHaveY($item[Stuffed Shoulder Parrot], 1, 0);
		pullXWhenHaveY($item[Eyepatch], 1, 0);
		pullXWhenHaveY($item[Swashbuckling Pants], 1, 0);
		pullXWhenHaveY($item[Gravy Boat], 1, 0);
		pullXWhenHaveY($item[Blackberry Galoshes], 1, 0);
		bond_buySkills();
		deck_cheat("tower");
		deck_cheat("mine");
		deck_cheat("sheep");
		kgbSetup();
		use(1, $item[Infinite BACON Machine]);
		if(!get_property("_internetViralVideoBought").to_boolean() && (item_amount($item[BACON]) >= 20))
		{
			cli_execute("make 1 viral video");
		}
		if(!get_property("_pottedTeaTreeUsed").to_boolean())
		{
			cli_execute("teatree " + $item[Cuppa Sobrie Tea]);
		}
		if(equipped_item($slot[Hat]) != $item[The Crown of Ed the Undying])
		{
			equip($slot[Hat], $item[The Crown of Ed the Undying]);
			adjustEdHat("weasel");
		}
		doNumberology("battlefield");
		adjustEdHat("hyena");
	}
}

boolean bond_buySkills()
{
	if(my_path() != "License to Adventure")
	{
		return false;
	}
	string page = visit_url("place.php?whichplace=town_right&action=town_bondhq", false);
	matcher bondPoints = create_matcher("You have (\\d+) pound", page);
	int points = 0;
	if(bondPoints.find())
	{
		points = to_int(bondPoints.group(1));
		print("Found " + points + " pound(s) of social capital husks.", "green");
	}

	while(points > 0)
	{
		int start = points;
		if(!get_property("bondSymbols").to_boolean())
		{
			if(points >= 3)
			{
				print("Getting bondSymbols", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=10&w=s");
				points -= 3;
			}
		}
		else if(!get_property("bondJetpack").to_boolean())
		{
			if(points >= 3)
			{
				print("Getting bondJetpack", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=12&w=s");
				points -= 3;
			}
		}
		else if(!get_property("bondDrunk1").to_boolean())
		{
			if(points >= 2)
			{
				print("Getting bondDrunk1", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=8&w=s");
				points -= 2;
			}
		}
		else if(!get_property("bondDrunk2").to_boolean())
		{
			if(points >= 3)
			{
				print("Getting bondDrunk2", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=11&w=s");
				points -= 3;
			}
		}
		else if(!get_property("bondMartiniPlus").to_boolean())
		{
			if(points >= 3)
			{
				print("Getting bondMartiniPlus", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=13&w=p");
				points -= 3;
			}
		}
		else if(!get_property("bondMartiniTurn").to_boolean())
		{
			if(points >= 1)
			{
				print("Getting bondMartiniTurn", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=1&w=p");
				points -= 1;
			}
		}
		else if(!get_property("bondAdv").to_boolean())
		{
			if(points >= 1)
			{
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=1&w=s");
				points -= 1;
			}
		}
		else if(!get_property("bondBridge").to_boolean())
		{
			if(points >= 3)
			{
				print("Getting bondBridge", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=14&w=s");
				points -= 3;
			}
		}
		else if(!get_property("bondSpleen").to_boolean())
		{
			if(points >= 4)
			{
				print("Getting bondSpleen", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=17&w=s");
				points -= 4;
			}
		}
		else if(!get_property("bondDesert").to_boolean())
		{
			if(points >= 5)
			{
				print("Getting bondDesert", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=18&w=s");
				points -= 5;
			}
		}
		else if(!get_property("bondMeat").to_boolean())
		{
			if(points >= 1)
			{
				print("Getting bondMeat", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=2&k=11&w=p");
				points -= 1;
			}
		}
		else if(!get_property("bondItem1").to_boolean())
		{
			if(points >= 1)
			{
				print("Getting bondItem1", "blue");
				page = visit_url("choice.php?whichchoice=1259&pwd=&option=1&k=2&w=p");
				points -= 1;
			}
		}
		if(start == points)
		{
			break;
		}
	}
	return true;
}


boolean LM_bond()
{
	if(my_path() != "License to Adventure")
	{
		return false;
	}

	if(have_effect($effect[Disavowed]) > 0)
	{
		if(have_skill($skill[Disco Nap]) && (my_mp() > mp_cost($skill[Disco Nap])))
		{
			use_skill(1, $skill[Disco Nap]);
		}
		set_property("_cc_bondBriefing", "started");
	}

	if(get_property("_cc_bondBriefing") == "started")
	{
		if(get_property("cc_dickstab").to_boolean() && !possessEquipment($item[Dented Scepter]) && is_unrestricted($item[Witchess Set]) && get_property("lovebugsUnlocked").to_boolean() && possessEquipment($item[Your Cowboy Boots]) && have_skills($skills[Curse of Weaksauce, Shell Up, Lunging Thrust-Smack, Sauceshell, Itchy Curse Finger]) && is_unrestricted($item[Source Terminal]) && (cc_get_campground() contains $item[Witchess Set]) && (cc_get_campground() contains $item[Source Terminal]))
		{
			cc_sourceTerminalEducate($skill[Turbo], $skill[Compress]);
			if(my_mp() < 55)
			{
				doRest();
			}
			buffMaintain($effect[Pyromania], 15, 1, 1);
			buffMaintain($effect[Frostbeard], 15, 1, 1);
			buffMaintain($effect[Power Ballad of the Arrowsmith], 5, 1, 1);
			set_property("cc_combatDirective", "start;skill weaksauce;skill cowboy kick;item time-spinner;skill love stinkbug;skill love mosquito;skill compress;skill turbo;skill shell up;skill sauceshell;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack;skill lunging thrust-smack");
			boolean retval = cc_advWitchess("king");
			set_property("cc_combatDirective", "");

			cc_sourceTerminalEducate($skill[Extract], $skill[Digitize]);
			if(!possessEquipment($item[Dented Scepter]))
			{
				abort("Dickstab failed");
			}
			return retval;
		}


		if(my_meat() < 1000)
		{
			set_property("choiceAdventure1261", 4);
		}
		else
		{
			set_property("choiceAdventure1261", 1);
		}
		boolean retval = ccAdv($location[Super Villain\'s Lair]);
		if(!retval)
		{
			set_property("_cc_bondBriefing", "finished");
			bond_buySkills();
		}
		return retval;
	}

	if(get_property("_cc_bondLevel").to_int() < my_level())
	{
		set_property("_cc_bondLevel", my_level());
		bond_buySkills();
	}

	if(get_property("cc_dickstab").to_boolean())
	{
		if((get_property("_cc_bondBriefing") == "finished") && get_property("gingerbreadCityAvailable").to_boolean() && (get_property("_gingerbreadCityTurns").to_int() < 5))
		{
			if(!get_property("_gingerbreadClockAdvanced").to_boolean())
			{
				if((item_amount($item[Greek Fire]) >= 4) && (have_effect($effect[Sweetbreads Flamb&eacute;]) == 0))
				{
					use(3, $item[Greek Fire]);
				}
				string old = get_property("choiceAdventure1215");
				set_property("choiceAdventure1215", 1);
				ccAdv($location[Gingerbread Civic Center]);
				set_property("choiceAdventure1215", old);
				return true;
			}
			if(get_property("_gingerbreadCityTurns").to_int() < 4)
			{
				return ccAdV($location[Gingerbread Upscale Retail District]);
			}
			if(get_property("_gingerbreadCityTurns").to_int() == 4)
			{
				string old = get_property("choiceAdventure1204");
				set_property("choiceAdventure1204", 1);
				ccAdv($location[Gingerbread Train Station]);
				set_property("choiceAdventure1204", old);
				return true;
			}
			abort("Gingerdickstab error");
		}

		if(get_property("_cc_bondBriefing") == "finished")
		{
			if(get_property("lastDesertUnlock").to_int() < my_ascensions())
			{
				if(my_meat() > 5000)
				{
					return LX_bitchinMeatcar();
				}
			}
			else if(!possessEquipment($item[Antique Accordion]))
			{
				if(my_meat() > 6000)
				{
					buyUpTo(1, $item[Antique Accordion]);
				}
			}
			else if((my_mp() > 85) && (my_level() > 8) && (my_adventures() < 20))
			{
				if((inebriety_left() < 3) && (inebriety_left() >= 1))
				{
					buffMaintain($effect[Ode to Booze], 50, 1, inebriety_left());
					if(item_amount($item[Splendid Martini]) >= inebriety_left())
					{
						ccDrink(inebriety_left(), $item[Splendid Martini]);
					}
					else
					{
						ccDrink(inebriety_left(), $item[Improved Martini]);
					}
				}
			}
			else if((my_mp() > 85) && (my_level() > 6))
			{
				if(inebriety_left() >= 10)
				{
					buffMaintain($effect[Ode to Booze], 50, 1, 10);
					ccDrink(10, $item[Improved Martini]);
				}
				else if(inebriety_left() >= 3)
				{
					buffMaintain($effect[Ode to Booze], 50, 1, 3);
					if(item_amount($item[Splendid Martini]) >= 3)
					{
						ccDrink(3, $item[Splendid Martini]);
					}
					else
					{
						ccDrink(3, $item[Improved Martini]);
					}
				}
			}
		}

		if((internalQuestStatus("questL08Trapper") < 2) && (my_level() >= 8))
		{
			if(item_amount($item[Goat Cheese]) == 0)
			{
				L8_trapperStart();
				if(L8_trapperGround())
				{
					return true;
				}
			}
			else if(item_amount($item[Goat Cheese]) == 2)
			{
				cc_sourceTerminalEducate($skill[Extract], $skill[Digitize]);
				return timeSpinnerCombat($monster[Dairy Goat]);
			}
			else if(item_amount(to_item(get_property("trapperOre"))) == 1)
			{
				while(acquireHermitItem($item[Ten-Leaf Clover]));
				use(1, $item[Disassembled Clover]);
				backupSetting("cloverProtectActive", false);
				ccAdvBypass(270, $location[Itznotyerzitz Mine]);
				restoreSetting("cloverProtectActive");
				return true;
			}
			else if(item_amount(to_item(get_property("trapperOre"))) == 3)
			{
				return L8_trapperGround();
			}
		}
		if((my_level() >= 9) && (item_amount($item[Victor\'s Spoils]) > 0))
		{
			use(1, $item[Victor\'s Spoils]);
			if(LX_freeCombats())
			{
				return true;
			}
		}
		if(get_property("questM20Necklace") == "finished")
		{
			if(get_property("_sourceTerminalDigitizeMonster") == $monster[Writing Desk])
			{
				if(get_property("_sourceTerminalDigitizeUses").to_int() == 1)
				{
					woods_questStart();
					equip($slot[acc2], $item[Continuum Transfunctioner]);
					cc_sourceTerminalEducate($skill[Extract], $skill[Digitize]);
					set_property("cc_digitizeDirective", $monster[Blooper]);
					ccAdv(1, $location[8-bit Realm]);
					set_property("cc_digitizeDirective", "");
				}
			}
		}
		if(my_level() >= 10)
		{
			if(!get_property("_incredibleSelfEsteemCast").to_boolean() && (my_mp() > 20))
			{
				use_skill(1, $skill[Incredible Self-Esteem]);
			}
			if(L10_airship() || L10_basement() || L10_ground())
			{
				return true;
			}
			if(possessEquipment($item[Mohawk Wig]))
			{
				if(L10_topFloor())
				{
					return true;
				}
			}
			if(!get_property("cc_getStarKey").to_boolean())
			{
				if(item_amount($item[Richard\'s Star Key]) == 0)
				{
					if(item_amount($item[Star Chart]) == 0)
					{
						return ccAdv($location[The Hole In The Sky]);
					}
				}
			}
		}
		if(internalQuestStatus("questM21Dance") >= 4)
		{
			if((get_property("cc_swordfish") != "finished") && (item_amount($item[Disposable Instant Camera]) == 0))
			{
				if(contains_text($location[The Haunted Bedroom], $monster[Animated Ornate Nightstand]))
				{
					set_property("choiceAdventure878", 4);
					set_property("cc_bedroomHandler1", "yes");
					set_property("cc_bedroomHandler2", "yes");
					timeSpinnerCombat($monster[Animated Ornate Nightstand]);
					if(contains_text(visit_url("main.php"), "choice.php"))
					{
						ccAdv($location[The Haunted Bedroom]);
					}
					if(contains_text(visit_url("main.php"), "Combat"))
					{
						ccAdv($location[The Haunted Bedroom]);
					}
					set_property("cc_bedroomHandler1", "no");
					set_property("cc_bedroomHandler2", "no");

				}
			}
		}
		if((my_daycount() == 1) && (get_property("cc_swordfish") == "finished"))
		{
			abort("Made it too far. Need to fix for this.");
		}
		//End of day:
		//Time spinner bloopers.
		//+adv chateau
		//Get kgb buffs.
		//A View to Some Meat
	}



	if(get_property("_cc_bondBriefing") == "finished")
	{
		return false;
	}

	return false;
}

item[int] bondDrinks()
{
	item[int] retval = itemList();

	foreach it in $items[]
	{
		if((it.smallimage == "martini.gif") && is_unrestricted(it))
		{
			retval = retval.ListInsert(it);
		}
	}
	return retval;

}
