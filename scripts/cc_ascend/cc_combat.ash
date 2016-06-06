script "cc_combat.ash"
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_equipment.ash>
import <cc_ascend/cc_edTheUndying.ash>

monster ocrs_helper(string page);
void awol_helper(string page);

monster ocrs_helper(string page)
{
	if(my_path() != "One Crazy Random Summer")
	{
		abort("Should not be in ocrs_helper if not on the path!");
	}

	string combatState = get_property("cc_combatHandler");

	//	ghostly				physical resistance
	//	untouchable			damage reduced to 5, instant kills still good (much less of an issue now

	/*
		For no staggers, don\'t use staggers
		For blocks skills/combat items, we can probably set them all to used as well.
	*/

	if(isFreeMonster(last_monster()))
	{
		if((!contains_text(combatState, "cleesh")) && have_skill($skill[cleesh]) && (my_mp() > 10))
		{
			set_property("cc_useCleesh", false);
			set_property("cc_combatHandler", combatState + "(cleesh)");
		}
	}

	if(last_monster().random_modifiers["unstoppable"])
	{
		if(!contains_text(combatState, "unstoppable"))
		{
			set_property("cc_combatHandler", combatState + "(DNA)(air dirty laundry)(ply reality)(indigo cup)(love mosquito)(blue balls)(love gnats)(unstoppable)");
			#Block weaksauce and pocket crumbs?
		}
	}

	if(last_monster().random_modifiers["annoying"])
	{
		if(contains_text(page, "makes the most annoying noise you've ever heard, stopping you in your tracks."))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		set_property("cc_funCombatHandler", get_property("cc_combatHandler"));
	}

	if(last_monster().random_modifiers["restless"])
	{
		if(contains_text(page, "moves out of the way"))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		if(contains_text(page, "quickly moves out of the way"))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		if(contains_text(page, "will have moved by the time"))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}

		set_property("cc_funCombatHandler", get_property("cc_combatHandler"));
	}

	if(last_monster().random_modifiers["phase-shifting"])
	{
		if(contains_text(page, "blinks out of existence before"))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		set_property("cc_funCombatHandler", get_property("cc_combatHandler"));
	}

	if(last_monster().random_modifiers["cartwheeling"])
	{
		if(contains_text(page, "cartwheels out of the way"))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		set_property("cc_funCombatHandler", get_property("cc_combatHandler"));
	}

	set_property("cc_useCleesh", false);
	if(last_monster().random_modifiers["ticking"])
	{
		if((!contains_text(combatState, "cleesh")) && have_skill($skill[cleesh]) && (my_mp() > 10))
		{
			set_property("cc_useCleesh", true);
		}
	}
	if(last_monster().random_modifiers["untouchable"])
	{
		if((!contains_text(combatState, "cleesh")) && have_skill($skill[cleesh]) && (my_mp() > 10))
		{
			set_property("cc_useCleesh", true);
		}
	}
	return last_monster();
}

void awol_helper(string page)
{
	//Let us self-contain this so it is quick to remove later.
	if((my_daycount() == 1) && (my_turncount() < 10))
	{
		set_property("cc_noSnakeOil", 0);
	}

	string combatState = get_property("cc_combatHandler");
	if(contains_text(page, "Your oil extractor is completely clogged up at this point"))
	{
		set_property("cc_noSnakeOil", my_daycount());
	}
	if(get_property("_oilExtracted").to_int() >= 100)
	{
		set_property("cc_noSnakeOil", my_daycount());
	}

	if((!contains_text(combatState, "extractSnakeOil")) && (get_property("cc_noSnakeOil").to_int() == my_daycount()))
	{
		set_property("cc_combatHandler", combatState + "(extractSnakeOil)");
	}
}

string cc_combatHandler(int round, string opp, string text)
{
	#print("cc_combatHandler: " + round, "brown");
	#Yes, round 0, really.
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
		set_property("cc_funCombatHandler", "");
		set_property("cc_funPrefix", "");
		set_property("cc_combatHandlerThunderBird", "0");
		set_property("cc_combatHandlerFingernailClippers", "0");
	}

	set_property("cc_diag_round", round);

	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	if(my_path() == "One Crazy Random Summer")
	{
		enemy = ocrs_helper(text);
		enemy = last_monster();
	}
	if(my_path() == "Avatar of West of Loathing")
	{
		awol_helper(text);
	}

	phylum type = monster_phylum(enemy);

	phylum fish = $phylum[fish];
	phylum construct = $phylum[construct];
	phylum constellation = $phylum[constellation];
	phylum current = to_phylum(get_property("dnaSyringe"));

	string combatState = get_property("cc_combatHandler");
	int thunderBirdsLeft = get_property("cc_combatHandlerThunderBird").to_int();
	int fingernailClippersLeft = get_property("cc_combatHandlerFingernailClippers").to_int();

	#Handle different path is monster_level_adjustment() > 150 (immune to staggers?)
	int mcd = monster_level_adjustment();

	boolean doBanisher = !get_property("kingLiberated").to_boolean();

	if(enemy == $monster[Source Agent])
	{
		if(have_skill($skill[Data Siphon]))
		{
			if(my_mp() < 50)
			{
				if(have_skill($skill[Source Punch]) && (my_mp() >= mp_cost($skill[Source Punch])))
				{
					return "skill " + $skill[Source Punch];
				}
			}
			else if(my_mp() > 125)
			{
				if(!contains_text(combatState, "(reboot)") && have_skill($skill[Reboot]) && (my_mp() >= mp_cost($skill[Reboot])))
				{
					set_property("cc_combatHandler", combatState + "(reboot)");
					return "skill " + $skill[Reboot];
				}
				if(!contains_text(combatState, "(big guns)") && have_skill($skill[Big Guns]) && (my_mp() >= mp_cost($skill[Big Guns])) && (my_hp() < 100))
				{
					set_property("cc_combatHandler", combatState + "(big guns)");
					return "skill " + $skill[Big Guns];
				}

			}
			else if(my_mp() > 100)
			{
				if(!contains_text(combatState, "(humiliatingHack)") && have_skill($skill[Humiliating Hack]) && (my_mp() >= mp_cost($skill[Humiliating Hack])))
				{
					set_property("cc_combatHandler", combatState + "(humiliatingHack)");
					return "skill " + $skill[Humiliating Hack];
				}
				if(!contains_text(combatState, "(disarmament)") && have_skill($skill[Disarmament]) && (my_mp() >= mp_cost($skill[Disarmament])))
				{
					set_property("cc_combatHandler", combatState + "(disarmament)");
					return "skill " + $skill[Disarmament];
				}
			}
			else
			{
				if(have_skill($skill[Source Kick]) && (my_mp() >= mp_cost($skill[Source Kick])))
				{
					return "skill " + $skill[Source Kick];
				}
			}
		}

		if((!contains_text(combatState, "big guns")) && (have_skill($skill[Big Guns])) && (my_mp() >= mp_cost($skill[Big Guns])))
		{
			set_property("cc_combatHandler", combatState + "(big guns)");
			return "skill " + $skill[Big Guns];
		}
		if(have_skill($skill[Source Punch]) && (my_mp() >= mp_cost($skill[Source Punch])))
		{
			return "skill " + $skill[Source Punch];
		}
		return "runaway";
	}

