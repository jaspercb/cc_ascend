script "cc_community_service.ash"

import <cc_ascend/cc_clan.ash>
import <cc_util>

#	Some details derived some yojimbos_law's forum post:
#	http://forums.kingdomofloathing.com/vb/showpost.php?p=4769933&postcount=345


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
boolean cs_eat_stuff();
boolean cs_giant_growth();


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

	if(day == 1)
	{
		if(get_property("cc_day1_init") != "finished")
		{
			set_property("cc_semirare", "2");
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

			buyUpTo(1, $item[antique accordion]);

			while((item_amount($item[turtle totem]) == 0) || (item_amount($item[saucepan]) == 0))
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}

			equipBaseline();
			visit_url("guild.php?place=challenge");

			deck_cheat("myst stat");
			deck_cheat("meat");
			deck_cheat("green mana");
			autosell(1, $item[1952 Mickey Mantle Card]);

			cli_execute("make bitch");
			buyUpTo(1, $item[Antique Accordion]);

			if(have_skill($skill[Summon Smithsness]))
			{
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
			}

			cli_execute("garden pick");
			if(item_amount($item[Ice Harvest]) > 0)
			{
				cli_execute("make ice island long tea");
			}

			visit_url("da.php");
			if(get_property("barrelShrineUnlocked").to_boolean())
			{
				visit_url("da.php?barrelshrine=1");
				visit_url("choice.php?whichchoice=1100&pwd&option=2", true);
			}

			visit_url("shop.php?whichshop=meatsmith");
			visit_url("shop.php?whichshop=meatsmith&action=talk");
			run_choice(1);

			use_familiar($familiar[Crimbo Shrub]);
			if((my_familiar() == $familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
			{
				visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
				visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=2&lights=1&garland=3&gift=1");
			}
			use_familiar($familiar[none]);

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
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
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
	if((item_amount($item[Milk of Magnesium]) == 0) && (item_amount($item[Glass of Goat\'s Milk]) > 0) && have_skill($skill[Advanced Saucecrafting]))
	{
		cli_execute("make milk of magnesium");
	}


	if(my_daycount() == 1)
	{
		if(!possessEquipment($item[Hairpiece on Fire]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Hairpiece on Fire");
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
		if(!possessEquipment($item[Staff of the Headmaster\'s Victuals]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Staff of the Headmaster\'s Victuals");
		}
		if(!possessEquipment($item[Vicar\'s Tutu]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			cli_execute("make Vicar's Tutu");
		}
		if(item_amount($item[Handful of Smithereens]) >= 3)
		{
			cli_execute("make 3 louder than bomb");
		}

		if(item_amount($item[Scrumptious Reagent]) == 5)
		{
			if(item_amount($item[grapefruit]) > 0)
			{
				cli_execute("make ointment of the occult");
			}
			if(item_amount($item[squashed frog]) > 0)
			{
				cli_execute("make frogade");
			}
			if(item_amount($item[eye of newt]) > 0)
			{
				cli_execute("make eyedrops of newt");
			}
			else if(item_amount($item[salamander spleen]) > 0)
			{
				cli_execute("make salamander slurry");
			}
		}

	}
}

boolean cs_eat_stuff()
{
	if(my_path() != "Community Service")
	{
		return false;
	}
	if(my_daycount() == 1)
	{
		if(item_amount($item[Weird Gazelle Steak]) > 0)
		{
			if(item_amount($item[Milk of Magnesium]) > 0)
			{
				use(1, $item[Milk of Magnesium]);
			}
			eat(1, $item[Weird Gazelle Steak]);
			if(item_amount($item[Handful of Smithereens]) > 0)
			{
				cli_execute("make 1 this charming flan");
				eat(1, $item[This Charming Flan]);
			}
			if(item_amount($item[Snow Berries]) > 1)
			{
				cli_execute("make 1 snow crab");
				eat(1, $item[Snow Crab]);
			}
			eatFancyDog("sleeping dog");
		}
	}
	else if(my_daycount() == 2)
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
	if(get_property("dnaSyringe") == $phylum[beast])
	{
		if((get_property("_dnaPotionsMade").to_int() == 0) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == $phylum[pirate])
	{
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == $phylum[elemental])
	{
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
	}

	if((get_property("dnaSyringe") == $phylum[fish]) && !get_property("_dnaHybrid").to_boolean())
	{
		if((get_property("_dnaPotionsMade").to_int() == 3) && (my_daycount() == 1))
		{
			cli_execute("camp dnainject");
		}
	}

	if(get_property("dnaSyringe") == $phylum[construct])
	{
		if((get_property("_dnaPotionsMade").to_int() == 0) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == $phylum[dude])
	{
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == $phylum[humanoid])
	{
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
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

	if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love stinkbug)");
		return "skill summon love stinkbug";
	}
	if((!contains_text(combatState, "love mosquito")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love mosquito)");
		return "skill summon love mosquito";
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
	boolean [monster] lookFor = $monsters[Dairy Goat, factory overseer (female), factory worker (female), mine overseer (male), mine overseer (female), mine worker (male), mine worker (female)];
	if((have_effect($effect[Everything Looks Yellow]) == 0) && (lookFor contains enemy))
	{
		if((!contains_text(combatState, "yellowray")) && (my_familiar() == $familiar[Crimbo Shrub]))
		{
			set_property("cc_combatHandler", combatState + "(yellowray)");
			handleTracker(enemy, $skill[Open a Big Yellow Present], "cc_yellowRays");
			return "skill Open a Big Yellow Present";
		}
	}

	if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love stinkbug)");
		return "skill summon love stinkbug";
	}
	if((!contains_text(combatState, "love mosquito")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love mosquito)");
		return "skill summon love mosquito";
	}
	return "skill salsaball";
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
	if((!contains_text(combatState, "louder than bomb")) && (item_amount($item[Louder Than Bomb]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(louder than bomb)");
		return "item louder than bomb";
	}

	abort("Could not LTB our Giant Growth, uh oh.");
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
	if(item_amount($item[Louder Than Bomb]) == 0)
	{
		return false;
	}
	return adv1($location[The Haunted Kitchen], 0, "cs_combatLTB");
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
	case 1:		return "Community Service Quest: HP";
	case 2:		return "Community Service Quest: Muscle";
	case 3:		return "Community Service Quest: Mysticality";
	case 4:		return "Community Service Quest: Moxie";
	case 5:		return "Community Service Quest: Familiar Weight";
	case 6:		return "Community Service Quest: Melee Damage";
	case 7:		return "Community Service Quest: Spell Damage";
	case 8:		return "Community Service Quest: Monsters Less Attracted to You";
	case 9:		return "Community Service Quest: Item/Booze Drops";
	case 10:	return "Community Service Quest: Hot Protection";
	case 11:	return "Community Service Quest: Coiling Wire";
	default:	return "Community Service Quest: NULL";
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
	int [int] questList = get_cs_questList();
	if(((questList contains quest) && (my_adventures() > questList[quest])) || (quest == 30))
	{
		string temp = visit_url("council.php");
		temp = run_choice(quest);
		if(quest != 30)
		{
			print("Quest " + quest + " completed for " + questList[quest] + " adventures.", "blue");
		}
		else
		{
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

