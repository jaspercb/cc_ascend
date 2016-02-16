script "cc_community_service.ash"

import <cc_ascend/cc_clan.ash>
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_ascend_header.ash>

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
boolean cs_eat_stuff(int quest);
boolean cs_giant_growth();
boolean cs_eat_spleen();



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
			autosell(item_amount($item[1952 Mickey Mantle Card]), $item[1952 Mickey Mantle Card]);

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
			if(get_property("barrelShrineUnlocked").to_boolean() && !get_property("_barrelPrayer").to_boolean())
			{
				boolean buff = cli_execute("barrelprayer Glamour");
			}

			if(get_property("questM23Meatsmith") == "unstarted")
			{
				set_property("choiceAdventure1059", 1);
				visit_url("shop.php?whichshop=meatsmith");
				visit_url("shop.php?whichshop=meatsmith&action=talk");
				run_choice(1);
			}

			if(have_familiar($familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
			{
				familiar last = my_familiar();
				use_familiar($familiar[Crimbo Shrub]);
				visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
				visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=2&lights=1&garland=3&gift=1");
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
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}
				if(my_mp() >= mp_cost($skill[Summon Smithsness]))
				{
					use_skill(1, $skill[Summon Smithsness]);
				}

				if(have_skill($skill[Summon Clip Art]) && (my_mp() >= mp_cost($skill[Summon Clip Art])))
				{
					cli_execute("make cold-filtered water");
				}
				else if(my_mp() >= mp_cost($skill[Summon Smithsness]))
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
	if((item_amount($item[Milk of Magnesium]) == 0) && (item_amount($item[Glass of Goat\'s Milk]) > 0) && have_skill($skill[Advanced Saucecrafting]) && (get_property("_rapidPrototypingUsed").to_int() < 5))
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

		if(!have_familiar($familiar[Machine Elf]))
		{
			if(item_amount($item[Handful of Smithereens]) >= 3)
			{
				cli_execute("make 3 louder than bomb");
			}
		}

		if(item_amount($item[Scrumptious Reagent]) >= 5)
		{
			if((item_amount($item[gr8ps]) > 0) && (item_amount($item[Potion of Temporary Gr8tness]) == 0) && (npc_price($item[Delectable Catalyst]) < my_meat()) && (get_property("_rapidPrototypingUsed").to_int() < 5))
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
				eatFancyDog("savage macho dog");
			}
			else
			{
				eatFancyDog("sleeping dog");
			}

			if((item_amount($item[Snow Berries]) > 1) && (my_fullness() <= (fullness_limit() - 1)))
			{
				cli_execute("make 1 snow crab");
				eat(1, $item[Snow Crab]);
			}
			if((item_amount($item[Handful of Smithereens]) > 0) && (my_fullness() <= (fullness_limit() - 2)))
			{
				cli_execute("make 1 this charming flan");
				eat(1, $item[This Charming Flan]);
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
	}

	if(get_property("dnaSyringe") == $phylum[dude])
	{
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == $phylum[humanoid])
	{
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
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

	if(isFreeMonster(last_monster()))
	{
		return cs_combatNormal(round, opp, text);
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
		abort("100% familiar is not compatible, to disable: set cc_100familiar=false");
	}

	static int curQuest = 0;
	if(curQuest == 0)
	{
		curQuest = expected_next_cs_quest();
	}

	cs_dnaPotions();
	use_barrels();
	cs_make_stuff();

	if(fortuneCookieEvent())
	{
		return true;
	}

	equipBaseline();
	print(what_cs_quest(curQuest), "blue");

	cs_eat_spleen();

	boolean [familiar] useFam;
	if(((curQuest == 11) || (curQuest == 6) || (curQuest == 9)) && (my_spleen_use() < 12))
	{
		useFam = $familiars[Unconscious Collective, Grim Brother, Golden Monkey];
	}
	else
	{
		useFam = $familiars[Galloping Grill, Fist Turkey, Puck Man, Ms. Puck Man];
	}

	familiar toFam = $familiar[Cocoabo];
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
				if(item_amount($item[Ice Island Long Tea]) > 0)
				{
					cli_execute("drink Ice Island Long Tea");
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

				if(have_familiar($familiar[Crimbo Shrub]))
				{
					handleFamiliar($familiar[Crimbo Shrub]);
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
				if((item_amount($item[Glass of Goat\'s Milk]) > 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
				{
					cli_execute("make milk of magnesium");
				}
				return true;
			}

			if(chateaumantegna_available() && (get_property("chateauMonster") != $monster[dairy goat]) && (my_fullness() == 0) && !get_property("_photocopyUsed").to_boolean())
			{
				handleFamiliar($familiar[Crimbo Shrub]);
				if(my_familiar() == $familiar[Crimbo Shrub])
				{
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
				if((item_amount($item[Glass of Goat\'s Milk]) > 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
				{
					cli_execute("make milk of magnesium");
				}
				return true;
			}

			if(my_fullness() == 0)
			{
				if(item_amount($item[Milk of Magnesium]) > 0)
				{
					use(1, $item[Milk of Magnesium]);
				}
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
				if(get_property("cc_noSleepingDog").to_boolean() || have_skill($skill[Dog Tired]))
				{
					eatFancyDog("savage macho dog");
				}
				else
				{
					eatFancyDog("sleeping dog");
				}
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
			if((have_effect($effect[Everything Looks Yellow]) == 0) && have_familiar($familiar[Crimbo Shrub]) && elementalPlanes_access($element[hot]))
			{
				handleFamiliar($familiar[Crimbo Shrub]);
				ccAdv(1, $location[LavaCo&trade; Lamp Factory], "cs_combatYR");
				return true;
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
				if((item_amount($item[Tomato Juice of Powerful Power]) < 4) && (get_property("_rapidPrototypingUsed").to_int() < 5))
				{
					cli_execute("make 6 tomato juice of powerful power");
				}
			}

			if((my_spleen_use() == 12) && (item_amount($item[Abstraction: Category]) > 0))
			{
				chew(1, $item[Abstraction: Category]);
			}

			int pixelsNeed = 30 - (15 * item_amount($item[Miniature Power Pill]));

			if(((item_amount($item[Power Pill]) < 2) || (item_amount($item[Yellow Pixel]) < pixelsNeed)) && (have_familiar($familiar[Puck Man]) || have_familiar($familiar[Ms. Puck Man])))
			{
				if(get_property("cc_tryPowerLevel").to_boolean())
				{
					if((my_hp() + 50) < my_maxhp())
					{
						useCocoon();
					}
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

						buffMaintain($effect[Ur-Kel\'s Aria of Annoyance], 62, 1, 1);
						buffMaintain($effect[Pride of the Puffin], 62, 1, 1);
						buffMaintain($effect[Drescher\'s Annoying Noise], 72, 1, 1);
						buffMaintain($effect[Wry Smile], 42, 1, 1);
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
						buffMaintain($effect[Empathy], 47, 1, 1);
						buffMaintain($effect[Leash of Linguini], 44, 1, 1);
						buffMaintain($effect[Rage of the Reindeer], 42, 1, 1);
						buffMaintain($effect[Scarysauce], 42, 1, 1);
						buffMaintain($effect[Disco Fever], 42, 1, 1);
						buffMaintain($effect[Ruthlessly Efficient], 42, 1, 1);

						if(!get_property("_aprilShower").to_boolean())
						{
							cli_execute("shower myst");
						}

#						if((have_effect($effect[The Dinsey Look]) == 0) && (item_amount($item[FunFunds&trade;]) > 0))
#						{
#							cli_execute("make dinsey face paint");
#						}
#						buffMaintain($effect[The Dinsey Look], 0, 1, 1);
#						buffMaintain($effect[Flexibili Tea], 0, 1, 1);
						buffMaintain($effect[Neuroplastici Tea], 0, 1, 1);
#						buffMaintain($effect[Physicali Tea], 0, 1, 1);

						if(item_amount($item[Tomato Juice of Powerful Power]) > 4)
						{
							buffMaintain($effect[Tomato Power], 0, 1, 1);
						}


						if((get_property("_hipsterAdv").to_int() < 1) && is_unrestricted($familiar[Artistic Goth Kid]))
						{
							handleFamiliar($familiar[Artistic Goth Kid]);
						}

//						if(my_familiar() != $familiar[Artistic Goth Kid])
//						{
//							if(handleFaxMonster($monster[Black Crayon Crimbo Elf], "cs_combatNormal"))
//							{
//								return true;
//							}
//						}

						ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice], "cs_combatNormal");
						return true;
					}
				}
				ccAdv(1, $location[The Velvet / Gold Mine], "cs_combatNormal");
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
				ccAdv(1, $location[The X-32-F Combat Training Snowman]);
				return true;
			}

			if((have_effect($effect[Half-Blooded]) > 0) || (have_effect($effect[Half-Drained]) > 0) || (have_effect($effect[Bruised]) > 0) || (have_effect($effect[Relaxed Muscles]) > 0) || (have_effect($effect[Hypnotized]) > 0) || (have_effect($effect[Bad Haircut]) > 0))
			{
				doHottub();
			}

			if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_adventures() > 0))
			{
				if(get_property("cc_choice1119") != "")
				{
					set_property("choiceAdventure1119", get_property("cc_choice1119"));
				}
				set_property("cc_choice1119", get_property("choiceAdventure1119"));
				set_property("choiceAdventure1119", 1);
				handleFamiliar($familiar[Machine Elf]);
				ccAdv(1, $location[The Deep Machine Tunnels]);
				set_property("choiceAdventure1119", get_property("cc_choice1119"));
				set_property("cc_choice1119", "");
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

			if(have_familiar($familiar[Crimbo Shrub]) && (have_effect($effect[Everything Looks Yellow]) == 0) && !get_property("_photocopyUsed").to_boolean())
			{
				handleFamiliar($familiar[Crimbo Shrub]);
				if(handleFaxMonster($monster[Sk8 gnome], "cs_combatYR"))
				{
					return true;
				}
			}

			if(have_skill($skill[Advanced Saucecrafting]))
			{
				if((item_amount($item[Oil of Expertise]) < 2) && (get_property("_rapidPrototypingUsed").to_int() < 5))
				{
					cli_execute("make 3 oil of expertise");
				}
				if((item_amount($item[Tomato Juice of Powerful Power]) < 4) && (get_property("_rapidPrototypingUsed").to_int() < 5))
				{
					cli_execute("make 6 tomato juice of powerful power");
				}

				if((item_amount($item[grapefruit]) > 0) && (item_amount($item[Ointment of the Occult]) == 0))
				{
					cli_execute("make ointment of the occult");
				}
				else if((item_amount($item[squashed frog]) > 0) && (item_amount($item[Frogade]) == 0))
				{
					cli_execute("make frogade");
				}
				else if((item_amount($item[eye of newt]) > 0) && (item_amount($item[Eyedrops of Newt]) == 0))
				{
					cli_execute("make eyedrops of newt");
				}
				else if((item_amount($item[salamander spleen]) > 0) && (item_amount($item[Salamander Slurry]) == 0))
				{
					cli_execute("make salamander slurry");
				}

			}

			buffMaintain($effect[Simmering], 0, 1, 1);
			uneffect($effect[The Moxious Madrigal]);
			uneffect($effect[Ur-Kel\'s Aria of Annoyance]);
			uneffect($effect[Brawnee\'s Anthem of Absorption]);
			uneffect($effect[Power Ballad of the Arrowsmith]);

			buffMaintain($effect[Ode to Booze], 50, 1, 10);
			overdrink(1, $item[Emergency Margarita]);
			if((my_spleen_use() == 12) && (item_amount($item[Handful of Smithereens]) > 0))
			{
				chew(1, $item[Handful of Smithereens]);
			}
			if((my_spleen_use() == 13) && (item_amount($item[Handful of Smithereens]) > 1))
			{
				chew(1, $item[Handful of Smithereens]);
			}
			while(((my_spleen_use() + 2) <= spleen_limit()) && (item_amount($item[cuppa Activi tea]) > 0))
			{
				chew(1, $item[cuppa Activi tea]);
			}
			while(((my_spleen_use() + 1) <= spleen_limit()) && (item_amount($item[Nasty Snuff]) > 0))
			{
				chew(1, $item[Nasty Snuff]);
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

			if(have_familiar($familiar[Crimbo Shrub]) && (have_effect($effect[Everything Looks Yellow]) == 0) && !get_property("_photocopyUsed").to_boolean())
			{
				handleFamiliar($familiar[Crimbo Shrub]);
				if(handleFaxMonster($monster[Sk8 gnome], "cs_combatYR"))
				{
					return true;
				}
			}
			if((item_amount($item[Gr8ps]) > 0) && (item_amount($item[Potion of Temporary Gr8tness]) == 0) && (have_effect($effect[Gr8tness]) == 0) && (npc_price($item[Delectable Catalyst]) < my_meat()) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make " + $item[Potion of Temporary Gr8tness]);
			}

			if(!possessEquipment($item[Barrel Lid]) && get_property("barrelShrineUnlocked").to_boolean() && !get_property("_barrelPrayer").to_boolean())
			{
				boolean buff = cli_execute("barrelprayer Protection");
			}

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

			if(!get_property("_grimBuff").to_boolean())
			{
				cli_execute("grim hpmp");
			}
			if(is_unrestricted($item[Colorful Plastic Ball]))
			{
				# Can not beu used in Ronin/Hardcore, derp....
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

			if(!get_property("cc_tryPowerLevel").to_boolean())
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

			if(item_amount($item[Saucepanic]) > 0)
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
			if((item_amount($item[Snow Berries]) > 0) || (item_amount($item[Snow Cleats]) == 0))
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
					if(my_meat() > 5000)
					{
						extraAdv = extraAdv + 13;
						needCost = needCost - 2;
					}
					if(item_amount($item[Asbestos Thermos]) > 0)
					{
						extraAdv = extraAdv + 16;
					}
					if(item_amount($item[Cold One]) > 0)
					{
						extraAdv = extraAdv + 5;
					}

					if(item_amount($item[Blood-Drive Sticker]) > 0)
					{
						needCost = needCost + 5;
					}

					if((my_adventures() + extraAdv) > needCost)
					{
						use_skill(1, $skill[The Ode to Booze]);
						if((my_meat() > 5000) && (item_amount($item[Clan VIP Lounge Key]) > 0))
						{
							cli_execute("drink 1 hot socks");
						}
						if(item_amount($item[Asbestos Thermos]) > 0)
						{
							drink(1, $item[Asbestos Thermos]);
						}
						if(item_amount($item[Cold One]) > 0)
						{
							drink(1, $item[Cold One]);
						}
					}
					else
					{
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
			if(is_unrestricted($item[Clan Pool Table]))
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
				use(item_amount($item[Ghost Dog Chow]), $item[Ghost Dog Chow]);
			}


			if(do_cs_quest(5))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;

	case 6:		#Melee Damage
			while((my_mp() < 50) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if((my_inebriety() == 5) || (my_inebriety() == 11))
			{
				uneffect($effect[Cletus\'s Canticle of Celerity]);
				uneffect($effect[The Moxious Madrigal]);
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				cli_execute("drink sockdollager");
				cli_execute("drink cup of tea");
			}


			while((my_mp() < 152) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}

			buffMaintain($effect[Song of the North], 100, 1, 1);
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
			if(is_unrestricted($item[Clan Pool Table]))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
			}


			while((my_level() < 8) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
				buffMaintain($effect[Ode to Booze], 50, 1, 6);
				cli_execute("postcheese");
			}
			if((my_level() >= 8) && (item_amount($item[Astral Pilsner]) > 0))
			{
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
//			Do not let this trigger an adventure loss, do not waste these for later.
//			if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_adventures() > 0))
//			{
//				if(get_property("cc_choice1119") != "")
//				{
//					set_property("choiceAdventure1119", get_property("cc_choice1119"));
//				}
//				set_property("cc_choice1119", get_property("choiceAdventure1119"));
//				set_property("choiceAdventure1119", 1);
//				handleFamiliar($familiar[Machine Elf]);
//				ccAdv(1, $location[The Deep Machine Tunnels]);
//				set_property("choiceAdventure1119", get_property("cc_choice1119"));
//				set_property("cc_choice1119", "");
//				return true;
//			}



			if((have_effect($effect[Half-Blooded]) > 0) || (have_effect($effect[Half-Drained]) > 0) || (have_effect($effect[Bruised]) > 0) || (have_effect($effect[Relaxed Muscles]) > 0) || (have_effect($effect[Hypnotized]) > 0) || (have_effect($effect[Bad Haircut]) > 0))
			{
				doHottub();
			}

			while((my_mp() < 200) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			if(possessEquipment($item[Staff of the Headmaster\'s Victuals]) && can_equip($item[Staff of the Headmaster\'s Victuals]) && have_skill($skill[Spirit of Rigatoni]))
			{
				equip($slot[weapon], $item[Staff of the Headmaster\'s Victuals]);
			}
			if(possessEquipment($item[Astral Statuette]))
			{
				equip($item[Astral Statuette]);
			}
			buffMaintain($effect[Song of Sauce], 100, 1, 1);
			buffMaintain($effect[Arched Eyebrow of the Archmage], 10, 1, 1);
			buffMaintain($effect[Jackasses\' Symphony of Destruction], 8, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=2");
			}

			if((item_amount($item[Tobiko Marble Soda]) == 0) && (have_effect($effect[Pisces in the Skyces]) == 0) && (item_amount($item[Ye Wizard\'s Shack snack voucher]) > 0))
			{
				cli_execute("make " + $item[Tobiko Marble Soda]);
				buffMaintain($effect[Pisces in the Skyces], 0, 1, 1);
			}


			if(do_cs_quest(7))
			{
				curQuest = 0;
			}
			else
			{
				curQuest = 0;
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

			buffMaintain($effect[Singer\'s Faithful Ocelot], 15, 1, 1);
			buffMaintain($effect[Empathy], 15, 1, 1);
			buffMaintain($effect[Leash of Linguini], 12, 1, 1);
			buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 11, 1, 1);
			print("Cost before Steely: " + get_cs_questCost(9), "green");
			buffMaintain($effect[Steely-Eyed Squint], 101, 1, 1);
			print("Cost after Steely: " + get_cs_questCost(9), "green");

			buffMaintain($effect[Spice Haze], 250, 1, 1);

			buffMaintain($effect[Human-Pirate Hybrid], 0, 1, 1);
			buffMaintain($effect[One Very Clear Eye], 0, 1, 1);
			buffMaintain($effect[Sour Softshoe], 0, 1, 1);
			buffMaintain($effect[Serendipi Tea], 0, 1, 1);
			if(is_unrestricted($item[Clan Pool Table]))
			{
				visit_url("clan_viplounge.php?preaction=poolgame&stance=3");
			}
			if(is_unrestricted($item[Clan Pool Table]))
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
			}
			else
			{
				curQuest = 0;
				abort("Could not handle our quest and can not recover");
			}
		break;


	case 10:	#Hot Resistance
			if((have_effect($effect[Everything Looks Yellow]) == 0) && have_familiar($familiar[Crimbo Shrub]))
			{
				if(is_unrestricted($item[Deluxe Fax Machine]) && (item_amount($item[Potion of Temporary Gr8tness]) == 0))
				{
					handleFamiliar($familiar[Crimbo Shrub]);
					if(handleFaxMonster($monster[Sk8 gnome], "cs_combatYR"))
					{
						return true;
					}
				}
				else
				{
					handleFamiliar($familiar[Crimbo Shrub]);
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

			boolean [item] toSmash = $items[asparagus knife, plastic nunchaku, Staff of the Headmaster\'s Victuals, heavy-duty clipboard, dirty hobo gloves, dirty rigging rope, sewage-clogged pistol];
			foreach it in toSmash
			{
				pulverizeThing(it);
			}

			if((item_amount($item[Sleaze Powder]) > 0) && (item_amount($item[Lotion of Sleaziness]) == 0) && (have_effect($effect[Sleazy Hands]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make lotion of sleaziness");
			}
			if((item_amount($item[Stench Powder]) > 0) && (item_amount($item[Lotion of Stench]) == 0) && (have_effect($effect[Stinky Hands]) == 0) && (get_property("_rapidPrototypingUsed").to_int() < 5))
			{
				cli_execute("make lotion of stench");
			}

			buffMaintain($effect[Protection from Bad Stuff], 0, 1, 1);
			buffMaintain($effect[Human-Elemental Hybrid], 0, 1, 1);
			buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
			buffMaintain($effect[Leash of Linguini], 12, 1, 1);
			buffMaintain($effect[Empathy], 15, 1, 1);
			buffMaintain($effect[Astral Shell], 10, 1, 1);
			buffMaintain($effect[Sleazy Hands], 0, 1, 1);
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
			}
			else
			{
				curQuest = 0;
				equip($slot[hat], $item[none]);
				equip($slot[pants], $item[none]);
				equip($slot[off-hand], $item[none]);
				equip($slot[acc1], $item[none]);
				equip($slot[acc3], $item[none]);
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

