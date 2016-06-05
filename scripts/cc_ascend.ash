script "cc_ascend.ash";
notify cheesecookie;
since r16987;

/***	svn checkout https://svn.code.sf.net/p/ccascend/code/cc_ascend
		Killing is wrong, and bad. There should be a new, stronger word for killing like badwrong or badong. YES, killing is badong. From this moment, I will stand for the opposite of killing, gnodab.
***/

import <cc_ascend/cc_ascend_header.ash>
import <cc_ascend/cc_deprecation.ash>
import <cc_ascend/cc_combat.ash>
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_floristfriar.ash>
import <cc_ascend/cc_equipment.ash>
import <cc_ascend/cc_eudora.ash>
import <cc_ascend/cc_elementalPlanes.ash>
import <cc_ascend/cc_clan.ash>
import <cc_ascend/cc_cooking.ash>
import <cc_ascend/cc_adventure.ash>
import <cc_ascend/cc_mr2014.ash>
import <cc_ascend/cc_mr2015.ash>
import <cc_ascend/cc_mr2016.ash>

import <cc_ascend/cc_boris.ash>
import <cc_ascend/cc_heavyrains.ash>
import <cc_ascend/cc_picky.ash>
import <cc_ascend/cc_standard.ash>
import <cc_ascend/cc_edTheUndying.ash>
import <cc_ascend/cc_summerfun.ash>
import <cc_ascend/cc_community_service.ash>
import <cc_ascend/cc_awol.ash>
import <cc_ascend/cc_theSource.ash>


void initializeSettings()
{
	if(my_ascensions() <= get_property("cc_doneInitialize").to_int())
	{
		return;
	}
	cli_execute("refresh all");
	set_property("cc_doneInitialize", my_ascensions());

	if(my_familiar() != $familiar[none])
	{
		set_property("cc_100familiar", user_confirm("Familiar already set, is this a 100% familiar run? Will default to 'No' in 15 seconds.", 15000, false));
		if(get_property("cc_100familiar").to_boolean())
		{
			set_property("cc_useCubeling", false);
		}
	}
	else
	{
		set_property("cc_useCubeling", true);
		set_property("cc_100familiar", false);
	}

	if(!get_property("cc_100familiar").to_boolean() && have_familiar($familiar[Crimbo Shrub]))
	{
		use_familiar($familiar[Crimbo Shrub]);
		use_familiar($familiar[none]);
	}

	set_property("chasmBridgeProgress", 0);
	set_property("nosyNoseMonster", 0);
	string pool = visit_url("questlog.php?which=3");
	matcher my_pool = create_matcher("a skill level of (\\d+) at shooting pool", pool);
	if(my_pool.find())
	{
		set_property("poolSkill", to_int(my_pool.group(1)));
	}


	set_property("cc_abooclover", true);
	set_property("cc_aboocount", "0");
	set_property("cc_aboopending", 0);
	set_property("cc_aftercore", false);
	set_property("cc_airship", "");
	set_property("cc_ballroom", "");
	set_property("cc_ballroomflat", "");
	set_property("cc_ballroomopen", "");
	set_property("cc_ballroomsong", "");
	set_property("cc_banishes", "");
	set_property("cc_bat", "");
	set_property("cc_batoomerangDay", 0);
	set_property("cc_bean", false);
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
	set_property("cc_combatHandler", "");
	set_property("cc_consumption", "");
	set_property("cc_cookie", -1);
	set_property("cc_crackpotjar", "");
	set_property("cc_crypt", "");
	set_property("cc_cubeItems", true);
	set_property("cc_day1_cobb", "");
	set_property("cc_day1_dna", "");
	set_property("cc_day1_init", "");
	set_property("cc_day2_init", "");
	set_property("cc_day3_init", "");
	set_property("cc_day4_init", "");
	set_property("cc_disableAdventureHandling", "no");
	set_property("cc_doCombatCopy", "no");
	set_property("cc_familiarChoice", $familiar[none]);
	set_property("cc_fcle", "");
	set_property("cc_friars", "");
	set_property("cc_funTracker", "");
	set_property("cc_gaudy", "");
	set_property("cc_gaudypiratecount", "");
	set_property("cc_getBoningKnife", false);
	set_property("cc_getStarKey", false);
	set_property("cc_getSteelOrgan", get_property("cc_alwaysGetSteelOrgan").to_boolean());
	set_property("cc_gnasirUnlocked", false);
	set_property("cc_goblinking", "");
	set_property("cc_gremlins", "");
	set_property("cc_gremlinBanishes", "");
	set_property("cc_grimfairytale", "");
	set_property("cc_grimstoneFancyOilPainting", true);
	set_property("cc_grimstoneOrnateDowsingRod", true);
	set_property("cc_gunpowder", "");
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
	set_property("cc_ignoreFlyer", false);
	set_property("cc_instakill", "");
	set_property("cc_masonryWall", false);
	set_property("cc_mcmuffin", "");
	set_property("cc_mistypeak", "");
	set_property("cc_modernzmobiecount", "");
	set_property("cc_mosquito", "");
	set_property("cc_nuns", "");

	if((my_name() == "cheesecookie") && (cc_my_path() != "Actually Ed the Undying"))
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
	set_property("cc_powerLevelLastLevel", "0");
	set_property("cc_powerLevelAdvCount", "0");
	set_property("cc_powerLevelLastAttempted", "0");
	set_property("cc_skipDesert", 0);
	set_property("cc_snapshot", "");
	set_property("cc_sniffs", "");
	set_property("cc_spookyfertilizer", "");
	set_property("cc_spookymap", "");
	set_property("cc_spookyravennecklace", "");
	set_property("cc_spookyravensecond", "");
	set_property("cc_spookysapling", "");
	set_property("cc_sonofa", "");
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
	set_property("cc_yellowRays", "");

	set_property("autoSatisfyWithNPCs", true);

	set_property("choiceAdventure1003", 0);
	beehiveConsider();

	cc_sourceTerminalRequest("educate extract.edu");
	cc_sourceTerminalRequest("enquiry familiar.enq");

	elementalPlanes_initializeSettings();
	eudora_initializeSettings();
	hr_initializeSettings();
	picky_initializeSettings();
	awol_initializeSettings();
	theSource_initializeSettings();
	standard_initializeSettings();
	florist_initializeSettings();
	ocrs_initializeSettings();
	ed_initializeSettings();
	boris_initializeSettings();
}

