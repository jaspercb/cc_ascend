script "cc_ascend.ash";
notify cheesecookie;
since r16166;

/***	svn checkout https://svn.code.sf.net/p/ccascend/code/cc_ascend
		Killing is wrong, and bad. There should be a new, stronger word for killing like badwrong or badong. YES, killing is badong. From this moment, I will stand for the opposite of killing, gnodab.
***/

import <cc_ascend/cc_ascend_header.ash>
import <cc_ascend/cc_deprecation.ash>
import <cc_combat.ash>
import <cc_util.ash>
import <cc_ascend/heavyrains.ash>
import <cc_ascend/picky.ash>
import <cc_ascend/standard.ash>
import <cc_ascend/floristfriar.ash>
import <cc_ascend/chateaumantegna.ash>
import <cc_ascend/cc_equipment.ash>
import <cc_ascend/cc_edTheUndying.ash>
import <cc_ascend/cc_eudora.ash>
import <cc_ascend/cc_summerfun.ash>
import <cc_ascend/cc_elementalPlanes.ash>
import <cc_ascend/cc_deckofeverycard.ash>


boolean ccEat(int howMany, item toEat)
{
	boolean retval = false;
	while(howMany > 0)
	{
		if((get_campground() contains $item[Portable Mayo Clinic]) && (my_meat() > 11000))
		{
			buy(1, $item[Mayoflex]);
			use(1, $item[Mayoflex]);
		}
		retval = eat(1, toEat);
		howMany = howMany - 1;
	}
	return retval;
}

void initializeSettings()
{
	if(my_ascensions() <= get_property("cc_doneInitialize").to_int())
	{
		return;
	}
	set_property("cc_doneInitialize", my_ascensions());

	if(my_familiar() != $familiar[none])
	{
		set_property("cc_100familiar", user_confirm("Familiar already set, is this a 100% familiar run? Will default to 'No' in 15 seconds.", 15000, false));
		set_property("cc_useCubeling", false);
	}
	else
	{
		set_property("cc_useCubeling", true);
		set_property("cc_100familiar", false);
	}

	set_property("chasmBridgeProgress", 0);

	set_property("cc_abooclover", "");
	set_property("cc_aboocount", "0");
	set_property("cc_aftercore", "");
	set_property("cc_airship", "");
	set_property("cc_ballroom", "");
	set_property("cc_ballroomflat", "");
	set_property("cc_ballroomopen", "");
	set_property("cc_ballroomsong", "");
	set_property("cc_banishes", "");
	set_property("cc_bat", "");
	set_property("cc_bean", "");
	set_property("cc_getBeehive", false);
	set_property("cc_blackfam", true);
	set_property("cc_blackmap", "");
	set_property("cc_boopeak", "");
	set_property("cc_breakstone", get_property("cc_pvpEnable").to_boolean());
	set_property("cc_castlebasement", "");
	set_property("cc_castleground", "");
	set_property("cc_castletop", "");
	set_property("cc_chasmBusted", true);
	set_property("cc_clanstuff", "0");
	set_property("cc_crackpotjar", "");
	set_property("cc_crypt", "");
	set_property("cc_cubeItems", "");
	set_property("cc_day1_cobb", "");
	set_property("cc_day1_dna", "");
	set_property("cc_day1_init", "");
	set_property("cc_day2_init", "");
	set_property("cc_day3_init", "");
	set_property("cc_day4_init", "");
	set_property("cc_disableAdventureHandling", "no");
	set_property("cc_doCombatCopy", "no");
	set_property("cc_fcle", "");
	set_property("cc_friars", "");
	set_property("cc_funTracker", "");
	set_property("cc_gaudy", "");
	set_property("cc_gaudypiratecount", "");
	set_property("cc_getBoningKnife", false);
	set_property("cc_getStarKey", false);
	set_property("cc_goblinking", "");
	set_property("cc_gremlins", "");
	set_property("cc_gremlinclap", "");
	set_property("cc_gremlinbatter", "");
	set_property("cc_gremlinpants", "");
	set_property("cc_gremlinlouder", "");
	set_property("cc_grimfairytale", "");
	set_property("cc_grimstoneFancyOilPainting", true);
	set_property("cc_grimstoneOrnateDowsingRod", true);
	set_property("cc_guildmeat", "");
	set_property("cc_gunpowder", "");
	set_property("cc_hasrainman", "");
	set_property("cc_haslightningbolt", "");
	set_property("cc_haveoven", false);
	set_property("cc_hedge", "fast");
	set_property("cc_hiddenapartment", "0");
	set_property("cc_hiddenbowling", "");
	set_property("cc_hiddencity", "");
	set_property("cc_hiddenhospital", "");
	set_property("cc_hiddenoffice", "0");
	set_property("cc_hiddenunlock", "");
	set_property("cc_hiddenzones", "");
	set_property("cc_highlandlord", "");
	set_property("cc_hippyInstead", false);
	set_property("cc_holeinthesky", false);
	set_property("cc_hugeghuol", "");
	set_property("cc_ignoreFlyer", false);
	set_property("cc_killingjar", "");
	set_property("cc_mcmuffin", "");
	set_property("cc_mistypeak", "");
	set_property("cc_modernzmobiecount", "");
	set_property("cc_mosquito", "");
	set_property("cc_nuns", "");

	if((my_name() == "cheesecookie") && (my_path() != "Actually Ed the Undying"))
	{
		set_property("cc_nunsTrick", "yes");
	}
	else
	{
		set_property("cc_nunsTrick", "no");
	}
	set_property("cc_nunsTrickActive", "no");
	set_property("cc_nunsTrickGland", "");
	set_property("cc_nunsTrickCount", "0");
	set_property("cc_nunsTrickReady", "");
	set_property("cc_oilpeak", "");
	set_property("cc_orchard", "");
	set_property("cc_palindome", "");
	set_property("cc_phatloot", "");
	set_property("cc_prewar", "");
	set_property("cc_prehippy", "");
	set_property("cc_pirateoutfit", "");
	set_property("cc_priorCharpaneMode", "0");
	set_property("cc_semirare", "");
	set_property("cc_semisub", "");
	set_property("cc_snapshot", "");
	set_property("cc_sniffs", "");
	set_property("cc_spookyfertilizer", "finished");
	set_property("cc_spookymap", "");
	set_property("cc_spookyravennecklace", "");
	set_property("cc_spookyravensecond", "");
	set_property("cc_spookysapling", "");
	set_property("cc_sonata", "");
	set_property("cc_sorceress", "");
	set_property("cc_swordfish", "");
	set_property("cc_tavern", "");
	set_property("cc_trytower", "");
	set_property("cc_trapper", "");
	set_property("cc_treecoin", "");
	set_property("cc_twinpeak", "");
	set_property("cc_twinpeakprogress", "");
	set_property("cc_waitingArrowAlcove", "50");
	set_property("cc_wandOfNagamar", false);
	set_property("cc_war", "");
	set_property("cc_winebomb", "");
	set_property("cc_writingDeskSummon", false);
	set_property("cc_yellowRay_day1", "");
	set_property("cc_yellowRay_day2", "");
	set_property("cc_yellowRay_day3", "");
	set_property("cc_yellowRay_day4", "");
	set_property("cc_yellowRays", "");

	if(in_hardcore())
	{
		set_property("cc_spookyfertilizer", "");
	}

	set_property("autoSatisfyWithNPCs", true);

	beehiveConsider();

	elementalPlanes_initializeSettings();
	eudora_initializeSettings();
	hr_initializeSettings();
	picky_initializeSettings();
	standard_initializeSettings();
	florist_initializeSettings();
	chateaumantegna_initializeSettings();
	ocrs_initializeSettings();
	ed_initializeSettings();
}

# num is not handled properly anyway, so we'll just reject it.
boolean ccAdv(int num, location loc, string option)
{
	if(option == "")
	{
		option = "cc_combatHandler";
	}
	if(my_path() == "Actually Ed the Undying")
	{
		return ed_ccAdv(num, loc, option);
	}

#	boolean retval = adv1(loc, num, option);
	boolean retval = adv1(loc, 0, option);
	if(my_path() == "One Crazy Random Summer")
	{
		if(last_monster().random_modifiers["clingy"])
		{
			int oldDesert = get_property("desertExploration").to_int();
			retval = ccAdv(num, loc, option);
			if(my_location() == $location[The Arid\, Extra-Dry Desert])
			{
				set_property("desertExploration", oldDesert);
			}
		}
	}
	return retval;
}

boolean ccAdv(int num, location loc)
{
	return ccAdv(num, loc, "");
}


boolean ccAdvBypass(string url, location loc)
{
	if(my_class() == $class[Ed])
	{
		ed_preAdv(1, loc, "");
	}

	print("About to start a combat indirectly at " + loc + "...", "blue");
	string page = visit_url(url);
	if((my_hp() == 0) || (get_property("_edDefeats").to_int() == 1))
	{
		print("Uh oh! Died when starting a combat indirectly.", "red");
		if(my_class() == $class[Ed])
		{
			return ed_ccAdv(1, loc, "", true);
		}
		abort("ccAdvBypass override abort");
	}
	if(contains_text(page, "Combat"))
	{
		return ccAdv(1, loc);
	}
	return false;
}
boolean ccAdvBypass(int snarfblat, location loc)
{
	string page = "adventure.php?snarfblat=" + snarfblat + "&confirm=on";
	return ccAdvBypass(page, loc);
}

boolean ccAdvBypass(int snarfblat)
{
	return ccAdvBypass(snarfblat, $location[Noob Cave]);
}
boolean ccAdvBypass(string url)
{
	return ccAdvBypass(url, $location[Noob Cave]);
}

boolean handleFamiliar(familiar fam)
{
	if(get_property("cc_100familiar").to_boolean())
	{
		return true;
	}

	if((fam == $familiar[Ms. Puck Man]) && !have_familiar($familiar[Ms. Puck Man]) && have_familiar($familiar[Puck Man]))
	{
		fam = $familiar[Puck Man];
	}
	if((fam == $familiar[Puck Man]) && !have_familiar($familiar[Puck Man]) && have_familiar($familiar[Ms. Puck Man]))
	{
		fam = $familiar[Ms. Puck Man];
	}

	familiar toEquip = $familiar[none];
	if(have_familiar(fam))
	{
		toEquip = fam;
	}
	else
	{
		boolean[familiar] poss = $familiars[Mosquito, Leprechaun, Baby Gravy Fairy, Golden Monkey, Hobo Monkey, Crimbo Shrub, Galloping Grill, Fist Turkey, Piano Cat, Angry Jung Man, Grimstone Golem, Adventurous Spelunker];

		int spleen_hold = 4;
		if(item_amount($item[Astral Energy Drink]) > 0)
		{
			spleen_hold = spleen_hold + 8;
		}
		if(in_hardcore() && ((my_spleen_use() + spleen_hold) <= spleen_limit()))
		{
			if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
			{
				toEquip = $familiar[Unconscious Collective];
			}
			if((grimTaleDrops() < 1) && have_familiar($familiar[Grim Brother]))
			{
				toEquip = $familiar[Grim Brother];
			}
			if((powderedGoldDrops() < 1) && have_familiar($familiar[Golden Monkey]))
			{
				toEquip = $familiar[Golden Monkey];
			}
		}
		else if(in_hardcore() && (item_amount($item[Yellow Pixel]) < 30) && have_familiar($familiar[Ms. Puck Man]))
		{
			toEquip = $familiar[Ms. Puck Man];
		}
		else if(in_hardcore() && (item_amount($item[Yellow Pixel]) < 30) && have_familiar($familiar[Puck Man]))
		{
			toEquip = $familiar[Puck Man];
		}

		foreach thing in poss
		{
			if((have_familiar(thing)) && (my_bjorned_familiar() != thing))
			{
				toEquip = thing;
			}
		}
	}

	if((toEquip != $familiar[none]) && (toEquip != my_familiar()) && (my_bjorned_familiar() != toEquip))
	{
		use_familiar(toEquip);
	}

	if(hr_handleFamiliar(fam))
	{
		return true;
	}
	return false;
}


void maximize_hedge()
{
	string data = visit_url("campground.php?action=telescopelow");

	element first = ns_hedge1(data);
	element second = ns_hedge2(data);
	element third = ns_hedge3(data);
	if((first == $element[none]) || (second == $element[none]) || (third == $element[none]))
	{
		maximize("all res -equip snow suit", 2500, 0, false);
	}
	else
	{
		maximize(to_string(first) + " res, " + to_string(second) + " res, " + to_string(third) + " res -equip snow suit", 2500, 0, false);
	}
}

