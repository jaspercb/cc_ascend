script "cc_combat.ash"
import <cc_util.ash>
import <cc_equipment.ash>
import <cc_edTheUndying.ash>

void handleBanish(monster enemy, skill banisher);
void handleBanish(monster enemy, item banisher);
void handleYellowRay(monster enemy, skill yellowRay);
void handleYellowRay(monster enemy, item yellowRay);
void handleSniffs(monster enemy, skill sniffer);
void handleLashes(monster enemy);
void handleRenenutet(monster enemy);

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

/*	Translation Info:
abcdefghijklmnopqrstuvwxyz
4bc 3fgh1 k1mn0pqr57u wxy
	1337 Knob Goblin Barbecue team
         Kn0b G0b11n B4rb3cu3 734m
    1337 g14n7 5w4rm 0f ghu01 wh31p5
         giant swarm of ghuol whelps
    1337 m4y0nn4153 w45p
         mayonnaise wasp
*/

	string fun = "";
	monster enemy = to_monster(opp);
	if(enemy.base_hp == 0)
	{
		while((length(opp) > 0) && (enemy.base_hp == 0))
		{
			int space = index_of(opp, " ");
			if(space == -1)
			{
				print("Could not determine non-fun monster.", "red");
				break;
			}
			else
			{
				fun = fun + substring(opp, 0, space+1);
				opp = substring(opp, space+1);
				enemy = to_monster(opp);

				//Also, try the transliteration of the monster
				//	Either from:	1)	location monster list
				//					2)	wandering tracking
				//					3)	from copy source
				//					4)	as hinted (when using bypass, and not-implemented)

				if(enemy.base_hp != 0)
				{
					print("Determined non-fun monster: (" + enemy + ") with fun: " + fun, "blue");
					set_property("cc_funPrefix", fun);
				}
			}
		}
	}

	if(contains_text(fun, "annoying"))
	{
		if(contains_text(text, "makes the most annoying noise you've ever heard, stopping you in your tracks."))
		{
			print("Last action failed, uh oh! Trying to undo!", "olive");
			set_property("cc_combatHandler", get_property("cc_funCombatHandler"));
		}
		set_property("cc_funCombatHandler", get_property("cc_combatHandler"));
	}

	phylum type = monster_phylum(enemy);

	phylum fish = to_phylum("fish");
	phylum construct = to_phylum("construct");
	phylum constellation = to_phylum("constellation");
	phylum current = to_phylum(get_property("dnaSyringe"));

	string combatState = get_property("cc_combatHandler");
	int thunderBirdsLeft = get_property("cc_combatHandlerThunderBird").to_int();
	int fingernailClippersLeft = get_property("cc_combatHandlerFingernailClippers").to_int();

	#Handle different path is monster_level_adjustment() > 150 (immune to staggers?)
	int mcd = monster_level_adjustment();

	boolean doBanisher = !get_property("kingLiberated").to_boolean();

	if(enemy == $monster[Your Shadow])
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
		if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
		{
			set_property("cc_combatHandler", combatState + "(love stinkbug1)");
			return "skill summon love stinkbug";
		}

		if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
		{
			set_property("cc_combatHandler", combatState + "(love stinkbug2)");
			return "skill summon love stinkbug";
		}

		if((!contains_text(combatState, "shell up")) && have_skill($skill[Shell Up]) && (my_mp() >= 6) && ((my_hp() * 4) < my_maxhp()))
		{
			set_property("cc_combatHandler", combatState + "(shell up)");
			return "skill shell up";
		}

		if(have_skill($skill[headbutt]) && (my_mp() >= 3))
		{
			return "headbutt";
		}
		if(have_skill($skill[clobber]) && ((my_mp() >= 1) || (my_class() == $class[Seal Clubber])))
		{
			return "clobber";
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
		if(my_mp() >= 24)
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

	if(get_property("cc_useCleesh") == "yes")
	{
		if((!contains_text(combatState, "cleesh")) && have_skill($skill[cleesh]) && (my_mp() > 10))
		{
			set_property("cc_useCleesh", "no");
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
			handleBanish(enemy, $item[louder than bomb]);
			return "item louder than bomb";
		}
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(combatState, "makeitrain")) && (get_property("cc_nunsTrickReady") == "yes"))
	{
		if((my_rain() > 10) && (have_skill($skill[make it rain])))
		{
			set_property("cc_combatHandler", combatState + "(makeitrain)");
			return "skill make it rain";
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

	#Do not accidentally charge the nanorhino with a non-banisher
	if((my_familiar() == $familiar[Nanorhino]) && (have_effect($effect[Nanobrawny]) == 0))
	{
		return "skill toss";
	}

#	if((!contains_text(combatState, "nanotoss")) && (my_familiar() == $familiar[Nanorhino]) && (have_effect($effect[Nanobrawny]) >= 40))
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
			if((get_property("_badlyRomanticArrows") == "1") && (round <= 1))
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

	if(have_skill($skill[Summon Mayfly Swarm]) && (!contains_text(combatState, "mayfly")))
	{
		if((equipped_item($slot[acc1]) == $item[Mayfly Bait Necklace]) || (equipped_item($slot[acc2]) == $item[Mayfly Bait Necklace]) || (equipped_item($slot[acc3]) == $item[Mayfly Bait Necklace]))
		{
			if((my_location() == $location[Dreadsylvanian Village]) || (my_location() == $location[Dreadsylvanian Castle]) || (my_location() == $location[Dreadsylvanian Woods]) || (my_location() == $location[Sloppy Seconds Diner]))
			{
				set_property("cc_combatHandler", combatState + "(mayfly)");
				return "skill summon mayfly swarm";
			}
		}
	}


	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && (!contains_text(combatState, "insults")))
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
			handleSniffs(enemy, $skill[Transcendent Olfaction]);
			return "skill transcendent olfaction";
		}
		if((enemy == $monster[Gladiator]) && (my_location() == $location[The Roman Forum]))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleSniffs(enemy, $skill[Transcendent Olfaction]);
			return "skill transcendent olfaction";
		}
	}

	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && get_property("kingLiberated").to_boolean())
	{
		if(enemy == $monster[Gurgle the Turgle])
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleSniffs(enemy, $skill[Transcendent Olfaction]);
			return "skill transcendent olfaction";
		}
	}



	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && ((get_property("cc_hasrainman") != "true") || get_property("cc_100familiar").to_boolean()))
	{
		if((enemy == $monster[writing desk]) && (my_location() == $location[The Haunted Library]))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleSniffs(enemy, $skill[Transcendent Olfaction]);
			return "skill transcendent olfaction";
		}
	}

	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40) && (enemy == $monster[Smoke Monster]) && (item_amount($item[Pack Of Smokes]) > 0))
	{
		set_property("cc_combatHandler", combatState + "(olfaction)");
		handleSniffs(enemy, $skill[Transcendent Olfaction]);
		return "skill transcendent olfaction";
	}


	if((have_effect($effect[on the trail]) == 0) && (have_skill($skill[transcendent olfaction])) && (my_mp() >= 40))
	{
		if((enemy == $monster[blooper]) ||
			(enemy == $monster[bob racecar]) ||
			(enemy == $monster[racecar bob]) ||
#			(enemy == $monster[cubist bull]) ||
			(enemy == $monster[pygmy bowler]) ||
			(enemy == $monster[pygmy witch surgeon]) ||
			(enemy == $monster[quiet healer]) ||
			(enemy == $monster[morbid skull]))
		{
			set_property("cc_combatHandler", combatState + "(olfaction)");
			handleSniffs(enemy, $skill[Transcendent Olfaction]);
			return "skill transcendent olfaction";
		}
	}

	if(contains_text(combatState, "insults"))
	{
		if(enemy == $monster[shady pirate])
		{
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
		if(enemy == $monster[shifty pirate])
		{
			if(get_property("_pantsgivingBanish").to_int() < 5)
			{
				handleBanish(enemy, $skill[talk about politics]);
				return "skill talk about poltiics";
			}
		}
		if(my_lightning() >= 25)
		{
			if(have_skill($skill[lightning strike]))
			{
				return "skill lightning strike";
			}
		}
	}

	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(combatState, "4dcamera")) && (get_property("cc_nunsTrickActive") == "yes") && (item_amount($item[4-d Camera]) == 1) && (get_property("_cameraUsed").to_boolean() != true))
	{
		set_property("cc_combatHandler", combatState + "(4dcamera)");
		return "item 4-d camera";
	}

	if((enemy == $monster[clingy pirate]) && (item_amount($item[cocktail napkin]) > 0))
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

	if(have_effect($effect[everything looks yellow]) == 0)
	{
		if(contains_text(combatState, "yellowray"))
		{
			abort("Ugh, where is my damn yellowray!!!");
		}
		if((my_lightning() >= 5) || (item_amount($item[golden light]) > 0) || (my_familiar() == $familiar[Crimbo Shrub]))
		{
			boolean doYellow = false;
			if((enemy == $monster[burly sidekick]) && (item_amount($item[mohawk wig]) == 0))
			{
				doYellow = true;
			}
			if((enemy == $monster[filthworm royal guard]) ||
				((enemy == $monster[orcish frat boy spy]) && (my_daycount() == 1)) ||
				(enemy == $monster[knob goblin harem girl]))
			{
				doYellow = true;
			}
			if((get_property("cc_nunsTrickGland") == "start") && (enemy == $monster[larval filthworm]))
			{
				doYellow = true;
			}
			if(doYellow)
			{
				set_property("cc_combatHandler", combatState + "(yellowray)");
				if(my_familiar() == $familiar[Crimbo Shrub])
				{
					print("Trying to Open a Big Yellow Present", "red");
					handleYellowRay(enemy, $skill[Open a Big Yellow Present]);
					return "skill Open a Big Yellow Present";
				}
				if(my_lightning() >= 5)
				{
					handleYellowRay(enemy, $skill[Ball Lightning]);
					return "skill ball lightning";
				}
				handleYellowRay(enemy, $item[Golden Light]);
				return "item golden light";
			}
		}
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
#			(enemy == $monster[empty suit of armor]) ||
			(enemy == $monster[tomb servant]) ||
			(enemy == $monster[sabre-toothed goat]) ||
			(enemy == $monster[pygmy witch lawyer]) ||
			(enemy == $monster[pygmy witch nurse]) ||
			(enemy == $monster[possessed laundry press]) ||
			(enemy == $monster[mismatched twins]) ||
			(enemy == $monster[crusty pirate]))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
		if((enemy == $monster[burly sidekick]) && (item_amount($item[mohawk wig]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
		if((enemy == $monster[knob goblin madam]) && (item_amount($item[knob goblin perfume]) > 0))
		{
			set_property("cc_combatHandler", combatState + "(thunder clap)");
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
	}

	#First pass politics
	if((!contains_text(combatState, "politics")) && (have_skill($skill[talk about politics])) && (get_property("_pantsgivingBanish").to_int() < 5))
	{
		if((enemy == $monster[plaid ghost]) ||
			(enemy == $monster[skeletal sommelier]) ||
			(enemy == $monster[slick lihc]) ||
			(enemy == $monster[doughbat]) ||
			(enemy == $monster[natural spider]) ||
			(enemy == $monster[wardr&ouml;b nightstand]) ||
			(enemy == $monster[upgraded ram]) ||
			(enemy == $monster[taco cat]))
		{
			set_property("cc_combatHandler", combatState + "(politics)");
			handleBanish(enemy, $skill[talk about politics]);
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

	#Only Batter Up
	if((!contains_text(combatState, "batter up!")) && (have_skill($skill[batter up!])) && (my_fury() >= 5))
	{
		if((enemy == $monster[animated rustic nightstand]) ||
			(enemy == $monster[bullet bill]) ||
			(enemy == $monster[coaltergeist]) ||
			(enemy == $monster[chatty pirate]) ||
			(enemy == $monster[snow queen]) ||
			(enemy == $monster[steam elemental]) ||
			(enemy == $monster[drunk goat]) ||
			(enemy == $monster[evil olive]) ||
			(enemy == $monster[procrastination giant]) ||
			(enemy == $monster[protagonist]) ||
			(enemy == $monster[mad wino]) ||
			(enemy == $monster[tomb asp]) ||
			(enemy == $monster[animated possessions]) ||
			(enemy == $monster[senile lihc]) ||
#			(enemy == $monster[guy with a pitchfork\, and his wife]) ||
			(enemy == $monster[pygmy headhunter]) ||
			(enemy == $monster[pygmy orderlies]) ||
			(enemy == $monster[punk rock giant]) ||
			(enemy == $monster[skeletal sommelier]) ||
			(enemy == $monster[possessed laundry press]) ||
			(enemy == $monster[knob goblin harem guard]) ||
			(enemy == $monster[bubblemint twins]))
		{
			set_property("cc_combatHandler", combatState + "(batter up!)");
			handleBanish(enemy, $skill[batter up!]);
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
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
	}

	#Second poltiics pass
	if((!contains_text(combatState, "politics")) && (have_skill($skill[talk about politics])) && (get_property("_pantsgivingBanish").to_int() < 5))
	{
		if((enemy == $monster[tomb asp]) ||
			(enemy == $monster[pygmy orderlies]) ||
			(enemy == $monster[clingy pirate]))
		{
			set_property("cc_combatHandler", combatState + "(politics)");
			handleBanish(enemy, $skill[talk about politics]);
			return "skill talk about politics";
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

	if(!enemy.boss)
	{
		if(my_lightning() > 89)
		{
			if(have_skill($skill[lightning strike]))
			{
				return "skill lightning strike";
			}
		}
		if(my_lightning() >= 25)
		{
			if((my_daycount() == 2) && (get_property("desertExploration").to_int() < 100))
			{
				if((my_familiar() == $familiar[Artistic Goth Kid]) && (have_skill($skill[lightning strike])))
				{
					return "skill lightning strike";
				}
			}
			else if(have_skill($skill[lightning strike]))
			{
				return "skill lightning strike";
			}
		}
	}

	#Default behaviors:
	if(mcd < 150)
	{
		if((!contains_text(combatState, "weaksauce")) && (have_skill($skill[curse of weaksauce])) && (my_mp() >= 60))
		{
			set_property("cc_combatHandler", combatState + "(weaksauce)");
			return "skill curse of weaksauce";
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
			set_property("cc_combatHandler", combatState + "(love mosquito1)");
			return "skill summon love mosquito";
		}

		if((!contains_text(combatState, "love mosquito")) && get_property("lovebugsUnlocked").to_boolean())
		{
			set_property("cc_combatHandler", combatState + "(love mosquito2)");
			return "skill summon love mosquito";
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
			set_property("cc_combatHandler", combatState + "(love gnats1)");
			return "skill summon love gnats";
		}

		if((!contains_text(combatState, "love gnats")) && get_property("lovebugsUnlocked").to_boolean())
		{
			set_property("cc_combatHandler", combatState + "(love gnats2)");
			return "skill summon love gnats";
		}
	}

	if((!contains_text(combatState, "candyblast")) && (my_mp() > 60) && (get_property("kingLiberated").to_boolean()))
	{
		set_property("cc_combatHandler", combatState + "(candyblast)");
		return "skill candyblast";
	}

	if((!contains_text(combatState, "spiritsnap")) && (my_class() == $class[Turtle Tamer]) && (have_skill($skill[Spirit Snap]) && (my_mp() > 80)))
	{
		set_property("cc_combatHandler", combatState + "(spiritsnap)");
		return "skill spirit snap";
	}

	string attackBasic = "attack with weapon";
	string attackMinor = "attack with weapon";
	string attackMajor = "attack with weapon";
	string stunner = "";

	switch(my_class())
	{
	case $class[Seal Clubber]:
		attackMinor = "attack with weapon";
		if(have_skill($skill[lunge smack]) && (my_mp() >= 1))
		{
			attackMinor = "skill lunge smack";
		}
		if(have_skill($skill[lunging thrust-smack]) && (my_mp() >= 8))
		{
			attackMajor = "skill lunging thrust-smack";
		}
		if(have_skill($skill[Club Foot]) && (my_mp() >= 8))
		{
			stunner = "skill club foot";
		}
		break;
	case $class[Sauceror]:
		if((my_mp() >= 30) && (have_skill($skill[Saucegeyser])))
		{
			attackMinor = "skill saucegeyser";
			attackMajor = "skill saucegeyser";
		}
		if(my_soulsauce() >= 5)
		{
			stunner = "skill soul bubble";
		}
		break;
	case $class[Turtle Tamer]:
		attackMinor = "attack with weapon";
		if((my_mp() > 150) && (have_skill($skill[shieldbutt])) && hasShieldEquipped())
		{
			attackMinor = "skill shieldbutt";
		}
		else if(my_mp() > 80)
		{
			attackMinor = "skill kneebutt";
		}
		attackMajor = "skill kneebutt";
		if((have_skill($skill[shieldbutt])) && hasShieldEquipped() && (my_mp() >= 10))
		{
			attackMajor = "skill shieldbutt";
		}
		if(have_skill($skill[Shell Up]))
		{
			stunner = "skill shell up";
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

			if((!contains_text(combatState, "stunner")) && (stunner != "") && (monster_level_adjustment() <= 150) && (my_mp() > 10))
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
			if((enemy == $monster[Aquagoblin]) ||
				(enemy == $monster[Lord Soggyraven]))
			{
				return attackMajor;
			}
			if((my_class() == $class[Turtle Tamer]) && (my_mp() >= 10) && (have_skill($skill[Spirit Snap])) && (!contains_text(combatState, "spirit snap")))
			{
				set_property("cc_combatHandler", combatState + "(spirit snap)");
				return "skill spirit snap";
			}
			if((!contains_text(combatState, "northern explosion")) && (have_skill($skill[northern explosion])) && (my_mp() >= 16) && (my_class() == $class[Seal Clubber]) && (monster_element(enemy) != $element[cold]))
			{
				set_property("cc_combatHandler", combatState + "(northern explosion)");
				return "skill northern explosion";
			}
			if((!contains_text(combatState, "last attempt")) && (my_mp() >= 8))
			{
				set_property("cc_combatHandler", combatState + "(last attempt)");
				return attackMajor;
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


		if((monster_level_adjustment() > 150) && (my_mp() >= 8))
		{
			return attackMajor;
		}
		if((have_skill($skill[lunge smack])) && (my_mp() >= 1))
		{
			return attackMinor;
		}
		return attackBasic;
	}

	if(round > 100)
	{
		abort("Some sort of problem occured, maybe the fat stacks were nerfed again");
	}

	return attackBasic;
#	return get_ccs_action(round);
}


void handleBanish(monster enemy, skill banisher)
{
	string banishes = get_property("cc_banishes");
	if(banishes != "")
	{
		banishes = banishes + ", ";
	}
	banishes = banishes + "(" + my_daycount() + ":" + enemy + ":" + banisher + ":" + my_turncount() + ")";
	set_property("cc_banishes", banishes);
}

void handleBanish(monster enemy, item banisher)
{
	string banishes = get_property("cc_banishes");
	if(banishes != "")
	{
		banishes = banishes + ", ";
	}
	banishes = banishes + "(" + my_daycount() + ":" + enemy + ":" + banisher + ":" + my_turncount() + ")";
	set_property("cc_banishes", banishes);
}


void handleYellowRay(monster enemy, skill yellowRay)
{
	string yellow = get_property("cc_yellowRays");
	if(yellow != "")
	{
		yellow = yellow + ", ";
	}
	yellow = yellow + "(" + my_daycount() + ":" + enemy + ":" + yellowRay + ":" + my_turncount() + ")";
	set_property("cc_yellowRays", yellow);
}

void handleYellowRay(monster enemy, item yellowRay)
{
	string yellow = get_property("cc_yellowRays");
	if(yellow != "")
	{
		yellow = yellow + ", ";
	}
	yellow = yellow + "(" + my_daycount() + ":" + enemy + ":" + yellowRay + ":" + my_turncount() + ")";
	set_property("cc_yellowRays", yellow);
}

string findBanisher(string opp)
{
	print("In findBanisher for: " + opp, "green");
	monster enemy = to_monster(opp);
	if(get_property("cc_gremlinlouder") == "")
	{
		set_property("cc_gremlinlouder", "used");
		if(item_amount($item[louder than bomb]) > 0)
		{
			handleBanish(enemy, $item[louder than bomb]);
			return "item louder than bomb";
		}
	}
	if(get_property("cc_gremlinpants") == "")
	{
		set_property("cc_gremlinpants", "used");
		if(have_skill($skill[talk about politics]))
		{
			handleBanish(enemy, $skill[talk about politics]);
			return "skill talk about politics";
		}
	}
	if(get_property("cc_gremlinbatter") == "")
	{
		set_property("cc_gremlinbatter", "used");
		if((have_skill($skill[batter up!])) && (my_fury() >= 5))
		{
			handleBanish(enemy, $skill[batter up!]);
			return "skill batter up!";
		}
	}
	if(get_property("cc_gremlinclap") == "")
	{
		set_property("cc_gremlinclap", "used");
		if(have_skill($skill[thunder clap]))
		{
			handleBanish(enemy, $skill[thunder clap]);
			return "skill thunder clap";
		}
	}

	if(my_thunder() >= 40)
	{
		return "skill thunder clap";
	}
	if((have_skill($skill[talk about politics])) && (get_property("_pantsgivingBanish").to_int() < 5))
	{
		return "skill talk about politics";
	}

	if((my_class() == $class[Ed]) && have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		handleBanish(enemy, $skill[Curse of Vacation]);
		return "skill curse of vacation";
	}

	return "attack with weapon";
}

string ccsJunkyard(int round, string opp, string text)
{
	if(opp == "gourmet gourami")
	{
		return "attack with weapon";
	}

	if(round == 0)
	{
		print("ccsJunkyard: " + round, "brown");
		set_property("cc_gremlinMoly", true);
		set_property("cc_combatJunkyard", "clear");
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

	if(my_location() == $location[Next To That Barrel With Something Burning In It])
	{
		if(opp == "vegetable gremlin")
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
		if(opp == "erudite gremlin")
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
		if(opp == "spider gremlin")
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
		if(opp == "batwinged gremlin")
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
	if((!contains_text(combatState, "marshmallow")) && have_skill($skill[Curse of the Marshmallow]) && (my_mp() > 1))
	{
		set_property("cc_combatHandler", combatState + "(marshmallow)");
		return "skill Curse of the Marshmallow";
	}
	if((!contains_text(combatState, "love scarab")) && have_skill($skill[Summon Love Scarabs]))
	{
		set_property("cc_combatHandler", combatState + "(love scarab1)");
		return "skill summon love scarabs";
	}
	if((!contains_text(combatState, "love scarab")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love scarab2)");
		return "skill summon love scarabs";
	}
	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("cc_combatHandler", combatState + "(love gnats1)");
		return "skill summon love gnats";
	}
	if((!contains_text(combatState, "love gnats")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love gnats2)");
		return "skill summon love gnats";
	}

	if(!get_property("cc_gremlinMoly").to_boolean() && (my_class() == $class[Ed]))
	{
		if(get_property("cc_edCombatStage").to_int() >= 2)
		{
			string banisher = findBanisher(opp);
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


	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}


	if(!get_property("cc_gremlinMoly").to_boolean())
	{
		if(my_class() == $class[Ed])
		{
			if(get_property("cc_edCombatStage").to_int() >= 2)
			{
				return findBanisher(opp);
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
			return findBanisher(opp);
		}
	}


	if(!get_property("cc_gremlinMoly").to_boolean())
	{
		if(have_skill($skill[Lunging Thrust-Smack]) && (my_mp() >= 8))
		{
			return "skill lunging thrust-smack";
		}
		if(have_skill($skill[Storm of the Scarab]) && (my_mp() >= 8))
		{
			return "skill Storm of the Scarab";
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
	if(have_skill($skill[toss]))
	{
		if((my_mp() >= 1) || (my_class() == $class[Turtle Tamer]))
		{
			return "skill toss";
		}
	}
	return "attack with weapon";
}

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

string cc_edCombatHandler(int round, string opp, string text)
{
	if(my_path() != "Actually Ed the Undying")
	{
		abort("Not in Actually Ed the Undying, this ccs will result in massive suckage.");
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
		set_property("cc_combatHandler", combatState + "(love scarab1)");
		return "skill summon love scarabs";
	}

	if((!contains_text(combatState, "love scarab")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("cc_combatHandler", combatState + "(love scarab2)");
		return "skill summon love scarabs";
	}


	if(get_property("cc_edStatus") == "UNDYING!")
	{
		if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
		{
			set_property("cc_combatHandler", combatState + "(love gnats1)");
			return "skill summon love gnats";
		}

		if((!contains_text(combatState, "love gnats")) && get_property("lovebugsUnlocked").to_boolean())
		{
			set_property("cc_combatHandler", combatState + "(love gnats2)");
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
				set_property("cc_combatHandler", combatState + "(love gnats1)");
				return "skill summon love gnats";
			}

			if((!contains_text(combatState, "love gnats")) && get_property("lovebugsUnlocked").to_boolean())
			{
				set_property("cc_combatHandler", combatState + "(love gnats2)");
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


	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("cc_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}

	if((enemy == $monster[clingy pirate]) && (item_amount($item[cocktail napkin]) > 0))
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

	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && (!contains_text(combatState, "insults")))
	{
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
			handleSniffs(enemy, $skill[Curse of Stench]);
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
				handleSniffs(enemy, $skill[Curse of Stench]);
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
				handleSniffs(enemy, $skill[Curse of Stench]);
				return "skill Curse of Stench";
			}
		}
	}

	if(contains_text(combatState, "insults") && (get_property("cc_edStatus") == "dying"))
	{
		if((enemy == $monster[shady pirate]) && have_skill($skill[Curse of Vacation]) && (my_mp() >= 30))
		{
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
		if((enemy == $monster[shifty pirate]) && (get_property("_pantsgivingBanish").to_int() < 5))
		{
			handleBanish(enemy, $skill[talk about politics]);
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
		if((opp == "mountain man") && !doWrath)
		{
			doWrath = true;
			print("Mountain man was not found by $monster (" + enemy + ")and instead only by opp compare", "red");
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
			handleYellowRay(enemy, $skill[Wrath of Ra]);
			return "skill wrath of ra";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[pygmy orderlies]) && (my_location() == $location[The Hidden Bowling Alley]))
		{
			set_property("cc_combatHandler", combatState + "(curse of vacation)");
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[fallen archfiend]) && (my_location() == $location[The Dark Heart of the Woods]) && (get_property("cc_pirateoutfit") != "almost") && (get_property("cc_pirateoutfit") != "finished"))
		{
			set_property("cc_combatHandler", combatState + "(curse of vacation)");
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
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
			handleBanish(enemy, $skill[Curse of Vacation]);
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
		if((enemy == $monster[Funky Pirate]) && !possessEquipment($item[Sewage-Clogged Pistol]))
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
			handleLashes(enemy);
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
			handleRenenutet(enemy);
			set_property("cc_edStatus", "dying");
			return "item Talisman of Renenutet";
		}
	}

	if((enemy == $monster[Pygmy Orderlies]) && (item_amount($item[Short Writ of Habeas Corpus]) > 0))
	{
		return "item short writ of habeas corpus";
	}

	if(!ed_needShop() && (my_level() >= 10) && (item_amount($item[Rock Band Flyers]) == 0) && (my_location() != $location[The Hidden Apartment Building]) && (type != to_phylum("Undead")) && (my_mp() > 20) && (my_location() != $location[Barrrney\'s Barrr]))
	{
		set_property("cc_edStatus", "dying");
	}

	if(get_property("cc_edStatus") == "UNDYING!")
	{
#		if((my_location() == $location[The Secret Government Laboratory]) || !ed_needShop())
		if(my_location() == $location[The Secret Government Laboratory])
		{
			if(item_amount($item[Rock Band Flyers]) == 0)
			{
				if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
				{
					set_property("cc_combatHandler", combatState + "(love stinkbug1)");
					return "skill summon love stinkbug";
				}
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

	if((my_mp() >= 15) && (my_location() == $location[The Secret Government Laboratory]) && have_skill($skill[Roar of the Lion]))
	{
		if(have_skill($skill[Storm of the Scarab]) && (my_buffedstat($stat[Mysticality]) >= 60))
		{
			return "skill Storm of the Scarab";
		}
		return "skill Roar of the Lion";
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
	if((fightStat > monster_defense()) && (round < 20) && ((expected_damage() * 1.1) < my_hp()))
	{
		return "attack with weapon";
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

	return "skill Mild Curse";
}
