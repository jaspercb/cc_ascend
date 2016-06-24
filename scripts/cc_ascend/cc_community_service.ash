script "cc_community_service.ash"

#	Some details derived some yojimbos_law's forum post:
#	http://forums.kingdomofloathing.com/vb/showpost.php?p=4769933&postcount=345


import<cc_ascend/cc_clan.ash>
import<cc_ascend/cc_util.ash>
import<cc_ascend/cc_ascend_header.ash>
import<cc_ascend/cc_mr2016.ash>
import<cc_ascend/cc_mr2014.ash>



int get_cs_questNum(string input);
int get_cs_questCost(int quest);
int get_cs_questCost(string input);
int [int] get_cs_questList();
boolean do_cs_quest(int quest);
boolean do_cs_quest(string quest);
string what_cs_quest(int quest);
int expected_next_cs_quest();
void cs_dnaPotions();
void cs_initializeDay(int day);
void cs_make_stuff();
boolean cs_eat_stuff(int quest);
boolean cs_giant_growth();
boolean cs_eat_spleen();
boolean cs_witchess();


# Internal
int expected_next_cs_quest_internal();
string cs_combatLTB(int round, string opp, string text);
string cs_combatNormal(int round, string opp, string text);
string cs_combatYR(int round, string opp, string text);

void cs_initializeDay(int day)
{
	if(my_path() != "Community Service")
	{
		return;
	}

	set_property("choiceAdventure1106", 2);
	set_property("choiceAdventure1107", 1);
	set_property("choiceAdventure1108", 3);

	if(day == 1)
	{
		if(get_property("cc_day1_init") != "finished")
		{
			set_property("cc_day1_dna", "finished");
			if(item_amount($item[transmission from planet Xi]) > 0)
			{
				use(1, $item[transmission from planet xi]);
			}
			if(item_amount($item[Xiblaxian holo-wrist-puter simcode]) > 0)
			{
				use(1, $item[Xiblaxian holo-wrist-puter simcode]);
			}

			if(have_skill($skill[Spirit of Peppermint]))
			{
				use_skill(1, $skill[Spirit of Peppermint]);
			}

			if(have_skill($skill[Iron Palm Technique]) && (have_effect($effect[Iron Palms]) == 0) && (my_class() == $class[Seal Clubber]))
			{
				use_skill(1, $skill[Iron Palm Technique]);
			}

			visit_url("tutorial.php?action=toot");
			use(item_amount($item[Letter From King Ralph XI]), $item[Letter From King Ralph XI]);
			use(item_amount($item[Pork Elf Goodies Sack]), $item[Pork Elf Goodies Sack]);
			tootGetMeat();

			int[string] terminalStatus = cc_sourceTerminalStatus();
			cc_sourceTerminalRequest("educate extract.edu");
			if(terminalStatus["stats.enq"] == 1)
			{
				cc_sourceTerminalRequest("enquiry stats.enq");
			}
			else if(terminalStatus["protect.enq"] == 1)
			{
				cc_sourceTerminalRequest("enquiry protect.enq");
			}
			else
			{
				cc_sourceTerminalRequest("enquiry familiar.enq");
			}

			equipBaseline();
			visit_url("guild.php?place=challenge");

			deck_cheat("myst stat");
			deck_cheat("meat");
			deck_cheat("green mana");
			autosell(item_amount($item[1952 Mickey Mantle Card]), $item[1952 Mickey Mantle Card]);

			while(((item_amount($item[turtle totem]) == 0) || (item_amount($item[saucepan]) == 0)) && (my_meat() > npc_price($item[Chewing Gum on a String])))
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}

			if(knoll_available())
			{
				if(item_amount($item[Bitchin\' Meatcar]) == 0)
				{
					cli_execute("make bitch");
				}
				buyUpTo(1, $item[Antique Accordion]);
			}
			else
			{
				buyUpTo(1, $item[Toy Accordion]);
			}

			if(have_skill($skill[Summon Smithsness]))
			{
				while((my_mp() >= mp_cost($skill[Summon Smithsness])) && (get_property("tomeSummons").to_int() < 3))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
			}

			cli_execute("garden pick");
			if(!cc_haveWitchess())
			{
				if((item_amount($item[Ice Harvest]) >= 3) && (item_amount($item[Snow Berries]) >= 1))
				{
					cli_execute("make ice island long tea");
				}
			}

			startMeatsmithSubQuest();

			if(have_familiar($familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
			{
				familiar last = my_familiar();
				int gift = 1;
				if(get_property("cc_100familiar").to_boolean() && (my_familiar() != $familiar[Crimbo Shrub]))
				{
					gift = 2;
				}
				use_familiar($familiar[Crimbo Shrub]);
				visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
				visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=2&lights=1&garland=3&gift=" + gift);
				use_familiar(last);
			}

			if(get_property("barrelShrineUnlocked").to_boolean())
			{
				handleBarrelFullOfBarrels();
			}

			if(get_property("cc_breakstone").to_boolean())
			{
				visit_url("campground.php?action=stone&smashstone=Yep.&pwd&confirm=on", true);
				set_property("cc_breakstone", false);
			}
			set_property("cc_day1_init", "finished");
			try
			{
				visit_url("council.php");
			}
			finally
			{
				print("Visited Council for first time, if you manually visited the council before running, this might have aborted, just run again.", "red");
			}
		}
	}
	else if(day == 2)
	{
		if(get_property("cc_day2_init") != "finished")
		{
			equipBaseline();
			deck_cheat("Giant Growth");
			deck_cheat("green mana");

			if(have_skill($skill[Summon Smithsness]))
			{
				while((my_mp() >= mp_cost($skill[Summon Smithsness])) && (get_property("tomeSummons").to_int() < 2))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}

				if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])) && (get_property("tomeSummons").to_int() < 3))
				{
					cli_execute("make cold-filtered water");
				}
				else if((my_mp() >= mp_cost($skill[Summon Smithsness])) && (get_property("tomeSummons").to_int() < 3))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
			}

			if((item_amount($item[Seal Tooth]) == 0) && have_skill($skill[Ambidextrous Funkslinging]))
			{
				cli_execute("hermit seal tooth");
			}

			cli_execute("garden pick");

			while(item_amount($item[saucepan]) == 0)
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}

			cli_execute("postcheese");

			if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			set_property("cc_day2_init", "finished");
		}
	}
}