boolean handleFamiliar(string type)
{
	//	Put all familiars in reverse priority order here.
	if(type == "meat")
	{
		foreach fam in $familiars[Adventurous Spelunker, Grimstone Golem, Angry Jung Man, Bloovian Groose, Hobo Monkey, Piano Cat, Leprechaun]
		{
			if(have_familiar(fam))
			{
				return handleFamiliar(fam);
			}
		}
	}
	else if(type == "item")
	{
		foreach fam in $familiars[Rockin\' Robin, Adventurous Spelunker, Grimstone Golem, Angry Jung Man, Bloovian Groose, Intergnat, Slimeling, Baby Gravy Fairy]
		{
			if(have_familiar(fam))
			{
				return handleFamiliar(fam);
			}
		}
	}
	else if(type == "stat")
	{
		if(monster_level_adjustment() > 120)
		{
			foreach fam in $familiars[Galloping Grill, Rockin\' Robin, Hovering Sombrero, Baby Sandworm]
			{
				if(have_familiar(fam))
				{
					return handleFamiliar(fam);
				}
			}
		}
		foreach fam in $familiars[Grim Brother, Rockin\' Robin, Golden Monkey, Reanimated Reanimator, Unconscious Collective, Bloovian Groose, Lil\' Barrel Mimic, Artistic Goth Kid, Happy Medium, Baby Z-Rex, Li\'l Xenomorph, Smiling Rat, Dramatic Hedgehog, Grinning Turtle, Frumious Bandersnatch, Blood-Faced Volleyball]
		{
			if(have_familiar(fam))
			{
				return handleFamiliar(fam);
			}
		}
	}
	else if(type == "init")
	{
		if(familiar_weight(my_familiar()) == 20)
		{
			if($familiars[Rockin\' Robin, Adventurous Spelunker, Grimstone Golem, Angry Jung Man, Bloovian Groose, Baby Gravy Fairy] contains my_familiar())
			{
				foreach fam in $familiars[Happy Medium, Xiblaxian Holo-Companion, Oily Woim]
				if(have_familiar(fam))
				{
					return handleFamiliar(fam);
				}
			}
		}
	}

	else if(type == "yellow ray")
	{
#		foreach fam in $familiars[Crimbo Shrub, Nanorhino, He-Boulder]
		foreach fam in $familiars[Crimbo Shrub]
		{
			if(have_familiar(fam))
			{
				return handleFamiliar(fam);
			}
		}
	}
	return false;
}

boolean handleFamiliar(familiar fam)
{
	if(get_property("cc_100familiar").to_boolean())
	{
		return true;
	}

	if(fam == $familiar[none])
	{
		return true;
	}
	if(!is_unrestricted(fam))
	{
		return false;
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
		boolean[familiar] poss = $familiars[Mosquito, Leprechaun, Baby Gravy Fairy, Slimeling, Golden Monkey, Hobo Monkey, Crimbo Shrub, Galloping Grill, Fist Turkey, Rockin\' Robin, Piano Cat, Angry Jung Man, Grimstone Golem, Adventurous Spelunker, Rockin\' Robin];

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

	if((toEquip != $familiar[none]) && (my_bjorned_familiar() != toEquip))
	{
		#use_familiar(toEquip);
		set_property("cc_familiarChoice", toEquip);
	}
	if(get_property("kingLiberated").to_boolean() && (toEquip != $familiar[none]) && (toEquip != my_familiar()) && (my_bjorned_familiar() != toEquip))
	{
		use_familiar(toEquip);
	}
#	set_property("cc_familiarChoice", my_familiar());

	if(hr_handleFamiliar(fam))
	{
		return true;
	}
	return false;
}

boolean LX_witchess()
{
	if(my_path() == "Community Service")
	{
		return false;
	}
	if(cs_witchess())
	{
		return true;
	}
	if(!cc_haveWitchess())
	{
		return false;
	}
	if(my_turncount() < 20)
	{
		return false;
	}


	switch(my_daycount())
	{
	case 1:
		if((item_amount($item[Greek Fire]) == 0) && (my_path() != "Community Service"))
		{
			return cc_advWitchess("ml");
		}
		return cc_advWitchess("booze");
	case 2:
		if((get_property("sidequestNunsCompleted") == "none") && (item_amount($item[Jumping Horseradish]) == 0))
		{
			return cc_advWitchess("meat");
		}
	case 3:
		if((get_property("sidequestNunsCompleted") == "none") && (item_amount($item[Jumping Horseradish]) == 0))
		{
			return cc_advWitchess("meat");
		}
	case 4:
		if((get_property("sidequestNunsCompleted") == "none") && (item_amount($item[Jumping Horseradish]) == 0))
		{
			return cc_advWitchess("meat");
		}
		return cc_advWitchess("booze");

	default:
		return cc_advWitchess("booze");
	}
	return false;
}

void maximize_hedge()
{
	string data = visit_url("campground.php?action=telescopelow");

	element first = ns_hedge1();
	element second = ns_hedge2();
	element third = ns_hedge3();
	buffMaintain($effect[Patent Prevention], 0, 1, 1);
	if((first == $element[none]) || (second == $element[none]) || (third == $element[none]))
	{
		ccMaximize("all res -equip snow suit", 2500, 0, false);
	}
	else
	{
		ccMaximize(to_string(first) + " res, " + to_string(second) + " res, " + to_string(third) + " res -equip snow suit", 2500, 0, false);
	}

	foreach eff in $effects[Egged On, Patent Prevention]
	{
		buffMaintain(eff, 0, 1, 1);
	}

}

int pullsNeeded(string data)
{
	if(get_property("kingLiberated").to_boolean())
	{
		return 0;
	}
	if((my_class() == $class[Ed]) || (cc_my_path() == "Community Service"))
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
	visit_url("campground.php?action=telescopelow");

	if(progress < 1)
	{
		int crowd1score = 0;
		int crowd2score = 0;
		int crowd3score = 0;

//		Note: Maximizer gives concert White-boy angst, instead of concert 3 (consequently, it doesn\'t work).

		switch(ns_crowd1())
		{
		case 1:					crowd1score = initiative_modifier()/40;							break;
		}

		switch(ns_crowd2())
		{
		case $stat[Moxie]:		crowd2score = (my_buffedstat($stat[Moxie]) - 150) / 40;			break;
		case $stat[Muscle]:		crowd2score = (my_buffedstat($stat[Muscle]) - 150) / 40;		break;
		case $stat[Mysticality]:crowd2score = (my_buffedstat($stat[Mysticality]) - 150) / 40;	break;
		}

		switch(ns_crowd3())
		{
		case $element[cold]:	crowd3score = numeric_modifier("cold damage") / 9;				break;
		case $element[hot]:		crowd3score = numeric_modifier("hot damage") / 9;				break;
		case $element[sleaze]:	crowd3score = numeric_modifier("sleaze damage") / 9;			break;
		case $element[spooky]:	crowd3score = numeric_modifier("spooky damage") / 9;			break;
		case $element[stench]:	crowd3score = numeric_modifier("stench damage") / 9;			break;
		}

		crowd1score = min(max(0, crowd1score), 9);
		crowd2score = min(max(0, crowd2score), 9);
		crowd3score = min(max(0, crowd3score), 9);
		adv = adv + (10 - crowd1score) + (10 - crowd2score) + (10 - crowd3score);
	}

	if(progress < 2)
	{
		ns_hedge1();
		ns_hedge2();
		ns_hedge3();

		print("Hedge time of 4 adventures. (Up to 10 without Elemental Resistances)", "red");
		adv = adv + 4;
	}

	if(progress < 3)
	{
		if((item_amount($item[Richard\'s Star Key]) == 0) && (item_amount($item[Star Chart]) == 0))
		{
			print("Need star chart", "red");
			if((cc_my_path() == "Heavy Rains") && (my_rain() >= 50))
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

	if(adv > 0)
	{
		print("Estimated adventure need (tower) is: " + adv + ".", "orange");
		if(!in_hardcore())
		{
			print("You need " + count + " pulls.", "orange");
		}
	}
	if(pulls_remaining() > 0)
	{
		print("You have " + pulls_remaining() + " pulls.", "orange");
	}
	return count;
}

boolean tophatMaker()
{
	if(!knoll_available() || (item_amount($item[Brass Gear]) == 0) || possessEquipment($item[Mark V Steam-Hat]))
	{
		return false;
	}
	item reEquip = $item[none];

	if(possessEquipment($item[Mark IV Steam-Hat]))
	{
		if(equipped_item($slot[Hat]) == $item[Mark IV Steam-Hat])
		{
			reEquip = $item[Mark V Steam-Hat];
			equip($slot[hat], $item[none]);
		}
		ccCraft("combine", 1, $item[Brass Gear], $item[Mark IV Steam-Hat]);
	}
	else if(possessEquipment($item[Mark III Steam-Hat]))
	{
		if(equipped_item($slot[Hat]) == $item[Mark III Steam-Hat])
		{
			reEquip = $item[Mark IV Steam-Hat];
			equip($slot[hat], $item[none]);
		}
		ccCraft("combine", 1, $item[Brass Gear], $item[Mark III Steam-Hat]);
	}
	else if(possessEquipment($item[Mark II Steam-Hat]))
	{
		if(equipped_item($slot[Hat]) == $item[Mark II Steam-Hat])
		{
			reEquip = $item[Mark III Steam-Hat];
			equip($slot[hat], $item[none]);
		}
		ccCraft("combine", 1, $item[Brass Gear], $item[Mark II Steam-Hat]);
	}
	else if(possessEquipment($item[Mark I Steam-Hat]))
	{
		if(equipped_item($slot[Hat]) == $item[Mark I Steam-Hat])
		{
			reEquip = $item[Mark II Steam-Hat];
			equip($slot[hat], $item[none]);
		}
		ccCraft("combine", 1, $item[Brass Gear], $item[Mark I Steam-Hat]);
	}
	else if(possessEquipment($item[Brown Felt Tophat]))
	{
		if(equipped_item($slot[Hat]) == $item[Brown Felt Tophat])
		{
			reEquip = $item[Mark I Steam-Hat];
			equip($slot[hat], $item[none]);
		}
		ccCraft("combine", 1, $item[Brass Gear], $item[Brown Felt Tophat]);
	}
	else
	{
		return false;
	}

	print("Mark Steam-Hat upgraded!", "blue");
	if(reEquip != $item[none])
	{
		equip($slot[hat], reEquip);
	}
	return true;
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

boolean warAdventure()
{
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		ccAdv(1, $location[The Battlefield (Frat Uniform)]);
	}
	else
	{
		ccAdv(1, $location[The Battlefield (Hippy Uniform)]);
	}
	return true;
}

boolean doThemtharHills(boolean trickMode)
{
	if(get_property("cc_nuns") == "done")
	{
		return false;
	}
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
		if(have_skill($skill[Rain Man]))
		{
			copyPossible = true;
			if(my_rain() >= 60)
			{
				copyAvailable = 1;
			}
		}

#		Sample for allowed Rain-Doh usage.
#		if((item_amount($item[Rain-doh Black Box]) > 0) && (get_property("_raindohCopiesMade").to_int() < 5))
#		{
#			copyAvailable = 2;
#			copyPossible = true;
#		}

		if((item_amount($item[shaking 4-d camera]) > 0) && !get_property("_cameraUsed").to_boolean())
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
		}
		fightCopy = true;
	}

	if((get_property("sidequestArenaCompleted") == "fratboy") && !get_property("concertVisited").to_boolean() && (have_effect($effect[Winklered]) == 0))
	{
		outfit("frat warrior fatigues");
		cli_execute("concert 2");
	}

	handleBjornify($familiar[Hobo Monkey]);
	if((equipped_item($slot[off-hand]) != $item[Half a Purse]) && !possessEquipment($item[Half a Purse]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
	{
		buyUpTo(1, $item[Loose Purse Strings]);
		ccCraft("smith", 1, $item[Lump of Brituminous Coal], $item[Loose purse strings]);
	}

	if(possessEquipment($item[Half a Purse]))
	{
		equip($item[Half a Purse]);
	}
	if((cc_my_path() == "Heavy Rains") && (item_amount($item[Thor\'s Pliers]) > 0))
	{
		equip($item[Thor\'s Pliers]);
	}
	if(possessEquipment($item[Miracle Whip]))
	{
		equip($item[Miracle Whip]);
	}

	shrugAT();

	if(my_class() == $class[Ed])
	{
		if(fightCopy)
		{
			adjustEdHat("meat");
		}

		if(!have_skill($skill[Gift of the Maid]) && ($servant[Maid].experience >= 441))
		{
			visit_url("charsheet.php");
			if(have_skill($skill[Gift of the Maid]))
			{
				print("Gift of the Maid not properly detected until charsheet refresh.", "red");
			}
		}
		handleServant($servant[maid]);
	}
	buffMaintain($effect[Purr of the Feline], 10, 1, 1);
	float meatDropHave = meat_drop_modifier();

/*
	if(get_property("cc_100familiar").to_boolean())
	{
		ccMaximize("meat drop, -equip snow suit", 1500, 0, false);
	}
	else
	{
		ccMaximize("meat drop, -equip snow suit, switch Hobo Monkey, switch rockin' robin, switch adventurous spelunker, switch Grimstone Golem, switch Fist Turkey, switch Unconscious Collective, switch Golden Monkey, switch Angry Jung Man, switch Leprechaun", 1500, 0, false);
		handleFamiliar(my_familiar());
	}
	int expectedMeat = numeric_modifier("Generated:_spec", "meat drop");
*/

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
	buffMaintain($effect[Patent Avarice], 0, 1, 1);

	handleFamiliar("meat");

	if(cc_my_path() == "Heavy Rains")
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	else if((get_property("cc_nunsTrickCount").to_int() > 2) || (meat_drop_modifier() > 600.0))
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	// Target 1000 + 400% = 5000 meat per brigand. Of course we want more, but don\'t bother unless we can get this.
	float meat_need = 400.00;
#	if(cc_my_path() == "Standard")
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
				handleFamiliar("item");
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
			handleCopiedMonster($item[Shaking 4-D Camera]);
			break;
		case 4:
			handleCopiedMonster($item[Ice Sculpture]);
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
		if(get_property("lastEncounter") != $monster[Dirty Thieving Brigand])
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
		if(((item_amount($item[stone wool]) > 0) || (have_effect($effect[Stone-Faced]) > 0)) && (get_property("cc_nunsTrickCount").to_int() > 2) && (get_property("lastTempleAdventures") != my_ascensions()))
		{
			set_property("choiceAdventure582", "1");
			set_property("choiceAdventure579", "3");
			if(have_effect($effect[Stone-Faced]) == 0)
			{
				use(1, $item[stone wool]);
			}
			put_closet(item_amount($item[stone wool]), $item[stone wool]);
			ccAdv(1, $location[The Hidden Temple]);
		}
	}
	handleFamiliar("item");
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
		if((storage_amount($item[Buddy Bjorn]) > 0) && !($classes[Avatar of Boris, Avatar of Jarlsberg, Avatar of Sneaky Pete, Ed] contains my_class()))
		{
			pullXWhenHaveY($item[Buddy Bjorn], 1, 0);
		}
		if((storage_amount($item[Camp Scout Backpack]) > 0) && !possessEquipment($item[Buddy Bjorn]))
		{
			pullXWhenHaveY($item[Camp Scout Backpack], 1, 0);
		}

		if(is_unrestricted($item[Pantsgiving]))
		{
			if(my_class() != $class[Avatar of Boris])
			{
				pullXWhenHaveY($item[xiblaxian stealth cowl], 1, 0);
			}
			pullXWhenHaveY($item[Pantsgiving], 1, 0);
		}
		else
		{
			pullXWhenHaveY($item[The Crown of Ed the Undying], 1, 0);
			adjustEdHat("ml");
			pullXWhenHaveY($item[Xiblaxian Stealth Trousers], 1, 0);
		}

		if(!possessEquipment($item[Astral Shirt]))
		{
			if(have_skill($skill[Torso Awaregness]))
			{
				pullXWhenHaveY($item[Sneaky Pete\'s Leather Jacket], 1, 0);
				if(item_amount($item[Sneaky Pete\'s Leather Jacket]) == 0)
				{
					pullXWhenHaveY($item[Sneaky Pete\'s Leather Jacket (Collar Popped)], 1, 0);
				}
				else
				{
					cli_execute("fold " + $item[Sneaky Pete\'s Leather Jacket (Collar Popped)]);
				}
			}
		}

		pullXWhenHaveY($item[spooky-gro fertilizer], 1, 0);

		if(((cc_my_path() == "Picky") || get_property("cc_100familiar").to_boolean()) && (item_amount($item[Deck of Every Card]) == 0))
		{
			if(item_amount($item[Boris\'s Key]) == 0)
			{
				pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
			}
			if(item_amount($item[Sneaky Pete\'s Key]) == 0)
			{
				pullXWhenHaveY($item[Sneaky Pete\'s Key Lime Pie], 1, 0);
			}
			if(item_amount($item[Jarlsberg\'s Key]) == 0)
			{
				pullXWhenHaveY($item[Jarlsberg\'s Key Lime Pie], 1, 0);
			}
		}
		else if(cc_my_path() == "Standard")
		{
			pullXWhenHaveY(whatHiMein(), 3, 0);
		}

		pullXWhenHaveY($item[over-the-shoulder folder holder], 1, 0);
		if((my_primestat() == $stat[Muscle]) && (cc_my_path() != "Heavy Rains"))
		{
			if(closet_amount($item[Fake Washboard]) == 0)
			{
				pullXWhenHaveY($item[Fake Washboard], 1, 0);
			}
			if((item_amount($item[Fake Washboard]) == 0) && (closet_amount($item[Fake Washboard]) == 0))
			{
				pullXWhenHaveY($item[numberwang], 1, 0);
			}
			else
			{
				if(get_property("barrelShrineUnlocked").to_boolean())
				{
					put_closet(item_amount($item[Fake Washboard]), $item[Fake Washboard]);
				}
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

		if((my_class() == $class[Sauceror]) || (my_class() == $class[Pastamancer]))
		{
			if((item_amount($item[Deck of Every Card]) == 0) && !have_skill($skill[Summon Smithsness]))
			{
				pullXWhenHaveY($item[Thor\'s Pliers], 1, 0);
			}
		}

		if(cc_my_path() == "Picky")
		{
			pullXWhenHaveY($item[gumshoes], 1, 0);
		}
		if(have_skill($skill[Summon Smithsness]))
		{
			pullXWhenHaveY($item[hand in glove], 1, 0);
		}
		else
		{
			//pullXWhenHaveY(<smithsWeapon>, 1, 0);
			//Possibly pull other smiths gear?
		}

		if((cc_my_path() != "Heavy Rains") && !($classes[Avatar of Boris, Avatar of Jarlsberg, Avatar of Sneaky Pete, Ed] contains my_class()))
		{
			if(!possessEquipment($item[Snow Suit]))
			{
				pullXWhenHaveY($item[snow suit], 1, 0);
			}
			if(!possessEquipment($item[Snow Suit]) && !possessEquipment($item[Filthy Child Leash]) && !possessEquipment($item[Astral Pet Sweater]))
			{
				pullXWhenHaveY($item[Filthy Child Leash], 1, 0);
			}
		}

		if(get_property("cc_dickstab").to_boolean())
		{
			pullXWhenHaveY($item[Shore Inc. Ship Trip Scrip], 3, 0);
		}

		if((!have_familiar($familiar[Grim Brother])) && (my_class() != $class[Ed]))
		{
			pullXWhenHaveY($item[Unconscious Collective Dream Jar], 1, 0);
			if(item_amount($item[Unconscious Collective Dream Jar]) > 0)
			{
				ccChew(1, $item[Unconscious Collective Dream Jar]);
			}
		}
	}
	else if(day == 2)
	{
		if((closet_amount($item[Fake Washboard]) == 1) && get_property("barrelShrineUnlocked").to_boolean())
		{
			take_closet(1, $item[Fake Washboard]);
		}
	}

	return pulls_remaining();
}

boolean fortuneCookieEvent()
{
	if((cc_my_path() == "Heavy Rains") && (get_property("cc_orchard") == "finished"))
	{
		if(get_counters("Fortune Cookie", 0, 200) != "")
		{
			cli_execute("counters");
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

		location goal = $location[The Hidden Temple];

		if((my_path() == "Community Service") && (my_daycount() == 1))
		{
			goal = $location[The Limerick Dungeon];
		}

		if((goal == $location[The Hidden Temple]) && ((item_amount($item[stone wool]) >= 2) || (get_property("cc_hiddenunlock") == "nose") || (get_property("cc_hiddenunlock") == "finished") || (internalQuestStatus("questL11Worship") >= 3) || (get_property("semirareLocation") == goal) || (get_property("lastTempleUnlock").to_int() < my_ascensions()) || (get_property("cc_spookysapling") != "finished")))
		{
			goal = $location[The Castle in the Clouds in the Sky (Top Floor)];
		}

		if((goal == $location[The Castle in the Clouds in the Sky (Top Floor)]) && ((item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0) || (get_property("cc_nuns") == "done") || (get_property("cc_nuns") == "finished") || (internalQuestStatus("questL10Garbage") < 9) || (get_property("semirareLocation") == goal) || (get_property("lastCastleTopUnlock").to_int() < my_ascensions()) || (get_property("cc_castleground") != "finished") || (get_property("sidequestNunsCompleted") != "none")))
		{
			goal = $location[The Limerick Dungeon];
		}

		#(internalQuestStatus("questL10Garbage") < 9) 
		if((goal == $location[The Limerick Dungeon]) && ((item_amount($item[Cyclops Eyedrops]) > 0) || (get_property("cc_orchard") == "start") || (get_property("cc_orchard") == "done") || (get_property("cc_orchard") == "finished") || (get_property("semirareLocation") == goal) || (get_property("lastFilthClearance").to_int() >= my_ascensions()) || (get_property("sidequestOrchardCompleted") != "none") || (get_property("currentHippyStore") != "none")))
		{
			goal = $location[The Haunted Pantry];
		}

		if((goal == $location[The Haunted Pantry]) && (get_property("semirareLocation") == goal))
		{
			goal = $location[The Sleazy Back Alley];
		}

		if((goal == $location[The Sleazy Back Alley]) && (get_property("semirareLocation") == goal))
		{
			goal = $location[The Outskirts of Cobb\'s Knob];
		}

		if((goal == $location[The Outskirts of Cobb\'s Knob]) && (get_property("semirareLocation") == goal))
		{
			print("Do we not have access to either The Haunted Pantry or The Sleazy Back Alley?", "red");
			goal = $location[The Haunted Pantry];
		}

		return ccAdv(goal);
	}
	return false;
}


void initializeDay(int day)
{
	if(get_property("kingLiberated").to_boolean())
	{
		return;
	}

	if(!possessEquipment($item[Your Cowboy Boots]) && get_property("telegraphOfficeAvailable").to_boolean() && is_unrestricted($item[LT&T Telegraph Office Deed]))
	{
		string temp = visit_url("desc_item.php?whichitem=529185925");
		#if(equipped_item($slot[bootspur]) == $item[Nicksilver spurs])
		if(contains_text(temp, "Item Drops from Monsters"))
		{
			string temp = visit_url("place.php?whichplace=town_right&action=townright_ltt");
		}
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

	if(item_amount($item[Telegram From Lady Spookyraven]) > 0)
	{
		print("Lady Spookyraven quest not detected as started should have been auto-started. Starting it. If you are not in an Ed run, report this. Otherwise, it is expected.", "red");
		use(1, $item[Telegram From Lady Spookyraven]);
		set_property("questM20Necklace", "started");
	}

	if(internalQuestStatus("questM20Necklace") == -1)
	{
		if(item_amount($item[Telegram From Lady Spookyraven]) > 0)
		{
			use(1, $item[Telegram From Lady Spookyraven]);
		}
		else
		{
			print("Lady Spookyraven quest not detected as started but we don't have the telegram, assuming it is... If you are not in an Ed run, report this. Otherwise, it is expected.", "red");
			set_property("questM20Necklace", "started");
		}
	}

	cc_barrelPrayers();

	if(!get_property("_pottedTeaTreeUsed").to_boolean() && (cc_get_campground() contains $item[Potted Tea Tree]) && !get_property("kingLiberated").to_boolean())
	{
		if(get_property("cc_teaChoice") != "")
		{
			string[int] teaChoice = split_string(get_property("cc_teaChoice"), ";");
			item myTea = teaChoice[min(count(teaChoice), my_daycount()) - 1].to_item();
			if(myTea != $item[none])
			{
				boolean buff = cli_execute("teatree " + myTea);
			}
		}
		else if(day == 1)
		{
			boolean buff = cli_execute("teatree " + $item[Cuppa Voraci Tea]);
		}
		else if(day == 2)
		{
			boolean buff = cli_execute("teatree " + $item[Cuppa Sobrie Tea]);
		}
		else
		{
			visit_url("campground.php?action=teatree");
			run_choice(1);
		}
	}

	if(!get_property("_floundryItemUsed").to_boolean() && (get_clan_furniture() contains $item[Clan Floundry]) && !get_property("kingLiberated").to_boolean())
	{
		if(get_property("cc_floundryChoice") != "")
		{
			string[int] floundryChoice = split_string(get_property("cc_floundryChoice"), ";");
			item myFloundry = floundryChoice[min(count(floundryChoice), my_daycount()) - 1].to_item();
			int oldCount = item_amount(myFloundry);
			if(myFloundry != $item[none])
			{
				string temp = visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=" + myFloundry.to_int());
				if(item_amount(myFloundry) != (oldCount + 1))
				{
					print("Could not fish from the Floundry for some raisin.", "red");
				}
				else
				{
					set_property("_floundryItemUsed", true);
				}
			}
		}
	}

	if((item_amount($item[GameInformPowerDailyPro Magazine]) > 0) && (my_daycount() == 1))
	{
		visit_url("inv_use.php?pwd=&which=3&whichitem=6174", true);
		visit_url("inv_use.php?pwd=&which=3&whichitem=6174&confirm=Yep.", true);
		set_property("cc_disableAdventureHandling", "yes");
		ccAdv(1, $location[Video Game Level 1]);
		set_property("cc_disableAdventureHandling", "no");
		if(item_amount($item[Dungeoneering Kit]) > 0)
		{
			use(1, $item[Dungeoneering Kit]);
		}
	}

	chateaumantegna_useDesk();
	ed_initializeDay(day);
	boris_initializeDay(day);
	cs_initializeDay(day);

	if(day == 1)
	{
		if(get_property("cc_day1_init") != "finished")
		{
			set_property("_beancannonUsed", 0);
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

			if((get_clan_furniture() contains $item[Clan Floundry]) && (item_amount($item[Fishin\' Pole]) == 0))
			{
				visit_url("clan_viplounge.php?action=floundry");
			}

			visit_url("tutorial.php?action=toot");
			use(item_amount($item[Letter From King Ralph XI]), $item[Letter From King Ralph XI]);
			use(item_amount($item[Pork Elf Goodies Sack]), $item[Pork Elf Goodies Sack]);
			tootGetMeat();

			hr_initializeDay(day);

			if((item_amount($item[Antique Accordion]) == 0) && !($classes[Accordion Thief, Avatar of Boris, Avatar of Jarlsberg, Avatar of Sneaky Pete, Ed] contains my_class()))
			{
				buyUpTo(1, $item[toy accordion]);
			}

			while((item_amount($item[turtle totem]) == 0) || (item_amount($item[saucepan]) == 0))
			{
				buyUpTo(1, $item[chewing gum on a string]);
				use(1, $item[chewing gum on a string]);
			}

			makeStartingSmiths();

			handleFamiliar($familiar[Angry Jung Man]);
			equipBaseline();

			handleBjornify($familiar[none]);
			handleBjornify($familiar[El Vibrato Megadrone]);

			string temp = visit_url("guild.php?place=challenge");

			if(get_property("cc_breakstone").to_boolean())
			{
				temp = visit_url("campground.php?action=stone&smashstone=Yep.&pwd&confirm=on", true);
				set_property("cc_breakstone", false);
			}
			set_property("cc_day1_init", "finished");
		}

		if((get_property("lastCouncilVisit").to_int() < my_level()) && (cc_my_path() != "Community Service"))
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
			set_property("_beancannonUsed", 0);
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
			if((item_amount($item[Antique Accordion]) == 0) && !($classes[Accordion Thief, Avatar of Boris, Avatar of Jarlsberg, Avatar of Sneaky Pete, Ed] contains my_class()))
			{
				buyUpTo(1, $item[antique accordion]);
			}
			if(my_class() == $class[Avatar of Boris])
			{
				if((item_amount($item[Clancy\'s Crumhorn]) == 0) && (get_property("cc_clancy").to_item() != $item[Clancy\'s Crumhorn]))
				{
					buyUpTo(1, $item[Clancy\'s Crumhorn]);
				}
			}
			if(have_skill($skill[Summon Smithsness]) && (my_mp() > (3 * mp_cost($skill[Summon Smithsness]))))
			{
				use_skill(3, $skill[Summon Smithsness]);
			}

			if(item_amount($item[handful of smithereens]) >= 2)
			{
				buyUpTo(2, $item[Ben-Gal&trade; Balm], 25);
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
				if(item_amount($item[Boris\'s Key]) == 0)
				{
					pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
				}
				if(item_amount($item[Sneaky Pete\'s Key]) == 0)
				{
					pullXWhenHaveY($item[Sneaky Pete\'s Key Lime Pie], 1, 0);
				}
				if(item_amount($item[Jarlsberg\'s Key]) == 0)
				{
					pullXWhenHaveY($item[Jarlsberg\'s Key Lime Pie], 1, 0);
				}
			}
			else
			{
				pullXWhenHaveY(whatHiMein(), 2, 0);
			}

#			if((item_amount($item[glass of goat\'s milk]) == 0) || (cc_my_path() == "Picky"))
#			{
#				pullXWhenHaveY($item[milk of magnesium], 1, 0);
#			}

			set_property("cc_day2_init", "finished");
		}
		if(chateaumantegna_havePainting() && (my_class() != $class[Ed]) && (cc_my_path() != "Community Service"))
		{
			handleFamiliar($familiar[Reanimated Reanimator]);
			chateaumantegna_usePainting();
			handleFamiliar($familiar[Angry Jung Man]);
		}
	}
	else if(day == 3)
	{
		if(get_property("cc_day3_init") == "")
		{
			set_property("_beancannonUsed", 0);
			hermit(10, $item[ten-leaf clover]);

			picky_pulls();
			standard_pulls();

			set_property("cc_day3_init", "finished");
		}
	}
	else if(day == 4)
	{
		if(get_property("cc_day4_init") == "")
		{
			set_property("_beancannonUsed", 0);
			hermit(10, $item[ten-leaf clover]);
			set_property("cc_day4_init", "finished");
		}
	}
	if(day >= 2)
	{
		ovenHandle();
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

	restoreAllSettings();
	restoreSetting("autoSatisfyWithCoinmasters");
	restoreSetting("removeMalignantEffects");
#	if(get_property("cc_priorCoinmasters").to_boolean())
#	{
#		set_property("cc_priorCoinmasters", false);
#		set_property("autoSatisfyWithCoinmasters", false);
#	}

	if(get_property("cc_priorCharpaneMode").to_int() == 1)
	{
		print("Resuming Compact Character Mode.");
		set_property("cc_priorCharpaneMode", 0);
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=1&ajax=0", true);
	}

	restoreSetting("kingLiberatedScript");
	restoreSetting("afterAdventureScript");
	restoreSetting("betweenAdventureScript");
	restoreSetting("betweenBattleScript");

#	restore_property("kingLiberatedScript", "cc_kingLiberatedScript");
#	restore_property("afterAdventureScript", "cc_afterAdventureScript");
#	restore_property("betweenAdventureScript", "cc_betweenAdventureScript");
#	restore_property("betweenBattleScript", "cc_betweenBattleScript");


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
	if(!haveSpleenFamiliar())
	{
		spleenlimit = 0;
	}
	if((my_spleen_use() < spleenlimit) && !in_hardcore() && (my_inebriety() < inebriety_limit()))
	{
		return;
	}

	handleBarrelFullOfBarrels();

	if(get_property("cc_priorXiblaxianMode").to_int() == 1)
	{
		set_property("cc_priorXiblaxianMode", 0);
		setvar("chit.helpers.xiblaxian", true);
		cli_execute("zlib chit.helpers.xiblaxian = true");
	}

	ed_terminateSession();

	while(LX_freeCombats())
	{}

	if(my_class() == $class[seal clubber])
	{
		handleFamiliar("stat");
		int oldSeals = get_property("_sealsSummoned").to_int();
		while((get_property("_sealsSummoned").to_int() < 5) && (!get_property("kingLiberated").to_boolean()) && (my_meat() > 4500))
		{
			if(my_daycount() == 1)
			{
				cli_execute("make figurine of an ancient seal");
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
#				if((have_effect($effect[Everything Looks Yellow]) == 0) && (my_lightning() >= 5))
				if(canYellowRay())
				{
					print("Make sure to Ball Lightning the spy!!", "red");
				}
			}
			else
			{
				print("If you have the Frat Warrior Fatigues, rain man an Astronomer? Skinflute?", "blue");
			}
		}
		if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (inebriety_left() >= 0) && (my_adventures() > 0))
		{
			print("You have " + (5 - get_property("_machineTunnelsAdv").to_int()) + " fights in The Deep Machine Tunnels that you should use!", "blue");
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
		doHottub();
	}

	if(!get_property("_mayoTankSoaked").to_boolean() && (cc_get_campground() contains $item[Portable Mayo Clinic]) && is_unrestricted($item[Portable Mayo Clinic]))
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

	if((is_unrestricted($item[Clan Pool Table])) && (get_property("_poolGames").to_int() < 3) && (item_amount($item[Clan VIP Lounge Key]) > 0))
	{
		visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
		visit_url("clan_viplounge.php?preaction=poolgame&stance=1");
		visit_url("clan_viplounge.php?preaction=poolgame&stance=3");
	}
	if(is_unrestricted($item[Colorful Plastic Ball]) && !get_property("_ballpit").to_boolean())
	{
		cli_execute("ballpit");
	}
	if((get_property("telescopeUpgrades").to_int() > 0) && (get_property("cc_sorceress") == ""))
	{
		if(get_property("telescopeLookedHigh") == "false")
		{
			cli_execute("telescope high");
		}
	}

	if(!possessEquipment($item[Vicar\'s Tutu]) && (my_daycount() == 1) && (item_amount($item[lump of Brituminous coal]) > 0))
	{
		if((item_amount($item[frilly skirt]) < 1) && knoll_available())
		{
			buyUpTo(1, $item[frilly skirt]);
		}
		if(item_amount($item[frilly skirt]) > 0)
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[frilly skirt]);
		}
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

	dna_bedtime();

	if((get_property("_grimBuff") == "false") && have_familiar($familiar[Grim Brother]))
	{
		visit_url("choice.php?pwd=&whichchoice=835&option=1", true);
	}

	if(get_property("cc_clanstuff").to_int() < my_daycount())
	{
		if(is_unrestricted($item[Olympic-sized Clan Crate]) && !get_property("_olympicSwimmingPool").to_boolean())
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
			if(get_property("kingLiberated").to_boolean())
			{
				cli_execute("shower ice");
			}
			else
			{
				cli_execute("shower " + my_primestat());
			}
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
		if((pulls_remaining() > 1) && !possessEquipment($item[antique machete]) && (my_class() != $class[Avatar of Boris]))
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

	if((my_daycount() - 5) >= get_property("lastAnticheeseDay").to_int())
	{
		visit_url("place.php?whichplace=desertbeach&action=db_nukehouse");
	}

	if((get_property("puzzleChampBonus").to_int() == 20) && !get_property("_witchessBuff").to_boolean())
	{
		visit_url("campground.php?action=witchess");
		visit_url("choice.php?whichchoice=1181&pwd=&option=3");
		visit_url("choice.php?whichchoice=1183&pwd=&option=2");
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
	if(item_amount($item[Loathing Legion Jackhammer]) > 0)
	{
		int craftingLeft = 3 - get_property("_legionJackhammerCrafting").to_int();
		print("Free Loathing Legion Jackhammer craftings left: " + craftingLeft, "blue");
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
	if(get_property("timesRested").to_int() < total_free_rests())
	{
		print("You have " + (total_free_rests() - get_property("timesRested").to_int()) + " free rests remaining.", "blue");
	}
	if((get_property("sidequestNunsCompleted") == "fratboy") && (get_property("nunsVisits").to_int() < 3))
	{
		print("You have " + (3 - get_property("nunsVisits").to_int()) + " nuns visits left.", "blue");
	}
	if(get_property("libramSummons").to_int() > 0)
	{
		print("Total Libram Summons: " + get_property("libramSummons"), "blue");
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
	if((item_amount($item[Glenn\'s Golden Dice]) > 0) && (!get_property("_glennGoldenDiceUsed").to_boolean()))
	{
		print("Still have some of Glenn's Golden Dice that you can use!", "blue");
	}
	if((get_property("spookyAirportAlways").to_boolean()) && (my_class() != $class[Ed]) && !get_property("_controlPanelUsed").to_boolean())
	{
		visit_url("place.php?whichplace=airport_spooky_bunker&action=si_controlpanel");
		visit_url("choice.php?pwd=&whichchoice=986&option=8",true);
		visit_url("choice.php?pwd=&whichchoice=986&option=10",true);
	}

	elementalPlanes_takeJob($element[spooky]);
	elementalPlanes_takeJob($element[stench]);
	elementalPlanes_takeJob($element[cold]);

	if((item_amount($item[Infinite BACON Machine]) > 0) && !get_property("_baconMachineUsed").to_boolean())
	{
		use(1, $item[Infinite BACON Machine]);
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
		if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5))
		{
			print("You have " + (5 - get_property("_machineTunnelsAdv").to_int()) + " fights in The Deep Machine Tunnels that you should use!", "blue");
		}
		if((my_inebriety() <= inebriety_limit()) && (my_rain() >= 50) && (my_adventures() >= 1))
		{
			if(item_amount($item[beer helmet]) == 0)
			{
				print("Please consider an orcish frat boy spy (You want Frat Warrior Fatigues).", "blue");
#				if((have_effect($effect[Everything Looks Yellow]) == 0) && (my_lightning() >= 5))
				if(canYellowRay())
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
			if((get_property("_photocopyUsed") == "false") && (is_unrestricted($item[Deluxe Fax Machine])) && (my_adventures() > 0) && (my_class() != $class[Avatar of Boris]))
			{
				print("You may have a fax that you can use. Check it out!", "blue");
			}
			if((pulls_remaining() > 0) && (my_daycount() == 1))
			{
				string consider = "";
				boolean[item] cList;
				cList = $items[antique machete, wet stew, blackberry galoshes, drum machine, killing jar];
				if(my_class() == $class[Avatar of Boris])
				{
					cList = $items[wet stew, blackberry galoshes, drum machine, killing jar];
				}
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

		if(have_skill($skill[Calculate the Universe]) && !get_property("_universeCalculated").to_boolean())
		{
			print("You can still Calculate the Universe!", "blue");
		}

		if(is_unrestricted($item[Deck of Every Card]) && (item_amount($item[Deck of Every Card]) > 0) && (get_property("_deckCardsDrawn").to_int() < 15))
		{
			print("You have a Deck of Every Card and " + (15 - get_property("_deckCardsDrawn").to_int()) + " draws remaining!", "blue");
		}

		if(is_unrestricted($item[Chateau Mantegna Room Key]) && !get_property("_chateauMonsterFought").to_boolean() && get_property("chateauAvailable").to_boolean())
		{
			print("You can still fight a Chateau Mangtegna Painting today.", "blue");
		}

		if(stills_available() > 0)
		{
			print("You have " + stills_available() + " uses of Nash Crosby's Still left.", "blue");
		}

		if(is_unrestricted($item[shrine to the Barrel God]) && !get_property("_barrelPrayer").to_boolean() && get_property("barrelShrineUnlocked").to_boolean())
		{
			print("You can still worship the barrel god today.", "blue");
		}
		if(is_unrestricted($item[Airplane Charter: Dinseylandfill]) && !get_property("_dinseyGarbageDisposed").to_boolean() && elementalPlanes_access($element[stench]))
		{
			if((item_amount($item[bag of park garbage]) > 0) || (pulls_remaining() > 0))
			{
				print("You can still dispose of Garbage in Dinseyland.", "blue");
			}
		}
		if(is_unrestricted($item[Airplane Charter: That 70s Volcano]) && !get_property("_infernoDiscoVisited").to_boolean() && elementalPlanes_access($element[hot]))
		{
			if((item_amount($item[Smooth Velvet Hat]) > 0) || (item_amount($item[Smooth Velvet Shirt]) > 0) || (item_amount($item[Smooth Velvet Pants]) > 0) || (item_amount($item[Smooth Velvet Hanky]) > 0) || (item_amount($item[Smooth Velvet Pocket Square]) > 0) || (item_amount($item[Smooth Velvet Socks]) > 0))
			{
				print("You can still disco inferno at the Inferno Disco.", "blue");
			}
		}
		if(is_unrestricted($item[Potted Tea Tree]) && !get_property("_pottedTeaTreeUsed").to_boolean() && (cc_get_campground() contains $item[Potted Tea Tree]))
		{
			print("You have a tea tree to shake!", "blue");
		}

		print("You are probably done for today, beep.", "blue");
	}
}

boolean questOverride()
{
	if(get_property("semirareCounter").to_int() == 0)
	{
		if(get_property("semirareLocation") != "")
		{
			set_property("semirareLocation", "");
		}
	}


	// At the start of an ascension, cc_get_campground() displays the wrong info.
	// Visiting the campground doesn\'t work.... grrr...
	//	visit_url("campground.php");

#	if(!get_property("cc_haveoven").to_boolean())
#	{
#		if(cc_get_campground() contains $item[Dramatic&trade; range])
#		{
#			set_property("cc_haveoven", true);
#		}
#	}

	if((get_property("lastTempleUnlock").to_int() == my_ascensions()) && (get_property("cc_treecoin") != "finished"))
	{
		print("Found Unlocked Hidden Temple but unaware of tree-holed coin (2)");
		set_property("cc_treecoin", "finished");
	}
	if((get_property("lastTempleUnlock").to_int() == my_ascensions()) && (get_property("cc_spookymap") != "finished"))
	{
		print("Found Unlocked Hidden Temple but unaware of spooky map (2)");
		set_property("cc_spookymap", "finished");
	}
	if((get_property("lastTempleUnlock").to_int() == my_ascensions()) && (get_property("cc_spookyfertilizer") != "finished"))
	{
		print("Found Unlocked Hidden Temple but unaware of spooky fertilizer (2)");
		set_property("cc_spookyfertilizer", "finished");
	}
	if((get_property("lastTempleUnlock").to_int() == my_ascensions()) && (get_property("cc_spookysapling") != "finished"))
	{
		print("Found Unlocked Hidden Temple but unaware of spooky sapling (2)");
		set_property("cc_spookysapling", "finished");
	}

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
		set_property("cc_boopeak", "finished");
		set_property("cc_oilpeak", "finished");
		set_property("cc_twinpeak", "finished");
	}
	if((get_property("questL10Garbage") == "finished") && (get_property("cc_castletop") != "finished"))
	{
		print("Found completed Castle in the Clouds in the Sky with some Pie (10)");
		set_property("cc_castletop", "finished");
		set_property("cc_castleground", "finished");
		set_property("cc_castlebasement", "finished");
		set_property("cc_airship", "finished");
		set_property("cc_bean", true);
	}
	if((internalQuestStatus("questL10Garbage") >= 9) && (get_property("cc_castleground") != "finished"))
	{
		print("Found completed Castle Ground Floor (10)");
		set_property("cc_castleground", "finished");
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
	if((internalQuestStatus("questL10Garbage") >= 2) && !get_property("cc_bean").to_boolean())
	{
		print("Found completed Planted Beanstalk (10)");
		set_property("cc_bean", true);
	}

	if((internalQuestStatus("questL11Manor") >= 11) && (get_property("cc_ballroom") != "finished"))
	{
		print("Found completed Spookyraven Manor (11)");
		set_property("cc_ballroom", "finished");
		set_property("cc_winebomb", "finished");
		set_property("cc_ballroomflat", "finished");
	}

	if((internalQuestStatus("questL11Manor") >= 3) && (get_property("cc_winebomb") != "finished"))
	{
		print("Found completed Spookyraven Manor Organ Music (11)");
		set_property("cc_winebomb", "finished");
		set_property("cc_masonryWall", true);
		set_property("cc_ballroomflat", "finished");
	}

	if((internalQuestStatus("questL11Manor") >= 1) && (get_property("cc_ballroomflat") != "finished"))
	{
		print("Found completed Spookyraven Manor Organ Music (11)");
		set_property("cc_ballroomflat", "finished");
	}

	if((internalQuestStatus("questL11Worship") >= 3) && (get_property("cc_hiddenunlock") != "finished"))
	{
		print("Found unlocked Hidden City (11)");
		set_property("cc_hiddenunlock", "finished");
	}

	if((internalQuestStatus("questL11Black") >= 2) && (get_property("cc_blackmap") == ""))
	{
		print("Found an unexpected Black Market (11 - via questL11Black)");
		set_property("cc_blackmap", "document");
	}
	if((get_property("blackForestProgress") >= 5) && (get_property("cc_blackmap") == ""))
	{
		print("Found an unexpected Black Market (11 - via blackForestProgress)");
		set_property("cc_blackmap", "document");
	}

	if((get_property("questL11Black") == "finished") && (get_property("cc_blackmap") != "finished"))
	{
		print("Found completed Black Market (11 - via questL11Black)");
		set_property("cc_blackmap", "finished");
	}
	if((internalQuestStatus("questL11MacGuffin") >= 2) && (get_property("cc_blackmap") != "finished"))
	{
		print("Found completed Black Market (11 - via questL11MacGuffin)");
		set_property("cc_blackmap", "finished");
	}


	if((internalQuestStatus("questL11MacGuffin") >= 2) && (get_property("cc_mcmuffin") == ""))
	{
		print("Found started McMuffin quest (11)");
		set_property("cc_mcmuffin", "start");
	}



	if((get_property("questL11Palindome") == "finished") && (get_property("cc_palindome") != "finished"))
	{
		print("Found completed Palindome (11)");
		set_property("cc_palindome", "finished");
	}

//	if((get_property("questL11Pyramid") == "finished") && (get_property("cc_mcmuffin") != "finished"))
//	{
//		print("Found completed Pyramid (11)");
//		set_property("cc_mcmuffin", "finished");
//	}
	if((get_property("questL11MacGuffin") == "finished") && (get_property("cc_mcmuffin") != "finished"))
	{
		print("Found completed McMuffin (11)");
		set_property("cc_mcmuffin", "finished");
	}

	if((get_property("questL11Business") == "finished") && (get_property("cc_hiddenoffice") != "finished"))
	{
		print("Found completed Hidden Office Building (11)");
		set_property("cc_hiddenoffice", "finished");
		if((get_property("cc_hiddenzones") != "finished") && (get_property("cc_hiddenzones").to_int() < 3))
		{
			set_property("cc_hiddenzones", 3);
		}
	}
	if((get_property("questL11Curses") == "finished") && (get_property("cc_hiddenapartment") != "finished"))
	{
		print("Found completed Hidden Apartment Building (11)");
		set_property("cc_hiddenapartment", "finished");
		if((get_property("cc_hiddenzones") != "finished") && (get_property("cc_hiddenzones").to_int() < 2))
		{
			set_property("cc_hiddenzones", 2);
		}
	}
	if((get_property("questL11Spare") == "finished") && (get_property("cc_hiddenbowling") != "finished"))
	{
		print("Found completed Hidden Bowling Alley (11)");
		set_property("cc_hiddenbowling", "finished");
		if((get_property("cc_hiddenzones") != "finished") && (get_property("cc_hiddenzones").to_int() < 5))
		{
			set_property("cc_hiddenzones", 5);
		}
	}
	if((get_property("questL11Doctor") == "finished") && (get_property("cc_hiddenhospital") != "finished"))
	{
		print("Found completed Hidden Hopickle (11)");
		set_property("cc_hiddenhospital", "finished");
		if((get_property("cc_hiddenzones") != "finished") && (get_property("cc_hiddenzones").to_int() < 4))
		{
			set_property("cc_hiddenzones", 4);
		}
	}
	if((get_property("questL11Worship") == "finished") && (get_property("cc_hiddencity") != "finished"))
	{
		print("Found completed Hidden City (11)");
		set_property("cc_hiddencity", "finished");
		set_property("cc_hiddenzones", "finished");
		set_property("cc_hiddenunlock", "finished");
	}
	if((internalQuestStatus("questL11Worship") >= 3) && (get_property("cc_hiddenunlock") != "finished"))
	{
		print("Found completed unlocked Hidden City (11)");
		set_property("cc_hiddenunlock", "finished");
	}

	if(get_property("sidequestArenaCompleted") != "none")
	{
		if(get_property("flyeredML").to_int() < 10000)
		{
			print("Found completed Island War Arena but flyeredML does not match (12)");
			set_property("flyeredML", 10000);
		}
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
	}

	if((get_property("sidequestLighthouseCompleted") != "none") && (get_property("cc_sonofa") != "finished"))
	{
		print("Found completed Lighthouse (12)");
		set_property("cc_sonofa", "finished");
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

	if((internalQuestStatus("questL12War") >= 1)  && (get_property("cc_prewar") != "started"))
	{
		print("Found Started Island War (12)");
		set_property("cc_prewar", "started");
	}

	if((internalQuestStatus("questL12War") >= 2)  && (get_property("cc_war") != "finished"))
	{
		print("Found completed Island War (12)");
		set_property("cc_war", "finished");
	}

	if((internalQuestStatus("questL13Final") >= 12) && (get_property("cc_sorceress") != "finished"))
	{
		print("Found completed Prism Recovery (13)");
		set_property("cc_sorceress", "finished");
		if(my_class() == $class[Ed])
		{
			council();
		}
	}

	if(internalQuestStatus("questM12Pirate") >= 0)
	{
		if(get_property("cc_pirateoutfit") == "")
		{
			print("Pirate Quest already started but we don't know that, fixing...");
			set_property("cc_pirateoutfit", "insults");
		}
	}

	if(internalQuestStatus("questM12Pirate") >= 3)
	{
		if((get_property("cc_pirateoutfit") == "insults") || (get_property("cc_pirateoutfit") == "blueprint"))
		{
			print("Pirate Quest got enough insults and did the blueprint, fixing...");
			set_property("cc_pirateoutfit", "almost");
		}
	}

	if(internalQuestStatus("questM12Pirate") >= 5)
	{
		if(get_property("cc_pirateoutfit") != "finished")
		{
			print("Completed Beer Pong but we were not aware, fixing...");
			set_property("cc_pirateoutfit", "finished");
		}
	}

	if(possessEquipment($item[Pirate Fledges]) || (internalQuestStatus("questM12Pirate") >= 6))
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

	if(internalQuestStatus("questM12Pirate") >= 7)
	{
		if(get_property("cc_gaudy") == "")
		{
			print("Completed Swordfish but Gaudy Pirate were not observed, fixing...");
			set_property("cc_gaudy", "start");
		}
	}

	if(possessEquipment($item[Talisman o\' Namsilat]))
	{
		if(get_property("cc_gaudy") != "finished")
		{
			print("Have Talisman o' Namsilat but incomplete Gaudy Pirates, fixing...");
			set_property("cc_gaudy", "finished");
		}
	}

	if((get_property("lastQuartetAscension").to_int() >= my_ascensions()) && (get_property("cc_ballroomsong") != "finished"))
	{
		print("Found Ballroom Quarter Song set (X).");
		set_property("cc_ballroomsong", "finished");
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
	int progress = 1;
	if(possessEquipment($item[UV-resistant compass]))
	{
		desertBuff = $item[UV-resistant compass];
		progress = 2;
	}
	if(possessEquipment($item[Ornate Dowsing Rod]))
	{
		desertBuff = $item[Ornate Dowsing Rod];
		progress = 3;
	}

	if((!possessEquipment(desertBuff)) && (my_class() != $class[Avatar of Boris]))
	{
		if((my_level() >= 12) && !in_hardcore())
		{
			print("Do you actually have a UV-resistant compass? Try 'refresh inv' in the CLI!", "green");
			abort("I can't do the Oasis without an Ornate Dowsing Rod. You can manually get a UV-resistant compass and I'll use that if you really hate me that much.");
		}
		else
		{
			print("Skipping desert, don't have a rod or a compass.");
			set_property("cc_skipDesert", my_turncount());
		}
		return false;
	}


	if((have_effect($effect[Ultrahydrated]) > 0) || (get_property("desertExploration").to_int() == 0))
	{
		print("Searching for the pyramid", "blue");
		if((cc_my_path() == "Heavy Rains") && (item_amount($item[Thor\'s Pliers]) > 0))
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
			buffMaintain($effect[Go Get \'Em, Tiger!], 0, 1, 1);
			buyUpTo(1, $item[Blood of the Wereseal]);
			buffMaintain($effect[Temporary Lycanthropy], 0, 1, 1);
		}

		if((my_mp() > 30) && ((my_hp()*2) < (my_maxhp()*1)))
		{
			useCocoon();
		}

#		if(in_hardcore() && isGuildClass() && (item_amount($item[Worm-Riding Hooks]) > 0) && (get_property("desertExploration").to_int() <= (100 - (5 * progress))) && ((get_property("gnasirProgress").to_int() & 16) != 16))
		if(in_hardcore() && (item_amount($item[Worm-Riding Hooks]) > 0) && (get_property("desertExploration").to_int() <= (100 - (5 * progress))) && ((get_property("gnasirProgress").to_int() & 16) != 16))
		{
			if(item_amount($item[Drum Machine]) > 0)
			{
				print("Found the drums, now we use them!", "blue");
				use(1, $item[Drum Machine]);
			}
			else
			{
				print("Off to find the drums!", "blue");
				ccAdv(1, $location[The Oasis]);
			}
			return true;
		}

		if(((get_property("gnasirProgress").to_int() & 1) != 1))
		{
			int expectedOasisTurns = 8 - $location[The Oasis].turns_spent;
			int equivProgress = expectedOasisTurns * progress;
			int need = 100 - get_property("desertExploration").to_int();
			print("expectedOasis: " + expectedOasisTurns);
			print("equivProgress: " + equivProgress);
			print("need: " + need);
			if((need <= 15) && (15 >= equivProgress) && (item_amount($item[Stone Rose]) == 0))
			{
				print("It seems raisinable to hunt a Stone Rose. Beep", "blue");
				ccAdv(1, $location[The Oasis]);
				return true;
			}
		}

		if((desertBuff != $item[none]) && can_equip(desertBuff))
		{
			equip(desertBuff);
		}
		handleFamiliar("init");
		set_property("choiceAdventure805", 1);
		int need = 100 - get_property("desertExploration").to_int();
		print("Need for desert: " + need, "blue");
		print("Worm riding: " + item_amount($item[worm-riding manual page]), "blue");

		if(!get_property("cc_gnasirUnlocked").to_boolean() && ($location[The Arid\, Extra-Dry Desert].turns_spent > 10))
		{
			print("Did not appear to notice that Gnasir unlocked, assuming so at this point.", "green");
			set_property("cc_gnasirUnlocked", true);
		}


		if(get_property("cc_gnasirUnlocked").to_boolean() && (item_amount($item[Stone Rose]) > 0) && ((get_property("gnasirProgress").to_int() & 1) != 1))
		{
			print("Returning the stone rose", "blue");
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
			{
				cli_execute("refresh inv");
				if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
				{
					abort("Returned stone rose but did not return stone rose.");
				}
				else
				{
					if((get_property("gnasirProgress").to_int() & 1) != 1)
					{
						print("Mafia did not track gnasir Stone Rose (0x1). Fixing.", "red");
						set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 1);
					}
				}
			}
			use(1, $item[desert sightseeing pamphlet]);
			return true;
		}

		if(get_property("cc_gnasirUnlocked").to_boolean() && ((get_property("gnasirProgress").to_int() & 2) != 2))
		{
			if((item_amount($item[Can of Black Paint]) > 0) || (my_meat() >= 1000))
			{
				buyUpTo(1, $item[Can of Black Paint]);
				print("Returning the Can of Black Paint", "blue");
				visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
				visit_url("choice.php?whichchoice=805&option=1&pwd=");
				visit_url("choice.php?whichchoice=805&option=2&pwd=");
				visit_url("choice.php?whichchoice=805&option=1&pwd=");
				if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
				{
					cli_execute("refresh inv");
					if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
					{
						abort("Returned can of black paint but did not return can of black paint.");
					}
					else
					{
						if((get_property("gnasirProgress").to_int() & 2) != 2)
						{
							print("Mafia did not track gnasir Can of Black Paint (0x2). Fixing.", "red");
							set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 2);
						}
					}
				}
				use(1, $item[desert sightseeing pamphlet]);
				return true;
			}
		}

		if(get_property("cc_gnasirUnlocked").to_boolean() && (item_amount($item[Killing Jar]) > 0) && ((get_property("gnasirProgress").to_int() & 4) != 4))
		{
			print("Returning the killing jar", "blue");
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
			{
				cli_execute("refresh inv");
				if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
				{
					abort("Returned killing jar but did not return killing jar.");
				}
				else
				{
					if((get_property("gnasirProgress").to_int() & 4) != 4)
					{
						print("Mafia did not track gnasir Killing Jar (0x4). Fixing.", "red");
						set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 4);
					}
				}
			}
			use(1, $item[desert sightseeing pamphlet]);
			return true;
		}

		if((item_amount($item[Worm-Riding Manual Page]) >= 15) && ((get_property("gnasirProgress").to_int() & 8) != 8))
		{
			print("Returning the worm-riding manual pages", "blue");
			visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			visit_url("choice.php?whichchoice=805&option=2&pwd=");
			visit_url("choice.php?whichchoice=805&option=1&pwd=");
			if(item_amount($item[Worm-Riding Hooks]) == 0)
			{
				abort("We messed up in the Desert, get the Worm-Riding Hooks and use them please.");
			}
			if(item_amount($item[Worm-Riding Manual Page]) >= 15)
			{
				print("Mafia doesn't realize that we've returned the worm-riding manual pages... fixing", "red");
				cli_execute("refresh all");
				if((get_property("gnasirProgress").to_int() & 8) != 8)
				{
					print("Mafia did not track gnasir Worm-Riding Manual Pages (0x8). Fixing.", "red");
					set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 8);
				}
			}
			return true;
		}

		need = 100 - get_property("desertExploration").to_int();
		if((item_amount($item[Worm-Riding Hooks]) > 0) && ((get_property("gnasirProgress").to_int() & 16) != 16))
		{
			pullXWhenHaveY($item[Drum Machine], 1, 0);
			if(item_amount($item[Drum Machine]) > 0)
			{
				print("Drum machine desert time!", "blue");
				use(1, $item[Drum Machine]);
				return true;
			}
		}

		need = 100 - get_property("desertExploration").to_int();
		# If we have done the Worm-Riding Hooks or the Killing jar, don\'t do this.
		if((need <= 15) && ((get_property("gnasirProgress").to_int() & 12) == 0))
		{
			pullXWhenHaveY($item[Killing Jar], 1, 0);
			if(item_amount($item[Killing Jar]) > 0)
			{
				print("Secondary killing jar handler", "blue");
				visit_url("place.php?whichplace=desertbeach&action=db_gnasir");
				visit_url("choice.php?whichchoice=805&option=1&pwd=");
				visit_url("choice.php?whichchoice=805&option=2&pwd=");
				visit_url("choice.php?whichchoice=805&option=1&pwd=");
				if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
				{
					cli_execute("refresh inv");
					if(item_amount($item[Desert Sightseeing Pamphlet]) == 0)
					{
						abort("Returned killing jar (secondard) but did not return killing jar.");
					}
					else
					{
						if((get_property("gnasirProgress").to_int() & 4) != 4)
						{
							print("Mafia did not track gnasir Killing Jar (0x4). Fixing.", "red");
							set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 4);
						}
					}
				}
				use(1, $item[desert sightseeing pamphlet]);
				return true;
			}
		}

		ccAdv(1, $location[The Arid\, Extra-Dry Desert]);
		handleFamiliar("item");

		if(contains_text(get_property("lastEncounter"), "A Sietch in Time"))
		{
			print("We've found the gnome!! Sightseeing pamphlets for everyone!", "green");
			set_property("cc_gnasirUnlocked", true);
		}

		if(contains_text(get_property("lastEncounter"), "He Got His Just Desserts"))
		{
			take_closet(closet_amount($item[Beer Helmet]), $item[Beer Helmet]);
			take_closet(closet_amount($item[Distressed Denim Pants]), $item[Distressed Denim Pants]);
			take_closet(closet_amount($item[Bejeweled Pledge Pin]), $item[Bejeweled Pledge Pin]);
			if(get_property("cc_nunsTrick") != "no")
			{
				set_property("cc_nunsTrick", "got");
				set_property("cc_nunsTrickGland", "start");
			}
		}
	}
	else
	{
		int need = 100 - get_property("desertExploration").to_int();
		print("Getting some ultrahydrated, I suppose. Desert left: " + need, "blue");

		if((need > (5 * progress)) && (item_amount($item[disassembled clover]) > 2) && !get_property("lovebugsUnlocked").to_boolean())
		{
			print("Gonna clover this, yeah, it only saves 2 adventures. So?", "green");
			use(1, $item[Disassembled Clover]);
//			ccAdvBypass("adventure.php?snarfblat=122&confirm=on", $location[The Oasis]);
			backupSetting("cloverProtectActive", false);
			ccAdvBypass("adventure.php?snarfblat=122", $location[The Oasis]);
			restoreSetting("cloverProtectActive");
			if(item_amount($item[Ten-Leaf Clover]) > 0)
			{
				print("Wandering adventure in The Oasis, boo. Gonna have to do this again.");
				use(item_amount($item[Ten-Leaf Clover]), $item[Ten-Leaf Clover]);
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

boolean L11_palindome()
{
	if(get_property("cc_palindome") == "finished")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("cc_swordfish") != "finished")
	{
		return false;
	}

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


	boolean lovemeDone = (item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0) || (internalQuestStatus("questL11Palindome") >= 1);
	if(!lovemeDone && (get_property("palindomeDudesDefeated").to_int() >= 5))
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
		ccCraft("cook", 1, $item[Bird Rib], $item[Lion Oil]);
	}
	if((item_amount($item[Stunt Nuts]) > 0) && (item_amount($item[Wet Stew]) > 0) && (item_amount($item[Wet Stunt Nut Stew]) == 0))
	{
		ccCraft("cook", 1, $item[wet stew], $item[stunt nuts]);
	}

	if((item_amount($item[Wet Stunt Nut Stew]) > 0) && !possessEquipment($item[Mega Gem]))
	{
		visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
	}

	if((total == 0) && !possessEquipment($item[Mega Gem]) && lovemeDone && in_hardcore() && (item_amount($item[Wet Stunt Nut Stew]) == 0) && ((internalQuestStatus("questL11Palindome") >= 3) || isGuildClass()))
	{
		if(item_amount($item[Wet Stunt Nut Stew]) == 0)
		{
			handleFamiliar("item");
			equipBaseline();
			if((item_amount($item[Bird Rib]) == 0) || (item_amount($item[Lion Oil]) == 0))
			{
				if(item_amount($item[white page]) > 0)
				{
					set_property("choiceAdventure940", 1);
					if(item_amount($item[Bird Rib]) > 0)
					{
						set_property("choiceAdventure940", 2);
					}

					if(get_property("lastGuildStoreOpen").to_int() < my_ascensions())
					{
						print("This is probably no longer needed as of r16907. Please remove me", "blue");
						print("Going to pretend we have unlocked the Guild because Mafia will assume we need to do that before going to Whitey's Grove and screw up us. We'll fix it afterwards.", "red");
					}
					backupSetting("lastGuildStoreOpen", my_ascensions());
					string[int] pages;
					pages[0] = "inv_use.php?pwd&which=3&whichitem=7555";
					pages[1] = "choice.php?pwd&whichchoice=940&option=" + get_property("choiceAdventure940");
					if(ccAdvBypass(0, pages, $location[Whitey\'s Grove], "")) {}
					restoreSetting("lastGuildStoreOpen");
					return true;
				}

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
				doHottub();
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
			ccCraft("cook", 1, $item[Bird Rib], $item[Lion Oil]);
		}

		if((item_amount($item[Stunt Nuts]) > 0) && (item_amount($item[Wet Stew]) > 0) && (item_amount($item[Wet Stunt Nut Stew]) == 0))
		{
			ccCraft("cook", 1, $item[wet stew], $item[stunt nuts]);
		}

		if(!possessEquipment($item[Mega Gem]))
		{
			visit_url("place.php?whichplace=palindome&action=pal_mrlabel");
		}

		if(!possessEquipment($item[Mega Gem]))
		{
			print("No mega gem for us. Well, no reason to go further here....", "red");
			return false;
		}
		equip($slot[acc2], $item[Mega Gem]);
		set_property("choiceAdventure131", 1);

		print("War sir is raw!!", "blue");

		string[int] pages;
		pages[0] = "place.php?whichplace=palindome&action=pal_drlabel";
		pages[1] = "choice.php?pwd&whichchoice=131&option=1";
		if(ccAdvBypass(0, pages, $location[Noob Cave], "")) {}

		if(item_amount($item[2268]) == 1)
		{
			set_property("cc_palindome", "finished");
		}
		return true;
	}
	else
	{
		if((my_mp() > 60) || considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		if(internalQuestStatus("questL11Palindome") >= 2)
		{
			print("Palindome failure:", "red");
			print("You probably just need to get a Mega Gem to fix this.", "red");
			abort("We have made too much progress in the Palindome and should not be here.");
		}

		if((have_effect($effect[On The Trail]) > 0) && !($monsters[Bob Racecar, Racecar Bob] contains get_property("olfactedMonster").to_monster()))
		{
			if(item_amount($item[soft green echo eyedrop antidote]) > 0)
			{
				print("Gotta hunt down them Naskar boys.", "blue");
				uneffect($effect[On The Trail]);
			}
		}

		ccAdv(1, $location[Inside the Palindome]);
		if($location[Inside the Palindome].turns_spent > 30)
		{
			abort("It appears that we've spent too many turns in the Palindome. If you run me again, I'll try one more time but many I failed finishing the Palindome");
		}
	}
	return true;
}


boolean L13_towerNSNagamar()
{
	if(!get_property("cc_wandOfNagamar").to_boolean())
	{
		return false;
	}
	if(item_amount($item[Wand of Nagamar]) > 0)
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
		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		if(item_amount($item[Disassembled Clover]) > 0)
		{
			use(1, $item[Disassembled Clover]);
			backupSetting("cloverProtectActive", false);
			if(ccAdvBypass(322, $location[The Castle in the Clouds in the Sky (Basement)]))
			{
				print("Wandering monster interrupt at Castle in the Clouds (Basement)", "red");
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
				restoreSetting("cloverProtectActive");
				return true;
			}
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			restoreSetting("cloverProtectActive");
			cli_execute("make wand of nagamar");
			return true;
		}
		abort("Could not make Wand of Nagamar for some raisin. Make it manually please and thank you.");
		return true;
	}
}

boolean L13_towerNSTransition()
{
	if(get_property("cc_sorceress") == "top")
	{
		set_property("cc_sorceress", "final");
	}
	return false;
}

boolean L13_towerNSFinal()
{
	if(get_property("cc_sorceress") != "final")
	{
		return false;
	}
	if(get_property("cc_wandOfNagamar").to_boolean())
	{
		return false;
	}

	cli_execute("scripts/postcheese.ash");
	if((item_amount($item[Ouija Board\, Ouija Board]) > 0) && (my_class() == $class[Turtle Tamer]))
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


	if(internalQuestStatus("questL13Final") < 12)
	{
		set_property("cc_disableAdventureHandling", "yes");
		ccAdvBypass("place.php?whichplace=nstower&action=ns_10_sorcfight", $location[Noob Cave]);
		if(have_effect($effect[Beaten Up]) > 0)
		{
			print("Sorceress beat us up. Wahhh.", "red");
			set_property("cc_disableAdventureHandling", "no");
			return true;
		}
		if(last_monster() == $monster[Naughty Sorceress])
		{
			ccAdv(1, $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				print("Blobbers Sorceress beat us up. Wahhh.", "red");
				set_property("cc_disableAdventureHandling", "no");
				return true;
			}
			ccAdv(1, $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				print("We got beat up by a sausage....", "red");
				set_property("cc_disableAdventureHandling", "no");
				return true;
			}
			if(get_property("cc_stayInRun").to_boolean())
			{
				set_property("cc_disableAdventureHandling", "no");
				abort("User wanted to stay in run (cc_stayInRun), we are done.");
			}

			if($classes[Avatar of Boris, Avatar of Jarlsberg, Avatar of Sneaky Pete] contains my_class())
			{
				set_property("cc_disableAdventureHandling", "no");
				if(get_property("cc_sorceress") == "finished")
				{
					abort("Freeing the king will result in a path change and we can barely handle The Sleazy Back Alley. Aborting, run the script again after selecting your aftercore path in order for it to clean up.");
				}
				set_property("cc_sorceress", "finished");
				return true;
			}
			visit_url("place.php?whichplace=nstower&action=ns_11_prism");
		}
		set_property("cc_disableAdventureHandling", "no");
	}
	else
	{
		visit_url("place.php?whichplace=nstower&action=ns_11_prism");
	}

	if(get_property("cc_stayInRun").to_boolean())
	{
		abort("User wanted to stay in run (cc_stayInRun), we are done.");
	}


	visit_url("place.php?whichplace=nstower&action=ns_11_prism");
	if(get_property("kingLiberated") == "false")
	{
		abort("Yeah, so, I'm done. You might be stuck at the shadow, or at the final boss, or just with a king in a prism. I don't know and quite frankly, after the last " + my_daycount() + " days, I don't give a damn. That's right, I said it. Bitches.");
	}
	set_property("cc_sorceress", "finished");
	return true;
}


boolean L13_towerNSTower()
{
	if(get_property("cc_sorceress") != "tower")
	{
		return false;
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

		int sources = 0;
		if(item_amount($item[astral shirt]) > 0)
		{
			equip($item[astral shirt]);
		}
		if((my_class() == $class[Turtle Tamer]) && (item_amount($item[Shocked Shell]) > 0))
		{
			equip($slot[shirt], $item[Shocked Shell]);
		}
		if(equipped_item($slot[shirt]) == $item[astral shirt])
		{
			sources = 6;
		}
		else if(have_skill($skill[Belch the Rainbow]))
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
			use_familiar($familiar[Warbear Drone]);
			cli_execute("precheese");
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
		else if(have_familiar($familiar[Sludgepuppy]))
		{
			handleFamiliar($familiar[Sludgepuppy]);
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
		if((item_amount($item[smirking shrunken head]) > 0) && can_equip($item[smirking shrunken head]))
		{
			equip($item[smirking shrunken head]);
			sources = sources + 1;
		}
		else if((item_amount($item[hot plate]) > 0) && can_equip($item[hot plate]))
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
		int sourceNeed = 13;
		if(have_skill($skill[Shell Up]))
		{
			if((have_effect($effect[Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Grand Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Glorious Blessing of the Storm Tortoise]) > 0))
			{
				if(have_skill($skill[Blessing of the War Snapper]) && (my_mp() > (2 * mp_cost($skill[Blessing of the War Snapper]))))
				{
					use_skill(1, $skill[Blessing of the War Snapper]);
				}
			}
			if((have_effect($effect[Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Grand Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Glorious Blessing of the Storm Tortoise]) == 0))
			{
				sourceNeed -= 2;
			}
		}
		if(have_skill($skill[Sauceshell]))
		{
			sourceNeed -= 2;
		}
		if((item_amount($item[beehive]) > 0) || (sources > sourceNeed))
		{
			if(item_amount($item[beehive]) == 0)
			{
				useCocoon();
			}
			ccAdvBypass("place.php?whichplace=nstower&action=ns_05_monster1", $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				set_property("cc_getBeehive", true);
				print("I probably failed the Wall of Skin, I assume that I tried without a beehive. Well, I'm going back to get it.", "red");
			}
			else
			{
				handleFamiliar("item");
				if(item_amount(familiarEquip) > 0)
				{
					equip(familiarEquip);
				}
			}
		}
		else
		{
			set_property("cc_getBeehive", true);
			print("Need a beehive, buzz buzz. Only have " + sources + " damage sources and we want " + sourceNeed, "red");
		}
		return true;
	}


	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_06_monster2"))
	{
		equipBaseline();
		shrugAT();
		buffMaintain($effect[Disco Leer], 0, 1, 1);
		buffMaintain($effect[Polka of Plenty], 0, 1, 1);
		buffMaintain($effect[Cranberry Cordiality], 0, 1, 1);
		buffMaintain($effect[Big Meat Big Prizes], 0, 1, 1);
		buffMaintain($effect[Patent Avarice], 0, 1, 1);
		if((get_property("sidequestArenaCompleted") == "fratboy") && !get_property("concertVisited").to_boolean() && (have_effect($effect[Winklered]) == 0))
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
			ccMaximize("meat drop, -equip snow suit", 1500, 0, false);
		}
		else
		{
			ccMaximize("meat drop, -equip snow suit, switch Hobo Monkey, switch rockin' robin, switch adventurous spelunker, switch Grimstone Golem, switch Fist Turkey, switch Unconscious Collective, switch Golden Monkey, switch Angry Jung Man, switch Leprechaun", 1500, 0, false);
			handleFamiliar(my_familiar());
		}
		if((my_class() == $class[Seal Clubber]) && (item_amount($item[Meat Tenderizer is Murder]) > 0))
		{
			equip($item[Meat Tenderizer is Murder]);
		}

		if(my_mp() >= 20)
		{
			useCocoon();
		}
		else if(my_hp() < (0.9 * my_maxhp()))
		{
			doHottub();
		}
		ccAdvBypass("place.php?whichplace=nstower&action=ns_06_monster2", $location[Noob Cave]);
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_07_monster3"))
	{
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
			if(item_amount($item[Electric Boning Knife]) == 0)
			{
				ccMaximize("myst -equip snow suit", 1500, 0, false);
			}
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
			ccAdvBypass("place.php?whichplace=nstower&action=ns_07_monster3", $location[Noob Cave]);
			if(have_effect($effect[Beaten Up]) > 0)
			{
				print("Could not towerkill Wall of Bones, reverting to Boning Knife", "red");
				doHottub();
				set_property("cc_getBoningKnife", true);
			}
			else
			{
				handleFamiliar("item");
			}
		}
		else if(item_amount($item[electric boning knife]) > 0)
		{
			return ccAdvBypass("place.php?whichplace=nstower&action=ns_07_monster3", $location[Noob Cave]);
		}
		else
		{
			print("Backfarming an Electric Boning Knife", "green");
			set_property("choiceAdventure1026", "2");
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Ground Floor)]);
		}
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_08_monster4"))
	{
		set_property("choiceAdventure1015", "2");
		visit_url("place.php?whichplace=nstower&action=ns_08_monster4");
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
		doHottub();

		ccAdvBypass("place.php?whichplace=nstower&action=ns_09_monster5", $location[Noob Cave]);
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_10_sorcfight"))
	{
		set_property("cc_sorceress", "top");
		return true;
	}

	return false;
}

boolean L13_towerNSHedge()
{
	if(get_property("cc_sorceress") != "hedge")
	{
		return false;
	}
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
		visit_url("choice.php?pwd=&whichchoice=1008&option=2", true);
		visit_url("choice.php?pwd=&whichchoice=1011&option=2", true);
		visit_url("choice.php?pwd=&whichchoice=1013&option=1", true);
	}
	else
	{
		abort("cc_hedge not set properly (slow/fast), assuming manual handling desired");
	}
	return true;
}


boolean L13_towerNSContests()
{
	if(get_property("cc_sorceress") != "start")
	{
		return false;
	}


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
		return true;
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

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_contestbooth"))
	{
		if(get_property("nsContestants1").to_int() == -1)
		{
			if(!get_property("_grimBuff").to_boolean())
			{
				cli_execute("grim init");
			}
			if((get_property("telescopeUpgrades").to_int() > 0) && (!get_property("telescopeLookedHigh").to_boolean()))
			{
				cli_execute("telescope high");
			}
			switch(ns_crowd1())
			{
			case 1:
				while((my_mp() < 160) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
				{
					doRest();
				}
				foreach eff in $effects[Adorable Lookout, Alacri Tea, All Fired Up, Fishy\, Oily, The Glistening, Human-Machine Hybrid, Patent Alacrity, Provocative Perkiness, Sepia Tan, Sugar Rush, Ticking Clock, Well-Swabbed Ear]
				{
					buffMaintain(eff, 0, 1, 1);
				}

				buffMaintain($effect[Cletus\'s Canticle of Celerity], 10, 1, 1);
				buffMaintain($effect[Suspicious Gaze], 10, 1, 1);
				buffMaintain($effect[Springy Fusilli], 10, 1, 1);
				buffMaintain($effect[Walberg\'s Dim Bulb], 5, 1, 1);
				buffMaintain($effect[Song of Slowness], 100, 1, 1);
				buffMaintain($effect[Soulerskates], 0, 1, 1);

				if(get_property("cc_100familiar").to_boolean())
				{
					ccMaximize("init, -equip snow suit", 1500, 0, false);
				}
				else
				{
					ccMaximize("init, -equip snow suit, switch xiblaxian holo-companion, switch oily woim ", 1500, 0, false);
					handleFamiliar(my_familiar());
				}

				cli_execute("precheese");
				break;
			}

			visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
			visit_url("choice.php?pwd=&whichchoice=1003&option=1", true);
			visit_url("main.php");
		}
		if(get_property("nsContestants2").to_int() == -1)
		{
			while((my_mp() < 150) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			switch(ns_crowd2())
			{
			case $stat[moxie]:
				foreach eff in $effects[Busy Bein\' Delicious, Butt-Rock Hair, Funky Coal Patina, Liquidy Smoky, Locks Like the Raven, Lycanthropy\, Eh?, Memories of Puppy Love, Newt Gets In Your Eyes, Notably Lovely, Oiled Skin, Pill Power, Radiating Black Body&trade;, Seriously Mutated,  Spiky Hair, Sugar Rush, Standard Issue Bravery, Superhuman Sarcasm, Tomato Power]
				{
					buffMaintain(eff, 0, 1, 1);
				}

				buffMaintain($effect[The Moxious Madrigal], 10, 1, 1);
				buffMaintain($effect[Disco Smirk], 10, 1, 1);
				buffMaintain($effect[Song of Bravado], 100, 1, 1);
				buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
				ccMaximize("moxie -equip snow suit", 1500, 0, false);
				break;
			case $stat[muscle]:
				foreach eff in $effects[Browbeaten, Extreme Muscle Relaxation, Feroci Tea, Fishy Fortification, Football Eyes, Go Get \'Em\, Tiger!, Human-Human Hybrid, Industrial Strength Starch, Lycanthropy\, Eh?, Marinated, Phorcefullness, Pill Power, Rainy Soul Miasma, Savage Beast Inside, Seriously Mutated, Slightly Larger Than Usual, Standard Issue Bravery, Steroid Boost, Spiky Hair, Sugar Rush, Superheroic, Temporary Lycanthropy, Tomato Power, Truly Gritty, Woad Warrior]
				{
					buffMaintain(eff, 0, 1, 1);
				}

				buffMaintain($effect[Power Ballad of the Arrowsmith], 10, 1, 1);
				buffMaintain($effect[Song of Bravado], 100, 1, 1);
				buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
				ccMaximize("muscle -equip snow suit", 1500, 0, false);
				break;
			case $stat[mysticality]:
				# Gothy may have given us a strange bug during one ascension, removing it for now.
				foreach eff in $effects[Baconstoned, Erudite, Far Out, Glittering Eyelashes, Industrial Strength Starch, Liquidy Smoky, Marinated, Mutated, Mystically Oiled, OMG WTF, Pill Power, Rainy Soul Miasma, Rosewater Mark, Seeing Colors, Slightly Larger Than Usual, Standard Issue Bravery, Sweet\, Nuts, Tomato Power]
				{
					buffMaintain(eff, 0, 1, 1);
				}

				buffMaintain($effect[The Magical Mojomuscular Melody], 10, 1, 1);
				buffMaintain($effect[Song of Bravado], 100, 1, 1);
				buffMaintain($effect[Pasta Oneness], 1, 1, 1);
				buffMaintain($effect[Saucemastery], 1, 1, 1);
				buffMaintain($effect[Stevedave\'s Shanty of Superiority], 30, 1, 1);
				ccMaximize("myst -equip snow suit", 1500, 0, false);
				break;
			}

			visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
			visit_url("choice.php?pwd=&whichchoice=1003&option=2", true);
			visit_url("main.php");
		}
		if(get_property("nsContestants3").to_int() == -1)
		{
			while((my_mp() < 125) && (get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
			}
			buffMaintain($effect[All Glory To the Toad], 0, 1, 1);
			element challenge = ns_crowd3();
			switch(challenge)
			{
			case $element[cold]:
				buffMaintain($effect[Cold Hard Skin], 0, 1, 1);
				buffMaintain($effect[Frostbeard], 15, 1, 1);
				buffMaintain($effect[Icy Glare], 10, 1, 1);
				buffMaintain($effect[Song of the North], 100, 1, 1);
				break;
			case $element[hot]:
				buffMaintain($effect[Flamibili Tea], 0, 1, 1);
				buffMaintain($effect[Flaming Weapon], 0, 1, 1);
				buffMaintain($effect[Human-Demon Hybrid], 0, 1, 1);
				buffMaintain($effect[Lit Up], 0, 1, 1);
				buffMaintain($effect[Fire Inside], 0, 1, 1);
				buffMaintain($effect[Pyromania], 15, 1, 1);
				buffMaintain($effect[Song of Sauce], 100, 1, 1);
				break;
			case $element[sleaze]:
				buffMaintain($effect[Takin\' It Greasy], 15, 1, 1);
				break;
			case $element[stench]:
				buffMaintain($effect[Drenched With Filth], 0, 1, 1);
				buffMaintain($effect[Musky], 0, 1, 1);
				buffMaintain($effect[Stinky Hands], 0, 1, 1);
				buffMaintain($effect[Stinky Weapon], 0, 1, 1);
				buffMaintain($effect[Rotten Memories], 15, 1, 1);
				break;
			case $element[spooky]:
				buffMaintain($effect[Spooky Hands], 0, 1, 1);
				buffMaintain($effect[Spooky Weapon], 0, 1, 1);
				buffMaintain($effect[Dirge of Dreadfulness], 10, 1, 1);
				buffMaintain($effect[Intimidating Mien], 15, 1, 1);
				buffMaintain($effect[Snarl of the Timberwolf], 10, 1, 1);
				break;
			}

			if(challenge != $element[none])
			{
				ccMaximize(challenge + " dmg, " + challenge + " spell dmg -equip snow suit", 1500, 0, false);
			}
			visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
			visit_url("choice.php?pwd=&whichchoice=1003&option=3", true);
			visit_url("main.php");
		}

		set_property("choiceAdventure1003",  4);
		if((get_property("nsContestants1").to_int() == 0) && (get_property("nsContestants2").to_int() == 0) && (get_property("nsContestants3").to_int() == 0))
		{
			visit_url("place.php?whichplace=nstower&action=ns_01_contestbooth");
			visit_url("choice.php?pwd=&whichchoice=1003&option=4", true);
			visit_url("main.php");
			return true;
		}
	}

	handleFamiliar("item");
	equipBaseline();

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd1"))
	{
		ccAdv(1, $location[Fastest Adventurer Contest]);
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd2"))
	{
		location toCompete = $location[none];
		switch(get_property("nsChallenge1"))
		{
		case "Mysticality":	toCompete = $location[Smartest Adventurer Contest];		break;
		case "Moxie":		toCompete = $location[Smoothest Adventurer Contest];	break;
		case "Muscle":		toCompete = $location[Strongest Adventurer Contest];	break;
		}
		if(toCompete == $location[none])
		{
			abort("nsChallenge1 is invalid. This is a severe error.");
		}
		ccAdv(1, toCompete);
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_crowd3"))
	{
		location toCompete = $location[none];
		switch(get_property("nsChallenge2"))
		{
		case "cold":		toCompete = $location[Coldest Adventurer Contest];		break;
		case "hot":			toCompete = $location[Hottest Adventurer Contest];		break;
		case "sleaze":		toCompete = $location[Sleaziest Adventurer Contest];	break;
		case "spooky":		toCompete = $location[Spookiest Adventurer Contest];	break;
		case "stench":		toCompete = $location[Stinkiest Adventurer Contest];	break;
		}
		if(toCompete == $location[none])
		{
			abort("nsChallenge1 is invalid. This is a severe error.");
		}
		ccAdv(1, toCompete);
		return true;
	}
	return false;
}

boolean L13_towerNSEntrance()
{
	if(get_property("cc_sorceress") != "")
	{
		return false;
	}

	if(L13_ed_towerHandler())
	{
		return true;
	}

	if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_01_contestbooth"))
	{
		set_property("cc_sorceress", "start");
		set_property("choiceAdventure1003", 0);
	}
	else
	{
		if(my_level() < 13)
		{
			print("I seem to need to power level, or something... waaaa.", "red");
			wait(10);
			if((get_property("timesRested").to_int() < total_free_rests()) && chateaumantegna_available())
			{
				doRest();
				cli_execute("scripts/postcheese.ash");
				if(get_property("cc_lastABooCycleFix").to_int() >= 3)
				{
					set_property("cc_lastABooCycleFix", get_property("cc_lastABooCycleFix").to_int()-1);
				}
				return true;
			}

			if(!LX_attemptPowerLevel())
			{
				print("The following error message is probably wrong, you just need to powerlevel to 13 most likely.", "red");
				abort("Need more flyer ML but don't know where to go :(");
			}
			return true;
		}
		else
		{
			#need a wand (or substitute a key lime for food earlier)
			if(my_level() != get_property("cc_powerLevelLastLevel").to_int())
			{
				print("Hmmm, we need to stop being so feisty about quests...", "red");
				set_property("cc_powerLevelLastLevel", my_level());
				return true;
			}
			abort("Some sidequest is not done for some raisin. Some sidequest is missing, or something is missing, or something is not not something. We don't know what to do.");
		}
	}
	return false;
}

boolean L12_lastDitchFlyer()
{
	if(get_property("cc_ignoreFlyer").to_boolean())
	{
		return false;
	}
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("flyeredML").to_int() < 10000)
	{
		return false;
	}
	if(get_property("sidequestArenaCompleted") != "none")
	{
		return false;
	}
	if((item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[Jam Band Flyers]) == 0))
	{
		return false;
	}

	print("Not enough flyer ML but we are ready for the war... uh oh", "blue");
	boolean doHoleInTheSky = false;
	if(item_amount($item[Richard\'s Star Key]) == 0)
	{
		if((item_amount($item[Star Chart]) == 0) || (item_amount($item[Star]) < 8) || (item_amount($item[Line]) < 7))
		{
			doHoleInTheSky = true;
		}
	}
	if(contains_text(get_property("nsTowerDoorKeysUsed"),"star key"))
	{
		doHoleInTheSky = false;
	}

	if(doHoleInTheSky)
	{
		if(item_amount($item[Steam-Powered Model Rocketship]) == 0)
		{
			set_property("choiceAdventure677", "2");
			set_property("choiceAdventure678", "3");
			handleFamiliar("init");
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
			handleFamiliar("item");
		}
		else
		{
			if((item_amount($item[star]) < 8) || (item_amount($item[line]) < 7))
			{
				handleFamiliar("item");
			}
			ccAdv(1, $location[The Hole in the Sky]);
		}
		return true;
	}
	else
	{
		print("Should not have so little flyer ML at this point", "red");
		wait(1);
		if(!LX_attemptPowerLevel())
		{
			abort("Need more flyer ML but don't know where to go :(");
		}
		return true;
	}
}

boolean LX_attemptPowerLevel()
{
	if(get_property("cc_powerLevelLastLevel").to_int() != my_level())
	{
		print("I might have to powerlevel... let's consider the possibilities...", "red");
		set_property("cc_powerLevelLastLevel", my_level());
		return true;
	}
	set_property("cc_powerLevelAdvCount", get_property("cc_powerLevelAdvCount").to_int() + 1);
	set_property("cc_powerLevelLastAttempted", my_turncount());

	handleFamiliar("stat");
	if(cc_my_path() == "The Source")
	{
		if(get_property("cc_spookyravensecond") != "")
		{
			if(get_property("barrelShrineUnlocked").to_boolean())
			{
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
				if(item_amount($item[Disassembled Clover]) == 0)
				{
					handleBarrelFullOfBarrels();
					string temp = visit_url("barrel.php");
					temp = visit_url("choice.php?whichchoice=1099&pwd=&option=2");
					handleBarrelFullOfBarrels();
					return true;
				}
				stat myStat = my_primestat();
				if(my_basestat(myStat) >= 148)
				{
					return false;
#					if(my_basestat($stat[Muscle]) < my_basestat(myStat))
#					{
#						myStat = $stat[Muscle];
#					}
#					if(my_basestat($stat[Mysticality]) < my_basestat(myStat))
#					{
#						myStat = $stat[Mysticality];
#					}
#					if(my_basestat($stat[Moxie]) < my_basestat(myStat))
#					{
#						myStat = $stat[Moxie];
#					}
				}
				else if(my_basestat(myStat) >= 125)
				{
					//Should probably prefer to check what equipment failures we may be having.
					if((my_basestat($stat[Muscle]) < my_basestat(myStat)) && (my_basestat($stat[Muscle]) < 70))
					{
						myStat = $stat[Muscle];
					}
					if((my_basestat($stat[Mysticality]) < my_basestat(myStat)) && (my_basestat($stat[Mysticality]) < 70))
					{
						myStat = $stat[Mysticality];
					}
					if((my_basestat($stat[Moxie]) < my_basestat(myStat)) && (my_basestat($stat[Moxie]) < 70))
					{
						myStat = $stat[Moxie];
					}
				}
				//Else, default to mainstat.

				//Determine where to go for clover stats, do not worry about clover failures
				use(1, $item[Disassembled Clover]);
				location whereTo = $location[none];
				switch(myStat)
				{
				case $stat[Muscle]:			whereTo = $location[The Haunted Gallery];				break;
				case $stat[Mysticality]:	whereTo = $location[The Haunted Bathroom];				break;
				case $stat[Moxie]:			whereTo = $location[The Haunted Ballroom];				break;
				}

				if((whereTo == $location[The Haunted Ballroom]) && (get_property("cc_ballroomopen") != "open"))
				{
					use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
					LX_spookyBedroomCombat();
					return true;
				}
				backupSetting("cloverProtectActive", false);
				ccAdv(1, whereTo);
				restoreSetting("cloverProtectActive");
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
				return true;
			}
			//Banish mahogant, elegant after gown only. (Harold\'s Bell?)
			LX_spookyBedroomCombat();
			return true;
		}
	}

	if(elementalPlanes_access($element[stench]) && have_skill($skill[Summon Smithsness]))
	{
		ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
	}
	else if(elementalPlanes_access($element[spooky]))
	{
		ccAdv(1, $location[The Deep Dark Jungle]);
	}
	else if(elementalPlanes_access($element[cold]))
	{
		ccAdv(1, $location[VYKEA]);
	}
	else if((elementalPlanes_access($element[sleaze])) && (my_level() < 11))
	{
		ccAdv(1, $location[Sloppy Seconds Diner]);
	}
	else if(elementalPlanes_access($element[stench]))
	{
		ccAdv(1, $location[Uncle Gator\'s Country Fun-Time Liquid Waste Sluice]);
	}
	else if(elementalPlanes_access($element[sleaze]))
	{
		ccAdv(1, $location[Sloppy Seconds Diner]);
	}
	else
	{
		return false;
	}
	return true;
}

boolean L11_hiddenCity()
{
	if(get_property("cc_hiddencity") == "finished")
	{
		return false;
	}

	if(get_property("cc_hiddenzones") != "finished")
	{
		return false;
	}

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


	if((item_amount($item[Moss-Covered Stone Sphere]) == 0) && (get_property("cc_hiddenapartment") != "finished"))
	{
		if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
		{
			return false;
		}
		if((my_adventures() < (9 - get_property("cc_hiddenapartment").to_int())))
		{
			return false;
		}
	}

	if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
	{
		use(1, $item[Book of Matches]);
	}

	if(get_property("cc_hiddenzones") == "finished")
	{
		if((get_property("_nanorhinoBanishedMonster") == "") && (have_effect($effect[nanobrawny]) == 0) && have_familiar($familiar[Nanorhino]))
		{
			handleFamiliar($familiar[Nanorhino]);
		}
		else
		{
			handleFamiliar("item");
		}

		if((get_property("cc_hiddenapartment") == "finished") || (item_amount($item[Moss-Covered Stone Sphere]) > 0))
		{
			set_property("cc_hiddenapartment", "finished");
			if(have_effect($effect[Thrice-Cursed]) > 0)
			{
				print("Ewww, time to wash off this pygmy stench.", "blue");
				doHottub();
			}
			if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") == $monster[Pygmy Shaman]))
			{
				if(item_amount($item[soft green echo eyedrop antidote]) > 0)
				{
					print("They stink so much!", "blue");
					uneffect($effect[On The Trail]);
				}
			}
		}
		if((get_property("cc_hiddenoffice") == "finished") || (item_amount($item[Crackling Stone Sphere]) > 0))
		{
			set_property("cc_hiddenoffice", "finished");
			if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") == $monster[Pygmy Witch Accountant]))
			{
				if(item_amount($item[soft green echo eyedrop antidote]) > 0)
				{
					print("No more accountants to hunt!", "blue");
					uneffect($effect[On The Trail]);
				}
			}
		}
		if((get_property("cc_hiddenbowling") == "finished") || (item_amount($item[Scorched Stone Sphere]) > 0))
		{
			set_property("cc_hiddenbowling", "finished");
			if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") == $monster[Pygmy Bowler]))
			{
				if(item_amount($item[soft green echo eyedrop antidote]) > 0)
				{
					print("No more stinky bowling shoes to worry about!", "blue");
					uneffect($effect[On The Trail]);
				}
			}
		}

		if((get_property("cc_hiddenapartment") != "finished"))
		{
			print("The idden [sic] apartment!", "blue");
			int current = get_property("cc_hiddenapartment").to_int() + 1;
			set_property("cc_hiddenapartment", current);
			if(current <= 8)
			{
				print("Hidden Apartment Progress: " + get_property("hiddenApartmentProgress"), "blue");
				ccAdv(1, $location[The Hidden Apartment Building]);
				if(lastAdventureSpecialNC())
				{
					set_property("cc_hiddenapartment", current - 1);
				}
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
							buyUpTo(1, $item[Cursed Punch]);
							if(item_amount($item[Cursed Punch]) == 0)
							{
								abort("Could not acquire Cursed Punch, unable to deal with Hidden Apartment Properly");
							}
							if(my_mp() > 50)
							{
								shrugAT();
								buffMaintain($effect[Ode to Booze], 50, 1, 1);
							}

							ccDrink(1, $item[Cursed Punch]);
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
			if(considerGrimstoneGolem(true))
			{
				handleBjornify($familiar[Grimstone Golem]);
			}

			backupSetting("autoCraft", false);
#			if(get_property("cc_autoCraft") == "")
#			{
#				set_property("cc_autoCraft", get_property("autoCraft").to_boolean());
#			}
#			set_property("autoCraft", false);

			ccAdv(1, $location[The Hidden Office Building]);

			if((item_amount($item[Boring Binder Clip]) == 1) && (item_amount($item[McClusky File (Page 5)]) == 1))
			{
				#cli_execute("make mcclusky file (complete)");
				visit_url("inv_use.php?pwd=&which=3&whichitem=6694");
				cli_execute("refresh inv");
			}
			restoreSetting("autoCraft");
#			if(get_property("cc_autoCraft") != "")
#			{
#				set_property("autoCraft", get_property("cc_autoCraft").to_boolean());
#				set_property("cc_autoCraft", "");
#			}

#			if(item_amount($item[McClusky File (Complete)]) == 1)
#			{
#				print("If we abort saying that a boring binder clip doesn't make anything interesting.", "red");
#				print("Just run me again, we are trying to work with that...", "red");
#			}

			return true;
		}

		if(get_property("cc_hiddenbowling") != "finished")
		{
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
				if(cc_my_path() == "One Crazy Random Summer")
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
			if((item_amount($item[half-size scalpel]) > 0) && can_equip($item[half-size scalpel]))
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
			if((my_mp() > 60) || considerGrimstoneGolem(true))
			{
				handleBjornify($familiar[Grimstone Golem]);
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
				handleFamiliar("init");
				string[int] pages;
				pages[0] = "adventure.php?snarfblat=350";
				pages[1] = "choice.php?pwd&whichchoice=791&option=1";
				if(ccAdvBypass(0, pages, $location[A Massive Ziggurat], "")) {}
				handleFamiliar("item");
			}
			finally
			{
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
	return false;
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
		if(possessEquipment($item[Antique Machete]) || (my_class() == $class[Avatar of Boris]))
		{
			set_property("cc_hiddenzones", "1");
		}
	}

	if(get_property("cc_hiddenzones") == "0")
	{
		if((possessEquipment($item[antique machete])) || (my_class() == $class[Avatar of Boris]))
		{
			set_property("cc_hiddenzones", "1");
		}
		else
		{
			if((my_mp() > 60) || considerGrimstoneGolem(true))
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
		if(internalQuestStatus("questL11Curses") >= 0)
		{
			set_property("cc_hiddenzones", "2");
			return true;
		}
		if(can_equip($item[Antique Machete]))
		{
			equip($item[antique machete]);
		}
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
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}

		ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
		if(contains_text(get_property("lastEncounter"), "Earthbound and Down"))
		{
			set_property("cc_hiddenzones", "2");
			set_property("choiceAdventure781", 6);
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "2")
	{
		if(internalQuestStatus("questL11Business") >= 0)
		{
			set_property("cc_hiddenzones", "3");
			return true;
		}
		if(can_equip($item[Antique Machete]))
		{
			equip($item[antique machete]);
		}
		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
		if(contains_text(get_property("lastEncounter"), "Air Apparent"))
		{
			set_property("cc_hiddenzones", "3");
			set_property("choiceAdventure785", 6);
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "3")
	{
		if(internalQuestStatus("questL11Doctor") >= 0)
		{
			set_property("cc_hiddenzones", "4");
			return true;
		}
		if(can_equip($item[Antique Machete]))
		{
			equip($item[antique machete]);
		}

		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
		if(contains_text(get_property("lastEncounter"), "Water You Dune"))
		{
			set_property("cc_hiddenzones", "4");
			set_property("choiceAdventure783", 6);
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "4")
	{
		if(internalQuestStatus("questL11Spare") >= 0)
		{
			set_property("cc_hiddenzones", "5");
			return true;
		}
		if(can_equip($item[Antique Machete]))
		{
			equip($item[antique machete]);
		}

		if((dreamJarDrops() < 1) && have_familiar($familiar[Unconscious Collective]))
		{
			handleFamiliar($familiar[Unconscious Collective]);
		}
		else
		{
			handleFamiliar($familiar[Fist Turkey]);
		}
		handleBjornify($familiar[Grinning Turtle]);
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
		if(contains_text(get_property("lastEncounter"), "Fire When Ready"))
		{
			set_property("cc_hiddenzones", "5");
			set_property("choiceAdventure787", 6);
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "5")
	{
		if(can_equip($item[Antique Machete]))
		{
			equip($item[antique machete]);
		}

		handleFamiliar($familiar[Fist Turkey]);
		handleBjornify($familiar[Grinning Turtle]);
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
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
			handleFamiliar("item");
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
	if((item_amount($item[Stone Wool]) == 0) && (have_effect($effect[Stone-Faced]) == 0))
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
		set_property("choiceAdventure579", "0");
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
		#
		#	Is it possible that some other adventure can interrupt us here? If so, we will need to fix that.
		#
		if(contains_text(get_property("lastEncounter"), "Lights Out in the Ballroom"))
		{
			ccAdv(1, $location[The Haunted Ballroom]);
		}
		set_property("choiceAdventure106", "2");
		if($classes[Avatar of Boris, Ed] contains my_class())
		{
			set_property("choiceAdventure106", "3");
		}
		visit_url("place.php?whichplace=manor3&action=manor3_ladys");
		return true;
	}

	if(considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}

	//Convert Spookyraven Spectacles to a toggle
	if((item_amount($item[Lord Spookyraven\'s Spectacles]) == 0) && (my_class() != $class[Avatar of Boris]))
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
		if((item_amount($item[Lord Spookyraven\'s Spectacles]) == 1) || (my_class() == $class[Avatar of Boris]))
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
		if((item_amount($item[Lady Spookyraven\'s Finest Gown]) == 0) && !contains_text(get_counters("Fortune Cookie", 0, 10), "Fortune Cookie"))
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

			handleFamiliar("item");
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

	if(L11_ed_mauriceSpookyraven())
	{
		return true;
	}

	if(item_amount($item[2286]) > 0)
	{
		set_property("cc_ballroom", "finished");
		return true;
	}

	if(get_property("cc_ballroomflat") == "")
	{
		print("Searching for the basement of Spookyraven", "blue");
		set_property("choiceAdventure90", "3");

		if((my_mp() > 60) || considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		buffMaintain($effect[Snow Shoes], 0, 1, 1);

		handleFamiliar("init");
		set_property("choiceAdventure106", "2");
		if($classes[Avatar of Boris, Ed] contains my_class())
		{
			set_property("choiceAdventure106", "3");
		}

		if(!ccAdv(1, $location[The Haunted Ballroom]))
		{
			visit_url("place.php?whichplace=manor2");
			print("If 'That Area is not available', mafia isn't recognizing it without a visit to manor2, not sure why.", "red");
		}
		handleFamiliar("item");
		if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
		{
			set_property("cc_ballroomflat", "finished");
		}
		return true;
	}
	if(item_amount($item[recipe: mortar-dissolving solution]) == 0)
	{
		if(possessEquipment($item[Lord Spookyraven\'s Spectacles]))
		{
			equip($slot[acc3], $item[Lord Spookyraven\'s Spectacles]);
		}
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

	if((get_property("cc_winebomb") == "finished") || get_property("cc_masonryWall").to_boolean())
	{
		print("Down with the tyrant of Spookyraven!", "blue");
		if(my_mp() >= 20)
		{
			useCocoon();
		}
		buffMaintain($effect[Astral Shell], 10, 1, 1);
		buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);


		# The ccAdvBypass case is probably suitable for Ed but we'd need to verify it.
		if(my_class() == $class[Ed])
		{
			visit_url("place.php?whichplace=manor4&action=manor4_chamberboss");
		}
		else
		{
			ccAdvBypass("place.php?whichplace=manor4&action=manor4_chamberboss", $location[Noob Cave]);
		}

		if(have_effect($effect[beaten up]) == 0)
		{
			set_property("cc_ballroom", "finished");
		}
		return true;
	}


	if((!possessEquipment($item[Lord Spookyraven\'s Spectacles])) || (my_class() == $class[Avatar of Boris]))
	{
		# I suppose we can let anyone in without the Spectacles.
		while(item_amount($item[Loosening Powder]) == 0)
		{
			ccAdv($location[The Haunted Kitchen]);
			return true;
		}
		while(item_amount($item[Powdered Castoreum]) == 0)
		{
			ccAdv($location[The Haunted Conservatory]);
			return true;
		}
		while(item_amount($item[Drain Dissolver]) == 0)
		{
			if(get_property("cc_towelChoice") == "")
			{
				set_property("cc_towelChoice", get_property("choiceAdventure882"));
				set_property("choiceAdventure882", 2);
			}
			ccAdv($location[The Haunted Bathroom]);
			if(get_property("cc_towelChoice") != "")
			{
				set_property("choiceAdventure882", get_property("cc_towelChoice"));
				set_property("cc_towelChoice", "");
			}
			return true;
		}
		while(item_amount($item[Triple-Distilled Turpentine]) == 0)
		{
			ccAdv($location[The Haunted Gallery]);
			return true;
		}
		while(item_amount($item[Detartrated Anhydrous Sublicalc]) == 0)
		{
			ccAdv($location[The Haunted Laboratory]);
			return true;
		}
		while(item_amount($item[Triatomaceous Dust]) == 0)
		{
			ccAdv($location[The Haunted Storage Room]);
			return true;
		}

		visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		set_property("cc_masonryWall", true);
		return true;
	}

	if((item_amount($item[blasting soda]) == 1) && (item_amount($item[bottle of Chateau de Vinegar]) == 1))
	{
		print("Time to cook up something explosive! Science fair unstable fulminate time!", "green");
		ovenHandle();
		ccCraft("cook", 1, $item[bottle of Chateau de Vinegar], $item[blasting soda]);
		set_property("cc_winebomb", "partial");
		if(item_amount($item[Unstable Fulminate]) == 0)
		{
			print("We could not make an Unstable Fulminate but we think we have an oven. Do this manually and resume?", "red");
			print("Speculating that get_campground() was incorrect at ascension start...", "red");
			// This issue is valid as of mafia r16799
			set_property("cc_haveoven", false);
			ovenHandle();
			ccCraft("cook", 1, $item[bottle of Chateau de Vinegar], $item[blasting soda]);
			if(item_amount($item[Unstable Fulminate]) == 0)
			{
				abort("Could not make an Unstable Fulminate, make it manually and resume");
			}
		}
	}

	if(get_property("spookyravenRecipeUsed") != "with_glasses")
	{
		abort("Did not read Mortar Recipe with the Spookyraven glasses. We can't proceed.");
	}

	if(possessEquipment($item[Unstable Fulminate]))
	{
		set_property("cc_winebomb", "partial");
	}

	if((item_amount($item[bottle of Chateau de Vinegar]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for vinegar", "blue");
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		ccAdv(1, $location[The Haunted Wine Cellar]);
		return true;
	}
	if((item_amount($item[blasting soda]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for baking soda, I mean, blasting pop.", "blue");
		if(considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
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

		if((cc_my_path() == "Picky") && (item_amount($item[gumshoes]) > 0))
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
			set_property("cc_masonryWall", true);
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
	if((my_adventures() == 0) || (my_level() < 6))
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
	buffMaintain($effect[How to Scam Tourists], 0, 1, 1);
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
		buffMaintain($effect[Unusual Perspective], 0, 1, 1);
		if(get_property("cc_dickstab").to_boolean())
		{
			buffMaintain($effect[Wet and Greedy], 0, 1, 1);
			buffMaintain($effect[Frosty], 0, 1, 1);
		}
		if((item_amount($item[possessed sugar cube]) > 0) && (have_effect($effect[Dance of the Sugar Fairy]) == 0))
		{
			cli_execute("make sugar fairy");
			buffMaintain($effect[Dance of the Sugar Fairy], 0, 1, 1);
		}
		if((have_effect($effect[On The Trail]) > 0) && (get_property("olfactedMonster") != $monster[Tomb Rat]))
		{
			if(item_amount($item[soft green echo eyedrop antidote]) > 0)
			{
				uneffect($effect[On The Trail]);
			}
		}
		handleFamiliar("item");
	}

	ccAdv(1, $location[The Middle Chamber]);
	return true;
}

boolean L11_unlockPyramid()
{
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

	if((item_amount($item[2325]) > 0) || ((item_amount($item[2180]) > 0) && (item_amount($item[2268]) > 0) && (item_amount($item[2286]) > 0)))
	{
		print("Reveal the pyramid", "blue");
#		if(item_amount($item[Staff of Ed]) == 0)
		if(item_amount($item[2325]) == 0)
		{
			if((item_amount($item[2180]) > 0) && (item_amount($item[2286]) > 0))
			{
				ccCraft("combine", 1, $item[2180], $item[2286]);
			}
			if((item_amount($item[Headpiece of the Staff of Ed]) > 0) && (item_amount($item[2268]) > 0))
			{
				ccCraft("combine", 1, $item[headpiece of the staff of ed], $item[2268]);
			}
		}
		if(item_amount($item[2325]) == 0)
		{
			abort("Failed making Staff of Ed (2325) via CLI. Please do it manually and rerun.");
		}

		visit_url("place.php?whichplace=desertbeach&action=db_pyramid1");

		if(get_property("questL11Pyramid") == "unstarted")
		{
			print("No burning Ed's model now!", "blue");
			if((cc_my_path() == "One Crazy Random Summer") && (get_property("desertExploration").to_int() == 100))
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
					abort("Tried to open the Pyramid but could not - exploration at 100?. Something went wrong :(");
				}
				else
				{
					print("Incorrectly had exploration value of 100 however, this was correctable. Trying to resume.", "blue");
					return false;
				}
			}
			if(my_turncount() == get_property("cc_skipDesert").to_int())
			{
				print("Did not have an Arid Desert Item and the Pyramid is next. Must backtrack and recover", "red");
				if((my_adventures() >= 3) && (my_meat() >= 500))
				{
					ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
					if(item_amount($item[Shore Inc. Ship Trip Scrip]) > 0)
					{
						cli_execute("make UV-Resistant Compass");
					}
					if(item_amount($item[UV-Resistant Compass]) == 0)
					{
						abort("Could not acquire a UV-Resistant Compass. Failing.");
					}
				}
				else
				{
					abort("Could not backtrack to handle getting a UV-Resistant Compass");
				}
				return true;
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
	if(cc_my_path() == "Heavy Rains")
	{
		baseML = baseML + 60;
	}
	if(baseML > 150)
	{
		if(equipped_item($slot[acc2]) == $item[Hand In Glove])
		{
			equip($slot[acc2], $item[pirate fledges]);
		}
		uneffect($effect[Ur-kel\'s Aria of Annoyance]);
		if(possessEquipment($item[Beer Helmet]))
		{
			equip($item[beer helmet]);
		}
	}
	print("Time to waste all of Ed's Ka Coins :(", "blue");

	set_property("choiceAdventure976", "1");

	int x = 0;
	set_property("cc_disableAdventureHandling", "yes");
	while(item_amount($item[2334]) == 0)
	{
		x = x + 1;
		print("Hello Ed #" + x + " give me McMuffin please.", "blue");
		ccAdv(1, $location[The Lower Chambers]);
		if(have_effect($effect[Beaten Up]) > 0)
		{
			set_property("cc_disableAdventureHandling", "no");
			abort("Got Beaten Up by Ed the Undying.");
		}
	}
	set_property("cc_disableAdventureHandling", "no");

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
	if(get_property("cc_sonofa") == "finished")
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
	set_property("cc_sonofa", "finished");
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
		ccCraft("smith", 1, $item[lump of Brituminous coal], $item[turtle totem]);
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
#		ccCraft("paste", 1, $item[Ben-Gal&trade; Balm], $item[Handful of Smithereens]);
	}
	set_property("cc_gremlins", "start");
	set_property("cc_gremlinBanishes", "");
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

	handleFamiliar("init");
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
	handleFamiliar("item");
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
	if(get_property("cc_sonofa") == "finished")
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
		set_property("cc_sonofa", "finished");
		return true;
	}

	if(chateaumantegna_havePainting() && !get_property("chateauMonsterFought").to_boolean() && (get_property("chateauMonster") == $monster[Lobsterfrogman]))
	{
		if(chateaumantegna_usePainting())
		{
			handleFamiliar("item");
			return true;
		}
	}

	if(!uneffect($effect[The Sonata of Sneakiness]))
	{
		return false;
	}
	if((my_class() == $class[Ed]) && (item_amount($item[Talisman of Horus]) == 0))
	{
		return false;
	}

	if(!uneffect($effect[Patent Invisibility]))
	{
		print("Could not uneffect Patent Invisibility for Lobsterfrogman, delaying");
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
	buffMaintain($effect[High Colognic], 0, 1, 1);
	buffMaintain($effect[Celestial Saltiness], 0, 1, 1);
	buffMaintain($effect[Everything Must Go!], 0, 1, 1);
	if(have_familiar($familiar[Grim Brother]))
	{
		handleBjornify($familiar[Grim Brother]);
	}
	if((equipped_item($slot[hat]) == $item[Xiblaxian stealth cowl]) && possessEquipment($item[Beer Helmet]))
	{
		equip($item[Beer Helmet]);
	}
	if((have_equipped($item[Xiblaxian Stealth Trousers])) && possessEquipment($item[Distressed Denim Pants]))
	{
		equip($slot[Pants], $item[Distressed Denim Pants]);
	}
	if(equipped_item($slot[acc1]) == $item[over-the-shoulder folder holder])
	{
		if((item_amount($item[Ass-Stompers of Violence]) > 0) && (equipped_item($slot[acc1]) != $item[Ass-Stompers of Violence]))
		{
			equip($slot[acc1], $item[Ass-Stompers of Violence]);
		}
		else
		{
			equip($slot[acc1], $item[bejeweled pledge pin]);
		}
	}
	if(item_amount($item[portable cassette player]) > 0)
	{
		equip($slot[acc2], $item[portable cassette player]);
	}

	buffMaintain($effect[Patent Aggression], 0, 1, 1);
	removeNonCombat();

	handleFamiliar($familiar[Jumpsuited Hound Dog]);

	if(item_amount($item[barrel of gunpowder]) < 4)
	{
		set_property("cc_doCombatCopy", "yes");
	}

	if(numeric_modifier("Combat Rate") <= 9.0)
	{
		if(possessEquipment($item[Carpe]))
		{
			equip($slot[Back], $item[Carpe]);
		}
	}


	//Seriously? http://alliancefromhell.com/viewtopic.php?t=1338
	if(item_amount($item[Wool Hat]) == 1)
	{
		pulverizeThing($item[Wool Hat]);
	}
	if(item_amount($item[Goatskin Umbrella]) == 1)
	{
		pulverizeThing($item[Goatskin Umbrella]);
	}

	buffMaintain($effect[Song of Battle], 10, 1, 1);
	if(numeric_modifier("Combat Rate") < 0.0)
	{
		print("Something is keeping us from getting a suitable combat rate, we have: " + numeric_modifier("Combat Rate") + " and Lobsterfrogmen.", "red");
		return false;
	}

	ccAdv(1, $location[Sonofa Beach]);
	set_property("cc_doCombatCopy", "no");
	handleFamiliar("item");

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
		handleFamiliar("meat");
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
		buffMaintain($effect[Unusual Perspective], 0, 1, 1);

		if(get_property("cc_dickstab").to_boolean())
		{
			buffMaintain($effect[Wet and Greedy], 0, 1, 1);
		}
		buffMaintain($effect[Frosty], 0, 1, 1);
	}

	if((!possessEquipment($item[A Light That Never Goes Out])) && (item_amount($item[Lump of Brituminous Coal]) > 0))
	{
		buyUpTo(1, $item[third-hand lantern]);
		ccCraft("smith", 1, $item[Lump of Brituminous Coal], $item[third-hand lantern]);
	}

	if(possessEquipment($item[A Light That Never Goes Out]))
	{
		if(weapon_hands(equipped_item($slot[weapon])) != 1)
		{
			equip($slot[weapon], $item[none]);
		}
		equip($item[A Light That Never Goes Out]);
	}

	handleFamiliar("item");
	if(item_amount($item[Training Helmet]) > 0)
	{
		equip($slot[hat], $item[Training Helmet]);
	}

	if(have_effect($effect[Filthworm Drone Stench]) > 0)
	{
		if(canYellowRay())
		{
			if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
			{
				handleFamiliar("yellow ray");
			}
		}
		ccAdv(1, $location[The Royal Guard Chamber]);
	}
	else if(have_effect($effect[Filthworm Larva Stench]) > 0)
	{
		ccAdv(1, $location[The Feeding Chamber]);
	}
	else
	{
		ccAdv(1, $location[The Hatching Chamber]);
	}
	handleFamiliar("item");
	return true;
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
	if(!canYellowRay())
	{
		return false;
	}
#	if(have_effect($effect[Everything looks yellow]) != 0)
#	{
#		return false;
#	}
#	if(get_property("cc_100familiar").to_boolean())
#	{
#		return false;
#	}
#	if((my_lightning() < 5) && (cc_my_path() == "Heavy Rains"))
#	{
#		return false;
#	}
	if(!outfit("war hippy fatigues"))
	{
		abort("Could not wear war hippy fatigues, failing");
	}
	if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
	{
		handleFamiliar("yellow ray");
	}
#	if(cc_my_path() != "Heavy Rains")
#	{
#		handleFamiliar($familiar[Crimbo Shrub]);
#		if((my_familiar() == $familiar[Crimbo Shrub]) && !get_property("_shrubDecorated").to_boolean())
#		{
#			visit_url("inv_use.php?pwd=&which=3&whichitem=7958");
#			visit_url("choice.php?pwd=&whichchoice=999&option=1&topper=1&lights=1&garland=1&gift=1");
#		}
#	}
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
#	cli_execute("refresh equip");
	if(my_hp() < my_maxhp())
	{
		print("My hp is: " + my_hp());
		print("My max hp is: " + my_maxhp());
		useCocoon();
	}
	print("Let's fight the boss!", "blue");

	location bossFight = $location[The Battlefield (Frat Uniform)];
	if(get_property("cc_hippyInstead").to_boolean())
	{
		bossFight = $location[The Battlefield (Hippy Uniform)];
	}

#	handlePreAdventure(bossFight);
	handleFamiliar($familiar[Machine Elf]);
	string[int] pages;
	pages[0] = "bigisland.php?place=camp&whichcamp=1";
	pages[1] = "bigisland.php?place=camp&whichcamp=2";
	pages[2] = "bigisland.php?action=bossfight&pwd";
	if(!ccAdvBypass(0, pages, bossFight, ""))
	{
		print("Boss already defeated, ignoring", "red");
	}
#	visit_url("bigisland.php?place=camp&whichcamp=1");
#	visit_url("bigisland.php?place=camp&whichcamp=2");
#	visit_url("bigisland.php?action=bossfight&pwd");
#	if(!ccAdv(1, bossFight))
#	{
#		print("Boss already defeated, ignoring", "red");
#	}
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
	if((get_property("cc_war") != "finished") && (item_amount($item[rock band flyers]) == 0) && (item_amount($item[jam band flyers]) == 0))
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

	handleBjornify($familiar[Grimstone Golem]);
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
	string temp = visit_url("bigisland.php?place=orchard&action=stand&pwd");
	temp = visit_url("bigisland.php?place=orchard&action=stand&pwd");
	return true;
}


boolean L10_plantThatBean()
{
	if((my_level() < 10) || get_property("cc_bean").to_boolean())
	{
		return false;
	}
	council();
	print("Planting me magic bean!", "blue");
	string page = visit_url("place.php?whichplace=plains");
	if(contains_text(page, "place.php?whichplace=beanstalk"))
	{
		print("I have no bean but I see a stalk here. Okies. I'm ok with that", "blue");
		set_property("cc_bean", true);
		visit_url("place.php?whichplace=beanstalk");
		return true;
	}
	use(1, $item[enchanted bean]);
	set_property("cc_bean", true);
	return true;
}

boolean L10_holeInTheSkyUnlock()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castlebasement") != "finished")
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
		return false;
	}
	if(item_amount($item[Richard\'s Star Key]) > 0)
	{
		set_property("cc_holeinthesky", false);
		return false;
	}
	if((item_amount($item[Star Chart]) > 0) && (item_amount($item[Star]) >= 8) && (item_amount($item[Line]) >= 7))
	{
		set_property("cc_holeinthesky", false);
		return false;
	}
	if(contains_text(get_property("nsTowerDoorKeysUsed"),"star key"))
	{
		set_property("cc_holeinthesky", false);
		return false;
	}

	print("Castle Top Floor - Opening the Hole in the Sky", "blue");
	set_property("choiceAdventure677", 2);
	set_property("choiceAdventure675", 4);
	set_property("choiceAdventure678", 3);
	set_property("choiceAdventure676", 4);

	if(have_familiar($familiar[Ms. Puck Man]))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
	}
	else if(have_familiar($familiar[Puck Man]))
	{
		handleFamiliar($familiar[Puck Man]);
	}
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
	handleFamiliar("item");

	return true;
}

boolean L10_topFloor()
{
	if(my_level() < 10)
	{
		return false;
	}

	if(get_property("cc_castleground") != "finished")
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
	if((item_amount($item[Mohawk Wig]) > 0) && can_equip($item[Mohawk Wig]))
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

	handleFamiliar("init");
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
	handleFamiliar("item");

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

	if(get_property("cc_castlebasement") != "finished")
	{
		return false;
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

	if(have_familiar($familiar[Ms. Puck Man]))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
	}
	else if(have_familiar($familiar[Puck Man]))
	{
		handleFamiliar($familiar[Puck Man]);
	}
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Ground Floor)]);
	handleFamiliar("item");

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
	if(my_adventures() < 3)
	{
		return false;
	}
	print("Basement Search", "blue");
	set_property("choiceAdventure670", "5");
	if(item_amount($item[Massive Dumbbell]) > 0)
	{
		set_property("choiceAdventure671", "1");
	}
	else
	{
		set_property("choiceAdventure671", "4");
	}

	if(my_primestat() == $stat[Muscle])
	{
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}
	buyUpTo(1, $item[Hair Spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

	if(possessEquipment($item[Titanium Assault Umbrella]) && can_equip($item[Titanium Assault Umbrella]))
	{
		set_property("choiceAdventure669", "4");
	}
	else
	{
		set_property("choiceAdventure669", "1");
	}

	if(have_familiar($familiar[Ms. Puck Man]))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
	}
	else if(have_familiar($familiar[Puck Man]))
	{
		handleFamiliar($familiar[Puck Man]);
	}
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
	handleFamiliar("item");

	if(contains_text(get_property("lastEncounter"), "Out in the Open Source") && (get_property("choiceAdventure671").to_int() == 1))
	{
		print("Dumbbell + Dumbwaiter means we fly!", "green");
		set_property("cc_castlebasement", "finished");
	}
	else if(contains_text(get_property("lastEncounter"), "The Fast and the Furry-ous"))
	{
		print("We was fast and furry-ous!", "blue");
		equip($item[Titanium Assault Umbrella]);
		set_property("choiceAdventure669", "1");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		if(contains_text(get_property("lastEncounter"), "The Fast and the Furry-ous"))
		{
			set_property("cc_castlebasement", "finished");
		}
		else
		{
			print("Got interrupted trying to unlock the Ground Floor of the Castle", "red");
		}
	}
	else if(contains_text(get_property("lastEncounter"), "You Don\'t Mess Around with Gym"))
	{
		print("Just messed with Gym", "blue");
		if(!can_equip($item[Amulet of Extreme Plot Significance]) || (item_amount($item[Massive Dumbbell]) > 0))
		{
			print("Can't equip an Amulet of Extreme Plot Signifcance...", "red");
			print("I suppose we will try the Massive Dumbbell... Beefcake!", "red");
			if(item_amount($item[Massive Dumbbell]) == 0)
			{
				set_property("choiceAdventure670", "1");
			}
			else
			{
				set_property("choiceAdventure670", "2");
			}
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
			return true;
		}

		set_property("choiceAdventure670", "5");
		if(!possessEquipment($item[Amulet Of Extreme Plot Significance]))
		{
			pullXWhenHaveY($item[Amulet of Extreme Plot Significance], 1, 0);
			if(!possessEquipment($item[Amulet of Extreme Plot Significance]))
			{
				if($location[The Penultimate Fantasy Airship].turns_spent >= 45)
				{
					print("Well, we don't seem to be able to find an Amulet...", "red");
					print("I suppose we will get the Massive Dumbbell... Beefcake!", "red");
					if(item_amount($item[Massive Dumbbell]) == 0)
					{
						set_property("choiceAdventure670", "1");
					}
					else
					{
						set_property("choiceAdventure670", "2");
					}
					ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
				}
				else
				{
					if(canYellowRay())
					{
						if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
						{
							handleFamiliar("yellow ray");
						}
					}
					print("Backfarming an Amulet of Extreme Plot Significance, sigh :(", "blue");
					ccAdv(1, $location[The Penultimate Fantasy Airship]);
				}
				return true;
			}
		}
		equip($slot[acc3], $item[Amulet Of Extreme Plot Significance]);
		set_property("choiceAdventure670", "4");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		if(contains_text(get_property("lastEncounter"), "You Don\'t Mess Around with Gym"))
		{
			set_property("cc_castlebasement", "finished");
		}
		else
		{
			print("Got interrupted trying to unlock the Ground Floor of the Castle", "red");
		}
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
	if((my_mp() > 60) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}

	if(item_amount($item[Model Airship]) == 0)
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


	if(!possessEquipment($item[Mohawk Wig]) && canYellowRay())
	{
		if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
		{
			handleFamiliar("yellow ray");
		}
	}

	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
	buffMaintain($effect[Snow Shoes], 0, 1, 1);
	buffMaintain($effect[Fishy\, Oily], 0, 1, 1);

	ccAdv(1, $location[The Penultimate Fantasy Airship]);
	handleFamiliar("item");
	return true;
}

boolean L12_flyerBackup()
{
	if(get_property("cc_prewar") != "started")
	{
		return false;
	}
	if(get_property("flyeredML").to_int() >= 10000)
	{
		return false;
	}
	if((item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[Jam Band Flyers]) == 0))
	{
		return false;
	}
	if(get_property("choiceAdventure1003").to_int() >= 3)
	{
		return false;
	}

	return LX_freeCombats();
}

boolean LX_freeCombats()
{
	if(my_inebriety() > inebriety_limit())
	{
		return false;
	}

	if(snojoFightAvailable() && (my_adventures() > 0))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
		ccAdv(1, $location[The X-32-F Combat Training Snowman]);
		handleFamiliar("item");
		return true;
	}

	if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_adventures() > 0) && !get_property("cc_100familiar").to_boolean())
	{
		if(get_property("cc_choice1119") != "")
		{
			set_property("choiceAdventure1119", get_property("cc_choice1119"));
		}
		set_property("cc_choice1119", get_property("choiceAdventure1119"));
		set_property("choiceAdventure1119", 1);


		familiar bjorn = my_bjorned_familiar();
		if(bjorn == $familiar[Machine Elf])
		{
			handleBjornify($familiar[Grinning Turtle]);
		}
		handleFamiliar($familiar[Machine Elf]);
		ccAdv(1, $location[The Deep Machine Tunnels]);
		if(bjorn == $familiar[Machine Elf])
		{
			handleBjornify(bjorn);
		}

		set_property("choiceAdventure1119", get_property("cc_choice1119"));
		set_property("cc_choice1119", "");
		handleFamiliar("item");
		return true;
	}
	return false;
}


boolean Lx_resolveSixthDMT()
{
	if(have_familiar($familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_adventures() > 10) && !get_property("cc_100familiar").to_boolean() && ($location[The Deep Machine Tunnels].turns_spent == 5) && (my_daycount() == 2))
	{
		if(get_property("cc_choice1119") != "")
		{
			set_property("choiceAdventure1119", get_property("cc_choice1119"));
		}
		set_property("cc_choice1119", get_property("choiceAdventure1119"));
		set_property("choiceAdventure1119", 1);


		familiar bjorn = my_bjorned_familiar();
		if(bjorn == $familiar[Machine Elf])
		{
			handleBjornify($familiar[Grinning Turtle]);
		}
		handleFamiliar($familiar[Machine Elf]);
		ccAdv(1, $location[The Deep Machine Tunnels]);
		if(bjorn == $familiar[Machine Elf])
		{
			handleBjornify(bjorn);
		}

		set_property("choiceAdventure1119", get_property("cc_choice1119"));
		set_property("cc_choice1119", "");
		handleFamiliar("item");
		return true;
	}
	return false;
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
	if(get_property("flyeredML").to_int() >= 10000)
	{
		return false;
	}
	if((item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[Jam Band Flyers]) == 0))
	{
		return false;
	}
	if(get_property("choiceAdventure1003").to_int() >= 3)
	{
		return false;
	}

	if((get_property("_sealsSummoned").to_int() < maxSealSummons()) && (my_meat() > 500))
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

		handleFamiliar("init");
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
		if((item_amount($item[bad-ass club]) == 0) && (item_amount($item[ingot of seal-iron]) > 0) && have_skill($skill[Super-Advanced Meatsmithing]))
		{
			use(1, $item[ingot of seal-iron]);
		}
		handleFamiliar("item");
		return true;
	}
	return false;
}

boolean LX_dolphinKingMap()
{
	if(item_amount($item[Dolphin King\'s Map]) > 0)
	{
		if(possessEquipment($item[Snorkel]) || (my_meat() >= npc_price($item[Snorkel])))
		{
			buyUpTo(1, $item[Snorkel]);
			item oldHat = equipped_item($slot[hat]);
			equip($item[Snorkel]);
			use(1, $item[Dolphin King\'s Map]);
			equip(oldHat);
			return true;
		}
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
		handleCopiedMonster($item[Rain-Doh Box Full of Monster]);
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
		handleCopiedMonster($item[Rain-Doh Box Full of Monster]);
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
		if(have_skill($skill[Rain Man]) && (item_amount($item[barrel of gunpowder]) < 4))
		{
			set_property("cc_doCombatCopy", "yes");
		}
		handleCopiedMonster($item[Rain-Doh Box Full of Monster]);
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
		handleCopiedMonster($item[Rain-Doh Box Full of Monster]);
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
		handleCopiedMonster($item[Rain-Doh Box Full of Monster]);
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
	if(possessEquipment($item[Ornate Dowsing Rod]))
	{
		print("Hey, we have the dowsing rod already, yippie!", "blue");
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

	if(my_mp() > 60)
	{
		handleBjornify($familiar[Grimstone Golem]);
	}

	buffMaintain($effect[Browbeaten], 0, 1, 1);
	buffMaintain($effect[Rosewater Mark], 0, 1, 1);

	boolean edAlcove = true;
	if(my_class() == $class[Ed])
	{
		edAlcove = have_skill($skill[More Legs]);
	}

	if((get_property("romanticTarget") != $monster[modern zmobie]) && (get_property("cc_waitingArrowAlcove").to_int() < 50))
	{
		set_property("cc_waitingArrowAlcove", 50);
	}

	if((get_property("cyrptAlcoveEvilness").to_int() > 0) && ((get_property("cyrptAlcoveEvilness").to_int() <= get_property("cc_waitingArrowAlcove").to_int()) || (get_property("cyrptAlcoveEvilness").to_int() <= 25)) && edAlcove)
	{
		handleFamiliar("init");

		if((get_property("_badlyRomanticArrows").to_int() == 0) && have_familiar($familiar[Reanimated Reanimator]) && (my_daycount() == 1))
		{
			handleFamiliar($familiar[Reanimated Reanimator]);
		}

		buffMaintain($effect[Sepia Tan], 0, 1, 1);
		buffMaintain($effect[Walberg\'s Dim Bulb], 5, 1, 1);
		buffMaintain($effect[Springy Fusilli], 10, 1, 1);
		buffMaintain($effect[Patent Alacrity], 0, 1, 1);
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
		handleFamiliar("item");
		return true;
	}

	if(get_property("cyrptNookEvilness").to_int() > 0)
	{
		print("The Nook!", "blue");
		buffMaintain($effect[Joyful Resolve], 0, 1, 1);
		ccAdv(1, $location[The Defiled Nook]);
		if(item_amount($item[evil eye]) > 0)
		{
			use(item_amount($item[evil eye]), $item[evil eye]);
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

		handleFamiliar("item");
		return true;
	}

	if(get_property("cyrptCrannyEvilness").to_int() > 0)
	{
		print("The Cranny!", "blue");
		set_property("choiceAdventure523", "4");

		if(my_mp() > 60)
		{
			handleBjornify($familiar[Grimstone Golem]);
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
		handleFamiliar($familiar[Machine Elf]);
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
	if((my_mp() > 50) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}

#	if((my_daycount() == 1) && (get_property("_hipsterAdv").to_int() < 7) && (item_amount($item[hot wing]) >= 3) && is_unrestricted($familiar[Artistic Goth Kid]))
#	{
#		handleFamiliar($familiar[Artistic Goth Kid]);
#	}
	buffMaintain($effect[Snow Shoes], 0, 1, 1);

	if(item_amount($item[box of birthday candles]) == 0)
	{
		print("Getting Box of Birthday Candles", "blue");
		ccAdv(1, $location[The Dark Heart of the Woods]);
		handleFamiliar("item");
		return true;
	}

	if(item_amount($item[dodecagram]) == 0)
	{
		print("Getting Dodecagram", "blue");
		ccAdv(1, $location[The Dark Neck of the Woods]);
		handleFamiliar("item");
		return true;
	}
	if(item_amount($item[eldritch butterknife]) == 0)
	{
		print("Getting Eldritch Butterknife", "blue");
		ccAdv(1, $location[The Dark Elbow of the Woods]);
		handleFamiliar("item");
		return true;
	}
	handleFamiliar("item");
	print("Finishing friars", "blue");
	visit_url("friars.php?action=ritual&pwd");
	council();
	set_property("cc_friars", "done");
	return true;
}

boolean LX_steelOrgan()
{
	if(!get_property("cc_getSteelOrgan").to_boolean())
	{
		return false;
	}
	if((get_property("cc_friars") != "done") && (get_property("cc_friars") != "finished"))
	{
		return false;
	}
	if(my_class() == $class[Ed])
	{
		print("Ed can not get a Steel Organ, turning off setting.", "blue");
		set_property("cc_getSteelOrgan", false);
		return false;
	}

	if(my_path() == "Avatar of West of Loathing")
	{
		if((get_property("awolPointsCowpuncher").to_int() < 7) || (get_property("awolPointsBeanslinger").to_int() < 1) || (get_property("awolPointsSnakeoiler").to_int() < 5))
		{
			set_property("cc_getSteelOrgan", false);
			return false;
		}
	}

	if(have_skill($skill[Liver of Steel]) || have_skill($skill[Stomach of Steel]) || have_skill($skill[Spleen of Steel]))
	{
		print("We have a steel organ, turning off the setting." ,"blue");
		set_property("cc_getSteelOrgan", false);
		return false;
	}
	print("I am hungry for some steel.", "blue");
	if(get_property("questM10Azazel") == "unstarted")
	{
		string temp = visit_url("pandamonium.php");
		temp = visit_url("pandamonium.php?action=moan");
		temp = visit_url("pandamonium.php?action=infe");
		temp = visit_url("pandamonium.php?action=sven");
		temp = visit_url("pandamonium.php?action=sven");
		temp = visit_url("pandamonium.php?action=beli");
		temp = visit_url("pandamonium.php?action=mourn");
	}
	if(get_property("questM10Azazel") == "started")
	{
		if(((item_amount($item[Observational Glasses]) == 0) || (item_amount($item[Imp Air]) < 5)) && (item_amount($item[Azazel\'s Tutu]) == 0))
		{
			if(item_amount($item[Observational Glasses]) == 0)
			{
				uneffect($effect[The Sonata of Sneakiness]);
				buffMaintain($effect[Hippy Stench], 0, 1, 1);
				buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 10, 1, 1);
				buffMaintain($effect[Musk of the Moose], 10, 1, 1);
				# Should we check for -NC stuff and deal with it?
				# We need a Combat Modifier controller
			}
			if(item_amount($item[Imp Air]) >= 5)
			{
				handleFamiliar($familiar[Jumpsuited Hound Dog]);
			}
			else
			{
				handleFamiliar("item");
			}
			ccAdv(1, $location[The Laugh Floor]);
		}
		else if(((item_amount($item[Azazel\'s Unicorn]) == 0) || (item_amount($item[Bus Pass]) < 5)) && (item_amount($item[Azazel\'s Tutu]) == 0))
		{
			int jim = 0;
			int flargwurm = 0;
			int bognort = 0;
			int stinkface = 0;
			int need = 4;
			if(item_amount($item[Comfy Pillow]) > 0)
			{
				jim = to_int($item[Comfy Pillow]);
				need -= 1;
			}
			if(item_amount($item[Booze-Soaked Cherry]) > 0)
			{
				flargwurm = to_int($item[Booze-Soaked Cherry]);
				need -= 1;
			}
			if(item_amount($item[Giant Marshmallow]) > 0)
			{
				bognort = to_int($item[Giant Marshmallow]);
				need -= 1;
			}
			if(item_amount($item[Beer-Scented Teddy Bear]) > 0)
			{
				stinkface = to_int($item[Beer-Scented Teddy Bear]);
				need -= 1;
			}
			if(need > 0)
			{
				int cake = item_amount($item[Sponge Cake]);
				if((jim == 0) && (cake > 0))
				{
					jim = to_int($item[Sponge Cake]);
					need -= 1;
					cake -= 1;
				}
				if((flargwurm == 0) && (cake > 0))
				{
					flargwurm = to_int($item[Sponge Cake]);
					need -= 1;
					cake -= 1;
				}
				int paper = item_amount($item[Gin-Soaked Blotter Paper]);
				if((bognort == 0) && (paper > 0))
				{
					bognort = to_int($item[Gin-Soaked Blotter Paper]);
					need -= 1;
					paper -= 1;
				}
				if((stinkface == 0) && (paper > 0))
				{
					stinkface = to_int($item[Gin-Soaked Blotter Paper]);
					need -= 1;
					paper -= 1;
				}
			}


			if((need == 0) && (item_amount($item[Azazel\'s Unicorn]) == 0))
			{
				string temp = visit_url("pandamonium.php?action=sven");
				visit_url("pandamonium.php?action=sven&bandmember=Jim&togive=" + jim + "&preaction=try");
				temp = visit_url("pandamonium.php?action=sven");
				visit_url("pandamonium.php?action=sven&bandmember=Flargwurm&togive=" + flargwurm + "&preaction=try");
				temp = visit_url("pandamonium.php?action=sven");
				visit_url("pandamonium.php?action=sven&bandmember=Bognort&togive=" + bognort + "&preaction=try");
				temp = visit_url("pandamonium.php?action=sven");
				visit_url("pandamonium.php?action=sven&bandmember=Stinkface&togive=" + stinkface + "&preaction=try");
				return true;
			}

			if(item_amount($item[Azazel\'s Unicorn]) == 0)
			{
				uneffect($effect[Carlweather\'s Cantata of Confrontation]);
				buffMaintain($effect[The Sonata of Sneakiness], 20, 1, 1);
				buffMaintain($effect[Smooth Movements], 10, 1, 1);
			}
			else
			{
				uneffect($effect[The Sonata of Sneakiness]);
			}
			handleFamiliar("item");
			ccAdv(1, $location[Infernal Rackets Backstage]);
		}
		else if((item_amount($item[Azazel\'s Lollipop]) == 0) && (item_amount($item[Azazel\'s Tutu]) == 0))
		{
			foreach it in $items[Hilarious Comedy Prop, Victor\, the Insult Comic Hellhound Puppet, Observational Glasses]
			{
				if(item_amount(it) > 0)
				{
					string temp = visit_url("pandamonium.php?action=mourn&whichitem=" + to_int(it) + "&pwd=");
				}
				else
				{
					abort("Somehow we do not have " + it + " at this point...");
				}
			}
		}
		else if((item_amount($item[Azazel\'s Tutu]) == 0) && (item_amount($item[Bus Pass]) >= 5) && (item_amount($item[Imp Air]) >= 5))
		{
			string temp = visit_url("pandamonium.php?action=moan");
		}
		else if((item_amount($item[Azazel\'s Tutu]) > 0) && (item_amount($item[Azazel\'s Lollipop]) > 0) && (item_amount($item[Azazel\'s Unicorn]) > 0))
		{
			string temp = visit_url("pandamonium.php?action=temp");
		}
		else
		{
			print("Stuck in the Steel Organ quest and can't continue, moving on.", "red");
			set_property("cc_getSteelOrgan", false);
		}
		return true;
	}
	else if(get_property("questM10Azazel") == "finished")
	{
		if((item_amount($item[Steel Lasagna]) > 0) && (fullness_left() >= 5))
		{
			eatsilent(1, $item[Steel Lasagna]);
		}
		if((item_amount($item[Steel Margarita]) > 0) && ((my_inebriety() <= 5) || (my_inebriety() >= 12)) && (inebriety_left() >= 5))
		{
			drink(1, $item[Steel Margarita]);
		}
		if((item_amount($item[Steel-Scented Air Freshener]) > 0) && (spleen_left() >= 5))
		{
			chew(1, $item[Steel-Scented Air Freshener]);
		}
	}
	return false;
}


boolean L6_friarsHotWing()
{
	if(get_property("cc_friars") != "done")
	{
		return false;
	}
	if((get_property("cc_pirateoutfit") == "almost") || (get_property("cc_pirateoutfit") == "finished") )
	{
		set_property("cc_friars", "finished");
		return false;
	}

	if(internalQuestStatus("questM12Pirate") >= 3)
	{
		set_property("cc_friars", "finished");
		return false;
	}

	if(item_amount($item[hot wing]) >= 3)
	{
		set_property("cc_friars", "finished");
		return true;
	}

	if(considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}
	print("Need more Hot Wings", "blue");
	if(my_class() == $class[Ed])
	{
		if(!ccAdv(1, $location[Pandamonium]))
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
	if(cc_get_campground() contains $item[Frobozz Real-Estate Company Instant House (TM)])
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
		handleFamiliar("item");
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
		handleFamiliar("item");
		ccAdv(1, $location[The Goatlet]);
		return true;
	}
	else if((my_rain() > 50) && (have_effect($effect[Ultrahydrated]) == 0) && (cc_my_path() == "Heavy Rains"))
	{
		print("Trying to summon a mountain man", "blue");
		set_property("cc_mountainmen", "1");
		rainManSummon("mountain man", false, false);
		return true;
	}
	else if(cc_my_path() == "Heavy Rains")
	{
		#Do pulls instead if we don't possess rain man?
		print("Need Ore but not enough rain", "blue");
		return false;
	}
	else if(!in_hardcore())
	{
		if(pulls_remaining() >= (3 - item_amount(oreGoal)))
		{
			pullXWhenHaveY(oreGoal, 3 - item_amount(oreGoal), item_amount(oreGoal));
		}
	}
	else if((my_level() >= 12) && in_hardcore())
	{
		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		if(item_amount($item[Disassembled Clover]) > 1)
		{
			backupSetting("cloverProtectActive", false);
			use(1, $item[Disassembled Clover]);
			if(ccAdvBypass(270, $location[Itznotyerzitz Mine]))
			{
				print("Wandering monster interrupt at Itznotyerzitz Mine", "red");
				restoreSetting("cloverProtectActive");
				return true;
			}
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			restoreSetting("cloverProtectActive");
			return true;
		}
	}
	return false;
}

boolean LX_guildUnlock()
{
	if(!in_hardcore())

	{
		if(my_ascensions() >= 125)
		{
			return false;
		}
	}
	if(!isGuildClass() || guild_store_available())
	{
		return false;
	}
	print("Let's unlock the guild.", "green");
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
	if(!outfit("knob goblin harem girl disguise"))
	{
		abort("Could not put on Knob Goblin Harem Girl Disguise, aborting");
	}
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
	if(my_level() < 4)
	{
		return false;
	}

	print("In the bat hole!", "blue");
	if(considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}
	buffMaintain($effect[Fishy Whiskers], 0, 1, 1);

	int batStatus = internalQuestStatus("questL04Bat");
	if((item_amount($item[sonar-in-a-biscuit]) > 0) && (batStatus < 3))
	{
		use(1, $item[sonar-in-a-biscuit]);
		return true;
	}

	if(batStatus >= 4)
	{
		if((item_amount($item[enchanted bean]) == 0) && !get_property("cc_bean").to_boolean())
		{
			ccAdv(1, $location[The Beanbat Chamber]);
			return true;
		}
		set_property("cc_bat", "finished");
		council();
		return true;
	}
	if(batStatus >= 3)
	{
		ccAdv(1, $location[The Boss Bat\'s Lair]);
		return true;
	}
	if(batStatus >= 2)
	{
		if((item_amount($item[Enchanted Bean]) == 0) && !get_property("cc_bean").to_boolean())
		{
			ccAdv(1, $location[The Beanbat Chamber]);
			return true;
		}
		ccAdv(1, $location[The Batrat and Ratbat Burrow]);
		return true;
	}
	if(batStatus >= 1)
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

	if((my_class() == $class[Ed]) && (item_amount($item[Disassembled Clover]) > 0) && (batStatus <= 1))
	{
		backupSetting("cloverProtectActive", false);
		use(1, $item[Disassembled Clover]);
		if(ccAdvBypass(31, $location[Guano Junction]))
		{
			print("Wandering monster interrupt at Guano Junction", "red");
			restoreSetting("cloverProtectActive");
			return true;
		}
		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		restoreSetting("cloverProtectActive");
		return true;
	}
	ccAdv(1, $location[Guano Junction]);
	return true;
}

boolean LX_craftAcquireItems()
{
	if(in_hardcore())
	{
		if(have_effect($effect[Adventurer\'s Best Friendship]) > 120)
		{
			set_property("choiceAdventure1106", 3);
		}
		else
		{
			set_property("choiceAdventure1106", 2);
		}
	}
	else
	{
		if(have_effect($effect[Adventurer\'s Best Friendship]) > 30)
		{
			set_property("choiceAdventure1106", 3);
		}
		else
		{
			set_property("choiceAdventure1106", 2);
		}
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
			#if(in_hardcore() && isGuildClass())
			if(isGuildClass())
			{
				if((item_amount($item[Snow Berries]) >= 3) && (item_amount($item[Ice Harvest]) >= 3) && (item_amount($item[Unfinished Ice Sculpture]) == 0))
				{
					cli_execute("make 1 Unfinished Ice Sculpture");
				}
				if((item_amount($item[Snow Berries]) >= 2) && (item_amount($item[Snow Crab]) == 0))
				{
					cli_execute("make 1 Snow Crab");
				}
			}
			#cli_execute("make " + item_amount($item[snow berries]) + " snow cleats");
		}
		else
		{
			abort("Bridge progress came up as >= 30 but is no longer after viewing the page.");
		}
	}

	if(knoll_available() && (item_amount($item[detuned radio]) == 0) && (my_meat() > 300))
	{
		buyUpTo(1, $item[detuned radio]);
		change_mcd(10);
		visit_url("choice.php?pwd&whichchoice=835&option=2", true);
	}

	if((my_adventures() <= 3) && (my_daycount() == 1) && in_hardcore())
	{
		if(LX_meatMaid())
		{
			return true;
		}
	}

	#Can we have some other way to check that we have AT skills?
	if((item_amount($item[antique accordion]) == 0) && (my_meat() > 12500) && (have_skill($skill[The Ode to Booze])) && (my_class() != $class[Accordion Thief]))
	{
		buyUpTo(1, $item[antique accordion]);
	}

	while((item_amount($item[Seal Tooth]) == 0) && (item_amount($item[Hermit Permit]) > 0) && (my_meat() > 7500))
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

	if(my_class() == $class[Turtle Tamer])
	{
		if(!possessEquipment($item[Turtle Wax Shield]) && (item_amount($item[Turtle Wax]) > 0))
		{
			use(1, $item[Turtle Wax]);
		}
		if(have_skill($skill[Armorcraftiness]) && !possessEquipment($item[Painted Shield]) && (my_meat() > 3500) && (item_amount($item[Painted Turtle]) > 0) && (item_amount($item[Tenderizing Hammer]) > 0))
		{
			// Make Painted Shield - Requires an Adventure
		}
		if(have_skill($skill[Armorcraftiness]) && !possessEquipment($item[Spiky Turtle Shield]) && (my_meat() > 3500) && (item_amount($item[Hedgeturtle]) > 0) && (item_amount($item[Tenderizing Hammer]) > 0))
		{
			// Make Spiky Turtle Shield - Requires an Adventure
		}
	}
	if((get_power(equipped_item($slot[pants])) < 70) && !possessEquipment($item[Demonskin Trousers]) && (my_meat() > 350) && (item_amount($item[Demon Skin]) > 0) && (item_amount($item[Tenderizing Hammer]) > 0) && knoll_available())
	{
		buyUpTo(1, $item[Pants Kit]);
		ccCraft("smith", 1, $item[Pants Kit], $item[Demon Skin]);
	}
	if(!possessEquipment($item[Tighty Whiteys]) && (my_meat() > 350) && (item_amount($item[White Snake Skin]) > 0) && (item_amount($item[Tenderizing Hammer]) > 0) && knoll_available())
	{
		buyUpTo(1, $item[Pants Kit]);
		ccCraft("smith", 1, $item[Pants Kit], $item[White Snake Skin]);
	}

	if(!possessEquipment($item[Grumpy Old Man Charrrm Bracelet]) && (item_amount($item[Jolly Roger Charrrm Bracelet]) > 0) && (item_amount($item[Grumpy Old Man Charrrm]) > 0))
	{
		use(1, $item[Jolly Roger Charrrm Bracelet]);
		use(1, $item[Grumpy Old Man Charrrm]);
	}

	if(!possessEquipment($item[Booty Chest Charrrm Bracelet]) && (item_amount($item[Jolly Roger Charrrm Bracelet]) > 0) && (item_amount($item[Booty Chest Charrrm]) > 0))
	{
		use(1, $item[Jolly Roger Charrrm Bracelet]);
		use(1, $item[Booty Chest Charrrm]);
	}

	LX_dolphinKingMap();

	cc_mayoItems();

	return false;
}


boolean LX_meatMaid()
{
	if(cc_get_campground() contains $item[Meat Maid])
	{
		return false;
	}
	if(!knoll_available() || (my_daycount() != 1) || (get_property("cc_crypt") != "finished"))
	{
		return false;
	}

	if((item_amount($item[Smart Skull]) > 0) && (item_amount($item[Disembodied Brain]) > 0))
	{
		print("Got a brain, trying to make and use a meat maid now.", "blue");
		cli_execute("make meat maid");
		use(1, $item[meat maid]);
		return true;
	}

	use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
	if(item_amount($item[Disassembled Clover]) == 0)
	{
		return false;
	}
	if(my_meat() < 320)
	{
		return false;
	}
	print("Well, we could make a Meat Maid and that seems raisinable.", "blue");

	if((item_amount($item[Brainy Skull]) == 0) && (item_amount($item[Disembodied Brain]) == 0))
	{
		backupSetting("cloverProtectActive", false);
		use(1, $item[disassembled clover]);
//		if(contains_text(visit_url("adventure.php?snarfblat=58&confirm=on"), "Combat"))
		if(contains_text(visit_url("adventure.php?snarfblat=58"), "Combat"))
		{
			print("Wandering combat at The VERY Unquiet Garves, have to try this again.", "red");
			restoreSetting("cloverProtectActive");
			ccAdv(1, $location[The VERY Unquiet Garves]);
#			if(item_amount($item[ten-leaf clover]) == 1)
#			{
#				use(1, $item[ten-leaf clover]);
#			}
			return true;
		}
		restoreSetting("cloverProtectActive");
		if(get_property("lastEncounter") == "Rolling the Bones")
		{
			print("Got a brain, trying to make and use a meat maid now.", "blue");
			cli_execute("make meat maid");
			use(1, $item[meat maid]);
		}
		if(lastAdventureSpecialNC())
		{
			abort("May be stuck in an interrupting Non-Combat adventure, finish current adventure and resume");
		}
		return true;
	}
	return false;
}

boolean LX_bitchinMeatcar()
{
	if((item_amount($item[Bitchin\' Meatcar]) > 0) || gnomads_available() || (my_class() == $class[Ed]))
	{
		return false;
	}
	if(get_property("lastDesertUnlock").to_int() == my_ascensions())
	{
		return false;
	}

	if(knoll_available())
	{
		cli_execute("make bitch");
		cli_execute("place.php?whichplace=desertbeach&action=db_nukehouse");
	}
	else
	{
		print("Farming for a Bitchin' Meatcar", "blue");
		if(get_property("questM01Untinker") == "unstarted")
		{
			visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");
		}
		if((item_amount($item[Tires]) == 0) || (item_amount($item[empty meat tank]) == 0) || (item_amount($item[spring]) == 0) ||(item_amount($item[sprocket]) == 0) ||(item_amount($item[cog]) == 0))
		{
			if(!ccAdv(1, $location[The Degrassi Knoll Garage]))
			{
				if(guild_store_available())
				{
					visit_url("guild.php?place=paco");
				}
				else
				{
					abort("Need to farm a Bitchin' Meatcar but guild not available.");
				}
			}
			if(item_amount($item[Gnollish Toolbox]) > 0)
			{
				use(1, $item[Gnollish Toolbox]);
			}
		}
		else
		{
			cli_execute("make bitch");
			cli_execute("place.php?whichplace=desertbeach&action=db_nukehouse");
		}
	}
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
	if((item_amount($item[Dingy Dinghy]) > 0) || (get_property("lastIslandUnlock").to_int() == my_ascensions()))
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
	if(item_amount($item[Tree-Holed Coin]) == 1)
	{
		set_property("cc_treecoin", "finished");
	}
	if(item_amount($item[Spooky Temple Map]) == 1)
	{
		set_property("cc_treecoin", "finished");
	}
	if(get_property("cc_treecoin") == "finished")
	{
		return false;
	}

	print("Time for a tree-holed coin", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "2");
	ccAdv(1, $location[The Spooky Forest]);
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
	ccAdv(1, $location[The Spooky Forest]);
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

#	handlePreAdventure($location[The Spooky Forest]);
#	if(contains_text(visit_url("adventure.php?snarfblat=15"), "Combat") || lastAdventureSpecialNC())
#	{
#		ccAdv(1, $location[The Spooky Forest]);
#	}
#	else
	if(!ccAdvBypass("adventure.php?snarfblat=15", $location[The Spooky Forest]))
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
	if(item_amount($item[mosquito larva]) > 0)
	{
		council();
		set_property("cc_mosquito", "finished");
		visit_url("tavern.php?place=barkeep");
	}
	if(get_property("cc_mosquito") == "finished")
	{
		return false;
	}

	buffMaintain($effect[Snow Shoes], 0, 1, 1);

	print("Trying to find a mosquito.", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "1");
	ccAdv(1, $location[The Spooky Forest]);
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
	if(get_property("cc_gaudy") == "finished")
	{
		delayKitchen = false;
	}
	if(item_amount($item[Spookyraven Billiards Room Key]) > 0)
	{
		delayKitchen = false;
	}
	if(my_level() == get_property("cc_powerLevelLastLevel").to_int())
	{
		delayKitchen = false;
	}
	if(delayKitchen)
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
		if(delayKitchen)
		{
			int hot = elemental_resist($element[hot]);
			int stench = elemental_resist($element[stench]);
			int mpNeed = 0;
			if((hot < 9) && (stench < 9) && have_skill($skill[Astral Shell]) && (have_effect($effect[Astral Shell]) == 0))
			{
				hot += 1;
				stench += 1;
				mpNeed += mp_cost($skill[Astral Shell]);
			}
			if((hot < 9) && (stench < 9) && have_skill($skill[Elemental Saucesphere]) && (have_effect($effect[Elemental Saucesphere]) == 0))
			{
				hot += 2;
				stench += 2;
				mpNeed += mp_cost($skill[Elemental Saucesphere]);
			}
			if((my_mp() > mpNeed) && (hot >= 9) && (stench >= 9))
			{
				buffMaintain($effect[Astral Shell], mp_cost($skill[Astral Shell]), 1, 1);
				buffMaintain($effect[Elemental Saucesphere], mp_cost($skill[Elemental Saucesphere]), 1, 1);
			}
			if((elemental_resist($element[hot]) >= 9) && (elemental_resist($element[stench]) >= 9))
			{
				delayKitchen = false;
			}
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
			int expectPool = get_property("poolSkill").to_int();
			if(my_inebriety() >= 10)
			{
				expectPool += (30 - (2 * my_inebriety()));
			}
			else
			{
				expectPool += my_inebriety();
			}
			// Staff of Fats (non-Ed and Ed) and Staff of Ed (from Ed)
			#if(have_equipped($item[2268]) || have_equipped($item[7964]) || have_equipped($item[7961]))
			if(possessEquipment($item[2268]) || possessEquipment($item[7964]) || possessEquipment($item[7961]))
			{
				expectPool += 5;
			}
			if(have_equipped($item[Pool Cue]))
			{
				expectPool += 3;
			}
			if((have_effect($effect[Chalky Hand]) > 0) || (item_amount($item[Handful of Hand Chalk]) > 0))
			{
				expectPool += 3;
			}
			if(have_effect($effect[Chalked Weapon]) > 0)
			{
				expectPool += 5;
			}
			if(have_effect($effect[Influence of Sphere]) > 0)
			{
				expectPool += 5;
			}
			if(have_effect($effect[Video... Games?]) > 0)
			{
				expectPool += 5;
			}
			if(have_effect($effect[Swimming with Sharks]) > 0)
			{
				expectPool += 3;
			}


			print("Looking at the billiards room: 14 <= " + expectPool + " <= 18", "green");
			if((my_inebriety() < 8) && ((my_inebriety() + 2) < inebriety_limit()))
			{
				if(expectPool < 18)
				{
					print("Not quite boozed up for the billiards room... we'll be back.", "green");
				}
				return false;
			}
			if((my_inebriety() > 12) && (expectPool < 16))
			{
				if(in_hardcore() && (my_daycount() <= 2))
				{
					print("Ok, I'm too boozed up for the billards room, I'll be back.", "green");
				}
				if(!in_hardcore() && (my_daycount() <= 1))
				{
					print("I'm too drunk for pool, at least it is only " + format_date_time("yyyyMMdd", today_to_string(), "EEEE"), "green");
				}
			}

			set_property("choiceAdventure875" , "1");
			if(expectPool < 14)
			{
				set_property("choiceAdventure875", "2");
			}
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
			buffMaintain($effect[Patent Prevention], 0, 1, 1);

			ccAdv(1, $location[The Haunted Kitchen]);
			handleFamiliar("item");
		}
		return true;
	}
	return false;
}

boolean L5_getEncryptionKey()
{
	if(item_amount($item[11-inch knob sausage]) == 1)
	{
		visit_url("guild.php?place=challenge");
		return true;
	}
	if(item_amount($item[Knob Goblin Encryption Key]) == 1)
	{
		set_property("cc_day1_cobb", "finished");
		if(my_level() >= 5)
		{
			council();
		}
	}
	if(get_property("cc_day1_cobb") == "finished")
	{
		return false;
	}
	if(internalQuestStatus("questL05Goblin") >= 1)
	{
		set_property("cc_day1_cobb", "finished");
		return false;
	}

	print("Looking for the knob.", "blue");
	ccAdv(1, $location[The Outskirts of Cobb\'s Knob]);
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

	#handle lights-out, too bad we can\'t at least start Stephen Spookyraven here.
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
	if((my_mp() > 60) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
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
			set_property("cc_gunpowder", "finished");
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

	if((get_property("cc_orcishfratboyspy") == "done") && !in_hardcore())
	{
		pullXWhenHaveY($item[Beer Helmet], 1, 0);
		pullXWhenHaveY($item[Bejeweled Pledge Pin], 1, 0);
		pullXWhenHaveY($item[Distressed Denim Pants], 1, 0);
	}

	if(!in_hardcore() && (cc_my_path() != "Heavy Rains"))
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

#		Huh? I think this was meant to be Ball Lightning.
#		// 138 is HR Lightning Bolt
#		if((have_effect($effect[everything looks yellow]) > 0) || !have_skill(to_skill(138)))
		if(!canYellowRay())
#		if((have_effect($effect[everything looks yellow]) > 0) || !have_skill(to_skill(138)))
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
	if(cc_my_path() == "Heavy Rains")
	{
		abort("We shouldn't be going down this path in HR");
	}
	if(possessEquipment($item[Filthy Knitted Dread Sack]) && possessEquipment($item[Filthy Corduroys]))
	{
		set_property("cc_prehippy", "firstOutfit");
		return true;
	}
	if(possessEquipment($item[Beer Helmet]) && possessEquipment($item[Distressed Denim Pants]) && possessEquipment($item[Bejeweled Pledge Pin]))
	{
		set_property("cc_prehippy", "firstOutfit");
		return true;
	}

	if(my_class() == $class[Ed])
	{
		if(!canYellowRay() && (my_level() < 12))
		{
			return false;
		}
	}

#	if((my_class() == $class[Ed]) && have_skill($skill[Wrath of Ra]))
#	{
#		if(have_effect($effect[Everything Looks Yellow]) != 0)
#		{
#			return false;
#		}
#		if(my_mp() < 40)
#		{
#			return false;
#		}
#	}
	if(have_skill($skill[Calculate the Universe]) && (my_daycount() == 1))
	{
		return false;
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
	if((item_amount($item[rock band flyers]) == 0) && (item_amount($item[jam band flyers]) == 0))
	{
		return false;
	}
	if(get_property("flyeredML").to_int() < 10000)
	{
		if(get_property("sidequestArenaCompleted") != "none")
		{
			print("Sidequest Arena detected as completed but flyeredML is not appropriate, fixing.", "red");
			set_property("flyeredML", 10000);
		}
		else
		{
			return false;
		}
	}
	if(get_property("cc_ignoreFlyer").to_boolean())
	{
		return false;
	}
	print("Done with this Flyer crap", "blue");
	warOutfit();
	visit_url("bigisland.php?place=concert&pwd");

	cli_execute("refresh inv");
	if((item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[Jam Band Flyers]) == 0))
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
	boolean clueCheck = ((item_amount($item[A-Boo Clue]) > 0) || (get_property("cc_aboopending").to_int() != 0));
	if(clueCheck && (get_property("booPeakProgress").to_int() > 2))
	{
		boolean doThisBoo = false;

		if(my_class() == $class[Ed])
		{
			if(item_amount($item[Linen Bandages]) == 0)
			{
				return false;
			}
		}
		familiar priorBjorn = my_bjorned_familiar();

		string lihcface = "";
		if((my_class() == $class[Ed]) && possessEquipment($item[The Crown of Ed the Undying]))
		{
			lihcface = "-equip lihc face";
		}
		string parrot = ", switch exotic parrot";
		if(get_property("cc_100familiar").to_boolean())
		{
			parrot = "";
		}

		ccMaximize("spooky res, cold res " + lihcface + " -equip snow suit" + parrot, 0, 0, true);
		int coldResist = numeric_modifier("Generated:_spec", "cold resistance");
		int spookyResist = numeric_modifier("Generated:_spec", "spooky resistance");
		int hpDifference = numeric_modifier("Generated:_spec", "Maximum HP") - numeric_modifier("Maximum HP");

		//	Do we need to manually adjust for the parrot?

		if(black_market_available() && (item_amount($item[Can of Black Paint]) == 0) && (have_effect($effect[Red Door Syndrome]) == 0) && (my_meat() >= 1000))
		{
			buyUpTo(1, $item[Can of Black Paint]);
			coldResist += 2;
			spookyResist += 2;
		}
		else if((item_amount($item[Can of Black Paint]) > 0) && (have_effect($effect[Red Door Syndrome]) == 0))
		{
			coldResist += 2;
			spookyResist += 2;
		}

		if((item_amount($item[Spooky Powder]) > 0) && (have_effect($effect[Spookypants]) == 0))
		{
			spookyResist = spookyResist + 1;
		}
		if((item_amount($item[Ectoplasmic Orbs]) > 0) && (have_effect($effect[Balls of Ectoplasm]) == 0))
		{
			spookyResist = spookyResist + 1;
		}
		if((item_amount($item[Black Eyedrops]) > 0) && (have_effect($effect[Hyphemariffic]) == 0))
		{
			spookyResist = spookyResist + 9;
		}
		if((item_amount($item[Cold Powder]) > 0) && (have_effect($effect[Insulated Trousers]) == 0))
		{
			coldResist = coldResist + 1;
		}

		#Calculate how much boo peak damage does per unit resistance.
		int estimatedCold = (13+25+50+125+250) * ((100.0 - elemental_resist_value(coldResist)) / 100.0);
		int estimatedSpooky = (13+25+50+125+250) * ((100.0 - elemental_resist_value(spookyResist)) / 100.0);
		print("Current HP: " + my_hp() + "/" + my_maxhp(), "blue");
		print("Expected cold damage: " + estimatedCold + " Expected spooky damage: " + estimatedSpooky, "blue");
		print("Expected Cold Resist: " + coldResist + " Expected Spooky Resist: " + spookyResist + " Expected HP Difference: " + hpDifference, "blue");
		int totalDamage = estimatedCold + estimatedSpooky;

		if(get_property("booPeakProgress").to_int() <= 6)
		{
			estimatedCold = ((estimatedCold * 38) / 463) + 1;
			estimatedSpooky = ((estimatedSpooky * 38) / 463) + 1;
			totalDamage = estimatedCold + estimatedSpooky;
		}
		else if(get_property("booPeakProgress").to_int() <= 12)
		{
			estimatedCold = ((estimatedCold * 88) / 463) + 1;
			estimatedSpooky = ((estimatedSpooky * 88) / 463) + 1;
			totalDamage = estimatedCold + estimatedSpooky;
		}
		else if(get_property("booPeakProgress").to_int() <= 20)
		{
			estimatedCold = ((estimatedCold * 213) / 463) + 1;
			estimatedSpooky = ((estimatedSpooky * 213) / 463) + 1;
			totalDamage = estimatedCold + estimatedSpooky;
		}

		if(get_property("booPeakProgress").to_int() <= 20)
		{
			print("Don't need a full A-Boo Clue, adjusting values:", "blue");
			print("Expected cold damage: " + estimatedCold + " Expected spooky damage: " + estimatedSpooky, "blue");
			print("Expected Cold Resist: " + coldResist + " Expected Spooky Resist: " + spookyResist + " Expected HP Difference: " + hpDifference, "blue");
		}

		int considerHP = my_maxhp() + hpDifference;

		int mp_need = 20 + numeric_modifier("Generated:_spec", "Mana Cost");
		if((my_hp() - totalDamage) > 50)
		{
			mp_need = mp_need - 20;
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
		if((my_hp() >= totalDamage) && (my_mp() >= mp_need))
		{
			doThisBoo = true;
		}
		if((considerHP >= totalDamage) && (my_mp() >= mp_need) && have_skill($skill[Cannelloni Cocoon]))
		{
			doThisBoo = true;
		}

		if(doThisBoo)
		{
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			ccMaximize("spooky res, cold res " + lihcface + " -equip snow suit" + parrot, 0, 0, false);
			adjustEdHat("ml");

			if(item_amount($item[ghost of a necklace]) > 0)
			{
				equip($slot[acc2], $item[ghost of a necklace]);
			}
			buffMaintain($effect[Astral Shell], 10, 1, 1);
			buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
			buffMaintain($effect[Scarysauce], 10, 1, 1);
			buffMaintain($effect[Spookypants], 0, 1, 1);
			buffMaintain($effect[Hyphemariffic], 0, 1, 1);
			buffMaintain($effect[Insulated Trousers], 0, 1, 1);
			buffMaintain($effect[Balls of Ectoplasm], 0, 1, 1);
			buffMaintain($effect[Red Door Syndrome], 0, 1, 1);
			buffMaintain($effect[Well-Oiled], 0, 1, 1);

			set_property("choiceAdventure611", "1");
			if((my_hp() - 50) < totalDamage)
			{
				useCocoon();
			}
			if(get_property("cc_aboopending").to_int() == 0)
			{
				use(1, $item[A-Boo clue]);
				set_property("cc_aboopending", my_turncount());
			}
			handleFamiliar($familiar[Exotic Parrot]);
			# When booPeakProgress <= 0, we want to leave this adventure. Can we?
			# I can not figure out how to do this via ASH since the adventure completes itself?
			# However, in mafia, (src/net/sourceforge/kolmafia/session/ChoiceManager.java)
			# upon case 611, if booPeakProgress <= 0, set choiceAdventure611 to 2
			# If lastDecision was 2, revert choiceAdventure611 to 1 (or perhaps unset it?)
			ccAdv(1, $location[A-Boo Peak]);
			if(get_property("lastEncounter") != "The Horror...")
			{
				print("Wandering adventure interrupt of A-Boo Peak, refreshing inventory.", "red");
				cli_execute("refresh inv");
			}
			else
			{
				set_property("cc_aboopending", 0);
			}
			useCocoon();
			if((my_class() == $class[Ed]) && (my_hp() == 0))
			{
				use(1, $item[Linen Bandages]);
			}
			if(((my_hp() * 4) < my_maxhp()) && (item_amount($item[Scroll of Drastic Healing]) > 0) && (my_class() != $class[Ed]))
			{
				use(1, $item[Scroll of Drastic Healing]);
			}
			handleFamiliar("item");
			handleBjornify(priorBjorn);
			return true;
		}
		else if(cc_my_path() != "Picky")
		{
			#abort("Could not handle HP/MP situation for a-boo peak");
		}
		print("Nevermind, that peak is too scary!", "green");
		equipBaseline();
		handleFamiliar("item");
		handleBjornify(priorBjorn);
	}
	else if(get_property("cc_abooclover").to_boolean() && (get_property("booPeakProgress").to_int() >= 40))
	{
		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		if(item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);
			backupSetting("cloverProtectActive", false);

//			string page = visit_url("adventure.php?snarfblat=296&confirm=on");
			string page = visit_url("adventure.php?snarfblat=296");
			if(contains_text(page, "Combat"))
			{
				print("Wandering monster interrupt at a-boo peak", "red");
				ccAdv(1, $location[A-Boo Peak]);
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			}
			else
			{
				set_property("cc_abooclover", false);
			}
			restoreSetting("cloverProtectActive");
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
	if(get_property("cc_twinpeakprogress").to_int() == 0)
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

	if((my_mp() > 60) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
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
		float food_drop = item_drop_modifier();
		food_drop -= numeric_modifier(my_familiar(), "Item Drop", familiar_weight(my_familiar()), equipped_item($slot[familiar]));

		if((food_drop < 50) && (food_drop >= 20))
		{
			if((friars_available()) && (!get_property("friarsBlessingReceived").to_boolean()))
			{
				cli_execute("friars food");
			}
		}
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
		int possibleGain = 0;
		if(item_amount($item[Polysniff Perfume]) > 0)
		{
			possibleGain += 2;
		}
		if(item_amount($item[Pec Oil]) > 0)
		{
			possibleGain += 2;
		}
		if(item_amount($item[Oil of Parrrlay]) > 0)
		{
			possibleGain += 1;
		}
		int parrotOffset = 0;
		if((elemental_resist($element[stench]) < 4) && have_familiar($familiar[Exotic Parrot]))
		{
			parrotOffset = numeric_modifier($familiar[Exotic Parrot], "Stench Resistance", familiar_weight($familiar[Exotic Parrot]), equipped_item($slot[familiar]));
		}

		if((elemental_resist($element[stench]) + parrotOffset) >= 4)
		{
			if(elemental_resist($element[stench]) < 4)
			{
				handleFamiliar($familiar[Exotic Parrot]);
			}
			attemptNum = 1;
			attempt = true;
		}
		else if((elemental_resist($element[stench]) + possibleGain + parrotOffset) >= 4)
		{
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
			if(elemental_resist($element[stench]) < 4)
			{
				handleFamiliar($familiar[Exotic Parrot]);
			}
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
		if(lastAdventureSpecialNC())
		{
			ccAdv(1, $location[Twin Peak]);
			#abort("May be stuck in an interrupting Non-Combat adventure, finish current adventure and resume.");
		}
		return true;
	}

	print("Backwards Twin Peak Handler, can this be removed? (As of 2016/04/17, no)", "red");
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
		handleFamiliar("item");
	}
	return true;
}

boolean L9_oilPeak()
{
	if(get_property("cc_oilpeak") != "")
	{
		return false;
	}

	int expectedML = 10;
	if(have_skill($skill[Drescher\'s Annoying Noise]))
	{
		expectedML += 10;
	}
	if(have_skill($skill[Pride of the Puffin]))
	{
		expectedML += 10;
	}
	if(have_skill($skill[Ur-kel\'s Aria of Annoyance]))
	{
		expectedML += (2 * my_level());
	}

	if((monster_level_adjustment() < expectedML) && (my_level() < 12))
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
	handleFamiliar("init");

	if((my_class() == $class[Ed]) && get_property("cc_dickstab").to_boolean())
	{
		buffMaintain($effect[The Dinsey Look], 0, 1, 1);
	}
	if(monster_level_adjustment() < 50)
	{
		buffMaintain($effect[The Dinsey Look], 0, 1, 1);
	}
	if(monster_level_adjustment() < 50)
	{
		buffMaintain($effect[Sweetbreads Flamb&eacute;], 0, 1, 1);
	}
	ccAdv(1, $location[Oil Peak]);
	handleFamiliar("item");
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

	if(L9_ed_chasmBuild())
	{
		return true;
	}

	if(in_hardcore())
	{
		int need = (30 - get_property("chasmBridgeProgress").to_int());
		if(L9_ed_chasmBuildClover(need))
		{
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
		backupSetting("cloverProtectActive", false);
//		ccAdvBypass("adventure.php?snarfblat=295&confirm=on", $location[The Smut Orc Logging Camp]);
		ccAdvBypass("adventure.php?snarfblat=295", $location[The Smut Orc Logging Camp]);
		if(item_amount($item[Ten-Leaf Clover]) > 0)
		{
			print("Wandering adventure in The Smut Orc Logging Camp, boo. Gonna have to do this again.");
			use(item_amount($item[Ten-Leaf Clover]), $item[Ten-Leaf Clover]);
			restoreSetting("cloverProtectActive");
			return true;
		}
		restoreSetting("cloverProtectActive");
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
	if(L9_ed_chasmStart())
	{
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
			print("We should have a talisman o' namsilat but we don't know about it, attempting to create?", "red");
			if(item_amount($item[Snakehead Charrrm]) > 1)
			{
				cli_execute("make " + $item[Talisman O\' Namsilat]);
			}
			if(possessEquipment($item[Talisman O\' Namsilat]))
			{
				print("Found my Talisman o' Namsilat!", "blue");
				return true;
			}
		}
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
		if((my_mp() > 60) || considerGrimstoneGolem(true))
		{
			handleBjornify($familiar[Grimstone Golem]);
		}

		set_property("choiceAdventure189", "1");
		set_property("oceanAction", "continue");
		set_property("oceanDestination", to_lower_case(my_primestat()));
		handleFamiliar("init");

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
				handleFamiliar("item");
				return true;
			}
			set_property("cc_gaudy", "finished");
			set_property("cc_swordfish", "finished");
			use(1, $item[gaudy key]);
			use(1, $item[gaudy key]);
		}
		handleFamiliar("item");
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
	if(get_property("cc_mcmuffin") != "")
	{
		return false;
	}
	if(item_amount($item[Your Father\'s Macguffin Diary]) > 0)
	{
		use(item_amount($item[Your Father\'s Macguffin Diary]), $item[Your Father\'s Macguffin Diary]);
		set_property("cc_mcmuffin", "start");
		return true;
	}
	if(item_amount($item[Copy of a Jerk Adventurer\'s Father\'s Diary]) > 0)
	{
		use(item_amount($item[Copy of a Jerk Adventurer\'s Father\'s Diary]), $item[Copy of a Jerk Adventurer\'s Father\'s Diary]);
		set_property("cc_mcmuffin", "start");
		return true;
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
	if(get_property("cc_blackmap") != "document")
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
	buyUpTo(1, $item[Forged Identification Documents]);
	if(item_amount($item[Forged Identification Documents]) > 0)
	{
		set_property("cc_blackmap", "finished");
		handleFamiliar("item");
		return true;
	}
	print("Could not buy Forged Identification Documents, can't get booze now!", "red");
	return false;
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
		if(my_meat() >= 5000)
		{
			buyUpTo(1, $item[forged identification documents]);
			if(item_amount($item[Forged Identification Documents]) > 0)
			{
				set_property("cc_blackmap", "finished");
			}
		}
		return true;
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
		if(!possessEquipment($item[Blackberry Galoshes]))
		{
			pullXWhenHaveY($item[blackberry galoshes], 1, 0);
		}
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

	if((item_amount($item[Blackberry Galoshes]) > 0) && !have_equipped($item[Blackberry Galoshes]) && can_equip($item[Blackberry Galoshes]))
	{
		equip($slot[acc3], $item[Blackberry Galoshes]);
	}

	if(considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}
	else
	{
		handleBjornify($familiar[Grim Brother]);
	}

	if(!possessEquipment($item[Blackberry Galoshes]) && (item_amount($item[Blackberry]) >= 3))
	{
		set_property("choiceAdventure924", "2");
		set_property("choiceAdventure928", "4");
	}

	handleFamiliar($familiar[Reassembled Blackbird]);
	ccAdv(1, $location[The Black Forest]);
	handleFamiliar("item");
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
	else
	{
		handleFamiliar("item");
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

#	if(!canYellowRay())
#	{
#		return false;
#	}
	if(have_effect($effect[Everything Looks Yellow]) > 0)
	{
		return false;
	}

	if(cc_my_path() == "Heavy Rains")
	{
		buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
	}

	if(!in_hardcore() && !canYellowRay())
	{
		if(my_level() != get_property("cc_powerLevelLastLevel").to_int())
		{
			return false;
		}
	}
#	if(cc_my_path() == "Heavy Rains")
#	{
#		if(have_skill($skill[Ball Lightning]) && (my_lightning() >= 5))
#		{
#			buffMaintain($effect[Fishy Whiskers], 0, 1, 1);
#			print("Ditch attempt at the Harem Girl", "blue");
#		}
#		else if(!in_hardcore())
#		{
#			return false;
#		}
#	}

	if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
	{
		handleFamiliar("yellow ray");
	}

	print("Looking for some sexy lingerie!", "blue");
	ccAdv(1, $location[Cobb\'s Knob Harem]);
	handleFamiliar("item");
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
		outfit("swashbuckling getup");
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

	if(!uneffect($effect[Patent Invisibility]))
	{
		print("Could not uneffect Patent Invisibility for F'C'le, delaying");
		return false;
	}
	if(!uneffect($effect[Shelter Of Shed]))
	{
		print("Could not uneffect Shelter of Shed for F'C'le, delaying");
		return false;
	}

	print("Fcle time!", "blue");
	if(!outfit("swashbuckling getup"))
	{
		abort("Could not put on Swashbuckling Getup, aborting");
	}
	if(item_amount($item[numberwang]) > 0)
	{
		equip($slot[acc1], $item[numberwang]);
	}
	buffMaintain($effect[Taunt of Horus], 0, 1, 1);
	buffMaintain($effect[Patent Aggression], 0, 1, 1);

	removeNonCombat();

	if(have_familiar($familiar[Jumpsuited Hound Dog]))
	{
		handleFamiliar($familiar[Jumpsuited Hound Dog]);
	}
	else
	{
		handleFamiliar("item");
	}

	if(numeric_modifier("Combat Rate") <= 9.0)
	{
		if(possessEquipment($item[Carpe]))
		{
			equip($slot[Back], $item[Carpe]);
		}
	}

	if(numeric_modifier("Combat Rate") < 0.0)
	{
		print("Something is keeping us from getting a suitable combat rate, we have: " + numeric_modifier("Combat Rate") + " and F'c'le, continuning but not happy about it..", "red");
	}
	ccAdv(1, $location[The F\'c\'le]);
	handleFamiliar("item");

	return true;
}


boolean LX_pirateBeerPong()
{
	if(get_property("cc_pirateoutfit") != "almost")
	{
		return false;
	}
	if(!outfit("swashbuckling getup"))
	{
		abort("Could not put on Swashbuckling Getup, aborting");
	}
	LX_getDictionary();
	#	ccAdvBypass may be a bit trickier here.
	#	handlePreAdventure($location[Barrrney\'s Barrr]);
	#	We can get a Doghouse adventure here....

	set_property("choiceAdventure184", 6);

	if(numPirateInsults() < 6)
	{
		set_property("choiceAdventure187", "2");
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	else
	{
		set_property("choiceAdventure187", "0");
	}
	print("About to try this insult beer pong thing!", "blue");
	string page = tryBeerPong();
	if(contains_text(page, "victory laps"))
	{
		set_property("cc_pirateoutfit", "finished");
	}
	else if(contains_text(page, "Combat") || lastAdventureSpecialNC())
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

	return ccAdvBypass("inv_use.php?pwd=&which=3&whichitem=2950", $location[Noob Cave]);
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
			print("Looks like that Booty Crab will beat me up, I suppose I can walk the other way...", "green");
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
		outfit("swashbuckling getup");
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
			#abort("You somehow got here without 3 hot wings, did you eat them or something? That makes me sad.");
			if(L6_friarsGetParts() || L6_friarsHotWing())
			{
				return true;
			}
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
	if(!outfit("swashbuckling getup"))
	{
		print("Can not equip, or do not have the Swashbuckling Getup. Delaying.", "red");
		return false;
	}
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
		if(have_familiar($familiar[Ms. Puck Man]))
		{
			handleFamiliar($familiar[Ms. Puck Man]);
		}
		else if(have_familiar($familiar[Puck Man]))
		{
			handleFamiliar($familiar[Puck Man]);
		}
		ccAdv(1, $location[barrrney\'s barrr]);
		handleFamiliar("item");
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

boolean L8_trapperGroar()
{
	if(get_property("cc_trapper") == "finished")
	{
		return false;
	}

	boolean canGroar = false;

	if((item_amount($item[Ninja Rope]) >= 1) && (item_amount($item[Ninja Carabiner]) >= 1) && (item_amount($item[Ninja Crampons]) >= 1))
	{
		canGroar = true;
	}
	if((internalQuestStatus("questL08Trapper") == 2) && (get_property("currentExtremity").to_int() == 3))
	{
		string temp = visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
	}
	if((internalQuestStatus("questL08Trapper") >= 3) && (get_property("currentExtremity").to_int() == 0))
	{
		canGroar = true;
	}

	if(canGroar)
	{
		if(elemental_resist($element[cold]) < 5)
		{
			buffMaintain($effect[Astral Shell], 10, 1, 1);
			buffMaintain($effect[Elemental Saucesphere], 10, 1, 1);
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		}
		string lihcface = "";
		if((my_class() == $class[Ed]) && possessEquipment($item[The Crown of Ed the Undying]))
		{
			lihcface = "-equip lihc face";
		}

		if((elemental_resist($element[cold]) < 5) && (my_level() == get_property("cc_powerLevelLastLevel").to_int()))
		{
			ccMaximize("cold res " + lihcface + " -equip snow suit", 0, 0, true);
			int coldResist = numeric_modifier("Generated:_spec", "cold resistance");
			if(coldResist >= 5)
			{
				ccMaximize("cold res " + lihcface + " -equip snow suit", 0, 0, false);
			}
		}

		if(elemental_resist($element[cold]) >= 5)
		{
			if(get_property("cc_mistypeak") == "")
			{
				set_property("cc_ninjasnowmanassassin", "1");
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
				set_property("cc_mistypeak", "finished");
			}

			print("Time to take out Gargle, sure, Gargle (Groar)", "blue");
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
	return false;
}

boolean L8_trapperExtreme()
{
	if(get_property("currentExtremity").to_int() >= 3)
	{
		return false;
	}
	if(internalQuestStatus("questL08Trapper") >= 3)
	{
		return false;
	}

	//If choice 2 exists, we might want to take it, not that it is good in-run (the jar of frostkraut or whatever)
	//set_property("choiceAdventure575", "2");

	if((possessEquipment($item[extreme mittens])) && (possessEquipment($item[extreme scarf])) && (possessEquipment($item[snowboarder pants])))
	{
		if(outfit("eXtreme Cold-Weather Gear"))
		{
			set_property("choiceAdventure575", "3");
			ccAdv(1, $location[The eXtreme Slope]);
			return true;
		}
		else
		{
			print("I can not wear the eXtreme Gear, I'm just not awesome enough :(", "red");
			return false;
		}
	}


	print("Penguin Tony Hawk time. Extreme!! SSX Tricky!!", "blue");
	if(possessEquipment($item[extreme mittens]))
	{
		set_property("choiceAdventure15", "2");
		if(possessEquipment($item[extreme scarf]))
		{
			set_property("choiceAdventure15", "3");
		}
	}
	else
	{
		set_property("choiceAdventure15", "1");
	}

	if(possessEquipment($item[snowboarder pants]))
	{
		set_property("choiceAdventure16", "2");
		if(possessEquipment($item[extreme scarf]))
		{
			set_property("choiceAdventure16", "3");
		}
	}
	else
	{
		set_property("choiceAdventure16", "1");
	}

	if(possessEquipment($item[extreme mittens]))
	{
		set_property("choiceAdventure17", "2");
		if(possessEquipment($item[snowboarder pants]))
		{
			set_property("choiceAdventure17", "3");
		}
	}
	else
	{
		set_property("choiceAdventure17", "1");
	}

	set_property("choiceAdventure575", "1");

	ccAdv(1, $location[The eXtreme Slope]);
	return true;


}



boolean L8_trapperYeti()
{
	if(get_property("cc_trapper") != "yeti")
	{
		return false;
	}

	if(L8_trapperGroar())
	{
		return false;
	}

	if(!have_skill($skill[Rain Man]) && (pulls_remaining() >= 3) && (internalQuestStatus("questL08Trapper") < 3))
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
		return false;
	}

	if(in_hardcore())
	{
		if(get_property("questL08Trapper") == "step1")
		{
			set_property("questL08Trapper", "step2");
		}
		if(my_class() == $class[Ed])
		{
			if(item_amount($item[Talisman of Horus]) == 0)
			{
				return false;
			}
			if((have_effect($effect[Taunt of Horus]) == 0) && (item_amount($item[Talisman of Horus]) == 0))
			{
				return false;
			}
		}
		if((have_effect($effect[Thrice-Cursed]) > 0) || (have_effect($effect[Twice-Cursed]) > 0) || (have_effect($effect[Once-Cursed]) > 0))
		{
			return false;
		}

		uneffect($effect[The Sonata of Sneakiness]);
		if(!uneffect($effect[Patent Invisibility]))
		{
			print("Could not uneffect Patent Invisibility for ninja snowmen, delaying");
			return false;
		}
		if(!uneffect($effect[Shelter Of Shed]))
		{
			print("Could not uneffect Shelter of Shed for ninja snowmen, delaying");
			return false;
		}

		buffMaintain($effect[Patent Aggression], 0, 1, 1);
		removeNonCombat();

		if(have_familiar($familiar[Jumpsuited Hound Dog]))
		{
			handleFamiliar($familiar[Jumpsuited Hound Dog]);
		}
		else
		{
			handleFamiliar("item");
		}

		buffMaintain($effect[Hippy Stench], 0, 1, 1);
		buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 10, 1, 1);
		buffMaintain($effect[Musk of the Moose], 10, 1, 1);
		buffMaintain($effect[Taunt of Horus], 0, 1, 1);
		buffMaintain($effect[Song of Battle], 10, 1, 1);

		if((my_class() == $class[Ed]) && (!elementalPlanes_access($element[spooky])))
		{
			adjustEdHat("myst");
		}

		if(numeric_modifier("Combat Rate") <= 9.0)
		{
			if(possessEquipment($item[Carpe]))
			{
				equip($slot[Back], $item[Carpe]);
			}
		}

		if(numeric_modifier("Combat Rate") <= 0.0)
		{
			print("Something is keeping us from getting a suitable combat rate, we have: " + numeric_modifier("Combat Rate") + " and Ninja Snowmen.", "red");
			return false;
		}

		if(!ccAdv(1, $location[Lair of the Ninja Snowmen]))
		{
			print("Seems like we failed the Ninja Snowmen unlock, reverting trapper setting", "red");
			set_property("cc_trapper", "start");
		}
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
			boolean needReset = false;

			if(ccAdvBypass("cellar.php?action=explore&whichspot=" + actual, $location[Noob Cave]))
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

			if(contains_text(page, "whichchoice value=") || contains_text(page, "whichchoice="))
			{
				print("Tavern handler: You are RL drunk, you should not be here.", "red");
				ccAdv(1, $location[Noob Cave]);
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

	boolean enoughElement = (numeric_modifier("cold damage") >= 20) && (numeric_modifier("hot damage") >= 20) && (numeric_modifier("spooky damage") >= 20) && (numeric_modifier("stench damage") >= 20);

	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure1000", "1");
		set_property("choiceAdventure1001", "2");
		if((my_mp() < 15) && have_skill($skill[Shelter of Shed]))
		{
			return false;
		}
	}
	else if(!enoughElement || (my_mp() < mpNeed))
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

	if((my_mp() > 60) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
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
	if((get_property("cc_ballroomopen") != "open") || (get_property("cc_ballroomsong") == "finished"))
	{
		return false;
	}
	if(get_property("lastQuartetRequest").to_int() != 0)
	{
		set_property("cc_ballroomsong", "finished");
		return false;
	}
	if(my_class() == $class[Ed])
	{
		return false;
	}

	if((my_mp() > 60) || considerGrimstoneGolem(true))
	{
		handleBjornify($familiar[Grimstone Golem]);
	}
	set_property("choiceAdventure90", "3");

	set_property("choiceAdventure106", "2");
	if($classes[Avatar of Boris, Ed] contains my_class())
	{
		set_property("choiceAdventure106", "3");
	}

	ccAdv(1, $location[The Haunted Ballroom]);
	if(contains_text(get_property("lastEncounter"), "Strung-Up Quartet"))
	{
		set_property("cc_ballroomsong", "finished");
	}
	if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
	{
		set_property("cc_ballroomflat", "finished");
		if(my_class() == $class[Ed])
		{
			set_property("cc_ballroomsong", "finished");
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

	foreach it in $items[Anticheese, Awful Poetry Journal, Beach Glass Bead, Blue Pixel, Clay Peace-Sign Bead, Decorative Fountain, Empty Cloaca-Cola Bottle, Enchanted Barbell, Fancy Bath Salts, Frigid Ninja Stars, Giant Moxie Weed, Green Pixel, Half of a Gold Tooth, Imp Ale, Keel-Haulin\' Knife, Kokomo Resort Pass, Mad Train Wine, Margarita, Martini, Meat Paste, Mineapple, Moxie Weed, Patchouli Incense Stick, Phat Turquoise Bead, Photoprotoneutron Torpedo, Procrastination Potion, Ratgut, Red Pixel, Smelted Roe, Spicy Jumping Bean Burrito, Spicy Bean Burrito, Strongness Elixir, Sunken Chest, Tambourine Bells, Tequila Sunrise, Windchimes]
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
	if(((item_amount($item[rock band flyers]) == 1) || (item_amount($item[jam band flyers]) == 1)) && (get_property("flyeredML").to_int() < 10000))
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
	if(cc_my_path() == "Heavy Rains")
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
		restoreAllSettings();
		abort("cc_interrupt detected and aborting, cc_interrupt disabled.");
	}

	int delay = get_property("cc_delayTimer").to_int();
	if(delay != 0)
	{
		print("Delay between adventures... beep boop... ", "blue");
		wait(delay);
	}

	if(item_amount($item[Ten-Leaf Clover]) > 0)
	{
		use(item_amount($item[Ten-Leaf Clover]), $item[Ten-Leaf Clover]);
	}


	if((monster_level_adjustment() > 150) && (monster_level_adjustment() <= 160))
	{
		int base = (monster_level_adjustment() - current_mcd());
		if(base <= 150)
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
		else if(((monster_level_adjustment() + (10 - current_mcd())) <= 150) && (current_mcd() != 10))
		{
			if(get_property("cc_beatenUpCount").to_int() < 5)
			{
				change_mcd(10);
			}
			else
			{
				if(current_mcd() != 0)
				{
					change_mcd(0);
				}
			}
		}
	}
	handleFamiliar("item");

	if(my_familiar() == $familiar[Crimbo Shrub])
	{
		if((get_property("_jungDrops").to_int() == 1) || (my_daycount() > 1))
		{
			handleFamiliar("item");
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
			handleFamiliar("item");
		}
	}
	else if(($familiars[Adventurous Spelunker, Rockin\' Robin] contains my_familiar()) && (get_property("_jungDrops").to_int() == 0) && (my_daycount() == 1))
	{
		handleFamiliar($familiar[Angry Jung Man]);
	}

	if(($familiars[Adventurous Spelunker, Rockin\' Robin] contains my_familiar()) && have_familiar($familiar[Grimstone Golem]) && (in_hardcore() || !possessEquipment($item[Buddy Bjorn])))
	{
		if(!possessEquipment($item[Ornate Dowsing Rod]) && (item_amount($item[Odd Silver Coin]) < 5) && (item_amount($item[Grimstone Mask]) == 0) && considerGrimstoneGolem(false))
		{
			handleFamiliar($familiar[Grimstone Golem]);
		}
	} 

	int spleen_hold = 4;
	if(!haveSpleenFamiliar())
	{
		spleen_hold += 20;
	}
	else
	{
		if(item_amount($item[Astral Energy Drink]) > 0)
		{
			spleen_hold = spleen_hold + 8;
		}
		spleen_hold += 4 * item_amount($item[Grim Fairy Tale]);
		spleen_hold += 4 * item_amount($item[Powdered Gold]);
		spleen_hold += 4 * item_amount($item[Agua de Vida]);
		spleen_hold += 4 * item_amount($item[Unconscious Collective Dream Jar]);
		spleen_hold += 4 * item_amount($item[Groose Grease]);
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
		handleFamiliar("item");
	}
	if((my_familiar() == $familiar[Golden Monkey]) && (powderedGoldDrops() >= 1))
	{
		handleFamiliar("item");
	}
	if((my_familiar() == $familiar[Grim Brother]) && (grimTaleDrops() >= 1))
	{
		handleFamiliar("item");
	}
	if((my_familiar() == $familiar[Puck Man]) && (item_amount($item[Yellow Pixel]) > 20))
	{
		handleFamiliar("item");
	}
	if((my_familiar() == $familiar[Ms. Puck Man]) && (item_amount($item[Yellow Pixel]) > 20))
	{
		handleFamiliar("item");
	}
	if(in_hardcore() && ($familiars[Adventurous Spelunker, Rockin\' Robin] contains my_familiar()) && (my_mp() < 50))
	{
		handleFamiliar($familiar[Galloping Grill]);
	}

	# This function buys missing skills in general, not just for Picky.
	# It should be moved.
	picky_buyskills();
	awol_buySkills();
	awol_useStuff();
	theSource_buySkills();

	oldPeoplePlantStuff();
	use_barrels();

	tophatMaker();
	equipBaseline();
	xiblaxian_makeStuff();
	deck_useScheme("");

	if(dna_startAcquire())
	{
		return true;
	}

	if(theSource_oracle() || LX_theSource())
	{
		return true;
	}

	if(L1_HRstart())
	{
		return true;
	}

	if(LX_witchess())
	{
		return true;
	}

	if(get_property("cc_doCombatCopy") == "yes")
	{
		# This should never persist into another turn, ever.
		set_property("cc_doCombatCopy", "no");
	}

	if((equipped_item($slot[familiar]) == $item[none]) && (my_familiar() != $familiar[none]) && (cc_my_path() == "Heavy Rains"))
	{
		abort("Familiar has no equipment, WTF");
	}

	autosellCrap();

	ocrs_postCombatResolve();
	if((have_effect($effect[beaten up]) > 0) && (cc_my_path() == "Community Service"))
	{
		doHottub();
	}

	if(have_effect($effect[beaten up]) > 0)
	{
		if(have_effect($effect[Temporary Amnesia]) > 0)
		{
			doHottub();
		}
		else if((my_mp() > 20) && ((my_hp() * 1.2) >= my_maxhp()) && have_skill($skill[Tongue of the Walrus]))
		{
			use_skill(1, $skill[Tongue of the Walrus]);
		}
		if(have_effect($effect[beaten up]) > 0)
		{
			abort("Got beaten up, please fix me");
		}
	}

	if(my_daycount() != 2)
	{
		doNumberology("adventures3");
	}

	if(LA_cs_communityService())
	{
		return true;
	}
	if(cc_my_path() == "Community Service")
	{
		abort("Should not have gotten here, aborted LA_cs_communityService method allowed return to caller. Uh oh.");
	}

	if(my_daycount() == 2)
	{
		if((doNumberology("battlefield", false) != -1) && (my_mp() >= mp_cost($skill[Calculate the Universe])) && canYellowRay())
		{
			if(yellowRayCombatString() == ("skill " + $skill[Open a Big Yellow Present]))
			{
				handleFamiliar("yellow ray");
			}
			doNumberology("battlefield");
			return true;
		}
	}


	if(!get_property("_cc_codpieceGet").to_boolean())
	{
		if(possessEquipment($item[Codpiece]))
		{
			use(1, $item[Codpiece]);
			set_property("_cc_codpieceGet", true);
		}
	}
	if(!get_property("_cc_clarinetGet").to_boolean())
	{
		if(possessEquipment($item[Bass Clarinet]))
		{
			use(1, $item[Bass Clarinet]);
			set_property("_cc_clarinetGet", true);
		}
	}
	if(!get_property("_cc_hatchetGet").to_boolean())
	{
		if(possessEquipment($item[Fish Hatchet]))
		{
			use(1, $item[Fish Hatchet]);
			set_property("_cc_hatchetGet", true);
		}
	}

	buyableMaintain($item[Ben-gal&trade; Balm], 1, 200);
	buyableMaintain($item[Turtle Pheromones], 1, 800, my_class() == $class[Turtle Tamer]);
	buyableMaintain($item[Hair Spray], 1, 200, my_class() != $class[Turtle Tamer]);
	buyableMaintain($item[Blood of the Wereseal], 1, 3500, (monster_level_adjustment() > 135));

	if(my_level() < 13)
	{
		if(item_amount($item[pulled red taffy]) >= 6)
		{
			buffMaintain($effect[Cinnamon Challenger], 0, 6, 10);
		}
		if(item_amount($item[pulled orange taffy]) >= 6)
		{
			buffMaintain($effect[Orange Crusher], 0, 6, 10);
		}
		if(item_amount($item[pulled violet taffy]) >= 6)
		{
			buffMaintain($effect[Purple Reign], 0, 6, 10);
		}

		buffMaintain($effect[Gummi-Grin], 0, 1, 1);
		buffMaintain($effect[Strong Resolve], 0, 1, 1);
		buffMaintain($effect[Irresistible Resolve], 0, 1, 1);
		buffMaintain($effect[Brilliant Resolve], 0, 1, 1);
		buffMaintain($effect[From Nantucket], 0, 1, 1);
		buffMaintain($effect[Squatting and Thrusting], 0, 1, 1);
		buffMaintain($effect[You Read the Manual], 0, 1, 1);
	}

	if(my_level() > get_property("lastCouncilVisit").to_int())
	{
		council();
		if(contains_text(visit_url("place.php?whichplace=forestvillage"), "The Florist Friar's Cottage") && !florist_available())
		{
			print("Mafia does not think you have a Florist Friar but one seems to live in your forest.", "red");
			trickMafiaAboutFlorist();
			if(florist_available())
			{
				print("Deception successful, Mafia now realizes you have a Florist Friar.", "blue");
			}
		}
		if((my_class() == $class[Ed]) && (my_level() == 11) && (item_amount($item[7961]) > 0))
		{
			cli_execute("refresh inv");
		}
	}


	if(doHRSkills())
	{
		return true;
	}
	handleJar();

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
		boolean tooManyAdventures = false;
		if(($locations[The Battlefield (Frat Uniform), The Battlefield (Hippy Uniform), The Deep Dark Jungle, Hippy Camp, Noob Cave, Pirates of the Garbage Barges, The Secret Government Laboratory, Sloppy Seconds Diner, The SMOOCH Army HQ, Uncle Gator\'s Country Fun-Time Liquid Waste Sluice, VYKEA, The X-32-F Combat Training Snowman] contains my_location()) == false)
		{
			tooManyAdventures = true;
		}

		if(tooManyAdventures && (my_path() == "The Source"))
		{
			if($locations[The Haunted Bathroom, The Haunted Bedroom, The Haunted Gallery] contains my_location())
			{
				tooManyAdventures = false;
			}
		}

		if(tooManyAdventures)
		{
			abort("We have spent over 50 turns at '" + my_location() + "' and that is bad... aborting.");
		}
	}

	dna_sorceressTest();
	dna_generic();

	if(get_property("cc_useCubeling").to_boolean())
	{
		if((item_amount($item[ring of detect boring doors]) == 1) && (item_amount($item[eleven-foot pole]) == 1) && (item_amount($item[pick-o-matic lockpicks]) == 1))
		{
			set_property("cc_cubeItems", false);
		}
		if(get_property("cc_cubeItems").to_boolean() && (my_familiar() != $familiar[Gelatinous Cubeling]))
		{
			handleFamiliar($familiar[Gelatinous Cubeling]);
		}
	}

	if((my_daycount() == 1) && (turkeyBooze() < 5) && have_familiar($familiar[Fist Turkey]))
	{
		handleFamiliar($familiar[Fist Turkey]);
	}

	if(fortuneCookieEvent())
	{
		return true;
	}

	LX_craftAcquireItems();

	consumeStuff();
	int paintingLevel = 8;
	if(cc_my_path() == "One Crazy Random Summer")
	{
		paintingLevel = 9;
	}
	if((my_level() >= paintingLevel) && chateaumantegna_havePainting() && (my_class() == $class[Ed]) && (my_daycount() <= 3))
	{
		if((have_effect($effect[Everything Looks Yellow]) == 0) && canYellowRay())
#		if((have_effect($effect[Everything Looks Yellow]) == 0) && have_skill($skill[Wrath of Ra]) && (my_mp() >= 40))
		{
			if(chateaumantegna_usePainting())
			{
				return true;
			}
		}
	}

	if((my_level() >= 9) && !get_property("_photocopyUsed").to_boolean() && (my_class() == $class[Ed]) && (my_daycount() < 3))
	{
		if(handleFaxMonster($monster[Lobsterfrogman]))
		{
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

	//Handle most quests, if we are Actually Ed the Undying
	if(LM_edTheUndying())
	{
		return true;
	}
	if(LM_boris())
	{
		return true;
	}

	if(organsFull() && (my_adventures() < 10) && chateaumantegna_havePainting() && (my_daycount() == 1) && (my_class() != $class[Ed]))
	{
		if(chateaumantegna_usePainting())
		{
#			ccAdv(1, $location[Noob Cave]);
			return true;
		}
	}
	if((my_level() >= 8) && chateaumantegna_havePainting() && (my_daycount() == 2) && (my_class() != $class[Ed]))
	{
		if(chateaumantegna_usePainting())
		{
#			ccAdv(1, $location[Noob Cave]);
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

	if(snojoFightAvailable() && (my_daycount() == 2) && (get_property("snojoMoxieWins").to_int() == 10))
	{
		handleFamiliar($familiar[Ms. Puck Man]);
		ccAdv(1, $location[The X-32-F Combat Training Snowman]);
		handleFamiliar("item");
		return true;
	}

	if(Lx_resolveSixthDMT())
	{
		return true;
	}

	if(LX_dinseylandfillFunbucks())
	{
		return true;
	}

	if(L12_flyerFinish())
	{
		return true;
	}

	if((my_level() >= 12) && (item_amount($item[rock band flyers]) == 0) && (item_amount($item[jam band flyers]) == 0) && (get_property("flyeredML").to_int() < 10000) && ((get_property("cc_hiddenapartment") == "0") || (get_property("cc_hiddenapartment") == "finished")) && ((have_effect($effect[ultrahydrated]) == 0) || (get_property("desertExploration").to_int() >= 100)))
	{
		if(L12_getOutfit() || L12_startWar())
		{
			return true;
		}
	}

	if(LX_guildUnlock())
	{
		return true;
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

	# Should check that we can actually get goofballs first. Should be migrated to cc_util
	if(get_property("lastGoofballBuy").to_int() != my_ascensions())
	{
		visit_url("place.php?whichplace=woods");
		print("Got Goofballs", "blue");
		visit_url("tavern.php?place=susguy&action=buygoofballs", true);
		put_closet(item_amount($item[Bottle of Goofballs]), $item[Bottle of Goofballs]);
	}

	if(LX_bitchinMeatcar())
	{
		return true;
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

	if((my_level() >= 7) && (my_daycount() != 2) && LX_freeCombats())
	{
		return true;
	}

	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}

	if(LX_steelOrgan())
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

	if(L12_flyerBackup() || Lsc_flyerSeals())
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

	if(L11_nostrilOfTheSerpent() || L11_unlockHiddenCity())
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

	if(L11_hiddenCity())
	{
		return true;
	}

	if(L11_palindome())
	{
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

	if(L12_orchardStart() || L12_filthworms() || L12_orchardFinalize())
	{
		return true;
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

	if(L12_lastDitchFlyer())
	{
		return true;
	}

	if((get_property("hippiesDefeated").to_int() < 64) && (get_property("fratboysDefeated").to_int() < 64) && (my_level() >= 12))
	{
		print("First 64 combats. To orchard/lighthouse", "blue");
		handleFamiliar("item");
		warOutfit();
		return warAdventure();
	}

	if((get_property("hippiesDefeated").to_int() < 192) && (get_property("fratboysDefeated").to_int() < 192) && (my_level() >= 12))
	{
		print("Getting to the nunnery/junkyard", "blue");
		handleFamiliar("item");
		warOutfit();
		return warAdventure();
	}

	if((get_property("cc_nuns") == "done") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		handleFamiliar("item");
		warOutfit();
		return warAdventure();
	}

	if((get_property("cc_nuns") == "finished") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		handleFamiliar("item");
		warOutfit();
		return warAdventure();
	}

	if(L13_towerNSEntrance() || L13_towerNSContests() || L13_towerNSHedge() || L13_sorceressDoor() || L13_towerNSTower())
	{
		return true;
	}

	if(L13_towerNSNagamar() || L13_towerNSTransition() || L13_towerNSFinal())
	{
		return true;
	}

	if(L13_ed_councilWarehouse())
	{
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

#	if(my_class() == $class[Astral Spirit])
	if(to_string(my_class()) == "Astral Spirit")
	{
		# my_class() can report Astral Spirit even though it is not a valid class....
		print("We think we are an Astral Spirit, if you actually are that's bad!", "red");
		cli_execute("refresh all");
	}

#	cli_execute("spookyraven on");
	cli_execute("spookyraven off");

	print("Hello " + my_name() + ", time to explode!");
	print("This is version: " + svn_info("ccascend-cc_ascend").last_changed_rev);
	print("This is day " + my_daycount() + ".");
	print("Turns played: " + my_turncount() + " current adventures: " + my_adventures());
	print("Current Ascension: " + cc_my_path());

	set_property("cc_disableAdventureHandling", "no");
	set_property("cc_bedroomHandler1", "no");
	set_property("cc_bedroomHandler2", "no");

	settingFixer();

	uneffect($effect[Ode To Booze]);
	handlePulls(my_daycount());
	initializeDay(my_daycount());

	backupSetting("autoSatisfyWithCoinmasters", true);
	backupSetting("removeMalignantEffects", false);
#	if(!get_property("autoSatisfyWithCoinmasters").to_boolean())
#	{
#		set_property("cc_priorCoinmasters", true);
#		set_property("autoSatisfyWithCoinmasters", true);
#	}

#	set_property_ifempty("cc_kingLiberatedScript", get_property("kingLiberatedScript"));
#	set_property_ifempty("cc_afterAdventureScript", get_property("afterAdventureScript"));
#	set_property_ifempty("cc_betweenAdventureScript", get_property("betweenAdventureScript"));
#	set_property_ifempty("cc_betweenBattleScript", get_property("betweenBattleScript"));

	backupSetting("kingLiberatedScript", "scripts/kingcheese.ash");
	backupSetting("afterAdventureScript", "scripts/postcheese.ash");
	backupSetting("betweenAdventureScript", "scripts/precheese.ash");
	backupSetting("betweenBattleScript", "scripts/precheese.ash");

#	set_property("kingLiberatedScript", "scripts/kingcheese.ash");
#	set_property("afterAdventureScript", "scripts/postcheese.ash");
#	set_property("betweenAdventureScript", "scripts/precheese.ash");
#	set_property("betweenBattleScript", "scripts/precheese.ash");


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

	ed_initializeSession();

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
		equipBaseline();
		handleFamiliar("item");
		if(item_amount($item[Boris\'s Helm]) > 0)
		{
			equip($item[Boris\'s Helm]);
		}
		if((item_amount($item[fudgecycle]) > 0) && can_equip($item[fudgecycle]))
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