//	if(enemy == $monster[Your Shadow])
	if((enemy == $monster[Your Shadow]) || (opp == "shadow cow puncher") || (opp == "shadow snake oiler") || (opp == "shadow beanslinger"))
	{
		if(have_skill($skill[Ambidextrous Funkslinging]))
		{
			if(item_amount($item[gauze garter]) >= 2)
			{
				return "item gauze garter, gauze garter";
			}
			if(item_amount($item[filthy poultice]) >= 2)
			{
				return "item filthy poultice, filthy poultice";
			}
			if((item_amount($item[gauze garter]) > 0) && (item_amount($item[filthy poultice]) > 0))
			{
				return "item gauze garter, filthy poultice";
			}
		}
		if(item_amount($item[gauze garter]) > 0)
		{
			return "item gauze garter";
		}
		if(item_amount($item[filthy poultice]) > 0)
		{
			return "item filthy poultice";
		}
		if(item_amount($item[rain-doh indigo cup]) > 0)
		{
			return "item rain-doh indigo cup";
		}
		return "skill something I don't have, I just want to abort";
	}

	if(enemy == $monster[Wall of Meat])
	{
		if((!contains_text(combatState, "makeitrain")) && (have_skill($skill[Make It Rain])) && (my_rain() >= 10))
		{
			set_property("cc_combatHandler", combatState + "(makeitrain)");
			return "skill make it rain";
		}
	}

	if(enemy == $monster[wall of skin])
	{
		if(item_amount($item[beehive]) > 0)
		{
			return "item beehive";
		}
#		if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
#		{
#			set_property("cc_combatHandler", combatState + "(love stinkbug)");
#			return "skill summon love stinkbug";
#		}

		if((!contains_text(combatState, "shell up")) && have_skill($skill[Shell Up]) && (my_mp() >= 6) && (round >= 3))
		{
			set_property("cc_combatHandler", combatState + "(shell up)");
			return "skill shell up";
		}

		if((!contains_text(combatState, "sauceshell")) && have_skill($skill[Sauceshell]) && (my_mp() >= 35) && (round >= 4))
		{
			set_property("cc_combatHandler", combatState + "(sauceshell)");
			return "skill sauceshell";
		}

		if(have_equipped($item[Astral Shirt]))
		{
			if(have_skill($skill[headbutt]) && (my_mp() >= 3))
			{
				return "skill " + $skill[Headbutt];
			}
			if(have_skill($skill[clobber]) && (my_mp() >= mp_cost($skill[Clobber])))
			{
				return "skill " + $skill[Clobber];
			}
		}
		if(have_skill($skill[Belch the Rainbow]) && (my_mp() >= mp_cost($skill[Belch the Rainbow])))
		{
			return "skill " + $skill[Belch the Rainbow];
		}
		return "attack with weapon";
	}

	if(enemy == $monster[wall of bones])
	{
		if(item_amount($item[electric boning knife]) > 0)
		{
			return "item electric boning knife";
		}
		if(((my_hp() * 4) < my_maxhp()) && (have_effect($effect[Takin\' It Greasy]) > 0))
		{
			return "skill unleash the greash";
		}

		if((my_mp() >= 50) && have_skill($skill[Garbage Nova]))
		{
			return "skill garbage nova";
		}

		if((my_mp() >= 24) && have_skill($skill[Saucegeyser]))
		{
			return "skill saucegeyser";
		}
	}


	if((!contains_text(combatState, "blackbox")) && (my_path() != "Heavy Rains") && (enemy == $monster[Writing Desk]) && (get_property("writingDesksDefeated").to_int() < 4) && (get_property("cc_spookyravennecklace") != "done") && (get_property("_raindohCopiesMade").to_int() < 5))
	{
		set_property("cc_doCombatCopy", "yes");
	}
	if((!contains_text(combatState, "blackbox")) && (my_path() != "Heavy Rains") && (enemy == $monster[Gaudy Pirate]) && (get_property("cc_gaudypiratecount").to_int() < 1) && (get_property("_raindohCopiesMade").to_int() < 5))
	{
		set_property("cc_doCombatCopy", "yes");
	}
	if((!contains_text(combatState, "blackbox")) && (my_path() != "Heavy Rains") && (enemy == $monster[Modern Zmobie]) && (get_property("cc_modernzmobiecount").to_int() < 3) && (get_property("_raindohCopiesMade").to_int() < 5))
	{
		set_property("cc_doCombatCopy", "yes");
	}

	if(have_effect($effect[temporary amnesia]) > 0)
	{
		return "attack with weapon";
	}

	if(!contains_text(combatState, "abstraction") && in_ronin())
	{
		if((item_amount($item[Abstraction: Sensation]) > 0) && (enemy == $monster[Performer of Actions]))
		{
			#	Change +100% Moxie to +100% Init
			set_property("cc_combatHandler", combatState + "(abstraction)");
			return "item abstraction: sensation";
		}
		if((item_amount($item[Abstraction: Thought]) > 0) && (enemy == $monster[Perceiver of Sensations]))
		{
			# Change +100% Myst to +100% Items
			set_property("cc_combatHandler", combatState + "(abstraction)");
			return "item abstraction: thought";
		}
		if((item_amount($item[Abstraction: Action]) > 0) && (enemy == $monster[Thinker of Thoughts]))
		{
			# Change +100% Muscle to +10 Familiar Weight
			set_property("cc_combatHandler", combatState + "(abstraction)");
			return "item abstraction: action";
		}
	}


	if((!contains_text(combatState, "tunneldownwards")) && (have_effect($effect[Shape of...Mole!]) > 0) && (my_location() == $location[Mt. Molehill]))
	{
		set_property("cc_combatHandler", combatState + "(tunneldownwards)");
		return "skill tunnel downwards";
	}

	if((my_familiar() == $familiar[Stocking Mimic]) && (round < 12))
	{
		if(item_amount($item[Dictionary]) > 0)
		{
			return "item dictionary";
		}
	}

	if(!contains_text(combatState, "pickpocket") && ((my_class() == $class[Disco Bandit]) || (my_class() == $class[Accordion Thief])) && contains_text(text, "value=\"Pick") && ((expected_damage() * 2) < my_hp()))
	{
		boolean tryIt = false;
		foreach i, drop in item_drops_array(enemy)
		{
			if(drop.type == "0")
			{
				tryIt = true;
			}
			if((drop.rate > 0) && (drop.type != "n") && (drop.type != "c") && (drop.type != "b"))
			{
				tryIt = true;
			}
		}
		if(tryIt)
		{
			set_property("cc_combatHandler", combatState + "(pickpocket)");
			string attemptSteal = steal();
			return "pickpocket";
		}
	}

	if(!contains_text(combatState, "stealaccordion") && (my_class() == $class[Accordion Thief]) && have_skill($skill[Steal Accordion]) && ((expected_damage() * 2) < my_hp()))
	{
		set_property("cc_combatHandler", combatState + "(stealaccordion)");
		return "skill " + $skill[Steal Accordion];
	}

	if(get_property("cc_useTatter").to_boolean())
	{
		if(item_amount($item[Tattered Scrap of Paper]) > 0)
		{
			return "item Tattered Scrap of Paper";
		}
	}

	if((get_property("cc_usePowerPill").to_boolean()) && (get_property("_powerPillUses").to_int() < 20) && !enemy.boss)
	{
		if(item_amount($item[Power Pill]) > 0)
		{
			return "item Power Pill";
		}
	}


	if(get_property("cc_useCleesh").to_boolean())
	{
		if((!contains_text(combatState, "cleesh")) && have_skill($skill[cleesh]) && (my_mp() > 10))
		{
			set_property("cc_useCleesh", false);
			set_property("cc_combatHandler", combatState + "(cleesh)");
			return "skill cleesh";
		}
	}

	if(thunderBirdsLeft > 0)
	{
		thunderBirdsLeft = thunderBirdsLeft - 1;
		if(thunderBirdsLeft == 0)
		{
			set_property("cc_combatHandler", combatState + "(thunderbird)");
		}
		set_property("cc_combatHandlerThunderBird", "" + thunderBirdsLeft);
		return "skill thunder bird";
	}

	if((!contains_text(combatState, "thunderstrike")) && (monster_level_adjustment() <= 150) && have_skill($skill[Thunder Bird]))
	{
		if((enemy == $monster[big wisnaqua]) ||
			(enemy == $monster[the big wisniewski]) ||
			(enemy == $monster[the man]) ||
			(enemy == $monster[the aquaman]) ||
			(enemy == $monster[the rain king]))
		{
			if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= 60))
			{
				set_property("cc_combatHandler", combatState + "(weaksauce)");
				return "skill curse of weaksauce";
			}

			set_property("cc_combatHandler", combatState + "(thunderstrike)");
			set_property("cc_combatHandlerThunderBird", "5");
			return "skill thunderstrike";
		}
	}

	if((my_location() == $location[The Battlefield (Frat Uniform)]) && (enemy == $monster[gourmet gourami]))
	{
		if((item_amount($item[louder than bomb]) > 0) && (get_property("cc_gremlins") == "finished"))
		{
			handleTracker(enemy, $item[louder than bomb], "cc_banishes");
			return "item louder than bomb";
		}
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(combatState, "makeitrain")) && (get_property("cc_nunsTrickReady") == "yes"))
	{
		if((my_rain() > rain_cost($skill[Make It Rain])) && (have_skill($skill[make it rain])))
		{
			set_property("cc_combatHandler", combatState + "(makeitrain)");
			return "skill " + $skill[Make It Rain];
		}
	}

	if((enemy == $monster[hellseal pup]) && (my_class() == $class[Seal Clubber]))
	{
		return "skill clobber";
	}

	if((enemy == $monster[mother hellseal]) && (my_class() == $class[Seal Clubber]))
	{
		if((!contains_text(combatState, "indigo cup")) && (item_amount($item[rain-doh indigo cup]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(indigo cup)");
			return "item rain-doh indigo cup";
		}
		return "skill lunging thrust-smack";
	}

	if((enemy == $monster[French Guard Turtle]) && have_equipped($item[Fouet de tortue-dressage]) && (my_mp() >= mp_cost($skill[Apprivoisez La Tortue])))
	{
		return "skill " + $skill[Apprivoisez La Tortue];
	}

	#Do not accidentally charge the nanorhino with a non-banisher
	if((my_familiar() == $familiar[Nanorhino]) && (have_effect($effect[Nanobrawny]) == 0))
	{
		foreach it in $skills[toss, clobber, shell up, lunge smack, thrust-smack, headbutt, kneebutt, lunging thrust-smack, club foot, shieldbutt, spirit snap, cavalcade of fury, northern explosion, spectral snapper, Harpoon!, Summon Leviatuga]
		{
			if(have_skill(it) && (my_mp() >= mp_cost(it)))
			{
				return "skill " + it;
			}
		}
	}

	if((!contains_text(combatState, "nanotoss")) && (have_effect($effect[Nanobrawny]) >= 40))
	{
		#if appropriate enemy, then banish
		if(enemy == $monster[pygmy janitor])
		{
			set_property("cc_combatHandler", combatState + "(nanotoss)");
			return "skill unleash nanites";
		}
	}

	if((!contains_text(combatState, "winkat")) && (my_familiar() == $familiar[Reanimated Reanimator]))
	{
		if((enemy == $monster[lobsterfrogman]) ||
			(enemy == $monster[modern zmobie]) ||
			(enemy == $monster[ninja snowman assassin]) ||
			(enemy == $monster[Writing desk]))
		{
			set_property("cc_combatHandler", combatState + "(winkat)");
			if((get_property("_badlyRomanticArrows").to_int() == 1) && (round <= 1) && (get_property("romanticTarget") != enemy))
			{
				abort("Have animator out but can not arrow");
			}
			if(enemy == $monster[modern zmobie])
			{
				set_property("cc_waitingArrowAlcove", get_property("cyrptAlcoveEvilness").to_int() - 20);
			}
			return "skill wink at";
		}
	}

	if((!contains_text(combatState, "blackbox")) && (get_property("cc_doCombatCopy") == "yes") && (enemy != $monster[gourmet gourami]) && (item_amount($item[Rain-Doh Black Box]) > 0))
	{
		set_property("cc_doCombatCopy", "no");
		set_property("cc_combatHandler", combatState + "(blackbox)");
		if(get_property("_raindohCopiesMade").to_int() < 5)
		{
			return "item rain-doh black box";
		}
		print("Can not issue copy directive because we have no copies left", "red");
	}
	if(get_property("cc_doCombatCopy") == "yes")
	{
		set_property("cc_doCombatCopy", "no");
	}

	if((enemy == $monster[plaid ghost]) && (item_amount($item[T.U.R.D.S. Key]) > 0))
	{
		return "item t.u.r.d.s. key";
	}

	if((enemy == $monster[tomb rat]) && (item_amount($item[tangle of rat tails]) > 0))
	{
		return "item tangle of rat tails";
	}

	if((enemy == $monster[storm cow]) && (have_skill($skill[unleash the greash])))
	{
		return "skill unleash the greash";
	}

	if(fingernailClippersLeft > 0)
	{
		fingernailClippersLeft = fingernailClippersLeft - 1;
		if(fingernailClippersLeft == 0)
		{
			set_property("cc_combatHandler", combatState + "(fingernail clippers)");
		}
		set_property("cc_combatHandlerFingernailClippers", "" + fingernailClippersLeft);
		return "item military-grade fingernail clippers";
	}

	#Is $monster[one of doctor weirdeaux's creations valid yet?
	if((item_amount($item[military-grade fingernail clippers]) > 0)  && (my_location() == $location[The Mansion of Dr. Weirdeaux]))
	{
		if(!contains_text(combatState, "fingernail clippers"))
		{
			fingernailClippersLeft = 3;
			set_property("cc_combatHandlerFingernailClippers", "3");
		}
	}

	if((!contains_text(combatState, "(extract)")) && have_skill($skill[Extract]) && (my_mp() > (mp_cost($skill[Extract]) * 2)) && get_property("kingLiberated").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(extract)");
		return "skill " + $skill[Extract];
	}


	if(have_skill($skill[Summon Mayfly Swarm]) && (!contains_text(combatState, "mayfly")))
	{
		if((equipped_item($slot[acc1]) == $item[Mayfly Bait Necklace]) || (equipped_item($slot[acc2]) == $item[Mayfly Bait Necklace]) || (equipped_item($slot[acc3]) == $item[Mayfly Bait Necklace]))
		{
			if((my_location() == $location[Dreadsylvanian Village]) || (my_location() == $location[Dreadsylvanian Castle]) || (my_location() == $location[Dreadsylvanian Woods]) || (my_location() == $location[Sloppy Seconds Diner]) || (my_location() == $location[The Ice Hole]))
			{
				set_property("cc_combatHandler", combatState + "(mayfly)");
				return "skill summon mayfly swarm";
			}
		}
	}


	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && (!contains_text(combatState, "insults")) && (numPirateInsults() < 8))
	{
		if((my_location() == $location[The Obligatory Pirate\'s Cove]) || (my_location() == $location[barrrney\'s barrr]) ||
			(enemy == $monster[gaudy pirate]))
		{
			set_property("cc_combatHandler", combatState + "(insults)");
			return "item the big book of pirate insults";
		}
	}

	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40))
	{
		if((enemy == $monster[pygmy shaman]) && (my_location() == $location[The Hidden Apartment Building]) && (item_amount($item[soft green echo eyedrop antidote]) > 3))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
		if((enemy == $monster[Gladiator]) && (my_location() == $location[The Roman Forum]))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
	}

	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && get_property("kingLiberated").to_boolean())
	{
		if(enemy == $monster[Gurgle the Turgle])
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
	}



	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && (!have_skill($skill[Rain Man]) || get_property("cc_100familiar").to_boolean()))
	{
		if((enemy == $monster[writing desk]) && (my_location() == $location[The Haunted Library]) && (get_property("cc_spookyravennecklace") != "done"))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
	}

	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && (enemy == $monster[Smoke Monster]) && (item_amount($item[Pack Of Smokes]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(olfaction)");
		handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
		return "skill transcendent olfaction";
	}


	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= mp_cost($skill[Transcendent Olfaction])))
	{
		if($monsters[Blooper, Bob Racecar, cabinet of Dr. Limpieza, Dairy Goat, Morbid Skull, Pygmy Bowler, Pygmy Witch Surgeon, Quiet Healer, Racecar Bob, Tomb Rat] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleTracker(enemy, $skill[Transcendent Olfaction], "cc_sniffs");
			return "skill transcendent olfaction";
		}
	}
	if(!contains_text(get_property("longConMonster"),enemy) && have_skill($skill[Long Con]) && (my_mp() >= mp_cost($skill[Long Con])) && (get_property("_longConUsed").to_int() < 5))
	{
		if($monsters[Blooper, cabinet of Dr. Limpieza, Dairy Goat, Dirty Old Lihc, Gaudy Pirate, Morbid Skull, Pygmy Bowler, Pygmy Witch Surgeon, Quiet Healer, Tomb Rat, Writing Desk] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(longcon)");
			handleTracker(enemy, $skill[Long Con], "cc_sniffs");
			return "skill " + $skill[Long Con];
		}


		if(($monsters[Bob Racecar, Racecar Bob] contains enemy) && (get_property("palindomeDudesDefeated").to_int() < 5) && !contains_text(get_property("longConMonster"), $monster[Racecar Bob]) && !contains_text(get_property("longConMonster"), $monster[Bob Racecar]))
		{
			set_property("cc_combatHandler", combatState + "(longcon)");
			handleTracker(enemy, $skill[Long Con], "cc_sniffs");
			return "skill " + $skill[Long Con];
		}
	}


	if(contains_text(combatState, "insults"))
	{
		if((enemy == $monster[shady pirate]) && have_skill($skill[Thunder Clap]) && (my_thunder() >= 40))
		{
			handleTracker(enemy, $skill[thunder clap], "cc_banishes");
			return "skill thunder clap";
		}
		if(enemy == $monster[shifty pirate])
		{
			if(get_property("_pantsgivingBanish").to_int() < 5)
			{
				handleTracker(enemy, $skill[talk about politics], "cc_banishes");
				return "skill talk about poltiics";
			}
		}
		if((my_lightning() >= 25) && !isFreeMonster(enemy) && !enemy.boss)
		{
			if(have_skill($skill[lightning strike]))
			{
				handleTracker(enemy, $skill[lightning strike], "cc_instakill");
				return "skill lightning strike";
			}
		}
	}

	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]) && (my_location() != $location[The Battlefield (Hippy Uniform)]) && ((item_amount($item[rock band flyers]) > 0) || (item_amount($item[jam band flyers]) > 0)))
	{
		if(!contains_text(combatState, "beanscreen") && have_skill($skill[Beanscreen]) && (my_mp() >= mp_cost($skill[Beanscreen])))
		{
			set_property("cc_combatHandler", combatState + "(beanscreen)");
			return "skill " + $skill[Beanscreen];
		}

		if(!contains_text(combatState, "broadside") && have_skill($skill[Broadside]) && (my_mp() >= mp_cost($skill[Broadside])))
		{
			set_property("cc_combatHandler", combatState + "(broadside)");
			return "skill " + $skill[Broadside];
		}

		if(!contains_text(combatState, "soulbubble") && have_skill($skill[Soul Saucery]) && (my_soulsauce() >= soulsauce_cost($skill[Soul Bubble])))
		{
			set_property("cc_combatHandler", combatState + "(soulbubble)");
			return "skill " + $skill[Soul Bubble];
		}

		if(!contains_text(combatState, "hogtie") && !contains_text(combatState, "beanscreen") && have_skill($skill[Hogtie]) && (my_mp() >= (6 * mp_cost($skill[Hogtie]))) && hasLeg(enemy))
		{
			set_property("cc_combatHandler", combatState + "(hogtie)");
			return  "skill " + $skill[Hogtie];
		}

		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
		if((item_amount($item[jam band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item jam band flyers";
		}
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(combatState, "4dcamera")) && (get_property("cc_nunsTrickActive") == "yes") && (item_amount($item[4-d Camera]) == 1) && (get_property("_cameraUsed").to_boolean() != true))
	{
		set_property("cc_combatHandler", combatState + "(4dcamera)");
		return "item 4-d camera";
	}

	if((enemy == $monster[clingy pirate (female)]) && (item_amount($item[cocktail napkin]) > 0))
	{
		return "item cocktail napkin";
	}

	if((enemy == $monster[clingy pirate (male)]) && (item_amount($item[cocktail napkin]) > 0))
	{
		return "item cocktail napkin";
	}
	if((!contains_text(combatState, "DNA")) && (monster_level_adjustment() < 150) && (item_amount($item[DNA Extraction Syringe]) > 0))
	{
		if(type != current)
		{
			set_property("cc_combatHandler", combatState + "(DNA)");
			return "item DNA extraction syringe";
		}
	}

	if(!contains_text(combatState, "yellowray"))
	{
		boolean doYellow = false;
		if((enemy == $monster[burly sidekick]) && !possessEquipment($item[Mohawk Wig]))
		{
			doYellow = true;
		}
		if((enemy == $monster[Quiet Healer]) && !possessEquipment($item[Amulet of Extreme Plot Significance]) && (get_property("cc_airship") == "finished"))
		{
			doYellow = true;
		}
		if((get_property("cc_nunsTrickGland") == "start") && (enemy == $monster[larval filthworm]))
		{
			doYellow = true;
		}
		if(($monsters[Filthworm Royal Guard, Knob Goblin Harem Girl] contains enemy) ||
			((enemy == $monster[orcish frat boy spy]) && (my_daycount() == 1)) ||
			((enemy == $monster[War Frat 151st Infantryman]) && (my_daycount() == 4)))
		{
			doYellow = true;
		}

		if(doYellow)
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
				print("Wanted a yellow ray but we can not find one.", "red");
			}
		}
	}

	if(contains_text(combatState, "yellowray"))
	{
		abort("Ugh, where is my damn yellowray!!!");
	}

	if((enemy == $monster[animated possessions]) || (enemy == $monster[natural spider]))
	{
		if(item_amount($item[green smoke bomb]) > 0)
		{
			return "item green smoke bomb";
		}
	}

	if(get_property("kingLiberated") == "false")
	{
		if((enemy == $monster[pygmy orderlies]) ||
			(enemy == $monster[pygmy witch lawyer]) ||
			(enemy == $monster[pygmy witch nurse]))
		{
			if(item_amount($item[short writ of habeas corpus]) > 0)
			{
				return "item short writ of habeas corpus";
			}
		}
	}

	#First pass thunder clap
	if((!contains_text(combatState, "thunder clap")) && (have_skill($skill[thunder clap])) && (my_thunder() >= 40))
	{
		if((enemy == $monster[animated mahogany nightstand]) ||
			(enemy == $monster[coaltergeist]) ||
			(enemy == $monster[flock of stab-bats]) ||
			(enemy == $monster[mad wino]) ||
			(enemy == $monster[tomb servant]) ||
			(enemy == $monster[sabre-toothed goat]) ||
			(enemy == $monster[pygmy witch lawyer]) ||
			(enemy == $monster[pygmy witch nurse]) ||
			(enemy == $monster[possessed laundry press]) ||
			(enemy == $monster[mismatched twins]) ||
			(enemy == $monster[crusty pirate]))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleTracker(enemy, $skill[thunder clap], "cc_banishes");
			return "skill thunder clap";
		}
		if((enemy == $monster[burly sidekick]) && possessEquipment($item[Mohawk Wig]))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleTracker(enemy, $skill[thunder clap], "cc_banishes");
			return "skill thunder clap";
		}
		if((enemy == $monster[knob goblin madam]) && (item_amount($item[knob goblin perfume]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleTracker(enemy, $skill[thunder clap], "cc_banishes");
			return "skill thunder clap";
		}
	}

	#First pass politics
	if((!contains_text(combatState, "politics")) && (have_skill($skill[talk about politics])) && (get_property("_pantsgivingBanish").to_int() < 5))
	{
		if($monsters[Doughbat, Natural Spider, plaid ghost, slick lihc, skeletal sommelier, taco cat, wardr&ouml;b nightstand, upgraded ram] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(politics)");
			handleTracker(enemy, $skill[talk about politics], "cc_banishes");
			return "skill talk about politics";
		}
	}

	#Unlikely path: Louder than bomb
	if((!contains_text(combatState, "louderthanbomb")) && (item_amount($item[louder than bomb]) > 0))
	{
		if((enemy == $monster[tan gnat]) ||
			(enemy == $monster[natural spider]) ||
			(enemy == $monster[upgraded ram]))
		{
			set_property("cc_combatHandler", combatState + "(louderthanbomb)");
			return "item louder than bomb";
		}
	}

	#Snokebomb replace Batter Up! pass
	if((!contains_text(combatState, "snokebomb")) && (have_skill($skill[Snokebomb])) && (get_property("_snokebombUsed").to_int() < 3) && ((my_mp() - 20) >= mp_cost($skill[Snokebomb])))
	{
		if($monsters[Animated Possessions, Animated Rustic Nightstand, Bubblemint Twins, Bullet Bill, Chatty Pirate, Coaltergeist, Doughbat, Evil Olive, Knob Goblin Harem Guard, Mad Wino, Possessed Laundry Press, Procrastination Giant, Protagonist, Punk Rock Giant, Pygmy Headhunter, Pygmy Orderlies, Sabre-Toothed Goat, Skeletal Sommelier, Slick Lihc, Snow Queen, Steam Elemental, Tomb Asp] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(snokebomb)");
			handleTracker(enemy, $skill[Snokebomb], "cc_banishes");
			return "skill " + $skill[Snokebomb];
		}
	}


	#Beancannon
	if((!contains_text(combatState, "beancannon")) && (have_skill($skill[Beancannon])) && (get_property("_beancannonUsed").to_int() < 5) && ((my_mp() - 20) >= mp_cost($skill[Beancannon])))
	{
		if($monsters[Animated Possessions, Animated Rustic Nightstand, Bubblemint Twins, Bullet Bill, Chatty Pirate, Coaltergeist, Doughbat, Evil Olive, Knob Goblin Harem Guard, Mad Wino, Possessed Laundry Press, Procrastination Giant, Protagonist, Punk Rock Giant, Pygmy Headhunter, Pygmy Orderlies, Sabre-Toothed Goat, Skeletal Sommelier, Slick Lihc, Snow Queen, Steam Elemental, Tomb Asp] contains enemy)
		{
			if($items[Frigid Northern Beans, Heimz Fortified Kidney Beans, Hellfire Spicy Beans, Mixed Garbanzos and Chickpeas, Pork \'n\' Pork \'n\' Pork \'n\' Beans, Shrub\'s Premium Baked Beans, Tesla\'s Electroplated Beans, Trader Olaf\'s Exotic Stinkbeans, World\'s Blackest-Eyed Peas] contains equipped_item($slot[Off-hand]))
			{
				set_property("_beancannonUsed", get_property("_beancannonUsed").to_int() + 1);
				set_property("cc_combatHandler", combatState + "(beancannon)");
				handleTracker(enemy, $skill[Beancannon], "cc_banishes");
				return "skill " + $skill[Beancannon];
			}
		}
	}

	#Minimal Tennis Ball usage
	if((!contains_text(combatState, "tennisball")) && (item_amount($item[Tennis Ball]) > 0))
	{
		if($monsters[Tomb Servant] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(tennisball)");
			handleTracker(enemy, $item[Tennis Ball], "cc_banishes");
			return "item " + $item[Tennis Ball];
		}
	}


	if((!contains_text(combatState, "banishing shout")) && (have_skill($skill[Banishing Shout])) && (my_mp() > mp_cost($skill[Banishing Shout])) && !isBanished(enemy))
	{
		if($monsters[Animated Possessions, Animated Rustic Nightstand, Bubblemint Twins, Bullet Bill, Chatty Pirate, Coaltergeist, Drunk Goat, Evil Olive, Knob Goblin Harem Guard, Mad Wino, Natural Spider, Plaid Ghost, Possessed Laundry Press, Procrastination Giant, Protagonist, Punk Rock Giant, Pygmy Headhunter, Pygmy Janitor, Pygmy Orderlies, Senile Lihc, Skeletal Sommelier, Slick Lihc, Snow Queen, Steam Elemental, Taco Cat, Tan Gnat, Tomb Asp, Tomb Servant, wardr&ouml;b nightstand] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(banishing shout)");
			handleTracker(enemy, $skill[Banishing Shout], "cc_banishes");
			return "skill " + $skill[Banishing Shout];
		}
	}


	#Only Batter Up
	if((!contains_text(combatState, "batter up!")) && (have_skill($skill[batter up!])) && (my_fury() >= 5))
	{
		if($monsters[Animated Possessions, Animated Rustic Nightstand, Bubblemint Twins, Bullet Bill, Chatty Pirate, Coaltergeist, Drunk Goat, Evil Olive, Knob Goblin Harem Guard, Mad Wino, Possessed Laundry Press, Procrastination Giant, Protagonist, Punk Rock Giant, Pygmy Headhunter, Pygmy Orderlies, Senile Lihc, Skeletal Sommelier, Snow Queen, Steam Elemental, Tomb Asp] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(batter up!)");
			handleTracker(enemy, $skill[batter up!], "cc_banishes");
			return "skill batter up!";
		}
	}

	#Second thunder clap pass
	if((!contains_text(combatState, "thunder clap")) && (have_skill($skill[thunder clap])) && (my_thunder() >= 40))
	{
		if((enemy == $monster[plaid ghost]) ||
			(enemy == $monster[slick lihc]) ||
			(enemy == $monster[skeletal sommelier]) ||
			(enemy == $monster[procrastination giant]) ||
			(enemy == $monster[natural spider]) ||
			(enemy == $monster[steam elemental]))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleTracker(enemy, $skill[thunder clap], "cc_banishes");
			return "skill thunder clap";
		}
	}

	#Second poltiics pass
	if((!contains_text(combatState, "politics")) && (have_skill($skill[talk about politics])) && (get_property("_pantsgivingBanish").to_int() < 5))
	{
		if($monsters[Clingy Pirate (Female), Clingy Pirate (Male), Pygmy Orderlies, Tomb Asp] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(politics)");
			handleTracker(enemy, $skill[talk about politics], "cc_banishes");
			return "skill talk about politics";
		}
	}

	if((!contains_text(combatState, "snokebomb")) && (have_skill($skill[Snokebomb])) && (get_property("_snokebombUsed").to_int() < 3) && ((my_mp() - 20) >= mp_cost($skill[Snokebomb])))
	{
		if($monsters[Clingy Pirate (Female), Clingy Pirate (Male), Pygmy Orderlies, Tomb Asp] contains enemy)
		{
			set_property("cc_combatHandler", combatState + "(Snokebomb)");
			handleTracker(enemy, $skill[Snokebomb], "cc_banishes");
			return "skill " + $skill[Snokebomb];
		}
	}


	if(item_amount($item[disposable instant camera]) > 0)
	{
		if((enemy == $monster[bob racecar]) || (enemy == $monster[racecar bob]))
		{
			set_property("cc_combatHandler", combatState + "(disposable instant camera)");
			return "item disposable instant camera";
		}
	}

	if((enemy == $monster[oil cartel]) && (item_amount($item[duskwalker syringe]) > 0))
	{
		return "item duskwalker syringe";
	}

	if((!contains_text(combatState, "opium grenade")) && (item_amount($item[opium grenade]) > 0))
	{
		if(enemy == $monster[pair of burnouts])
		{
			set_property("cc_combatHandler", combatState + "(opium grenade)");
			return "item opium grendade";
		}
	}

	# Instakill handler
	if(!enemy.boss && !isFreeMonster(enemy))
	{
		if((my_lightning() >= 25) && have_skill($skill[Lightning Strike]))
		{
			if(have_skill($skill[lightning strike]))
			{
				handleTracker(enemy, $skill[lightning strike], "cc_instakill");
				return "skill " + $skill[lightning strike];
			}
		}

		if(!contains_text(combatState, "shattering punch") && have_skill($skill[Shattering Punch]) && ((my_mp() / 2) > mp_cost($skill[Shattering Punch])) && (get_property("_shatteringPunchUsed").to_int() < 3))
		{
			if((my_adventures() < 20) || get_property("kingLiberated").to_boolean() || (my_daycount() >= 3))
			{
				set_property("cc_combatHandler", combatState + "(shattering punch)");
				handleTracker(enemy, $skill[shattering punch], "cc_instakill");
				return "skill " + $skill[shattering punch];
			}
		}

//		Can not use _usedReplicaBatoomerang if we have more than 1 because of the double item use issue...
//		Sure, we can try to use a second item (if we have it or are forced to buy it... ugh).
//		if(!contains_text(combatState, "batoomerang") && (item_amount($item[Replica Bat-oomerang]) > 0) && (get_property("_usedReplicaBatoomerang").to_int() < 3))
		if(!contains_text(combatState, "batoomerang") && (item_amount($item[Replica Bat-oomerang]) > 0))
		{
			if(get_property("cc_batoomerangDay").to_int() != my_daycount())
			{
				set_property("cc_batoomerangDay", my_daycount());
				set_property("cc_batoomerangUse", 0);
			}
			if(get_property("cc_batoomerangUse").to_int() < 3)
			{
				set_property("cc_batoomerangUse", get_property("cc_batoomerangUse").to_int() + 1);
				set_property("cc_combatHandler", combatState + "(batoomerang)");
				handleTracker(enemy, $item[Replica Bat-oomerang], "cc_instakill");
				return "item " + $item[Replica Bat-oomerang];
			}
		}


		if(!contains_text(combatState, "jokesterGun") && (equipped_item($slot[Weapon]) == $item[The Jokester\'s Gun]) && !get_property("_firedJokestersGun").to_boolean() && have_skill($skill[Fire the Jokester\'s Gun]))
		{
			set_property("cc_combatHandler", combatState + "(jokesterGun)");
			handleTracker(enemy, $skill[Fire the Jokester\'s Gun], "cc_instakill");
			return "skill" + $skill[Fire the Jokester\'s Gun];
		}
	}


	if(!contains_text(combatState, "badMedicine") && have_skill($skill[Bad Medicine]) && (my_mp() >= (3 * mp_cost($skill[Bad Medicine]))))
	{
		set_property("cc_combatHandler", combatState + "(badMedicine)");
		return "skill " + $skill[Bad Medicine];
	}

	if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= 60) && have_skill($skill[Itchy Curse Finger]))
	{
		set_property("cc_combatHandler", combatState + "(weaksauce)");
		return "skill curse of weaksauce";
	}


	if((!contains_text(combatState, "intimidating bellow")) && (have_skill($skill[Intimidating Bellow])) && (my_mp() >= 25) && have_skill($skill[Louder Bellows]))
	{
		set_property("cc_combatHandler", combatState + "(intimidating bellow)");
		return "skill " + $skill[Intimidating Bellow];
	}

	#Default behaviors:
	if(mcd <= 150)
	{
		if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= 60))
		{
			set_property("cc_combatHandler", combatState + "(weaksauce)");
			return "skill curse of weaksauce";
		}

		if(!contains_text(combatState, "canhandle") && have_skill($skill[Canhandle]))
		{
			if($items[Frigid Northern Beans, Heimz Fortified Kidney Beans, Hellfire Spicy Beans, Mixed Garbanzos and Chickpeas, Pork \'n\' Pork \'n\' Pork \'n\' Beans, Shrub\'s Premium Baked Beans, Tesla\'s Electroplated Beans, Trader Olaf\'s Exotic Stinkbeans, World\'s Blackest-Eyed Peas] contains equipped_item($slot[Off-hand]))
			{
				set_property("cc_combatHandler", combatState + "(canhandle)");
				return "skill " + $skill[Canhandle];
			}
		}

		if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_class() == $class[Sauceror]) && (my_mp() >= 20))
		{
			set_property("cc_combatHandler", combatState + "(weaksauce)");
			return "skill curse of weaksauce";
		}

		if((!contains_text(combatState, "pocket crumbs")) && (have_skill($skill[pocket crumbs])))
		{
			set_property("cc_combatHandler", combatState + "(pocket crumbs)");
			return "skill pocket crumbs";
		}

		if((!contains_text(combatState, $item[Cow Poker])) && (item_amount($item[Cow Poker]) > 0))
		{
			if($monsters[Caugr, Moomy, Pharaoh Amoon-Ra Cowtep, Pyrobove, Spidercow] contains enemy)
			{
				set_property("cc_combatHandler", combatState + "(" + $item[Cow Poker] + ")");
				return "item " + $item[Cow Poker];
			}
		}


		if((!contains_text(combatState, $item[Western-Style Skinning Knife])) && (item_amount($item[Western-Style Skinning Knife]) > 0))
		{
			if($monsters[Caugr, Coal Snake, Diamondback Rattler, Frontwinder, Grizzled Bear, Mountain Lion] contains enemy)
			{
				set_property("cc_combatHandler", combatState + "(" + $item[Western-Style Skinning Knife] + ")");
				return "item " + $item[Western-Style Skinning Knife];
			}
		}

		if((!contains_text(combatState, "air dirty laundry")) && (have_skill($skill[air dirty laundry])))
		{
			set_property("cc_combatHandler", combatState + "(air dirty laundry)");
			return "skill air dirty laundry";
		}

		if((!contains_text(combatState, "cowboy kick")) && (have_skill($skill[Cowboy Kick])))
		{
			set_property("cc_combatHandler", combatState + "(cowboy kick)");
			return "skill " + $skill[Cowboy Kick];
		}

		if((!contains_text(combatState, "fire death ray")) && (have_skill($skill[Fire Death Ray])))
		{
			set_property("cc_combatHandler", combatState + "(fire death ray)");
			return "skill fire death ray";
		}

		if((!contains_text(combatState, "ply reality")) && (have_skill($skill[ply reality])))
		{
			set_property("cc_combatHandler", combatState + "(ply reality)");
			return "skill ply reality";
		}

		if((!contains_text(combatState, "indigo cup")) && (item_amount($item[rain-doh indigo cup]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(indigo cup)");
			return "item rain-doh indigo cup";
		}

		if((!contains_text(combatState, "love mosquito")) && have_skill($skill[Summon Love Mosquito]))
		{
			set_property("cc_combatHandler", combatState + "(love mosquito)");
			return "skill summon love mosquito";
		}
		if((!contains_text(combatState, "tomayohawk")) && (item_amount($item[Tomayohawk-Style Reflex Hammer]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(tomayohawk)");
			return "item " + $item[Tomayohawk-Style Reflex Hammer];
		}

		if((!contains_text(combatState, "cadenza")) && (item_type(equipped_item($slot[weapon])) == "accordion") && (my_mp() >= mp_cost($skill[Cadenza])))
		{
			if($items[Accordion of Jordion, Accordionoid Rocca, non-Euclidean non-accordion, Shakespeare\'s Sister\'s Accordion, zombie accordion] contains equipped_item($slot[weapon]))
			{
				set_property("cc_combatHandler", combatState + "(cadenza)");
				return "item " + $skill[Cadenza];
			}
		}

		if((!contains_text(combatState, "(extract)")) && have_skill($skill[Extract]) && (my_mp() > (mp_cost($skill[Extract]) * 3)))
		{
			set_property("cc_combatHandler", combatState + "(extract)");
			return "skill " + $skill[Extract];
		}


		if((!contains_text(combatState, "(scienceMedicine)")) && have_skill($skill[Science! Fight With Medicine]))
		{
			set_property("cc_combatHandler", combatState + "(scienceMedicine)");
			return "skill " + $skill[Science! Fight With Medicine];
		}

	}

	#Default behaviors, multi-staggers when chance is 50% or greater
	if(mcd < 100)
	{
		if((!contains_text(combatState, "blue balls")) && (item_amount($item[rain-doh blue balls]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(blue balls)");
			return "item rain-doh blue balls";
		}

		if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
		{
			set_property("cc_combatHandler", combatState + "(love gnats)");
			return "skill summon love gnats";
		}

		if(!contains_text(combatState, "love stinkbug") && contains_text(combatState, "love gnats") && !contains_text(text, "STUN RESIST") && have_skill($skill[Summon Love Stinkbug]))
		{
			set_property("cc_combatHandler", combatState + "(love stinkbug)");
			return "skill " + $skill[Summon Love Stinkbug];
		}
	}

	if((!contains_text(combatState, "candyblast")) && (my_mp() > 60) && (get_property("kingLiberated").to_boolean()))
	{
		# We can get only one candy and we can detect it, if so desired:
		# "Hey, some of it is even intact afterwards!"
		set_property("cc_combatHandler", combatState + "(candyblast)");
		return "skill candyblast";
	}

	if((!contains_text(combatState, "spirit snap")) && (my_class() == $class[Turtle Tamer]) && (have_skill($skill[Spirit Snap]) && (my_mp() > 80)))
	{
		if((have_effect($effect[Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Grand Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Glorious Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Glorious Blessing of the War Snapper]) > 0) || (have_effect($effect[Glorious Blessing of She-Who-Was]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(spirit snap)");
			return "skill " + $skill[Spirit Snap];
		}
	}

	if((!contains_text(combatState, "stuffedmortarshell")) && (my_class() == $class[Sauceror]) && ((expected_damage() * 2) < my_hp()) && have_skill($skill[Stuffed Mortar Shell]) && (my_mp() > mp_cost($skill[Stuffed Mortar Shell])))
	{
		set_property("cc_combatHandler", combatState + "(stuffedmortarshell)");
		return "skill stuffed mortar shell";
	}

	if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_class() == $class[Sauceror]) && (my_mp() >= 32))
	{
		set_property("cc_combatHandler", combatState + "(weaksauce)");
		return "skill curse of weaksauce";
	}

	if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_class() == $class[Sauceror]) && (my_mp() >= 8) && contains_text(combatState, "stuffedmortarshell"))
	{
		set_property("cc_combatHandler", combatState + "(weaksauce)");
		return "skill curse of weaksauce";
	}


	string attackMinor = "attack with weapon";
	string attackMajor = "attack with weapon";
	int costMinor = 0;
	int costMajor = 0;
	string stunner = "";
	int costStunner = 0;

	switch(my_class())
	{
	case $class[Seal Clubber]:
		attackMinor = "attack with weapon";
		if(have_skill($skill[lunge smack]) && (my_mp() >= mp_cost($skill[Lunge Smack])))
		{
			attackMinor = "skill lunge smack";
			costMinor = mp_cost($skill[Lunge Smack]);
		}
		if(have_skill($skill[lunging thrust-smack]) && (my_mp() >= mp_cost($skill[Lunging Thrust-Smack])))
		{
			attackMajor = "skill lunging thrust-smack";
			costMajor = mp_cost($skill[Lunging Thrust-Smack]);
		}
		if(have_skill($skill[Club Foot]) && (my_mp() >= mp_cost($skill[Club Foot])))
		{
			stunner = "skill club foot";
			costStunner = mp_cost($skill[Club Foot]);
		}
		break;
	case $class[Turtle Tamer]:
		attackMinor = "attack with weapon";
		if((my_mp() > 150) && (have_skill($skill[shieldbutt])) && hasShieldEquipped())
		{
			attackMinor = "skill shieldbutt";
			costMinor = mp_cost($skill[Shieldbutt]);
		}
		else if((my_mp() > 80) && ((my_hp() * 2) < my_maxhp()) && have_skill($skill[Kneebutt]))
		{
			attackMinor = "skill kneebutt";
			costMinor = mp_cost($skill[Kneebutt]);
		}
		if((round > 15) || ((my_hp() * 2) < my_maxhp()) && have_skill($skill[Kneebutt]))
		{
			attackMajor = "skill kneebutt";
			costMajor = mp_cost($skill[Kneebutt]);
		}
		if((have_skill($skill[shieldbutt])) && hasShieldEquipped() && (my_mp() >= mp_cost($skill[Shieldbutt])))
		{
			attackMajor = "skill shieldbutt";
			costMajor = mp_cost($skill[Shieldbutt]);
		}
		if(have_skill($skill[Shell Up]) && (my_mp() >= mp_cost($skill[Shell Up])))
		{
			stunner = "skill shell up";
			costStunner = mp_cost($skill[Shell Up]);
		}

		if(((monster_defense() - my_buffedstat(my_primestat())) > 20) && have_skill($skill[Saucestorm]) && (my_mp() >= mp_cost($skill[Saucestorm])))
		{
			attackMajor = "skill " + $skill[Saucestorm];
			costMajor = mp_cost($skill[Saucestorm]);
		}

		break;
	case $class[Pastamancer]:
		if((my_mp() >= mp_cost($skill[Cannelloni Cannon])) && (have_skill($skill[Cannelloni Cannon])))
		{
			attackMinor = "skill Cannelloni Cannon";
			costMinor = mp_cost($skill[Cannelloni Cannon]);
		}
		if((my_mp() >= mp_cost($skill[Weapon of the Pastalord])) && (have_skill($skill[Weapon of the Pastalord])))
		{
			attackMajor = "skill Weapon of the Pastalord";
			costMajor = mp_cost($skill[Weapon of the Pastalord]);
		}
		if((my_mp() >= mp_cost($skill[Saucestorm])) && (have_skill($skill[Saucestorm])))
		{
			attackMajor = "skill " + $skill[Saucestorm];
			attackMinor = "skill " + $skill[Saucestorm];
			costMinor = mp_cost($skill[Saucestorm]);
			costMajor = mp_cost($skill[Saucestorm]);
		}
		if((my_mp() >= 1) && (have_skill($skill[Utensil Twist])) && (item_type(equipped_item($slot[weapon])) == "utensil"))
		{
			if(equipped_item($slot[weapon]) == $item[Hand That Rocks the Ladle])
			{
				attackMajor = "skill " + $skill[Utensil Twist];
				attackMinor = "skill " + $skill[Utensil Twist];
				costMinor = mp_cost($skill[Utensil Twist]);
				costMajor = mp_cost($skill[Utensil Twist]);
			}
			else if((enemy.physical_resistance <= 80) && (attackMinor != ("skill " + $skill[Saucestorm])))
			{
				attackMinor = "skill " + $skill[Utensil Twist];
				costMinor = mp_cost($skill[Utensil Twist]);
			}
		}
		if(have_skill($skill[Entangling Noodles]) && (my_mp() >= mp_cost($skill[Entangling Noodles])))
		{
			stunner = "skill entangling noodles";
			costStunner = mp_cost($skill[Entangling Noodles]);
		}
		break;
	case $class[Sauceror]:
		if((my_mp() >= mp_cost($skill[Saucegeyser])) && (have_skill($skill[Saucegeyser])))
		{
			attackMinor = "skill saucegeyser";
			attackMajor = "skill saucegeyser";
			costMinor = mp_cost($skill[Saucegeyser]);
			costMajor = mp_cost($skill[Saucegeyser]);
		}
		else if((my_mp() >= mp_cost($skill[Saucecicle])) && have_skill($skill[Saucecicle]) && (monster_element(enemy) != $element[cold]))
		{
			attackMinor = "skill saucecicle";
			attackMajor = "skill saucecicle";
			costMinor = mp_cost($skill[Saucecicle]);
			costMajor = mp_cost($skill[Saucecicle]);
		}
		else if((my_mp() >= mp_cost($skill[Saucestorm])) && (have_skill($skill[Saucestorm])))
		{
			attackMinor = "skill saucestorm";
			attackMajor = "skill saucestorm";
			costMinor = mp_cost($skill[Saucestorm]);
			costMajor = mp_cost($skill[Saucestorm]);
		}
		else if((my_mp() >= mp_cost($skill[Wave of Sauce])) && have_skill($skill[Wave of Sauce]) && (monster_element(enemy) != $element[hot]))
		{
			attackMinor = "skill wave of sauce";
			attackMajor = "skill wave of sauce";
			costMinor = mp_cost($skill[Wave of Sauce]);
			costMajor = mp_cost($skill[Wave of Sauce]);
		}
		else if((my_mp() >= mp_cost($skill[Stream of Sauce])) && have_skill($skill[Stream of Sauce]) && (monster_element(enemy) != $element[hot]))
		{
			attackMinor = "skill stream of sauce";
			attackMajor = "skill stream of sauce";
			costMinor = mp_cost($skill[Stream of Sauce]);
			costMajor = mp_cost($skill[Stream of Sauce]);
		}

		if(my_soulsauce() >= 5)
		{
			stunner = "skill soul bubble";
			costStunner = mp_cost($skill[Soul Bubble]);
		}


		if(!contains_text(combatState, "delaymortarshell") && contains_text(combatState, "stuffedmortarshell") && (my_class() == $class[Sauceror]) && ((expected_damage() * 2) < my_hp()) && have_skill($skill[Stuffed Mortar Shell]) && have_skill($skill[Salsaball]) && (my_mp() > mp_cost($skill[Salsaball])))
		{
			set_property("cc_combatHandler", combatState + "(delaymortarshell)");
			return "skill salsaball";
		}

		break;

	case $class[Avatar of Boris]:
		if((my_mp() >= mp_cost($skill[Heroic Belch])) && have_skill($skill[Heroic Belch]) && (enemy.physical_resistance >= 100) && (monster_element(enemy) != $element[stench]) && (my_fullness() >= 5))
		{
			attackMinor = "skill " + $skill[Heroic Belch];
			attackMajor = "skill " + $skill[Heroic Belch];
			costMinor = mp_cost($skill[Heroic Belch]);
			costMajor = mp_cost($skill[Heroic Belch]);
		}

		if((my_mp() >= mp_cost($skill[Broadside])) && have_skill($skill[Broadside]))
		{
			stunner = "skill " + $skill[Broadside];
			costStunner = mp_cost($skill[Broadside]);
		}
		break;

	case $class[Accordion Thief]:

		if((!contains_text(combatState, "cadenza")) && (item_type(equipped_item($slot[weapon])) == "accordion") && (my_mp() >= mp_cost($skill[Cadenza])) && ((expected_damage() * 2) < my_hp()))
		{
			if($items[accordion file, alarm accordion, autocalliope, bal-musette accordion, baritone accordion, cajun accordion, ghost accordion, peace accordion, pentatonic accordion, pygmy concertinette, skipper\'s accordion, squeezebox of the ages, the trickster\'s trikitixa] contains equipped_item($slot[weapon]))
			{
				set_property("cc_combatHandler", combatState + "(cadenza)");
				return "item " + $skill[Cadenza];
			}
		}

		if(have_skill($skill[Accordion Bash]) && (my_mp() >= mp_cost($skill[Accordion Bash])) && (item_type(equipped_item($slot[weapon])) == "accordion"))
		{
			stunner = "skill " + $skill[Accordion Bash];
			costStunner = mp_cost($skill[Accordion Bash]);
		}

		if(((monster_defense() - my_buffedstat(my_primestat())) > 20) && have_skill($skill[Saucestorm]) && (my_mp() >= mp_cost($skill[Saucestorm])))
		{
			attackMajor = "skill " + $skill[Saucestorm];
			costMajor = mp_cost($skill[Saucestorm]);
		}

		break;

	case $class[Disco Bandit]:

		// I have no idea how Disco Bandits fight, even less than AT.

		if(((monster_defense() - my_buffedstat(my_primestat())) > 20) && have_skill($skill[Saucestorm]) && (my_mp() >= mp_cost($skill[Saucestorm])))
		{
			attackMajor = "skill " + $skill[Saucestorm];
			costMajor = mp_cost($skill[Saucestorm]);
		}
		break;

	case $class[Cow Puncher]:
	case $class[Beanslinger]:
	case $class[Snake Oiler]:
		if(!contains_text(combatState, "extractSnakeOil") && (my_hp() > 80) && have_skill($skill[Extract Oil]) && (my_mp() >= (3 * mp_cost($skill[Extract Oil]))))
		{
			if($monsters[Aggressive grass snake, Bacon snake, Batsnake, Black adder, Burning Snake of Fire, Coal snake, Diamondback rattler, Frontwinder, Frozen Solid Snake, King snake, Licorice snake, Mutant rattlesnake, Prince snake, Sewer snake with a sewer snake in it, Snakeleton, The Snake with Like Ten Heads, Tomb asp, Trouser Snake, Whitesnake] contains enemy)
			{

			}
			else if(($phylums[beast, dude, hippy, humanoid, orc, pirate] contains type) && (item_amount($item[Skin Oil]) < 3))
			{
				set_property("cc_combatHandler", combatState + "(extractSnakeOil)");
				return "skill " + $skill[Extract Oil];
			}
			else if(($phylums[bug, construct, constellation, demon, elemental, elf, fish, goblin, hobo, horror, mer-kin, penguin, plant, slime, weird] contains type) && (item_amount($item[Unusual Oil]) < 4))
			{
				set_property("cc_combatHandler", combatState + "(extractSnakeOil)");
				return "skill " + $skill[Extract Oil];
			}
			else if(($phylums[undead] contains type) && (item_amount($item[Skin Oil]) < 5))
			{
				set_property("cc_combatHandler", combatState + "(extractSnakeOil)");
				return "skill " + $skill[Extract Oil];
			}
		}
		if(!contains_text(combatState, "goodMedicine") && have_skill($skill[Good Medicine]) && (my_mp() >= (3 * mp_cost($skill[Good Medicine]))))
		{
			set_property("cc_combatHandler", combatState + "(goodMedicine)");
			return "skill " + $skill[Good Medicine];
		}

		if(!contains_text(combatState, "hogtie") && have_skill($skill[Hogtie]) && (my_mp() >= (6 * mp_cost($skill[Hogtie]))) && hasLeg(enemy))
		{
			set_property("cc_combatHandler", combatState + "(hogtie)");
			return  "skill " + $skill[Hogtie];
		}


		if(have_skill($skill[One-Two Punch]) && (my_mp() >= mp_cost($skill[One-Two Punch])) && (equipped_item($slot[Weapon]) == $item[none]))
		{
//			attackMajor = "skill " + $skill[One-Two Punch];
//			attackMinor = "skill " + $skill[One-Two Punch];
//			costMajor = mp_cost($skill[One-Two Punch]);
//			costMinor = mp_cost($skill[One-Two Punch]);
			//This does not seem to work.
		}



		if(have_skill($skill[Lavafava]) && (my_mp() >= mp_cost($skill[Lavafava])) && (enemy.defense_element != $element[hot]))
		{
			attackMajor = "skill " + $skill[Lavafava];
			attackMinor = "skill " + $skill[Lavafava];
			costMajor = mp_cost($skill[Lavafava]);
			costMinor = mp_cost($skill[Lavafava]);
		}
		if(have_skill($skill[Beanstorm]) && (my_mp() >= mp_cost($skill[Beanstorm])))
		{
			attackMajor = "skill " + $skill[Beanstorm];
			attackMinor = "skill " + $skill[Beanstorm];
			costMajor = mp_cost($skill[Beanstorm]);
			costMinor = mp_cost($skill[Beanstorm]);
		}

		if(have_skill($skill[Fan Hammer]) && (my_mp() >= mp_cost($skill[Fan Hammer])))
		{
			attackMajor = "skill " + $skill[Fan Hammer];
			attackMinor = "skill " + $skill[Fan Hammer];
			costMajor = mp_cost($skill[Fan Hammer]);
			costMinor = mp_cost($skill[Fan Hammer]);
		}
		if(have_skill($skill[Snakewhip]) && (my_mp() >= mp_cost($skill[Snakewhip])) && (enemy.physical_resistance < 80))
		{
			attackMajor = "skill " + $skill[Snakewhip];
			attackMinor = "skill " + $skill[Snakewhip];
			costMajor = mp_cost($skill[Snakewhip]);
			costMinor = mp_cost($skill[Snakewhip]);
		}

		if(have_skill($skill[Pungent Mung]) && (my_mp() >= mp_cost($skill[Pungent Mung])) && (enemy.defense_element != $element[stench]))
		{
			attackMajor = "skill " + $skill[Pungent Mung];
			attackMinor = "skill " + $skill[Pungent Mung];
			costMajor = mp_cost($skill[Pungent Mung]);
			costMinor = mp_cost($skill[Pungent Mung]);
		}

		if(have_skill($skill[Cowcall]) && (my_mp() >= mp_cost($skill[Cowcall])) && (type != $phylum[undead]) && (enemy.defense_element != $element[spooky]) && (have_effect($effect[Cowrruption]) >= 60))
		{
			attackMajor = "skill " + $skill[Cowcall];
			attackMinor = "skill " + $skill[Cowcall];
			costMajor = mp_cost($skill[Cowcall]);
			costMinor = mp_cost($skill[Cowcall]);
		}

		if(have_skill($skill[Cowcall]) && (my_mp() >= mp_cost($skill[Cowcall])) && (type != $phylum[undead]) && (enemy.defense_element != $element[spooky]) && (my_class() == $class[Cow Puncher]))
		{
			attackMajor = "skill " + $skill[Cowcall];
			attackMinor = "skill " + $skill[Cowcall];
			costMajor = mp_cost($skill[Cowcall]);
			costMinor = mp_cost($skill[Cowcall]);
		}

		if(have_skill($skill[Beanscreen]) && (my_mp() >= mp_cost($skill[Beanscreen])) && ((expected_damage() * 2) > my_hp()))
		{
			stunner = "skill " + $skill[Beanscreen];
			costStunner = mp_cost($skill[Beanscreen]);
		}

		if(have_skill($skill[Hogtie]) && (my_mp() >= (3 * mp_cost($skill[Hogtie]))) && hasLeg(enemy))
		{
			stunner = "skill " + $skill[Hogtie];
			costStunner = mp_cost($skill[Hogtie]);
		}
		break;
	}

	if(round <= 25)
	{
		if(((my_hp() * 10)/3) < my_maxhp())
		{
			if((!contains_text(combatState, "thunderstrike")) && (have_skill($skill[thunderstrike])) && (monster_level_adjustment() <= 150))
			{
				set_property("cc_combatHandler", combatState + "(thunderstrike)");
				return "skill thunderstrike";
			}

			if((!contains_text(combatState, "stunner")) && (stunner != "") && (monster_level_adjustment() <= 50) && (my_mp() >= costStunner))
			{
				set_property("cc_combatHandler", combatState + "(stunner)");
				return stunner;
			}

			if((have_skill($skill[unleash the greash])) && (monster_element(enemy) != $element[sleaze]) && (have_effect($effect[Takin\' It Greasy]) > 100))
			{
				return "skill unleash the greash";
			}
			if((have_skill($skill[thousand-yard stare])) && (monster_element(enemy) != $element[spooky]) && (have_effect($effect[Intimidating Mien]) > 100))
			{
				return "skill thousand-yard stare";
			}
			if($monsters[Aquagoblin, Lord Soggyraven] contains enemy)
			{
				return attackMajor;
			}
			if((my_class() == $class[Turtle Tamer]) && (my_mp() >= mp_cost($skill[Spirit Snap])) && (have_skill($skill[Spirit Snap])) && (!contains_text(combatState, "spirit snap")))
			{
				if((have_effect($effect[Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Grand Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Glorious Blessing of the Storm Tortoise]) > 0) || (have_effect($effect[Glorious Blessing of the War Snapper]) > 0) || (have_effect($effect[Glorious Blessing of She-Who-Was]) > 0))
				{
					set_property("cc_combatHandler", combatState + "(spirit snap)");
					return "skill " + $skill[Spirit Snap];
				}
			}
			if((!contains_text(combatState, "northern explosion")) && (have_skill($skill[northern explosion])) && (my_mp() >= mp_cost($skill[Northern Explosion])) && (my_class() == $class[Seal Clubber]) && (monster_element(enemy) != $element[cold]))
			{
				set_property("cc_combatHandler", combatState + "(northern explosion)");
				return "skill northern explosion";
			}
			if((!contains_text(combatState, "last attempt")) && (my_mp() >= costMajor))
			{
				if((expected_damage() * 1.4) >= my_hp())
				{
					set_property("cc_combatHandler", combatState + "(last attempt)");
					print("Uh oh, I'm having trouble in combat.", "red");
				}
				return attackMajor;
			}
			if((expected_damage() * 2.5) < my_hp())
			{
				print("Hmmm, I don't really know what to do in this combat but it looks like I'll live.", "red");
				if(my_mp() >= costMajor)
				{
					return attackMajor;
				}
				else if(my_mp() >= costMinor)
				{
					return attackMinor;
				}
				return "attack with weapon";
			}
			if(my_location() != $location[The Slime Tube])
			{
				abort("Could not handle monster, sorry");
			}
		}
		if((monster_level_adjustment() > 150) && (my_mp() >= 45) && (have_skill($skill[Shell Up])) && (!contains_text(combatState, "shellup")) && (my_class() == $class[Turtle Tamer]))
		{
			set_property("cc_combatHandler", combatState + "(shellup)");
			return "skill shell up";
		}

		if(attackMinor == "attack with weapon")
		{
			if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
			{
				set_property("cc_combatHandler", combatState + "(love stinkbug)");
				return "skill " + $skill[Summon Love Stinkbug];
			}
			if(have_skill($skill[Mighty Axing]) && (equipped_item($slot[Weapon]) != $item[none]))
			{
				return "skill " + $skill[Mighty Axing];
			}
		}

		if((my_location() == $location[The X-32-F Combat Training Snowman]) && contains_text(text, "Cattle Prod") && (my_mp() >= costMajor))
		{
			return attackMajor;
		}

		if((monster_level_adjustment() > 150) && (my_mp() >= costMajor))
		{
			return attackMajor;
		}
		if((have_skill($skill[lunge smack])) && (my_mp() >= mp_cost($skill[Lunge Smack])))
		{
			return attackMinor;
		}
		if(my_mp() >= costMinor)
		{
			return attackMinor;
		}
		return "attack with weapon";
	}
	else
	{
		abort("Some sort of problem occurred, it is past round 25 but we are still in non-gremlin combat...");
	}

	if(attackMinor == "attack with weapon")
	{
		if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
		{
			set_property("cc_combatHandler", combatState + "(love stinkbug)");
			return "skill " + $skill[Summon Love Stinkbug];
		}
	}

	return attackMinor;
#	return get_ccs_action(round);
}

string findBanisher(int round, string opp, string text)
{
	print("In findBanisher for: " + opp, "green");
	monster enemy = to_monster(opp);

	foreach itm in $items[Louder Than Bomb, Tennis Ball]
	{
		if((!contains_text(get_property("cc_gremlinBanishes"), itm)) && (item_amount(itm) > 0))
		{
			set_property("cc_gremlinBanishes", get_property("cc_gremlinBanishes") + "(" + itm + ")");
			handleTracker(enemy, itm, "cc_banishes");
			return "item " + itm;
		}
	}

	foreach act in $skills[Banishing Shout, Talk About Politics, Batter Up!, Thunder Clap, Curse of Vacation, Snokebomb, Beancannon]
	{
		if((!contains_text(get_property("cc_gremlinBanishes"), act)) && have_skill(act) && (my_mp() >= mp_cost(act)) && (my_thunder() >= thunder_cost(act)) && have_skill(act))
		{
			if(act == $skill[Banishing Shout])
			{
				handleTracker(enemy, act, "cc_banishes");
				return "skill " + act;
			}
			if((act == $skill[Batter Up!]) && (my_fury() < 5))
			{
				continue;
			}
			if((act == $skill[Talk About Politics]) && (get_property("_pantsgivingBanish").to_int() >= 5))
			{
				continue;
			}
			if((act == $skill[Beancannon]) && (get_property("_beancannonUsed").to_int() >= 5))
			{
				continue;
			}
			if((act == $skill[Beancannon]) && !($items[Frigid Northern Beans, Heimz Fortified Kidney Beans, Hellfire Spicy Beans, Mixed Garbanzos and Chickpeas, Pork \'n\' Pork \'n\' Pork \'n\' Beans, Shrub\'s Premium Baked Beans, Tesla\'s Electroplated Beans, Trader Olaf\'s Exotic Stinkbeans, World\'s Blackest-Eyed Peas] contains equipped_item($slot[Off-hand])))
			{
				continue;
			}
			if((act == $skill[Snokebomb]) && (get_property("_snokebombUsed").to_int() >= 3))
			{
				continue;
			}

			if(act == $skill[Beancannon])
			{
				set_property("_beancannonUsed", get_property("_beancannonUsed").to_int() + 1);
			}
			set_property("cc_gremlinBanishes", get_property("cc_gremlinBanishes") + "(" + act + ")");
			handleTracker(enemy, act, "cc_banishes");
			return "skill " + act;
		}
	}

//	if(have_skill($skill[Lunging Thrust-Smack]) && (my_mp() >= mp_cost($skill[Lunging Thrust-Smack])))
//	{
//		return "skill lunging thrust-smack";
//	}
	if(have_skill($skill[Storm of the Scarab]) && (my_mp() >= mp_cost($skill[Storm of the Scarab])))
	{
		return "skill Storm of the Scarab";
	}
	return cc_combatHandler(round, opp, text);
//	if(have_skill($skill[Lunge Smack]) && (my_mp() >= mp_cost($skill[Lunge Smack])))
//	{
//		return "skill lunge smack";
//	}
//	return "attack with weapon";
}

string ccsJunkyard(int round, string opp, string text)
{
	monster enemy = to_monster(opp);

	if(!($monsters[A.M.C. gremlin, batwinged gremlin, erudite gremlin, spider gremlin, vegetable gremlin] contains enemy))
	{
		return cc_combatHandler(round, opp, text);
	}

	if(round == 0)
	{
		print("ccsJunkyard: " + round, "brown");
		set_property("cc_gremlinMoly", true);
		set_property("cc_combatHandler", "");
	}
	else
	{
		print("cc_Junkyard: " + round, "brown");
	}
	string combatState = get_property("cc_combatHandler");
	string edCombatState = get_property("cc_edCombatHandler");

	if(my_class() == $class[Ed])
	{
		if(contains_text(edCombatState, "gremlinNeedBanish"))
		{
			set_property("cc_gremlinMoly", false);
		}
	}

	if(enemy == $monster[A.M.C. gremlin])
	{
		set_property("cc_gremlinMoly", false);
	}

	if(my_location() == $location[Next To That Barrel With Something Burning In It])
	{
		if(enemy == $monster[vegetable gremlin])
		{
			set_property("cc_gremlinMoly", false);
		}
		else if(contains_text(text, "It does a bombing run over your head"))
		{
			set_property("cc_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Out By That Rusted-Out Car])
	{
		if(enemy == $monster[erudite gremlin])
		{
			set_property("cc_gremlinMoly", false);
		}
		else if(contains_text(text, "It picks a beet off of itself and beats you with it"))
		{
			set_property("cc_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Over Where The Old Tires Are])
	{
		if(enemy == $monster[spider gremlin])
		{
			set_property("cc_gremlinMoly", false);
		}
		else if(contains_text(text, "He uses the random junk around him"))
		{
			set_property("cc_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Near an Abandoned Refrigerator])
	{
		if(enemy == $monster[batwinged gremlin])
		{
			set_property("cc_gremlinMoly", false);
		}
		else if(contains_text(text, "It bites you in the fibula with its mandibles"))
		{
			set_property("cc_gremlinMoly", false);
		}
	}

	if(!contains_text(edCombatState, "gremlinNeedBanish") && !get_property("cc_gremlinMoly").to_boolean() && (my_class() == $class[Ed]))
	{
		set_property("cc_edCombatHandler", "(gremlinNeedBanish)");
	}

	if(round >= 28)
	{
		if(have_skill($skill[Lunging Thrust-Smack]) && (my_mp() >= 8))
		{
			return "skill lunging thrust-smack";
		}
		return "attack with weapon";
	}

	if(contains_text(text, "It whips out a hammer") || contains_text(text, "He whips out a crescent") || contains_text(text, "It whips out a pair") || contains_text(text, "It whips out a screwdriver"))
	{
		return "item molybdenum magnet";
	}

	if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= mp_cost($skill[Curse of Weaksauce])))
	{
		set_property("cc_combatHandler", combatState + "(weaksauce)");
		return "skill " + $skill[Curse of Weaksauce];
	}

	if((!contains_text(combatState, "marshmallow")) && have_skill($skill[Curse of the Marshmallow]) && (my_mp() > mp_cost($skill[Curse of the Marshmallow])))
	{
		set_property("cc_combatHandler", combatState + "(marshmallow)");
		return "skill Curse of the Marshmallow";
	}
	if((!contains_text(combatState, "love scarab")) && have_skill($skill[Summon Love Scarabs]))
	{
		set_property("cc_combatHandler", combatState + "(love scarab)");
		return "skill summon love scarabs";
	}
	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("cc_combatHandler", combatState + "(love gnats)");
		return "skill summon love gnats";
	}

	if(!contains_text(combatState, "badMedicine") && have_skill($skill[Bad Medicine]) && (my_mp() >= mp_cost($skill[Bad Medicine])))
	{
		set_property("cc_combatHandler", combatState + "(badMedicine)");
		return "skill " + $skill[Bad Medicine];
	}

	if(!contains_text(combatState, "goodMedicine") && have_skill($skill[Good Medicine]) && (my_mp() >= mp_cost($skill[Good Medicine])) && (expected_damage() * 2.1) >= my_hp())
	{
		set_property("cc_combatHandler", combatState + "(goodMedicine)");
		return "skill " + $skill[Good Medicine];
	}


	if(!get_property("cc_gremlinMoly").to_boolean() && (my_class() == $class[Ed]))
	{
		if(get_property("cc_edCombatStage").to_int() >= 2)
		{
			string banisher = findBanisher(round, opp, text);
			if(banisher != "attack with weapon")
			{
				return banisher;
			}
			else if(my_mp() >= 8)
			{
				return "skill storm of the scarab";
			}
			return banisher;
		}
	}


	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]) && (my_location() != $location[The Battlefield (Hippy Uniform)]))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
		if((item_amount($item[jam band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item jam band flyers";
		}
	}


	if(!get_property("cc_gremlinMoly").to_boolean())
	{
		if(my_class() == $class[Ed])
		{
			if(get_property("cc_edCombatStage").to_int() >= 2)
			{
				return findBanisher(round, opp, text);
			}
			else if(item_amount($item[dictionary]) > 0)
			{
				return "item dictionary";
			}
			else if(item_amount($item[seal tooth]) > 0)
			{
				return "item seal tooth";
			}
		}
		else
		{
			return findBanisher(round, opp, text);
		}
	}


	if(!get_property("cc_gremlinMoly").to_boolean())
	{
		if(have_skill($skill[Lunging Thrust-Smack]) && (my_mp() >= mp_cost($skill[Lunging Thrust-Smack])))
		{
			return "skill lunging thrust-smack";
		}
		if(have_skill($skill[Storm of the Scarab]) && (my_mp() >= mp_cost($skill[Storm of the Scarab])))
		{
			return "skill Storm of the Scarab";
		}
		if(have_skill($skill[Lunge Smack]) && (my_mp() >= mp_cost($skill[Lunge Smack])))
		{
			return "skill lunge smack";
		}
		return "attack with weapon";
	}

	if(item_amount($item[dictionary]) > 0)
	{
		return "item dictionary";
	}
	if(item_amount($item[seal tooth]) > 0)
	{
		return "item seal tooth";
	}
	if(item_amount($item[Spectre Scepter]) > 0)
	{
		return "item spectre scepter";
	}
	if(have_skill($skill[toss]) && (my_mp() >= mp_cost($skill[Toss])))
	{
		return "skill toss";
	}
	return "attack with weapon";
}
/*
void handleSniffs(monster enemy, skill sniffer)
{
	if(my_daycount() <= 5)
	{
		string sniffs = get_property("cc_sniffs");
		if(sniffs != "")
		{
			sniffs = sniffs + ",";
		}
		sniffs = sniffs + "(" + my_daycount() + ":" + enemy + ":" + sniffer + ":" + my_turncount() + ")";
		set_property("cc_sniffs", sniffs);
	}
}

void handleLashes(monster enemy)
{
	if(my_daycount() <= 5)
	{
		string lashes = get_property("cc_lashes");
		if(lashes != "")
		{
			lashes = lashes + ", ";
		}
		if(get_property("_edLashCount").to_int() >= 30)
		{
			lashes = lashes + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + "F)";
		}
		else
		{
			lashes = lashes + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + ")";
		}
		set_property("cc_lashes", lashes);
	}
}

void handleRenenutet(monster enemy)
{
	if(my_daycount() <= 5)
	{
		string renenutet = get_property("cc_renenutet");
		if(renenutet != "")
		{
			renenutet = renenutet + ", ";
		}
		renenutet = renenutet + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + ")";
		set_property("cc_renenutet", renenutet);
	}
}
*/
string cc_edCombatHandler(int round, string opp, string text)
{
	if(my_path() != "Actually Ed the Undying")
	{
		abort("Not in Actually Ed the Undying, this combat filter will result in massive suckage.");
	}
	if(round == 0)
	{
		print("cc_combatHandler: " + round, "brown");
		set_property("cc_combatHandler", "");
		if(get_property("cc_edCombatStage").to_int() == 0)
		{
			set_property("cc_edCombatCount", 1 + get_property("cc_edCombatCount").to_int());
			set_property("cc_edCombatStage", 1);
			set_property("cc_edStatus", "UNDYING!");
		}
		else
		{
			set_property("cc_edCombatStage", 1 + get_property("cc_edCombatStage").to_int());
		}
	}
	set_property("cc_edCombatRoundCount", 1 + get_property("cc_edCombatRoundCount").to_int());


	if(get_property("cc_edCombatStage").to_int() == 3)
	{
		set_property("cc_edStatus", "dying");
		set_property("cc_edCombatStage", 0);
	}

	set_property("cc_diag_round", round);

	if(get_property("cc_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	phylum type = monster_phylum(enemy);
	string combatState = get_property("cc_combatHandler");
	string edCombatState = get_property("cc_edCombatHandler");

	#Handle different path is monster_level_adjustment() > 150 (immune to staggers?)
	int mcd = monster_level_adjustment();

	if(have_effect($effect[temporary amnesia]) > 0)
	{
		return "attack with weapon";
	}

	if((!contains_text(combatState, "pocket crumbs")) && (have_skill($skill[pocket crumbs])))
	{
		set_property("cc_combatHandler", combatState + "(pocket crumbs)");
		return "skill pocket crumbs";
	}

	if((!contains_text(combatState, "air dirty laundry")) && (have_skill($skill[air dirty laundry])))
	{
		set_property("cc_combatHandler", combatState + "(air dirty laundry)");
		return "skill air dirty laundry";
	}

	if((!contains_text(combatState, "love scarab")) && have_skill($skill[Summon Love Scarabs]))
	{
		set_property("cc_combatHandler", combatState + "(love scarab)");
		return "skill summon love scarabs";
	}

	if((get_property("edPoints").to_int() <= 4) && (my_daycount() == 1))
	{
		if(!ed_needShop() || (get_property("cc_edCombatStage").to_int() > 1))
		{
			set_property("cc_edStatus", "dying");
		}
	}

	if(get_property("cc_edStatus") == "UNDYING!")
	{
		if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
		{
			set_property("cc_combatHandler", combatState + "(love gnats)");
			return "skill summon love gnats";
		}
	}
	else if(get_property("cc_edStatus") == "dying")
	{
		boolean doStunner = true;

		if((mcd > 50) && (expected_damage() * 1.15) > my_hp())
		{
			doStunner = false;
		}

		if(doStunner)
		{
			if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
			{
				set_property("cc_combatHandler", combatState + "(love gnats)");
				return "skill summon love gnats";
			}
		}
	}
	else
	{
		print("Ed combat state does not exist, winging it....", "red");
	}


	if((!contains_text(combatState, "sewage pistol")) && have_skill($skill[Fire Sewage Pistol]))
	{
		set_property("cc_combatHandler", combatState + "(sewage pistol)");
		return "skill fire sewage pistol";
	}

	if(enemy == $monster[Protagonist])
	{
		set_property("cc_edStatus", "dying");
	}


	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]) && (my_location() != $location[The Battlefield (Hippy Uniform)]))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
		if((item_amount($item[jam band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item jam band flyers";
		}
	}

	if((enemy == $monster[clingy pirate (female)]) && (item_amount($item[cocktail napkin]) > 0))
	{
		return "item cocktail napkin";
	}
	if((enemy == $monster[clingy pirate (male)]) && (item_amount($item[cocktail napkin]) > 0))
	{
		return "item cocktail napkin";
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(edCombatState, "curse of fortune")))
	{
		if((item_amount($item[Ka Coin]) > 0) && (have_skill($skill[Curse of Fortune])))
		{
			set_property("cc_edCombatHandler", edCombatState + "(curse of fortune)");
			set_property("cc_edStatus", "dying");
			return "skill curse of fortune";
		}
	}

	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && (!contains_text(combatState, "insults")) && (numPirateInsults() < 8) && (get_property("cc_edStatus") != "dying"))
	{
		if(!contains_text(combatState, "beanscreen") && have_skill($skill[Beanscreen]) && (my_mp() >= mp_cost($skill[Beanscreen])))
		{
			set_property("cc_combatHandler", combatState + "(beanscreen)");
			return "skill " + $skill[Beanscreen];
		}

		if((my_location() == $location[The Obligatory Pirate\'s Cove]) || (my_location() == $location[barrrney\'s barrr]) ||
			(enemy == $monster[gaudy pirate]))
		{
			set_property("cc_combatHandler", combatState + "(insults)");
			return "item the big book of pirate insults";
		}
	}

	if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("cc_edStatus") == "UNDYING!"))
	{
		if((enemy == $monster[bob racecar]) ||
			(enemy == $monster[pygmy bowler]) ||
			(enemy == $monster[pygmy witch surgeon]) ||
			(enemy == $monster[possessed wine rack]) ||
			(enemy == $monster[cabinet of Dr. Limpieza]) ||
			(enemy == $monster[quiet healer]) ||
			(enemy == $monster[racecar bob]) ||
			(enemy == $monster[dirty old lihc]) ||
			(enemy == $monster[dairy goat]) ||
			(enemy == $monster[green ops soldier]) ||
			(enemy == $monster[Government Scientist]) ||
			(enemy == $monster[Writing Desk]))
		{
			set_property("cc_edCombatHandler", combatState + "(curseofstench)");
			handleTracker(enemy, $skill[Curse of Stench], "cc_sniffs");
			return "skill Curse of Stench";
		}
	}

	if(my_location() == $location[The Secret Council Warehouse])
	{
		if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("cc_edStatus") == "UNDYING!"))
		{
			boolean doStench = false;
			#	Rememeber, we are looking to see if we have enough of the opposite item here.
			if(enemy == $monster[Warehouse Guard])
			{
				int progress = get_property("warehouseProgress").to_int();
				progress = progress + (8 * item_amount($item[Warehouse Inventory Page]));
				if(progress >= 50)
				{
					doStench = true;
				}
			}

			if(enemy == $monster[Warehouse Clerk])
			{
				int progress = get_property("warehouseProgress").to_int();
				progress = progress + (8 * item_amount($item[Warehouse Map Page]));
				if(progress >= 50)
				{
					doStench = true;
				}
			}
			if(doStench)
			{
				set_property("cc_edCombatHandler", combatState + "(curseofstench)");
				handleTracker(enemy, $skill[Curse of Stench], "cc_sniffs");
				return "skill Curse of Stench";
			}
		}
	}


	if(my_location() == $location[The Smut Orc Logging Camp])
	{
		if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("cc_edStatus") == "UNDYING!"))
		{
			boolean doStench = false;
			string stenched = to_lower_case(get_property("stenchCursedMonster"));

			if((fastenerCount() >= 30) && (stenched != "smut orc pipelayer") && (stenched != "smut orc jacker"))
			{
				#	Sniff 100% lumber
				if((enemy == $monster[Smut Orc Pipelayer]) || (enemy == $monster[Smut Orc Jacker]))
				{
					doStench = true;
				}
			}
			if((lumberCount() >= 30) && (stenched != "smut orc screwer") && (stenched != "smut orc nailer"))
			{
				#	Sniff 100% fastener
				if((enemy == $monster[Smut Orc Screwer]) || (enemy == $monster[Smut Orc Nailer]))
				{
					doStench = true;
				}
			}

			if(doStench)
			{
				set_property("cc_edCombatHandler", combatState + "(curseofstench)");
				handleTracker(enemy, $skill[Curse of Stench], "cc_sniffs");
				return "skill Curse of Stench";
			}
		}
	}

	if(contains_text(combatState, "insults") && (get_property("cc_edStatus") == "dying"))
	{
		if((enemy == $monster[shady pirate]) && have_skill($skill[Curse of Vacation]) && (my_mp() >= 30))
		{
			handleTracker(enemy, $skill[Curse of Vacation], "cc_banishes");
			return "skill curse of vacation";
		}
		if((enemy == $monster[shifty pirate]) && (get_property("_pantsgivingBanish").to_int() < 5))
		{
			handleTracker(enemy, $skill[talk about politics], "cc_banishes");
			return "skill talk about poltiics";
		}
	}

	if((!contains_text(combatState, "yellowray")) && (have_effect($effect[everything looks yellow]) == 0) && (have_skill($skill[Wrath of Ra])) && (my_mp() >= 40))
	{
		boolean doWrath = false;
		if((my_location() == $location[Hippy Camp]) && !possessEquipment($item[Filthy Corduroys]) && !possessEquipment($item[Filthy Knitted Dread Sack]))
		{
			doWrath = true;
		}
		if((enemy == $monster[burly sidekick]) && (item_amount($item[mohawk wig]) == 0))
		{
			doWrath = true;
		}
		if(enemy == $monster[knob goblin harem girl])
		{
			doWrath = true;
		}
		if(enemy == $monster[Mountain Man])
		{
			doWrath = true;
		}

		if((enemy == $monster[Frat Warrior Drill Sergeant]) || (enemy == $monster[War Pledge]))
		{
			if(!possessEquipment($item[Bullet-Proof Corduroys]) && !possessEquipment($item[Reinforced Beaded Headband]) && !possessEquipment($item[Round Purple Sunglasses]))
			{
				doWrath = true;
			}
		}

		if(doWrath)
		{
			set_property("cc_combatHandler", combatState + "(yellowray)");
			handleTracker(enemy, $skill[Wrath of Ra], , "cc_yellowRays");
			return "skill wrath of ra";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[pygmy orderlies]) && (my_location() == $location[The Hidden Bowling Alley]))
		{
			set_property("cc_combatHandler", combatState + "(curse of vacation)");
			handleTracker(enemy, $skill[Curse of Vacation], "cc_banishes");
			return "skill curse of vacation";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[fallen archfiend]) && (my_location() == $location[The Dark Heart of the Woods]) && (get_property("cc_pirateoutfit") != "almost") && (get_property("cc_pirateoutfit") != "finished"))
		{
			set_property("cc_combatHandler", combatState + "(curse of vacation)");
			handleTracker(enemy, $skill[Curse of Vacation], "cc_banishes");
			return "skill curse of vacation";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= mp_cost($skill[Curse of Vacation])))
	{
		if((enemy == $monster[animated mahogany nightstand]) ||
			(enemy == $monster[coaltergeist]) ||
			(enemy == $monster[flock of stab-bats]) ||
			(enemy == $monster[procrastination giant]) ||
			(enemy == $monster[mad wino]) ||
			(enemy == $monster[Irritating Series of Random Encounters]) ||
			(enemy == $monster[sabre-toothed goat]) ||
			(enemy == $monster[knob goblin harem guard]) ||
			(enemy == $monster[pygmy witch lawyer]) ||
			(enemy == $monster[pygmy witch nurse]) ||
			(enemy == $monster[punk rock giant]) ||
			(enemy == $monster[slick lihc]) ||
			(enemy == $monster[warehouse janitor]) ||
			(enemy == $monster[possessed laundry press]) ||
			(enemy == $monster[mismatched twins]) ||
			(enemy == $monster[crusty pirate]))
		{
			set_property("cc_combatHandler", combatState + "(curse of vacation)");
			handleTracker(enemy, $skill[Curse of Vacation], "cc_banishes");
			return "skill curse of vacation";
		}
	}

	if(item_amount($item[disposable instant camera]) > 0)
	{
		if((enemy == $monster[bob racecar]) || (enemy == $monster[racecar bob]))
		{
			set_property("cc_combatHandler", combatState + "(disposable instant camera)");
			return "item disposable instant camera";
		}
	}

	if((my_location() == $location[Oil Peak]) && (item_amount($item[duskwalker syringe]) > 0))
	{
		return "item duskwalker syringe";
	}

	if(!contains_text(edCombatState, "lashofthecobra") && have_skill($skill[Lash of the Cobra]) && (my_mp() >= 12))
	{
		set_property("cc_edCombatHandler", edCombatState + "(lashofthecobra)");
		boolean doLash = false;
		if((enemy == $monster[Swarthy Pirate]) && !possessEquipment($item[Stuffed Shoulder Parrot]))
		{
			doLash = true;
		}
		if((enemy == $monster[Big Wheelin\' Twins]) && !possessEquipment($item[Badge Of Authority]))
		{
			doLash = true;
		}

		if((enemy == $monster[Fishy Pirate]) && !possessEquipment($item[Perfume-Soaked Bandana]))
		{
			doLash = true;
		}
		if((enemy == $monster[Funky Pirate]) && !possessEquipment($item[Sewage-Clogged Pistol]) && elementalPlanes_access($element[spooky]))
		{
			doLash = true;
		}
		if((enemy == $monster[Garbage Tourist]) && (item_amount($item[Bag of Park Garbage]) == 0))
		{
			doLash = true;
		}

		if((enemy == $monster[Sassy Pirate]) && !possessEquipment($item[Swashbuckling Pants]))
		{
			doLash = true;
		}
		if((enemy == $monster[Smarmy Pirate]) && !possessEquipment($item[Eyepatch]))
		{
			doLash = true;
		}
		if((enemy == $monster[One-eyed Gnoll]) && !possessEquipment($item[Eyepatch]))
		{
			doLash = true;
		}
		if((enemy == $monster[Stone Temple Pirate]) && !possessEquipment($item[Eyepatch]))
		{
			doLash = true;
		}
		if((enemy == $monster[Dairy Goat]) && (item_amount($item[Goat Cheese]) < 3))
		{
			doLash = true;
		}
		if((enemy == $monster[Renaissance Giant]) && (item_amount($item[Ye Olde Meade]) < 1) && (my_daycount() == 1))
		{
			doLash = true;
		}
		if((enemy == $monster[Protagonist]) && !possessEquipment($item[Ocarina of Space]))
		{
			doLash = true;
		}
		if(enemy == $monster[Bearpig Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Elephant (Meatcar?) Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Spider (Duck?) Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Beanbat])
		{
			doLash = true;
		}
		if(enemy == $monster[Bookbat])
		{
			doLash = true;
		}
		if(((enemy == $monster[Toothy Sklelton]) || (enemy == $monster[Spiny Skelelton])) && (get_property("cyrptNookEvilness").to_int() > 26))
		{
			doLash = true;
		}
		if((enemy == $monster[Oil Baron]) && (item_amount($item[Bubblin\' Crude]) < 12) && (item_amount($item[Jar of Oil]) == 0))
		{
			doLash = true;
		}

		if((enemy == $monster[Blackberry Bush]) && (item_amount($item[Blackberry]) < 3) && !possessEquipment($item[Blackberry Galoshes]))
		{
			doLash = true;
		}
		if((enemy == $monster[Pygmy Bowler]) && (get_property("_edLashCount").to_int() < 26))
		{
			doLash = true;
		}
		if(enemy == $monster[Larval Filthworm])
		{
			doLash = true;
		}
		if(enemy == $monster[Filthworm Drone])
		{
			doLash = true;
		}
		if(enemy == $monster[Filthworm Royal Guard])
		{
			doLash = true;
		}
		if(enemy == $monster[Knob Goblin Madam])
		{
			if(item_amount($item[Knob Goblin Perfume]) == 0)
			{
				doLash = true;
			}
		}
		if(enemy == $monster[Knob Goblin Harem Girl])
		{
			if(!possessEquipment($item[Knob Goblin Harem Veil]) || !possessEquipment($item[Knob Goblin Harem Pants]))
			{
				doLash = true;
			}
		}

		if(((my_location() == $location[Hippy Camp]) || (my_location() == $location[Wartime Hippy Camp])) && contains_text(enemy, "hippy"))
		{
			if(!possessEquipment($item[Filthy Knitted Dread Sack]) || !possessEquipment($item[Filthy Corduroys]))
			{
				doLash = true;
			}
		}

		if(my_location() == $location[Wartime Frat House])
		{
			if(!possessEquipment($item[Beer Helmet]) || !possessEquipment($item[Bejeweled Pledge Pin]) || !possessEquipment($item[Distressed Denim Pants]))
			{
				doLash = true;
			}
		}

		if((enemy == $monster[Dopey 7-Foot Dwarf]) && !possessEquipment($item[Miner\'s Helmet]))
		{
			doLash = true;
		}

		if((enemy == $monster[Grumpy 7-Foot Dwarf]) && !possessEquipment($item[7-Foot Dwarven Mattock]))
		{
			doLash = true;
		}

		if((enemy == $monster[Sleepy 7-Foot Dwarf]) && !possessEquipment($item[Miner\'s Pants]))
		{
			doLash = true;
		}

		if((enemy == $monster[Burly Sidekick]) && !possessEquipment($item[Mohawk Wig]))
		{
			doLash = true;
		}

		if((enemy == $monster[Spunky Princess]) && !possessEquipment($item[Titanium Assault Umbrella]))
		{
			doLash = true;
		}

		if((enemy == $monster[Quiet Healer]) && !possessEquipment($item[Amulet of Extreme Plot Significance]))
		{
			doLash = true;
		}

		if((enemy == $monster[P Imp]) || (enemy == $monster[G Imp]))
		{
			if((get_property("cc_pirateoutfit") != "finished") && (get_property("cc_pirateoutfit") != "almost") && (item_amount($item[Hot Wing]) < 3))
			{
				doLash = true;
			}
		}

		if(enemy == $monster[Warehouse Clerk])
		{
			int progress = get_property("warehouseProgress").to_int();
			progress = progress + (8 * item_amount($item[Warehouse Inventory Page]));
			if(progress < 50)
			{
				doLash = true;
			}
		}

		if(enemy == $monster[Warehouse Guard])
		{
			int progress = get_property("warehouseProgress").to_int();
			progress = progress + (8 * item_amount($item[Warehouse Map Page]));
			if(progress < 50)
			{
				doLash = true;
			}
		}

		if(doLash)
		{
			handleTracker(enemy, "cc_lashes");
			return "skill lash of the cobra";
		}
	}

	if((item_amount($item[Tattered Scrap of Paper]) > 0) && (!contains_text(combatState, "tatters")))
	{
		if((enemy == $monster[Demoninja]) ||
			(enemy == $monster[Drunken Rat]) ||
			(enemy == $monster[Bunch of Drunken Rats]) ||
			(enemy == $monster[Knob Goblin Elite Guard]) ||
			(enemy == $monster[Drunk Goat]) ||
			(enemy == $monster[Sabre-Toothed Goat]) ||
			(enemy == $monster[Bubblemint Twins]) ||
			(enemy == $monster[Creepy Ginger Twin]) ||
			(enemy == $monster[Mismatched Twins]) ||
			(enemy == $monster[Coaltergeist]) ||
			(enemy == $monster[L imp]) ||
			(enemy == $monster[W imp]) ||
			(enemy == $monster[Hellion]) ||
			(enemy == $monster[Fallen Archfiend]))
		{
			set_property("cc_combatHandler", combatState + "(tatters)");
			return "item tattered scrap of paper";
		}
	}



	if((!contains_text(edCombatState, "talismanofrenenutet")) && (item_amount($item[Talisman of Renenutet]) > 0))
	{
		boolean doRenenutet = false;
		if((enemy == $monster[Cleanly Pirate]) && (item_amount($item[Rigging Shampoo]) == 0))
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Creamy Pirate]) && (item_amount($item[Ball Polish]) == 0))
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Curmudgeonly Pirate]) && (item_amount($item[Mizzenmast Mop]) == 0))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Possessed Wine Rack])
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Cabinet of Dr. Limpieza])
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Quiet Healer]) && !possessEquipment($item[Amulet of Extreme Plot Significance]))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Mountain Man])
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Pygmy Janitor]) && (item_amount($item[Book of Matches]) == 0))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Blackberry Bush])
		{
			if(!possessEquipment($item[Blackberry Galoshes]) && (item_amount($item[Blackberry]) < 3))
			{
				doRenenutet = true;
			}
		}
		if(my_location() == $location[Wartime Frat House])
		{
			if(!possessEquipment($item[Beer Helmet]) || !possessEquipment($item[Bejeweled Pledge Pin]) || !possessEquipment($item[Distressed Denim Pants]))
			{
				doRenenutet = true;
			}
		}
		if((enemy == $monster[Warehouse Clerk]) || (enemy == $monster[Warehouse Guard]))
		{
			doRenenutet = true;
		}
		if(doRenenutet)
		{
			set_property("cc_edCombatHandler", edCombatState + "(talismanofrenenutet)");
			handleTracker(enemy, "cc_renenutet");
			set_property("cc_edStatus", "dying");
			return "item Talisman of Renenutet";
		}
	}

	if((enemy == $monster[Pygmy Orderlies]) && (item_amount($item[Short Writ of Habeas Corpus]) > 0))
	{
		return "item short writ of habeas corpus";
	}

	if(!ed_needShop() && (my_level() >= 10) && (item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[jam Band Flyers]) == 0) && (my_location() != $location[The Hidden Apartment Building]) && (type != $phylum[undead]) && (my_mp() > 20) && (my_location() != $location[Barrrney\'s Barrr]))
	{
		set_property("cc_edStatus", "dying");
	}

	if(get_property("cc_edStatus") == "UNDYING!")
	{
#		if((my_location() == $location[The Secret Government Laboratory]) || !ed_needShop())
		if(my_location() == $location[The Secret Government Laboratory])
		{
			if((item_amount($item[Rock Band Flyers]) == 0) && (item_amount($item[Jam Band Flyers]) == 0))
			{
				if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
				{
					set_property("cc_combatHandler", combatState + "(love stinkbug2)");
					return "skill summon love stinkbug";
				}
			}
		}

		if(item_amount($item[Dictionary]) > 0)
		{
#		    string macro = "item dictionary; repeat";
#		    visit_url("fight.php?action=macro&macrotext=" + url_encode(macro), true, true);
			return "item dictionary";
		}
		if(item_amount($item[Seal Tooth]) > 0)
		{
			return "item seal tooth";
		}

		return "skill Mild Curse";
	}

	if((my_mp() >= mp_cost($skill[Roar of the Lion])) && (my_location() == $location[The Secret Government Laboratory]) && have_skill($skill[Roar of the Lion]))
	{
		if(have_skill($skill[Storm of the Scarab]) && (my_buffedstat($stat[Mysticality]) >= 60))
		{
			return "skill Storm of the Scarab";
		}
		return "skill Roar of the Lion";
	}
	if((my_mp() >= mp_cost($skill[Storm of the Scarab])) && ($locations[Pirates of the Garbage Barges, The SMOOCH Army HQ, VYKEA] contains my_location()) && have_skill($skill[Storm of the Scarab]))
	{
		return "skill Storm of the Scarab";
	}


#	if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]) && (mcd <= 50))
#	{
#		set_property("cc_combatHandler", combatState + "(love stinkbug1)");
#		return "skill summon love stinkbug";
#	}
#	if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean() && (mcd <= 50))
#	{
#		set_property("cc_combatHandler", combatState + "(love stinkbug2)");
#		return "skill summon love stinkbug";
#	}

	int fightStat = my_buffedstat(weapon_type(equipped_item($slot[weapon]))) - 20;
	if((fightStat > monster_defense()) && (round < 20) && ((expected_damage() * 1.1) < my_hp()) && (get_property("cc_edStatus") == "UNDYING!"))
	{
		return "attack with weapon";
	}

	if((!contains_text(combatState, "cowboy kick")) && (have_skill($skill[Cowboy Kick])))
	{
		set_property("cc_combatHandler", combatState + "(cowboy kick)");
		return "skill " + $skill[Cowboy Kick];
	}

	if((item_amount($item[ice-cold Cloaca Zero]) > 0) && (my_mp() < 15) && (my_maxmp() > 200))
	{
		return "item ice-cold Cloaca Zero";
	}
	if((my_mp() >= 8) && have_skill($skill[Storm of the Scarab]) && (my_buffedstat($stat[Mysticality]) > 35))
	{
		return "skill Storm of the Scarab";
	}

	if((enemy.physical_resistance >= 100) || (round >= 25) || ((expected_damage() * 1.25) >= my_hp()))
	{
		if((my_mp() >= 5) && have_skill($skill[Fist of the Mummy]))
		{
			return "skill Fist of the Mummy";
		}
	}

	if((my_mp() < 5) && (item_amount($item[Holy Spring Water]) > 0))
	{
		return "item Holy Spring Water";
	}

	if(round >= 29)
	{
		print("About to UNDYING too much but have no other combat resolution. Please report this.", "red");
	}

	if((fightStat > monster_defense()) && (round < 20) && ((expected_damage() * 1.1) < my_hp()) && (get_property("cc_edStatus") == "dying"))
	{
		print("Attacking with weapon because we don't have enough MP. Expected damage: " + expected_damage() + ", current hp: " + my_hp(), "red");
		return "attack with weapon";
	}

	return "skill Mild Curse";
}