void cs_make_stuff()
{
	if(item_amount($item[skeleton key]) == 0)
	{
		if((item_amount($item[skeleton bone]) > 0) && (item_amount($item[loose teeth]) > 0))
		{
			cli_execute("make skeleton key");
		}
	}
	if((item_amount($item[Milk of Magnesium]) == 0) && (item_amount($item[Glass of Goat\'s Milk]) > 0) && have_skill($skill[Advanced Saucecrafting]) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0))
	{
		cli_execute("make milk of magnesium");
	}


	if(my_daycount() == 1)
	{
		if(!possessEquipment($item[Hairpiece on Fire]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			if(knoll_available() || (item_amount($item[Maiden Wig]) > 0))
			{
				cli_execute("make Hairpiece on Fire");
			}
		}
		if(!possessEquipment($item[Saucepanic]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Saucepanic");
		}
		if(!possessEquipment($item[A Light that Never Goes Out]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make A Light that Never Goes Out");
		}
	}
	if(my_daycount() == 2)
	{
		if((available_amount($item[Saucepanic]) == 1) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Saucepanic");
		}
		if(!possessEquipment($item[Vicar\'s Tutu]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Vicar's Tutu");
		}

		if(!possessEquipment($item[Staff of the Headmaster\'s Victuals]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Staff of the Headmaster\'s Victuals");
		}

		if(!have_familiar($familiar[Machine Elf]) && !get_property("cc_100familiar").to_boolean())
		{
			if(item_amount($item[Handful of Smithereens]) >= 3)
			{
				cli_execute("make 3 louder than bomb");
			}
		}

		if((item_amount($item[Scrumptious Reagent]) >= 5) && have_skill($skill[Advanced Saucecrafting]))
		{
			if((item_amount($item[gr8ps]) > 0) && (item_amount($item[Potion of Temporary Gr8tness]) == 0) && (npc_price($item[Delectable Catalyst]) < my_meat()) && (get_property("_rapidPrototypingUsed").to_int() < 5) && have_skill($skill[The Way of Sauce]))
			{
				cli_execute("make " + $item[Potion of Temporary Gr8tness]);
			}
			if((item_amount($item[grapefruit]) > 0) && (item_amount($item[Ointment of the Occult]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make ointment of the occult");
			}
			if((item_amount($item[squashed frog]) > 0) && (item_amount($item[Frogade]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make frogade");
			}
			if((item_amount($item[eye of newt]) > 0) && (item_amount($item[Eyedrops of Newt]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make eyedrops of newt");
			}
			else if((item_amount($item[salamander spleen]) > 0) && (item_amount($item[Salamander Slurry]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make salamander slurry");
			}
		}

		if((item_amount($item[Yellow Pixel]) >= 15) && (item_amount($item[Black Pixel]) >= 2) && (item_amount($item[Pixel Star]) == 0))
		{
			cli_execute("make pixel star");
		}
		if(item_amount($item[Yellow Pixel]) >= 15)
		{
			cli_execute("make miniature power pill");
		}

	}
}


boolean cs_eat_spleen()
{
	if(my_path() != "Community Service")
	{
		return false;
	}
	if(my_daycount() > 1)
	{
		return false;
	}

	int oldSpleenUse = my_spleen_use();
	while((my_spleen_use() < 12) && ((item_amount($item[Unconscious Collective Dream Jar]) + item_amount($item[Grim Fairy Tale]) + item_amount($item[Powdered Gold])) > 0))
	{
		if(item_amount($item[Unconscious Collective Dream Jar]) > 0)
		{
			chew(1, $item[Unconscious Collective Dream Jar]);
		}
		if(item_amount($item[Grim Fairy Tale]) > 0)
		{
			chew(1, $item[Grim Fairy Tale]);
		}
		if(item_amount($item[Powdered Gold]) > 0)
		{
			chew(1, $item[Powdered Gold]);
		}
	}
	return oldSpleenUse != my_spleen_use();
}


boolean cs_eat_stuff(int quest)
{
	if(my_path() != "Community Service")
	{
		return false;
	}

	if(quest == 0)
	{
		if(my_fullness() != 0)
		{
			return false;
		}
		if(cc_haveSourceTerminal())
		{
			if((item_amount($item[Source Essence]) < 10) && (item_amount($item[Browser Cookie]) == 0))
			{
				return false;
			}
		}
		if(item_amount($item[Milk of Magnesium]) > 0)
		{
			use(1, $item[Milk of Magnesium]);
		}
		if(get_property("cc_noSleepingDog").to_boolean() || have_skill($skill[Dog Tired]))
		{
			if(cc_sourceTerminalExtrudeLeft() > 0)
			{
				if(item_amount($item[Browser Cookie]) == 0)
				{
					cc_sourceTerminalExtrude($item[Browser Cookie]);
				}
			}

			if(item_amount($item[Browser Cookie]) > 0)
			{
				eat(1, $item[Browser Cookie]);
			}
			else
			{
				eatFancyDog("savage macho dog");
			}
		}
		else
		{
			eatFancyDog("sleeping dog");
		}

		if((item_amount($item[Handful of Smithereens]) > 0) && (fullness_left() >= 2))
		{
			cli_execute("make 1 this charming flan");
			eat(1, $item[This Charming Flan]);
		}
		if((item_amount($item[Snow Berries]) > 1) && (fullness_left() >= 1))
		{
			cli_execute("make 1 snow crab");
			eat(1, $item[Snow Crab]);
		}
	}

	if(quest == 9)
	{
		if(item_amount($item[Weird Gazelle Steak]) > 0)
		{
			if(item_amount($item[Milk of Magnesium]) > 0)
			{
				use(1, $item[Milk of Magnesium]);
			}
			eat(1, $item[Weird Gazelle Steak]);

			if(get_property("cc_noSleepingDog").to_boolean())
			{
				if(cc_sourceTerminalExtrudeLeft() > 0)
				{
					if(item_amount($item[Browser Cookie]) == 0)
					{
						cc_sourceTerminalExtrude($item[Browser Cookie]);
					}
				}

				if(item_amount($item[Browser Cookie]) > 0)
				{
					eat(1, $item[Browser Cookie]);
				}
				else
				{
					eatFancyDog("savage macho dog");
				}
			}
			else
			{
				eatFancyDog("sleeping dog");
			}
			if((item_amount($item[Handful of Smithereens]) > 0) && (fullness_left() >= 2))
			{
				cli_execute("make 1 this charming flan");
				eat(1, $item[This Charming Flan]);
			}
			if((item_amount($item[Snow Berries]) > 1) && (fullness_left() >= 1))
			{
				cli_execute("make 1 snow crab");
				eat(1, $item[Snow Crab]);
			}

		}
	}
	else if(quest == 10)
	{
		if(item_amount($item[Sausage Without A Cause]) > 0)
		{
			if(item_amount($item[Milk of Magnesium]) > 0)
			{
				use(1, $item[Milk of Magnesium]);
			}
			eat(1, $item[Sausage Without A Cause]);
			if(item_amount($item[Limp Broccoli]) > 0)
			{
				eat(1, $item[Limp Broccoli]);
			}
			else
			{
				if(item_amount($item[Ice Harvest]) > 0)
				{
					eat(1, $item[Ice Harvest]);
				}
				if(item_amount($item[Snow Berries]) > 1)
				{
					cli_execute("make 1 snow crab");
					eat(1, $item[Snow Crab]);
				}
			}
			eatFancyDog("junkyard dog");
		}
	}
	return true;
}

void cs_dnaPotions()
{
	if(my_path() != "Community Service")
	{
		return;
	}
	dna_generic();

	if((get_property("dnaSyringe") == $phylum[fish]) && !get_property("_dnaHybrid").to_boolean())
	{
		if((get_property("_dnaPotionsMade").to_int() == 3) && (my_daycount() == 1))
		{
			cli_execute("camp dnainject");
		}
	}

}

string cs_combatNormal(int round, string opp, string text)
{
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
	}

	set_property("cc_diag_round", round);
	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	string combatState = get_property("cc_combatHandler");

	phylum current = to_phylum(get_property("dnaSyringe"));
	phylum type = monster_phylum(enemy);

	if((!contains_text(combatState, "snokebomb")) && (have_skill($skill[Snokebomb])) && (get_property("_snokebombUsed").to_int() < 3) && ((my_mp() - 20) >= mp_cost($skill[Snokebomb])))
	{
		if($monsters[Swarm of Skulls] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(Snokebomb)");
			handleTracker(enemy, $skill[Snokebomb], "cc_banishes");
			return "skill " + $skill[Snokebomb];
		}
	}

	if((my_location() == $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]) && !contains_text(combatState, "love gnats"))
	{
		combatState = combatState + "(love gnats)(love stinkbug)(love mosquito)";
		set_property("cc_combatHandler", combatState);
	}

	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("cc_combatHandler", combatState + "(love gnats)");
		return "skill summon love gnats";
	}


	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40))
	{
		if((enemy == $monster[Novelty Tropical Skeleton]) ||
			(enemy == $monster[Possessed Can of Tomatoes]) ||
			(enemy == $monster[Government Scientist]))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
	}

	if((!contains_text(combatState, "cleesh")) && (my_mp() > 10) && ((enemy == $monster[creepy little girl]) || (enemy == $monster[lab monkey]) || (enemy == $monster[super-sized cola wars soldier])))
	{
			set_property("cc_combatHandler", combatState + "(cleesh)");
			return "skill cleesh";
	}

	if((!contains_text(combatState, "DNA")) && (item_amount($item[DNA Extraction Syringe]) > 0))
	{
		if(type != current)
		{
			set_property("cc_combatHandler", combatState + "(DNA)");
			return "item DNA extraction syringe";
		}
	}

	if((!contains_text(combatState, "winkat")) && (my_familiar() == $familiar[Reanimated Reanimator]))
	{
		if($monsters[Witchess Bishop, Witchess Knight] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(winkat)");
			if((get_property("_badlyRomanticArrows").to_int() == 1) && (get_property("romanticTarget") != enemy))
			{
				abort("Have animator out but can not arrow");
			}
			return "skill wink at";
		}
	}

	if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love stinkbug)");
		return "skill summon love stinkbug";
	}

	if((!contains_text(combatState, "(digitize)")) && have_skill($skill[Digitize]) && (my_mp() > (mp_cost($skill[Digitize]) * 2)) && ($monsters[Witchess Bishop, Witchess Knight] contains enemy))
	{
		set_property("cc_combatHandler", combatState + "(digitize)");
		return "skill " + $skill[Digitize];
	}

	boolean danger = false;
	if((my_location() == $location[The X-32-F Combat Training Snowman]) && contains_text(text, "Cattle Prod"))
	{
		danger = true;
	}

	if((!contains_text(combatState, "(extract)")) && have_skill($skill[Extract]) && (my_mp() > (mp_cost($skill[Extract]) * 3)) && !danger)
	{
		set_property("cc_combatHandler", combatState + "(extract)");
		return "skill " + $skill[Extract];
	}

	if((!contains_text(combatState, "love mosquito")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love mosquito)");
		return "skill summon love mosquito";
	}



	if((!contains_text(combatState, "shattering punch")) && have_skill($skill[Shattering Punch]) && ((my_mp() / 2) > mp_cost($skill[Shattering Punch])) && !isFreeMonster(enemy) && !enemy.boss && (get_property("_shatteringPunchUsed").to_int() < 3))
	{
		set_property("cc_combatHandler", combatState + "(shattering punch)");
		handleTracker(enemy, $skill[shattering punch], "cc_instakill");
		return "skill " + $skill[shattering punch];
	}

	if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= 32))
	{
		set_property("cc_combatHandler", combatState + "(weaksauce)");
		return "skill curse of weaksauce";
	}

	if(have_skill($skill[saucegeyser]) && (my_mp() >= 24))
	{
		return "skill saucegeyser";
	}

	return "skill salsaball";


}

string cs_combatYR(int round, string opp, string text)
{
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
	}

	set_property("cc_diag_round", round);
	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	string combatState = get_property("cc_combatHandler");

	phylum current = to_phylum(get_property("dnaSyringe"));
	phylum type = monster_phylum(enemy);

	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("cc_combatHandler", combatState + "(love gnats)");
		return "skill summon love gnats";
	}
	if((!contains_text(combatState, "DNA")) && (item_amount($item[DNA Extraction Syringe]) > 0))
	{
		if(type != current)
		{
			set_property("cc_combatHandler", combatState + "(DNA)");
			return "item DNA extraction syringe";
		}
	}
	boolean [monster] lookFor = $monsters[Dairy Goat, factory overseer (female), factory worker (female), mine overseer (male), mine overseer (female), mine worker (male), mine worker (female), sk8 gnome];
	if((have_effect($effect[Everything Looks Yellow]) == 0) && (lookFor contains enemy))
	{
		if(!contains_text(combatState, "yellowray"))
		{
			string combatAction = yellowRayCombatString();
			if(combatAction != "")
			{
				set_property("cc_combatHandler", combatState + "(yellowray)");
				if(index_of(combatAction, "skill") == 0)
				{
					handleTracker(enemy, to_skill(substring(combatAction, 6)), "cc_yellowRays");
				}
				else if(index_of(combatAction, "item") == 0)
				{
					handleTracker(enemy, to_item(substring(combatAction, 5)), "cc_yellowRays");
				}
				else
				{
					print("Unable to track yellow ray behavior: " + combatAction, "red");
				}
				return combatAction;
			}
			else
			{
				abort("Wanted a yellow ray but we can not find one.");
			}
		}
	}

	if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love stinkbug)");
		return "skill summon love stinkbug";
	}
	if((!contains_text(combatState, "(extract)")) && have_skill($skill[Extract]) && (my_mp() > (mp_cost($skill[Extract]) * 3)))
	{
		set_property("cc_combatHandler", combatState + "(extract)");
		return "skill " + $skill[Extract];
	}
	if((!contains_text(combatState, "love mosquito")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love mosquito)");
		return "skill summon love mosquito";
	}
	return "skill salsaball";
}

string cs_combatKing(int round, string opp, string text)
{
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
	}

	set_property("cc_diag_round", round);
	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	string combatState = get_property("cc_combatHandler");

	if(enemy != $monster[Witchess King])
	{
		abort("Wrong combat script called");
	}

	foreach action in $skills[Curse of Weaksauce, Conspiratorial Whispers, Tattle, Summon Love Mosquito, Shell Up, Silent Slam, Sauceshell, Summon Love Stinkbug, Extract]
	{
		if((!contains_text(combatState, "(" + action + ")")) && have_skill(action) && (my_mp() > mp_cost(action)))
		{
			set_property("cc_combatHandler", combatState + "(" + action + ")");
			return "skill " + action;
		}
	}

	return "action with weapon";
}


string cs_combatLTB(int round, string opp, string text)
{
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
	}

	set_property("cc_diag_round", round);
	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	string combatState = get_property("cc_combatHandler");

	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("cc_combatHandler", combatState + "(love gnats)");
		return "skill summon love gnats";
	}
	if((!contains_text(combatState, "giant growth")) && have_skill($skill[Giant Growth]))
	{
		set_property("cc_combatHandler", combatState + "(giant growth)");
		return "skill giant growth";
	}

	if(isFreeMonster(last_monster()))
	{
		return cs_combatNormal(round, opp, text);
	}

	if((!contains_text(combatState, "shattering punch")) && have_skill($skill[Shattering Punch]) && ((my_mp() / 2) > mp_cost($skill[Shattering Punch])) && !isFreeMonster(enemy) && !enemy.boss && (get_property("_shatteringPunchUsed").to_int() < 3))
	{
		set_property("cc_combatHandler", combatState + "(shattering punch)");
		handleTracker(enemy, $skill[shattering punch], "cc_instakill");
		return "skill " + $skill[shattering punch];
	}

	if((!contains_text(combatState, "louder than bomb")) && (item_amount($item[Louder Than Bomb]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(louder than bomb)");

		if((item_amount($item[Seal Tooth]) > 0) && have_skill($skill[Ambidextrous Funkslinging]))
		{
			return "item louder than bomb, seal tooth";
		}
		return "item louder than bomb";
	}
	if((!contains_text(combatState, "tennis ball")) && (item_amount($item[Tennis Ball]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(tennis ball)");

		if((item_amount($item[Seal Tooth]) > 0) && have_skill($skill[Ambidextrous Funkslinging]))
		{
			return "item tennis ball, seal tooth";
		}
		return "item tennis ball";
	}


	if((!contains_text(combatState, "power pill")) && (item_amount($item[Power Pill]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(power pill)");

		if((item_amount($item[Seal Tooth]) > 0) && have_skill($skill[Ambidextrous Funkslinging]))
		{
			return "item power pill, seal tooth";
		}
		return "item power pill";
	}

	abort("Could not free kill our Giant Growth, uh oh.");
	return "fail";
}

boolean cs_giant_growth()
{
	if(have_effect($effect[Giant Growth]) > 0)
	{
		return true;
	}
	if(item_amount($item[Green Mana]) == 0)
	{
		return false;
	}
	if(!have_skill($skill[Giant Growth]))
	{
		return false;
	}
	if((item_amount($item[Louder Than Bomb]) == 0) && !have_familiar($familiar[Machine Elf]))
	{
		return false;
	}

#	print("Starting LTBs: " + item_amount($item[Louder Than Bomb]), "blue");
	if(have_familiar($familiar[Machine Elf]) && !get_property("cc_100familiar").to_boolean())
	{
		use_familiar($familiar[Machine Elf]);
	}


	if(my_familiar() == $familiar[Machine Elf])
	{
		ccAdv(1, $location[The Deep Machine Tunnels], "cs_combatLTB");
	}
	else
	{
		ccAdv(1, $location[8-bit Realm], "cs_combatLTB");
	}
#	print("Ending LTBs: " + item_amount($item[Louder Than Bomb]), "blue");
#	cli_execute("refresh inv");
#	print("Corrected LTBs: " + item_amount($item[Louder Than Bomb]), "blue");


	if(have_effect($effect[Giant Growth]) > 0)
	{
		return true;
	}
	return cs_giant_growth();
}


int [int] get_cs_questList()
{
	int [int] questList;
	if(my_path() != "Community Service")
	{
		return questList;
	}

	string page = visit_url("council.php");
	matcher quest_matcher = create_matcher("whichchoice value=1089><input type=hidden name=option value=(\\d+)(?:.*?)Perform Service [(](\\d+) Advent", page);

	while(quest_matcher.find())
	{
		int found = to_int(quest_matcher.group(1));
		int adv = to_int(quest_matcher.group(2));
		questList[found] = adv;
	}

	return questList;
}


int expected_next_cs_quest()
{
	if(my_path() != "Community Service")
	{
		return 0;
	}

	int retval = expected_next_cs_quest_internal();
	if(retval > 0)
	{
		switch(retval)
		{
		case 1:		print("Community Service Quest  1: HP", "blue");								break;
		case 2:		print("Community Service Quest  2: Muscle", "blue");							break;
		case 3:		print("Community Service Quest  3: Mysticality", "blue");						break;
		case 4:		print("Community Service Quest  4: Moxie", "blue");								break;
		case 5:		print("Community Service Quest  5: Familiar Weight", "blue");					break;
		case 6:		print("Community Service Quest  6: Melee Damage", "blue");						break;
		case 7:		print("Community Service Quest  7: Spell Damage", "blue");						break;
		case 8:		print("Community Service Quest  8: Monsters Less Attracted to You", "blue");	break;
		case 9:		print("Community Service Quest  9: Item/Booze Drops", "blue");					break;
		case 10:	print("Community Service Quest 10: Hot Protection", "blue");					break;
		case 11:	print("Community Service Quest 11: Coiling Wire", "blue");						break;
		}
	}
	return retval;
}

string what_cs_quest(int quest)
{
	switch(quest)
	{
	case 1:		return "Community Service Quest 1: HP";
	case 2:		return "Community Service Quest 2: Muscle";
	case 3:		return "Community Service Quest 3: Mysticality";
	case 4:		return "Community Service Quest 4: Moxie";
	case 5:		return "Community Service Quest 5: Familiar Weight";
	case 6:		return "Community Service Quest 6: Melee Damage";
	case 7:		return "Community Service Quest 7: Spell Damage";
	case 8:		return "Community Service Quest 8: Monsters Less Attracted to You";
	case 9:		return "Community Service Quest 9: Item/Booze Drops";
	case 10:	return "Community Service Quest 10: Hot Protection";
	case 11:	return "Community Service Quest 11: Coiling Wire";
	default:	return "Community Service Quest 0: NULL";
	}
}


int expected_next_cs_quest_internal()
{
	if(my_path() != "Community Service")
	{
		return 0;
	}

	int [int] questList = get_cs_questList();
	boolean [int] questOrder = $ints[11, 6, 9, 7, 10, 1, 2, 3, 4, 5, 8];
	foreach quest in questOrder
	{
		if(questList contains quest)
		{
			return quest;
		}
	}
	return 0;
}


boolean do_cs_quest(int quest)
{
	if(my_path() != "Community Service")
	{
		return false;
	}

	switch(quest)
	{
	case 1:		ccMaximize("hp, -equip snow suit", 1500, 0, false);					break;
	case 2:		ccMaximize("muscle, -equip snow suit", 1500, 0, false);				break;
	case 3:		ccMaximize("myst, -equip snow suit", 1500, 0, false);				break;
	case 4:		ccMaximize("moxie, -equip snow suit", 1500, 0, false);				break;
	case 5:		ccMaximize("familiar weight, -equip snow suit", 1500, 0, false);	break;
#	case 6:		ccMaximize("melee damage, -equip snow suit", 1500, 0, false);		break;
	case 7:		ccMaximize("spell damage, -equip snow suit", 1500, 0, false);		break;
	case 8:		ccMaximize("-combat, -equip snow suit", 1500, 0, false);			break;
	case 9:		ccMaximize("item, -equip snow suit", 1500, 0, false);				break;
	case 10:	ccMaximize("hot res, -equip snow suit", 1500, 0, false);			break;
	}


	int [int] questList = get_cs_questList();
	if(((questList contains quest) && (my_adventures() >= questList[quest])) || (quest == 30))
	{
		string temp = visit_url("council.php");
		if(quest != 30)
		{
			temp = run_choice(quest);
			print("Quest " + quest + " completed for " + questList[quest] + " adventures.", "blue");
		}
		else
		{
			if(get_property("cc_stayInRun").to_boolean())
			{
				abort("User wanted to stay in run (cc_stayInRun), we are done.");
			}
			visit_url("choice.php?pwd&whichchoice=1089&option=30");
			print("Community Service Completed. Beep boop.", "blue");
		}
		return true;
	}
	else
	{
		return false;
	}
}


boolean do_cs_quest(string quest)
{
	return do_cs_quest(get_cs_questNum(quest));
}


int get_cs_questCost(int quest)
{
	if((quest < 0) || (quest > 11))
	{
		abort("Invalid quest value specified");
	}
	if(my_path() != "Community Service")
	{
		return -1;
	}

	int [int] questsLeft = get_cs_questList();
	return questsLeft[quest];
}


int get_cs_questCost(string input)
{
	return get_cs_questCost(get_cs_questNum(input));
}

int get_cs_questNum(string input)
{
	if(my_path() != "Community Service")
	{
		return -1;
	}
	input = to_lower_case(input);
	if(input == "hp")
	{
		return 1;
	}
	if((input == "mus") || (input == "muscle") || (input == "musc"))
	{
		return 2;
	}
	if((input == "myst") || (input == "mysticality"))
	{
		return 3;
	}
	if((input == "mox") || (input == "moxie"))
	{
		return 4;
	}
	if((input == "familiar weight") || (input == "familiar") || (input == "weight") || (input == "fam") || (input == "fam weight"))
	{
		return 5;
	}
	if((input == "weapon damage") || (input == "weapon") || (input == "damage") || (input == "weapon dmg") || (input == "wpn") || (input == "wpn dmg"))
	{
		return 6;
	}
	if((input == "spell damage") || (input == "spell"))
	{
		return 7;
	}
	if((input == "nc") || (input == "non-combat") || (input == "non combat") || (input == "combat"))
	{
		return 8;
	}
	if((input == "item") || (input == "item drop") || (input == "drop"))
	{
		return 9;
	}
	if((input == "hot resistance") || (input == "hot res") || (input == "resistance") || (input == "hot"))
	{
		return 10;
	}
	if((input == "coil") || (input == "wire") || (input == "crap"))
	{
		return 11;
	}
	abort("Incorrect Community Service Quest Specified: " + input);
	return -1;
}

boolean LA_cs_communityService()
{
	if(my_path() != "Community Service")
	{
		return false;
	}
	if(my_inebriety() > inebriety_limit())
	{
		abort("Too drunk, not sure if not aborting is safe yet");
	}

	if(get_property("cc_100familiar").to_boolean())
	{
		if((my_familiar() != $familiar[Puck Man]) && (my_familiar() != $familiar[Ms. Puck Man]))
		{
			abort("100% familiar is not compatible, to disable: set cc_100familiar=false");
		}
		print("In 100% familiar mode with a Puck Person... well, good luck!", "red");
	}

	static int curQuest = 0;
	if(curQuest == 0)
	{
		curQuest = expected_next_cs_quest();
	}

	cs_dnaPotions();
	use_barrels();
	cs_make_stuff();
	cc_mayoItems();

	if(fortuneCookieEvent())
	{
		return true;
	}

	equipBaseline();
	if((equipped_item($slot[Shirt]) == $item[none]) && possessEquipment($item[Tunac]))
	{
		equip($slot[Shirt], $item[Tunac]);
	}
	if((equipped_item($slot[Off-Hand]) == $item[A Light that Never Goes Out]) && possessEquipment($item[Barrel Lid]))
	{
		equip($slot[Off-Hand], $item[Barrel Lid]);
	}
	print(what_cs_quest(curQuest), "blue");

	cs_eat_spleen();

	boolean [familiar] useFam;
	if(((curQuest == 11) || (curQuest == 6) || (curQuest == 9)) && (my_spleen_use() < 12))
	{
		useFam = $familiars[Unconscious Collective, Grim Brother, Golden Monkey];
	}
	else
	{
		if(have_familiar($familiar[Rockin\' Robin]) && ($familiar[Rockin\' Robin].drops_today == 0))
		{
			useFam = $familiars[Galloping Grill, Fist Turkey, Rockin\' Robin, Puck Man, Ms. Puck Man];
		}
		else
		{
			useFam = $familiars[Galloping Grill, Fist Turkey, Puck Man, Ms. Puck Man];
		}
	}

	handleFamiliar("item");
	#familiar toFam = $familiar[Cocoabo];
	familiar toFam = get_property("cc_familiarChoice").to_familiar();
	foreach fam in useFam
	{
		if(have_familiar(fam))
		{
			toFam = fam;
		}
	}
	handleFamiliar(toFam);

	if(item_amount($item[gold nuggets]) > 0)
	{
		autosell(item_amount($item[gold nuggets]), $item[gold nuggets]);
	}

	autosellCrap();

	//Quest order on Day 1: 11, 6, 9
	//Day 2: 7, 10, 1, 2, 3, 4, 5, 8

	if((my_daycount() == 2) && cc_haveWitchess() && have_skill($skill[Curse of Weaksauce]) && have_skill($skill[Tattle]) && have_skill($skill[Conspiratorial Whispers]) && have_skill($skill[Sauceshell]) && have_skill($skill[Shell Up]) && have_skill($skill[Silent Slam]) && !possessEquipment($item[Dented Scepter]) && (get_property("_cc_witchesBattles").to_int() < 5) && have_familiar($familiar[Galloping Grill]))
	{
		while((my_mp() < 120) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
		{
			doRest();
		}
		if((my_hp() < 200) && ((my_hp()+30) < my_maxhp()))
		{
			useCocoon();
		}
		handleFamiliar($familiar[Galloping Grill]);
		return cc_advWitchess("king", "cs_combatKing");
	}

	if((my_daycount() != 1) && cs_witchess())
	{
		return true;
	}


#	if(my_daycount() == 1)
	if((curQuest == 11) || (curQuest == 6) || (curQuest == 9) || (curQuest == 7))
	{
		if(curQuest != 7)
		{
			if(my_inebriety() == 0)
			{
				doRest();
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				cli_execute("drink lucky lindy");
			}

			if(my_inebriety() == 1)
			{
				doRest();
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				if(item_amount($item[Sacramento Wine]) >= 4)
				{
					drink(4, $item[Sacramento Wine]);
				}
				else if(item_amount($item[Ice Island Long Tea]) > 0)
				{
					drink(1, $item[Ice Island Long Tea]);
				}
				solveCookie();
			}

			if(!get_property("_chateauMonsterFought").to_boolean() && chateaumantegna_available() && (get_property("chateauMonster") == $monster[dairy goat]))
			{
				buffMaintain($effect[Reptilian Fortitude], 8, 1, 1);
				buffMaintain($effect[Power Ballad of the Arrowsmith], 5, 1, 1);

				buffMaintain($effect[Astral Shell], 10, 1, 1);
				buffMaintain($effect[Ghostly Shell], 6, 1, 1);
				buffMaintain($effect[Blubbered Up], 7, 1, 1);
				buffMaintain($effect[Springy Fusilli], 10, 1, 1);
				buffMaintain($effect[The Moxious Madrigal], 2, 1, 1);
				buffMaintain($effect[Cletus\'s Canticle of Celerity], 4, 1, 1);
				buffMaintain($effect[Walberg\'s Dim Bulb], 5, 1, 1);
				cli_execute("postcheese");
				doRest();
				buffMaintain($effect[Astral Shell], 10, 1, 1);
				buffMaintain($effect[Ghostly Shell], 6, 1, 1);
				buffMaintain($effect[Blubbered Up], 7, 1, 1);
				buffMaintain($effect[Springy Fusilli], 10, 1, 1);
				buffMaintain($effect[The Moxious Madrigal], 2, 1, 1);
				buffMaintain($effect[Cletus\'s Canticle of Celerity], 4, 1, 1);
				buffMaintain($effect[Walberg\'s Dim Bulb], 5, 1, 1);

				if(canYellowRay())
				{
					if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
					{
						handleFamiliar("yellow ray");
					}
					chateaumantegna_usePainting("cs_combatYR");
				}
				else
				{
					chateaumantegna_usePainting("cs_combatNormal");
				}
				if(to_phylum(get_property("dnaSyringe")) == $phylum[beast])
				{
					cli_execute("camp dnapotion");
				}
				if((item_amount($item[Glass of Goat\'s Milk]) > 0) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make milk of magnesium");
				}
				return true;
			}

			if(chateaumantegna_available() && (get_property("chateauMonster") != $monster[dairy goat]) && (my_fullness() == 0) && !get_property("_photocopyUsed").to_boolean())
			{
				if(canYellowRay())
				{
					if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
					{
						handleFamiliar("yellow ray");
					}
					handleFaxMonster($monster[Dairy Goat], "cs_combatYR");
				}
				else
				{
					handleFaxMonster($monster[Dairy Goat], "cs_combatNormal");
				}
				if(to_phylum(get_property("dnaSyringe")) == $phylum[beast])
				{
					cli_execute("camp dnapotion");
				}
				if((item_amount($item[Glass of Goat\'s Milk]) > 0) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0) && have_skill($skill[Advanced Saucecrafting]))
				{
					cli_execute("make milk of magnesium");
				}
				return true;
			}

			cs_eat_stuff(0);

			if(cs_witchess())
			{
				return true;
			}

			if((curQuest == 11) && ((my_turncount() + 60) < get_property("cc_cookie").to_int()) && (my_adventures() > 65))
			{
				if(do_cs_quest(11))
				{
					use(1, $item[a ten-percent bonus]);
					curQuest = 0;
					return true;
				}
				else
				{
					curQuest = 0;
					abort("Could not handle our quest and can not recover");
				}
			}

			if((curQuest != 11) && (have_effect($effect[substats.enh]) == 0) && (cc_sourceTerminalEnhanceLeft() >= 1))
			{
				cc_sourceTerminalEnhance("substats");
			}

			buffMaintain($effect[Singer\'s Faithful Ocelot], 15, 1, 1);
			buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 11, 1, 1);

			while((my_mp() < 40) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			if(item_amount($item[Exorcised sandwich]) > 0)
			{
				visit_url("guild.php?place=challenge");
				visit_url("guild.php?place=paco");
				visit_url("guild.php?place=paco");
				visit_url("guild.php?place=paco");
				run_choice(1);
				woods_questStart();
				handleBarrelFullOfBarrels();
				if(!florist_available())
				{
					trickMafiaAboutFlorist();
				}
				return true;
			}

			LX_dolphinKingMap();

			if(my_ascensions() > get_property("lastGuildStoreOpen").to_int())
			{
				buffMaintain($effect[Musk of the Moose], 10, 1, 1);
				ccAdv(1, $location[The Haunted Pantry], "cs_combatNormal");
				return true;
			}

			if((item_amount($item[Tomato]) < 2) && have_skill($skill[Advanced Saucecrafting]))
			{
				buffMaintain($effect[Musk of the Moose], 10, 1, 1);
				ccAdv(1, $location[The Haunted Pantry], "cs_combatNormal");
				return true;
			}

			if(have_skill($skill[Advanced Saucecrafting]) && ((item_amount($item[Cherry]) < 1) || (item_amount($item[Grapefruit]) < 1) || (item_amount($item[Lemon]) < 1)))
			{
				if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") == to_string($monster[possessed can of tomatoes])))
				{
					uneffect($effect[On The Trail]);
				}
				set_property("choiceAdventure1060", 2);
				ccAdv(1, $location[The Skeleton Store], "cs_combatNormal");
				if(item_amount($item[skeleton key]) == 0)
				{
					if((item_amount($item[skeleton bone]) > 0) && (item_amount($item[loose teeth]) > 0))
					{
						cli_execute("make skeleton key");
					}
				}
				return true;
			}

			if((item_amount($item[Gene Tonic: Pirate]) == 0) && (item_amount($item[DNA Extraction Syringe]) > 0) && elementalPlanes_access($element[stench]))
			{
				ccAdv(1, $location[Pirates of the Garbage Barges], "cs_combatNormal");
				if(to_phylum(get_property("dnaSyringe")) == $phylum[pirate])
				{
					cli_execute("camp dnapotion");
				}
				return true;
			}

			if(((item_amount($item[Gene Tonic: Elemental]) == 0) || !get_property("_dnaHybrid").to_boolean()) && (item_amount($item[DNA Extraction Syringe]) > 0) && elementalPlanes_access($element[hot]))
			{
				buffMaintain($effect[Reptilian Fortitude], 8, 1, 1);
				buffMaintain($effect[Power Ballad of the Arrowsmith], 5, 1, 1);

				buffMaintain($effect[Astral Shell], 10, 1, 1);
				buffMaintain($effect[Ghostly Shell], 6, 1, 1);
				buffMaintain($effect[Blubbered Up], 7, 1, 1);
				buffMaintain($effect[Springy Fusilli], 10, 1, 1);
				buffMaintain($effect[The Moxious Madrigal], 2, 1, 1);
				buffMaintain($effect[Cletus\'s Canticle of Celerity], 4, 1, 1);
				buffMaintain($effect[Walberg\'s Dim Bulb], 5, 1, 1);

				useCocoon();

				ccAdv(1, $location[The Bubblin\' Caldera], "cs_combatNormal");
				if(to_phylum(get_property("dnaSyringe")) == $phylum[elemental])
				{
					cli_execute("camp dnapotion");
				}
				if(to_phylum(get_property("dnaSyringe")) == $phylum[fish])
				{
					cli_execute("camp dnainject");
				}
				return true;
			}

			if((curQuest == 9) && (item_amount($item[Experimental Serum G-9]) < 2) && elementalPlanes_access($element[spooky]))
			{
				if(item_amount($item[Personal Ventilation Unit]) > 0)
				{
					equip($slot[acc1], $item[Personal Ventilation Unit]);
				}
				int turns_max = 10;
				if(have_skill($skill[CLEESH]))
				{
					turns_max = 18;
				}
				if($location[The Secret Government Laboratory].turns_spent <= turns_max)
				{
					buffMaintain($effect[Singer\'s Faithful Ocelot], 47, 1, 1);
					buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 43, 1, 1);
					ccAdv(1, $location[The Secret Government Laboratory], "cs_combatNormal");
					return true;
				}
			}

		}
		else if((curQuest == 7) && (item_amount($item[Emergency Margarita]) > 0))
		{
			if((have_effect($effect[substats.enh]) == 0) && (cc_sourceTerminalEnhanceLeft() >= 1))
			{
				cc_sourceTerminalEnhance("substats");
			}

			if(canYellowRay() && elementalPlanes_access($element[hot]))
			{
				if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
				{
					handleFamiliar("yellow ray");
				}
				ccAdv(1, $location[LavaCo&trade; Lamp Factory], "cs_combatYR");
				return true;
			}

			if(inebriety_left() >= 1)
			{
				if(item_amount($item[Sacramento Wine]) > 0)
				{
					buffMaintain($effect[Ode to Booze], 50, 1, 1);
					drink(1, $item[Sacramento Wine]);
				}
				else if(item_amount($item[Iced Plum Wine]) > 0)
				{
					buffMaintain($effect[Ode to Booze], 50, 1, 1);
					drink(1, $item[Iced Plum Wine]);
				}
				else
				{
					buffMaintain($effect[Ode to Booze], 50, 1, 1);
					cli_execute("drink cup of tea");
				}
			}

			if((item_amount($item[Black Pixel]) < 2) && (have_familiar($familiar[Puck Man]) || have_familiar($familiar[Ms. Puck Man])))
			{
				equip($slot[acc1], $item[Continuum Transfunctioner]);

				if(get_property("cc_tryPowerLevel").to_boolean())
				{
					buffMaintain($effect[Ur-Kel\'s Aria of Annoyance], 62, 1, 1);
					buffMaintain($effect[Pride of the Puffin], 62, 1, 1);
					buffMaintain($effect[Drescher\'s Annoying Noise], 72, 1, 1);
					buffMaintain($effect[Wry Smile], 42, 1, 1);
				}

				ccAdv(1, $location[8-bit Realm], "cs_combatNormal");
				return true;
			}

			if(have_skill($skill[Advanced Saucecrafting]))
			{
				if((item_amount($item[Tomato Juice of Powerful Power]) < 4) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) >= 2) && have_skill($skill[Advanced Saucecrafting]))
				{
					cli_execute("make 6 tomato juice of powerful power");
				}
			}

			if((my_spleen_use() == 12) && (item_amount($item[Abstraction: Category]) > 0))
			{
				chew(1, $item[Abstraction: Category]);
			}

			int pixelsNeed = 30 - (15 * item_amount($item[Miniature Power Pill]));
			# Account for possible pixels from Snojo?
			# Make sure for tryPowerLevel not to go too high in ML (75).

			if(!get_property("_aprilShower").to_boolean())
			{
				cli_execute("shower myst");
			}

			buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
			buffMaintain($effect[Ur-Kel\'s Aria of Annoyance], 62, 1, 1);
			buffMaintain($effect[Pride of the Puffin], 62, 1, 1);
			buffMaintain($effect[Drescher\'s Annoying Noise], 72, 1, 1);
			buffMaintain($effect[Wry Smile], 42, 1, 1);
			buffMaintain($effect[Empathy], 47, 1, 1);
			buffMaintain($effect[Leash of Linguini], 44, 1, 1);
			buffMaintain($effect[Ruthlessly Efficient], 42, 1, 1);
			buffMaintain($effect[The Magical Mojomuscular Melody], 12, 1, 1);
			if(item_amount($item[Tomato Juice of Powerful Power]) > 4)
			{
				buffMaintain($effect[Tomato Power], 0, 1, 1);
			}
			if(((my_hp() + 50) < my_maxhp()) && (my_mp() > 100))
			{
				useCocoon();
			}

			if(((item_amount($item[Power Pill]) < 2) || (item_amount($item[Yellow Pixel]) < pixelsNeed)) && (have_familiar($familiar[Puck Man]) || have_familiar($familiar[Ms. Puck Man])))
			{
				if(get_property("cc_tryPowerLevel").to_boolean())
				{
					if(elementalPlanes_access($element[stench]) && (my_hp() > 100))
					{
						if(current_mcd() < 10)
						{
							change_mcd(10);
						}
						if(item_amount($item[Astral Statuette]) > 0)
						{
							equip($item[Astral Statuette]);
						}

						if(have_skill($skill[Soul Food]))
						{
							use_skill(my_soulsauce() / 5, $skill[Soul Food]);
						}

						buyUpTo(1, $item[Hair Spray]);
						buyUpTo(1, $item[Ben-Gal&trade; Balm]);
						buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
						buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

						buffMaintain($effect[Astral Shell], 42, 1, 1);
						buffMaintain($effect[Elemental Saucesphere], 42, 1, 1);
						buffMaintain($effect[Brawnee\'s Anthem of Absorption], 45, 1, 1);
						buffMaintain($effect[Jalape&ntilde;o Saucesphere], 37, 1, 1);
						buffMaintain($effect[Ghostly Shell], 38, 1, 1);
						buffMaintain($effect[Reptilian Fortitude], 42, 1, 1);
						buffMaintain($effect[Power Ballad of the Arrowsmith], 37, 1, 1);
						buffMaintain($effect[The Moxious Madrigal], 34, 1, 1);
						buffMaintain($effect[Patience of the Tortoise], 33, 1, 1);
						buffMaintain($effect[Seal Clubbing Frenzy], 33, 1, 1);
						buffMaintain($effect[Mariachi Mood], 33, 1, 1);
						buffMaintain($effect[Disco State of Mind], 33, 1, 1);
						buffMaintain($effect[Saucemastery], 33, 1, 1);
						buffMaintain($effect[Blubbered Up], 39, 1, 1);
						buffMaintain($effect[Spiky Shell], 40, 1, 1);
						buffMaintain($effect[Song of Starch], 132, 1, 1);
						buffMaintain($effect[Rage of the Reindeer], 42, 1, 1);
						buffMaintain($effect[Scarysauce], 42, 1, 1);
						buffMaintain($effect[Disco Fever], 42, 1, 1);

#						if((have_effect($effect[The Dinsey Look]) == 0) && (item_amount($item[FunFunds&trade;]) > 0))
#						{
#							cli_execute("make dinsey face paint");
#						}
#						buffMaintain($effect[The Dinsey Look], 0, 1, 1);
#						buffMaintain($effect[Flexibili Tea], 0, 1, 1);
						buffMaintain($effect[Neuroplastici Tea], 0, 1, 1);
#						buffMaintain($effect[Physicali Tea], 0, 1, 1);


						if((get_property("_hipsterAdv").to_int() < 1) && is_unrestricted($familiar[Artistic Goth Kid]))
						{
							handleFamiliar($familiar[Artistic Goth Kid]);
						}

						if(elementalPlanes_access($element[stench]))
						{
							ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice], "cs_combatNormal");
							return true;
						}
					}
				}

				if((elementalPlanes_access($element[hot])) && (item_amount($item[New Age Healing Crystal]) < 2))
				{
					ccAdv(1, $location[The Velvet / Gold Mine], "cs_combatNormal");
				}
				else if(elementalPlanes_access($element[cold]))
				{
					backupSetting("choiceAdventure1115", 4);
					ccAdv(1, $location[VYKEA], "cs_combatNormal");
				}
				else if(elementalPlanes_access($element[hot]))
				{
					ccAdv(1, $location[The Velvet / Gold Mine], "cs_combatNormal");
				}
				else
				{
					ccAdv(1, $location[8-bit Realm], "cs_combatNormal");
				}
				return true;
			}

			if(get_property("cc_tryPowerLevel").to_boolean())
			{
				change_mcd(0);
			}

			int missing = 0;
			if(!have_skill($skill[Advanced Saucecrafting]))
			{
				missing = missing + 1;
			}
			if(!elementalPlanes_access($element[spooky]))
			{
				missing = missing + 1;
			}
			if(!elementalPlanes_access($element[hot]))
			{
				missing = missing + 1;
			}
			missing = min(2, missing);

			if(snojoFightAvailable() && (my_adventures() > 0))
			{
				familiar oldFam = my_familiar();
				if(have_familiar($familiar[Rockin\' Robin]) && (item_amount($item[Robin\'s Egg]) == 0))
				{
					handleFamiliar($familiar[Rockin\' Robin]);
				}
				ccAdv(1, $location[The X-32-F Combat Training Snowman]);
				handleFamiliar(oldFam);
				return true;
			}

			if((have_effect($effect[Half-Blooded]) > 0) || (have_effect($effect[Half-Drained]) > 0) || (have_effect($effect[Bruised]) > 0) || (have_effect($effect[Relaxed Muscles]) > 0) || (have_effect($effect[Hypnotized]) > 0) || (have_effect($effect[Bad Haircut]) > 0))
			{
				doHottub();
			}

			if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_adventures() > 0) && !get_property("cc_100familiar").to_boolean())
			{
				backupSetting("choiceAdventure1119", 1);
				handleFamiliar($familiar[Machine Elf]);
				ccAdv(1, $location[The Deep Machine Tunnels]);
				restoreSetting("choiceAdventure1119");
				set_property("choiceAdventure1119", "");
				return true;
			}

			if((missing > (item_amount($item[Miniature Power Pill]) + item_amount($item[Power Pill]))) && (have_familiar($familiar[Puck Man]) || have_familiar($familiar[Ms. Puck Man])))
			{
				if(elementalPlanes_access($element[hot]))
				{
					ccAdv(1, $location[The Velvet / Gold Mine], "cs_combatNormal");
				}
				else if(elementalPlanes_access($element[stench]))
				{
					ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice], "cs_combatNormal");
				}
				else if(elementalPlanes_access($element[spooky]))
				{
					ccAdv(1, $location[The Deep Dark Jungle], "cs_combatNormal");
				}
				else if(elementalPlanes_access($element[sleaze]))
				{
					ccAdv(1, $location[Sloppy Seconds Diner], "cs_combatNormal");
				}
				else
				{
					ccAdv(1, $location[The Haunted Kitchen], "cs_combatNormal");
				}
				if(item_amount($item[Yellow Pixel]) >= 15)
				{
					cli_execute("make miniature power pill");
				}
				return true;
			}

			if((canYellowRay() || (numeric_modifier("item drop") >= 150.0)) && !get_property("_photocopyUsed").to_boolean())
			{
				if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
				{
					handleFamiliar("yellow ray");
				}
				string combatString = "cs_combatYR";
				if(numeric_modifier("item drop") >= 150.0)
				{
					combatString = "cs_combatNormal";
				}
				if(handleFaxMonster($monster[Sk8 gnome], combatString))
				{
					return true;
				}
			}

			if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() == 5) && ($location[The Deep Machine Tunnels].turns_spent == 5) && (my_adventures() > 0) && !get_property("cc_100familiar").to_boolean())
			{
				backupSetting("choiceAdventure1119", 1);
				handleFamiliar($familiar[Machine Elf]);
				ccAdv(1, $location[The Deep Machine Tunnels]);
				restoreSetting("choiceAdventure1119");
				set_property("choiceAdventure1119", "");
				return true;
			}

			if(have_skill($skill[Advanced Saucecrafting]))
			{
				if((item_amount($item[Oil of Expertise]) < 2) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make 3 oil of expertise");
				}
				if((item_amount($item[Tomato Juice of Powerful Power]) < 4) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 1))
				{
					cli_execute("make 6 tomato juice of powerful power");
				}

				if((item_amount($item[grapefruit]) > 0) && (item_amount($item[Ointment of the Occult]) == 0) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make ointment of the occult");
				}
				else if((item_amount($item[squashed frog]) > 0) && (item_amount($item[Frogade]) == 0) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make frogade");
				}
				else if((item_amount($item[eye of newt]) > 0) && (item_amount($item[Eyedrops of Newt]) == 0) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make eyedrops of newt");
				}
				else if((item_amount($item[salamander spleen]) > 0) && (item_amount($item[Salamander Slurry]) == 0) && (item_amount($item[Scrumptious Reagent]) > 0))
				{
					cli_execute("make salamander slurry");
				}
			}

			buffMaintain($effect[Simmering], 0, 1, 1);

			if((spleen_left() >= 3) && (item_amount($item[Handful of Smithereens]) > 0))
			{
				chew(1, $item[Handful of Smithereens]);
			}
			if((spleen_left() >= 2) && (item_amount($item[Handful of Smithereens]) > 1))
			{
				chew(1, $item[Handful of Smithereens]);
			}
			while((spleen_left() >= 2) && (item_amount($item[cuppa Activi tea]) > 0))
			{
				chew(1, $item[cuppa Activi tea]);
			}
			while((spleen_left() >= 2) && (item_amount($item[Nasty Snuff]) > 0))
			{
				chew(1, $item[Nasty Snuff]);
			}
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 10);

			if(item_amount($item[Flavored Foot Massage Oil]) > 0)
			{
				string temp = visit_url("curse.php?action=use&pwd=&whichitem=3274&targetplayer=" + get_player_id(my_name()));
			}
			if((item_amount($item[CSA fire-starting kit]) > 0) && !get_property("_fireStartingKitUsed").to_boolean() && (get_property("choiceAdventure595").to_int() == 1))
			{
				use(1, $item[CSA Fire-Starting Kit]);
			}

			if(!get_property("cc_saveMargarita").to_boolean())
			{
				overdrink(1, $item[Emergency Margarita]);
			}
			else
			{
				put_closet(item_amount($item[Emergency Margarita]), $item[Emergency Margarita]);
				abort("Saving Emergency Margarita, forcing abort, done with day. Overdrink and run again.");
			}
			return true;
		}
	}

	int checkQuest = expected_next_cs_quest();
	if(checkQuest != curQuest)
	{
		print("Quest data error detected, trying to resolve. Please don't do quests manually, it hurts me!", "red");
		curQuest = checkQuest;
		return true;
	}

	familiar prior = my_familiar();
	switch(curQuest)
	{
	case 0:
		print("Service Complete, finishing finish...", "blue");
		try
		{
			if(do_cs_quest(30))
			{
				cli_execute("call kingcheese");
				return true;
			}
			else
			{
				abort("Could not complete run.");
			}
		}
		finally
		{
			print("Waiting a few seconds, please hold.", "red");
			wait(5);
			if(get_property("kingLiberated").to_boolean())
			{
				cli_execute("call kingcheese");
				return true;
			}
			else
			{
				abort("kingLiberation not set correctly but run is probably complete. Beep boop. Try running again to handle resetting options");
			}
		}
		break;
	case 1:		#HP Quest
			if(canYellowRay() && !get_property("_photocopyUsed").to_boolean())
			{
				if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
				{
					handleFamiliar("yellow ray");
				}
				if(handleFaxMonster($monster[Sk8 gnome], "cs_combatYR"))
				{
					return true;
				}
			}
			if((item_amount($item[Gr8ps]) > 0) && (item_amount($item[Potion of Temporary Gr8tness]) == 0) && (have_effect($effect[Gr8tness]) == 0) && (npc_price($item[Delectable Catalyst]) < my_meat()) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0) && have_skill($skill[Advanced Saucecrafting]) && have_skill($skill[The Way of Sauce]))
			{
				cli_execute("make " + $item[Potion of Temporary Gr8tness]);
			}

#			if(!possessEquipment($item[Barrel Lid]) && get_property("barrelShrineUnlocked").to_boolean() && !get_property("_barrelPrayer").to_boolean())
#			{
#				boolean buff = cli_execute("barrelprayer Protection");
#			}

			if(possessEquipment($item[Barrel Lid]))
			{
				equip($item[Barrel Lid]);
			}

			if(item_amount($item[Ben-Gal&trade; Balm]) == 0)
			{
				buyUpTo(1, $item[Ben-Gal&trade; Balm], 25);
			}

			while(((total_free_rests() - get_property("timesRested").to_int()) > 4) && chateaumantegna_available())
			{
				cli_execute("postcheese");
				doRest();
			}

			if((item_amount($item[lemon]) > 0) && (item_amount($item[philter of phorce]) == 0) && (have_effect($effect[Phorcefullness]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0) && have_skill($skill[Advanced Saucecrafting]))
			{
				cli_execute("make philter of phorce");
			}

			while((my_mp() < 125) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Song of Starch], 100, 1, 1);
			buffMaintain($effect[Reptilian Fortitude], 10, 1, 1);
			buffMaintain($effect[Rage of the Reindeer], 10, 1, 1);
			buffMaintain($effect[Power Ballad of the Arrowsmith], 10, 1, 1);
			buffMaintain($effect[Seal Clubbing Frenzy], 1, 1, 1);
			buffMaintain($effect[Patience of the Tortoise], 1, 1, 1);
			buffMaintain($effect[Mariachi Mood], 1, 1, 1);
			buffMaintain($effect[Saucemastery], 1, 1, 1);
			buffMaintain($effect[Disco State of Mind], 1, 1, 1);
			buffMaintain($effect[Pasta Oneness], 1, 1, 1);
			buffMaintain($effect[Disdain of the War Snapper], 15, 1, 1);
			buffMaintain($effect[A Few Extra Pounds], 10, 1, 1);

			buffMaintain($effect[Lycanthropy\, Eh?], 0, 1, 1);
			buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
			buffMaintain($effect[Expert Oiliness], 0, 1, 1);
			buffMaintain($effect[Phorcefullness], 0, 1, 1);
			buffMaintain($effect[Tomato Power], 0, 1, 1);
			buffMaintain($effect[Puddingskin], 0, 1, 1);
			buffMaintain($effect[Superheroic], 0, 1, 1);
			buffMaintain($effect[Extra Backbone], 0, 1, 1);
			buffMaintain($effect[Pill Power], 0, 1, 1);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			buffMaintain($effect[Nigh-Invincible], 0, 1, 1);
			buffMaintain($effect[Pill Power], 0, 1, 1);
			buffMaintain($effect[Frog in Your Throat], 0, 1, 1);
			buffMaintain($effect[Feroci Tea], 0, 1, 1);
			buffMaintain($effect[Gr8tness], 0, 1, 1);
			buffMaintain($effect[Vitali Tea], 0, 1, 1);
			buffMaintain($effect[Twen Tea], 0, 1, 1);
			buffMaintain($effect[Purity of Spirit], 0, 1, 1);
			buffMaintain($effect[Peppermint Bite], 0, 1 , 1);
			buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
			buffMaintain($effect[Phorcefullness], 0, 1, 1);

			if(!get_property("_grimBuff").to_boolean())
			{
				cli_execute("grim hpmp");
			}
			if(is_unrestricted($item[Colorful Plastic Ball]))
			{
				# Can not be used in Ronin/Hardcore, derp....
				cli_execute("ballpit");
			}
			if((item_amount($item[Ancient Medicinal Herbs]) > 0) && (have_effect($effect[Ancient Fortitude]) == 0))
			{
				chew(1, $item[Ancient Medicinal Herbs]);
			}

			if(!get_property("_madTeaParty").to_boolean())
			{
				if(item_amount($item[Coconut Shell]) == 0)
				{
					if((item_amount($item[Pentacorn Hat]) == 0) && (my_meat() > 300))
					{
						buyUpTo(1, $item[Pentacorn Hat]);
					}
				}
				if(!get_property("_lookingGlass").to_boolean())
				{
					cli_execute("clan_viplounge.php?action=lookingglass");
				}
				cli_execute("hatter 12");
			}

			if(get_property("telescopeUpgrades").to_int() > 0)
			{
				if(get_property("telescopeLookedHigh") == "false")
				{
					cli_execute("telescope high");
				}
			}

			if((15 - get_property("_deckCardsDrawn").to_int()) >= 5)
			{
				deck_cheat("muscle buff");
			}

			if((my_spleen_use() < 15) && (item_amount($item[Abstraction: Action]) > 0) && (have_effect($effect[Action]) == 0))
			{
				chew(1, $item[Abstraction: Action]);
			}

			if(do_cs_quest(1))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 2:		#Muscle Quest
			if(!possessEquipment($item[Barrel Lid]))
			{
				visit_url("da.php?barrelshrine=1");
				visit_url("choice.php?whichchoice=1100&pwd&option=1", true);
			}

			if(possessEquipment($item[Barrel Lid]))
			{
				equip($item[Barrel Lid]);
			}

			buyUpTo(1, $item[Ben-Gal&trade; Balm]);

			if(!get_property("cc_tryPowerLevel").to_boolean() && !get_property("cc_saveMargarita").to_boolean())
			{
				if(item_amount($item[Blood-drive sticker]) > 0)
				{
					chew(1, $item[Blood-drive sticker]);
				}
			}

			while((my_mp() < 50) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if((my_inebriety() == 0) && (item_amount($item[Clan VIP Lounge Key]) > 0))
			{
				shrugAT();
				use_skill(1, $skill[The Ode to Booze]);
				cli_execute("drink 1 bee's knees");
			}


			while((my_mp() < 125) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Song of Bravado], 100, 1, 1);
			buffMaintain($effect[Rage of the Reindeer], 10, 1, 1);
			buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
			buffMaintain($effect[Power Ballad of the Arrowsmith], 10, 1, 1);
			buffMaintain($effect[Disdain of the War Snapper], 15, 1, 1);

			buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
			buffMaintain($effect[Expert Oiliness], 0, 1, 1);
			buffMaintain($effect[Orange Crusher], 0, 1, 50);
			buffMaintain($effect[Orange Crusher], 0, 1, 50);
			buffMaintain($effect[Orange Crusher], 0, 1, 50);
			buffMaintain($effect[Orange Crusher], 0, 1, 50);
			buffMaintain($effect[Orange Crusher], 0, 1, 50);
			buffMaintain($effect[Phorcefullness], 0, 1, 1);
			buffMaintain($effect[Tomato Power], 0, 1, 1);
			buffMaintain($effect[Savage Beast Inside], 0, 1, 1);
			buffMaintain($effect[Extra Backbone], 0, 1, 1);
			buffMaintain($effect[Gr8tness], 0, 1, 1);
			buffMaintain($effect[Pill Power], 0, 1, 1);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			buffMaintain($effect[Seal Clubbing Frenzy], 1, 1, 1);
			buffMaintain($effect[Patience of the Tortoise], 1, 1, 1);
			buffMaintain($effect[Human-Humanoid Hybrid], 0, 1, 1);
			buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
			buffMaintain($effect[Frog in Your Throat], 0, 1, 1);
			buffMaintain($effect[Twen Tea], 0, 1, 1);
			buffMaintain($effect[Feroci Tea], 0, 1, 1);
			buffMaintain($effect[Peppermint Bite], 0, 1 , 1);

			handleFamiliar($familiar[Machine Elf]);
			cs_giant_growth();

			if((my_spleen_use() < 15) && (item_amount($item[Abstraction: Action]) > 0) && (have_effect($effect[Action]) == 0))
			{
				chew(1, $item[Abstraction: Action]);
			}

			if(do_cs_quest(2))
			{
				cli_execute("refresh inv");
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 3:		#Myst Quest
			buyUpTo(1, $item[Glittery Mascara]);

			if((item_amount($item[Saucepanic]) > 0) && have_skill($skill[Double-Fisted Skull Smashing]))
			{
				equip($slot[off-hand], $item[Saucepanic]);
			}

			while((my_mp() < 133) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Song of Bravado], 100, 1, 1);
			buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
			buffMaintain($effect[The Magical Mojomuscular Melody], 3, 1, 1);
			buffMaintain($effect[Disdain of She-Who-Was], 15, 1, 1);

			buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
			buffMaintain($effect[Mystically Oiled], 0, 1, 1);
			buffMaintain($effect[Tomato Power], 0, 1, 1);
			buffMaintain($effect[Pill Power], 0, 1, 1);
			buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
			buffMaintain($effect[Liquidy Smoky], 0, 1, 1);
			buffMaintain($effect[Gr8tness], 0, 1, 1);
			buffMaintain($effect[OMG WTF], 0, 1, 1);
			buffMaintain($effect[Purple Reign], 0, 1, 50);
			buffMaintain($effect[Purple Reign], 0, 1, 50);
			buffMaintain($effect[Purple Reign], 0, 1, 50);
			buffMaintain($effect[Purple Reign], 0, 1, 50);
			buffMaintain($effect[Purple Reign], 0, 1, 50);
			buffMaintain($effect[Saucemastery], 1, 1, 1);
			buffMaintain($effect[Pasta Oneness], 1, 1, 1);
			buffMaintain($effect[Human-Humanoid Hybrid], 0, 1, 1);
			buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
			buffMaintain($effect[Salamander In Your Stomach], 0, 1, 1);
			buffMaintain($effect[Twen Tea], 0, 1, 1);
			buffMaintain($effect[Wit Tea], 0, 1, 1);
			buffMaintain($effect[Sweet\, Nuts], 0, 1 , 1);


			buffMaintain($effect[Nearly All-Natural], 0, 1, 1);

			handleFamiliar($familiar[Machine Elf]);
			cs_giant_growth();

			if((my_spleen_use() < 15) && (item_amount($item[Abstraction: Thought]) > 0) && (have_effect($effect[Thought]) == 0))
			{
				chew(1, $item[Abstraction: Thought]);
			}

			if(do_cs_quest(3))
			{
				cli_execute("refresh inv");
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}

		break;


	case 4:		#Moxie Quest
			buyUpTo(1, $item[Hair Spray]);

			while((my_mp() < 50) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if((my_inebriety() == 2) && (item_amount($item[Clan VIP Lounge Key]) > 0))
			{
				shrugAT();
				use_skill(1, $skill[The Ode to Booze]);
				cli_execute("drink 1 bee's knees");
			}


			while((my_mp() < 142) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Song of Bravado], 100, 1, 1);
			buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
			buffMaintain($effect[The Moxious Madrigal], 2, 1, 1);
			buffMaintain($effect[Disco Smirk], 10, 1, 1);
			buffMaintain($effect[Disco Fever], 10, 1, 1);
			buffMaintain($effect[Blubbered Up], 10, 1, 1);

			buffMaintain($effect[Expert Oiliness], 0, 1, 1);
			buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
			buffMaintain($effect[Tomato Power], 0, 1, 1);
			buffMaintain($effect[Pulchritudinous Pressure], 0, 1, 1);
			buffMaintain($effect[Lycanthropy\, Eh?], 0, 1, 1);
			buffMaintain($effect[Superhuman Sarcasm], 0, 1, 1);
			buffMaintain($effect[Notably Lovely], 0, 1, 1);
			buffMaintain($effect[Pill Power], 0, 1, 1);
			buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
			buffMaintain($effect[Gr8tness], 0, 1, 1);
			buffMaintain($effect[Liquidy Smoky], 0, 1, 1);
			buffMaintain($effect[Cinnamon Challenger], 0, 1, 50);
			buffMaintain($effect[Cinnamon Challenger], 0, 1, 50);
			buffMaintain($effect[Cinnamon Challenger], 0, 1, 50);
			buffMaintain($effect[Cinnamon Challenger], 0, 1, 50);
			buffMaintain($effect[Cinnamon Challenger], 0, 1, 50);
			buffMaintain($effect[Disco State of Mind], 1, 1, 1);
			buffMaintain($effect[Mariachi Mood], 1, 1, 1);
			buffMaintain($effect[Human-Humanoid Hybrid], 0, 1, 1);
			buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
			buffMaintain($effect[Newt Gets In Your Eyes], 0, 1, 1);
			buffMaintain($effect[Twen Tea], 0, 1, 1);
			buffMaintain($effect[Dexteri Tea], 0, 1, 1);
			buffMaintain($effect[Busy Bein\' Delicious], 0, 1 , 1);

			buffMaintain($effect[Amazing], 0, 1, 1);

			handleFamiliar($familiar[Machine Elf]);
			cs_giant_growth();

			if((my_spleen_use() < 15) && (item_amount($item[Abstraction: Sensation]) > 0) && (have_effect($effect[Sensation]) == 0))
			{
				chew(1, $item[Abstraction: Sensation]);
			}

			if(do_cs_quest(4))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;
	case 5:		#Familiar Weight
			while((my_mp() < 50) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			int lastQuestCost = 36;
			if(have_skill($skill[Smooth Movement]))
			{
				lastQuestCost = lastQuestCost - 3;
			}
			if(have_skill($skill[The Sonata of Sneakiness]))
			{
				lastQuestCost = lastQuestCost - 3;
			}
			if((item_amount($item[Snow Berries]) >= 1) || (item_amount($item[Snow Cleats]) == 0))
			{
				lastQuestCost = lastQuestCost - 3;
			}
			if(item_amount($item[cuppa Obscuri Tea]) > 0)
			{
				lastQuestCost = lastQuestCost - 3;
			}
			if(is_unrestricted($item[Olympic-sized Clan Crate]) && !get_property("_olympicSwimmingPool").to_boolean())
			{
				lastQuestCost = lastQuestCost - 3;
			}

			buffMaintain($effect[Blue Swayed], 0, 1, 50);
			buffMaintain($effect[Blue Swayed], 0, 1, 50);
			buffMaintain($effect[Blue Swayed], 0, 1, 50);
			buffMaintain($effect[Blue Swayed], 0, 1, 50);
			buffMaintain($effect[Blue Swayed], 0, 1, 50);
			buffMaintain($effect[Loyal Tea], 0, 1, 1);
			if((my_spleen_use() < 15) && (item_amount($item[Abstraction: Joy]) > 0) && (have_effect($effect[Joy]) == 0))
			{
				chew(1, $item[Abstraction: Joy]);
			}

			if((get_property("puzzleChampBonus").to_int() == 20) && !get_property("_witchessBuff").to_boolean())
			{
				visit_url("campground.php?action=witchess");
				visit_url("choice.php?whichchoice=1181&pwd=&option=3");
				visit_url("choice.php?whichchoice=1183&pwd=&option=2");
			}
			else if(get_property("cc_pauseForWitchess").to_boolean())
			{
				user_confirm("Get the Witchess Familiar Buff and then click this away. Beep boop.");
			}

			if((have_effect($effect[Puzzle Champ]) == 0) && get_property("cc_pauseForWitchess").to_boolean())
			{
				user_confirm("Get the Witchess Familiar Buff and then click this away. Beep boop.");
			}

			int currentCost = get_cs_questCost(curQuest);
			if(have_skill($skill[Empathy of the Newt]))
			{
				currentCost = currentCost - 1;
			}
			if(have_skill($skill[Leash of Linguini]))
			{
				currentCost = currentCost - 1;
			}

			int needCost = lastQuestCost + currentCost;

			if(my_inebriety() == 4)
			{
				if(my_adventures() < needCost)
				{
					//Is it possible for us to drink some other stuff?
					int extraAdv = 0;

					int drunkLeft = 10;
					if((item_amount($item[Sacramento Wine]) >= 4) && (drunkLeft >= 4))
					{
						extraAdv = extraAdv + 24;
						drunkLeft -= 4;
					}
					if((item_amount($item[Sacramento Wine]) >= 5) && (drunkLeft >= 1))
					{
						extraAdv = extraAdv + 6;
						drunkLeft -= 1;
					}
					if((item_amount($item[Iced Plum Wine]) >= 1) && (drunkLeft >= 1))
					{
						extraAdv = extraAdv + 7;
						drunkLeft -= 1;
					}

					if((my_meat() > 5000) && (drunkLeft >= 3) && (item_amount($item[Clan VIP Lounge Key]) > 0))
					{
						extraAdv = extraAdv + 13;
						needCost = needCost - 2;
						drunkLeft -= 3;
					}
					if((item_amount($item[Asbestos Thermos]) > 0) && (drunkLeft >= 4))
					{
						extraAdv = extraAdv + 16;
						drunkLeft -= 4;
					}

					if((item_amount($item[Cold One]) > 0) && (drunkLeft >= 1))
					{
						extraAdv = extraAdv + 5;
						drunkLeft -= 1;
					}

					if(item_amount($item[Blood-Drive Sticker]) > 0)
					{
						needCost = needCost + 5;
					}

					if((my_adventures() + extraAdv) > needCost)
					{
						shrugAT();
						use_skill(1, $skill[The Ode to Booze]);
						if((item_amount($item[Sacramento Wine]) >= 4) && (inebriety_left() >= 4))
						{
							drink(4, $item[Sacramento Wine]);
						}
						if((item_amount($item[Sacramento Wine]) >= 1) && (inebriety_left() >= 1))
						{
							drink(1, $item[Sacramento Wine]);
						}
						if((item_amount($item[Iced Plum Wine]) >= 1) && (inebriety_left() >= 1))
						{
							drink(1, $item[Iced Plum Wine]);
						}

						if((my_meat() > 5000) && (item_amount($item[Clan VIP Lounge Key]) > 0) && (inebriety_left() >= 3))
						{
							cli_execute("drink 1 hot socks");
						}
						if((item_amount($item[Asbestos Thermos]) > 0) && (inebriety_left() >= 4))
						{
							drink(1, $item[Asbestos Thermos]);
						}
						if((item_amount($item[Cold One]) > 0) && (inebriety_left() >= 1))
						{
							drink(1, $item[Cold One]);
						}

					}
					else
					{
						shrugAT();
						use_skill(1, $skill[The Ode to Booze]);
						drink(1, $item[Vintage Smart Drink]);
					}
				}
			}

			while((my_mp() < 27) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Empathy], 15, 1, 1);
			buffMaintain($effect[Leash of Linguini], 12, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]) && (have_effect($effect[Billiards Belligerence]) == 0))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
			}

			familiar toFam = $familiar[Cocoabo];
			foreach fam in $familiars[]
			{
				if((familiar_weight(fam) > familiar_weight(toFam)) && have_familiar(fam))
				{
					toFam = fam;
				}
			}

			if(possessEquipment($item[Pet Rock &quot;Snooty&quot; Disguise]))
			{
				foreach fam in $familiars[Pet Rock, Toothsome Rock, Bulky Buddy Box, Holiday Log]
				{
					if(((familiar_weight(fam) + 11) > familiar_weight(toFam)) && have_familiar(fam))
					{
						toFam = fam;
					}
				}
			}

			#handleFamiliar(toFam);
			use_familiar(toFam);
			if(can_equip($item[Pet Rock &quot;Snooty&quot; Disguise]) && possessEquipment($item[Pet Rock &quot;Snooty&quot; Disguise]))
			{
				equip($item[Pet Rock &quot;Snooty&quot; Disguise]);
			}

			#This is probably not all that effective here....
			if(item_amount($item[Ghost Dog Chow]) > 0)
			{
				use(max(5,item_amount($item[Ghost Dog Chow])), $item[Ghost Dog Chow]);
			}

			if(do_cs_quest(5))
			{
				curQuest = 0;
				use_familiar(prior);
			}
			else
			{
				curQuest = 0;
				use_familiar(prior);
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 6:		#Melee Damage
			while((my_mp() < 50) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if(((my_inebriety() == 5) || (my_inebriety() == 11)) && (have_effect($effect[In A Lather]) == 0))
			{
				shrugAT();
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				cli_execute("drink sockdollager");
			}


			while((my_mp() < 207) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			buffMaintain($effect[Song of the North], 100, 1, 1);
			buffMaintain($effect[Bow-Legged Swagger], 100, 1, 1);
			buffMaintain($effect[Jackasses\' Symphony of Destruction], 9, 1, 1);
			buffMaintain($effect[Rage of the Reindeer], 10, 1, 1);
			buffMaintain($effect[Scowl of the Auk], 10, 1, 1);
			buffMaintain($effect[Tenacity of the Snapper], 8, 1, 1);
			buffMaintain($effect[Disdain of the War Snapper], 15, 1, 1);

			if((item_amount($item[Wasabi Marble Soda]) == 0) && (have_effect($effect[Wasabi With You]) == 0) && (item_amount($item[Ye Wizard\'s Shack snack voucher]) > 0))
			{
				cli_execute("make " + $item[Wasabi Marble Soda]);
				buffMaintain($effect[Wasabi With You], 0, 1, 1);
			}

			buffMaintain($effect[Human-Beast Hybrid], 0, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]) && (have_effect($effect[Billiards Belligerence]) == 0))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
			}

			if(!get_property("_grimBuff").to_boolean())
			{
				cli_execute("grim damage");
			}

			while((my_level() < 8) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
				buffMaintain($effect[Ode to Booze], 50, 1, 6);
				cli_execute("postcheese");
			}
			if((my_level() >= 8) && (item_amount($item[Astral Pilsner]) > 0) && (inebriety_left() >= item_amount($item[Astral Pilsner])))
			{
				shrugAT();
				buffMaintain($effect[Ode to Booze], 50, 1, 6);
				drink(item_amount($item[Astral Pilsner]), $item[Astral Pilsner]);
			}

			if((my_level() < 8) && !get_property("_fancyHotDogEaten").to_boolean())
			{
				if(get_property("cc_noSleepingDog").to_boolean() || have_skill($skill[Dog Tired]))
				{
					eatFancyDog("savage macho dog");
				}
				else
				{
					eatFancyDog("sleeping dog");
				}
				return true;
			}

			if((my_adventures() < get_cs_questCost(curQuest)) && ((my_inebriety() == 7) || (my_inebriety() == 13)))
			{
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				if(item_amount($item[Iced Plum Wine]) > 0)
				{
					drink(1, $item[Iced Plum Wine]);
				}
				else if(item_amount($item[Sacramento Wine]) > 0)
				{
					drink(1, $item[Sacramento Wine]);
				}
				else
				{
					cli_execute("drink cup of tea");
				}
			}

			if(do_cs_quest(6))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 7:		#Spell Damage
		if(my_daycount() > 1)
		{
			if(snojoFightAvailable() && (my_adventures() > 0))
			{
				ccAdv(1, $location[The X-32-F Combat Training Snowman]);
				return true;
			}
			if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 2))
			{
				handleFamiliar($familiar[Machine Elf]);
				ccAdv(1, $location[The Deep Machine Tunnels]);
				return true;
			}


			if((have_effect($effect[Half-Blooded]) > 0) || (have_effect($effect[Half-Drained]) > 0) || (have_effect($effect[Bruised]) > 0) || (have_effect($effect[Relaxed Muscles]) > 0) || (have_effect($effect[Hypnotized]) > 0) || (have_effect($effect[Bad Haircut]) > 0))
			{
				doHottub();
			}

			while((my_mp() < 250) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if(possessEquipment($item[Staff of the Headmaster\'s Victuals]) && can_equip($item[Staff of the Headmaster\'s Victuals]) && have_skill($skill[Spirit of Rigatoni]))
			{
				equip($slot[weapon], $item[Staff of the Headmaster\'s Victuals]);
			}
			else if(item_amount($item[Obsidian Nutcracker]) > 0)
			{
				equip($slot[weapon], $item[Obsidian Nutcracker]);
			}
			if(possessEquipment($item[Astral Statuette]))
			{
				equip($item[Astral Statuette]);
			}
			buffMaintain($effect[Song of Sauce], 100, 1, 1);
			buffMaintain($effect[Bendin\' Hell], 100, 1, 1);
			buffMaintain($effect[Arched Eyebrow of the Archmage], 10, 1, 1);
			buffMaintain($effect[Jackasses\' Symphony of Destruction], 8, 1, 1);
			buffMaintain($effect[Puzzle Fury], 0, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]) && (have_effect($effect[Mental A-cue-ity]) == 0))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=2");
			}

			if((item_amount($item[Tobiko Marble Soda]) == 0) && (have_effect($effect[Pisces in the Skyces]) == 0) && (item_amount($item[Ye Wizard\'s Shack snack voucher]) > 0))
			{
				cli_execute("make " + $item[Tobiko Marble Soda]);
				buffMaintain($effect[Pisces in the Skyces], 0, 1, 1);
			}

			if(have_familiar($familiar[Disembodied Hand]))
			{
				use_familiar($familiar[Disembodied Hand]);
				if(equipped_item($slot[familiar]) != $item[Obsidian Nutcracker])
				{
					if((item_amount($item[Obsidian Nutcracker]) > 0) || (npc_price($item[Obsidian Nutcracker]) < my_meat()))
					{
						buyUpTo(1, $item[Obsidian Nutcracker]);
					}
					if(item_amount($item[Obsidian Nutcracker]) > 0)
					{
						equip($slot[familiar], $item[Obsidian Nutcracker]);
					}
				}
			}

			if(do_cs_quest(7))
			{
				curQuest = 0;
				use_familiar(prior);
			}
			else
			{
				curQuest = 0;
				use_familiar(prior);
				abort("Could not handle our quest and can not recover");
			}
		}
		break;

	case 8:			#Non-Combat
			while((my_mp() < 30) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[Smooth Movements], 10, 1, 1);
			buffMaintain($effect[The Sonata of Sneakiness], 20, 1, 1);

			if((item_amount($item[Snow Berries]) > 0) && (have_effect($effect[Snow Shoes]) == 0) && (item_amount($item[Snow Cleats]) == 0))
			{
				cli_execute("make 1 snow cleats");
			}

			buffMaintain($effect[Snow Shoes], 0, 1, 1);
			buffMaintain($effect[Obscuri Tea], 0, 1, 1);
			if(is_unrestricted($item[Olympic-sized Clan Crate]) && !get_property("_olympicSwimmingPool").to_boolean())
			{
				cli_execute("swim noncombat");
			}

			int questCost = get_cs_questCost(curQuest);
			if(my_adventures() < questCost)
			{
				buffMaintain($effect[A Rose by Any Other Material], 0, 1, 1);
				questCost = questCost - 12;
			}
			if(my_adventures() < questCost)
			{
				buffMaintain($effect[Throwing Some Shade], 0, 1, 1);
			}


			if((my_adventures() < questCost) && (item_amount($item[Blood-Drive Sticker]) > 0))
			{
				equip($slot[pants], $item[none]);
				equip($slot[off-hand], $item[none]);
				pulverizeThing($item[A Light That Never Goes Out]);
				pulverizeThing($item[Vicar\'s Tutu]);
				chew(item_amount($item[Handful of Smithereens]), $item[Handful of Smithereens]);

			}

			if(do_cs_quest(8))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 9:		#item/booze drops
			cs_eat_stuff(curQuest);

			while((my_mp() < 154) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			if(have_effect($effect[items.enh]) == 0)
			{
				cc_sourceTerminalEnhance("items");
			}

			buffMaintain($effect[Singer\'s Faithful Ocelot], 15, 1, 1);
			buffMaintain($effect[Empathy], 15, 1, 1);
			buffMaintain($effect[Leash of Linguini], 12, 1, 1);
			buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 11, 1, 1);
			buffMaintain($effect[Steely-Eyed Squint], 101, 1, 1);

			buffMaintain($effect[Spice Haze], 250, 1, 1);

			if((get_property("puzzleChampBonus").to_int() == 20) && !get_property("_witchessBuff").to_boolean())
			{
				visit_url("campground.php?action=witchess");
				visit_url("choice.php?whichchoice=1181&pwd=&option=3");
				visit_url("choice.php?whichchoice=1183&pwd=&option=2");
			}

			if((inebriety_left() >= 1) && (have_effect($effect[Sacr&eacute; Mental]) == 0))
			{
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				if(item_amount($item[Sacramento Wine]) > 0)
				{
					drink(1, $item[Sacramento Wine]);
				}
				else if(item_amount($item[Iced Plum Wine]) > 0)
				{
					drink(1, $item[Iced Plum Wine]);
				}
				else
				{
					cli_execute("drink cup of tea");
				}
			}

			buffMaintain($effect[Human-Pirate Hybrid], 0, 1, 1);
			buffMaintain($effect[One Very Clear Eye], 0, 1, 1);
			buffMaintain($effect[Sour Softshoe], 0, 1, 1);
			buffMaintain($effect[Serendipi Tea], 0, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]) && (have_effect($effect[Hustlin\']) == 0))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=3");
			}
			if(is_unrestricted($item[Clan Pool Table]) && (have_effect($effect[Billiards Belligerence]) == 0))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
			}

			boolean [familiar] itemFams = $familiars[Gelatinous Cubeling, Syncopated Turtle, Slimeling, Angry Jung Man, Grimstone Golem, Adventurous Spelunker, Jumpsuited Hound Dog, Steam-Powered Cheerleader];
			familiar itemFam = $familiar[Cocoabo];
			foreach fam in itemFams
			{
				if(have_familiar(fam))
				{
					itemFam = fam;
				}
			}
			#handleFamiliar(itemFam);
			use_familiar(itemFam);

			if(do_cs_quest(9))
			{
				curQuest = 0;
				use_familiar(prior);
			}
			else
			{
				curQuest = 0;
				use_familiar(prior);
				abort("Could not handle our quest and can not recover");
			}
		break;


	case 10:	#Hot Resistance
			if(canYellowRay())
			{
				if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
				{
					handleFamiliar("yellow ray");
				}
				if(is_unrestricted($item[Deluxe Fax Machine]) && (item_amount($item[Potion of Temporary Gr8tness]) == 0))
				{
					if(handleFaxMonster($monster[Sk8 gnome], "cs_combatYR"))
					{
						return true;
					}
				}
				if(elementalPlanes_access($element[hot]))
				{
					ccAdv(1, $location[The Velvet / Gold Mine], "cs_combatYR");
					return true;
				}
			}

			if(have_familiar($familiar[Exotic Parrot]))
			{
				#handleFamiliar($familiar[Exotic Parrot]);
				use_familiar($familiar[Exotic Parrot]);
			}

			if(Lx_resolveSixthDMT())
			{
				return true;
			}

			if(possessEquipment($item[lava-proof pants]))
			{
				equip($item[lava-proof pants]);
			}
			if(possessEquipment($item[fireproof megaphone]))
			{
				equip($item[fireproof megaphone]);
			}
			if(possessEquipment($item[high-temperature mining mask]))
			{
				equip($item[high-temperature mining mask]);
			}
			if(possessEquipment($item[heat-resistant gloves]))
			{
				equip($slot[acc1], $item[heat-resistant gloves]);
			}
			if(possessEquipment($item[heat-resistant necktie]))
			{
				equip($slot[acc3], $item[heat-resistant necktie]);
			}

			while((my_mp() < 37) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			boolean [item] toSmash = $items[asparagus knife, dirty hobo gloves, dirty rigging rope, heavy-duty clipboard, Microplushie: Sororitrate, plastic nunchaku, sewage-clogged pistol, Staff of the Headmaster\'s Victuals];
			foreach it in toSmash
			{
				pulverizeThing(it);
			}

			if((item_amount($item[Sleaze Powder]) > 0) && (item_amount($item[Lotion of Sleaziness]) == 0) && (have_effect($effect[Sleazy Hands]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0) && have_skill($skill[Advanced Saucecrafting]))
			{
				cli_execute("make lotion of sleaziness");
			}
			if((item_amount($item[Stench Powder]) > 0) && (item_amount($item[Lotion of Stench]) == 0) && (have_effect($effect[Stinky Hands]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious Reagent]) > 0) && have_skill($skill[Advanced Saucecrafting]))
			{
				cli_execute("make lotion of stench");
			}

			if(!get_property("_mayoTankSoaked").to_boolean() && (cc_get_campground() contains $item[Portable Mayo Clinic]) && is_unrestricted($item[Portable Mayo Clinic]))
			{
				string temp = visit_url("shop.php?action=bacta&whichshop=mayoclinic");
			}

			buffMaintain($effect[Protection from Bad Stuff], 0, 1, 1);
			buffMaintain($effect[Human-Elemental Hybrid], 0, 1, 1);
			buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
			buffMaintain($effect[Leash of Linguini], 12, 1, 1);
			buffMaintain($effect[Empathy], 15, 1, 1);
			buffMaintain($effect[Astral Shell], 10, 1, 1);
			buffMaintain($effect[Sleazy Hands], 0, 1, 1);
			buffMaintain($effect[Egged On], 0, 1, 1);
			buffMaintain($effect[Flame-Retardant Trousers], 0, 1, 1);
			buffMaintain($effect[Stinky Hands], 0, 1, 1);
			buffMaintain($effect[Human-Machine Hybrid], 0, 1, 1);
			buffMaintain($effect[Frost Tea], 0, 1, 1);

			cs_eat_stuff(curQuest);

			if(do_cs_quest(10))
			{
				curQuest = 0;
				equip($slot[hat], $item[none]);
				equip($slot[pants], $item[none]);
				equip($slot[off-hand], $item[none]);
				equip($slot[acc1], $item[none]);
				equip($slot[acc3], $item[none]);
				use_familiar(prior);
			}
			else
			{
				curQuest = 0;
				equip($slot[hat], $item[none]);
				equip($slot[pants], $item[none]);
				equip($slot[off-hand], $item[none]);
				equip($slot[acc1], $item[none]);
				equip($slot[acc3], $item[none]);
				use_familiar(prior);
				abort("Could not handle our quest and can not recover");
			}
		break;
	case 11:
			abort("Beep, should not be trying quest 11 at this point in the script");

			if(do_cs_quest(11))
			{
				use(1, $item[a ten-percent bonus]);
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	default:
		abort("No quest remaining or detectable. Maybe we are already done?");
		break;

	}

	return true;
}


boolean cs_witchess()
{
	if(my_path() != "Community Service")
	{
		return false;
	}

	if(get_property("_cc_witchessBattles").to_int() == 5)
	{
		return false;
	}

	if((get_property("_badlyRomanticArrows").to_int() != 1) && have_familiar($familiar[Reanimated Reanimator]))
	{
		handleFamiliar($familiar[Reanimated Reanimator]);
	}
	else if(have_familiar($familiar[Galloping Grill]) && cc_haveSourceTerminal())
	{
		handleFamiliar($familiar[Galloping Grill]);
	}

	if((get_property("_cc_witchessBattles").to_int() == 5) || (get_property("_cc_witchessBattles").to_int() == 0))
	{
		cc_sourceTerminalRequest("educate digitize.edu");
	}
	boolean result = cc_advWitchess("booze", "cs_combatNormal");
	cc_sourceTerminalRequest("educate extract.edu");
	return result;
}