int pullsNeeded(string data)
{
	if(get_property("kingLiberated").to_boolean())
	{
		return 0;
	}
	if(my_class() == $class[Ed])
	{
		return 0;
	}

	int count = 0;
	int adv = 0;

	int progress = 0;
	if(get_property("cc_sorceress") == "hedge")
	{
		progress = 1;
	}
	if(get_property("cc_sorceress") == "door")
	{
		progress = 2;
	}
	if(get_property("cc_sorceress") == "tower")
	{
		progress = 3;
	}
	if(get_property("cc_sorceress") == "top")
	{
		progress = 4;
	}
	data = visit_url("campground.php?action=telescopelow");

	if(progress < 1)
	{
		int crowd1score = 0;
		int crowd2score = 0;
		int crowd3score = 0;

/***
			Skill:				Benefit		(350/85/550)?
			416% init 			9		1 ahead
			402% init			9		1 ahead
			390% init			9		1 ahead
			348% init			8		2 ahead
			346% init			8		2 ahead
			208% init			4		6 ahead

			Sleaze + 88			9
			Spooky + 86			9		1 ahead
			Spooky + 86			8		2 ahead
			Sleaze + 83			8		2 ahead
			Stench + 80			9		1 ahead
			Cold + 33			3		7 ahead
			560 Moxie			9
			544 Moxie			8		2 ahead
			564 Myst			8		2 ahead
			537 Myst			8		2 ahead
			488 Myst			7		3 ahead
			479 Moxie			7		3 ahead

Note: Maximizer gives concert White-boy angst, instead of concert 3 (consequently, it doesn\'t work).

***/

		switch(ns_crowd1(data))
		{
		case 1:					crowd1score = initiative_modifier()/40;							break;
		}

		switch(ns_crowd2(data))
		{
		case $stat[Moxie]:		crowd2score = (my_buffedstat($stat[Moxie]) - 150) / 40;			break;
		case $stat[Muscle]:		crowd2score = (my_buffedstat($stat[Muscle]) - 150) / 40;		break;
		case $stat[Mysticality]:crowd2score = (my_buffedstat($stat[Mysticality]) - 150) / 40;	break;
		}

		switch(ns_crowd3(data))
		{
		case $element[cold]:	crowd3score = numeric_modifier("cold damage") / 9;				break;
		case $element[hot]:		crowd3score = numeric_modifier("hot damage") / 9;				break;
		case $element[sleaze]:	crowd3score = numeric_modifier("sleaze damage") / 9;			break;
		case $element[spooky]:	crowd3score = numeric_modifier("spooky damage") / 9;			break;
		case $element[stench]:	crowd3score = numeric_modifier("stench damage") / 9;			break;
		}

		if(crowd1score < 0)
		{
			crowd1score = 0;
		}
		if(crowd1score > 9)
		{
			crowd1score = 9;
		}
		if(crowd2score < 0)
		{
			crowd2score = 0;
		}
		if(crowd2score > 9)
		{
			crowd2score = 9;
		}
		if(crowd3score < 0)
		{
			crowd3score = 0;
		}
		if(crowd3score > 9)
		{
			crowd3score = 9;
		}
		adv = adv + (10 - crowd1score) + (10 - crowd2score) + (10 - crowd3score);
	}

	if(progress < 2)
	{
		ns_hedge1(data);
		ns_hedge2(data);
		ns_hedge3(data);

		print("Hedge time of 4 adventures. (Up to 10 without Elemental Resistances)", "red");
		adv = adv + 4;
	}

	if(progress < 3)
	{
		if((item_amount($item[Richard\'s Star Key]) == 0) && (item_amount($item[Star Chart]) == 0))
		{
			print("Need star chart", "red");
			if((my_path() == "Heavy Rains") && (my_rain() >= 50))
			{
				print("You should rain man a star chart", "blue");
			}
			else
			{
				count = count + 1;
			}
		}

		if(item_amount($item[Richard\'s Star Key]) == 0)
		{
			int stars = item_amount($item[star]);
			int lines = item_amount($item[line]);

			if(stars < 8)
			{
				print("Need " + (8-stars) + " stars.", "red");
				count = count + (8-stars);
			}
			if(lines < 7)
			{
				print("Need " + (7-lines) + " lines.", "red");
				count = count + (7-lines);
			}
		}

		if((item_amount($item[Digital Key]) == 0) && (item_amount($item[White Pixel]) < 30))
		{
			print("Need " + (30-item_amount($item[white pixel])) + " white pixels.", "red");
			count = count + (30 - item_amount($item[white pixel]));
		}

		if(item_amount($item[skeleton key]) == 0)
		{
			if((item_amount($item[skeleton bone]) > 0) && (item_amount($item[loose teeth]) > 0))
			{
				cli_execute("make skeleton key");
			}
		}
		if(item_amount($item[skeleton key]) == 0)
		{
			print("Need a skeleton key or the ingredients (skeleton bone, loose teeth) for it.");
		}
	}



	if(progress < 4)
	{
		adv = adv + 6;
		if(get_property("cc_wandOfNagamar").to_boolean() && (item_amount($item[wand of nagamar]) == 0) && (item_amount($item[disassembled clover]) == 0))
		{
			print("Need a wand of nagamar (can be clovered).", "red");
			count = count + 1;
		}
	}

	print("Estimated adventure need is: " + adv + ".", "orange");
	print("You need " + count + " pulls.", "orange");
	print("You have " + pulls_remaining() + " pulls.", "orange");
	return count;
}

boolean warOutfit()
{
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		if(!outfit("frat warrior fatigues"))
		{
			foreach it in $items[Beer Helmet, Distressed Denim Pants, Bejeweled Pledge Pin]
			{
				take_closet(closet_amount(it), it);
			}
			if(!outfit("frat warrior fatigues"))
			{
				abort("Do not have frat warrior fatigues and don't know why....");
				return false;
			}
		}
		return true;
	}
	else
	{
		if(!outfit("war hippy fatigues"))
		{
			foreach it in $items[Reinforced Beaded Headband, Bullet-proof Corduroys, Round Purple Sunglasses]
			{
				take_closet(closet_amount(it), it);
			}
			if(!outfit("war hippy fatigues"))
			{
				abort("Do not have war hippy fatigues and don't know why....");
				return false;
			}
		}
		return true;
	}
}

void warAdventure()
{
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		ccAdv(1, $location[The Battlefield (Frat Uniform)]);
	}
	else
	{
		ccAdv(1, $location[The Battlefield (Hippy Uniform)]);
	}
}

//Return false if you should continue, true if it did something
boolean doThemtharHills(boolean trickMode)
{
	if((get_property("currentNunneryMeat").to_int() >= 100000) || (get_property("sidequestNunsCompleted") != "none"))
	{
		handleBjornify($familiar[el vibrato megadrone]);
		set_property("cc_nunsTrickReady", "done");
		set_property("cc_nuns", "done");
		set_property("cc_nunsTrick", "finished");
		return false;
	}

	if(get_property("cc_hippyInstead").to_boolean() || (get_property("hippiesDefeated").to_int() >= 192))
	{
		print("Themthar Nuns!", "blue");
		trickMode = false;
	}
	else
	{
		print("Themthar Nuns! Trick Mode Bitches!", "blue");
	}

	int copyAvailable = 0;
	boolean copyPossible = false;
	boolean fightCopy = false;
	if(trickMode && (get_property("cc_nunsTrickReady") == "yes") && (get_property("hippiesDefeated").to_int() < 192))
	{
		if((my_rain() >= 60) && (have_skill($skill[Rain Man])))
		{
			copyAvailable = 1;
		}
		if(have_skill($skill[Rain Man]))
		{
			copyPossible = true;
		}

#		Sample for allowed Rain-Doh usage.
#		if((item_amount($item[Rain-doh Black Box]) > 0) && (get_property("_raindohCopiesMade").to_int() < 5))
#		{
#			copyAvailable = 2;
#			copyPossible = true;
#		}

		if((item_amount($item[shaking 4-d camera]) > 0) && (get_property("_cameraUsed").to_boolean() != true))
		{
			copyAvailable = 3;
			copyPossible = true;
		}

		if(item_amount($item[Unfinished Ice Sculpture]) > 0)
		{
			copyAvailable = 4;
			copyPossible = true;
		}


		if(copyAvailable == 0)
		{
			return false;
#			if(!copyPossible)
#			{
#				set_property("cc_nunsTrickReady", "done");
#				set_property("cc_nunsTrick", "finished");
#			}
		}
		fightCopy = true;
	}

	if((get_property("sidequestArenaCompleted") == "fratboy") && (get_property("concertVisited") == "false") && (have_effect($effect[Winklered]) == 0))
	{
		outfit("frat warrior fatigues");
		cli_execute("concert 2");
#		outfit("war hippy fatigues");
	}

	handleBjornify($familiar[Hobo Monkey]);
	if((equipped_item($slot[off-hand]) != $item[Half a Purse]) && (item_amount($item[Half a Purse]) == 0) && (item_amount($item[Lump of Brituminous Coal]) > 0))
	{
		buyUpTo(1, $item[Loose Purse Strings]);
		craft("smith", 1, $item[Lump of Brituminous Coal], $item[Loose purse strings]);
	}

	if(possessEquipment($item[Half a Purse]))
	{
		equip($item[Half a Purse]);
	}
	if(possessEquipment($item[Miracle Whip]))
	{
		equip($item[Miracle Whip]);
	}
	if((my_path() == "Heavy Rains") && (item_amount($item[Thor\'s Pliers]) > 0))
	{
		equip($item[Thor\'s Pliers]);
	}

	shrugAT();



	if(my_class() == $class[Ed])
	{
		visit_url("charsheet.php");
		adjustEdHat("meat");
		handleServant($servant[maid]);
	}
	buffMaintain($effect[Purr of the Feline], 10, 1, 1);
	float meatDropHave = meat_drop_modifier();

#	if((my_class() == $class[Ed]) && (meatDropHave > 350.0))
#	{
#		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
#	}
	#if((item_amount($item[Resolution: Be Wealthier]) > 0) && (have_effect($effect[Greedy Resolve]) == 0))
	#{
	#	meatDropHave = meatDropHave + 30.0;
	#}
	#if((item_amount($item[Resolution: Be Luckier]) > 0) && (have_effect($effect[Fortunate Resolve]) == 0))
	#{
	#	meatDropHave = meatDropHave + 5.0;
	#}
	buffMaintain($effect[Greedy Resolve], 0, 1, 1);
	buffMaintain($effect[Disco Leer], 10, 1, 1);
	buffMaintain($effect[Polka of Plenty], 8, 1, 1);
	#Handle for familiar weight change.
	buffMaintain($effect[Kindly Resolve], 0, 1, 1);
	buffMaintain($effect[Heightened Senses], 0, 1, 1);
	buffMaintain($effect[Big Meat Big Prizes], 0, 1, 1);
	buffMaintain($effect[Human-Machine Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Constellation Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Humanoid Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Fish Hybrid], 0, 1, 1);
	buffMaintain($effect[Cranberry Cordiality], 0, 1, 1);

	if(my_path() == "Heavy Rains")
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	else if((get_property("cc_nunsTrickCount").to_int() > 2) || (meat_drop_modifier() > 600.0))
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	// Target 1000 + 400% = 5000 meat per brigand. Of course we want more, but don\'t bother unless we can get this.
	float meat_need = 400.00;
#	if(my_path() == "Standard")
#	{
#		meat_need = meat_need - 100.00;
#	}
#	if(get_property("cc_dickstab").to_boolean())
#	{
#		meat_need = meat_need + 200.00;
#	}
	if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
	{
		meat_need = meat_need - 200;
	}
	if(trickMode)
	{
		// Trick Mode should probably target more than 7000 meat per brigand.
		meat_need = meat_need + 200.00;
	}

	meatDropHave = meat_drop_modifier();

	if((my_class() == $class[Ed]) && have_skill($skill[Curse of Fortune]) && (item_amount($item[Ka Coin]) > 0))
	{
		meatDropHave = meatDropHave + 200;
	}
	if(meatDropHave < meat_need)
	{
		print("Meat drop (" + meatDropHave+ ") is pretty low, (we want: " + meat_need + ") probably not worth it to try this.", "red");

		float minget = 800.00 * (meatDropHave / 100.0);
		int meatneed = 100000 - get_property("currentNunneryMeat").to_int();
		print("The min we expect is: " + minget + " and we need: " + meatneed, "blue");
		if(trickMode)
		{
			if(!user_confirm("About to cancel nuns trick (click yes to continue, no to abort), still need testing on the parameters here."))
			{
				abort("User aborted nuns trick. We do not turn off the nuns flags (cc_nunsTrick->finished to abort). Beep.");
			}
		}

		if(minget < meatneed)
		{
			int curMeat = get_property("currentNunneryMeat").to_int();
			int advs = get_property("cc_nunsTrickCount").to_int();
			int needMeat = 100000 - curMeat;

			boolean failNuns = true;
			if(advs < 22)
			{
				int advLeft = 22 - advs;
				float needPerAdv = needMeat / advLeft;
				if(minget > needPerAdv)
				{
					print("We don't have the desired +meat but should be able to complete the nuns to our advantage", "green");
					failNuns = false;
				}
			}

			if(failNuns)
			{
				set_property("cc_nuns", "done");
				set_property("cc_nunsTrick", "no");
				set_property("cc_nunsTrickReady", "done");
				return true;
			}
		}
		else
		{
			print("The min should be enough! Doing it!!", "purple");
		}
	}


	buffMaintain($effect[Disco Leer], 10, 1, 1);
	buffMaintain($effect[Polka of Plenty], 8, 1, 1);
	buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	buffMaintain($effect[Greedy Resolve], 0, 1, 1);
	buffMaintain($effect[Kindly Resolve], 0, 1, 1);
	buffMaintain($effect[Heightened Senses], 0, 1, 1);
	buffMaintain($effect[Big Meat Big Prizes], 0, 1, 1);
	buffMaintain($effect[Fortunate Resolve], 0, 1, 1);
	buffMaintain($effect[Human-Machine Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Constellation Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Humanoid Hybrid], 0, 1, 1);
	buffMaintain($effect[Human-Fish Hybrid], 0, 1, 1);
	buffMaintain($effect[Cranberry Cordiality], 0, 1, 1);

	if(fightCopy)
	{
		print("Themthar Nuns Trick attempt to finish: " + copyAvailable, "blue");
		print("Meat drop to start: " + meat_drop_modifier(), "blue");
		useCocoon();
		if(equipped_item($slot[hat]) == $item[Reinforced Beaded Headband])
		{
			abort("Trying to nuns trick and might be wearing the Hippy Outfit");
		}

		switch(copyAvailable)
		{
		case 1:
			rainManSummon("dirty thieving brigand", false, false);
			set_property("cc_nunsTrickGland", "done");
			break;
		case 2:		//Rain-doh box
			break;
		case 3:
			handle4dCamera();
			break;
		case 4:
			handleIceSculpture();
			break;
		default:
			abort("Trying nuns trick but unhandled copy case (" + copyAvailable + ")");
			break;
		}
	}
	else
	{
		if(trickMode)
		{
			if((get_property("_cameraUsed").to_boolean() != true) && (item_amount($item[shaking 4-d camera]) == 0))
			{
				pullXWhenHaveY($item[4-d camera], 1, 0);
			}
			outfit("war hippy fatigues");
			if(get_property("cc_nunsTrickCount").to_int() == 0)
			{
				visit_url("bigisland.php?place=nunnery");
			}
		}
		else
		{
			warOutfit();
		}

		int lastMeat = get_property("currentNunneryMeat").to_int();
		int myLastMeat = my_meat();
		print("Meat drop to start: " + meat_drop_modifier(), "blue");
		ccAdv(1, $location[The Themthar Hills]);
		if(last_monster() != $monster[dirty thieving brigand])
		{
			return true;
		}
		if(get_property("lastEncounter") == "Don't Be Alarmed, Now")
		{
			return true;
		}
		int curMeat = get_property("currentNunneryMeat").to_int();
		if(lastMeat == curMeat)
		{
			int diffMeat = my_meat() - myLastMeat;
			set_property("currentNunneryMeat", diffMeat);
		}

		int advs = get_property("cc_nunsTrickCount").to_int() + 1;
		set_property("cc_nunsTrickCount", advs);

		int diffMeat = curMeat - lastMeat;
		int needMeat = 100000 - curMeat;
		int average = curMeat / advs;
		print("Cur Meat: " + curMeat + " Average: " + average, "blue");

		diffMeat = diffMeat * 1.2;
		average = average * 1.2;
		if(trickMode && ((needMeat < diffMeat) || (needMeat < average)))
		{
			set_property("cc_nunsTrickReady", "yes");
			print("Attempting nuns trick, beep boop!! No more auto-aborting!");
		}
		if((item_amount($item[stone wool]) > 0) && (get_property("cc_nunsTrickCount").to_int() > 2) && !get_property("_templeHiddenPower").to_boolean())
		{
			use(1, $item[stone wool]);
			put_closet(item_amount($item[stone wool]), $item[stone wool]);
			ccAdv(1, $location[The Hidden Temple]);
		}
	}
	return true;
}

boolean dealWithMilkOfMagnesium(boolean useAdv)
{
	if(item_amount($item[milk of magnesium]) > 0)
	{
		return true;
	}

	ovenHandle();
	if((item_amount($item[glass of goat\'s milk]) > 0) && have_skill($skill[Advanced Saucecrafting]))
	{
		if(useAdv)
		{
			cli_execute("make milk of magnesium");
		}
		else if(have_skill($skill[Rapid Prototyping]) && (get_property("_rapidPrototypingUsed").to_int() < 5) && have_skill($skill[Rapid Prototyping]))
		{
			cli_execute("make milk of magnesium");
		}
	}
	pullXWhenHaveY($item[Milk of Magnesium], 1, 0);
	return true;
}

int handlePulls(int day)
{
	if(item_amount($item[Carton of Astral Energy Drinks]) > 0)
	{
		use(1, $item[carton of astral energy drinks]);
	}
	if(item_amount($item[Astral Six-Pack]) > 0)
	{
		use(1, $item[Astral Six-Pack]);
	}
	if(item_amount($item[Astral Hot Dog Dinner]) > 0)
	{
		use(1, $item[Astral Hot Dog Dinner]);
	}

	initializeSettings();

	if(in_hardcore())
	{
		return 0;
	}

	if(day == 1)
	{
		set_property("lightsOutAutomation", "1");
		# Do starting pulls:
		if((pulls_remaining() != 20) && !in_hardcore() && (my_turncount() > 0))
		{
			print("I assume you've handled your pulls yourself... who knows.");
			return 0;
		}

		if((storage_amount($item[can of rain-doh]) > 0) && (pullXWhenHaveY($item[can of Rain-doh], 1, 0)))
		{
			if(item_amount($item[Can of Rain-doh]) > 0)
			{
				use(1, $item[can of Rain-doh]);
				put_closet(1, $item[empty rain-doh can]);
			}
		}
		if(storage_amount($item[buddy bjorn]) > 0)
		{
			pullXWhenHaveY($item[buddy bjorn], 1, 0);
		}
		if(storage_amount($item[Xiblaxian Stealth Cowl]) > 0)
		{
			pullXWhenHaveY($item[xiblaxian stealth cowl], 1, 0);
		}
		pullXWhenHaveY($item[pantsgiving], 1, 0);
		pullXWhenHaveY($item[spooky-gro fertilizer], 1, 0);

		if(!have_familiar($familiar[Fist Turkey]))
		{
			pullXWhenHaveY($item[crystal skeleton vodka], 2, 0);
		}

#		pullXWhenHaveY(whatHiMein(), 2, 0);
#		pullXWhenHaveY($item[digital key lime pie], 1, 0);

		if((my_path() == "Picky") || get_property("cc_100familiar").to_boolean())
		{
			pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
			pullXWhenHaveY($item[Sneaky Pete\'s Key Lime Pie], 1, 0);
			pullXWhenHaveY($item[Jarlsberg\'s Key Lime Pie], 1, 0);
		}
		else if(my_path() == "Standard")
		{
			pullXWhenHaveY(whatHiMein(), 3, 0);
		}

		pullXWhenHaveY($item[over-the-shoulder folder holder], 1, 0);
		if((my_primestat() == $stat[Muscle]) && (my_path() != "Heavy Rains"))
		{
			pullXWhenHaveY($item[Fake Washboard], 1, 0);
			if(item_amount($item[Fake Washboard]) == 0)
			{
				pullXWhenHaveY($item[numberwang], 1, 0);
			}
		}
		else
		{
			pullXWhenHaveY($item[numberwang], 1, 0);
		}
#		pullXWhenHaveY($item[milk of magnesium], 1, 0);
		pullXWhenHaveY($item[stuffed shoulder parrot], 1, 0);
		pullXWhenHaveY($item[eyepatch], 1, 0);
		pullXWhenHaveY($item[swashbuckling pants], 1, 0);
		#pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
#		pullXWhenHaveY($item[thor\'s pliers], 1, 0);
		#pullXWhenHaveY($item[the big book of pirate insults], 1, 0);
#		pullXWhenHaveY($item[mojo filter], 1, 0);
		#pullXWhenHaveY($item[camp scout backpack], 1, 0);
		#pullXWhenHaveY($item[caveman dan\'s favorite rock], 1, 0);

		if(my_path() == "Picky")
		{
			pullXWhenHaveY($item[gumshoes], 1, 0);
		}
		pullXWhenHaveY($item[hand in glove], 1, 0);

		if(my_path() != "Heavy Rains")
		{
			pullXWhenHaveY($item[snow suit], 1, 0);
		}

		if(get_property("cc_dickstab").to_boolean())
		{
			pullXWhenHaveY($item[Shore Inc. Ship Trip Scrip], 3, 0);
		}

		if((!have_familiar($familiar[Grim Brother])) && (my_class() != $class[Ed]))
		{
			pullXWhenHaveY($item[Unconscious Collective Dream Jar], 1, 0);
			chew(1, $item[Unconscious Collective Dream Jar]);
		}
	}
	return pulls_remaining();
}

boolean fortuneCookieEvent()
{
	if((my_path() == "Heavy Rains") && (get_property("cc_orchard") == "finished"))
	{
		cli_execute("counters");
		if(get_counters("Fortune Cookie", 0, 200) != "")
		{
			cli_execute("counters clear");
			print("We don't care about the semirares anymore, we are past the orchard. Cancelling.");
		}
		return false;
	}
	if((my_class() == $class[Ed]) && ((get_property("cc_orchard") == "finished") || (get_property("cc_semirare").to_int() >= 2)))
	{
		if(get_counters("Fortune Cookie", 0, 200) != "")
		{
			cli_execute("counters clear");
			print("We don't care about the semirares anymore, we are past the orchard. Cancelling.");
		}
		return false;
	}

	if(get_counters("Fortune Cookie", 0, 0) == "Fortune Cookie")
	{
		print("Semi rare time!", "blue");
		cli_execute("counters");
		cli_execute("counters clear");
		print("Removed all the counters, can we just remove the cookie?");
		if((get_property("cc_semirare") == "") && (get_property("cc_spookysapling") == "finished"))
		{
			ccAdv(1, $location[The Hidden Temple]);
			if(item_amount($item[stone wool]) > 0)
			{
				set_property("cc_semirare", "1");
				set_property("cc_semisub", "wool");
			}
		}
		else if((get_property("cc_semirare") == "1") && (get_property("cc_castleground") == "finished") && (get_property("cc_nuns") != "done"))
		{
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
			if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
			{
				set_property("cc_castleground", "done");
				set_property("cc_semisub", "inhaler");
				set_property("cc_semirare", "2");
			}
		}
		else if(get_property("cc_semisub") != "limerick")
		{
			ccAdv(1, $location[The Limerick Dungeon]);
			set_property("cc_semisub", "limerick");
		}
		else if(get_property("cc_semisub") != "pantry")
		{
			ccAdv(1, $location[The Haunted Pantry]);
			set_property("cc_semisub", "pantry");
		}
		else
		{
			ccAdv(1, $location[The Sleazy Back Alley]);
			set_property("cc_semisub", "alley");
		}
		return true;
	}
	return false;
}


void initializeDay(int day)
{
	if(get_property("kingLiberated").to_boolean())
	{
		return;
	}

	cli_execute("ccs null");
	set_property("battleAction", "custom combat script");
	if((item_amount($item[cursed microwave]) >= 1) && (get_property("_cursedMicrowaveUsed") == "false"))
	{
		use(1, $item[cursed microwave]);
	}
	if((item_amount($item[cursed pony keg]) >= 1) && (get_property("_cursedKegUsed") == "false"))
	{
		use(1, $item[cursed pony keg]);
	}
	if(storage_amount($item[Talking Spade]) > 0)
	{
		pullXWhenHaveY($item[Talking Spade], 1, 0);
	}

	if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
	{
		set_property("cc_castleground", "done");
		set_property("cc_semisub", "inhaler");
	}

	if(item_amount($item[GameInformPowerDailyPro Magazine]) > 0)
	{
#		use(1, $item[GameInformPowerDailyPro Magazine]);
	}

	chateaumantegna_useDesk();
	ed_initializeDay(day);

	if(day == 1)
	{
		if(get_property("cc_day1_init") != "finished")
		{
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

			hr_initializeDay(day);

			buyUpTo(1, $item[toy accordion]);

			while((item_amount($item[turtle totem]) == 0) || (item_amount($item[saucepan]) == 0))
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}

			makeStartingSmiths();

			handleFamiliar($familiar[Angry Jung Man]);
			equipBaseline();
			if(equipped_item($slot[familiar]) != $item[none])
			{
				lock_familiar_equipment(true);
			}
			handleBjornify($familiar[none]);
			handleBjornify($familiar[El Vibrato Megadrone]);

			visit_url("guild.php?place=challenge");

			if(get_property("cc_breakstone").to_boolean())
			{
				visit_url("campground.php?action=stone&smashstone=Yep.&pwd&confirm=on", true);
				set_property("cc_breakstone", false);
			}
			set_property("cc_day1_init", "finished");
		}

		if(get_property("cc_day1_dna") != "finished")
		{
			if(elementalPlanes_access($element[sleaze]) && (item_amount($item[DNA Extraction Syringe]) > 0))
			{
				ccAdv(1, $location[Sloppy Seconds Diner]);
				ccAdv(1, $location[Sloppy Seconds Diner]);
				cli_execute("camp dnainject");
			}
			set_property("cc_day1_dna", "finished");
		}

		if((my_path() == "Heavy Rains") && (get_property("cc_day1_desk") != "finished") && (my_rain() > 50))
		{
			if(my_hp() < my_maxhp())
			{
				cli_execute("hottub");
			}
			rainManSummon("writing desk", true, true);
			if((my_hp() * 2) < my_maxhp())
			{
				cli_execute("hottub");
			}
			hr_dnaPotions();
			set_property("cc_day1_desk", "finished");
		}
		if(get_property("lastCouncilVisit").to_int() < my_level())
		{
			cli_execute("counters");
			council();
		}
	}
	else if(day == 2)
	{
		equipBaseline();
		fortuneCookieEvent();

		if(get_property("cc_day2_init") == "")
		{
			if(item_amount($item[tonic djinn]) > 0)
			{
				set_property("choiceAdventure778", "2");
				use(1, $item[tonic djinn]);
			}
			if(item_amount($item[gym membership card]) > 0)
			{
				use(1, $item[gym membership card]);
			}

			hr_initializeDay(day);

			if(!in_hardcore())
			{
				pulverizeThing($item[hairpiece on fire]);
				pulverizeThing($item[vicar\'s tutu]);
			}
			hermit(10, $item[ten-leaf clover]);
			if(item_amount($item[antique accordion]) == 0)
			{
				buyUpTo(1, $item[antique accordion]);
			}
			if(have_skill($skill[summon smithsness]))
			{
				use_skill(3, $skill[summon smithsness]);
			}

			if(item_amount($item[handful of smithereens]) >= 2)
			{
				buy(2, $item[Ben-Gal&trade; Balm]);
				cli_execute("make 2 louder than bomb");
			}

			if(get_property("cc_dickstab").to_boolean())
			{
				pullXWhenHaveY($item[frost flower], 1, 0);
			}
			pullXWhenHaveY($item[hand in glove], 1, 0);
			pullXWhenHaveY($item[wet stew], 1, 0);
			pullXWhenHaveY($item[blackberry galoshes], 1, 0);
			pullXWhenHaveY($item[mojo filter], 1, 0);

			if(!get_property("cc_useCubeling").to_boolean() && (towerKeyCount() == 0))
			{
				pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
				pullXWhenHaveY($item[Sneaky Pete\'s Key Lime Pie], 1, 0);
				pullXWhenHaveY($item[Jarlsberg\'s Key Lime Pie], 1, 0);
			}
			else
			{
				pullXWhenHaveY(whatHiMein(), 3, 0);
			}

#			if((item_amount($item[glass of goat\'s milk]) == 0) || (my_path() == "Picky"))
#			{
#				pullXWhenHaveY($item[milk of magnesium], 1, 0);
#			}

			set_property("cc_day2_init", "finished");
		}
		if(chateaumantegna_havePainting() && (my_class() != $class[Ed]))
		{
			handleFamiliar($familiar[Reanimated Reanimator]);
			if(chateaumantegna_usePainting())
			{
				ccAdv(1, $location[Noob Cave]);
			}
			handleFamiliar($familiar[Angry Jung Man]);
		}
	}
	else if(day == 3)
	{
		if(get_property("cc_day3_init") == "")
		{
			hermit(10, $item[ten-leaf clover]);

			picky_pulls();
			standard_pulls();

			set_property("cc_day3_init", "finished");
		}
	}
	if(day >= 2)
	{
		if(get_property("cc_guildmeat") == "")
		{
			if(my_class() == $class[seal clubber])
			{
				visit_url("guild.php?place=scg");
				visit_url("guild.php?place=scg");
			}
			if(my_class() == $class[turtle tamer])
			{
				visit_url("guild.php?place=scg");
				visit_url("guild.php?place=scg");
			}
			set_property("cc_guildmeat", "got");
			ovenHandle();
		}
	}
	if(get_property("kingLiberated") == "false")
	{
		cli_execute("garden pick");
	}
	string campground = visit_url("campground.php");
	if(contains_text(campground, "beergarden7.gif"))
	{
		cli_execute("garden pick");
	}
	if(contains_text(campground, "wintergarden3.gif"))
	{
		cli_execute("garden pick");
	}
}



void doBedtime()
{
	print("Starting bedtime: Pulls Left: " + pulls_remaining(), "blue");

	if(get_property("lastEncounter") == "Like a Bat Into Hell")
	{
		abort("Our last encounter was UNDYING and we ended up trying to bedtime and failed.");
	}

	process_kmail("cc_deleteMail");

	if(my_adventures() > 4)
	{
		if(my_inebriety() <= inebriety_limit())
		{
			return;
		}
	}
	if(my_fullness() < fullness_limit())
	{
		return;
	}
	if(my_inebriety() < inebriety_limit())
	{
		return;
	}
	int spleenlimit = spleen_limit();
	if(get_property("cc_100familiar").to_boolean())
	{
		spleenlimit -= 3;
	}
	if((my_spleen_use() < spleenlimit) && !in_hardcore())
	{
		return;
	}

	if(get_property("cc_priorCoinmasters").to_boolean())
	{
		set_property("cc_priorCoinmasters", false);
		set_property("autoSatisfyWithCoinmasters", false);
	}

	if(get_property("cc_priorCharpaneMode").to_int() == 1)
	{
		print("Resuming Compact Character Mode.");
		set_property("cc_priorCharpaneMode", 0);
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=1&ajax=0", true);
	}

	if(get_property("cc_priorXiblaxianMode").to_int() == 1)
	{
		set_property("cc_priorXiblaxianMode", 0);
		setvar("chit.helpers.xiblaxian", true);
		cli_execute("zlib chit.helpers.xiblaxian = true");
	}

	if(my_class() == $class[Ed])
	{
		if(get_property("hpAutoRecoveryItems") == "linen bandages")
		{
			set_property("hpAutoRecoveryItems", get_property("cc_hpAutoRecoveryItems"));
			set_property("hpAutoRecovery", get_property("cc_hpAutoRecovery"));
			set_property("hpAutoRecoveryTarget", get_property("cc_hpAutoRecoveryTarget"));
			set_property("cc_hpAutoRecoveryItems", "");
			set_property("cc_hpAutoRecovery", 0.0);
			set_property("cc_hpAutoRecoveryTarget", 0.0);
		}
	}


	if(my_class() == $class[seal clubber])
	{
		int oldSeals = get_property("_sealsSummoned").to_int();
		while((get_property("_sealsSummoned").to_int() < 5) && (!get_property("kingLiberated").to_boolean()) && (my_meat() > 4500))
		{
			if(my_daycount() == 1)
			{
				cli_execute("make figurine of an ancient seal");
	#			buyUpTo(1, $item[figurine of an ancient seal]);
				buyUpTo(3, $item[seal-blubber candle]);
				handleSealAncient();
			}
			else
			{
				buyUpTo(1, $item[figurine of an armored seal]);
				buyUpTo(10, $item[seal-blubber candle]);
				handleSealArmored();
			}
			int newSeals = get_property("_sealsSummoned").to_int();
			if(newSeals == oldSeals)
			{
				abort("Unable to summon seals.");
			}
			oldSeals = newSeals;
		}
	}

	if((my_inebriety() <= inebriety_limit()) && (my_rain() >= 50) && (my_adventures() >= 1))
	{
		if(my_daycount() == 1)
		{
			if(item_amount($item[Rain-Doh Indigo Cup]) > 0)
			{
				print("Copies left: " + (5 - get_property("_raindohCopiesMade").to_int()), "olive");
			}
			if(!in_hardcore())
			{
				print("Pulls remaining: " + pulls_remaining(), "olive");
			}
			if(item_amount($item[beer helmet]) == 0)
			{
				print("Please consider an orcish frat boy spy (You want Frat Warrior Fatigues).", "blue");
				if((have_effect($effect[Everything Looks Yellow]) == 0) && (my_lightning() >= 5))
				{
					print("Make sure to Ball Lightning the spy!!", "red");
				}
			}
			else
			{
				print("If you have the Frat Warrior Fatigues, rain man an Astronomer? Skinflute?", "blue");
			}
		}
		abort("You have a rain man to cast, please do so before overdrinking and run me again.");
	}

	hermit(10, $item[ten-leaf clover]);

	if((friars_available()) && (!get_property("friarsBlessingReceived").to_boolean()))
	{
		cli_execute("friars familiar");
	}
	if((my_hp() < (0.9 * my_maxhp())) && (get_property("_hotTubSoaks").to_int() < 5))
	{
		cli_execute("hottub");
	}

	if(!get_property("_mayoTankSoaked").to_boolean())
	{
		visit_url("shop.php?action=bacta&whichshop=mayoclinic");
	}

	//	Also use "nunsVisits", as long as they were won by the Frat (sidequestNunsCompleted="fratboy").
	ed_doResting();
	skill libram = preferredLibram();
	if(libram != $skill[none])
	{
		while((get_property("timesRested").to_int() < total_free_rests()) && (mp_cost(libram) <= my_maxmp()))
		{
			doRest();
			while(my_mp() > mp_cost(libram))
			{
				use_skill(1, libram);
			}
		}
	}

	if(is_unrestricted("Clan Pool Table"))
	{
		visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
		visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
		visit_url("clan_viplounge.php?preaction=poolgame&stance=3");
	}
	if(is_unrestricted("Colorful Plastic Ball"))
	{
		cli_execute("ballpit");
	}
	if(get_property("telescopeUpgrades").to_int() > 0)
	{
		if(get_property("telescopeLookedHigh") == "false")
		{
			cli_execute("telescope high");
		}
	}

	if(!possessEquipment($item[Vicar\'s Tutu]) && (my_daycount() == 1) && (item_amount($item[lump of Brituminous coal]) > 0))
	{
		if(item_amount($item[frilly skirt]) < 1)
		{
			buyUpTo(1, $item[frilly skirt]);
		}
		craft("smith", 1, $item[lump of Brituminous coal], $item[frilly skirt]);
	}

	if((my_daycount() == 1) && ((item_amount($item[thor\'s pliers]) == 1) || (equipped_item($slot[weapon]) == $item[Thor\'s Pliers]) || (equipped_item($slot[off-hand]) == $item[Thor\'s Pliers]) || (get_property("_rapidPrototypingUsed").to_int() < 5)) && have_skill($skill[Rapid Prototyping]))
	{
		item oreGoal = to_item(get_property("trapperOre"));
		int need = 1;
		if(oreGoal == $item[chrome ore])
		{
			need = 4;
		}
		if((item_amount($item[chrome ore]) >= need) && !possessEquipment($item[chrome sword]))
		{
			cli_execute("make chrome sword");
		}
	}

	equipRollover();
	hr_doBedtime();

	while((my_daycount() == 1) && (item_amount($item[resolution: be more adventurous]) > 0) && (get_property("_resolutionAdv").to_int() < 10))
	{
		use(1, $item[resolution: be more adventurous]);
	}

	if(my_daycount() <= 2)
	{
		// Check for rapid prototyping
		while((get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious reagent]) > 0) && (item_amount($item[cranberries]) > 0) && (item_amount($item[cranberry cordial]) < 2) && have_skill($skill[Advanced Saucecrafting]) && have_skill($skill[Rapid Prototyping]))
		{
			cli_execute("make cranberry cordial");
		}
		put_closet(item_amount($item[cranberries]), $item[cranberries]);
		while((get_property("_rapidPrototypingUsed").to_int() < 5) && (item_amount($item[Scrumptious reagent]) > 0) && (item_amount($item[glass of goat\'s milk]) > 0) && (item_amount($item[milk of magnesium]) < 2) && have_skill($skill[Advanced Saucecrafting]) && have_skill($skill[Rapid Prototyping]))
		{
			cli_execute("make milk of magnesium");
		}
	}

	//We can also use int[item] get_campground()
	int lastDNA = get_property("_dnaPotionsMade").to_int();
	while((get_property("_dnaPotionsMade") != "3") && (get_property("dnaSyringe") != ""))
	{
		cli_execute("camp dnapotion");
		int thisDNA = get_property("_dnaPotionsMade").to_int();
		if(thisDNA == lastDNA)
		{
			break;
		}
	}

	if((get_property("_grimBuff") == "false") && have_familiar($familiar[Grim Brother]))
	{
		visit_url("choice.php?pwd=&whichchoice=835&option=1", true);
	}

	if(get_property("cc_clanstuff").to_int() < my_daycount())
	{
		if(!get_property("_olympicSwimmingPool").to_boolean())
		{
			cli_execute("swim noncombat");
		}
		if(!get_property("_olympicSwimmingPoolItemFound").to_boolean())
		{
			cli_execute("swim item");
		}
		if(get_property("_klawSummons").to_int() == 0)
		{
			cli_execute("clan_rumpus.php?action=click&spot=3&furni=3");
			cli_execute("clan_rumpus.php?action=click&spot=3&furni=3");
			cli_execute("clan_rumpus.php?action=click&spot=3&furni=3");
		}
		if(!get_property("_lookingGlass").to_boolean())
		{
			cli_execute("clan_viplounge.php?action=lookingglass");
		}
		if(get_property("_deluxeKlawSummons").to_int() == 0)
		{
			cli_execute("clan_viplounge.php?action=klaw");
			cli_execute("clan_viplounge.php?action=klaw");
			cli_execute("clan_viplounge.php?action=klaw");
		}
		if(!get_property("_aprilShower").to_boolean())
		{
			cli_execute("shower ice");
		}
		if(!get_property("_crimboTree").to_boolean())
		{
			cli_execute("crimbotree get");
		}
		set_property("cc_clanstuff", ""+my_daycount());
	}

	if((get_property("sidequestOrchardCompleted") != "none") && !get_property("_hippyMeatCollected").to_boolean())
	{
		visit_url("shop.php?whichshop=hippy");
	}

	if((get_property("sidequestArenaCompleted") != "none") && !get_property("concertVisited").to_boolean())
	{
		cli_execute("concert 2");
	}
	if(get_property("kingLiberated").to_boolean())
	{
		if((item_amount($item[The Legendary Beat]) > 0) && !get_property("_legendaryBeat").to_boolean())
		{
			use(1, $item[The Legendary Beat]);
		}
		if(have_skill($skill[Summon Clip Art]) && get_property("_clipartSummons").to_int() == 0)
		{
			cli_execute("make unbearable light");
		}
		if(have_skill($skill[Summon Clip Art]) && get_property("_clipartSummons").to_int() == 1)
		{
			cli_execute("make cold-filtered water");
		}
		if(have_skill($skill[Summon Clip Art]) && get_property("_clipartSummons").to_int() == 2)
		{
			cli_execute("make bucket of wine");
		}
		if((item_amount($item[Handmade Hobby Horse]) > 0) && !get_property("_hobbyHorseUsed").to_boolean())
		{
			use(1, $item[Handmade Hobby Horse]);
		}
		if((item_amount($item[ball-in-a-cup]) > 0) && !get_property("_ballInACupUsed").to_boolean())
		{
			use(1, $item[ball-in-a-cup]);
		}
		if((item_amount($item[set of jacks]) > 0) && !get_property("_setOfJacksUsed").to_boolean())
		{
			use(1, $item[set of jacks]);
		}
	}

	if(my_daycount() == 1)
	{
		if((pulls_remaining() > 1) && !possessEquipment($item[antique machete]))
		{
			if(item_amount($item[antique machete]) == 0)
			{
				pullXWhenHaveY($item[antique machete], 1, 0);
			}
		}
		if((pulls_remaining() > 1) && (get_property("cc_palindome") != "finished") )
		{
			if(item_amount($item[wet stew]) == 0)
			{
				pullXWhenHaveY($item[wet stew], 1, 0);
			}
		}
	}

	if((my_daycount() % 5) == 1)
	{
		visit_url("place.php?whichplace=desertbeach&action=db_nukehouse");
	}

	if(item_amount($item[rain-doh indigo cup]) > 0)
	{
		print("Copies left: " + (5 - get_property("_raindohCopiesMade").to_int()), "olive");
	}
	if(!in_hardcore())
	{
		print("Pulls remaining: " + pulls_remaining(), "olive");
	}
	if(have_skill($skill[Inigo\'s Incantation of Inspiration]))
	{
		int craftingLeft = 5 - get_property("_inigosCasts").to_int();
		print("Free Inigo\'s craftings left: " + craftingLeft, "blue");
	}
	if(item_amount($item[Thor\'s Pliers]) > 0)
	{
		int craftingLeft = 10 - get_property("_thorsPliersCrafting").to_int();
		print("Free Thor's Pliers craftings left: " + craftingLeft, "blue");
	}
	if(have_skill($skill[Rapid Prototyping]))
	{
		int craftingLeft = 5 - get_property("_rapidPrototypingUsed").to_int();
		print("Free Rapid Prototyping craftings left: " + craftingLeft, "blue");
	}

	if(get_property("libramSummons").to_int() > 0)
	{
		print("Total Libram Summoms: " + get_property("libramSummons"), "blue");
	}

	int smiles = (5 * (item_amount($item[Golden Mr. Accessory]) + storage_amount($item[Golden Mr. Accessory]) + closet_amount($item[Golden Mr. Accessory]))) - get_property("_smilesOfMrA").to_int();
	if(smiles > 0)
	{
		print("You have " + smiles + " smiles of Mr. A remaining.", "blue");
	}

	if((item_amount($item[CSA Fire-Starting Kit]) > 0) && (!get_property("_fireStartingKitUsed").to_boolean()))
	{
		print("Still have a CSA Fire-Starting Kit you can use!", "blue");
	}
	if((get_property("spookyAirportAlways").to_boolean()) && (my_class() != $class[Ed]))
	{
		visit_url("place.php?whichplace=airport_spooky_bunker&action=si_controlpanel");
		visit_url("choice.php?pwd=&whichchoice=986&option=8",true);
		visit_url("choice.php?pwd=&whichchoice=986&option=10",true);
	}

	if(my_daycount() == 2)
	{
		elementalPlanes_takeJob($element[spooky]);
		elementalPlanes_takeJob($element[stench]);
	}

	if((get_property("cc_dickstab").to_boolean()) && chateaumantegna_available() && (my_daycount() == 1))
	{
		boolean[item] furniture = chateaumantegna_decorations();
		if(!furniture[$item[Artificial Skylight]])
		{
			chateaumantegna_buyStuff($item[Artificial Skylight]);
		}
	}

	if(my_inebriety() <= inebriety_limit())
	{
		print("Goodnight done, please make sure to handle your overdrinking, then you can run me again.", "blue");
		if((my_inebriety() <= inebriety_limit()) && (my_rain() >= 50) && (my_adventures() >= 1))
		{
			if(item_amount($item[beer helmet]) == 0)
			{
				print("Please consider an orcish frat boy spy (You want Frat Warrior Fatigues).", "blue");
				if((have_effect($effect[Everything Looks Yellow]) == 0) && (my_lightning() >= 5))
				{
					print("Make sure to Ball Lightning the spy!!", "red");
				}
			}
			else
			{
				print("If you have the Frat Warrior Fatigues, rain man an Astronomer? Skinflute?", "blue");
			}
			abort("You have a rain man to cast, please do so before overdrinking and then run me again.");
		}
		if((item_amount($item[ye olde meade]) > 0) && (my_daycount() == 1))
		{
			print("You can drink a Ye Olde Meade as your nightcap! Yay!", "blue");
		}

		abort("You need to overdrink and then run me again. Beep.");
	}
	else
	{
		if(get_property("kingLiberated") == "false")
		{
			print(get_property("cc_banishes_day" + my_daycount()));
			print(get_property("cc_yellowRay_day" + my_daycount()));
			pullsNeeded("evaluate");
			if((get_property("_photocopyUsed") == "false") && (is_unrestricted("Deluxe Fax Machine")) && (my_adventures() > 0))
			{
				print("You may have a fax that you can use. Check it out!", "blue");
			}
			if((pulls_remaining() > 0) && (my_daycount() == 1))
			{
				string consider = "";
				boolean[item] cList = $items[antique machete, wet stew, blackberry galoshes, drum machine, killing jar];
				foreach it in cList
				{
					if(item_amount(it) == 0)
					{
						if(consider == "")
						{
							consider = consider + it;
						}
						else
						{
							consider = consider + ", " + it;
						}
					}
				}
				print("You still have pulls, consider: " + consider + "?", "red");
			}
		}

		if(is_unrestricted("Deck of Every Card") && (item_amount($item[Deck of Every Card]) > 0) && (get_property("_deckCardsDrawn").to_int() < 15))
		{
			print("You have a Deck of Every Card and " + (15 - get_property("_deckCardsDrawn").to_int()) + " draws remaining!", "blue");
		}

		print("You are probably done for today, beep.", "blue");
	}
}

void handleInitFamiliar()
{
	if(familiar_weight(my_familiar()) == 20)
	{
		if((my_familiar() == $familiar[Angry Jung Man]) || (my_familiar() == $familiar[Adventurous Spelunker]))
		{
			if(have_familiar($familiar[Xiblaxian Holo-Companion]))
			{
				handleFamiliar($familiar[Xiblaxian Holo-Companion]);
			}
			else if(have_familiar($familiar[Oily Woim]))
			{
				handleFamiliar($familiar[Oily Woim]);
			}
		}
	}
}


boolean questOverride()
{
	// At the start of an ascension, get_campground() displays the wrong info.
	// Visiting the campground doesn\'t work.... grrr...
	//	visit_url("campground.php");

#	if(!get_property("cc_haveoven").to_boolean())
#	{
#		if(get_campground() contains $item[Dramatic&trade; range])
#		{
#			set_property("cc_haveoven", true);
#		}
#	}
	if((get_property("questL02Larva") == "finished") && (get_property("cc_mosquito") != "finished"))
	{
		print("Found completed Mosquito Larva (2)");
		set_property("cc_mosquito", "finished");
	}
	if((get_property("questL03Rat") == "finished") && (get_property("cc_tavern") != "finished"))
	{
		print("Found completed Tavern (3)");
		set_property("cc_tavern", "finished");
	}
	if((get_property("questL04Bat") == "finished") && (get_property("cc_bat") != "finished"))
	{
		print("Found completed Bat Cave (4)");
		set_property("cc_bat", "finished");
	}
	if((get_property("questL05Goblin") == "finished") && (get_property("cc_goblinking") != "finished"))
	{
		print("Found completed Goblin King (5)");
		set_property("cc_day1_cobb", "finished");
		set_property("cc_goblinking", "finished");
	}
	if((get_property("questL06Friar") == "finished") && (get_property("cc_friars") != "done") && (get_property("cc_friars") != "finished"))
	{
		print("Found completed Friars (6)");
		set_property("cc_friars", "done");
	}
	if((get_property("questL07Cyrptic") == "finished") && (get_property("cc_crypt") != "finished"))
	{
		print("Found completed Cyrpt (7)");
		set_property("cc_crypt", "finished");
	}
	if((get_property("questL08Trapper") == "step2") && (get_property("cc_trapper") != "yeti"))
	{
		print("Found Trapper partially completed (8: Ores/Cheese)");
		set_property("cc_trapper", "yeti");
	}
	if((get_property("questL08Trapper") == "finished") && (get_property("cc_trapper") != "finished"))
	{
		print("Found completed Trapper (8)");
		set_property("cc_trapper", "finished");
	}
	if((get_property("questL09Topping") == "finished") && (get_property("cc_highlandlord") != "finished"))
	{
		print("Found completed Highland Lord (9)");
		set_property("cc_highlandlord", "finished");
	}
	if((get_property("questL10Garbage") == "finished") && (get_property("cc_castletop") != "finished"))
	{
		print("Found completed Castle in the Clouds in the Sky with some Pie (10)");
		set_property("cc_castletop", "finished");
		set_property("cc_castleground", "finished");
		set_property("cc_castlebasement", "finished");
		set_property("cc_airship", "finished");
		set_property("cc_bean", "plant");
	}
	if((internalQuestStatus("questL10Garbage") >= 9) && (get_property("cc_castleground") != "finished") && (get_property("cc_castleground") != "done"))
	{
		print("Found completed Castle Ground Floor (10)");
		set_property("cc_castleground", "done");
	}
	if((internalQuestStatus("questL10Garbage") >= 8) && (get_property("cc_castlebasement") != "finished"))
	{
		print("Found completed Castle Basement (10)");
		set_property("cc_castlebasement", "finished");
	}
	if((internalQuestStatus("questL10Garbage") >= 7) && (get_property("cc_airship") != "finished"))
	{
		print("Found completed Airship (10)");
		set_property("cc_airship", "finished");
	}
	if((internalQuestStatus("questL10Garbage") >= 2) && (get_property("cc_bean") != "plant"))
	{
		print("Found completed Planted Beanstalk (10)");
		set_property("cc_bean", "plant");
	}

	if((internalQuestStatus("questL11Manor") >= 11) && (get_property("cc_ballroom") != "finished"))
	{
		print("Found completed Spookyraven Manor (11)");
		set_property("cc_ballroom", "finished");
		set_property("cc_winebomb", "finished");
	}

	if((internalQuestStatus("questL11Worship") >= 3) && (get_property("cc_hiddenunlock") != "finished"))
	{
		print("Found unlocked Hidden City (11)");
		set_property("cc_hiddenunlock", "finished");
	}

	if((get_property("questL11Black") == "finished") && (get_property("cc_blackmap") != "finished"))
	{
		print("Found completed Black Market (11)");
		set_property("cc_blackmap", "finished");
	}
	if((get_property("questL11Palindome") == "finished") && (get_property("cc_palindome") != "finished"))
	{
		print("Found completed Palindome (11)");
		set_property("cc_palindome", "finished");
	}


	if((get_property("questL11Business") == "finished") && (get_property("cc_hiddenoffice") != "finished"))
	{
		print("Found completed Hidden Office Building (11)");
		set_property("cc_hiddenoffice", "finished");
	}
	if((get_property("questL11Curses") == "finished") && (get_property("cc_hiddenapartment") != "finished"))
	{
		print("Found completed Hidden Apartment Building (11)");
		set_property("cc_hiddenapartment", "finished");
	}
	if((get_property("questL11Spare") == "finished") && (get_property("cc_hiddenbowling") != "finished"))
	{
		print("Found completed Hidden Bowling Alley (11)");
		set_property("cc_hiddenbowling", "finished");
	}
	if((get_property("questL11Doctor") == "finished") && (get_property("cc_hiddenhospital") != "finished"))
	{
		print("Found completed Hidden Hopickle (11)");
		set_property("cc_hiddenhospital", "finished");
	}
	if((get_property("questL11Worship") == "finished") && (get_property("cc_hiddencity") != "finished"))
	{
		print("Found completed Hidden City (11)");
		set_property("cc_hiddencity", "finished");
	}


	if(get_property("sidequestOrchardCompleted") != "none")
	{
		if(get_property("cc_nunsTrickGland") != "done")
		{
			print("Found completed Orchard (Nuns Trick - Gland) (12)");
			set_property("cc_nunsTrickGland", "done");
		}
		if(get_property("cc_orchard") != "finished")
		{
			print("Found completed Orchard (12)");
			set_property("cc_orchard", "finished");
		}
		return false;
	}

	if((get_property("sidequestLighthouseCompleted") != "none") && (get_property("cc_sonata") != "finished"))
	{
		print("Found completed Lighthouse (12)");
		set_property("cc_sonata", "finished");
	}
	if((get_property("sidequestJunkyardCompleted") != "none") && (get_property("cc_gremlins") != "finished"))
	{
		print("Found completed Junkyard (12)");
		set_property("cc_gremlins", "finished");
	}
	if((get_property("sidequestOrchardCompleted") != "none") && (get_property("cc_orchard") != "finished"))
	{
		print("Found completed Orchard (12)");
		set_property("cc_orchard", "finished");
	}


	if((get_property("sidequestNunsCompleted") != "none") && (get_property("cc_nuns") != "done") && (get_property("cc_nuns") != "finished"))
	{
		print("Found completed Nuns (12)");
		set_property("cc_nuns", "finished");
	}

	if((get_property("sideDefeated") != "neither") && (get_property("cc_war") != "finished"))
	{
		print("Found completed Island War (12)");
		set_property("cc_war", "finished");
	}


	if(possessEquipment($item[Pirate Fledges]))
	{
		if(get_property("cc_pirateoutfit") != "finished")
		{
			print("Found Pirate Fledges and incomplete pirate outfit, fixing...");
			set_property("cc_pirateoutfit", "finished");
		}
		if(get_property("cc_fcle") != "finished")
		{
			print("Found Pirate Fledges and incomplete F\'C\'le, fixing...");
			set_property("cc_fcle", "finished");
		}
	}
	return false;
}

boolean L11_aridDesert()
{
	if(my_level() < 12)
	{
		if(get_property("cc_palindome") != "finished")
		{
			return false;
		}
	}
	if(get_property("desertExploration").to_int() >= 100)
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if((get_property("cc_hiddenapartment") != "finished") && (get_property("cc_hiddenapartment") != "0"))
	{
		return false;
	}

	item desertBuff = $item[none];
	if(possessEquipment($item[UV-resistant compass]))
	{
		desertBuff = $item[UV-resistant compass];
	}
	if(possessEquipment($item[Ornate Dowsing Rod]))
	{
		desertBuff = $item[Ornate Dowsing Rod];
	}

	if(!possessEquipment(desertBuff))
	{
		if(my_level() >= 12)
		{
			abort("I can't do the Oasis without an Ornate Dowsing Rod. You can manually get a UV-resistant compass and I'll use that if you really hate me that much.");
		}
		else
		{
			print("Skipping desert, don't have a rod or a compass.");
		}
		return false;
	}


	if((have_effect($effect[Ultrahydrated]) > 0) || (get_property("desertExploration").to_int() == 0))
	{
		print("Searching for the pyramid", "blue");
		equip(desertBuff);
		if((my_path() == "Heavy Rains") && (item_amount($item[Thor\'s Pliers]) > 0))
		{
			equip($item[Thor\'s Pliers]);
		}
		handleFamiliar($familiar[Artistic Goth Kid]);

		if(possessEquipment($item[reinforced beaded headband]) && possessEquipment($item[bullet-proof corduroys]) && possessEquipment($item[round purple sunglasses]))
		{
			foreach it in $items[Beer Helmet, Distressed Denim Pants, Bejeweled Pledge Pin]
			{
				take_closet(closet_amount(it), it);
			}

			if(get_property("cc_nunsTrick") == "true")
			{
				print("Had gotten War Hippy Fatigues during the Ferret rescue. Don't need to worry about them now.", "blue");
				set_property("cc_nunsTrick", "got");
				set_property("cc_nunsTrickGland", "start");
			}
		}
		else
		{
#			print("Only have some of the War Hippy Fatigues, so I'm going to closet everything relevant to get them in the desert", "blue");
			foreach it in $items[Reinforced Beaded Headband, Bullet-proof Corduroys, Round Purple Sunglasses, Beer Helmet, Distressed Denim Pants, Bejeweled Pledge Pin]
			{
				put_closet(closet_amount(it), it);
			}
		}

		buyUpTo(1, $item[hair spray]);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		if(my_primestat() == $stat[Muscle])
		{
			buyUpTo(1, $item[Ben-Gal&trade; Balm]);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			buyUpTo(1, $item[Blood of the Wereseal]);
			buffMaintain($effect[Temporary Lycanthropy], 0, 1, 1);
		}

		if((my_mp() > 30) && ((my_hp()*2) < (my_maxhp()*1)))
		{
			useCocoon();
		}

		if(in_hardcore() && isGuildClass() && (item_amount($item[Worm-Riding Hooks]) > 0) && (get_property("desertExploration").to_int() < 85))
		{
			if(item_amount($item[Drum Machine]) > 0)
			{
				use(1, $item[Drum Machine]);
			}
			else
			{
				ccAdv(1, $location[The Oasis]);
			}
			return true;
		}

		handleInitFamiliar();
		ccAdv(1, $location[The Arid\, Extra-Dry Desert]);
		handleFamiliar($familiar[Adventurous Spelunker]);

		if(contains_text(get_property("lastEncounter"), "He Got His Just Desserts"))
		{
			take_closet(1, $item[beer helmet]);
			take_closet(1, $item[distressed denim pants]);
			take_closet(1, $item[bejeweled pledge pin]);
			if(get_property("cc_nunsTrick") != "no")
			{
				set_property("cc_nunsTrick", "got");
				set_property("cc_nunsTrickGland", "start");
			}
		}

		int need = 100 - get_property("desertExploration").to_int();
		print("Need for desert: " + need, "blue");
		print("Worm riding: " + item_amount($item[worm-riding manual page]), "blue");
		if((need < 85) && (item_amount($item[Can of Black Paint]) > 0))
		{
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			use(1, $item[desert sightseeing pamphlet]);
		}
		if((need < 85) && (item_amount($item[Killing Jar]) > 0) && (get_property("cc_killingjar") != "done"))
		{
			set_property("cc_killingjar", "done");
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			use(1, $item[desert sightseeing pamphlet]);
		}

		need = 100 - get_property("desertExploration").to_int();
		if((need >= 15) && (item_amount($item[Worm-Riding Manual Page]) >= 15))
		{
			pullXWhenHaveY($item[Drum Machine], 1, 0);
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			set_property("cc_killingjar", "done");
			if(item_amount($item[Drum Machine]) > 0)
			{
				use(1, $item[Drum Machine]);
			}
		}

		need = 100 - get_property("desertExploration").to_int();
		if((need <= 15) && (get_property("cc_killingjar") == "") && (get_property("cc_killingjar") != "done"))
		{
			pullXWhenHaveY($item[Killing Jar], 1, 0);
			set_property("cc_killingjar", "done");
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			use(1, $item[desert sightseeing pamphlet]);
		}
	}
	else
	{
		int need = 100 - get_property("desertExploration").to_int();
		print("Getting some ultrahydrated, I suppose. Desert left: " + need, "blue");

		if((need > 15) && (item_amount($item[disassembled clover]) > 2) && !get_property("lovebugsUnlocked").to_boolean())
		{
			print("Gonna clover this, yeah, it only saves 2 adventures. So?", "green");
			use(1, $item[disassembled clover]);
			if(contains_text(visit_url("adventure.php?snarfblat=122&confirm=on"), "Combat"))
			{
				print("Wandering combat in The Oasis, boo. Gonna have to do this again.");
				ccAdv(1, $location[The Oasis]);
				if(item_amount($item[ten-leaf clover]) == 1)
				{
					use(1, $item[ten-leaf clover]);
				}
			}
		}
		else
		{
			if(!ccAdv(1, $location[The Oasis]))
			{
				print("Could not visit the Oasis for some reason, assuming desertExploration is incorrect.", "red");
				set_property("desertExploration", 0);
			}
		}
	}
	return true;
}

boolean L11_hiddenCityZones()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("cc_hiddenzones") == "finished")
	{
		return false;
	}

	if(get_property("cc_hiddenzones") == "")
	{
		print("Machete the hidden zones!", "blue");
		set_property("choiceAdventure781", "1");
		set_property("choiceAdventure785", "1");
		set_property("choiceAdventure783", "1");
		set_property("choiceAdventure787", "1");
		set_property("choiceAdventure789", "2");
		set_property("choiceAdventure791", "6");
		set_property("cc_hiddenzones", "0");
		if(possessEquipment($item[Antique Machete]))
		{
			set_property("cc_hiddenzones", "1");
		}
	}

	if(get_property("cc_hiddenzones") == "0")
	{
		if(possessEquipment($item[antique machete]))
		{
			set_property("cc_hiddenzones", "1");
		}
		else
		{
			if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
			{
				handleBjornify($familiar[Grimstone Golem]);
			}
			if(contains_text(get_property("lastEncounter"), "Where Does The Lone Ranger Take His Garbagester"))
			{
				set_property("choiceAdventure789", "6");
			}
			ccAdv(1, $location[The Hidden Park]);
			return true;
		}
	}

	if(get_property("cc_hiddenzones") == "1")
	{
		equip($item[antique machete]);
		# Add provision for Golden Monkey, or even more so, "Do we need spleen item"
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
		if(contains_text(get_property("lastEncounter"), "Earthbound and Down"))
		{
			set_property("cc_hiddenzones", "2");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "2")
	{
		equip($item[antique machete]);
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
		if(contains_text(get_property("lastEncounter"), "Air Apparent"))
		{
			set_property("cc_hiddenzones", "3");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "3")
	{
		equip($item[antique machete]);
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
		if(contains_text(get_property("lastEncounter"), "Water You Dune"))
		{
			set_property("cc_hiddenzones", "4");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "4")
	{
		equip($item[antique machete]);
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
		if(contains_text(get_property("lastEncounter"), "Fire When Ready"))
		{
			set_property("cc_hiddenzones", "5");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "5")
	{
		equip($item[antique machete]);
		handleFamiliar($familiar[Fist Turkey]);
		handleBjornify($familiar[Grinning Turtle]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[A Massive Ziggurat]);
		if(contains_text(get_property("lastEncounter"), "Legend of the Temple in the Hidden City"))
		{
			set_property("choiceAdventure791", "1");
			set_property("choiceAdventure781", "2");
			set_property("choiceAdventure785", "2");
			set_property("choiceAdventure783", "2");
			set_property("choiceAdventure787", "2");
			set_property("cc_hiddenzones", "finished");
			handleFamiliar($familiar[Adventurous Spelunker]);
			handleBjornify($familiar[El Vibrato Megadrone]);
		}
		if(contains_text(get_property("lastEncounter"), "Temple of the Legend in the Hidden City"))
		{
			set_property("choiceAdventure791", "1");
			set_property("choiceAdventure781", "2");
			set_property("choiceAdventure785", "2");
			set_property("choiceAdventure783", "2");
			set_property("choiceAdventure787", "2");
			set_property("cc_hiddenzones", "finished");
		}
		return true;
	}
	return false;
}

boolean L11_unlockHiddenCity()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(my_adventures() <= 3)
	{
		return false;
	}
	if(get_property("cc_hiddenunlock") != "nose")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}

	print("Searching for the Hidden City", "blue");
	if((item_amount($item[Stone Wool]) == 0) && (have_effect($effect[stone-faced]) == 0))
	{
		pullXWhenHaveY($item[Stone Wool], 1, 0);
	}
	buffMaintain($effect[Stone-Faced], 0, 1, 1);

	if(ccAdvBypass(280))
	{
		print("Wandering monster interrupted our attempt at the Hidden City", "red");
		return true;
	}

	visit_url("choice.php?whichchoice=582&option=2&pwd");
	visit_url("choice.php?whichchoice=580&option=2&pwd");
	visit_url("choice.php?whichchoice=584&option=4&pwd");
	visit_url("choice.php?whichchoice=580&option=1&pwd");
	visit_url("choice.php?whichchoice=123&option=2&pwd");
	visit_url("choice.php");
	cli_execute("dvorak");
	visit_url("choice.php?whichchoice=125&option=3&pwd");
	print("Hidden Temple Unlocked");
	set_property("cc_hiddenunlock", "finished");
	set_property("choiceAdventure582", "1");
	set_property("choiceAdventure579", "3");
	if((item_amount($item[antique machete]) == 0) && (!in_hardcore()))
	{
		pullXWhenHaveY($item[Antique Machete], 1, 0);
	}
	return true;
}


boolean L11_nostrilOfTheSerpent()
{
	if(get_property("questL11Worship") != "step1")
	{
		return false;
	}
#	if(get_property("lastTempleUnlock").to_int() != my_ascensions())
#	{
#		return false;
#	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(item_amount($item[The Nostril of the Serpent]) != 0)
	{
		return false;
	}
	if(get_property("cc_hiddenunlock") != "")
	{
		return false;
	}

	print("Must get a snake nose.", "blue");
	if((item_amount($item[Stone Wool]) == 0) && (have_effect($effect[stone-faced]) == 0))
	{
		pullXWhenHaveY($item[Stone Wool], 1, 0);
	}
	set_property("choiceAdventure582", "1");
	set_property("choiceAdventure579", "2");

	buffMaintain($effect[Stone-Faced], 0, 1, 1);
	if(have_effect($effect[Stone-Faced]) == 0)
	{
		abort("We are not Stone-Faced. Please get a stone wool and run me again.");
	}

	ccAdv(1, $location[The Hidden Temple]);
	cli_execute("refresh inv");
	if(item_amount($item[The Nostril of the Serpent]) == 1)
	{
		set_property("cc_hiddenunlock", "nose");
		set_property("choiceAdventure579", "3");
	}
	return true;
}

boolean LX_spookyBedroomCombat()
{
	set_property("cc_bedroomHandler1", "yes");
	set_property("cc_bedroomHandler2", "yes");
	ccAdv(1, $location[The Haunted Bedroom]);
	if(contains_text(visit_url("main.php"), "choice.php"))
	{
		print("Bedroom choice adventure get!", "green");
		ccAdv(1, $location[The Haunted Bedroom]);
	}
	else if(contains_text(visit_url("main.php"), "Combat"))
	{
		print("Bedroom post-combat super combat get!", "green");
		ccAdv(1, $location[The Haunted Bedroom]);
	}
	set_property("cc_bedroomHandler1", "no");
	set_property("cc_bedroomHandler2", "no");
	return false;
}

boolean LX_spookyravenSecond()
{
	if((get_property("cc_spookyravensecond") != "") || (get_property("cc_spookyravennecklace") != "done"))
	{
		return false;
	}

	if((item_amount($item[Lady Spookyraven\'s Powder Puff]) == 1) && (item_amount($item[Lady Spookyraven\'s Dancing Shoes]) == 1) && (item_amount($item[Lady Spookyraven\'s Finest Gown]) == 1))
	{
		print("Finished Spookyraven, just dancing with the lady.", "blue");
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		set_property("cc_ballroomopen", "open");
		ccAdv(1, $location[The Haunted Ballroom]);
		if(contains_text(get_property("lastEncounter"), "Lights Out in the Ballroom"))
		{
			ccAdv(1, $location[The Haunted Ballroom]);
		}
		set_property("choiceAdventure106", "2");
		visit_url("place.php?whichplace=manor3&action=manor3_ladys");
		return true;
	}

	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}

	if(item_amount($item[Lord Spookyraven\'s Spectacles]) == 0)
	{
		set_property("choiceAdventure878", "3");
	}
	else
	{
		if(item_amount($item[Disposable Instant Camera]) == 0)
		{
			set_property("choiceAdventure878", "4");
		}
		else
		{
			set_property("choiceAdventure878", "2");
		}
	}

	if(get_property("cc_bedroomHandler1") == "yes")
	{
		set_property("cc_bedroomHandler1", "no");
		set_property("cc_bedroomHandler2", "no");
		abort("We are currently in a choice and mafia won't automatically handle this. It's usually One Simple Nightstand that causes this but you might have a bonus. Woo.");
	}

	if((get_property("cc_ballroomopen") == "open") || (get_property("questM21Dance") == "finished") || (get_property("questM21Dance") == "step3"))
	{
		if(item_amount($item[Lord Spookyraven\'s Spectacles]) == 1)
		{
			set_property("cc_spookyravensecond", "finished");
		}
		else
		{
			print("Need Spectacles, damn it.", "blue");
			LX_spookyBedroomCombat();
			print("Finished 1 Spookyraven Bedroom Spectacle Sequence", "blue");
		}
		return true;
	}
	else
	{
		if((item_amount($item[Lady Spookyraven\'s Finest Gown]) == 0) && (get_counters("Fortune Cookie", 0, 10) != "Fortune Cookie"))
		{
			print("Spookyraven: Bedroom", "blue");
			LX_spookyBedroomCombat();
			print("Finished 1 Spookyraven Bedroom Sequence", "blue");
			return true;
		}
		if(item_amount($item[Lady Spookyraven\'s Dancing Shoes]) == 0)
		{
 			set_property("louvreGoal", "7");
 			set_property("louvreDesiredGoal", "7");
			print("Spookyraven: Gallery", "blue");
			ccAdv(1, $location[The Haunted Gallery]);
			return true;
		}
		if(item_amount($item[Lady Spookyraven\'s Powder Puff]) == 0)
		{
			if((my_daycount() == 1) && (get_property("_hipsterAdv").to_int() < 7) && is_unrestricted($familiar[Artistic Goth Kid]))
			{
				handleFamiliar($familiar[Artistic Goth Kid]);
			}
			print("Spookyraven: Bathroom", "blue");
			set_property("choiceAdventure892", "1");
			ccAdv(1, $location[The Haunted Bathroom]);

			handleFamiliar($familiar[Adventurous Spelunker]);
			return true;
		}
	}
	return false;
}



boolean L11_mauriceSpookyraven()
{
	if(get_property("cc_spookyravennecklace") != "done")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("cc_ballroom") != "")
	{
		return false;
	}

	if(my_class() == $class[Ed])
	{
		if(item_amount($item[7962]) == 0)
		{
			set_property("cc_ballroom", "finished");
			return true;
		}
	}
	else if(item_amount($item[2286]) > 0)
	{
		set_property("cc_ballroom", "finished");
		return true;
	}

	if(get_property("cc_ballroomflat") == "")
	{
		print("Searching for the basement of Spookyraven", "blue");
		set_property("choiceAdventure106", "2");
		set_property("choiceAdventure90", "3");
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		if(my_mp() > 60)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		buffMaintain($effect[Snow Shoes], 0, 1, 1);

		handleInitFamiliar();
		if(!ccAdv(1, $location[The Haunted Ballroom]))
		{
			visit_url("place.php?whichplace=manor2");
			print("If 'That Area is not available', mafia isn't recognizing it without a visit to manor2, not sure why.", "red");
		}
		handleFamiliar($familiar[Adventurous Spelunker]);
		if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
		{
			set_property("cc_ballroomflat", "organ");
		}
		return true;
	}
	if(item_amount($item[recipe: mortar-dissolving solution]) == 0)
	{
		equip($slot[acc3], $item[Lord Spookyraven\'s Spectacles]);
		visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		use(1, $item[recipe: mortar-dissolving solution]);

		if(item_amount($item[Numberwang]) > 0)
		{
			equip($slot[acc3], $item[numberwang]);
		}

		#Cellar, laundry room Lights out ignore
		set_property("choiceAdventure901", "2");
		set_property("choiceAdventure891", "1");
	}

	if((item_amount($item[blasting soda]) == 1) && (item_amount($item[bottle of Chateau de Vinegar]) == 1))
	{
		print("Time to cook up something explosive! Science fair unstable fulminate time!", "green");
		ovenHandle();
		craft("cook", 1, $item[bottle of Chateau de Vinegar], $item[blasting soda]);
		set_property("cc_winebomb", "partial");
	}

	if(possessEquipment($item[Unstable Fulminate]))
	{
		set_property("cc_winebomb", "partial");
	}

	if((item_amount($item[bottle of Chateau de Vinegar]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for vinegar", "blue");
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		ccAdv(1, $location[The Haunted Wine Cellar]);
		return true;
	}
	if((item_amount($item[blasting soda]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for baking soda, I mean, blasting pop.", "blue");
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		ccAdv(1, $location[The Haunted Laundry Room]);
		return true;
	}

	if(get_property("cc_winebomb") == "partial")
	{
		if(item_amount($item[unstable fulminate]) > 0)
		{
			if(weapon_hands(equipped_item($slot[weapon])) != 1)
			{
				equip($slot[weapon], $item[none]);
			}
			equip($item[unstable fulminate]);
		}
		print("Now we mix and heat it up.", "blue");

		if((my_path() == "Picky") && (item_amount($item[gumshoes]) > 0))
		{
			change_mcd(0);
			equip($slot[acc2], $item[gumshoes]);
		}

		if(item_amount($item[wine bomb]) == 1)
		{
			set_property("cc_winebomb", "finished");
			visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
			return true;
		}

		if(equipped_item($slot[Off-hand]) != $item[Unstable Fulminate])
		{
			abort("Unstable Fulminate was not equipped. Please report this and include the following: Equipped items and if you have or don't have an Unstable Fulminate. For now, get the wine bomb manually, and run again.");
		}
		ccAdv(1, $location[The Haunted Boiler Room]);

		if(item_amount($item[wine bomb]) == 1)
		{
			set_property("cc_winebomb", "finished");
			visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		}
		return true;
	}

	if(get_property("cc_winebomb") == "finished")
	{
		print("Down with the tyrant of Spookyraven!", "blue");
		if(my_mp() >= 20)
		{
			useCocoon();
		}
		buffMaintain($effect[Astral Shell], 10, 1, 1);
		buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);

		visit_url("place.php?whichplace=manor4&action=manor4_chamberboss");
		if(my_class() != $class[Ed])
		{
			ccAdv(1, $location[Noob Cave]);
		}
		if(have_effect($effect[beaten up]) == 0)
		{
			set_property("cc_ballroom", "finished");
		}
		return true;
	}
	return false;
}

boolean LX_dinseylandfillFunbucks()
{
	if(!get_property("cc_getDinseyGarbageMoney").to_boolean())
	{
		return false;
	}
	if(!elementalPlanes_access($element[stench]))
	{
		return false;
	}
	if(get_property("cc_dinseyGarbageMoney").to_int() == my_daycount())
	{
		return false;
	}
	if((my_adventures() == 0) || (my_level() < 5))
	{
		return false;
	}
	if(item_amount($item[Bag of Park Garbage]) > 0)
	{
		return dinseylandfill_garbageMoney();
	}
	if((my_daycount() >= 3) && (my_adventures() > 5))
	{
		# We do this after the item check since we may have an extra bag and we should turn that in.
		return false;
	}
	ccAdv(1, $location[Barf Mountain]);
	return true;
}

boolean L13_sorceressDoor()
{
	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_05_monster1"))
	{
		set_property("cc_sorceress", "tower");
		return false;
	}
	if(get_property("cc_sorceress") != "door")
	{
		return false;
	}

	if((item_amount($item[Richard\'s Star Key]) == 0) && (item_amount($item[Star Chart]) == 0))
	{
		if(my_rain() < 50)
		{
			pullXWhenHaveY($item[Star Chart], 1, 0);
		}
	}

	if((item_amount($item[Richard\'s Star Key]) == 0) && (item_amount($item[Star Chart]) > 0) && (item_amount($item[star]) >= 8) && (item_amount($item[line]) >= 7))
	{
		visit_url("shop.php?pwd&whichshop=starchart&action=buyitem&quantity=1&whichrow=141");
		if(item_amount($item[Richard\'s Star Key]) == 0)
		{
			cli_execute("make richard's star key");
		}
	}

	if(item_amount($item[white pixel]) >= 30)
	{
		cli_execute("make digital key");
		set_property("cc_crackpotjar", "finished");
	}

	string page = visit_url("place.php?whichplace=nstower_door");
	if(contains_text(page, "ns_lock1"))
	{
		if(item_amount($item[Boris\'s Key]) == 0)
		{
			cli_execute("make Boris's Key");
		}
		if(item_amount($item[Boris\'s Key]) == 0)
		{
			abort("Need Boris's Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock1");
	}
	if(contains_text(page, "ns_lock2"))
	{
		if(item_amount($item[Jarlsberg\'s Key]) == 0)
		{
			cli_execute("make Jarlsberg's Key");
		}
		if(item_amount($item[Jarlsberg\'s Key]) == 0)
		{
			abort("Need Jarlsberg's Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock2");
	}
	if(contains_text(page, "ns_lock3"))
	{
		if(item_amount($item[Sneaky Pete\'s Key]) == 0)
		{
			cli_execute("make Sneaky Pete's Key");
		}
		if(item_amount($item[Sneaky Pete\'s Key]) == 0)
		{
			abort("Need Sneaky Pete's Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock3");
	}

	if(contains_text(page, "ns_lock4"))
	{
		if(item_amount($item[Richard\'s Star Key]) == 0)
		{
			cli_execute("make richard's star key");
		}
		if(item_amount($item[Richard\'s Star Key]) == 0)
		{
			abort("Need Richard's Star Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock4");
	}

	if(contains_text(page, "ns_lock5"))
	{
		if(item_amount($item[Digital Key]) == 0)
		{
			cli_execute("make digital key");
		}
		if(item_amount($item[Digital Key]) == 0)
		{
			abort("Need Digital Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock5");
	}

	if(contains_text(page, "ns_lock6"))
	{
		if(item_amount($item[Skeleton Key]) == 0)
		{
			cli_execute("make skeleton key");
		}
		if(item_amount($item[Skeleton Key]) == 0)
		{
			abort("Need Skeleton Key for the Sorceress door :(");
		}
		visit_url("place.php?whichplace=nstower_door&action=ns_lock6");
	}


	visit_url("place.php?whichplace=nstower_door&action=ns_doorknob");
	return true;
}


boolean L11_unlockEd()
{
	if(get_property("cc_mcmuffin") != "pyramid")
	{
		return false;
	}

	if(my_class() == $class[Ed])
	{
		set_property("cc_mcmuffin", "finished");
		return true;
	}

	if(get_property("cc_tavern") != "finished")
	{
		print("Uh oh, didn\'t do the tavern and we are at the pyramid....", "red");
	}

	if(get_property("cc_nunsTrick") == "got")
	{
		set_property("cc_nunsTrickActive", "yes");
	}

	print("In the pyramid (W:" + item_amount($item[crumbling wooden wheel]) + ") (R:" + item_amount($item[tomb ratchet]) + ") (U:" + get_property("controlRoomUnlock") + ")", "blue");

	if(!get_property("middleChamberUnlock").to_boolean())
	{
		ccAdv(1, $location[The Upper Chamber]);
		return true;
	}

	int total = item_amount($item[Crumbling Wooden Wheel]);
	total = total + item_amount($item[Tomb Ratchet]);

	if((total >= 10) && (my_adventures() >= 4) && get_property("controlRoomUnlock").to_boolean())
	{
		visit_url("place.php?whichplace=pyramid&action=pyramid_control");
		int x = 0;
		while(x < 10)
		{
			if(item_amount($item[crumbling wooden wheel]) > 0)
			{
				visit_url("choice.php?pwd&whichchoice=929&option=1&choiceform1=Use+a+wheel+on+the+peg&pwd="+my_hash());
			}
			else
			{
				visit_url("choice.php?whichchoice=929&option=2&pwd");
			}
			x = x + 1;
			if((x == 3) || (x == 7) || (x == 10))
			{
				visit_url("choice.php?pwd&whichchoice=929&option=5&choiceform5=Head+down+to+the+Lower+Chambers+%281%29&pwd="+my_hash());
			}
			if((x == 3) || (x == 7))
			{
				visit_url("place.php?whichplace=pyramid&action=pyramid_control");
			}
		}
		set_property("cc_mcmuffin", "ed");
		return true;
	}
	if(total < 10)
	{
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		buffMaintain($effect[One Very Clear Eye], 0, 1, 1);
		buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
		buffMaintain($effect[Human-Fish Hybrid], 0, 1, 1);
		buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
		if(get_property("cc_dickstab").to_boolean())
		{
			buffMaintain($effect[Wet and Greedy], 0, 1, 1);
			buffMaintain($effect[Frosty], 0, 1, 1);
		}
		if(item_amount($item[possessed sugar cube]) > 0)
		{
			cli_execute("make sugar fairy");
			buffMaintain($effect[Dance of the Sugar Fairy], 0, 1, 1);
		}
	}
	if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") != "Tomb Rat"))
	{
		if(item_amount($item[soft green echo eyedrop antidote]) > 0)
		{
			uneffect($effect[On The Trail]);
		}
	}

	ccAdv(1, $location[The Middle Chamber]);
	return true;
}


boolean L11_unlockPyramid()
{
#	if((my_level() >= 12) && (my_class() != $class[Ed]) && (((item_amount($item[ancient amulet]) > 0) && (item_amount($item[Eye of Ed]) > 0) && (item_amount($item[Staff of Fats]) > 0)) || (item_amount($item[Staff of Ed]) > 0)) && (get_property("cc_mcmuffin") == "start"))
	int pyramidLevel = 11;
	if(get_property("cc_dickStab").to_boolean())
	{
		pyramidLevel = 12;
	}

	if(my_level() < pyramidLevel)
	{
		return false;
	}
	if(my_class() == $class[Ed])
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}

	if(get_property("questL11Pyramid") == "started")
	{
		set_property("cc_mcmuffin", "pyramid");
		return true;
	}


	if((((item_amount($item[2180]) > 0) && (item_amount($item[2286]) > 0) && (item_amount($item[2268]) > 0)) || (item_amount($item[2325]) > 0)))
	{
		print("Reveal the pyramid", "blue");
#		if(item_amount($item[Staff of Ed]) == 0)
		if(item_amount($item[2325]) == 0)
		{
			craft("combine", 1, $item[2180], $item[2286]);
			craft("combine", 1, $item[headpiece of the staff of ed], $item[2268]);
		}
		if(item_amount($item[2325]) == 0)
		{
			abort("Failed making Staff of Ed (2325) via CLI. Please do it manually and rerun.");
		}

		visit_url("place.php?whichplace=desertbeach&action=db_pyramid1");

		if(get_property("questL11Pyramid") == "unstarted")
		{
			print("No burning Ed's model now!", "blue");
			if((my_path() == "One Crazy Random Summer") && (get_property("desertExploration").to_int() == 100))
			{
				print("We might have had an issue due to OCRS and the Desert, please finish the desert (and only the desert) manually and run again.", "red");
				string page = visit_url("place.php?whichplace=desertbeach");
				matcher desert_matcher = create_matcher("title=\"[(](\\d+)% explored[)]\"", page);
				if(desert_matcher.find())
				{
					int found = to_int(desert_matcher.group(1));
					if(found < 100)
					{
						set_property("desertExploration", found);
					}
				}

				if(get_property("desertExploration").to_int() == 100)
				{
					abort("Tried to open the Pyramid but could not. Something went wrong :(");
				}
				else
				{
					print("Incorrectly had exploration value of 100 however, this was correctable. Trying to resume.", "blue");
					return false;
				}
			}
			abort("Tried to open the Pyramid but could not. Something went wrong :(");
		}

		set_property("cc_hiddencity", "finished");
		set_property("cc_ballroom", "finished");
		set_property("cc_palindome", "finished");
		set_property("cc_mcmuffin", "pyramid");
		buffMaintain($effect[Snow Shoes], 0, 1, 1);
		ccAdv(1, $location[The Upper Chamber]);
		return true;
	}
	else
	{
		return false;
	}
}

boolean L11_defeatEd()
{
	if(get_property("cc_mcmuffin") != "ed")
	{
		return false;
	}
	if(my_adventures() <= 7)
	{
		return false;
	}

	#if(item_amount($item[Holy MacGuffin]) == 1)
	if(item_amount($item[2334]) == 1)
	{
		set_property("cc_mcmuffin", "finished");
		council();
		return true;
	}

	int baseML = monster_level_adjustment();
	if(my_path() == "Heavy Rains")
	{
		baseML = baseML + 60;
	}
	if(baseML > 150)
	{
		equip($slot[acc2], $item[pirate fledges]);
		uneffect($effect[Ur-kel\'s Aria of Annoyance]);
		if(possessEquipment($item[Beer Helmet]))
		{
			equip($item[beer helmet]);
		}
	}
	print("Time to waste all of Ed's Ka Coins :(", "blue");

	set_property("choiceAdventure976", "1");

	#This seems to work but we just want to be a little careful with it.
	if(true)
	{
		while(item_amount($item[2334]) == 0)
		{
			ccAdv(1, $location[The Lower Chambers]);
		}
	}
	else
	{
		visit_url("place.php?whichplace=pyramid&action=pyramid_state1a");
		visit_url("choice.php?pwd&whichchoice=976&option=1&choiceform1=If+you+say+so...&pwd="+my_hash());
		visit_url("fight.php");
		int x = 0;
		while(x < 7)
		{
			x = x + 1;
			run_combat();
			#ccAdv(1, $location[Noob Cave]);
			if(x < 7)
			{
				visit_url("fight.php");
			}
		}
	}

	#if(item_amount($item[Holy MacGuffin]) != 0)
	if(item_amount($item[2334]) != 0)
	{
		set_property("cc_mcmuffin", "finished");
		council();
	}
	return true;
}

boolean L12_sonofaFinish()
{
	if(get_property("cc_sonata") == "finished")
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) < 5)
	{
		return false;
	}
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 64))
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	set_property("cc_sonata", "finished");
	return true;
}



boolean L12_gremlinStart()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_gremlins") != "")
	{
		return false;
	}
	print("Gremlin prep", "blue");
	if(get_property("cc_hippyInstead").to_boolean())
	{
		if(!possessEquipment($item[Reinforced Beaded Headband]))
		{
			pullXWhenHaveY($item[Reinforced Beaded Headband], 1, 0);
		}
		if(!possessEquipment($item[Bullet-Proof Corduroys]))
		{
			pullXWhenHaveY($item[Bullet-Proof Corduroys], 1, 0);
		}
		if(!possessEquipment($item[Round Purple Sunglasses]))
		{
			pullXWhenHaveY($item[Round Purple Sunglasses], 1, 0);
		}
	}

	if((!possessEquipment($item[Ouija Board\, Ouija Board])) && (item_amount($item[Lump of Brituminous Coal]) > 0))
	{
		while(item_amount($item[turtle totem]) == 0)
		{
			buyUpTo(1, $item[chewing gum on a string]);
			use(1, $item[chewing gum on a string]);
		}
		craft("smith", 1, $item[lump of Brituminous coal], $item[turtle totem]);
		while(item_amount($item[turtle totem]) == 0)
		{
			buyUpTo(1, $item[chewing gum on a string]);
			use(1, $item[chewing gum on a string]);
		}
	}
	if((item_amount($item[louder than bomb]) == 0) && (item_amount($item[Handful of Smithereens]) > 0))
	{
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		cli_execute("make louder than bomb");
#		craft("paste", 1, $item[Ben-Gal&trade; Balm], $item[Handful of Smithereens]);
	}
	set_property("cc_gremlins", "start");
	set_property("cc_gremlinclap", "");
	set_property("cc_gremlinbatter", "");
	set_property("cc_gremlinpants", "");
	set_property("cc_gremlinlouder", "");
	return true;
}

boolean L12_gremlins()
{
	if(get_property("cc_gremlins") != "start")
	{
		return false;
	}
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("sidequestJunkyardCompleted") != "none")
	{
		return false;
	}
	if(get_property("cc_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 192))
	{
		return false;
	}

	#Put a different shield in here.
	print("Doing them gremlins", "blue");
	if(item_amount($item[Ouija Board\, Ouija Board]) > 0)
	{
		equip($item[Ouija Board\, Ouija Board]);
	}
	if(item_amount($item[Reinforced Beaded Headband]) > 0)
	{
		equip($item[Reinforced Beaded Headband]);
	}
	useCocoon();

	handleInitFamiliar();
	if(item_amount($item[molybdenum hammer]) == 0)
	{
		ccAdv(1, $location[Next to that barrel with something burning in it], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum screwdriver]) == 0)
	{
		ccAdv(1, $location[Out by that rusted-out car], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum crescent wrench]) == 0)
	{
		ccAdv(1, $location[over where the old tires are], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum pliers]) == 0)
	{
		ccAdv(1, $location[near an abandoned refrigerator], "ccsJunkyard");
		return true;
	}
	handleFamiliar($familiar[Adventurous Spelunker]);
	warOutfit();
	visit_url("bigisland.php?action=junkman&pwd");
	set_property("cc_gremlins", "finished");
	return true;
}

boolean L12_sonofaBeach()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_sonata") == "finished")
	{
		return false;
	}
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		if(get_property("cc_gremlins") != "finished")
		{
			return false;
		}
	}
	else if(get_property("fratboysDefeated").to_int() < 64)
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) >= 5)
	{
		return false;
	}
#	Probably bad exclusions here.
#	if(have_skill($skill[Rain Man]))
#	{
#		return false;
#	}
#	if(!get_property("cc_100familiar").to_boolean())
#	{
#		return false;
#	}

	if(get_property("sidequestLighthouseCompleted") != "none")
	{
		set_property("cc_sonata", "finished");
		return true;
	}


	if(!uneffect($effect[The Sonata of Sneakiness]))
	{
		return false;
	}
	if((my_class() == $class[Ed]) && (item_amount($item[Talisman of Horus]) == 0))
	{
		return false;
	}

	if(!uneffect($effect[Shelter of Shed]))
	{
		print("Can not uneffect Shelter of Shed for the Lobsterfrogman, delaying");
		return false;
	}
	buffMaintain($effect[Taunt of Horus], 0, 1, 1);
	buffMaintain($effect[Hippy Stench], 0, 1, 1);
	buffMaintain($effect[Musk of the Moose], 0, 1, 10);
	buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 0, 1, 10);
	if(have_familiar($familiar[Grim Brother]))
	{
		handleBjornify($familiar[Grim Brother]);
	}
	if(equipped_item($slot[hat]) == $item[Xiblaxian stealth cowl])
	{
		equip($item[Beer Helmet]);
	}
	if(equipped_item($slot[acc1]) == $item[over-the-shoulder folder holder])
	{
		equip($slot[acc1], $item[bejeweled pledge pin]);
	}
	if(item_amount($item[portable cassette player]) > 0)
	{
		equip($slot[acc2], $item[portable cassette player]);
	}
	handleFamiliar($familiar[Jumpsuited Hound Dog]);

	if(item_amount($item[barrel of gunpowder]) < 4)
	{
		set_property("cc_doCombatCopy", "yes");
	}
	ccAdv(1, $location[Sonofa Beach]);
	set_property("cc_doCombatCopy", "no");

	if((my_class() == $class[Ed]) && (my_hp() == 0))
	{
		use(1, $item[Linen Bandages]);
	}
	return true;
}

boolean L12_filthworms()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(item_amount($item[Heart of the Filthworm Queen]) > 0)
	{
		set_property("cc_orchard", "done");
	}
	if(get_property("cc_orchard") != "start")
	{
		return false;
	}
	print("Doing the orchard.", "blue");

	if(item_amount($item[Filthworm Hatchling Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Hatchling Scent Gland]);
	}
	if(item_amount($item[Filthworm Drone Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Drone Scent Gland]);
	}
	if(item_amount($item[Filthworm Royal Guard Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Royal Guard Scent Gland]);
	}

	if(have_effect($effect[Filthworm Guard Stench]) > 0)
	{
		ccAdv(1, $location[The Filthworm Queen\'s Chamber]);
		if(item_amount($item[Heart of the Filthworm Queen]) > 0)
		{
			set_property("cc_orchard", "done");
		}
		return true;
	}

	if(!have_skill($skill[Lash of the Cobra]))
	{
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		buffMaintain($effect[Kindly Resolve], 0, 1, 1);
		buffMaintain($effect[Fortunate Resolve], 0, 1, 1);
		buffMaintain($effect[One Very Clear Eye], 0, 1, 1);
		buffMaintain($effect[Human-Fish Hybrid], 0, 1, 1);
		buffMaintain($effect[Human-Human Hybrid], 0, 1, 1);
		buffMaintain($effect[Human-Machine Hybrid], 0, 1, 1);

		if(get_property("cc_dickstab").to_boolean())
		{
			buffMaintain($effect[Wet and Greedy], 0, 1, 1);
		}
		buffMaintain($effect[Frosty], 0, 1, 1);
	}

	if((!possessEquipment($item[A Light That Never Goes Out])) && (item_amount($item[Lump of Brituminous Coal]) > 0))
	{
		buyUpTo(1, $item[third-hand lantern]);
		craft("smith", 1, $item[Lump of Brituminous Coal], $item[third-hand lantern]);
	}

	if(possessEquipment($item[A Light That Never Goes Out]))
	{
		if(weapon_hands(equipped_item($slot[weapon])) != 1)
		{
			equip($slot[weapon], $item[none]);
		}
		equip($item[A Light That Never Goes Out]);
	}

	handleFamiliar($familiar[Adventurous Spelunker]);

	if(have_effect($effect[Filthworm Drone Stench]) > 0)
	{
		ccAdv(1, $location[The Royal Guard Chamber]);
		return true;
	}
	if(have_effect($effect[Filthworm Larva Stench]) > 0)
	{
		ccAdv(1, $location[The Feeding Chamber]);
		return true;
	}
	ccAdv(1, $location[The Hatching Chamber]);
	return true;
}

boolean tryCookies()
{
	string cookie = get_counters("Fortune Cookie", 0, 200);
	if(cookie == "Fortune Cookie")
	{
		return true;
	}
	if(my_fullness() < 12)
	{
		return false;
	}
	while((fullness_limit() - my_fullness()) > 0)
	{
		buyUpTo(1, $item[Fortune Cookie]);
		if(item_amount($item[Mayoflex]) > 0)
		{
			use(1, $item[Mayoflex]);
		}
		eatsilent(1, $item[Fortune Cookie]);
		cookie = get_counters("Fortune Cookie", 0, 200);
		if(cookie == "Fortune Cookie")
		{
			return true;
		}
	}
	return false;
}

boolean tryPantsEat()
{
	if((fullness_limit() - my_fullness()) > 0)
	{
		if(item_amount($item[Mayoflex]) > 0)
		{
			use(1, $item[Mayoflex]);
		}
		if(item_amount($item[tasty tart]) > 0)
		{
			eatsilent(1, $item[tasty tart]);
			return true;
		}
		if(item_amount($item[deviled egg]) > 0)
		{
			eatsilent(1, $item[deviled egg]);
			return true;
		}
		if(item_amount($item[cold mashed potatoes]) > 0)
		{
			eatsilent(1, $item[cold mashed potatoes]);
			return true;
		}
		if(item_amount($item[dinner roll]) > 0)
		{
			eatsilent(1, $item[dinner roll]);
			return true;
		}
		if(item_amount($item[whole turkey leg]) > 0)
		{
			eatsilent(1, $item[whole turkey leg]);
			return true;
		}
		if(item_amount($item[can of sardines]) > 0)
		{
			eatsilent(1, $item[can of sardines]);
			return true;
		}
		if(item_amount($item[high-calorie sugar substitute]) > 0)
		{
			eatsilent(1, $item[high-calorie sugar substitute]);
			return true;
		}
		if(item_amount($item[pat of butter]) > 0)
		{
			eatsilent(1, $item[pat of butter]);
			return true;
		}
	}
	return false;
}


void consumeStuff()
{
	if(ed_eatStuff())
	{
		return;
	}
	if(get_property("kingLiberated") != false)
	{
		return;
	}

	int mpForOde = 50;
	if(!have_skill($skill[The Ode to Booze]))
	{
		mpForOde = 0;
	}

	if(my_daycount() == 1)
	{
		if((my_spleen_use() == 0) && (item_amount($item[grim fairy tale]) > 0))
		{
			chew(1, $item[grim fairy tale]);
			set_property("cc_grimfairytale", "1");
		}

		//	Try to drink more on day 1 please!

		if((my_meat() > 400) && (item_amount($item[handful of smithereens]) == 3) && (get_property("cc_mosquito") == "finished"))
		{
			cli_execute("make 3 paint a vulgar pitcher");
		}

		if(((my_inebriety() + 2) < inebriety_limit()) && (my_mp() >= mpForOde) && (item_amount($item[Agitated Turkey]) >= 2))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(2, $item[Agitated Turkey]);
		}

		if(((my_inebriety() + 1) == inebriety_limit()) && (my_mp() >= mpForOde) && (item_amount($item[Cold One]) >= 1) && (my_level() >= 11))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Cold One]);
		}

		if((my_spleen_use() <= 7) && (my_level() >= 10) && (my_adventures() < 3) && (item_amount($item[astral energy drink]) > 0))
		{
			chew(1, $item[astral energy drink]);
		}

		if((my_mp() > mpForOde) && (my_meat() > 400) && (my_level() >= 3) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
			if(item_amount($item[paint a vulgar pitcher]) > 0)
			{
				drink(1, $item[paint a vulgar pitcher]);
			}
		}

		if((my_mp() > mpForOde) && get_property("cc_100familiar").to_boolean() && (my_inebriety() == 0) && (my_meat() >= 500))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			cli_execute("drink 1 lucky lindy");

			pullXWhenHaveY($item[ice island long tea], 1, 0);
			drink(1, $item[Ice Island Long Tea]);
		}

		if((my_mp() > mpForOde) && get_property("cc_100familiar").to_boolean() && (my_inebriety() == 13) && (item_amount($item[Cold One]) > 0) && (my_level() >= 10))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Cold One]);
		}

		if((my_mp() > mpForOde) && (amountTurkeyBooze() >= 2) && (my_inebriety() == 0) && (my_meat() >= 500))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			cli_execute("drink 1 lucky lindy");
			print("drink 1 lucky lindy");
			while((amountTurkeyBooze() > 0) && (my_inebriety() < 3))
			{
				if(item_amount($item[Friendly Turkey]) > 0)
				{
					drink(1, $item[Friendly Turkey]);
				}
				else if(item_amount($item[Agitated Turkey]) > 0)
				{
					drink(1, $item[Agitated Turkey]);
				}
				else if(item_amount($item[Ambitious Turkey]) > 0)
				{
					drink(1, $item[Ambitious Turkey]);
				}
			}
		}

		if((my_mp() > mpForOde) && (turkeyBooze() >= 5) && (amountTurkeyBooze() >= 3) && (my_inebriety() < 6))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			while((amountTurkeyBooze() > 0) && (my_inebriety() < 6))
			{
				if(item_amount($item[Friendly Turkey]) > 0)
				{
					drink(1, $item[Friendly Turkey]);
				}
				else if(item_amount($item[Agitated Turkey]) > 0)
				{
					drink(1, $item[Agitated Turkey]);
				}
				else if(item_amount($item[Ambitious Turkey]) > 0)
				{
					drink(1, $item[Ambitious Turkey]);
				}
			}
		}

#		int sockdollagerDrunk = 6;
#		if(get_property("cc_100familiar").to_boolean())
#		{
#			sockdollagerDrunk = 5;
#		}

#		if((get_property("cc_bat") == "finished") && (get_property("_speakeasyDrinksDrunk") != "1") && (my_mp() > 50))
#		if((get_property("cc_ballroomsong") == "set") && (get_property("_speakeasyDrinksDrunk").to_int() == 1) && (my_mp() > mpForOde) && (my_inebriety() == sockdollagerDrunk))
		if((get_property("cc_ballroomsong") == "set") && (get_property("_speakeasyDrinksDrunk").to_int() == 1) && (my_mp() >= (mpForOde+30)) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			visit_url("clan_viplounge.php?action=speakeasy");
			cli_execute("drink 1 sockdollager");
			print("drink 1 sockdollager");
#			cli_execute("get _speakeasyDrinksDrunk ");
			print("Second speakeasy drink down!");
			hermit(10, $item[ten-leaf clover]);
		}

		if((my_adventures() < 4) && (my_fullness() == 0) && (my_level() >= 7))
		{
			dealWithMilkOfMagnesium(true);
			buffMaintain($effect[Got Milk], 0, 1, 1);
			if(item_amount($item[Spaghetti Breakfast]) > 0)
			{
				ccEat(1, $item[Spaghetti Breakfast]);
			}
			pullXWhenHaveY(whatHiMein(), 2, 0);
			ccEat(2, whatHiMein());
			if(item_amount($item[digital key lime pie]) > 0)
			{
				ccEat(1, $item[digital key lime pie]);
				tryPantsEat();
			}
			else
			{
				if(my_fullness() == 10)
				{
					pullXWhenHaveY(whatHiMein(), 1, 0);
					ccEat(1, whatHiMein());
				}
				else
				{
					pullXWhenHaveY($item[Digital Key Lime Pie], 1, 0);
					ccEat(1, $item[Digital Key Lime Pie]);
				}
			}
		}

		if(in_hardcore() && isGuildClass() && have_skill($skill[Pastamastery]))
		{
			int canEat = fullness_limit() / 5;
			boolean[item] toEat;
			boolean[item] toPrep;

			if(have_skill($skill[Advanced Saucecrafting]))
			{
				toPrep = $items[Bubblin\' Crude, Ectoplasmic Orbs, Salacious Crumbs, Pestopiary, Goat Cheese];
				toEat = $items[Fettucini Inconnu, Crudles, Spaghetti with Ghost Balls, Agnolotti Arboli, Suggestive Strozzapreti];
			}
			else //Pastamastery was checked before we entered this block.
			{
				toPrep = $items[Bubblin\' Crude, Ectoplasmic Orbs, Salacious Crumbs, Pestopiary];
				toEat = $items[Crudles, Spaghetti with Ghost Balls, Agnolotti Arboli, Suggestive Strozzapreti];
			}

			int haveToEat = 0;
			foreach it in toEat
			{
				haveToEat = haveToEat + item_amount(it);
			}

			int haveToPrep = 0;
			foreach it in toPrep
			{
				haveToPrep = haveToPrep + item_amount(it);
			}

			if((canEat > 0) && ((haveToEat + haveToPrep) > canEat))
			{
				if(haveToEat < canEat)
				{
					ovenHandle();
				}
				while(haveToEat < canEat)
				{
					haveToEat = haveToEat + 1;
					if((item_amount($item[Goat Cheese]) > 0) && (item_amount($item[Scrumptious Reagent]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						craft("cook", 1, $item[Goat Cheese], $item[Scrumptious Reagent]);
						craft("cook", 1, $item[Dry Noodles], $item[Fancy Schmancy Cheese Sauce]);
					}
					else if((item_amount($item[Bubblin\' Crude]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						craft("cook", 1, $item[Dry Noodles], $item[Bubblin\' Crude]);
					}
					else if((item_amount($item[Ectoplasmic Orbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						craft("cook", 1, $item[Dry Noodles], $item[Ectoplasmic Orbs]);
					}
					else if((item_amount($item[Pestopiary]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						craft("cook", 1, $item[Dry Noodles], $item[Pestopiary]);
					}
					else if((item_amount($item[Salacious Crumbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						craft("cook", 1, $item[Dry Noodles], $item[Salacious Crumbs]);
					}
				}
				dealWithMilkOfMagnesium(true);
				foreach it in toEat
				{
					while((canEat > 0) && (item_amount(it) > 0))
					{
						ccEat(1, it);
						canEat = canEat - 1;
					}
				}
			}
		}

		if((my_adventures() < 4) && (my_fullness() == 0) && (my_level() >= 6) && (item_amount($item[Boris\'s Key Lime Pie]) > 0) && (item_amount($item[Jarlsberg\'s Key Lime Pie]) > 0) && (item_amount($item[Sneaky Pete\'s Key Lime Pie]) > 0) && !in_hardcore())
		{
			dealWithMilkOfMagnesium(true);
			buffMaintain($effect[Got Milk], 0, 1, 1);
			ccEat(1, $item[Boris\'s Key Lime Pie]);
			ccEat(1, $item[Jarlsberg\'s Key Lime Pie]);
			ccEat(1, $item[Sneaky Pete\'s Key Lime Pie]);
			tryPantsEat();
			tryPantsEat();
			tryPantsEat();
		}

		if((fullness_limit() > 15) && (my_fullness() < fullness_limit()))
		{
			tryCookies();
			if((my_adventures() < 5) && (my_spleen_use() == 15) && (my_inebriety() >= 14))
			{
				tryPantsEat();
			}
		}

		if((my_spleen_use() == 4) && (item_amount($item[carrot nose]) > 0))
		{
			use(1, $item[carrot nose]);
			chew(1, $item[carrot juice]);
		}

		if(in_hardcore())
		{
			while((my_spleen_use() <= 11) && (item_amount($item[Unconscious Collective Dream Jar]) > 0))
			{
				chew(1, $item[Unconscious Collective Dream Jar]);
			}
			while((my_spleen_use() <= 11) && (item_amount($item[Powdered Gold]) > 0))
			{
				chew(1, $item[Powdered Gold]);
			}
			while((my_spleen_use() <= 11) && (item_amount($item[Grim Fairy Tale]) > 0))
			{
				chew(1, $item[Grim Fairy Tale]);
			}
		}

		if(((my_spleen_use() >= 4) && (my_spleen_use() < 7)) || ((my_spleen_use() >= 12) && (my_spleen_use() < 15)))
		{
			if(item_amount($item[tenderizing hammer]) == 0)
			{
				buyUpTo(1, $item[tenderizing hammer]);
			}
			pulverizeThing($item[oversized pizza cutter]);
			pulverizeThing($item[giant artisanal rice peeler]);
			pulverizeThing($item[magilaser blastercannon]);
			pulverizeThing($item[giant discarded bottlecap]);
			pulverizeThing($item[spiked femur]);
			pulverizeThing($item[broken sword]);
			pulverizeThing($item[curmudgel]);
			pulverizeThing($item[giant turkey leg]);
			pulverizeThing($item[glowing red eye]);
			if(item_amount($item[hot wad]) > 0)
			{
				chew(1, $item[hot wad]);
			}
			else if(item_amount($item[stench wad]) > 0)
			{
				chew(1, $item[stench wad]);
			}
			else if(item_amount($item[twinkly wad]) > 0)
			{
				chew(1, $item[twinkly wad]);
			}
			else if((item_amount($item[twinkly nuggets]) >= 5) && ((my_class() == $class[Seal Clubber]) || (my_class() == $class[Turtle Tamer])))
			{
				cli_execute("make 1 twinkly wad");
				chew(1, $item[twinkly wad]);
			}
		}

		if((my_fullness() >= 15) && ((my_spleen_use() == 7) || (my_level() == 10)) && (my_inebriety() >= 14) && (my_adventures() < 5))
		{
			if((item_amount($item[astral energy drink]) > 0) && (my_spleen_use() <= 7))
			{
				chew(1, $item[astral energy drink]);
			}
		}
	}
	else if(my_daycount() == 2)
	{
		if((my_level() >= 7) && (my_fullness() == 0) && ((my_adventures() < 10) || (get_counters("Fortune Cookie", 0, 5) == "Fortune Cookie") || (get_counters("Fortune Cookie", 0, 200) != "Fortune Cookie") || (get_property("middleChamberUnlock").to_boolean())) && !in_hardcore())
		{
			dealWithMilkOfMagnesium(true);
			buffMaintain($effect[Got Milk], 0, 1, 1);

			if(towerKeyCount() == 3)
			{
				ccEat(3, whatHiMein());
			}
			if(get_property("cc_useCubeling").to_boolean())
			{
				int count = towerKeyCount();
				if(get_property("cc_phatloot").to_int() < my_daycount())
				{
					count = count + 1;
				}
				if(count >= 2)
				{
					if(item_amount($item[Spaghetti Breakfast]) > 0)
					{
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, $item[Spaghetti Breakfast]);
					}
					pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
					if(item_amount($item[Boris\'s Key Lime Pie]) > 0)
					{
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, $item[Boris\'s Key Lime Pie]);
					}
					pullXWhenHaveY(whatHiMein(), 2, 0);
					if(item_amount(whatHiMein()) > 0)
					{
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, whatHiMein());
					}
					if(item_amount(whatHiMein()) > 0)
					{
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, whatHiMein());
					}
				}
			}
			else if(!get_property("cc_useCubeling").to_boolean())
			{
				ccEat(1, $item[Boris\'s Key Lime Pie]);
				ccEat(1, $item[Jarlsberg\'s Key Lime Pie]);
				ccEat(1, $item[Sneaky Pete\'s Key Lime Pie]);
				#cli_execute("eat 1 video games hot dog");
				if(my_fullness() != 15)
				{
					tryPantsEat();
					tryPantsEat();
					tryPantsEat();
				}
			}
		}

		if(in_hardcore() && isGuildClass())
		{
			if(((my_fullness() + 6) <= fullness_limit()) && (my_level() >= 6) && ovenHandle())
			{
				if(item_amount($item[Hell Broth]) == 0)
				{
					while((item_amount($item[Hellion Cube]) > 0) && (item_amount($item[Scrumptious Reagent]) > 0) && (item_amount($item[Hell Broth]) < 2))
					{
						cli_execute("make Hell Broth");
					}
				}
				while((item_amount($item[Hell Broth]) > 0) && (item_amount($item[Dry Noodles]) > 0) && (item_amount($item[Hell Ramen]) < 2))
				{
					cli_execute("make Hell Ramen");
				}

				while((item_amount($item[Hell Ramen]) > 0) && ((my_fullness() + 6) <= fullness_limit()))
				{
					dealWithMilkOfMagnesium(true);
					ccEat(1, $item[Hell Ramen]);
				}
			}
		}


		if((fullness_limit() >= 15) && (my_fullness() < fullness_limit()))
		{
			tryCookies();
			if((my_adventures() < 5) && (my_spleen_use() == 15) && (my_inebriety() >= 14))
			{
				tryPantsEat();
			}
		}

		if((my_inebriety() == 0) && (my_mp() >= mpForOde) && (my_meat() > 300) && (item_amount($item[handful of smithereens]) >= 2))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 4);
			cli_execute("make 2 paint a vulgar pitcher");
			drink(2, $item[paint a vulgar pitcher]);
		}

		if((my_inebriety() == 4) && (my_mp() >= mpForOde) && (my_meat() > 150) && (item_amount($item[handful of smithereens]) >= 1))
		{
			shrugAT();
			cli_execute("make 1 paint a vulgar pitcher");
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}

		if((my_inebriety() <= 9) && (my_adventures() < 10) && (my_meat() > 150) && (my_mp() >= mpForOde))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 4);
			if(item_amount($item[handful of smithereens]) > 0)
			{
				cli_execute("make 1 paint a vulgar pitcher");
				drink(1, $item[paint a vulgar pitcher]);
			}
			else if(my_meat() > 35000)
			{
				visit_url("clan_viplounge.php?action=speakeasy");
				cli_execute("drink flivver");
			}
		}

		if((get_property("cc_nunsTrick") == "got") && (get_property("currentNunneryMeat").to_int() < 100000))
		{
			if((get_property("cc_mcmuffin") == "ed") || (get_property("cc_mcmuffin") == "finished"))
			{
				if((my_inebriety() >= 6) && (my_inebriety() <= 11) && (my_mp() >= mpForOde))
				{
					if(item_amount($item[ambitious turkey]) > 0)
					{
						shrugAT();
						buffMaintain($effect[Ode to Booze], 50, 1, 1);
						drink(1, $item[ambitious turkey]);
					}
				}
			}
		}


		if(in_hardcore() && (my_mp() > mpForOde) && (item_amount($item[Pixel Daiquiri]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Pixel Daiquiri]);
		}

		if((my_level() >= 11) && (my_mp() > mpForOde) && (item_amount($item[Cold One]) > 1) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(2, $item[Cold One]);
		}

		if((my_inebriety() >= 6) && (my_inebriety() <= 11) && (get_property("cc_orchard") == "finished") && (my_mp() >= mpForOde))
		{
			if((get_property("cc_nuns") != "finished") && (get_property("cc_nuns") != "done") && (get_property("currentNunneryMeat").to_int() == 0))
			{
				if(item_amount($item[ambitious turkey]) > 0)
				{
					shrugAT();
					buffMaintain($effect[Ode to Booze], 50, 1, 1);
					drink(1, $item[ambitious turkey]);
				}
			}
		}

		if((my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}

		if((my_path() == "Picky") && (my_mp() > mpForOde) && (my_inebriety() <= inebriety_limit()) && (my_meat() > 500) && (get_property("_speakeasyDrinksDrunk").to_int() < 3))
		{
			# We could check for good drinks here but I don't know what would be good checks
			int canDrink = inebriety_limit() - my_inebriety();

			#Consider Ish Kabibble for A-Boo Peak (2)
			visit_url("clan_viplounge.php?action=speakeasy");

			#item toDrink = $item[none];
			string toDrink = "";
			if(canDrink >= 2)
			{
				toDrink = "Bee's Knees";
			}
			else if(canDrink >= 1)
			{
				toDrink = "glass of \"milk\"";
			}

			#if(toDrink != $item[none])
			if(toDrink != "")
			{
				shrugAT();
				buffMaintain($effect[Ode to Booze], 50, 1, 4);
				cli_execute("drink 1 " + toDrink);
				print("drink 1 " + toDrink);
			}
		}

/*****	This section needs to merge into a "Standard equivalent"		*****/
		if((my_path() == "Standard") && (my_mp() >= mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((my_path() == "Standard") && (my_mp() >= mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}

		if((my_path() == "Standard") && (my_mp() >= mpForOde) && (my_inebriety() <= inebriety_limit()) && (my_meat() > 500) && (get_property("_speakeasyDrinksDrunk").to_int() < 3))
		{
			# We could check for good drinks here but I don't know what would be good checks
#			int canDrink = inebriety_limit() - my_inebriety();

			#Consider Ish Kabibble for A-Boo Peak (2)
#			visit_url("clan_viplounge.php?action=speakeasy");

			#item toDrink = $item[none];
#			string toDrink = "";
#			if(canDrink >= 2)
#			{
#				toDrink = "Bee's Knees";
#			}
#			else if(canDrink >= 1)
#			{
#				toDrink = "glass of \"milk\"";
#			}

			#if(toDrink != $item[none])
#			if(toDrink != "")
#			{
#				shrugAT();
#				buffMaintain($effect[Ode to Booze], 50, 1, 4);
#				cli_execute("drink 1 " + toDrink);
#				print("drink 1 " + toDrink);
#			}
		}


/*****	End of Standard equivalent secton								*****/


		if((my_level() >= 11) && (my_spleen_use() == 0) && (item_amount($item[astral energy drink]) >= 2))
		{
			chew(1, $item[astral energy drink]);
			use(1, $item[mojo filter]);
			chew(1, $item[astral energy drink]);
		}
	}
	else if(my_daycount() == 3)
	{
		if((my_level() >= 7) && (my_fullness() == 0) && (my_adventures() < 10))
		{
			dealWithMilkOfMagnesium(true);

			if(item_amount($item[Star Key Lime Pie]) >= 3)
			{
				buffMaintain($effect[Got Milk], 0, 1, 1);
				ccEat(3, $item[Star Key Lime Pie]);
				tryPantsEat();
				tryPantsEat();
				tryPantsEat();
			}
			else
			{
				pullXWhenHaveY(whatHiMein(), 3, 0);
				if(item_amount(whatHiMein()) >= 3)
				{
					buffMaintain($effect[Got Milk], 0, 1, 1);
					eatsilent(3, whatHiMein());
				}
			}
		}

		if((item_amount($item[handful of smithereens]) > 0) && (my_meat() > 300))
		{
			cli_execute("make paint a vulgar pitcher");
		}

		if((my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}

		if((my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}
	}
}

void handleJar()
{
	if(item_amount($item[psychoanalytic jar]) > 0)
	{
		if(item_amount($item[jar of psychoses (The Crackpot Mystic)]) == 0)
		{
			visit_url("shop.php?whichshop=mystic&action=jung&whichperson=mystic", true);
		}
		else
		{
			put_closet(1, $item[psychoanalytic jar]);
		}
	}
}

boolean L12_nunsTrickGlandGet()
{
	if(get_property("sidequestOrchardCompleted") != "none")
	{
		return false;
	}
	if(get_property("cc_nunsTrickGland") != "start")
	{
		return false;
	}
	if(have_effect($effect[Everything looks yellow]) != 0)
	{
		return false;
	}
	if(get_property("cc_100familiar").to_boolean())
	{
		return false;
	}
	if((my_lightning() < 5) && (my_path() == "Heavy Rains"))
	{
		return false;
	}
	cli_execute("outfit war hippy fatigues");
	if(my_path() != "Heavy Rains")
	{
		handleFamiliar($familiar[Crimbo Shrub]);
		if((my_familiar() == $familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
		{
			visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
			visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=1&lights=1&garland=1&gift=1");
		}
	}
	if(item_amount($item[Filthworm Hatchling Scent Gland]) > 0)
	{
		set_property("cc_nunsTrickGland", "done");
		return true;
	}
	ccAdv(1, $location[The Hatching Chamber]);
	if(item_amount($item[Filthworm Hatchling Scent Gland]) > 0)
	{
		set_property("cc_nunsTrickGland", "done");
	}
	return true;
}

boolean L12_finalizeWar()
{
	if(get_property("cc_war") != "done")
	{
		return false;
	}
	if(my_level() < 12)
	{
		return false;
	}

	if(have_outfit("War Hippy Fatigues"))
	{
		print("Getting dimes.", "blue");
		sell($item[padl phone].buyer, item_amount($item[padl phone]), $item[padl phone]);
		sell($item[red class ring].buyer, item_amount($item[red class ring]), $item[red class ring]);
		sell($item[blue class ring].buyer, item_amount($item[blue class ring]), $item[blue class ring]);
		sell($item[white class ring].buyer, item_amount($item[white class ring]), $item[white class ring]);
	}
	if(have_outfit("Frat Warrior Fatigues"))
	{
		print("Getting quarters.", "blue");
		sell($item[pink clay bead].buyer, item_amount($item[pink clay bead]), $item[pink clay bead]);
		sell($item[purple clay bead].buyer, item_amount($item[purple clay bead]), $item[purple clay bead]);
		sell($item[green clay bead].buyer, item_amount($item[green clay bead]), $item[green clay bead]);
		sell($item[communications windchimes].buyer, item_amount($item[communications windchimes]), $item[communications windchimes]);
	}

	if(!get_property("cc_hippyInstead").to_boolean())
	{
		while($coinmaster[Dimemaster].available_tokens >= 2)
		{
			cli_execute("make filthy poultice");
		}
	}
	else
	{
		while($coinmaster[Quartersmaster].available_tokens >= 2)
		{
			cli_execute("make gauze garter");
		}
	}

	int have = item_amount($item[filthy poultice]) + item_amount($item[gauze garter]);
	if(have < 10)
	{
		int need = 10 - have;
		if(!get_property("cc_hippyInstead").to_boolean())
		{
			need = min(need, $coinmaster[Quartersmaster].available_tokens / 2);
			cli_execute("make " + need + " gauze garter");
		}
		else
		{
			need = min(need, $coinmaster[Dimemaster].available_tokens / 2);
			cli_execute("make " + need + " filthy poultice");
		}
	}


	if(have_outfit("War Hippy Fatigues"))
	{
		while($coinmaster[Dimemaster].available_tokens >= 5)
		{
			cli_execute("make " + $coinmaster[Dimemaster].available_tokens/5 + " fancy seashell necklace");
		}
		while($coinmaster[Dimemaster].available_tokens >= 2)
		{
			cli_execute("make " + $coinmaster[Dimemaster].available_tokens/2 + " filthy poultice");
		}
		while($coinmaster[Dimemaster].available_tokens >= 1)
		{
			cli_execute("make " + $coinmaster[Dimemaster].available_tokens + " water pipe bomb");
		}
	}

	if(have_outfit("Frat Warrior Fatigues"))
	{
		while($coinmaster[Quartersmaster].available_tokens >= 5)
		{
			cli_execute("make " + $coinmaster[Quartersmaster].available_tokens/5 + " commemorative war stein");
		}
		while($coinmaster[Quartersmaster].available_tokens >= 2)
		{
			cli_execute("make " + $coinmaster[Quartersmaster].available_tokens/2 + " gauze garter");
		}
		while($coinmaster[Quartersmaster].available_tokens >= 1)
		{
			cli_execute("make " + $coinmaster[Quartersmaster].available_tokens + " beer bomb");
		}
	}

	if(my_mp() < 40)
	{
		if(possessEquipment($item[Pantsgiving]))
		{
			equip($item[pantsgiving]);
		}
		doRest();
	}
	warOutfit();
	cli_execute("refresh equip");
	if(my_hp() < my_maxhp())
	{
		print("My hp is: " + my_hp());
		print("My max hp is: " + my_maxhp());
		useCocoon();
	}
	print("Let's fight the boss!", "blue");
	visit_url("bigisland.php?place=camp&whichcamp=1");
	visit_url("bigisland.php?place=camp&whichcamp=2");
	visit_url("bigisland.php?action=bossfight&pwd");
	ccAdv(1, $location[Noob Cave]);
	council();
	set_property("cc_war", "finished");
	return true;
}

boolean LX_getDigitalKey()
{
	if(contains_text(get_property("nsTowerDoorKeysUsed"), "digital key"))
	{
		return false;
	}
	if(((get_property("cc_war") != "finished") && (item_amount($item[rock band flyers]) == 0)))
	{
		return false;
	}
	while((item_amount($item[Red Pixel]) > 0) && (item_amount($item[Blue Pixel]) > 0) && (item_amount($item[Green Pixel]) > 0) && (item_amount($item[White Pixel]) < 30))
	{
		cli_execute("make white pixel");
	}
	if((item_amount($item[white pixel]) >= 30) || (item_amount($item[Digital Key]) > 0))
	{
		if(have_effect($effect[consumed by fear]) > 0)
		{
			uneffect($effect[Consumed By Fear]);
			council();
		}
		return false;
	}


	if(get_property("cc_crackpotjar") == "")
	{
		if(item_amount($item[jar of psychoses (The crackpot mystic)]) == 0)
		{
			pullXWhenHaveY($item[jar of psychoses (the Crackpot Mystic)], 1, 0);
		}
		if(item_amount($item[jar of psychoses (The crackpot mystic)]) == 0)
		{
			set_property("cc_crackpotjar", "fail");
		}
		else
		{
			woods_questStart();
			use(1, $item[jar of psychoses (The crackpot mystic)]);
			set_property("cc_crackpotjar", "done");
		}
	}
	print("Getting white pixels: Have " + item_amount($item[white pixel]), "blue");
	#if(item_amount($item[white pixel]) >= 27)
	#{
	#	abort("Can we pull any pixels?");
	#}
	if(get_property("cc_crackpotjar") == "done")
	{
		set_property("choiceAdventure644", 3);
		ccAdv(1, $location[Fear Man\'s Level]);
		if(have_effect($effect[consumed by fear]) == 0)
		{
			print("Well, we don't seem to have further access to the Fear Man area so... abort that plan", "red");
			set_property("cc_crackpotjar", "fail");
		}
	}
	else if(get_property("cc_crackpotjar") == "fail")
	{
		woods_questStart();
		equip($slot[acc2], $item[Continuum Transfunctioner]);
		ccAdv(1, $location[8-bit Realm]);
	}
	return true;
}

boolean L11_getBeehive()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(!get_property("cc_getBeehive").to_boolean())
	{
		return false;
	}

	print("Must find a beehive!", "blue");

	set_property("choiceAdventure923", "1");
	set_property("choiceAdventure924", "3");
	set_property("choiceAdventure1018", "1");
	set_property("choiceAdventure1019", "1");

	handleBjornify($familiar[grimstone golem]);
	buffMaintain($effect[The Sonata of Sneakiness], 20, 1, 1);
	buffMaintain($effect[Smooth Movements], 10, 1, 1);

	ccAdv(1, $location[The Black Forest]);
	if(item_amount($item[beehive]) > 0)
	{
		set_property("cc_getBeehive", false);
	}
	return true;
}

boolean L12_orchardStart()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_orchard") != "")
	{
		return false;
	}
	if((get_property("hippiesDefeated").to_int() < 64) && !get_property("cc_hippyInstead").to_boolean())
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	set_property("cc_orchard", "start");
	return true;
}

boolean L12_orchardFinalize()
{
	if(get_property("cc_orchard") != "done")
	{
		return false;
	}
	set_property("cc_orchard", "finished");
	if(item_amount($item[A Light that Never Goes Out]) > 0)
	{
		pulverizeThing($item[A Light that Never Goes Out]);
	}
	warOutfit();
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	return true;
}


boolean L10_plantThatBean()
{
	if((my_level() < 10) || (get_property("cc_bean") != ""))
	{
		return false;
	}
	council();
	print("Planting me magic bean!", "blue");
	string page = visit_url("place.php?whichplace=plains");
	if(contains_text(page, "place.php?whichplace=beanstalk"))
	{
		print("I have no bean but I see a stalk here. Okies. I'm ok with that", "blue");
		set_property("cc_bean", "plant");
		visit_url("place.php?whichplace=beanstalk");
		return true;
	}
	use(1, $item[enchanted bean]);
	set_property("cc_bean", "plant");
	return true;
}

boolean L10_holeInTheSkyUnlock()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(!get_property("cc_holeinthesky").to_boolean())
	{
		return false;
	}
	if(item_amount($item[steam-powered model rocketship]) > 0)
	{
		set_property("cc_holeinthesky", false);
	}

	print("Castle Top Floor - Opening the Hole in the Sky", "blue");
	set_property("choiceAdventure677", 2);
	set_property("choiceAdventure675", 4);
	set_property("choiceAdventure678", 3);
	set_property("choiceAdventure676", 4);

	handleInitFamiliar();
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
	handleFamiliar($familiar[Adventurous Spelunker]);
	return true;
}

boolean L10_topFloor()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castletop") != "")
	{
		return false;
	}

	print("Castle Top Floor", "blue");
	set_property("choiceAdventure677", 1);
	set_property("choiceAdventure675", 4);
	set_property("choiceAdventure678", 3);
	set_property("choiceAdventure676", 4);

	if((item_amount($item[mohawk wig]) == 0) && !in_hardcore())
	{
		pullXWhenHaveY($item[Mohawk Wig], 1, 0);
	}
	if(item_amount($item[Mohawk Wig]) > 0)
	{
		equip($item[mohawk wig]);
	}
	set_property("choiceAdventure678", 1);
	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure679", 2);
	}
	else
	{
		set_property("choiceAdventure679", 1);
	}

	handleInitFamiliar();
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
	handleFamiliar($familiar[Adventurous Spelunker]);

	if(contains_text(get_property("lastEncounter"), "Keep On Turnin\' the Wheel in the Sky"))
	{
		set_property("cc_castletop", "finished");
		council();
	}
	if(contains_text(get_property("lastEncounter"), "Copper Feel"))
	{
		set_property("cc_castletop", "finished");
		council();
	}
	return true;
}

boolean L10_ground()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(internalQuestStatus("questL10Garbage") > 8)
	{
		set_property("cc_castleground", "finished");
	}
	if(get_property("cc_castleground") != "")
	{
		return false;
	}


	print("Castle Ground Floor, boring!", "blue");
	set_property("choiceAdventure672", 3);
	set_property("choiceAdventure673", 3);
	set_property("choiceAdventure674", 3);
	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure1026", 3);
	}
	else
	{
		if(item_amount($item[electric boning knife]) > 0)
		{
			set_property("choiceAdventure1026", 3);
		}
		else
		{
			set_property("choiceAdventure1026", 2);
		}
	}

	handleInitFamiliar();
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Ground Floor)]);
	handleFamiliar($familiar[Adventurous Spelunker]);

	if(contains_text(get_property("lastEncounter"), "Top of the Castle, Ma"))
	{
		set_property("cc_castleground", "finished");
	}
	return true;
}

boolean L10_basement()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castlebasement") != "")
	{
		return false;
	}
	print("Basement Search", "blue");
	set_property("choiceAdventure669", "1");
	set_property("choiceAdventure670", "5");
	set_property("choiceAdventure671", "4");

	if(my_primestat() == $stat[Muscle])
	{
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}
	buyUpTo(1, $item[Hair Spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

	if(item_amount($item[titanium assault umbrella]) == 1)
	{
		set_property("choiceAdventure669", "4");
	}
	else
	{
		set_property("choiceAdventure669", "1");
	}

	handleInitFamiliar();
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
	handleFamiliar($familiar[Adventurous Spelunker]);

	if((contains_text(get_property("lastEncounter"), "The Fast and the Furry-ous")) && (item_amount($item[titanium assault umbrella]) == 1))
	{
		print("We was fast and furry-ous!", "blue");
		equip($item[titanium assault umbrella]);
		set_property("choiceAdventure669", "1");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		set_property("cc_castlebasement", "finished");
	}
	else if(contains_text(get_property("lastEncounter"), "You Don\'t Mess Around with Gym"))
	{
		print("Just messed with Gym", "blue");
		set_property("choiceAdventure670", "5");
		if(item_amount($item[amulet of extreme plot significance]) == 0)
		{
			if(in_hardcore() && !possessEquipment($item[Amulet of Extreme Plot Significance]))
			{
				print("Backfarming an Amulet of Extreme Plot Significance, sigh :(", "blue");
				ccAdv(1, $location[The Penultimate Fantasy Airship]);
				return true;
			}
			else
			{
				pullXWhenHaveY($item[Amulet of Extreme Plot Significance], 1, 0);
			}
		}
		equip($slot[acc3], $item[amulet of extreme plot significance]);
		set_property("choiceAdventure670", "4");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		set_property("cc_castlebasement", "finished");
	}
	return true;
}

boolean L10_airship()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(item_amount($item[S.O.C.K.]) == 1)
	{
		set_property("cc_airship", "finished");
	}
	if(get_property("cc_airship") != "")
	{
		return false;
	}

	visit_url("clan_viplounge.php?preaction=goswimming&subaction=submarine");
	print("Fantasy Airship Fly Fly time", "blue");
	if(my_mp() > 60)
	{
		handleBjornify($familiar[grimstone golem]);
	}

	if(item_amount($item[model airship]) == 0)
	{
		set_property("choiceAdventure182", "4");
	}
	else
	{
		set_property("choiceAdventure182", "1");
	}

	if((my_daycount() == 1) && (get_property("_hipsterAdv").to_int() < 7) && is_unrestricted($familiar[Artistic Goth Kid]))
	{
		print("Hipster Adv: " + get_property("_hipsterAdv"), "blue");
		handleFamiliar($familiar[Artistic Goth Kid]);
	}

	if((item_amount($item[mohawk wig]) == 0) && (have_effect($effect[Everything Looks Yellow]) == 0))
	{
		handleFamiliar($familiar[Crimbo Shrub]);
		if((my_familiar() == $familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
		{
			visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
			visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=1&lights=1&garland=1&gift=1");
		}
	}

	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
	buffMaintain($effect[Snow Shoes], 0, 1, 1);
	buffMaintain($effect[Fishy\, Oily], 0, 1, 1);

	ccAdv(1, $location[The Penultimate Fantasy Airship]);
	handleFamiliar($familiar[Adventurous Spelunker]);
	return true;
}

boolean Lsc_flyerSeals()
{
	if(my_class() != $class[Seal Clubber])
	{
		return false;
	}
	if(get_property("cc_prewar") != "started")
	{
		return false;
	}
	if(get_property("flyeredML") >= 10000)
	{
		return false;
	}
	if(item_amount($item[Rock Band Flyers]) == 0)
	{
		return false;
	}
	if(get_property("choiceAdventure1003").to_int() >= 3)
	{
		return false;
	}

	if((get_property("_sealsSummoned").to_int() < 5) && (my_meat() > 500))
	{
		element towerTest = ns_crowd3();
		boolean doElement = false;
		if(item_amount($item[powdered sealbone]) > 0)
		{
			if((towerTest == $element[cold]) && (item_amount($item[frost-rimed seal hide]) < 2) && (item_amount($item[figurine of a cold seal]) > 0))
			{
				doElement = true;
			}
			if((towerTest == $element[hot]) && (item_amount($item[sizzling seal fat]) < 2) && (item_amount($item[figurine of a charred seal]) > 0))
			{
				doElement = true;
			}
			if((towerTest == $element[sleaze]) && (item_amount($item[seal lube]) < 2) && (item_amount($item[figurine of a slippery seal]) > 0))
			{
				doElement = true;
			}
			if((towerTest == $element[spooky]) && (item_amount($item[scrap of shadow]) < 2) && (item_amount($item[figurine of a shadowy seal]) > 0))
			{
				doElement = true;
			}
			if((towerTest == $element[stench]) && (item_amount($item[fustulent seal grulch]) < 2) && (item_amount($item[figurine of a stinking seal]) > 0))
			{
				doElement = true;
			}
		}

		handleInitFamiliar();
		if(doElement)
		{
			if(item_amount($item[imbued seal-blubber candle]) == 0)
			{
				buyUpTo(1, $item[seal-blubber candle]);
				cli_execute("make imbued seal-blubber candle");
			}
			handleSealElement(towerTest);
		}
		else
		{
			buyUpTo(1, $item[figurine of an armored seal]);
			buyUpTo(10, $item[seal-blubber candle]);
			handleSealArmored();
		}
		if((item_amount($item[bad-ass club]) == 0) && (item_amount($item[ingot of seal-iron]) > 0))
		{
			use(1, $item[ingot of seal-iron]);
		}
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}
	return false;
}

boolean L0_handleRainDoh()
{
	if(item_amount($item[rain-doh box full of monster]) == 0)
	{
		return false;
	}
	if(my_level() <= 3)
	{
		return false;
	}
	if(have_effect($effect[ultrahydrated]) > 0)
	{
		return false;
	}

	monster enemy = to_monster(get_property("rainDohMonster"));
	print("Black boxing: " + enemy, "blue");

	if(enemy == $monster[Ninja Snowman Assassin])
	{
		int count = item_amount($item[ninja rope]);
		count += item_amount($item[ninja crampons]);
		count += item_amount($item[ninja carabiner]);

		if((count <= 1) && (get_property("_raindohCopiesMade").to_int() < 5))
		{
			set_property("cc_doCombatCopy", "yes");
		}
		handleRainDoh();
		if(last_monster() != $monster[ninja snowman assassin])
		{
			abort("Now sure what exploded, tried to summon copy of " + enemy + " but got " + last_monster() + " instead.");
		}
		set_property("cc_doCombatCopy", "no");
		if(count == 3)
		{
			set_property("cc_ninjasnowmanassassin", "1");
		}
		return true;
	}
	if(enemy == $monster[Ghost])
	{
		int count = item_amount($item[white pixel]);
		count += 30 * item_amount($item[digital key]);

		if((count <= 20) && (get_property("_raindohCopiesMade").to_int() < 5))
		{
			set_property("cc_doCombatCopy", "yes");
		}
		handleRainDoh();
		if(last_monster() != $monster[ghost])
		{
			abort("Now sure what exploded, tried to summon copy of " + enemy + " but got " + last_monster() + " instead.");
		}
		set_property("cc_doCombatCopy", "no");
		if(count > 20)
		{
		}
		return true;
	}
	if(enemy == $monster[Lobsterfrogman])
	{
		if((get_property("cc_hasrainman") == "") && (item_amount($item[barrel of gunpowder]) < 4))
		{
			set_property("cc_doCombatCopy", "yes");
		}
		handleRainDoh();
		if(last_monster() != $monster[lobsterfrogman])
		{
			abort("Now sure what exploded, tried to summon copy of " + enemy + " but got " + last_monster() + " instead.");
		}
		set_property("cc_doCombatCopy", "no");
		return true;
	}
	if(enemy == $monster[Skinflute])
	{
		int stars = item_amount($item[star]);
		int lines = item_amount($item[line]);

		if((stars < 7) && (lines < 6)  & (get_property("_raindohCopiesMade").to_int() < 5))
		{
			set_property("cc_doCombatCopy", "yes");
		}
		handleRainDoh();
		if(last_monster() != $monster[skinflute])
		{
			abort("Now sure what exploded, tried to summon copy of " + enemy + " but got " + last_monster() + " instead.");
		}
		set_property("cc_doCombatCopy", "no");
		return true;
	}

	/*	Should we check for an acceptable monster or just empty the box in that case?
	huge swarm of ghuol whelps, modern zmobie, gaudy pirate, writing desk, mountain man
	*/
	//If doesn\'t match a special condition
	if(enemy != $monster[none])
	{
		handleRainDoh();
		if(last_monster() != enemy)
		{
			abort("Now sure what exploded, tried to summon copy of " + enemy + " but got " + last_monster() + " instead.");
		}
		return true;
	}

	return false;
}


boolean LX_ornateDowsingRod()
{
	if(!get_property("cc_grimstoneOrnateDowsingRod").to_boolean())
	{
		return false;
	}
	if(possessEquipment($item[UV-resistant compass]))
	{
		print("You have a UV-resistant compass for some reason, I assume you don't want an Ornate Dowsing Rod.", "red");
		set_property("cc_grimstoneOrnateDowsingRod", false);
		return false;
	}
	if(my_adventures() <= 6)
	{
		return false;
	}
	if(item_amount($item[Grimstone Mask]) == 0)
	{
		return false;
	}
	if(my_daycount() < 2)
	{
		return false;
	}
	if(get_counters("", 0, 6) != "")
	{
		return false;
	}

	#Need to make sure we get our grimstone mask
	print("Acquiring a Dowsing Rod!", "blue");
	set_property("choiceAdventure829", "1");
	use(1, $item[grimstone mask]);

	set_property("choiceAdventure822", "1");
	set_property("choiceAdventure823", "1");
	set_property("choiceAdventure824", "1");
	set_property("choiceAdventure825", "1");
	set_property("choiceAdventure826", "1");
	while(item_amount($item[odd silver coin]) < 1)
	{
		ccAdv(1, $location[The Prince\'s Balcony]);
	}
	while(item_amount($item[odd silver coin]) < 2)
	{
		ccAdv(1, $location[The Prince\'s Dance Floor]);
	}
	while(item_amount($item[odd silver coin]) < 3)
	{
		ccAdv(1, $location[The Prince\'s Lounge]);
	}
	while(item_amount($item[odd silver coin]) < 4)
	{
		ccAdv(1, $location[The Prince\'s Kitchen]);
	}
	while(item_amount($item[odd silver coin]) < 5)
	{
		ccAdv(1, $location[The Prince\'s Restroom]);
	}

	cli_execute("make ornate dowsing rod");
	set_property("cc_grimstoneOrnateDowsingRod", false);
	set_property("choiceAdventure805", "1");
	return true;
}

boolean L7_crypt()
{
	if((my_level() < 7) || (get_property("cc_crypt") != ""))
	{
		return false;
	}
	if(item_amount($item[chest of the bonerdagon]) == 1)
	{
		set_property("cc_crypt", "finished");
		use(1, $item[chest of the bonerdagon]);
		return false;
	}
	oldPeoplePlantStuff();

	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	buffMaintain($effect[Browbeaten], 0, 1, 1);
	buffMaintain($effect[Rosewater Mark], 0, 1, 1);

	boolean edAlcove = true;
	if(my_class() == $class[Ed])
	{
		edAlcove = have_skill($skill[More Legs]);
	}

	if((get_property("cyrptAlcoveEvilness").to_int() > 0) && ((get_property("cyrptAlcoveEvilness").to_int() <= get_property("cc_waitingArrowAlcove").to_int()) || (get_property("cyrptAlcoveEvilness").to_int() <= 25)) && edAlcove)
	{
		if(have_familiar($familiar[Xiblaxian Holo-Companion]))
		{
			handleFamiliar($familiar[Xiblaxian Holo-Companion]);
		}
		else
		{
			handleFamiliar($familiar[Oily Woim]);
		}

		if((get_property("_badlyRomanticArrows") == "0") && have_familiar($familiar[Reanimated Reanimator]) && (my_daycount() == 1))
		{
			handleFamiliar($familiar[Reanimated Reanimator]);
		}

		buffMaintain($effect[Sepia Tan], 0, 1, 1);
		if((my_class() == $class[Seal Clubber]) || (my_class() == $class[Turtle Tamer]))
		{
			buyUpTo(1, $item[Cheap Wind-up Clock]);
			buffMaintain($effect[Ticking Clock], 0, 1, 1);
		}
		buffMaintain($effect[Song of Slowness], 110, 1, 1);
		buffMaintain($effect[Fishy\, Oily], 0, 1, 1);

		if((have_effect($effect[Soles of Glass]) == 0) && (get_property("_grimBuff") == false))
		{
			visit_url("choice.php?pwd&whichchoice=835&option=1", true);
		}

		print("The Alcove! (" + initiative_modifier() + ")", "blue");
		ccAdv(1, $location[The Defiled Alcove]);
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}

	if(get_property("cyrptNookEvilness").to_int() > 0)
	{
		print("The Nook!", "blue");
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		ccAdv(1, $location[The Defiled Nook]);
		if(item_amount($item[evil eye]) > 0)
		{
			use(1, $item[evil eye]);
		}
		return true;
	}

	if(get_property("cyrptNicheEvilness").to_int() > 0)
	{
		if((my_daycount() == 1) && (get_property("_hipsterAdv").to_int() < 7) && is_unrestricted($familiar[Artistic Goth Kid]))
		{
			handleFamiliar($familiar[Artistic Goth Kid]);
		}
		print("The Niche!", "blue");
		ccAdv(1, $location[The Defiled Niche]);

		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}

	if(get_property("cyrptCrannyEvilness").to_int() > 0)
	{
		print("The Cranny!", "blue");
		set_property("choiceAdventure523", "4");

		if(my_mp() > 60)
		{
			handleBjornify($familiar[grimstone golem]);
		}

		ccAdv(1, $location[The Defiled Cranny]);
		return true;
	}

	if(get_property("cyrptTotalEvilness").to_int() <= 0)
	{
		if(my_primestat() == $stat[Muscle])
		{
			buyUpTo(1, $item[Ben-Gal&trade; Balm]);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			buyUpTo(1, $item[Blood of the Wereseal]);
			buffMaintain($effect[Temporary Lycanthropy], 0, 1, 1);
		}

		useCocoon();
		set_property("choiceAdventure527", 1);
		boolean tryBoner = ccAdv(1, $location[Haert of the Cyrpt]);
		if(item_amount($item[chest of the bonerdagon]) == 1)
		{
			set_property("cc_crypt", "finished");
			use(1, $item[chest of the bonerdagon]);
		}
		else if(!tryBoner)
		{
			print("We tried to kill the Bonerdagon because the cyrpt was defiled but couldn't adventure there and the chest of the bonerdagon is gone so we can't check that. Anyway, we are going to assume the cyrpt is done now.", "red");
			set_property("cc_crypt", "finished");
		}
		else
		{
			abort("Failed to kill bonerdagon");
		}
		return true;
	}
	return false;
}

boolean L1_edIsland()
{
	return L1_edIsland(0);
}

boolean L1_edDinsey()
{
	if(my_class() != $class[Ed])
	{
		return false;
	}
	if(!elementalPlanes_access($element[stench]))
	{
		return false;
	}
	if(my_level() < 6)
	{
		return false;
	}
	if(!get_property("cc_dickstab").to_boolean())
	{
		return false;
	}
	if(possessEquipment($item[Sewage-Clogged Pistol]) && possessEquipment($item[Perfume-Soaked Bandana]))
	{
		return false;
	}
	ccAdv(1, $location[Pirates of the Garbage Barges]);
	return true;
}

boolean L1_edIsland(int dickstabOverride)
{
	if(my_class() != $class[Ed])
	{
		return false;
	}
	if(!elementalPlanes_access($element[spooky]))
	{
		return false;
	}

	skill blocker = $skill[Still Another Extra Spleen];
	if(get_property("cc_dickstab").to_boolean())
	{
		if(turns_played() > 22)
		{
			blocker = $skill[Replacement Liver];
			blocker = $skill[Okay Seriously, This is the Last Spleen];
			if((dickstabOverride == 0) || (my_level() >= dickstabOverride))
			{
				return false;
			}
		}
	}

	if((my_level() >= 10) || ((my_level() >= 8) && have_skill(blocker)))
	{
		return false;
	}
	if((my_level() >= 3) && !get_property("controlPanel9").to_boolean())
	{
		visit_url("place.php?whichplace=airport_spooky_bunker&action=si_controlpanel");
		visit_url("choice.php?pwd=&whichchoice=986&option=9",true);
	}
	if((my_level() >= 3) && !get_property("controlPanel9").to_boolean())
	{
		abort("Damn control panel is not set, WTF!!!");
	}

	#If we get some other CI quest, this might keep triggering, should we flag this?
	if((my_hp() > 20) && !possessEquipment($item[Gore Bucket]) && !possessEquipment($item[Encrypted Micro-Cassette Recorder]) && !possessEquipment($item[Military-Grade Fingernail Clippers]))
	{
		elementalPlanes_takeJob($element[spooky]);
		#visit_url("place.php?whichplace=airport_spooky&action=airport2_radio");
		#visit_url("choice.php?pwd&whichchoice=984&option=1", true);
		set_property("choiceAdventure988", 2);
	}

	if(item_amount($item[Gore Bucket]) > 0)
	{
		equip($item[Gore Bucket]);
	}

	if(item_amount($item[Personal Ventilation Unit]) > 0)
	{
		equip($slot[acc2], $item[Personal Ventilation Unit]);
	}
	if(possessEquipment($item[Gore Bucket]) && (get_property("goreCollected").to_int() >= 100))
	{
		visit_url("place.php?whichplace=airport_spooky&action=airport2_radio");
		visit_url("choice.php?pwd&whichchoice=984&option=1", true);
	}

	buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
	ccAdv(1, $location[The Secret Government Laboratory]);
	if(item_amount($item[Bottle-Opener Keycard]) > 0)
	{
		use(1, $item[Bottle-Opener Keycard]);
	}
	set_property("choiceAdventure988", 1);
	return true;
}


boolean L1_edIslandFallback()
{
	if(my_class() != $class[Ed])
	{
		return false;
	}
	if(elementalPlanes_access($element[spooky]))
	{
		return false;
	}

	if((my_level() >= 10) || ((my_level() >= 8) && have_skill($skill[Still Another Extra Spleen])))
	{
		return false;
	}
	if(elementalPlanes_access($element[stench]))
	{
		ccAdv(1, $location[Pirates of the Garbage Barges]);
		return true;
	}

	if(LX_islandAccess())
	{
		return true;
	}

	return ccAdv(1, $location[Hippy Camp]);
}

boolean LX_hardcoreFoodFarm()
{
	if(!in_hardcore() || !isGuildClass())
	{
		return false;
	}
	if(my_fullness() >= 11)
	{
		return false;
	}

	if(my_level() < 8)
	{
		return false;
	}

	int possMeals = item_amount($item[Goat Cheese]);
	possMeals = possMeals + item_amount($item[Bubblin\' Crude]);

	if((my_fullness() >= 5) && (possMeals > 0))
	{
		return false;
	}
	if(possMeals > 1)
	{
		return false;
	}

	if((my_daycount() >= 3) && (my_adventures() > 15))
	{
		return false;
	}
	if(my_daycount() >= 4)
	{
		return false;
	}

	if((my_level() >= 9) && ((get_property("cc_highlandlord") == "start") || (get_property("cc_highlandlord") == "finished")))
	{
		ccAdv(1, $location[Oil Peak]);
		return true;
	}
	if(my_level() >= 8)
	{
		ccAdv(1, $location[The Goatlet]);
	}

	return false;
}

boolean L6_friarsGetParts()
{
	if((my_level() < 6) || (get_property("cc_friars") != ""))
	{
		return false;
	}
	if(my_mp() > 50)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	if((my_daycount() == 1) && (get_property("_hipsterAdv").to_int() < 7) && (item_amount($item[hot wing]) >= 3) && is_unrestricted($familiar[Artistic Goth Kid]))
	{
		handleFamiliar($familiar[Artistic Goth Kid]);
	}
	buffMaintain($effect[Snow Shoes], 0, 1, 1);

	if(item_amount($item[box of birthday candles]) == 0)
	{
		print("Getting Box of Birthday Candles", "blue");
		ccAdv(1, $location[The Dark Heart of the Woods]);
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}

	if(item_amount($item[dodecagram]) == 0)
	{
		print("Getting Dodecagram", "blue");
		ccAdv(1, $location[The Dark Neck of the Woods]);
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}
	if(item_amount($item[eldritch butterknife]) == 0)
	{
		print("Getting Eldritch Butterknife", "blue");
		ccAdv(1, $location[The Dark Elbow of the Woods]);
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}
	handleFamiliar($familiar[Adventurous Spelunker]);
	print("Finishing friars", "blue");
	visit_url("friars.php?action=ritual&pwd");
	council();
	set_property("cc_friars", "done");
	return true;
}

boolean L6_friarsHotWing()
{
	if(get_property("cc_friars") != "done")
	{
		return false;
	}
	if((get_property("cc_pirateoutfit") == "almost") || (get_property("cc_pirateoutfit") == "finished") )
	{
		if(get_property("cc_friars") == "done")
		{
			set_property("cc_friars", "finished");
		}
		return false;
	}

	if(item_amount($item[hot wing]) >= 3)
	{
		set_property("cc_friars", "finished");
		return true;
	}

	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	print("Need more Hot Wings", "blue");
	if(my_class() == $class[Ed])
	{
		boolean status = ccAdv(1, $location[Pandamonium]);
		if(status == false)
		{
			print("Was unable to go to Pandamonium (438) in Ed. Uh oh. If we did, run me again and report this to the script writer", "blue");
		}
		return true;
	}
	ccAdv(1, $location[Pandamonium Slums]);
	return true;
}

boolean LX_fancyOilPainting()
{
	if(get_property("chasmBridgeProgress").to_int() >= 30)
	{
		return false;
	}
	if(my_adventures() <= 4)
	{
		return false;
	}
	if(item_amount($item[Grimstone Mask]) == 0)
	{
		return false;
	}
	if(!get_property("cc_grimstoneFancyOilPainting").to_boolean())
	{
		return false;
	}
	if(get_counters("", 0, 6) != "")
	{
		return false;
	}
	print("Acquiring a Fancy Oil Painting!", "blue");
	set_property("choiceAdventure829", "1");
	use(1, $item[grimstone mask]);
	set_property("choiceAdventure823", "1");
	set_property("choiceAdventure824", "1");
	set_property("choiceAdventure825", "1");
	set_property("choiceAdventure826", "1");

	while(item_amount($item[odd silver coin]) < 1)
	{
		ccAdv(1, $location[The Prince\'s Balcony]);
	}
	while(item_amount($item[odd silver coin]) < 2)
	{
		ccAdv(1, $location[The Prince\'s Dance Floor]);
	}
	while(item_amount($item[odd silver coin]) < 3)
	{
		ccAdv(1, $location[The Prince\'s Lounge]);
	}
	while(item_amount($item[odd silver coin]) < 4)
	{
		ccAdv(1, $location[The Prince\'s Kitchen]);
	}
	cli_execute("make fancy oil painting");
	set_property("cc_grimstoneFancyOilPainting", false);
	return true;
}

boolean L9_leafletQuest()
{
	if((my_level() < 9) || possessEquipment($item[Giant Pinky Ring]))
	{
		return false;
	}
	if(my_class() == $class[Ed])
	{
		return false;
	}
	if(get_campground() contains $item[Frobozz Real-Estate Company Instant House (TM)])
	{
		return false;
	}
	print("Got a leaflet to do", "blue");
	council();
	cli_execute("leaflet");
	use(1, $item[Frobozz Real-Estate Company Instant House (TM)]);
	return true;
}

boolean L8_trapperGround()
{
	if(get_property("cc_trapper") != "start")
	{
		return false;
	}

	#print("Starting Trapper Collection", "blue");
	item oreGoal = to_item(get_property("trapperOre"));

	if((item_amount(oreGoal) >= 3) && (item_amount($item[goat cheese]) >= 3))
	{
		print("Giving Trapper goat cheese and " + oreGoal, "blue");
		set_property("cc_trapper", "yeti");
		visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
		return true;
	}

	if(item_amount($item[goat cheese]) < 3)
	{
		print("Yay for goat cheese!", "blue");
		ccAdv(1, $location[The Goatlet]);
		return true;
	}

	if(item_amount(oreGoal) >= 3)
	{
		if(item_amount($item[goat cheese]) >= 3)
		{
			print("Giving Trapper goat cheese and " + oreGoal, "blue");
			set_property("cc_trapper", "yeti");
			visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
			return true;
		}
		print("Yay for goat cheese!", "blue");
		ccAdv(1, $location[The Goatlet]);
		return true;
	}
	else if((my_rain() > 50) && (have_effect($effect[Ultrahydrated]) == 0) && (my_path() == "Heavy Rains"))
	{
		print("Trying to summon a mountain man", "blue");
		set_property("cc_mountainmen", "1");
		rainManSummon("mountain man", false, false);
		return true;
	}
	else if(my_path() == "Heavy Rains")
	{
		#Do pulls instead if we don't possess rain man?
		print("Need Ore but not enough rain", "blue");
		return false;
	}
	else if(!in_hardcore())
	{
		if(pulls_remaining() > 0)
		{
			pullXWhenHaveY(oreGoal, 3 - item_amount(oreGoal), item_amount(oreGoal));
		}
	}
	return false;
}

boolean LX_guildUnlock()
{
	if(!in_hardcore() || !isGuildClass() || guild_store_available())
	{
		return false;
	}
	location loc = $location[None];
	item goal = $item[none];
	switch(my_primestat())
	{
		case $stat[Muscle] :
			set_property("choiceAdventure111", "3");//Malice in Chains -> Plot a cunning escape
			set_property("choiceAdventure113", "2");//Knob Goblin BBQ -> Kick the chef
			set_property("choiceAdventure118", "2");//When Rocks Attack -> "Sorry, gotta run."
			set_property("choiceAdventure120", "4");//Ennui is Wasted on the Young -> "Since you\'re bored, you\'re boring. I\'m outta here."
			set_property("choiceAdventure543", "1");//Up In Their Grill -> Grab the sausage, so to speak. I mean... literally.
			loc = $location[The Outskirts of Cobb\'s Knob];
			goal = $item[11-Inch Knob Sausage];
			break;
		case $stat[Mysticality]:
			set_property("choiceAdventure115", "1");//Oh No, Hobo -> Give him a beating
			set_property("choiceAdventure116", "4");//The Singing Tree (Rustling) -> "No singing, thanks."
			set_property("choiceAdventure117", "1");//Trespasser -> Tackle him
			set_property("choiceAdventure114", "2");//The Baker\'s Dilemma -> "Sorry, I\'m busy right now."
			set_property("choiceAdventure544", "1");//A Sandwich Appears! -> sudo exorcise me a sandwich
			loc = $location[The Haunted Pantry];
			goal = $item[Exorcised Sandwich];
			break;
		case $stat[Moxie]:
			goal = equipped_item($slot[pants]);
			set_property("choiceAdventure108", "4");//Aww, Craps -> Walk Away
			set_property("choiceAdventure109", "1");//Dumpster Diving -> Punch the hobo
			set_property("choiceAdventure110", "4");//The Entertainer -> Introduce them to avant-garde
			set_property("choiceAdventure112", "2");//Please, Hammer -> "Sorry, no time."
			set_property("choiceAdventure121", "2");//Under the Knife -> Umm, no thanks. Seriously.
			set_property("choiceAdventure542", "1");//Now\'s Your Pants! I Mean... Your Chance! -> Yoink
			if(goal != $item[none])
			{
				loc = $location[The Sleazy Back Alley];
			}
			break;
	}
	if(loc != $location[none])
	{
		ccAdv(1, loc);
		if(item_amount(goal) > 0)
		{
			visit_url("guild.php?place=challenge");
		}
		return true;
	}
	return false;
}

boolean L8_trapperStart()
{
	if((my_level() < 8) || (get_property("cc_trapper") != ""))
	{
		return false;
	}
	council();
	print("Let's meet the trapper.", "blue");

	visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
	set_property("cc_trapper", "start");
	return true;
}

boolean L5_goblinKing()
{
	if(get_property("cc_goblinking") == "finished")
	{
		return false;
	}
	if(my_level() < 8)
	{
		return false;
	}
	if(my_adventures() <= 2)
	{
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 3) == "Fortune Cookie")
	{
		return false;
	}
	if(!possessEquipment($item[Knob Goblin Harem Veil]) || !possessEquipment($item[Knob Goblin Harem Pants]))
	{
		return false;
	}

	print("Death to the gobbo!!", "blue");
	cli_execute("outfit knob goblin harem girl disguise");
	buffMaintain($effect[Knob Goblin Perfume], 0, 1, 1);
	if(have_effect($effect[Knob Goblin Perfume]) == 0)
	{
		ccAdv(1, $location[Cobb\'s Knob Harem]);
		if(contains_text(get_property("lastEncounter"), "Cobb's Knob lab key"))
		{
			ccAdv(1, $location[Cobb\'s Knob Harem]);
		}
		return true;
	}

	if(my_primestat() == $stat[Muscle])
	{
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}
	buyUpTo(1, $item[Hair Spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

	if((my_class() == $class[Seal Clubber]) || (my_class() == $class[Turtle Tamer]))
	{
		buyUpTo(1, $item[Blood of the Wereseal]);
		buffMaintain($effect[Temporary Lycanthropy], 0, 1, 1);
	}

	if(monster_level_adjustment() > 150)
	{
		equip($slot[acc2], $item[none]);
	}

	ccAdv(1, $location[Throne Room]);
	if(have_effect($effect[Beaten Up]) > 0)
	{
		return true;
	}
	if((item_amount($item[Crown of the Goblin King]) > 0) || (item_amount($item[Glass Balls of the Goblin King]) > 0) || (item_amount($item[Codpiece of the Goblin King]) > 0))
	{
		set_property("cc_goblinking", "finished");
		council();
	}
	if(item_amount($item[Goblin Water]) > 0)
	{
		set_property("cc_goblinking", "finished");
		council();
	}
	return true;
}

boolean L4_batCave()
{
	if(get_property("cc_bat") == "finished")
	{
		return false;
	}

	print("In the bat hole!", "blue");
	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);

	if(item_amount($item[sonar-in-a-biscuit]) > 0)
	{
		use(item_amount($item[sonar-in-a-biscuit]), $item[sonar-in-a-biscuit]);
		return true;
	}
	string batHole = visit_url("place.php?whichplace=bathole");

	if(contains_text(batHole, "bathole_bg5"))
	{
		if((item_amount($item[enchanted bean]) == 0) && (get_property("cc_bean") != "plant"))
		{
			ccAdv(1, $location[The Beanbat Chamber]);
			return true;
		}
		set_property("cc_bat", "finished");
		council();
		return true;
	}

	if(contains_text(batHole, "bathole_bg4"))
	{
		ccAdv(1, $location[The Boss Bat\'s Lair]);
		return true;
	}
	if(contains_text(batHole, "bathole_bg3"))
	{
		if((item_amount($item[enchanted bean]) == 0) && (get_property("cc_bean") != "plant"))
		{
			ccAdv(1, $location[The Beanbat Chamber]);
			return true;
		}
		ccAdv(1, $location[The Batrat and Ratbat Burrow]);
		return true;
	}
	if(contains_text(batHole, "bathole_bg2"))
	{
		ccAdv(1, $location[The Batrat and Ratbat Burrow]);
		return true;
	}

	buffMaintain($effect[Hide of Sobek], 10, 1, 1);
	buffMaintain($effect[Astral Shell], 10, 1, 1);
	buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
	if(elemental_resist($element[stench]) < 1)
	{
		if(possessEquipment($item[Knob Goblin Harem Veil]))
		{
			equip($item[Knob Goblin Harem Veil]);
		}
		else
		{
			return false;
		}
	}

	if((my_class() == $class[Ed]) && (item_amount($item[Disassembled Clover]) > 0))
	{
		use(1, $item[Disassembled Clover]);
		if(ccAdvBypass(31, $location[Guano Junction]))
		{
			print("Wandering monster interrupt at Guano Junction", "red");
			return true;
		}
		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		return true;
	}

	ccAdv(1, $location[Guano Junction]);
	return true;
}

boolean LX_islandAccess()
{
	if((item_amount($item[Shore Inc. Ship Trip Scrip]) >= 3) && (item_amount($item[Dingy Dinghy]) == 0) && (my_meat() >= 400))
	{
		cli_execute("make dinghy plans");
		buyUpTo(1, $item[dingy planks]);
		use(1, $item[dinghy plans]);
		return true;
	}
	if(item_amount($item[Dingy Dinghy]) > 0)
	{
		return false;
	}
	if((my_adventures() <= 9) || (my_meat() <= 1900))
	{
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
	{
		//Just check the Fortune Cookie counter not any others.
		return false;
	}

	print("At the shore, la de da!", "blue");
	if(my_primestat() == $stat[Muscle])
	{
		set_property("choiceAdventure793", "1");
	}
	else if(my_primestat() == $stat[Mysticality])
	{
		set_property("choiceAdventure793", "2");
	}
	else
	{
		set_property("choiceAdventure793", "3");
	}
	while((item_amount($item[Shore Inc. Ship Trip Scrip]) < 3) && (my_meat() > 500))
	{
		ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
	}
	if(item_amount($item[Shore Inc. Ship Trip Scrip]) < 3)
	{
		print("Failed to get enough Shore Scrip for some reason, continuing...", "red");
		return false;
	}

	if(my_meat() >= 400)
	{
		cli_execute("make dinghy plans");
		buyUpTo(1, $item[dingy planks]);
		use(1, $item[dinghy plans]);
		return true;
	}
	return false;
}

boolean LX_phatLootToken()
{
	if(!possessEquipment($item[Ring of Detect Boring Doors]) || (item_amount($item[Eleven-Foot Pole]) == 0) || (item_amount($item[Pick-O-Matic Lockpicks]) == 0))
	{
		return false;
	}
	if(my_level() > 13)
	{
		return false;
	}
	if(get_property("cc_sorceress") != "")
	{
		return false;
	}
	if(get_property("cc_phatloot").to_int() >= my_daycount())
	{
		return false;
	}
	if(towerKeyCount() >= 3)
	{
		return false;
	}
	if(my_adventures() <= 5)
	{
		return false;
	}
	if(get_property("cc_keysdone") != "")
	{
		return false;
	}
	print("Phat Loot Token Get!", "blue");
	set_property("choiceAdventure690", "2");
	set_property("choiceAdventure691", "2");
	set_property("choiceAdventure692", "3");
	set_property("choiceAdventure693", "2");
	equip($slot[acc3], $item[ring of detect boring doors]);
	ccAdv(1, $location[the daily dungeon]);
	cli_execute("unequip acc3");
	if(get_property("_lastDailyDungeonRoom").to_int() == 15)
	{
		set_property("cc_phatloot", "" + my_daycount());
	}
	return true;

}


boolean L2_treeCoin()
{
	if(get_property("cc_treecoin") == "finished")
	{
		return false;
	}
	print("Time for a tree-holed coin", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "2");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[tree-holed coin]) == 1)
	{
		set_property("cc_treecoin", "finished");
	}
	return true;
}

boolean L2_spookyMap()
{
	if(get_property("cc_spookymap") == "finished")
	{
		return false;
	}
	print("Need a spooky map now", "blue");
	set_property("choiceAdventure502", "3");
	set_property("choiceAdventure506", "3");
	set_property("choiceAdventure507", "1");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[spooky temple map]) == 1)
	{
		set_property("cc_spookymap", "finished");
	}
	return true;
}

boolean L2_spookyFertilizer()
{
    if(item_amount($item[Spooky-Gro Fertilizer]) > 0)
    {
        set_property("cc_spookyfertilizer", "finished");
    }
	if(get_property("cc_spookyfertilizer") == "finished")
	{
		return false;
	}
	print("Need some poop, I mean fertilizer now", "blue");
	set_property("choiceAdventure502", "3");
	set_property("choiceAdventure506", "2");
	ccAdv(1, $location[The Spooky Forest]);
	if(item_amount($item[Spooky-Gro Fertilizer]) > 0)
	{
		set_property("cc_spookyfertilizer", "finished");
	}
	return true;
}

boolean L2_spookySapling()
{
	if(get_property("cc_spookysapling") == "finished")
	{
		return false;
	}
	if(my_meat() < 100)
	{
		return false;
	}
	print("And a spooky sapling!", "blue");
	set_property("choiceAdventure502", "1");
	set_property("choiceAdventure503", "3");
	set_property("choiceAdventure504", "3");

#	cli_execute("aa none");
	if(contains_text(visit_url("adventure.php?snarfblat=15"), "Combat"))
	{
		ccAdv(1, $location[The Spooky Forest]);
	}
	else
	{
		if(contains_text(get_property("lastEncounter"), "Hoom Hah"))
		{
			return true;
		}
		if(contains_text(get_property("lastEncounter"), "Blaaargh! Blaaargh!"))
		{
			print("Ewww, fake blood semirare. Worst. Day. Ever.", "red");
			return true;
		}
		visit_url("choice.php?whichchoice=502&option=1&pwd");
		visit_url("choice.php?whichchoice=503&option=3&pwd");
		if(item_amount($item[bar skin]) > 0)
		{
			visit_url("choice.php?whichchoice=504&option=2&pwd");
		}
		visit_url("choice.php?whichchoice=504&option=3&pwd");
		visit_url("choice.php?whichchoice=504&option=4&pwd");
		if(item_amount($item[Spooky Sapling]) > 0)
		{
			set_property("cc_spookysapling", "finished");
			use(1, $item[Spooky Temple Map]);
		}
		else
		{
			abort("Supposedly bought a spooky sapling, but failed :(");
		}
	}
	return true;
}

boolean L2_mosquito()
{
	if(get_property("cc_mosquito") == "finished")
	{
		return false;
	}

	buffMaintain($effect[Snow Shoes], 0, 1, 1);

	print("Trying to find a mosquito.", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "1");
	ccAdv(1, $location[The Spooky Forest]);

	if(item_amount($item[mosquito larva]) > 0)
	{
		council();
		visit_url("tavern.php?place=barkeep");
		set_property("cc_mosquito", "finished");
	}
	return true;
}

boolean LX_handleSpookyravenFirstFloor()
{
	if(get_property("cc_spookyravennecklace") == "done")
	{
		return false;
	}
	if(possessEquipment($item[Ghost of a Necklace]))
	{
		set_property("cc_spookyravennecklace", "done");
		return false;
	}

	boolean delayKitchen = get_property("cc_delayHauntedKitchen").to_boolean();
	if(get_property("cc_delayHauntedKitchen").to_boolean())
	{
		if((elemental_resist($element[hot]) < 9) || (elemental_resist($element[stench]) < 9))
		{
			if(my_class() == $class[Ed])
			{
				delayKitchen = have_skill($skill[Even More Elemental Wards]);
			}
		}
		else
		{
			delayKitchen = false;
		}
	}


	if(delayKitchen)
	{
		return false;
	}

	if(get_property("writingDesksDefeated").to_int() >= 5)
	{
		abort("Mafia reports 5 or more writing desks defeated yet we are still looking for them? Give Lady Spookyraven her necklace?");
	}
	if(item_amount($item[Lady Spookyraven\'s Necklace]) > 0)
	{
		abort("Have Lady Spookyraven's Necklace but did not give it to her....");
	}

	if(!have_skill($skill[Rain Man]) || get_property("cc_100familiar").to_boolean())
	{
		if(item_amount($item[Spookyraven Library Key]) == 1)
		{
			print("Well, we need writing desks", "blue");
			print("Going to the liberry!", "blue");
#			cli_execute("olfact writing desk");
			set_property("choiceAdventure888", "4");
			set_property("choiceAdventure889", "4");
			set_property("choiceAdventure163", "4");
			ccAdv(1, $location[The Haunted Library]);
		}
		else if(item_amount($item[Spookyraven Billiards room key]) == 1)
		{
			if((my_inebriety() < 8) && ((my_inebriety() + 2) < inebriety_limit()))
			{
				print("Not quite boozed up for the billiards room... we'll be back.", "green");
				return false;
			}

			set_property("choiceAdventure875" , "1");
			buffMaintain($effect[Chalky Hand], 0, 1, 1);

			# Staff of Fats
			if(item_amount($item[7964]) > 0)
			{
				equip($item[7964]);
			}
			if(item_amount($item[2268]) > 0)
			{
				equip($item[2268]);
			}

			#Staff of Ed
			if(item_amount($item[7961]) > 0)
			{
				equip($item[7961]);
			}
			print("It's billiards time!", "blue");
			ccAdv(1, $location[The Haunted Billiards Room]);

		}
		else
		{
			print("Looking for the Billards Room key (Hot/Stench:" + elemental_resist($element[hot]) + "/" + elemental_resist($element[stench]) + "): Progress " + get_property("manorDrawerCount") + "/24", "blue");
			handleFamiliar($familiar[Exotic Parrot]);
			if(get_property("manorDrawerCount").to_int() >= 24)
			{
				cli_execute("refresh inv");
				if(item_amount($item[Spookyraven Billiards Room Key]) == 0)
				{
					print("We think you've opened enough drawers in the kitchen but you don't have the Billiards Room Key.");
					wait(10);
				}
			}
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
			ccAdv(1, $location[The Haunted Kitchen]);
		}
		return true;
	}
	return false;
}

boolean L5_getEncryptionKey()
{
	if(get_property("cc_day1_cobb") == "finished")
	{
		return false;
	}
	print("Looking for the knob.", "blue");
	ccAdv(1, $location[the outskirts of cobb\'s knob]);

	if(item_amount($item[11-inch knob sausage]) == 1)
	{
		visit_url("guild.php?place=challenge");
	}

	if(item_amount($item[Knob Goblin Encryption Key]) == 1)
	{
		set_property("cc_day1_cobb", "finished");
		council();
	}
	return true;
}

boolean LX_handleSpookyravenNecklace()
{
	if((get_property("cc_spookyravennecklace") == "done") || (item_amount($item[Lady Spookyraven\'s Necklace]) == 0))
	{
		return false;
	}
	if(possessEquipment($item[Ghost Of A Necklace]))
	{
		set_property("cc_spookyravennecklace", "done");
		return false;
	}

	print("Starting Spookyraven Second Floor.", "blue");
	visit_url("place.php?whichplace=manor1&action=manor1_ladys");
	visit_url("main.php");
	visit_url("place.php?whichplace=manor2&action=manor2_ladys");

	set_property("choiceAdventure876", "2");
	set_property("choiceAdventure877", "1");
	set_property("choiceAdventure878", "3");
	set_property("choiceAdventure879", "1");
	set_property("choiceAdventure880", "1");

	#handle lights-out, too bad we can't at least start Stephen Spookyraven here.
	set_property("choiceAdventure897", "2");
	set_property("choiceAdventure896", "1");
	set_property("choiceAdventure892", "2");

	if(item_amount($item[ghost of a necklace]) > 0)
	{
		set_property("cc_spookyravennecklace", "done");
	}
	else if((item_amount($item[ghost of a necklace]) == 0) || (item_amount($item[Lady Spookyraven\'s Necklace]) == 1))
	{
		cli_execute("refresh inv");
		set_property("cc_spookyravennecklace", "done");
		#abort("Mafia still doesn't understand the ghost of a necklace, just re-run me.");
	}
	return true;
}


boolean L12_startWar()
{
	if(get_property("cc_prewar") != "")
	{
		return false;
	}

	print("Must save the ferret!!", "blue");
	outfit("frat warrior fatigues");
	if(my_mp() > 60)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	buffMaintain($effect[Snow Shoes], 0, 1, 1);

	ccAdv(1, $location[Wartime Hippy Camp]);
	if(contains_text(get_property("lastEncounter"), "Blockin\' Out the Scenery"))
	{
		set_property("cc_prewar", "started");
		visit_url("bigisland.php?action=junkman&pwd");
		if(!get_property("cc_hippyInstead").to_boolean())
		{
			visit_url("bigisland.php?place=concert&pwd");
			visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
			visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
			set_property("cc_gunpowder", "done");
		}
	}
	return true;
}

boolean L12_getOutfit()
{
	if(get_property("cc_prehippy") == "done")
	{
		return false;
	}
	if(my_level() < 12)
	{
		return false;
	}

	set_property("choiceAdventure143", "3");
	set_property("choiceAdventure144", "3");
	set_property("choiceAdventure145", "1");
	set_property("choiceAdventure146", "1");

	if((get_property("cc_orcishfratboyspy") == "done") && (!in_hardcore()))
	{
		pullXWhenHaveY($item[Beer Helmet], 1, 0);
		pullXWhenHaveY($item[Bejeweled Pledge Pin], 1, 0);
		pullXWhenHaveY($item[Distressed Denim Pants], 1, 0);
	}

	if(possessEquipment($item[beer helmet]) && possessEquipment($item[bejeweled pledge pin]) && possessEquipment($item[distressed denim pants]))
	{
		set_property("choiceAdventure139", "3");
		set_property("choiceAdventure140", "3");
		set_property("cc_prehippy", "done");
		visit_url("clan_viplounge.php?preaction=goswimming&subaction=submarine");
		return true;
	}

	if(get_property("cc_prehippy") == "firstOutfit")
	{
		outfit("filthy hippy disguise");
		if(my_lightning() >= 5)
		{
			ccAdv(1, $location[Wartime Frat House]);
			return true;
		}

		if(in_hardcore())
		{
			ccAdv(1, $location[Wartime Frat House]);
			return true;
		}

		if((have_effect($effect[everything looks yellow]) > 0) || (get_property("cc_haslightningbolt") == ""))
		{
			pullXWhenHaveY($item[Beer Helmet], 1, 0);
			pullXWhenHaveY($item[Bejeweled Pledge Pin], 1, 0);
			pullXWhenHaveY($item[Distressed Denim Pants], 1, 0);
			return true;
		}

		//We should probably have some kind of backup solution here

		return false;
	}
	else
	{
		if(!in_hardcore())
		{
			pullXWhenHaveY($item[Filthy Knitted Dread Sack], 1, 0);
			pullXWhenHaveY($item[Filthy Corduroys], 1, 0);
		}
		if(L12_preOutfit())
		{
			return true;
		}
	}
	return false;
}

boolean L12_preOutfit()
{
	if(item_amount($item[Dingy Dinghy]) == 0)
	{
		return false;
	}
	if(!in_hardcore())
	{
		return false;
	}
	if(my_level() < 9)
	{
		return false;
	}
	if(get_property("cc_prehippy") != "")
	{
		return false;
	}
	if(my_path() == "Heavy Rains")
	{
		abort("We shouldn't be going down this path in HR");
	}
	if(possessEquipment($item[Filthy Knitted Dread Sack]) && possessEquipment($item[Filthy Corduroys]))
	{
		set_property("cc_prehippy", "firstOutfit");
		return true;
	}
	if((my_class() == $class[Ed]) && have_skill($skill[Wrath of Ra]))
	{
		if(have_effect($effect[Everything Looks Yellow]) != 0)
		{
			return false;
		}
		if(my_mp() < 40)
		{
			return false;
		}
	}
	print("Trying to acquire a filthy hippy outfit", "blue");
	if(my_level() < 12)
	{
		ccAdv(1, $location[Hippy Camp]);
	}
	else
	{
		ccAdv(1, $location[Wartime Hippy Camp]);
	}
	return true;
}

boolean L12_flyerFinish()
{
	if(item_amount($item[rock band flyers]) == 0)
	{
		return false;
	}
	if(get_property("flyeredML").to_int() < 10000)
	{
		return false;
	}
	if(get_property("cc_ignoreFlyer").to_boolean())
	{
		return false;
	}
	print("Done with this Rock Band crap", "blue");
	warOutfit();
	visit_url("bigisland.php?place=concert&pwd");

	cli_execute("refresh inv");
	if(item_amount($item[Rock Band Flyers]) == 0)
	{
		change_mcd(0);
		return true;
	}
	print("We thought we had enough flyeredML, but we don't. Big sadness, let's try that again.", "red");
	set_property("flyeredML", 9999);
	return false;
}

boolean L9_highLandlord()
{
	if(my_level() < 9)
	{
		return false;
	}
	if(get_property("chasmBridgeProgress").to_int() < 30)
	{
		return false;
	}
	if(get_property("cc_highlandlord") == "finished")
	{
		return false;
	}

	if((my_class() == $class[Ed]) && !get_property("cc_chasmBusted").to_boolean())
	{
		return false;
	}

	if(get_property("cc_highlandlord") == "")
	{
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		set_property("cc_aboocount", "0");
		set_property("choiceAdventure296", "1");
		set_property("cc_highlandlord", "start");
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire1.gif"))
	{
		set_property("cc_boopeak", "finished");
	}

	if(L9_aBooPeak())
	{
		return true;
	}

	if(L9_oilPeak())
	{
		return true;
	}

	if(L9_twinPeak())
	{
		return true;
	}

	if((get_property("twinPeakProgress").to_int() == 15) && (get_property("cc_oilpeak") == "finished") && (get_property("cc_boopeak") == "finished"))
	{
		print("Highlord Done", "blue");
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		council();
		set_property("cc_highlandlord", "finished");
		return true;
	}

	return false;
}

boolean L9_aBooPeak()
{
	if(get_property("cc_boopeak") == "finished")
	{
		return false;
	}

	if(get_property("cc_aboocount").to_int() < 5)
	{
		print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
		set_property("cc_aboocount", get_property("cc_aboocount").to_int() + 1);
		ccAdv(1, $location[A-Boo Peak]);
		return true;
	}

	print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
	if(item_amount($item[a-boo clue]) > 0)
	{
		boolean doThisBoo = false;
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buffMaintain($effect[Astral Shell], 10, 1, 1);
		buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);

		if(my_class() == $class[Ed])
		{
			if(item_amount($item[Linen Bandages]) == 0)
			{
				return false;
			}
		}
		maximize("spooky res, cold res -equip lihc face -equip snow suit", 0, 0, false);
		adjustEdHat("ml");
		int coldResist = elemental_resist($element[cold]);
		int spookyResist = elemental_resist($element[spooky]);

		if(item_amount($item[Spooky Powder]) > 0)
		{
			spookyResist = spookyResist + 1;
		}
		if(item_amount($item[Cold Powder]) > 0)
		{
			coldResist = coldResist + 1;
		}

		#	Ed could really use some HP buffs but healing is an issue here.
		if(my_class() == $class[Ed])
		{
			if(black_market_available() && (item_amount($item[Can of Black Paint]) == 0) && (have_effect($effect[Red Door Syndrome]) == 0) && (my_meat() >= 1000))
			{
				buyUpTo(1, $item[Can of Black Paint]);
			}

			if(item_amount($item[Can of Black Paint]) > 0)
			{
				spookyResist = spookyResist + 2;
				coldResist = coldResist + 2;
			}
			if(item_amount($item[Oil of Parrrlay]) > 0)
			{
				spookyResist = spookyResist + 1;
				coldResist = coldResist + 1;
			}
		}

		#Calculate how much boo peak damage does per unit resistance.
		int estimatedCold = (13+25+50+125+250) * ((100.0 - elemental_resist_value(coldResist)) / 100.0);
		int estimatedSpooky = (13+25+50+125+250) * ((100.0 - elemental_resist_value(spookyResist)) / 100.0);
		print("Current HP: " + my_hp() + "/" + my_maxhp(), "blue");
		print("Expected cold damage: " + estimatedCold + " Expected spooky damage: " + estimatedSpooky, "blue");
		int totalDamage = estimatedCold + estimatedSpooky;
		int mp_need = 40;
		if((my_hp() - totalDamage) > 200)
		{
			mp_need = mp_need - 20;
		}
		if((my_hp() - totalDamage) > 300)
		{
			mp_need = mp_need - 10;
		}

		if(my_turncount() == get_property("cc_lastABooConsider").to_int())
		{
			set_property("cc_lastABooCycleFix", get_property("cc_lastABooCycleFix").to_int() + 1);
			if(get_property("cc_lastABooCycleFix").to_int() > 5)
			{
				abort("We are in an A-Boo Peak cycle and can't find anything else to do. Aborting. If you have actual other quests left, please report this. Otherwise, complete A-Boo peak manually");
			}
		}
		else
		{
			set_property("cc_lastABooConsider", my_turncount());
			set_property("cc_lastABooCycleFix", 0);
		}

		if(get_property("booPeakProgress").to_int() == 0)
		{
			doThisBoo = true;
		}
		if(((my_hp() >= 400) && (my_mp() >= mp_need)) || ((my_hp() >= totalDamage) && (my_mp() >= 20)))
		{
			doThisBoo = true;
		}
		if(doThisBoo)
		{
			if((item_amount($item[Lihc Face]) > 0) && (my_class() != $class[Ed]))
			{
				equip($item[Lihc Face]);
			}
			if(item_amount($item[ghost of a necklace]) > 0)
			{
				equip($slot[acc2], $item[ghost of a necklace]);
			}
			buffMaintain($effect[Spookypants], 0, 1, 1);
			buffMaintain($effect[Insulated Trousers], 0, 1, 1);

			if(my_class() == $class[Ed])
			{
				buffMaintain($effect[Red Door Syndrome], 0, 1, 1);
				buffMaintain($effect[Well-Oiled], 0, 1, 1);
			}

			set_property("choiceAdventure611", "1");
			useCocoon();
			use(1, $item[A-Boo clue]);
			ccAdv(1, $location[A-Boo Peak]);
			useCocoon();
			if((my_class() == $class[Ed]) && (my_hp() == 0))
			{
				use(1, $item[Linen Bandages]);
			}
			return true;
		}
		else if(my_path() != "Picky")
		{
			#abort("Could not handle HP/MP situation for a-boo peak");
		}
		equipBaseline();
	}
	else if((get_property("cc_abooclover") == "") && (get_property("booPeakProgress").to_int() >= 40))
	{
		if(item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);

			string page = visit_url("adventure.php?snarfblat=296&confirm=on");
			if(contains_text(page, "Combat"))
			{
				print("Wandering monster interrupt at a-boo peak", "red");
				ccAdv(1, $location[A-Boo Peak]);
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			}
			else
			{
				set_property("cc_abooclover", "used");
			}
			return true;
		}
	}
	else
	{
		ccAdv(1, $location[A-Boo Peak]);
		if(get_property("lastEncounter") == "Come On Ghosty, Light My Pyre")
		{
			set_property("cc_boopeak", "finished");
		}
		return true;
	}
	return false;
}

boolean L9_twinPeak()
{
	if(get_property("twinPeakProgress").to_int() >= 15)
	{
		return false;
	}
	if(get_property("cc_oilpeak") != "finished")
	{
		return false;
	}

	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
	if(get_property("cc_twinpeakprogress") == "")
	{
		print("Twin Peak", "blue");
		set_property("choiceAdventure604", "1");
		set_property("choiceAdventure618", "2");
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		ccAdv(1, $location[Twin Peak]);
		if(last_monster() != $monster[gourmet gourami])
		{
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Continue...");
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Everything+goes+black.");
			set_property("cc_twinpeakprogress", "1");
			set_property("choiceAdventure606", "2");
			set_property("choiceAdventure608", "1");
		}
		return true;
	}

	if(my_mp() > 60)
	{
		handleBjornify($familiar[grimstone golem]);
	}

	int progress = get_property("twinPeakProgress").to_int();
	boolean needStench = ((progress & 1) == 0);
	boolean needFood = ((progress & 2) == 0);
	boolean needJar = ((progress & 4) == 0);
	boolean needInit = (progress == 7);

	int attemptNum = 0;
	boolean attempt = false;
	if(needInit)
	{
		buffMaintain($effect[Adorable Lookout], 0, 1, 1);
		if(initiative_modifier() < 40.0)
		{
			if((my_class() == $class[Turtle Tamer]) || (my_class() == $class[Seal Clubber]))
			{
				buyUpTo(1, $item[Cheap Wind-Up Clock]);
				buffMaintain($effect[Ticking Clock], 0, 1, 1);
			}
		}
		if(initiative_modifier() < 40.0)
		{
			return false;
		}
		attemptNum = 4;
		attempt = true;
	}

	if(needJar && (item_amount($item[Jar of Oil]) == 1))
	{
		attemptNum = 3;
		attempt = true;
	}

	if(!attempt && needFood)
	{
		if(item_drop_modifier() < 50)
		{
			if((friars_available()) && (!get_property("friarsBlessingReceived").to_boolean()))
			{
				cli_execute("friars food");
			}
		}
		float food_drop = item_drop_modifier();
		if(have_effect($effect[Brother Flying Burrito\'s Blessing]) > 0)
		{
			food_drop = food_drop + 30;
		}
		if(food_drop >= 50.0)
		{
			attemptNum = 2;
			attempt = true;
		}
	}

	if(!attempt && needStench)
	{
		buffMaintain($effect[Astral Shell], 10, 1, 1);
		buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
		buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		if(elemental_resist($element[stench]) < 4)
		{
			handleFamiliar($familiar[Exotic Parrot]);
		}
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Neutered Nostrils], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Oiled-Up], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Well-Oiled], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) >= 4)
		{
			attemptNum = 1;
			attempt = true;
		}
	}

	if(!attempt)
	{
		return false;
	}

	set_property("choiceAdventure609", "1");
	if(attemptNum == 1)
	{
		set_property("choiceAdventure606", "1");
		set_property("choiceAdventure607", "1");
	}
	else if(attemptNum == 2)
	{
		set_property("choiceAdventure606", "2");
		set_property("choiceAdventure608", "1");
	}
	else if(attemptNum == 3)
	{
		set_property("choiceAdventure606", "3");
		set_property("choiceAdventure609", "1");
		set_property("choiceAdventure616", "1");
	}
	else if(attemptNum == 4)
	{
		set_property("choiceAdventure606", "4");
		set_property("choiceAdventure610", "1");
		set_property("choiceAdventure1056", "1");
	}

	int trimmers = item_amount($item[Rusty Hedge Trimmers]);
	if(item_amount($item[Rusty Hedge Trimmers]) > 0)
	{
		use(1, $item[rusty hedge trimmers]);
		cli_execute("refresh inv");
		if(item_amount($item[rusty hedge trimmers]) == trimmers)
		{
			abort("Tried using a rusty hedge trimmer but that didn't seem to work");
		}
		string page = visit_url("main.php");
		if((contains_text(page, "choice.php")) && (!contains_text(page, "Really Sticking Her Neck Out")) && (!contains_text(page, "It Came from Beneath the Sewer?")))
		{
			print("Inside of a Rusty Hedge Trimmer sequence.", "blue");
		}
		else
		{
			print("Rusty Hedge Trimmer Sequence completed itself.", "blue");
			return true;
		}
	}

	if(ccAdvBypass(297, $location[Twin Peak]))
	{
		return true;
	}
	string page = visit_url("main.php");
	if((contains_text(page, "choice.php")) && (!contains_text(page, "Really Sticking Her Neck Out")) && (!contains_text(page, "It Came from Beneath the Sewer?")))
	{
		if(attemptNum == 1)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=1&choiceform1=Investigate+Room+237");
			visit_url("choice.php?pwd&whichchoice=607&option=1&choiceform1=Carefully+inspect+the+body");
		}
		else if(attemptNum == 2)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=2&choiceform2=Search+the+pantry");
			visit_url("choice.php?pwd&whichchoice=608&option=1&choiceform1=Search+the+shelves");
		}
		else if(attemptNum == 3)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=3&choiceform3=Follow+the+faint+sound+of+music");
			visit_url("choice.php?pwd&whichchoice=609&option=1&choiceform1=Examine+the+painting");
			visit_url("choice.php?pwd&whichchoice=616&option=1&choiceform1=Mingle");
		}
		else if(attemptNum == 4)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=4&choiceform4=Wait+--+who%27s+that%3F");
			visit_url("choice.php?pwd&whichchoice=610&option=1&choiceform1=Pursue+your+double");
			visit_url("choice.php?pwd&whichchoice=1056&option=1&choiceform1=And+then...");
		}
		return true;
	}
	else
	{
		ccAdv(1, $location[Twin Peak]);
	}
	return true;
}

boolean L9_oilPeak()
{
	if(get_property("cc_oilpeak") != "")
	{
		return false;
	}

	print("Oil Peak with ML: " + monster_level_adjustment(), "blue");

	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire3.gif"))
	{
		if(item_amount($item[bubblin\' crude]) >= 12)
		{
			cli_execute("make jar of oil");
			set_property("cc_oilpeak", "finished");
			return true;
		}
		if(item_amount($item[Jar of oil]) > 0)
		{
			set_property("cc_oilpeak", "finished");
			return true;
		}
		print("Oil Peak is finished but we need more crude!", "blue");
	}

	buffMaintain($effect[Litterbug], 0, 1, 1);
	buffMaintain($effect[Tortious], 0, 1, 1);
	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
	handleInitFamiliar();

	if((my_class() == $class[Ed]) && get_property("cc_dickstab").to_boolean())
	{
		buffMaintain($effect[The Dinsey Look], 0, 1, 1);
	}
	ccAdv(1, $location[Oil Peak]);
	handleFamiliar($familiar[Adventurous Spelunker]);
	return true;
}

boolean L9_chasmBuild()
{
	if((my_level() < 9) || (get_property("chasmBridgeProgress").to_int() >= 30))
	{
		return false;
	}
	if(LX_getDictionary() || LX_dictionary())
	{
		return true;
	}
	print("Chasm time", "blue");
	if(item_amount($item[fancy oil painting]) > 0)
	{
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
	}
	if(item_amount($item[bridge]) > 0)
	{
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
	}

	if((my_class() == $class[Ed]) && !get_property("cc_chasmBusted").to_boolean())
	{
		print("What a nice bridge over here...." , "green");

		string page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		ccAdvBypass("place.php?whichplace=orc_chasm&action=bridge_done", $location[The Smut Orc Logging Camp]);

		set_property("cc_chasmBusted", true);
		set_property("chasmBridgeProgress", 0);
		return true;
	}

	if(in_hardcore())
	{
		int need = (30 - get_property("chasmBridgeProgress").to_int());
		if((my_class() == $class[Ed]) && (need > 3) && (item_amount($item[Disassembled Clover]) > 2))
		{
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=295&confirm=on");
			if(contains_text(visit_url("main.php"), "Combat"))
			{
				ccAdv(1, $location[The Smut Orc Logging Camp]);
				return true;
			}
			visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
			return true;
		}

		ccAdv(1, $location[The Smut Orc Logging Camp]);

		if(item_amount($item[Smut Orc Keepsake Box]) > 0)
		{
			use(1, $item[Smut Orc Keepsake Box]);
		}
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		if(get_property("chasmBridgeProgress").to_int() >= 30)
		{
			visit_url("place.php?whichplace=highlands&action=highlands_dude");
		}
		return true;
	}

	int need = (30 - get_property("chasmBridgeProgress").to_int()) / 5;
	if(need > 0)
	{
		while((need > 0) && (item_amount($item[Snow Berries]) >= 2))
		{
			cli_execute("make 1 snow boards");
			need = need - 1;
			visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		}
	}

	need = 30 - get_property("chasmBridgeProgress").to_int();
	if((need <= 3) && (need >= 1) && (item_amount($item[Disassembled Clover]) > 0))
	{
		use(1, $item[disassembled clover]);
		visit_url("adventure.php?snarfblat=295&confirm=on");
		if(contains_text(visit_url("main.php"), "Combat"))
		{
			//run_combat();
			ccAdv(1, $location[The Smut Orc Logging Camp]);
			return true;
		}
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
	}
	else
	{
		ccAdv(1, $location[The Smut Orc Logging Camp]);
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		return true;
		#abort("Umm.... we failed the smut orcs. Sorry bro.");
	}
	if(get_property("chasmBridgeProgress").to_int() < 30)
	{
		abort("Umm.... we failed the smut orcs. Sorry bro.");
		abort("Our chasm bridge situation is borken. Beep boop.");
	}
	visit_url("place.php?whichplace=highlands&action=highlands_dude");
	return true;
}

boolean LX_dictionary()
{
	if(item_amount($item[abridged dictionary]) == 1)
	{
		if(knoll_available() || (get_property("questM01Untinker") == "finished"))
		{
			print("Untinkering dictionary", "blue");
			cli_execute("untinker abridged dictionary");
		}
	}
	return false;
}

boolean L9_chasmStart()
{
	if(my_level() < 9)
	{
		return false;
	}
	if((my_class() == $class[Ed]) && !get_property("cc_chasmBusted").to_boolean())
	{
		print("It's a troll on a bridge!!!!", "blue");

		string page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		ccAdvBypass("place.php?whichplace=orc_chasm&action=bridge_done", $location[The Smut Orc Logging Camp]);

		set_property("cc_chasmBusted", true);
		set_property("chasmBridgeProgress", 0);
		return true;
	}
	return false;
}


boolean L11_talismanOfNam()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(item_amount($item[Talisman O\' Namsilat]) > 0)
	{
		set_property("cc_swordfish", "finished");
		set_property("cc_gaudy", "finished");
	}
	if(get_property("cc_swordfish") == "finished")
	{
		if(!possessEquipment($item[Talisman O\' Namsilat]))
		{
			print("We should have a talisman o' namsilat but we don't know about it, refreshing inventory", "red");
			cli_execute("refresh inv");
		}
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(!possessEquipment($item[Pirate Fledges]))
	{
		return false;
	}
	if((get_property("cc_war") == "finished") || (get_property("cc_prewar") == ""))
	{
		equip($slot[acc3], $item[pirate fledges]);
		if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		if(my_mp() > 60)
		{
			handleBjornify($familiar[grimstone golem]);
		}
		set_property("choiceAdventure189", "1");
		set_property("oceanAction", "continue");
		set_property("oceanDestination", to_lower_case(my_primestat()));
		handleInitFamiliar();

		if(get_property("cc_gaudy") == "")
		{
			print("It always be swordfish.", "blue");
			ccAdv(1, $location[The Poop Deck]);
			if(contains_text(get_property("lastEncounter"), "It\'s Always Swordfish"))
			{
				set_property("cc_gaudy", "start");
			}
		}
		else
		{
			if((item_amount($item[gaudy key]) < 2) && !possessEquipment($item[Talisman O\' Namsilat]))
			{
				print("Well, need to farm gaudy keys I suppose... sigh.", "blue");
				ccAdv(1, $location[Belowdecks]);
				handleFamiliar($familiar[Adventurous Spelunker]);
				return true;
			}
			set_property("cc_gaudy", "finished");
			set_property("cc_swordfish", "finished");
			use(1, $item[gaudy key]);
			use(1, $item[gaudy key]);
		}
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}
	return false;
}

boolean L11_mcmuffinDiary()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(my_adventures() <= 4)
	{
		return false;
	}
	if(my_meat() < 500)
	{
		return false;
	}
	if(item_amount($item[Forged Identification Documents]) == 0)
	{
		return false;
	}

	print("Getting the McMuffin Diary", "blue");
	set_property("choiceAdventure793", "1");
	ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
	use(item_amount($item[Your Father\'s Macguffin Diary]), $item[your father\'s macguffin diary]);
	use(item_amount($item[Copy of a Jerk Adventurer\'s Father\'s Diary]), $item[Copy of a Jerk Adventurer\'s Father\'s Diary]);
	set_property("cc_mcmuffin", "start");
	return true;
}

boolean L11_forgedDocuments()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(!black_market_available())
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "")
	{
		return false;
	}
	if(get_property("cc_blackmap") == "finished")
	{
		return false;
	}
	if(item_amount($item[Forged Identification Documents]) != 0)
	{
		return false;
	}
	if(my_meat() < 5500)
	{
		return false;
	}

	print("Getting the McMuffin Book", "blue");
	buyUpTo(1, $item[forged identification documents]);
	handleFamiliar($familiar[Adventurous Spelunker]);
	set_property("cc_blackmap", "finished");
	return true;

}


boolean L11_blackMarket()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("cc_blackmap") != "")
	{
		return false;
	}
	if(black_market_available())
	{
		set_property("cc_blackmap", "document");
		return false;
	}
	if($location[The Black Forest].turns_spent > 12)
	{
		print("We have spent a bit many adventures in The Black Forest... manually checking", "red");
		visit_url("place.php?whichplace=woods");
		visit_url("woods.php");
		if($location[The Black Forest].turns_spent > 30)
		{
			abort("We have spent too many turns in The Black Forest and haven't found The Black Market. Something is wrong. (Find Black Forest, set cc_blackmap=document, do not buy Forged Identification Documents");
		}
	}

	print("Must find the Black Market: " + get_property("blackForestProgress"), "blue");
	if(get_property("cc_blackfam").to_boolean())
	{
		council();
		handleFamiliar($familiar[reassembled blackbird]);
		pullXWhenHaveY($item[blackberry galoshes], 1, 0);
		set_property("cc_blackfam", false);
		set_property("choiceAdventure923", "1");
	}

	if(item_amount($item[beehive]) > 0)
	{
		set_property("cc_getBeehive", false);
	}

	if(get_property("cc_getBeehive").to_boolean())
	{
		set_property("choiceAdventure924", "3");
		set_property("choiceAdventure1018", "1");
		set_property("choiceAdventure1019", "1");
	}
	else
	{
		if(item_amount($item[Blackberry]) >= 3)
		{
			set_property("choiceAdventure924", "2");
			set_property("choiceAdventure177", "4");
		}
		else
		{
			set_property("choiceAdventure924", "1");
		}
	}

	if(item_amount($item[blackberry galoshes]) == 1)
	{
		equip($slot[acc3], $item[blackberry galoshes]);
	}

	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	else
	{
		handleBjornify($familiar[Grim Brother]);
	}

	handleFamiliar($familiar[reassembled blackbird]);

	if(!possessEquipment($item[Blackberry Galoshes]) && (item_amount($item[Blackberry]) >= 3))
	{
		set_property("choiceAdventure924", "2");
		set_property("choiceAdventure928", "4");
	}

	ccAdv(1, $location[The Black Forest]);
	if(black_market_available())
	{
		buyUpTo(1, $item[can of black paint]);
		handleFamiliar($familiar[Adventurous Spelunker]);
		set_property("cc_blackmap", "document");
		if(my_meat() >= 5000)
		{
			buyUpTo(1, $item[forged identification documents]);
			set_property("cc_blackmap", "finished");
		}
	}
	return true;
}

boolean L10_holeInTheSky()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(!get_property("cc_getStarKey").to_boolean())
	{
		return false;
	}
	if(item_amount($item[steam-powered model rocketship]) == 0)
	{
		return false;
	}
	if(contains_text(get_property("nsTowerDoorKeysUsed"),"star key"))
	{
		set_property("cc_getStarKey", false);
		return false;
	}
	if(item_amount($item[Richard\'s Star Key]) > 0)
	{
		set_property("cc_getStarKey", false);
		return false;
	}
	if((item_amount($item[star]) >= 8) && (item_amount($item[line]) >= 7))
	{
		if(!in_hardcore())
		{
			set_property("cc_getStarKey", false);
			return false;
		}
		else if(item_amount($item[Star Chart]) > 0)
		{
			set_property("cc_getStarKey", false);
			return false;
		}
	}
	ccAdv(1, $location[The Hole In The Sky]);
	return true;
}

boolean L5_haremOutfit()
{
	if(my_level() < 5)
	{
		return false;
	}
	if(get_property("questL05Goblin") == "finished")
	{
		return false;
	}
	if(possessEquipment($item[Knob Goblin Harem Veil]) && possessEquipment($item[Knob Goblin Harem Pants]))
	{
		return false;
	}

	if(have_effect($effect[Everything Looks Yellow]) > 0)
	{
		return false;
	}

	if(my_path() == "Heavy Rains")
	{
		if(have_skill($skill[Ball Lightning]) && (my_lightning() >= 5))
		{
			buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
			print("Ditch attempt at the Harem Girl", "blue");
		}
		else if(!in_hardcore())
		{
			return false;
		}
	}

	handleFamiliar($familiar[Crimbo Shrub]);
	if((my_familiar() == $familiar[Crimbo Shrub]) && (!get_property("_shrubDecorated").to_boolean()))
	{
		visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
		visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=1&lights=1&garland=1&gift=1");
		print("Time to bring Crimbo Fun to the Harem!", "blue");
	}
	ccAdv(1, $location[Cobb\'s Knob Harem]);
	handleFamiliar($familiar[Adventurous Spelunker]);
	return true;
}

boolean LX_getDictionary()
{
	if(item_amount($item[abridged dictionary]) == 1)
	{
		return false;
	}
	if(item_amount($item[dictionary]) == 1)
	{
		return false;
	}
	if(my_level() < 9)
	{
		return false;
	}
	if(my_meat() < 1000)
	{
		return false;
	}
	if(get_property("cc_war") != "")
	{
		if(get_property("cc_war") != "finished")
		{
			return false;
		}
	}
	if((get_property("questL12War") != "unstarted") && (get_property("questL12War") != "finished"))
	{
		return false;
	}
	buyUpTo(1, $item[abridged dictionary]);
	if(item_amount($item[abridged dictionary]) == 0)
	{
		return false;
	}
	return true;
}

boolean LX_fcle()
{
	if(get_property("cc_pirateoutfit") != "finished")
	{
		return false;
	}
	LX_getDictionary();
	if(get_property("cc_fcle") != "")
	{
		return false;
	}

	if(possessEquipment($item[pirate fledges]))
	{
		set_property("cc_fcle", "finished");
		visit_url("store.php?whichstore=r");
		print("Updating Pirate Bookstore Item (" + get_property("lastPirateEphemeraReset") + "): " + get_property("lastPirateEphemera"), "blue");
		return true;
	}

	if(get_property("cc_prewar") != "")
	{
		if(get_property("cc_war") != "finished")
		{
			return false;
		}
	}

	switch(my_primestat())
	{
	case $stat[Muscle]:
		set_property("choiceAdventure191", 3);
		break;
	case $stat[Moxie]:
		set_property("choiceAdventure191", 1);
		break;
	case $stat[Mysticality]:
		if((my_class() == $class[Ed]) && (my_hp() < 20))
		{
			set_property("choiceAdventure191", 1);
		}
		else
		{
			set_property("choiceAdventure191", 4);
		}
		break;
	}

	if((item_amount($item[rigging shampoo]) == 1) && (item_amount($item[ball polish]) == 1) && (item_amount($item[mizzenmast mop]) == 1))
	{
		use(1, $item[rigging shampoo]);
		use(1, $item[ball polish]);
		use(1, $item[mizzenmast mop]);
		cli_execute("outfit swashbuckling getup");
		ccAdv(1, $location[The F\'c\'le]);
		return true;
	}

	buffMaintain($effect[Joyful Resolve], 0, 1, 1);
	if((my_class() == $class[Ed]) && (item_amount($item[Talisman of Renenutet]) == 0))
	{
		return false;
	}

	if(my_class() == $class[Ed])
	{
		if((have_effect($effect[Taunt of Horus]) == 0) && (item_amount($item[Talisman of Horus]) == 0) && !get_property("cc_dickstab").to_boolean())
		{
			return false;
		}
	}
	if(!uneffect($effect[Shelter Of Shed]))
	{
		print("Could not uneffect Shelter of Shed for F'C'le, delaying");
		return false;
	}
	buffMaintain($effect[Taunt of Horus], 0, 1, 1);
	print("Fcle time!", "blue");
	cli_execute("outfit swashbuckling getup");
	if(item_amount($item[numberwang]) > 0)
	{
		equip($slot[acc1], $item[numberwang]);
	}

	ccAdv(1, $location[The F\'c\'le]);
	return true;
}


boolean LX_pirateBeerPong()
{
	if(get_property("cc_pirateoutfit") != "almost")
	{
		return false;
	}
	cli_execute("outfit swashbuckling getup");
	LX_getDictionary();
	string page = tryBeerPong();
	if(contains_text(page, "victory laps"))
	{
		set_property("cc_pirateoutfit", "finished");
	}
	else if(contains_text(page, "Combat"))
	{
		ccAdv(1, $location[barrrney\'s barrr]);
	}
	return true;
}

boolean LX_nastyBooty()
{
	if(item_amount($item[Cap\'m Caronch\'s Map]) == 0)
	{
		return false;
	}
	if(item_amount($item[Cap\'m Caronch\'s Nasty Booty]) != 0)
	{
		return false;
	}
	if(my_class() == $class[Ed])
	{
		handleServant($servant[Cat]);
	}
#	cli_execute("outfit swashbuckling getup");
	if((my_class() == $class[Ed]) && possessEquipment($item[The Crown of Ed the Undying]))
	{
		adjustEdHat("weasel");
	}

	string page = "inv_use.php?pwd=&which=3&whichitem=2950";
	ccAdvBypass(page, $location[Noob Cave]);

	return true;
}

boolean LX_pirateBlueprint()
{
	if(get_property("cc_pirateoutfit") != "blueprint")
	{
		return false;
	}
	if((my_class() == $class[Ed]) && (my_maxhp() < 70))
	{
		if((item_amount($item[Cap\'m Caronch\'s Map]) != 0) && (item_amount($item[Cap\'m Caronch\'s Nasty Booty]) == 0))
		{
			return false;
		}
	}

	print("Trying to blueprint handle", "blue");
	LX_getDictionary();
	if(LX_nastyBooty())
	{
		return true;
	}
	if(item_amount($item[orcish frat house blueprints]) == 0)
	{
		cli_execute("outfit swashbuckling getup");
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	else
	{
		print("Crossdressing (even if you are female) as a sorority girl!", "blue");
		set_property("choiceAdventure188", "3");
		if(knoll_available())
		{
			buyUpTo(1, $item[frilly skirt]);
		}
		else if(!possessEquipment($item[Frilly Skirt]))
		{
			if(available_amount($item[continuum transfunctioner]) == 0)
			{
				//From Bale\'s Woods.ash
				visit_url("place.php?whichplace=forestvillage&action=fv_mystic");
				visit_url("choice.php?pwd="+my_hash()+"&whichchoice=664&option=1&choiceform1=Sure%2C+old+man.++Tell+me+all+about+it.");
				visit_url("choice.php?pwd="+my_hash()+"&whichchoice=664&option=1&choiceform1=Against+my+better+judgment%2C+yes.");
				visit_url("choice.php?pwd="+my_hash()+"&whichchoice=664&option=1&choiceform1=Er,+sure,+I+guess+so...");
				visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");
			}
			if(!ccAdv(1, $location[The Degrassi Knoll Gym]))
			{
				visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");
				if(!ccAdv(1, $location[The Degrassi Knoll Gym]))
				{
					abort("Can't access The Degrassi Knoll Gym. Either start the untinker quest or get a frilly skirt.");
				}
			}
			return true;
		}


		if(item_amount($item[Hot Wing]) < 3)
		{
			return false;
		}
		if(equipped_item($slot[pants]) != $item[Frilly Skirt])
		{
			equip($item[Frilly Skirt]);
		}

		use(1, $item[orcish frat house blueprints]);
		set_property("cc_pirateoutfit", "almost");
		return true;
	}
}

boolean LX_pirateInsults()
{
	if(get_property("cc_pirateoutfit") != "insults")
	{
		return false;
	}

	if((my_class() == $class[Ed]) && (my_maxhp() < 70))
	{
		if((item_amount($item[Cap\'m Caronch\'s Map]) != 0) && (item_amount($item[Cap\'m Caronch\'s Nasty Booty]) == 0))
		{
			return false;
		}
	}

	print("Insult gathering party.", "blue");
	if(LX_nastyBooty())
	{
		return true;
	}
	cli_execute("outfit swashbuckling getup");
	LX_getDictionary();

	if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
	{
		buyUpTo(1, $item[the big book of pirate insults]);
	}
	if(item_amount($item[the big book of pirate insults]) == 0)
	{
		return false;
	}

	buyUpTo(1, $item[hair spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
	if((my_class() == $class[Seal Clubber]) || (my_class() == $class[Turtle Tamer]))
	{
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buyUpTo(1, $item[Blood of the Wereseal]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buffMaintain($effect[Temporary Lycanthropy], 0, 1, 1);
	}

#	cli_execute("refresh inv");

	if(numPirateInsults() < 7)
	{
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	set_property("cc_pirateoutfit", "blueprint");
	return false;
}

boolean LX_pirateOutfit()
{
	if(get_property("cc_pirateoutfit") != "")
	{
		return false;
	}
	if(item_amount($item[Dingy Dinghy]) == 0)
	{
		return false;
	}

	if((possessEquipment($item[eyepatch])) && (possessEquipment($item[swashbuckling pants])) && (possessEquipment($item[stuffed shoulder parrot])))
	{
		if(item_amount($item[the big book of pirate insults]) == 1)
		{
			set_property("cc_pirateoutfit", "insults");
			return true;
		}
		if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
		{
			set_property("cc_pirateoutfit", "insults");
			buyUpTo(1, $item[the big book of pirate insults]);
			return true;
		}
	}
	else
	{
		if((my_class() == $class[Ed]) && !possessEquipment($item[stuffed shoulder parrot]))
		{
			if(my_hp() <= 3)
			{
				return false;
			}
		}


		print("Searching for a pirate outfit.", "blue");
		if(possessEquipment($item[eyepatch]))
		{
			set_property("choiceAdventure22", "2");
			if(possessEquipment($item[swashbuckling pants]))
			{
				set_property("choiceAdventure22", "3");
			}
		}
		else
		{
			set_property("choiceAdventure22", "1");
		}

		if(possessEquipment($item[stuffed shoulder parrot]))
		{
			set_property("choiceAdventure23", "2");
			if(possessEquipment($item[swashbuckling pants]))
			{
				set_property("choiceAdventure23", "3");
			}
		}
		else
		{
			set_property("choiceAdventure23", "1");
		}

		if(possessEquipment($item[stuffed shoulder parrot]))
		{
			set_property("choiceAdventure24", "3");
			if(possessEquipment($item[eyepatch]))
			{
				set_property("choiceAdventure24", "2");
			}
		}
		else
		{
			set_property("choiceAdventure24", "1");
		}

		if(item_amount($item[the big book of pirate insults]) == 0)
		{
			if(!in_hardcore() || (pulls_remaining() > 0))
			{
				pullXWhenHaveY($item[The Big Book of Pirate Insults], 1, 0);
				if(item_amount($item[the big book of pirate insults]) == 0)
				{
					abort("Do not have a pirate insult book, fix that and run again");
				}
			}
		}
		if(my_class() == $class[Ed])
		{
			change_mcd(0);
		}
		ccAdv(1, $location[The Obligatory Pirate\'s Cove]);
		return true;
	}
	return false;
}


boolean L8_trapperYeti()
{
	if(get_property("cc_trapper") != "yeti")
	{
		return false;
	}

	if(!have_skill($skill[Rain Man]) && (pulls_remaining() >= 3))
	{
		if(item_amount($item[Ninja Rope]) == 0)
		{
			pullXWhenHaveY($item[Ninja Rope], 1, 0);
		}
		if(item_amount($item[Ninja Crampons]) == 0)
		{
			pullXWhenHaveY($item[Ninja Crampons], 1, 0);
		}
		if(item_amount($item[Ninja Carabiner]) == 0)
		{
			pullXWhenHaveY($item[Ninja Carabiner], 1, 0);
		}
	}

	if((item_amount($item[Ninja Rope]) >= 1) && (item_amount($item[Ninja Carabiner]) >= 1) && (item_amount($item[Ninja Crampons]) >= 1))
	{
		if(elemental_resist($element[cold]) < 5)
		{
			buffMaintain($effect[Astral Shell], 10, 1, 1);
			buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		}
		if(elemental_resist($element[cold]) >= 5)
		{
			if(get_property("cc_mistypeak") == "")
			{
				set_property("cc_ninjasnowmanassassin", "1");
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
				set_property("cc_mistypeak", "done");
			}

			print("Time to take out Gargle", "blue");
			if((item_amount($item[Groar\'s Fur]) == 0) && (item_amount($item[Winged Yeti Fur]) == 0))
			{
				//If this returns false, we might have finished already, can we check this?
				ccAdv(1, $location[Mist-shrouded Peak]);
			}
			else
			{
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				autosell(5, $item[dense meat stack]);
				set_property("cc_trapper", "finished");
				council();
			}
			return true;
		}
	}
	else if(my_class() == $class[Ed])
	{
		if(get_property("questL08Trapper") == "step1")
		{
			set_property("questL08Trapper", "step2");
		}
		if(item_amount($item[Talisman of Horus]) == 0)
		{
			return false;
		}

		if((have_effect($effect[Taunt of Horus]) == 0) && (item_amount($item[Talisman of Horus]) == 0))
		{
			return false;
		}

		if((have_effect($effect[Thrice-Cursed]) > 0) || (have_effect($effect[Twice-Cursed]) > 0) || (have_effect($effect[Once-Cursed]) > 0))
		{
			return false;
		}


		if(!uneffect($effect[Shelter Of Shed]))
		{
			print("Could not uneffect Shelter of Shed for ninja snowmen, delaying");
			return false;
		}
		buffMaintain($effect[Taunt of Horus], 0, 1, 1);
		if(have_effect($effect[Taunt of Horus]) > 0)
		{
			if(!elementalPlanes_access($element[spooky]))
			{
				adjustEdHat("myst");
			}
			if(!ccAdv(1, $location[Lair of the Ninja Snowmen]))
			{
				print("Seems like we failed the Ninja Snowmen unlock, reverting trapper setting", "red");
				set_property("cc_trapper", "start");
			}
			return true;
		}
	}
	else if(in_hardcore() && isGuildClass())
	{
		if((have_effect($effect[Thrice-Cursed]) > 0) || (have_effect($effect[Twice-Cursed]) > 0) || (have_effect($effect[Once-Cursed]) > 0))
		{
			return false;
		}

		uneffect($effect[The Sonata of Sneakiness]);
		buffMaintain($effect[Hippy Stench], 0, 1, 1);
		buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 10, 1, 1);
		buffMaintain($effect[Musk of the Moose], 10, 1, 1);
		handleFamiliar($familiar[Jumpsuited Hound Dog]);
		if(!ccAdv(1, $location[Lair of the Ninja Snowmen]))
		{
			print("Seems like we failed the Ninja Snowmen unlock, reverting trapper setting", "red");
			set_property("cc_trapper", "start");
		}
		handleFamiliar($familiar[Adventurous Spelunker]);
		return true;
	}
	return false;
}

boolean cc_tavern()
{
	if(get_property("cc_tavern") == "finished")
	{
		return false;
	}
	visit_url("cellar.php");
	# Mafia usually fixes tavernLayout when we visit the cellar. However, it sometimes leaves it in a broken state so we can't guarantee this will actually help. However, it will result in no net change in tavernLayout so at least we can abort.
	string tavern = get_property("tavernLayout");
	if(index_of(tavern, "3") != -1)
	{
		set_property("cc_tavern", "finished");
		return true;
	}
	print("In the tavern! Layout: " + tavern, "blue");
	boolean [int] locations = $ints[3, 2, 1, 0, 5, 10, 15, 20, 16, 21];
	foreach loc in locations
	{
		tavern = get_property("tavernLayout");
		if(char_at(tavern, loc) == "0")
		{
			int actual = loc + 1;
			#string newTavern = substring(tavern, 0, loc) + "1" + substring(tavern, loc+1, 25);
			#set_property("tavernLayout", newTavern);
			boolean needReset = false;
			#string page = visit_url("cellar.php?action=explore&whichspot=" + actual);

			if(ccAdvBypass("cellar.php?action=explore&whichspot=" + actual))
			{
				return true;
			}

			string page = visit_url("main.php");
			if(contains_text(page, "You've already explored that spot."))
			{
				needReset = true;
				print("tavernLayout is not reporting places we've been to.", "red");
			}
			if(contains_text(page, "Darkness (5,5)"))
			{
				needReset = true;
				print("tavernLayout is reporting too many places as visited.", "red");
			}

			#page = visit_url("main.php");
			#if(contains_text(page, "Combat"))
			#{
			#	ccAdv(1, $location[Noob Cave]);
			#}
			if(contains_text(page, "whichchoice value=") || contains_text(page, "whichchoice="))
			{
				adv1($location[Noob Cave], 1, "");
			}
			if(last_monster() == $monster[Crate])
			{
				if(get_property("cc_newbieOverride").to_boolean())
				{
					set_property("cc_newbieOverride", false);
				}
				else
				{
					abort("We went to the Noob Cave for reals... uh oh");
				}
			}
			if(get_property("lastEncounter") == "Like a Bat Into Hell")
			{
				abort("Got stuck undying while trying to do the tavern. Must handle manualy and then resume.");
			}

			if(needReset)
			{
				print("We attempted a tavern adventure but the tavern layout was not maintained properly.", "red");
				print("Attempting to reset this issue...", "red");
				set_property("tavernLayout", "0000100000000000000000000");
				visit_url("cellar.php");
			}
			return true;
		}
	}
	print("We found no valid location to tavern, something went wrong...", "red");
	print("Attempting to reset this issue...", "red");
	set_property("tavernLayout", "0000100000000000000000000");
	wait(5);
	return true;
}

boolean L3_tavern()
{
	if(get_property("cc_tavern") == "finished")
	{
		return false;
	}
	if(my_adventures() < 5)
	{
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 10) == "Fortune Cookie")
	{
		return false;
	}

	int mpNeed = 0;
	if(have_skill($skill[The Sonata of Sneakiness]) && (have_effect($effect[The Sonata of Sneakiness]) == 0))
	{
		mpNeed = mpNeed + 20;
	}
	if(have_skill($skill[Smooth Movement]) && (have_effect($effect[Smooth Movements]) == 0))
	{
		mpNeed = mpNeed + 10;
	}

	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure1000", "1");
		set_property("choiceAdventure1001", "2");
		if((my_mp() < 15) && have_skill($skill[Shelter of Shed]))
		{
			return false;
		}
	}
	else if((have_effect($effect[In A Lather]) == 0) || (my_mp() < mpNeed))
	{
		if((my_daycount() <= 2) && (my_level() <= 11))
		{
			return false;
		}
	}
	print("Doing Tavern", "blue");
	if(have_effect($effect[In A Lather]) > 0)
	{
		set_property("choiceAdventure513", "2");
		set_property("choiceAdventure514", "2");
		set_property("choiceAdventure515", "2");
		set_property("choiceAdventure496", "2");
	}
	else
	{
		set_property("choiceAdventure513", "1");
		set_property("choiceAdventure514", "1");
		set_property("choiceAdventure515", "1");
		set_property("choiceAdventure496", "1");
	}

	if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
	{
		handleBjornify($familiar[grimstone golem]);
	}

	buffMaintain($effect[The Sonata of Sneakiness], 20, 1, 1);
	buffMaintain($effect[Smooth Movements], 10, 1, 1);
	buffMaintain($effect[Tortious], 0, 1, 1);
	buffMaintain($effect[Litterbug], 0, 1, 1);
	change_mcd(10);

	while(cc_tavern())
	{
		if(my_adventures() <= 0)
		{
			abort("Ran out of adventures while doing the tavern.");
		}
		wait(4);
	}
	visit_url("tavern.php?place=barkeep");
#	tavern();
#	cli_execute("ccs null");
	set_property("cc_tavern", "finished");
	council();
	return true;
}


boolean LX_setBallroomSong()
{
	if((get_property("cc_ballroomopen") != "open") || (get_property("cc_ballroomsong") == "set"))
	{
		return false;
	}
	if(get_property("lastQuartetRequest").to_int() != 0)
	{
		set_property("cc_ballroomsong", "set");
		return false;
	}
	if(my_class() == $class[Ed])
	{
		return false;
	}

	if(my_mp() > 60)
	{
		handleBjornify($familiar[grimstone golem]);
	}
	set_property("choiceAdventure90", "3");

	set_property("choiceAdventure106", "2");
	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure106", "1");
	}

	ccAdv(1, $location[The Haunted Ballroom]);
	if(contains_text(get_property("lastEncounter"), "Strung-Up Quartet"))
	{
		set_property("cc_ballroomsong", "set");
	}
	if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
	{
		set_property("cc_ballroomflat", "organ");
		if(my_class() == $class[Ed])
		{
			set_property("cc_ballroomsong", "set");
		}
	}
	return true;
}

boolean autosellCrap()
{
	if(item_amount($item[dense meat stack]) > 1)
	{
		autosell(1, $item[dense meat stack]);
	}


	if(!in_hardcore() && !isGuildClass())
	{
		return false;
	}
	if(my_meat() > 6500)
	{
		return false;
	}

	foreach it in $items[Fancy Bath Salts, Empty Cloaca-Cola Bottle, Keel-Haulin\' Knife, Photoprotoneutron Torpedo, Procrastination Potion, Awful Poetry Journal, Imp Ale, Ratgut, Patchouli Incense Stick, Frigid Ninja Stars, Tambourine Bells, Beach Glass Bead, Clay Peace-Sign Bead, Windchimes, Phat Turquoise Bead, Decorative Fountain, Moxie Weed, Strongness Elixir, Sunken Chest]
	{
		if(item_amount(it) > 0)
		{
			autosell(item_amount(it), it);
		}
	}
	if(item_amount($item[hot wing]) > 3)
	{
		autosell(item_amount($item[hot wing]) - 3, $item[hot wing]);
	}
	return true;
}


boolean doTasks()
{
	if(my_thunder() > get_property("cc_lastthunder").to_int())
	{
		set_property("cc_lastthunderturn", "" + my_turncount());
		set_property("cc_lastthunder", "" + my_thunder());
	}
	wait(1);
	print("Turn(" + my_turncount() + "): Starting with " + my_adventures() + " left and " + pulls_remaining() + " pulls left at Level: " + my_level(), "cyan");
	if((item_amount($item[rock band flyers]) == 1) && (get_property("flyeredML").to_int() < 10000))
	{
		print("Still flyering: " + get_property("flyeredML"), "blue");
	}
	print("Encounter: " + combat_rate_modifier() + "   Exp Bonus: " + experience_bonus(), "blue");
	print("Meat: " + meat_drop_modifier() + "   Item: " + item_drop_modifier(), "blue");
	print("ML: " + monster_level_adjustment() + " control: " + current_mcd(), "blue");
	if(my_class() == $class[Sauceror])
	{
		print("Soulsauce: " + my_soulsauce(), "blue");
	}
	if(have_effect($effect[ultrahydrated]) > 0)
	{
		print("Ultrahydrated: " + have_effect($effect[ultrahydrated]), "violet");
	}
	if(have_effect($effect[Everything looks yellow]) > 0)
	{
		print("Everything Looks Yellow: " + have_effect($effect[everything looks yellow]), "blue");
	}
	if((item_amount($item[Snow suit]) > 0) || (equipped_item($slot[familiar]) == $item[snow suit]))
	{
		print("Snow suit usage: " + get_property("_snowSuitCount") + " carrots: " + get_property("_carrotNoseDrops"), "blue");
	}
	print("HP: " + my_hp() + "/" + my_maxhp() + "\tMP: " + my_mp() + "/" + my_maxmp(), "violet");
	if(my_path() == "Heavy Rains")
	{
		print("Post adventure done: Thunder: " + my_thunder() + " Rain: " + my_rain() + " Lightning: " + my_lightning(), "green");
	}
	if(my_class() == $class[Ed])
	{
		print("Ka Coins: " + item_amount($item[Ka Coin]) + " Lashes used: " + get_property("_edLashCount"), "green");
	}

	questOverride();

	if(get_property("cc_interrupt").to_boolean())
	{
		set_property("cc_interrupt", false);
		abort("cc_interrupt detected and aborting, cc_interrupt disabled.");
	}

	int delay = get_property("cc_delayTimer").to_int();
	if(delay != 0)
	{
		print("Delay between adventures... beep boop... ", "blue");
		wait(delay);
	}

	if((monster_level_adjustment() > 150) && (monster_level_adjustment() < 160))
	{
		int base = (monster_level_adjustment() - current_mcd());
		if(base < 150)
		{
			int canhave = 150 - base;
			change_mcd(canhave);
		}
	}
	else
	{
		if((get_property("flyeredML").to_int() >= 10000) && (my_level() >= 13))
		{
			if(current_mcd() != 0)
			{
				change_mcd(0);
			}
		}
		else if(((monster_level_adjustment() + (10 - current_mcd())) < 150) && (current_mcd() != 10))
		{
			change_mcd(10);
		}
	}
	if((my_familiar() == $familiar[Reanimated Reanimator]) && (get_property("_badlyRomanticArrows") == "1"))
	{
		print("We have a Reanimator as our familiar but can't winkat anymore. Let's change to our default.", "red");
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if(my_familiar() == $familiar[Crimbo Shrub])
	{
		if((get_property("_jungDrops").to_int() == 1) || (my_daycount() > 1))
		{
			handleFamiliar($familiar[Adventurous Spelunker]);
		}
		else
		{
			handleFamiliar($familiar[Angry Jung Man]);
		}
	}
	if(my_familiar() == $familiar[Angry Jung Man])
	{
		if((get_property("_jungDrops").to_int() == 1) || (my_daycount() > 1))
		{
			handleFamiliar($familiar[Adventurous Spelunker]);
		}
	}
	else if((my_familiar() == $familiar[Adventurous Spelunker]) && (get_property("_jungDrops").to_int() == 0) && (my_daycount() == 1))
	{
		handleFamiliar($familiar[Angry Jung Man]);
	}

	int spleen_hold = 4;
	if(item_amount($item[Astral Energy Drink]) > 0)
	{
		spleen_hold = spleen_hold + 8;
	}
	if(in_hardcore() && ((my_spleen_use() + spleen_hold) <= spleen_limit()))
	{
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else if((grimTaleDrops() < 1) && have_familiar($familiar[Grim Brother]))
		{
			handleFamiliar($familiar[Grim Brother]);
		}
		else if((powderedGoldDrops() < 1) && have_familiar($familiar[Golden Monkey]))
		{
			handleFamiliar($familiar[Golden Monkey]);
		}
	}
	else if(in_hardcore() && (item_amount($item[Yellow Pixel]) < 20))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
	}

	if((my_familiar() == $familiar[Unconscious Collective]) && (dreamJarDrops() >= 1))
	{
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if((my_familiar() == $familiar[Golden Monkey]) && (powderedGoldDrops() >= 1))
	{
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if((my_familiar() == $familiar[Grim Brother]) && (grimTaleDrops() >= 1))
	{
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if((my_familiar() == $familiar[Puck Man]) && (item_amount($item[Yellow Pixel]) > 20))
	{
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if((my_familiar() == $familiar[Ms. Puck Man]) && (item_amount($item[Yellow Pixel]) > 20))
	{
		handleFamiliar($familiar[Adventurous Spelunker]);
	}
	if(in_hardcore() && (my_familiar() == $familiar[Adventurous Spelunker]) && (my_mp() < 50) && ((my_mp() * 2) <
my_maxmp()))
	{
		handleFamiliar($familiar[Galloping Grill]);
	}


	oldPeoplePlantStuff();
	picky_buyskills();

	if(get_property("cc_doCombatCopy") == "yes")
	{
		# This should never persist into another turn, ever.
		set_property("cc_doCombatCopy", "no");
	}

	if((equipped_item($slot[familiar]) == $item[none]) && (my_familiar() != $familiar[none]) && (my_path() == "Heavy Rains"))
	{
		abort("Familiar has no equipment, WTF");
	}

	if(item_amount($item[pulled red taffy]) >= 6)
	{
		use(item_amount($item[pulled red taffy]), $item[pulled red taffy]);
	}
	if(item_amount($item[pulled orange taffy]) >= 6)
	{
		use(item_amount($item[pulled orange taffy]), $item[pulled orange taffy]);
	}
	if(item_amount($item[pulled violet taffy]) >= 6)
	{
		use(item_amount($item[pulled violet taffy]), $item[pulled violet taffy]);
	}
	buyableMaintain($item[Ben-gal&trade; Balm], 1, 200);
	buyableMaintain($item[Turtle Pheromones], 1, 800, my_class() == $class[Turtle Tamer]);
	buyableMaintain($item[Hair Spray], 1, 200, my_class() != $class[Turtle Tamer]);
	buyableMaintain($item[Blood of the Wereseal], 1, 3500, (monster_level_adjustment() > 135));
	buffMaintain($effect[Gummi-Grin], 0, 1, 1);
	buffMaintain($effect[Strong Resolve], 0, 1, 1);
	buffMaintain($effect[Irresistible Resolve], 0, 1, 1);
	buffMaintain($effect[Brilliant Resolve], 0, 1, 1);
	buffMaintain($effect[From Nantucket], 0, 1, 1);
	buffMaintain($effect[Squatting and Thrusting], 0, 1, 1);
	buffMaintain($effect[You Read the Manual], 0, 1, 1);

	autosellCrap();

	if(my_level() > get_property("lastCouncilVisit").to_int())
	{
		council();
		if((my_class() == $class[Ed]) && (my_level() == 11) && (item_amount($item[7961]) > 0))
		{
			cli_execute("refresh inv");
		}
	}

	equipBaseline();

	if(doHRSkills())
	{
		return true;
	}
	handleJar();

	if((have_effect($effect[beaten up]) > 0) && (my_path() == "One Crazy Random Summer"))
	{
		if(contains_text(get_property("cc_funPrefix"), "annoying") ||
			contains_text(get_property("cc_funPrefix"), "phase-shifting") ||
			contains_text(get_property("cc_funPrefix"), "restless") ||
			contains_text(get_property("cc_funPrefix"), "ticking"))
		{
			print("Probably beaten up by FUN! Trying to recover instead of aborting", "red");
			handleTracker(last_monster(), get_property("cc_funPrefix"), "cc_funTracker");
			if(have_skill($skill[Tongue of the Walrus]) && have_skill($skill[Cannelloni Cocoon]) && (my_mp() >= 30))
			{
				use_skill(1, $skill[Tongue of the Walrus]);
				useCocoon();
			}
			else
			{
				cli_execute("hottub");
			}
		}
	}


	if(have_effect($effect[beaten up]) > 0)
	{
		abort("Got beaten up, please fix me");
	}

	if(last_monster() == $monster[Crate])
	{
		if(get_property("cc_newbieOverride").to_boolean())
		{
			set_property("cc_newbieOverride", false);
		}
		else
		{
			abort("We went to the Noob Cave for reals... uh oh");
		}
	}
	else
	{
		set_property("cc_newbieOverride", false);
	}

	if(my_location().turns_spent > 50)
	{
		if(($locations[The Secret Government Laboratory, The Battlefield (Frat Uniform), The Battlefield (Hippy Uniform), Noob Cave, Pirates of the Garbage Barges, Sloppy Seconds Diner] contains my_location()) == false)
		{
			abort("We have spent over 50 turns at '" + my_location() + "' and that is bad... aborting.");
		}
	}


	hr_dnaPotions();
	picky_dnaPotions();
	standard_dnaPotions();

	# FIXME: Can we do this earlier? This isn't even all that useful, to be fair.
	# When is the last time we encounter each of these types?
	if((my_level() >= 13) && (get_property("_dnaPotionsMade").to_int() == 3) && (get_property("choiceAdventure1003").to_int() < 3) && (!get_property("_dnaHybrid").to_boolean()))
	{
		if((get_property("nsChallenge2") == "") && (get_property("telescopeUpgrades").to_int() >= 2))
		{
			ns_crowd3();
		}
		if((get_property("dnaSyringe") == "plant") && (get_property("nsChallenge2") == "cold"))
		{
			cli_execute("camp dnainject");
		}
		if((get_property("dnaSyringe") == "demon") && (get_property("nsChallenge2") == "hot"))
		{
			cli_execute("camp dnainject");
		}
		if((get_property("dnaSyringe") == "slime") && (get_property("nsChallenge2") == "sleaze"))
		{
			cli_execute("camp dnainject");
		}
		if((get_property("dnaSyringe") == "undead") && (get_property("nsChallenge2") == "spooky"))
		{
			cli_execute("camp dnainject");
		}
		if((get_property("dnaSyringe") == "hobo") && (get_property("nsChallenge2") == "stench"))
		{
			cli_execute("camp dnainject");
		}
	}



	if(get_property("dnaSyringe") == "construct")
	{
		if((get_property("_dnaPotionsMade").to_int() == 0) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == "fish")
	{
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 1))
		{
			cli_execute("camp dnapotion");
		}
		if((get_property("_dnaPotionsMade").to_int() == 0) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == "constellation")
	{
		if((get_property("_dnaPotionsMade").to_int() == 1) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("dnaSyringe") == "dude")
	{
		if((get_property("_dnaPotionsMade").to_int() == 2) && (my_daycount() == 2))
		{
			cli_execute("camp dnapotion");
		}
	}

	if(get_property("cc_useCubeling").to_boolean())
	{
		if((item_amount($item[ring of detect boring doors]) == 1) && (item_amount($item[eleven-foot pole]) == 1) && (item_amount($item[pick-o-matic lockpicks]) == 1))
		{
			set_property("cc_cubeItems", "done");
		}
		if((get_property("cc_cubeItems") == "") && (my_familiar() != $familiar[Gelatinous Cubeling]))
		{
			handleFamiliar($familiar[Gelatinous Cubeling]);
		}
	}

	if((my_daycount() == 1) && (turkeyBooze() < 5) && have_familiar($familiar[Fist Turkey]))
	{
		handleFamiliar($familiar[Fist Turkey]);
	}

	if((item_amount($item[snow berries]) == 3) && (my_daycount() == 1) && get_property("cc_grimstoneFancyOilPainting").to_boolean())
	{
		cli_execute("make 1 snow cleats");
	}

	if((item_amount($item[snow berries]) > 0) && (my_daycount() > 1) && (get_property("chasmBridgeProgress").to_int() >= 30))
	{
		visit_url("place.php?whichplace=orc_chasm");
		if(get_property("chasmBridgeProgress").to_int() >= 30)
		{
			if(in_hardcore() && isGuildClass())
			{
				if((item_amount($item[Snow Berries]) >= 3) && (item_amount($item[Ice Harvest]) >=3))
				{
					cli_execute("make 1 Unfinished Ice Sculpture");
				}
				if(item_amount($item[Snow Berries]) >= 2)
				{
					cli_execute("make 1 Snow Crab");
				}
			}
			cli_execute("make " + item_amount($item[snow berries]) + " snow cleats");
		}
		else
		{
			abort("Bridge progress came up as >= 30 but is no longer after viewing the page.");
		}
	}

	fortuneCookieEvent();

	if(knoll_available() && (item_amount($item[detuned radio]) == 0) && (my_meat() > 300))
	{
		buyUpTo(1, $item[detuned radio]);
		change_mcd(10);
		visit_url("choice.php?pwd&whichchoice=835&option=2", true);
	}

	consumeStuff();
	int paintingLevel = 8;
	if(my_path() == "One Crazy Random Summer")
	{
		paintingLevel = 9;
	}
	if((my_level() >= paintingLevel) && (chateaumantegna_havePainting()) && (my_class() == $class[Ed]) && (my_daycount() <= 3))
	{
		if((have_effect($effect[Everything Looks Yellow]) == 0) && have_skill($skill[Wrath of Ra]) && (my_mp() >= 40))
		{
			if(chateaumantegna_usePainting())
			{
				ccAdv(1, $location[Noob Cave]);
				return true;
			}
		}
	}


	if((my_level() >= 9) && !get_property("_photocopyUsed").to_boolean() && (my_class() == $class[Ed]) && (my_daycount() < 3))
	{
		if(handleFaxMonster("lobsterfrogman"))
		{
			ccAdv(1, $location[Noob Cave]);
			return true;
		}
	}

	if(LX_dictionary())
	{
		return true;
	}
	if((my_level() >= 5) && (item_amount($item[knob goblin encryption key]) == 1))
	{
		if(item_amount($item[Cobb\'s Knob Map]) == 0)
		{
			council();
		}
		use(1, $item[Cobb\'s Knob Map]);
		return true;
	}

	if(!in_hardcore() || !isGuildClass())
	{
		if(deck_useScheme("turns"))
		{
			return true;
		}
	}

	if(my_class() == $class[Ed])
	{
		ed_buySkills();

		if(get_property("edPiece") != "hyena")
		{
			if(get_property("spookyAirportAlways").to_boolean() || (my_level() >= 5))
			{
				adjustEdHat("ml");
			}
			else
			{
				adjustEdHat("myst");
			}
		}
		if(L1_edIsland() || l1_edIslandFallback())
		{
			return true;
		}

		if(L5_getEncryptionKey())
		{
			return true;
		}

		if(LX_islandAccess())
		{
			return true;
		}
		if((item_amount($item[Hermit Permit]) == 0) && (my_meat() > 100))
		{
			buy(1, $item[Hermit Permit]);
		}
		while((item_amount($item[Seal Tooth]) == 0) && (item_amount($item[Hermit Permit]) > 0) && (my_meat() > 50))
		{
			if((item_amount($item[Worthless Trinket]) + item_amount($item[Worthless Gewgaw]) + item_amount($item[Worthless Knick-knack])) > 0)
			{
				hermit(1, $item[Seal Tooth]);
			}
			else
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}
		}

		if(my_level() >= 9)
		{
			if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
				cli_execute("scripts/postcheese.ash");
				return true;
			}
		}

		if(L10_plantThatBean() || L10_airship() || L10_basement() || L10_ground() || L10_topFloor())
		{
			return true;
		}

		if(L12_preOutfit())
		{
			return true;
		}

		if(get_property("cc_dickstab").to_boolean())
		{
			if((my_level() >= 5) && (chateaumantegna_havePainting()) && (my_daycount() <= 2) && (my_class() != $class[Ed]))
			{
				if(chateaumantegna_usePainting())
				{
					ccAdv(1, $location[Noob Cave]);
					return true;
				}
			}
			if(L1_edDinsey())
			{
				return true;
			}
			if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
			{
				return true;
			}
			if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
			{
				return true;
			}
			if(L4_batCave())
			{
				return true;
			}
			if(L5_getEncryptionKey())
			{
				return true;
			}
			if(L5_goblinKing())
			{
				return true;
			}
			if(L9_chasmStart() || L9_chasmBuild())
			{
				return true;
			}
			if(LX_pirateOutfit() || LX_pirateInsults() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
			{
				return true;
			}
			if(LX_dinseylandfillFunbucks())
			{
				return true;
			}

			if(my_level() < 9)
			{
				if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
				{
					doRest();
					cli_execute("scripts/postcheese.ash");
					return true;
				}
			}

			if(L1_edIsland(10))
			{
				return true;
			}

			buffMaintain($effect[The Dinsey Look], 0, 1, 1);

			if(L7_crypt())
			{
				if(item_amount($item[FunFunds&trade;]) > 4)
				{
					buy(1, $item[Dinsey Face Paint]);
				}
				return true;
			}


		}


		if(LX_pirateOutfit() || LX_pirateInsults() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
		{
			return true;
		}
		if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
		{
			return true;
		}
		if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
		{
			return true;
		}
		if(L4_batCave())
		{
			return true;
		}
		if(L5_goblinKing())
		{
			return true;
		}
		if(!get_property("cc_dickstab").to_boolean() || (my_daycount() >= 2))
		{
			if(L3_tavern())
			{
				return true;
			}
		}

		if(L9_chasmStart() || L9_chasmBuild())
		{
			return true;
		}

		if(L6_friarsGetParts() || L6_friarsHotWing())
		{
			return true;
		}
		if(L11_blackMarket() || L11_forgedDocuments() || L11_mcmuffinDiary() || L11_talismanOfNam())
		{
			return true;
		}

		if(my_spleen_use() == 35)
		{
			if(my_daycount() >= 2)
			{
				if(my_mp() < 40)
				{
					buffMaintain($effect[Spiritually Awake], 0, 1, 1);
					buffMaintain($effect[Spiritually Aware], 0, 1, 1);
					buffMaintain($effect[Spiritually Awash], 0, 1, 1);
				}
			}
		}
	}

	if(organsFull() && (my_adventures() < 10) && (chateaumantegna_havePainting()) && (my_daycount() == 1) && (my_class() != $class[Ed]))
	{
		if(chateaumantegna_usePainting())
		{
			ccAdv(1, $location[Noob Cave]);
			return true;
		}
	}
	if((my_level() >= 8) && (chateaumantegna_havePainting()) && (my_daycount() == 2) && (my_class() != $class[Ed]))
	{
		if(chateaumantegna_usePainting())
		{
			ccAdv(1, $location[Noob Cave]);
			return true;
		}
	}

	if((my_class() != $class[Ed]) && (my_level() >= 9) && (my_daycount() == 1))
	{
		if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
		{
			doRest();
			cli_execute("scripts/postcheese.ash");
			return true;
		}
	}

	if(LX_dinseylandfillFunbucks())
	{
		return true;
	}

	#Can we have some other way to check that we have AT skills?
	if((item_amount($item[antique accordion]) == 0) && (my_meat() > 12500) && (have_skill($skill[The Ode to Booze])))
	{
		buyUpTo(1, $item[antique accordion]);
	}


	if(L12_flyerFinish())
	{
		return true;
	}

	if((my_level() >= 12) && (item_amount($item[rock band flyers]) == 0) && (get_property("flyeredML").to_int() < 10000) && ((get_property("cc_hiddenapartment") == "0") || (get_property("cc_hiddenapartment") == "finished")) && (have_effect($effect[ultrahydrated]) == 0))
	{
		if(L12_getOutfit())
		{
			return true;
		}

		if(L12_startWar())
		{
			return true;
		}
	}

	if(LX_guildUnlock())
	{
		return true;
	}

	if(in_hardcore() && isGuildClass())
	{
		switch(my_daycount())
		{
		case 1:
			if(deck_useScheme("HC1stats"))
			{
				return true;
			}
			break;
		case 2:
			if(deck_useScheme("HC2"))
			{
				return true;
			}
			break;
		case 3:
			if(deck_useScheme("HC3"))
			{
				return true;
			}
			break;
		}
	}

	if(L5_getEncryptionKey())
	{
		return true;
	}

	if(LX_handleSpookyravenNecklace())
	{
		return true;
	}

	if(L0_handleRainDoh())
	{
		return true;
	}

	if(routineRainManHandler())
	{
		return true;
	}

	if(LX_handleSpookyravenFirstFloor())
	{
		return true;
	}

	if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
	{
		return true;
	}

	if(get_property("lastGoofballBuy").to_int() < my_ascensions())
	{
		visit_url("woods.php");
		print("Got Goofballs", "blue");
		visit_url("tavern.php?place=susguy&action=buygoofballs", true);
	}

	if((item_amount($item[bitchin\' meatcar]) == 0) && !gnomads_available() && (my_class() != $class[Ed]))
	{
		cli_execute("make bitch");
		cli_execute("place.php?whichplace=desertbeach&action=db_nukehouse");
	}

	if(L5_haremOutfit())
	{
		return true;
	}

	if(LX_phatLootToken())
	{
		return true;
	}

	if(LX_islandAccess())
	{
		return true;
	}

	if(L4_batCave())
	{
		return true;
	}

	if(L5_goblinKing())
	{
		return true;
	}

	if(in_hardcore() && isGuildClass())
	{
		if(L6_friarsGetParts() || L6_friarsHotWing())
		{
			return true;
		}
	}

	if(LX_spookyravenSecond() || LX_setBallroomSong())
	{
		return true;
	}

	if(L3_tavern())
	{
		return true;
	}

	if(L6_friarsGetParts() || L6_friarsHotWing())
	{
		return true;
	}

	if(LX_hardcoreFoodFarm())
	{
		return true;
	}

	if(L9_leafletQuest())
	{
		return true;
	}

	if(L7_crypt())
	{
		return true;
	}

	if(LX_fancyOilPainting())
	{
		return true;
	}

	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}

	if(LX_pirateOutfit() || LX_pirateInsults() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
	{
		return true;
	}

	if(L10_plantThatBean())
	{
		return true;
	}

	if(L12_preOutfit())
	{
		return true;
	}

	if(L10_airship() || L10_basement() || L10_ground() || L10_topFloor())
	{
		return true;
	}

	if(L10_holeInTheSkyUnlock() || L10_holeInTheSky())
	{
		return true;
	}

	if(L9_chasmStart() || L9_chasmBuild())
	{
		return true;
	}

	if(L9_highLandlord())
	{
		return true;
	}

	if(Lsc_flyerSeals())
	{
		return true;
	}

	if(L11_blackMarket() || L11_forgedDocuments() || L11_mcmuffinDiary() || L11_talismanOfNam())
	{
		return true;
	}

	if(L11_mauriceSpookyraven())
	{
		return true;
	}

	if(L11_nostrilOfTheSerpent())
	{
		return true;
	}

	if(L11_unlockHiddenCity())
	{
		return true;
	}

	if(L11_hiddenCityZones())
	{
		return true;
	}

	if(LX_ornateDowsingRod())
	{
		return true;
	}

	if(L12_nunsTrickGlandGet())
	{
		return true;
	}
	if(get_property("cc_hippyInstead").to_boolean() && (get_property("cc_nunsTrick") == "true"))
	{
		set_property("cc_nunsTrick", "false");
		set_property("cc_ignoreFlyer", true);
	}

	if(L11_aridDesert())
	{
		return true;
	}


	if((get_property("cc_nunsTrick") == "got") && (get_property("currentNunneryMeat").to_int() < 100000) && !get_property("cc_100familiar").to_boolean())
	{
		set_property("cc_nunsTrickActive", "yes");
		if((get_property("cc_mcmuffin") == "ed") || (get_property("cc_mcmuffin") == "finished"))
		{
			if(doThemtharHills(true))
			{
				return true;
			}
		}
	}

	if(get_property("cc_nunsTrickActive") == "yes")
	{
		set_property("cc_nunsTrickActive", "no");
	}

	if((get_property("cc_nuns") == "done") && (item_amount($item[half a purse]) > 0))
	{
		pulverizeThing($item[Half A Purse]);
		if(item_amount($item[Handful of Smithereens]) > 0)
		{
			cli_execute("make louder than bomb");
		}
	}

	boolean canDoHidden = true;
	if((item_amount($item[Moss-Covered Stone Sphere]) == 0) && (get_property("cc_hiddenapartment") != "finished"))
	{
		if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
		{
			canDoHidden = false;
		}
		if((my_adventures() < (9 - get_property("cc_hiddenapartment").to_int())))
		{
			canDoHidden = false;
		}
	}

	if((get_property("cc_hiddenzones") == "finished") && (get_property("cc_hiddencity") == "") && canDoHidden)
	{
		if(my_class() == $class[Ed])
		{
			if(item_amount($item[7963]) == 0)
			{
				set_property("cc_hiddencity", "finished");
				return true;
			}
		}
		else if(item_amount($item[2180]) == 1)
		{
			set_property("cc_hiddencity", "finished");
			return true;
		}


		if((get_property("_nanorhinoBanishedMonster") == "") && (have_effect($effect[nanobrawny]) == 0))
		{
			handleFamiliar($familiar[Nanorhino]);
		}
		else
		{
			handleFamiliar($familiar[Adventurous Spelunker]);
		}


		if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
		{
			use(1, $item[Book of Matches]);
		}

		if((get_property("cc_hiddenapartment") != "finished"))
		{
			if(item_amount($item[Moss-Covered Stone Sphere]) > 0)
			{
				set_property("cc_hiddenapartment", "finished");
				cli_execute("hottub");
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				return true;
			}
			print("The idden [sic] apartment!", "blue");
			int current = get_property("cc_hiddenapartment").to_int();
			current = current + 1;
			set_property("cc_hiddenapartment", current);
			if(current <= 8)
			{
				print("Hidden Apartment Progress: " + get_property("hiddenApartmentProgress"), "blue");
				ccAdv(1, $location[The Hidden Apartment Building]);
				return true;
			}
			else
			{
				set_property("choiceAdventure780", "1");
				if(have_effect($effect[Thrice-Cursed]) == 0)
				{
					if((item_amount($item[Book of Matches]) == 0) && !in_hardcore())
					{
						pullXWhenHaveY($item[Book of Matches], 1, 0);
					}
					if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
					{
						use(1, $item[Book of Matches]);
					}
					while(have_effect($effect[Thrice-Cursed]) == 0)
					{
						if((inebriety_limit() - my_inebriety()) > 0)
						{
							if(my_mp() > 50)
							{
								shrugAT();
								buffMaintain($effect[Ode to Booze], 50, 1, 1);
							}
							buyUpTo(1, $item[Cursed Punch]);
							drink(1, $item[Cursed Punch]);
						}
						else
						{
							set_property("choiceAdventure780", "2");
							break;
						}
					}
				}
				print("Hidden Apartment Progress: " + get_property("hiddenApartmentProgress"), "blue");
				ccAdv(1, $location[The Hidden Apartment Building]);
				return true;
			}
		}
		if((get_property("cc_hiddenoffice") != "finished") && (my_adventures() >= 11))
		{
			if(item_amount($item[Crackling Stone Sphere]) > 0)
			{
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				set_property("cc_hiddenoffice", "finished");
				return true;
			}
			print("The idden [sic] office!", "blue");
			int current = get_property("cc_hiddenoffice").to_int();
			current = current + 1;
			set_property("cc_hiddenoffice", ""+current);
			if(current <= 6)
			{
				set_property("choiceAdventure786", "2");
			}
			else
			{
				set_property("choiceAdventure786", "1");
			}

			print("Hidden Office Progress: " + get_property("hiddenOfficeProgress"), "blue");
			if(get_property("_grimstoneMaskDropsCrown").to_int() == 0)
			{
				handleBjornify($familiar[grimstone golem]);
			}

			if(get_property("cc_autoCraft") == "")
			{
				set_property("cc_autoCraft", get_property("autoCraft").to_boolean());
			}
			set_property("autoCraft", false);

			ccAdv(1, $location[The Hidden Office Building]);


			if((item_amount($item[Boring Binder Clip]) == 1) && (item_amount($item[McClusky File (Page 5)]) == 1))
			{
				#cli_execute("make mcclusky file (complete)");
				visit_url("inv_use.php?pwd=&which=3&whichitem=6694");
				cli_execute("refresh inv");
			}
			if(get_property("cc_autoCraft") != "")
			{
				set_property("autoCraft", get_property("cc_autoCraft").to_boolean());
				set_property("cc_autoCraft", "");
			}

#			if(item_amount($item[McClusky File (Complete)]) == 1)
#			{
#				print("If we abort saying that a boring binder clip doesn't make anything interesting.", "red");
#				print("Just run me again, we are trying to work with that...", "red");
#			}

			return true;
		}

		if(get_property("cc_hiddenbowling") != "finished")
		{
			if(item_amount($item[Scorched Stone Sphere]) > 0)
			{
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				set_property("cc_hiddenbowling", "finished");
				return true;
			}

			print("The idden [sic] bowling alley!", "blue");
			if(item_amount($item[Book of Matches]) == 0)
			{
				pullXWhenHaveY($item[Book of Matches], 1, 0);
			}
			if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
			{
				use(1, $item[Book of Matches]);
			}
			if(item_amount($item[Bowl Of Scorpions]) == 0)
			{
				buyUpTo(1, $item[Bowl Of Scorpions]);
				if(my_path() == "One Crazy Random Summer")
				{
					buyUpTo(3, $item[Bowl Of Scorpions]);
				}
			}
			set_property("choiceAdventure788", "1");

			if(item_amount($item[Airborne Mutagen]) > 1)
			{
				buffMaintain($effect[Heightened Senses], 0, 1, 1);
			}

			buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
			print("Hidden Bowling Alley Progress: " + get_property("hiddenBowlingAlleyProgress"), "blue");
			ccAdv(1, $location[The Hidden Bowling Alley]);

			return true;
		}

		if(get_property("cc_hiddenhospital") != "finished")
		{
			if(item_amount($item[Dripping Stone Sphere]) > 0)
			{
				set_property("cc_hiddenhospital", "finished");
				return true;
			}
			print("The idden osptial!! [sic]", "blue");
			set_property("choiceAdventure784", "1");

			if(item_amount($item[bloodied surgical dungarees]) > 0)
			{
				equip($item[bloodied surgical dungarees]);
			}
			if(item_amount($item[half-size scalpel]) > 0)
			{
				equip($item[half-size scalpel]);
			}
			if(item_amount($item[surgical apron]) > 0)
			{
				equip($item[surgical apron]);
			}
			if(item_amount($item[head mirror]) > 0)
			{
				equip($slot[acc3], $item[head mirror]);
			}
			if(item_amount($item[surgical mask]) > 0)
			{
				equip($slot[acc2], $item[surgical mask]);
			}
			print("Hidden Hospital Progress: " + get_property("hiddenHospitalProgress"), "blue");
			if(my_mp() > 60)
			{
				handleBjornify($familiar[grimstone golem]);
			}
			ccAdv(1, $location[The Hidden Hospital]);

			return true;
		}
		if((get_property("cc_hiddenapartment") == "finished") && (get_property("cc_hiddenoffice") == "finished") && (get_property("cc_hiddenbowling") == "finished") && (get_property("cc_hiddenhospital") == "finished"))
		{
			print("Getting the stone triangles", "blue");
			set_property("choiceAdventure791", "1");
			while(item_amount($item[stone triangle]) < 1)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
			}
			while(item_amount($item[stone triangle]) < 2)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
			}
			while(item_amount($item[stone triangle]) < 3)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
			}
			while(item_amount($item[stone triangle]) < 4)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
			}

			print("Fighting the out-of-work spirit", "blue");
			useCocoon();

			try
			{
				handleInitFamiliar();
				cli_execute("ccs cc_default");
				if(ccAdv(1, $location[A Massive Ziggurat])) {}
				handleFamiliar($familiar[Adventurous Spelunker]);
			}
			finally
			{
				cli_execute("ccs null");
				print("If I stopped, just run me again, beep!", "red");
			}

			if(item_amount($item[2180]) == 1)
			{
				set_property("cc_hiddencity", "finished");
			}

			return true;
		}
		abort("Should not have gotten here. Aborting");
	}

	if((get_property("cc_mcmuffin") == "start") && (get_property("cc_swordfish") == "finished") && (get_property("cc_palindome") == ""))
	{
		if(get_property("questL11Palindome") == "finished")
		{
			set_property("cc_palindome", "finished");
			return true;
		}
		if(equipped_item($slot[acc3]) != $item[Talisman O\' Namsilat])
		{
			equip($slot[acc3], $item[Talisman O\' Namsilat]);
		}

		int total = 0;
		total = total + item_amount($item[Photograph Of A Red Nugget]);
		total = total + item_amount($item[Photograph Of An Ostrich Egg]);
		total = total + item_amount($item[Photograph Of God]);
		total = total + item_amount($item[Photograph Of A Dog]);


		boolean lovemeDone = (item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0);
		if(get_property("palindomeDudesDefeated").to_int() >= 5)
		{
			string palindomeCheck = visit_url("place.php?whichplace=palindome");
			lovemeDone = lovemeDone || contains_text(palindomeCheck, "pal_drlabel");
		}

		print("In the palindome", "blue");
		#
		#	In hardcore, guild-class, the right side of the or doesn't happen properly due us farming the
		#	Mega Gem within the if, with pulls, it works fine. Need to fix this. This is bad.
		#
		if((item_amount($item[Bird Rib]) > 0) && (item_amount($item[Lion Oil]) > 0) && (item_amount($item[Wet Stew]) == 0))
		{
			craft("cook", 1, $item[Bird Rib], $item[Lion Oil]);
		}
		if((item_amount($item[Stunt Nuts]) > 0) && (item_amount($item[Wet Stew]) > 0) && (item_amount($item[Wet Stunt Nut Stew]) == 0))
		{
			craft("cook", 1, $item[wet stew], $item[stunt nuts]);
		}

		if((item_amount($item[Wet Stunt Nut Stew]) > 0) && !possessEquipment($item[Mega Gem]))
		{
			visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
		}

		if((total == 0) && !possessEquipment($item[Mega Gem]) && lovemeDone && in_hardcore() && isGuildClass() && (item_amount($item[Wet Stunt Nut Stew]) == 0))
		{
			if(item_amount($item[Wet Stunt Nut Stew]) == 0)
			{
				if((item_amount($item[Bird Rib]) == 0) || (item_amount($item[Lion Oil]) == 0))
				{
					print("Off to the grove for some doofy food!", "blue");
					ccAdv(1, $location[Whitey\'s Grove]);
				}
				else if(item_amount($item[Stunt Nuts]) == 0)
				{
					print("We got no nuts!! :O", "Blue");
					ccAdv(1, $location[Inside the Palindome]);
				}
				else
				{
					abort("Some sort of Wet Stunt Nut Stew error. Try making it yourself?");
				}
				return true;
			}
		}
		if((((total == 4) && (item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0)) || ((total == 0) && possessEquipment($item[Mega Gem]))) && loveMeDone)
		{
			if(item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0)
			{
				use(1, $item[&quot;I Love Me\, Vol. I&quot;]);
			}
			visit_url("place.php?whichplace=palindome&action=pal_drlabel");
			visit_url("choice.php?pwd&whichchoice=872&option=1&photo1=2259&photo2=7264&photo3=7263&photo4=7265");

			if(my_class() == $class[Ed])
			{
				set_property("cc_palindome", "finished");
				return true;
			}


			# is step 4 when we got the wet stunt nut stew?
			if(get_property("questL11Palindome") != "step5")
			{
				if(item_amount($item[&quot;2 Love Me\, Vol. 2&quot;]) > 0)
				{
					use(1, $item[&quot;2 Love Me\, Vol. 2&quot;]);
					cli_execute("hottub");
				}
				visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
				if(!in_hardcore() && (item_amount($item[Wet Stunt Nut Stew]) == 0))
				{
					if((item_amount($item[Wet Stew]) == 0) && (item_amount($item[Mega Gem]) == 0))
					{
						pullXWhenHaveY($item[Wet Stew], 1, 0);
					}
					if((item_amount($item[Stunt Nuts]) == 0) && (item_amount($item[Mega Gem]) == 0))
					{
						pullXWhenHaveY($item[Stunt Nuts], 1, 0);
					}
				}
				if(in_hardcore() && isGuildClass())
				{
					return true;
				}

			}

			if((item_amount($item[Bird Rib]) > 0) && (item_amount($item[Lion Oil]) > 0) && (item_amount($item[Wet Stew]) == 0))
			{
				craft("cook", 1, $item[Bird Rib], $item[Lion Oil]);
			}

			if((item_amount($item[Stunt Nuts]) > 0) && (item_amount($item[Wet Stew]) > 0) && (item_amount($item[Wet Stunt Nut Stew]) == 0))
			{
				craft("cook", 1, $item[wet stew], $item[stunt nuts]);
			}

			if(!possessEquipment($item[Mega Gem]))
			{
				visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
			}
			equip($slot[acc2], $item[Mega Gem]);
			print("War sir is raw!!", "blue");
			visit_url("place.php?whichplace=palindome&action=pal_drlabel");
			visit_url("choice.php?pwd&whichchoice=131&option=1&choiceform1=War%2C+sir%2C+is+raw%21");
			ccAdv(1, $location[Noob Cave]);
			if(item_amount($item[2268]) == 1)
			{
				set_property("cc_palindome", "finished");
			}
			return true;
		}
		else
		{
			if(my_mp() > 60)
			{
				handleBjornify($familiar[grimstone golem]);
			}
			ccAdv(1, $location[Inside the Palindome]);
			if($location[Inside the Palindome].turns_spent > 30)
			{
				abort("It appears that we've spent too many turns in the Palindome. If you run me again, I'll try one more time but many I failed finishing the Palindome");
			}
		}
		return true;
	}

	if(L11_unlockPyramid() || L11_unlockEd() || L11_defeatEd())
	{
		return true;
	}

	if(L12_gremlins() || L12_gremlinStart())
	{
		return true;
	}

	if(L12_sonofaFinish() || L12_sonofaBeach())
	{
		return true;
	}

	if((get_property("cc_orchard") == "finished") && (get_property("sidequestOrchardCompleted") == "none"))
	{
		abort("The script thinks we completed the orchard but mafia doesn't, return the heart?");
	}

	if(L12_orchardStart())
	{
		return true;
	}

	if(L12_filthworms())
	{
		return true;
	}

	if(L12_orchardFinalize())
	{
		return true;
	}


	if((get_property("flyeredML").to_int() < 10000) && (!get_property("cc_ignoreFlyer").to_boolean() && (my_level() >= 12)))
	{
		print("Not enough flyer ML and we don't know what else to do...", "red");
		if(get_property("spookyAirportAlways").to_boolean())
		{
			if(item_amount($item[Personal Ventilation Unit]) > 0)
			{
				equip($slot[acc2], $item[Personal Ventilation Unit]);
			}
			buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
			if(my_primestat() == $stat[Mysticality])
			{
				buffMaintain($effect[Perspicacious Pressure], 0, 1, 1);
				buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
				buffMaintain($effect[Erudite], 0, 1, 1);
			}
			ccAdv(1, $location[The Secret Government Laboratory]);
			return true;
		}
		abort("Have not been able to flyer enough in-run, you can manually do this or override cc_ignoreFlyer = true");
	}

	if((my_level() >= 12) && ((get_property("hippiesDefeated").to_int() >= 192) || get_property("cc_hippyInstead").to_boolean()) && (get_property("cc_nuns") == ""))
	{
		if(doThemtharHills(false))
		{
			return true;
		}
	}

	if((get_property("cc_war") != "done") && (get_property("cc_war") != "finished") && ((get_property("hippiesDefeated").to_int() >= 1000) || (get_property("fratboysDefeated").to_int() >= 1000)))
	{
		set_property("cc_nuns", "finished");
		set_property("cc_war", "done");
	}

	if((my_level() >= 12) && (get_property("cc_battleFratplant") == ""))
	{
		warOutfit();
		warAdventure();
		oldPeoplePlantStuff();
		set_property("cc_battleFratplant", "plant");
		return true;
	}

	if(L11_getBeehive())
	{
		return true;
	}

	if(L12_finalizeWar())
	{
		return true;
	}

	if(LX_getDigitalKey())
	{
		return true;
	}

	if((item_amount($item[rock band flyers]) == 1) && (get_property("flyeredML").to_int() < 10000))
	{
		print("Not enough flyer ML but we are ready for the war... uh oh", "blue");
		if(my_path() == "Picky")
		{
			//This is outdated since we don\'t need to consider stars/lines as much
			if(item_amount($item[Steam-Powered Model Rocketship]) == 0)
			{
				set_property("choiceAdventure677", "2");
				set_property("choiceAdventure678", "3");
				handleInitFamiliar();
				ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
				handleFamiliar($familiar[Adventurous Spelunker]);
			}
			else
			{
				ccAdv(1, $location[The Hole in the Sky]);
			}
			return true;
		}
		else
		{
			print("Should not have so little flyer ML at this point", "red");
			wait(1);
			handleFamiliar($familiar[Fist Turkey]);
			if(elementalPlanes_access($element[sleaze]))
			{
				ccAdv(1, $location[Sloppy Seconds Diner]);
			}
			else
			{
				abort("Need more flyer ML but don't know where to go :(");
			}
			return true;
		}
	}

	if((get_property("cc_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 64) && (get_property("fratboysDefeated").to_int() < 64)) && (my_level() >= 12))
	{
		print("First 64 combats. To orchard/lighthouse", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("cc_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 192) && (get_property("fratboysDefeated").to_int() < 192)) && (my_level() >= 12))
	{
		print("Getting to the nunnery/junkyard", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("cc_nuns") == "done") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("cc_nuns") == "finished") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		warOutfit();
		warAdventure();
		return true;
	}


	if(get_property("cc_sorceress") == "")
	{
		if(my_class() == $class[Ed])
		{
			if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
			{
				set_property("cc_sorceress", "finished");
				council();
				return true;
			}

			council();
			if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_10_sorcfight"))
			{
				print("We found the jerkwad!! Revenge!!!!!", "blue");

				string page = "place.php?whichplace=nstower&action=ns_10_sorcfight";
				ccAdvBypass(page, $location[Noob Cave]);

				if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
				{
					set_property("cc_sorceress", "finished");
					council();
				}
				return true;
			}
			else
			{
				if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
				{
					doRest();
					cli_execute("scripts/postcheese.ash");
					return true;
				}
				print("Please check your quests, but you might just not be at level 13 yet in order to continue.", "red");
				if((my_level() < 13) && get_property("spookyAirportAlways").to_boolean())
				{
					boolean tryJungle = false;
					if(have_effect($effect[Jungle Juiced]) > 0)
					{
						tryJungle = true;
					}

					if(((my_inebriety() + 1) < inebriety_limit()) && (item_amount($item[Coinspiracy]) > 0) && (have_effect($effect[Jungle Juiced]) == 0))
					{
						buy(1, $item[Jungle Juice]);
						drink(1, $item[Jungle Juice]);
						tryJungle = true;
					}

					buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
					if(my_primestat() == $stat[Mysticality])
					{
						buffMaintain($effect[Perspicacious Pressure], 0, 1, 1);
						buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
						buffMaintain($effect[Erudite], 0, 1, 1);
					}

					if(tryJungle)
					{
						ccAdv(1, $location[The Deep Dark Jungle]);
					}
					else
					{
						if(item_amount($item[Personal Ventilation Unit]) > 0)
						{
							equip($slot[acc2], $item[Personal Ventilation Unit]);
						}
						ccAdv(1, $location[The Secret Government Laboratory]);
					}
					return true;
				}
				else
				{
					abort("We must be missing a sidequest. We can't find the jerk adventurer.");
				}
			}
		}


		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_contestbooth"))
		{
			set_property("cc_sorceress", "start");
			set_property("choiceAdventure1003", 0);
		}
		else
		{
			if(((my_daycount() > 2) && !in_hardcore()) || (my_daycount() > 3))
			{
				abort("Some sidequest is not done for some raisin.");
			}
			else if(my_level() < 13)
			{
				print("I seem to need to power level, or something... waaaa.", "red");
				wait(10);
				if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
				{
					doRest();
					cli_execute("scripts/postcheese.ash");
					return true;
				}

				handleFamiliar($familiar[Fist Turkey]);
				if(elementalPlanes_access($element[stench]))
				{
					ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
				}
				else if(elementalPlanes_access($element[spooky]))
				{
					ccAdv(1, $location[The Deep Dark Jungle]);
				}
				else if(elementalPlanes_access($element[sleaze]))
				{
					ccAdv(1, $location[Sloppy Seconds Diner]);
				}
				else
				{
					print("The following error message is probably wrong, you just need to powerlevel to 13 most likely.", "red");
					abort("Need more flyer ML but don't know where to go :(");
				}
				return true;
			}
			else
			{
				#need a wand (or substitute a key lime for food earlier)
			}
		}
	}


	if(get_property("cc_sorceress") == "start")
	{
		if((get_property("cc_trytower") == "pause") || (get_property("cc_trytower") == "stop") || ((my_name() == "cheesecookie") && (get_property("choiceAdventure1003").to_int() < 3)))
		{
			ns_crowd1();
			ns_crowd2();
			ns_crowd3();
			ns_hedge1();
			ns_hedge2();
			ns_hedge3();
			if(get_property("cc_trytower") == "stop")
			{
				print("Manual handling for the start of challenges still required. Then run me again. Beep", "blue");
				set_property("choiceAdventure1003", 3);
				abort("Can't handle this optimally just yet, damn it");
			}
			else if(get_property("cc_trytower") == "pause")
			{
				set_property("cc_trytower", "");
				print("Start the tower challenges and then run me again and I'll take care of the rest");
				abort("Run again once all three challenges have been started. We will assume they have been");
				set_property("choiceAdventure1003", 3);
			}
			else
			{
				print("Manual handling for the start of challenges still required. Then run me again. Beep");
				set_property("choiceAdventure1003", 3);
				abort("Can't handle this optimally just yet, damn it");
			}
		}
		if(contains_text(visit_url("place.php?whichplace=nstower"), "nstower_door"))
		{
			set_property("cc_sorceress", "door");
			return true;
		}
		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_03_hedgemaze"))
		{
			set_property("cc_sorceress", "hedge");
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_02_coronation"))
		{
			set_property("choiceAdventure1020", "1");
			set_property("choiceAdventure1021", "1");
			set_property("choiceAdventure1022", "1");
			visit_url("place.php?whichplace=nstower&action=ns_02_coronation");
			visit_url("choice.php?pwd=&whichchoice=1020&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1021&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1022&option=1", true);
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd1"))
		{
			ccAdv(1, $location[Fastest Adventurer Contest]);
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd2"))
		{
			switch(get_property("nsChallenge1"))
			{
			case "Mysticality":
				ccAdv(1, $location[Smartest Adventurer Contest]);
				break;
			case "Moxie":
				ccAdv(1, $location[Smoothest Adventurer Contest]);
				break;
			case "Muscle":
				ccAdv(1, $location[Strongest Adventurer Contest]);
				break;
			}
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd3"))
		{
			switch(get_property("nsChallenge2"))
			{
			case "cold":
				ccAdv(1, $location[Coldest Adventurer Contest]);
				break;
			case "hot":
				ccAdv(1, $location[Hottest Adventurer Contest]);
				break;
			case "sleaze":
				ccAdv(1, $location[Sleaziest Adventurer Contest]);
				break;
			case "spooky":
				ccAdv(1, $location[Spookiest Adventurer Contest]);
				break;
			case "stench":
				ccAdv(1, $location[Stinkiest Adventurer Contest]);
				break;
			}
			return true;
		}

		// FIXME: We want to invoke all three challenges at once because of cross-buffs.
		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_contestbooth"))
		{
			set_property("choiceAdventure1003", get_property("choiceAdventure1003").to_int() + 1);
			int nsChoice = get_property("choiceAdventure1003").to_int();

			switch(nsChoice)
			{
			case 1:
				switch(ns_crowd1())
				{
				case 1:
					if(get_property("cc_100familiar").to_boolean())
					{
						maximize("init, -equip snow suit", 1500, 0, false);
					}
					else
					{
						maximize("init, -equip snow suit, switch xiblaxian holo-companion, switch oily woim ", 1500, 0, false);
					}
					if(have_familiar($familiar[Xiblaxian Holo-Companion]))
					{
						handleFamiliar($familiar[Xiblaxian Holo-Companion]);
					}
					else if(have_familiar($familiar[Oily Woim]))
					{
						handleFamiliar($familiar[Oily Woim]);
					}
					break;
				}
				break;
			case 2:
				switch(ns_crowd2())
				{
				case $stat[moxie]:		maximize("moxie -equip snow suit", 1500, 0, false);			break;
				case $stat[muscle]:		maximize("muscle -equip snow suit", 1500, 0, false);			break;
				case $stat[mysticality]:maximize("myst -equip snow suit", 1500, 0, false);			break;
				}
				break;
			case 3:
				switch(ns_crowd3())
				{
				case $element[cold]:	maximize("cold dmg -equip snow suit", 1500, 0, false);			break;
				case $element[hot]:		maximize("hot dmg -equip snow suit", 1500, 0, false);			break;
				case $element[sleaze]:	maximize("sleaze dmg -equip snow suit", 1500, 0, false);			break;
				case $element[stench]:	maximize("stench dmg -equip snow suit", 1500, 0, false);			break;
				case $element[spooky]:	maximize("spooky dmg -equip snow suit", 1500, 0, false);			break;
				}
				break;
			}

			if(nsChoice > 6)
			{
				abort("Trying to select NS gate challenges or complete the gate and we explodered");
			}

			visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
			visit_url("choice.php?pwd=&whichchoice=1003&option=" + nsChoice, true);
			visit_url("main.php");
			return true;
		}

		abort("Failed the sorceress first area stuff, uh oh.");
	}

	if(get_property("cc_sorceress") == "hedge")
	{
		if(contains_text(visit_url("place.php?whichplace=nstower"), "nstower_door"))
		{
			set_property("cc_sorceress", "door");
			return true;
		}

		# Set this so it aborts if not enough adventures. Otherwise, well, we end up in a loop.
		set_property("choiceAdventure1004", "3");
		set_property("choiceAdventure1005", "2");			# 'Allo
		set_property("choiceAdventure1006", "2");			# One Small Step For Adventurer
		set_property("choiceAdventure1007", "2");			# Twisty Little Passages, All Hedge
		set_property("choiceAdventure1008", "2");			# Pooling Your Resources
		set_property("choiceAdventure1009", "2");			# Gold Ol' 44% Duck
		set_property("choiceAdventure1010", "2");			# Another Day, Another Fork
		set_property("choiceAdventure1011", "2");			# Of Mouseholes and Manholes
		set_property("choiceAdventure1012", "2");			# The Last Temptation
		set_property("choiceAdventure1013", "1");			# Masel Tov!

		maximize_hedge();
		useCocoon();
		visit_url("place.php?whichplace=nstower&action=ns_03_hedgemaze");

		if(get_property("cc_hedge") == "slow")
		{
			visit_url("choice.php?pwd=&whichchoice=1005&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1006&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1007&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1008&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1009&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1010&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1011&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1012&option=1", true);
			visit_url("choice.php?pwd=&whichchoice=1013&option=1", true);
		}
		else if(get_property("cc_hedge") == "fast")
		{
			visit_url("choice.php?pwd=&whichchoice=1005&option=2", true);
#			visit_url("choice.php?pwd=&whichchoice=1006&option=2", true);
#			visit_url("choice.php?pwd=&whichchoice=1007&option=2", true);
			visit_url("choice.php?pwd=&whichchoice=1008&option=2", true);
#			visit_url("choice.php?pwd=&whichchoice=1009&option=2", true);
#			visit_url("choice.php?pwd=&whichchoice=1010&option=2", true);
			visit_url("choice.php?pwd=&whichchoice=1011&option=2", true);
#			visit_url("choice.php?pwd=&whichchoice=1012&option=2", true);
			visit_url("choice.php?pwd=&whichchoice=1013&option=1", true);
		}
		else
		{
			abort("cc_hedge not set properly (slow/fast), assuming manual handling desired");
		}
		return true;
	}

	if(L13_sorceressDoor())
	{
		return true;
	}

	if(get_property("cc_sorceress") == "tower")
	{
		if(my_name() == "cheesecookie")
		{
#			abort("Aborting for tower experiments, beep");
		}
		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_05_monster1"))
		{
			change_mcd(0);
			if(item_amount($item[bottle of monsieur bubble]) > 0)
			{
				use(1, $item[bottle of monsieur bubble]);
			}
			else if(item_amount($item[carbonated soy milk]) > 0)
			{
				use(1, $item[carbonated soy milk]);
			}
			else if(item_amount($item[tiny house]) > 1)
			{
				use(2, $item[tiny house]);
			}

			#glowing syringe : biologically shocke
			int sources = 0;
			if(item_amount($item[astral shirt]) > 0)
			{
				equip($item[astral shirt]);
			}
			if(equipped_item($slot[shirt]) == $item[astral shirt])
			{
				sources = 6;
			}
			if(have_skill($skill[headbutt]))
			{
				sources = sources + 1;
			}
			item familiarEquip = equipped_item($slot[Familiar]);
			if((have_familiar($familiar[warbear drone])) && !get_property("cc_100familiar").to_boolean())
			{
				sources = sources + 2;
				handleFamiliar($familiar[Warbear Drone]);
				if(!possessEquipment($item[Warbear Drone Codes]))
				{
					pullXWhenHaveY($item[warbear drone codes], 1, 0);
				}
				if((item_amount($item[warbear drone codes]) > 0) || (equipped_item($slot[familiar]) == $item[warbear drone codes]))
				{
					equip($item[warbear drone codes]);
					sources = sources + 2;
				}
			}
			if(item_amount($item[hippy protest button]) > 0)
			{
				equip($slot[acc1], $item[hippy protest button]);
				sources = sources + 1;
			}
			else
			{
				equip($slot[acc1], $item[pirate fledges]);
			}
			if(item_amount($item[glob of spoiled mayo]) > 0)
			{
				buffMaintain($effect[Mayeaugh], 0, 1, 1);
				sources = sources + 1;
			}
			if(item_amount($item[smirking shrunken head]) > 0)
			{
				equip($item[smirking shrunken head]);
				sources = sources + 1;
			}
			else if(item_amount($item[hot plate]) > 0)
			{
				equip($item[hot plate]);
				sources = sources + 1;
			}
			if(have_skill($skill[Scarysauce]))
			{
				buffMaintain($effect[Scarysauce], 0, 1, 1);
				sources = sources + 1;
			}
			if(have_skill($skill[Spiky Shell]))
			{
				buffMaintain($effect[Spiky Shell], 0, 1, 1);
				sources = sources + 1;
			}
			if(have_skill($skill[Jalape&ntilde;o Saucesphere]))
			{
				sources = sources + 1;
				buffMaintain($effect[Jalape&ntilde;o Saucesphere], 0, 1, 1);
			}
			handleBjornify($familiar[Hobo Monkey]);
			if(equipped_item($slot[acc2]) != $item[world\'s best adventurer sash])
			{
				equip($slot[acc2], $item[world\'s best adventurer sash]);
			}
			if(item_amount($item[Groll Doll]) > 0)
			{
				equip($slot[acc3], $item[Groll Doll]);
			}
			if(item_amount($item[old-school calculator watch]) > 0)
			{
				equip($slot[acc3], $item[old-school calculator watch]);
			}
			if(item_amount($item[Bottle Opener Belt Buckle]) > 0)
			{
				equip($slot[acc3], $item[Bottle Opener Belt Buckle]);
			}
			if((equipped_item($slot[acc3]) != $item[acid-squirting flower]) && (item_amount($item[acid-squirting flower]) > 0))
			{
				equip($slot[acc3], $item[acid-squirting flower]);
			}
			if(have_skill($skill[Frigidalmatian]) && (my_mp() > 300))
			{
				sources = sources + 1;
			}


			if((item_amount($item[beehive]) > 0) || (sources > 14))
			{
				if(item_amount($item[beehive]) == 0)
				{
					useCocoon();
				}
				visit_url("place.php?whichplace=nstower&action=ns_05_monster1");
				adv1($location[Noob Cave], 1, "cc_combatHandler");
				if(have_effect($effect[Beaten Up]) > 0)
				{
					set_property("cc_getBeehive", true);
					print("I probably failed the Wall of Skin, I assume that I tried without a beehive. Well, I'm going back to get it.", "red");
				}
				else
				{
					handleFamiliar($familiar[Adventurous Spelunker]);
					if(item_amount(familiarEquip) > 0)
					{
						equip(familiarEquip);
					}
				}
			}
			else
			{
				set_property("cc_getBeehive", true);
				print("Need a beehive, buzz buzz.", "red");
			}
			return true;
		}


		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_06_monster2"))
		{
			buffMaintain($effect[Disco Leer], 0, 1, 1);
			buffMaintain($effect[Polka of Plenty], 0, 1, 1);
			buffMaintain($effect[Cranberry Cordiality], 0, 1, 1);
			if((get_property("sidequestArenaCompleted") == "fratboy") && (get_property("concertVisited") == "false") && (have_effect($effect[Winklered]) == 0))
			{
				cli_execute("concert 2");
			}
			if(item_amount($item[Silver Cow Creamer]) > 0)
			{
				equip($item[Silver Cow Creamer]);
			}
			if(item_amount($item[Sneaky Pete\'s Leather Jacket]) > 0)
			{
				equip($item[Sneaky Pete\'s Leather Jacket]);
			}
			if(get_property("cc_100familiar").to_boolean())
			{
				maximize("meat drop, -equip snow suit", 1500, 0, false);
			}
			else
			{
				maximize("meat drop, -equip snow suit, switch Hobo Monkey, switch Grimstone Golem, switch Fist Turkey, switch Unconscious Collective, switch Golden Monkey, switch Angry Jung Man, switch Leprechaun", 1500, 0, false);
			}
			if((my_class() == $class[Seal Clubber]) && (item_amount($item[Meat Tenderizer is Murder]) > 0))
			{
				equip($item[Meat Tenderizer is Murder]);
			}
			handleFamiliar($familiar[Adventurous Spelunker]);

			if(my_mp() >= 20)
			{
				useCocoon();
			}
			else if(my_hp() < (0.9 * my_maxhp()))
			{
				cli_execute("hottub");
			}
			#Wall of Meat, buff meat, need at least 400 I suppose.
			visit_url("place.php?whichplace=nstower&action=ns_06_monster2");
			#adv1($location[Noob Cave], 1, "cc_combatHandler");
			ccAdv(1, $location[Noob Cave]);
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_07_monster3"))
		{
			# wall of bones
			# is affected by -ML
			# 1000 stats, immune to stuns, maybe if you prep a big mien or greasy.
			# Tried +65/+460% at 541 Myst: (6831, 6845, 6815 damage)
			if(item_amount($item[electric boning knife]) > 0)
			{
				set_property("cc_getBoningKnife", false);
			}

			if(!get_property("cc_getBoningKnife").to_boolean() && ((my_class() == $class[Sauceror]) || have_skill($skill[Garbage Nova])))
			{
				uneffect($effect[Scarysauce]);
				uneffect($effect[Jalape&ntilde;o Saucesphere]);
				uneffect($effect[Mayeaugh]);
				uneffect($effect[Spiky Shell]);
				handleFamiliar($familiar[none]);
				buffMaintain($effect[Tomato Power], 0, 1, 1);
				buffMaintain($effect[Seeing Colors], 0, 1, 1);
				buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
				buffMaintain($effect[OMG WTF], 0, 1, 1);
				buffMaintain($effect[There is a Spoon], 0, 1, 1);
				boolean keepTrying = true;
				while((my_mp() < 216) && keepTrying)
				{
					keepTrying = false;
					if(item_amount($item[Carbonated Soy Milk]) > 0)
					{
						use(1, $item[Carbonated Soy Milk]);
						keepTrying = true;
					}
					if(item_amount($item[Natural Fennel Soda]) > 0)
					{
						use(1, $item[Natural Fennel Soda]);
						keepTrying = true;
					}
					if(item_amount($item[Phonics Down]) > 0)
					{
						use(1, $item[Phonics Down]);
						keepTrying = true;
					}
				}
				buffMaintain($effect[Song of Sauce], 0, 1, 1);
				maximize("myst -equip snow suit", 1500, 0, false);
				if(equipped_item($slot[acc1]) == $item[hand in glove])
				{
					equip($slot[acc1], $item[Pirate Fledges]);
				}
				if(equipped_item($slot[acc2]) == $item[hand in glove])
				{
					equip($slot[acc2], $item[Pirate Fledges]);
				}
				if(equipped_item($slot[acc3]) == $item[hand in glove])
				{
					equip($slot[acc3], $item[Pirate Fledges]);
				}
				useCocoon();
				visit_url("place.php?whichplace=nstower&action=ns_07_monster3");
				#adv1($location[Noob Cave], 1, "cc_combatHandler");
				ccAdv(1, $location[Noob Cave]);
				if(have_effect($effect[Beaten Up]) > 0)
				{
					print("Could not towerkill Wall of Bones, reverting to Boning Knife", "red");
					cli_execute("hottub");
					set_property("cc_getBoningKnife", true);
				}
				else
				{
					handleFamiliar($familiar[Adventurous Spelunker]);
				}
			}
			else if(item_amount($item[electric boning knife]) > 0)
			{
				visit_url("place.php?whichplace=nstower&action=ns_07_monster3");
				adv1($location[Noob Cave], 1, "cc_combatHandler");
			}
			else
			{
				print("Backfarming an Electric Boning Knife", "brown");
				set_property("choiceAdventure1026", "2");
				ccAdv(1, $location[The Castle in the Clouds in the Sky (Ground Floor)]);
#				abort("Need an electric boning knife");
			}
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_08_monster4"))
		{
			set_property("choiceAdventure1015", "2");
			visit_url("place.php?whichplace=nstower&action=ns_08_monster4");
			#Not breaking the mirror wastes an adventure
			visit_url("choice.php?pwd=&whichchoice=1015&option=2", true);
			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_09_monster5"))
		{
			if(my_maxhp() < 800)
			{
				buffMaintain($effect[Industrial Strength Starch], 0, 1, 1);
				buffMaintain($effect[Truly Gritty], 0, 1, 1);
				buffMaintain($effect[Superheroic], 0, 1, 1);
				buffMaintain($effect[Strong Grip], 0, 1, 1);
				buffMaintain($effect[Spiky Hair], 0, 1, 1);
			}
			cli_execute("scripts/postcheese.ash");
			cli_execute("hottub");

			visit_url("place.php?whichplace=nstower&action=ns_09_monster5");
			adv1($location[Noob Cave], 1, "cc_combatHandler");

			return true;
		}

		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_10_sorcfight"))
		{
			set_property("cc_sorceress", "top");
			return true;
		}
	}

	if(get_property("cc_wandOfNagamar").to_boolean())
	{
		if(item_amount($item[wand of nagamar]) > 0)
		{
			set_property("cc_wandOfNagamar", false);
			return true;
		}
		else if(pulls_remaining() >= 2)
		{
			if((item_amount($item[ruby w]) > 0) && (item_amount($item[metallic A]) > 0))
			{
				cli_execute("make wa");
			}
			pullXWhenHaveY($item[WA], 1, 0);
			pullXWhenHaveY($item[ND], 1, 0);
			cli_execute("make wand of nagamar");
			return true;
		}
		else
		{
			pullXWhenHaveY($item[disassembled clover], 1, 0);
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=322&confirm=on");
			cli_execute("make wand of nagamar");
			return true;
		}
	}

	if(get_property("cc_sorceress") == "top")
	{
		set_property("cc_sorceress", "final");
	}

	if((get_property("cc_sorceress") == "final") && !get_property("cc_wandOfNagamar").to_boolean())
	{
		//We should probably not do the buffing if we are fighting the actual sorceress.
		cli_execute("scripts/postcheese.ash");
		if(item_amount($item[Ouija Board\, Ouija Board]) > 0)
		{
			equip($item[Ouija Board\, Ouija Board]);
		}

		handleFamiliar($familiar[warbear drone]);
		if(!have_familiar($familiar[Warbear Drone]))
		{
			handleFamiliar($familiar[Fist Turkey]);
		}

		if(item_amount($item[Beer Helmet]) > 0)
		{
			equip($item[Beer Helmet]);
		}
		if(item_amount($item[Misty Cloak]) > 0)
		{
			equip($item[Misty Cloak]);
		}
		if(item_amount($item[Attorney\'s Badge]) > 0)
		{
			equip($slot[acc2], $item[Attorney\'s Badge]);
		}
		if(item_amount($item[gumshoes]) > 0)
		{
			equip($slot[acc1], $item[gumshoes]);
		}
		if(item_amount($item[World\'s Best Adventurer Sash]) > 0)
		{
			equip($slot[acc3], $item[World\'s Best Adventurer Sash]);
		}


		set_property("cc_disableAdventureHandling", "yes");
		visit_url("place.php?whichplace=nstower&action=ns_10_sorcfight");
		ccAdv(1, $location[Noob Cave]);
		if(have_effect($effect[Beaten Up]) > 0)
		{
			print("Sorceress beat us up. Wahhh.", "red");
			return true;
		}
		if(last_monster() == $monster[Naughty Sorceress])
		{
			ccAdv(1, $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				print("Blobbers Sorceress beat us up. Wahhh.", "red");
				return true;
			}
			ccAdv(1, $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				print("We got beat up by a sausage....", "red");
				return true;
			}
			visit_url("place.php?whichplace=nstower&action=ns_11_prism");
		}

		set_property("cc_disableAdventureHandling", "no");
		visit_url("place.php?whichplace=nstower&action=ns_11_prism");
		if(get_property("kingLiberated") == "false")
		{
			abort("Yeah, so, I'm done. You might be stuck at the shadow, or at the final boss, or just with a king in a prism. I don't know and quite frankly, after the last " + my_daycount() + " days, I don't give a damn. That's right, I said it. Bitches.");
		}
		set_property("cc_sorceress", "finished");
		return true;
	}

	if((get_property("cc_sorceress") == "finished") && (my_class() == $class[Ed]))
	{
#		if(item_amount($item[Holy MacGuffin]) == 0)
		if(item_amount($item[7965]) == 0)
		{
			ccAdv(1, $location[The Secret Council Warehouse]);
		}
		else
		{
			//Complete.
			return false;
		}
		while((item_amount($item[Warehouse Map Page]) > 0) && (item_amount($item[Warehouse Inventory Page]) > 0))
		{
			#use(item_amount($item[Warehouse Map Page]), $item[Warehouse Map Page]);
			use(item_amount($item[Warehouse Inventory Page]), $item[Warehouse Inventory Page]);
		}
		if(get_property("lastEncounter") == "You Found It!")
		{
			council();
			print("McMuffin is found!", "blue");
			print("Ed Combats: " + get_property("cc_edCombatCount"), "blue");
			print("Ed Combat Rounds: " + get_property("cc_edCombatRoundCount"), "blue");

			return false;
		}
		return true;
	}

	print("I should not get here more than once because I pretty much just finished all my in-run stuff. Beep", "blue");
	wait(5);
	return false;
}

void cc_begin()
{
	if(contains_text(visit_url("main.php"), "Being Picky"))
	{
		picky_startAscension();
	}

#	cli_execute("spookyraven on");
	cli_execute("spookyraven off");

	print("Hello " + my_name() + ", time to explode!");
	print("This is version: " + svn_info("ccascend-cc_ascend").last_changed_rev);
	print("This is day " + my_daycount() + ".");
	print("Turns played: " + my_turncount() + " current adventures: " + my_adventures());
	print("Current Ascension: " + my_path());

	set_property("cc_disableAdventureHandling", "no");

	settingFixer();

	uneffect($effect[Ode To Booze]);
	handlePulls(my_daycount());
	initializeDay(my_daycount());


	if(!get_property("autoSatisfyWithCoinmasters").to_boolean())
	{
		set_property("cc_priorCoinmasters", true);
		set_property("autoSatisfyWithCoinmasters", true);
	}

	set_property("kingLiberatedScript", "scripts/kingcheese.ash");
	set_property("afterAdventureScript", "scripts/postcheese.ash");
	set_property("betweenAdventureScript", "scripts/precheese.ash");
	set_property("betweenBattleScript", "scripts/precheese.ash");


	string charpane = visit_url("charpane.php");
	if(contains_text(charpane, "<hr width=50%>"))
	{
		print("Switching off Compact Character Mode, will resume during bedtime");
		set_property("cc_priorCharpaneMode", 1);
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=0&ajax=0", true);
	}

	if(vars["chit.helpers.xiblaxian"] != "false")
	{
		print("Switching off CHiT Xiblaxian Counter, will resume during bedtime");
		set_property("cc_priorXiblaxianMode", 1);
		setvar("chit.helpers.xiblaxian", false);
		cli_execute("zlib chit.helpers.xiblaxian = false");
	}


	if(my_class() == $class[Ed])
	{
		if(get_property("hpAutoRecoveryItems") != "linen bandages")
		{
			set_property("cc_hpAutoRecoveryItems", get_property("hpAutoRecoveryItems"));
			set_property("cc_hpAutoRecovery", get_property("hpAutoRecovery"));
			set_property("cc_hpAutoRecoveryTarget", get_property("hpAutoRecoveryTarget"));
			set_property("hpAutoRecoveryItems", "linen bandages");
			set_property("hpAutoRecovery", 0.0);
			set_property("hpAutoRecoveryTarget", 0.0);
		}
	}

	questOverride();

	if(my_daycount() > 1)
	{
		equipBaseline();
	}

	if(have_skill($skill[That\'s Not a Knife]))
	{
		use_skill(1, $skill[That\'s Not a Knife]);
		if(item_amount($item[boot knife]) == 1)
		{
			put_closet(1, $item[boot knife]);
		}
		if(item_amount($item[broken beer bottle]) == 1)
		{
			put_closet(1, $item[broken beer bottle]);
		}
		if(item_amount($item[sharpened spoon]) == 1)
		{
			put_closet(1, $item[sharpened spoon]);
		}
		if(item_amount($item[candy knife]) == 1)
		{
			put_closet(1, $item[candy knife]);
		}
		if(item_amount($item[soap knife]) >= 1)
		{
			put_closet(1, $item[soap knife]);
		}
	}

	#	pullsNeeded("evaluate");
	#	string data = visit_url("lair1.php?action=gates");
	#	int extra_pulls = pulls_remaining() - pullsNeeded(data);
	#	abort("oops");
	consumeStuff();
	while((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()) && (get_property("kingLiberated") == "false") && doTasks())
	{
		if((my_fullness() >= fullness_limit()) && (my_inebriety() >= inebriety_limit()) && (my_spleen_use() == spleen_limit()) && (my_adventures() < 4) && (my_rain() >= 50) && (get_counters("Fortune Cookie", 0, 4) == "Fortune Cookie"))
		{
			abort("Manually handle, because we have fortune cookie and rain man colliding at the end of our day and we don't know quite what to do here");
		}
		#We save the last adventure for a rain man, damn it.
	}

	if(get_property("kingLiberated") == "true")
	{
		if(get_property("cc_aftercore") != "done")
		{
			print("Failed to trigger kingLiberated script on liberation. Doing it manually", "green");
			cli_execute("scripts/kingcheese.ash");
		}
		equipBaseline();
		handleFamiliar($familiar[Adventurous Spelunker]);
		if(item_amount($item[hairpiece on fire]) > 0)
		{
			equip($item[hairpiece on fire]);
		}
		if(item_amount($item[fudgecycle]) > 0)
		{
			equip($slot[acc1], $item[fudgecycle]);
		}
		if(item_amount($item[camp scout backpack]) > 0)
		{
			equip($item[camp scout backpack]);
		}
		if(item_amount($item[operation patriot shield]) > 0)
		{
			equip($item[operation patriot shield]);
		}
		if((equipped_item($slot[familiar]) != $item[snow suit]) && (item_amount($item[snow suit]) > 0))
		{
			equip($item[snow suit]);
		}
		if(item_amount($item[mayfly bait necklace]) > 0)
		{
			equip($slot[acc2], $item[mayfly bait necklace]);
		}
	}

	doBedtime();
	print("Done for today (" + my_daycount() + "), beep boop");
}

void main()
{
	cc_begin();
}

