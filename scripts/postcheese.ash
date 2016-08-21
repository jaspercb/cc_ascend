script "postcheese.ash";
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_summerfun.ash>
import <cc_ascend/cc_awol.ash>
import <cc_ascend/cc_combat.ash>
import <cc_ascend/cc_ascend_header.ash>
import <cc_ascend/cc_edTheUndying.ash>
import <cc_ascend/cc_adventure.ash>


void handlePostAdventure()
{
	if(limit_mode() == "spelunky")
	{
		return;
	}
	//We need to do this early, and even if postAdventure handling is done.
	if(my_path() == "The Source")
	{
		if(get_property("cc_diag_round").to_int() == 0)
		{
			monster last = last_monster();
			string temp = visit_url("main.php");
			if(last != last_monster())
			{
				print("Interrupted battle detected at post combat time", "red");
				if(have_effect($effect[Beaten Up]) > 0)
				{
					print("Post combat time caused up to be Beaten Up!", "red");
					return;
				}
				ccAdv(my_location());
				return;
			}
		}
	}

	//This has a post combat scenario, let us just handle it.
	if(last_monster() == $monster[Cake Lord])
	{
		run_choice(1);
		run_choice(1);
	}

	if(get_property("cc_bedroomHandler1") == "yes")
	{
		set_property("cc_bedroomHandler1", "no");
		if(contains_text(visit_url("main.php"), "choice.php"))
		{
			print("Postadventure skipped by bedroom handler.", "green");
			return;
		}
	}

	if(get_property("cc_disableAdventureHandling") == "yes")
	{
		print("Postadventure skipped by standard adventure handler.", "green");
		return;
	}

	if(!get_property("_ballInACupUsed").to_boolean() && (item_amount($item[Ball-In-A-Cup]) > 0))
	{
		use(1, $item[Ball-In-A-Cup]);
	}
	if(!get_property("_setOfJacksUsed").to_boolean() && (item_amount($item[Set of Jacks]) > 0))
	{
		use(1, $item[Set of Jacks]);
	}
	if(!get_property("_hobbyHorseUsed").to_boolean() && (item_amount($item[Handmade Hobby Horse]) > 0))
	{
		use(1, $item[Handmade Hobby Horse]);
	}


	if((my_location() == $location[The Lower Chambers]) && (item_amount($item[2334]) == 0))
	{
		print("Postadventure skipped by Ed the Undying!", "green");
		return;
	}

	ocrs_postHelper();
	if(last_monster().random_modifiers["clingy"])
	{
		print("Postadventure skipped by clingy modifier.", "green");
		return;
	}

	if(have_effect($effect[Cunctatitis]) > 0)
	{
		if((my_mp() >= 12) && have_skill($skill[Disco Nap]))
		{
			use_skill(1, $skill[Disco Nap]);
		}
		else
		{
			uneffect($effect[Cunctatitis]);
		}
	}

	if(my_class() == $class[Avatar of Sneaky Pete])
	{
		buffMaintain($effect[All Revved Up], 25, 1, 10);
		buffMaintain($effect[Of Course It Looks Great], 55, 1, 10);
		if(have_skill($skill[Throw Party]) && !get_property("_petePartyThrown").to_boolean())
		{
			int threshold = 50;
			if(!possessEquipment($item[Sneaky Pete\'s Leather Jacket]) && !possessEquipment($item[Sneaky Pete\'s Leather Jacket (Collar Popped)]))
			{
				threshold = 30;
			}
			if(my_audience() >= threshold)
			{
				use_skill(1, $skill[Throw Party]);
			}
		}
		if(have_skill($skill[Incite Riot]) && !get_property("_peteRiotIncited").to_boolean())
		{
			int threshold = -50;
			if(!possessEquipment($item[Sneaky Pete\'s Leather Jacket]) && !possessEquipment($item[Sneaky Pete\'s Leather Jacket (Collar Popped)]))
			{
				threshold = -30;
			}
			if(my_audience() <= threshold)
			{
				use_skill(1, $skill[Incite Riot]);
			}
		}
	}

	if(my_path() == "Nuclear Autumn")
	{
		buffMaintain($effect[Juiced and Loose], 35, 1, 1);
		buffMaintain($effect[Hardened Sweatshirt], 35, 1, 1);
		buffMaintain($effect[Ear Winds], 35, 1, 1);
		buffMaintain($effect[Impeccable Coiffure], 75, 1, 1);
		buffMaintain($effect[Mind Vision], 200, 1, 1);

		buffMaintain($effect[Juiced and Loose], 75, 1, 30);
		buffMaintain($effect[Hardened Sweatshirt], 75, 1, 30);

		if(my_meat() > 15000)
		{
			buffMaintain($effect[Rad-Pro Tected], 0, 1, 1);
		}
	}

	if(my_path() == "Actually Ed the Undying")
	{
		int maxBuff = max(5, 660 - my_turncount());
		if(my_mp() < 40)
		{
			maxBuff = 5;
		}
		if(my_level() < 13)
		{
			buffMaintain($effect[Prayer of Seshat], 5, 1, maxBuff);
		}
		if(my_location() == $location[The Secret Government Laboratory])
		{
			buffMaintain($effect[Wisdom of Thoth], 5, 1, maxBuff);
			buffMaintain($effect[Power of Heka], 10, 1, maxBuff);
		}
		else
		{
			buffMaintain($effect[Wisdom of Thoth], 150, 1, maxBuff);
			buffMaintain($effect[Power of Heka], 100, 1, maxBuff);
		}

		if(get_property("edPoints").to_int() <= 6)
		{
			buffMaintain($effect[Wisdom of Thoth], 5, 1, 10);
			buffMaintain($effect[Power of Heka], 10, 1, 10);
		}

		buffMaintain($effect[Hide of Sobek], 200, 1, maxBuff);
		if(my_location() == $location[Hippy Camp])
		{
			buffMaintain($effect[Hide of Sobek], 20, 1, maxBuff);
		}

		if(!($locations[Hippy Camp, Pirates of the Garbage Barges, The Secret Government Laboratory] contains my_location()))
		{
			buffMaintain($effect[Bounty of Renenutet], 20, 1, maxBuff);
		}

		if((my_servant() == $servant[Priest]) && ($servant[Priest].experience < 196) && ($servant[Priest].experience >= 81))
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}
		if(my_servant() == $servant[Cat])
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}
		if((my_servant() == $servant[Belly-Dancer]) && ($servant[Belly-Dancer].experience < 196) && ($servant[Belly-Dancer].experience >= 81))
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}


		if(my_mp() > 100)
		{
			#int start = my_mp();
			int maxBuff = max(5, 750 - my_turncount());
			buffMaintain($effect[Prayer of Seshat], 5, 1, maxBuff);
			buffMaintain($effect[Wisdom of Thoth], 5, 1, maxBuff);
			#buffMaintain($effect[Power of Heka], 10, 1, maxBuff);
			#buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
			buffMaintain($effect[Hide of Sobek], 10, 1, maxBuff);
			buffMaintain($effect[Bounty of Renenutet], 20, 1, maxBuff);
			#if(start == my_mp())
			#{
			#	break;
			#}
		}

		if((my_level() < 13) && (my_level() > 3) && !get_property("cc_needLegs").to_boolean())
		{
			buffMaintain($effect[Blessing of Serqet], 15, 1, 1);
		}

		#+NC Maintenance
		if($locations[The Castle in the Clouds in the Sky (Basement), The Castle in the Clouds in the Sky (Ground Floor), The Castle in the Clouds in the Sky (Top Floor), The Dark Elbow of the Woods, The Dark Heart of the Woods, The Dark Neck of the Woods, The Defiled Alcove, The Defiled Cranny, The Haunted Ballroom, The Haunted Bathroom, The Haunted Billiards Room, The Haunted Gallery, The Hidden Hospital, Inside the Palindome, The Obligatory Pirate\'s Cove, The Penultimate Fantasy Airship, The Poop Deck, The Spooky Forest, Twin Peak, Wartime Hippy Camp] contains my_location())
		{
			if((have_effect($effect[Shelter of Shed]) == 0) && (my_mp() < 15))
			{
				print("We are having an MP problem damn it.... I wish I knew what data to output here to help with it.", "red");
				print("You probably want to abort and use some MP restorer. Sorry dude... otherwise, you can suck up the delays :)", "red");
				wait(10);
				if(item_amount($item[Magical Mystery Juice]) > 0)
				{
					use(1, $item[Magical Mystery Juice]);
				}
				else if(item_amount($item[Phonics Down]) > 0)
				{
					use(1, $item[Phonics Down]);
				}
				else if(item_amount($item[Tiny House]) > 0)
				{
					use(1, $item[Tiny House]);
				}
				else if(item_amount($item[Grogpagne]) > 0)
				{
					use(1, $item[Grogpagne]);
				}
				else if(item_amount($item[Holy Spring Water]) > 0)
				{
					use(1, $item[Holy Spring Water]);
				}
				else if(item_amount($item[Spirit Beer]) > 0)
				{
					use(1, $item[Spirit Beer]);
				}
				else if(item_amount($item[Sacramental Wine]) > 0)
				{
					use(1, $item[Sacramental Wine]);
				}
			}
			buffMaintain($effect[Shelter of Shed], 15, 1, 1);
		}
		if((my_mp() + 100) < my_maxmp())
		{
			if(item_amount($item[Magical Mystery Juice]) > 0)
			{
				use(1, $item[Magical Mystery Juice]);
			}
			else if(item_amount($item[Grogpagne]) > 0)
			{
				use(1, $item[Grogpagne]);
			}
			else if(item_amount($item[Phonics Down]) > 0)
			{
				use(1, $item[Phonics Down]);
			}
			else if(item_amount($item[Tiny House]) > 0)
			{
				use(1, $item[Tiny House]);
			}
			else if(item_amount($item[Holy Spring Water]) > 0)
			{
				use(1, $item[Holy Spring Water]);
			}
			else if(item_amount($item[Spirit Beer]) > 0)
			{
				use(1, $item[Spirit Beer]);
			}
			else if(item_amount($item[Sacramental Wine]) > 0)
			{
				use(1, $item[Sacramental Wine]);
			}
		}
		return;
	}

	skill libram = preferredLibram();

	buffMaintain($effect[Merry Smithsness], 0, 1, 10);

	#Deal with Poison, (should do all of them actually)
	if((have_effect($effect[Really Quite Poisoned]) > 0) || (have_effect($effect[A Little Bit Poisoned]) > 0) || (have_effect($effect[Majorly Poisoned]) > 0))
	{
		if((my_mp() > 12) && have_skill($skill[Disco Nap]))
		{
			use_skill(1, $skill[Disco Nap]);
		}
		else
		{
			buyUpTo(1, $item[anti-anti-antidote], 30);
#			visit_url("shop.php?pwd=&whichshop=doc&action=buyitem&quantity=1&whichrow=694", true);
			use(1, $item[anti-anti-antidote]);
		}
	}

	if(have_effect($effect[Temporary Amnesia]) > 0)
	{
		if(!uneffect($effect[Temporary Amnesia]))
		{
			abort("Could not remove temporary amnesia and now I suckzor.");
		}
	}

	if((my_class() == $class[Turtle Tamer]) && guild_store_available())
	{
		buffMaintain($effect[Eau de Tortue], 0, 1, 1);
	}

	if((monster_level_adjustment() > 140) && !get_property("kingLiberated").to_boolean())
	{
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}

	if(my_path() == "Community Service")
	{
		if(have_skill($skill[Summon BRICKOs]) && (get_property("_brickoEyeSummons").to_int() < 3))
		{
			libram = $skill[Summon BRICKOs];
		}
		else if(have_skill($skill[Summon Taffy]))
		{
			libram = $skill[Summon Taffy];
		}

		int missing = (my_maxmp() - my_mp()) / 15;
		int casts = (my_soulsauce() - 25) / 5;
		if(casts < 0)
		{
			casts = 0;
		}
		int regen = casts;
		if(casts > missing)
		{
			regen = missing;
		}
		if(regen > 0)
		{
			use_skill(regen, $skill[Soul Food]);
		}

		boolean [skill] toCast = $skills[Advanced Cocktailcrafting, Advanced Saucecrafting, Communism!, Grab a Cold One, Lunch Break, Pastamastery, Perfect Freeze, Request Sandwich, Spaghetti Breakfast, Summon Alice\'s Army Cards, Summon Carrot, Summon Confiscated Things, Summon Crimbo Candy, Summon Geeky Gifts, Summon Hilarious Objects, Summon Holiday Fun!, Summon Kokomo Resort Pass, Summon Tasteful Items];

		foreach sk in toCast
		{
			if(have_skill(sk) && (my_mp() >= mp_cost(sk)))
			{
				use_skill(1, sk);
			}
		}

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 15) && (mp_cost(libram) < 75))
		{
			use_skill(1, libram);
		}
		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 175))
		{
			use_skill(1, libram);
		}
		return;
	}

	if(cc_my_path() == "The Source")
	{
		if((get_property("sourceInterval").to_int() > 0) && (get_property("sourceInterval").to_int() <= 600) && (get_property("sourceAgentsDefeated").to_int() >= 9))
		{
			if((have_effect($effect[Song of Bravado]) == 0) && (have_effect($effect[Song of Sauce]) == 0) && (have_effect($effect[Song of Slowness]) == 0) && (have_effect($effect[Song of the North]) == 0))
			{
				buffMaintain($effect[Song of Starch], 250, 1, 1);
			}
		}
	}

	if(my_class() == $class[Sauceror])
	{
		if((my_level() >= 6) && (have_effect($effect[Blood Sugar Sauce Magic]) == 0) && have_skill($skill[Blood Sugar Sauce Magic]) && !in_hardcore())
		{
			use_skill(1, $skill[Blood Sugar Sauce Magic]);
		}

		if(((my_level() <= 8) && (my_soulsauce() >= 92)) || (my_soulsauce() >= 100))
		{
			use_skill(1, $skill[Soul Rotation]);
		}
		int missing = (my_maxmp() - my_mp()) / 15;
		int casts = (my_soulsauce() - 25) / 5;
		if(casts < 0)
		{
			casts = 0;
		}
		int regen = casts;
		if(casts > missing)
		{
			regen = missing;
		}
		if(regen > 0)
		{
			use_skill(regen, $skill[Soul Food]);
		}
	}

	if((monster_level_adjustment() > 120) && ((my_hp() * 10) < (my_maxhp() * 8)) && (my_mp() >= 20))
	{
		useCocoon();
	}

	if((my_maxhp() > 200) && (my_hp() < 80) && (my_mp() > 25))
	{
		useCocoon();
	}

	#+C Maintenance
	if($locations[The Black Forest, The F\'c\'le, Sonofa Beach] contains my_location())
	{
		uneffect($effect[The Sonata of Sneakiness]);
		buffMaintain($effect[Hippy Stench], 0, 1, 10);
		buffMaintain($effect[Musk of the Moose], 15, 1, 2);
		buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
	}
	#+C Maintenance
	if(my_location() == $location[Barrrney\'s Barrr])
	{
		if(numPirateInsults() < 7)
		{
			uneffect($effect[The Sonata Of Sneakiness]);
			buffMaintain($effect[Musk of the Moose], 15, 1, 2);
			buffMaintain($effect[Carlweather\'s Cantata of Confrontation], 25, 1, 2);
		}
		else
		{
			uneffect($effect[Carlweather\'s Cantata Of Confrontation]);
			buffMaintain($effect[Smooth Movements], 15, 1, 2);
			buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
			buffMaintain($effect[Muffled], 15, 1, 1);
			buffMaintain($effect[Brooding], 25, 1, 1);
		}
	}

	if(have_skill($skill[thunderheart]) && (my_thunder() >= 90) && ((my_turncount() - get_property("cc_lastthunderturn").to_int()) >= 9))
	{
		use_skill(1, $skill[thunderheart]);
	}


	#+NC Maintenance
	if((my_location() == $location[The Penultimate Fantasy Airship]) ||
		(my_location() == $location[Twin Peak]) ||
		(my_location() == $location[A Maze of Sewer Tunnels]) ||
		(my_location() == $location[The Poop Deck]) ||
		(my_location() == $location[The Haunted Ballroom]) ||
		(my_location() == $location[The Haunted Billiards Room]) ||
		(my_location() == $location[The Haunted Gallery]) ||
		(my_location() == $location[The Haunted Bathroom]) ||
		(my_location() == $location[The Hidden Hospital]) ||
		(my_location() == $location[Inside the Palindome]) ||
		(my_location() == $location[The Dark Neck of the Woods]) ||
		(my_location() == $location[The Dark Heart of the Woods]) ||
		(my_location() == $location[The Dark Elbow of the Woods]) ||
		(my_location() == $location[The Defiled Cranny]) ||
		(my_location() == $location[The Defiled Alcove]) ||
		(my_location() == $location[The Upper Chamber]) ||
		(my_location() == $location[The Spooky Forest]) ||
		(my_location() == $location[The Middle Chamber]) ||
		(my_location() == $location[Inside the Palindome]) ||
		(my_location() == $location[The Hidden Hospital]) ||
		(my_location() == $location[The Obligatory Pirate\'s Cove]) ||
		(my_location() == $location[Wartime Hippy Camp]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Top Floor)]) ||
		(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)])
	)
	{
		buffMaintain($effect[Smooth Movements], 15, 1, 2);
		buffMaintain($effect[The Sonata of Sneakiness], 25, 1, 2);
		buffMaintain($effect[Muffled], 15, 1, 1);
		buffMaintain($effect[Brooding], 25, 1, 1);
	}

	effect awolDesired = awol_walkBuff();
	if(awolDesired != $effect[none])
	{
		if(!get_property("kingLiberated").to_boolean())
		{
			int awolMP = 85;
			if(my_class() == $class[Beanslinger])
			{
				awolMP = 95;
			}
			buffMaintain(awolDesired, awolMP, 1, 20);
		}
		else
		{
			buffMaintain(awolDesired, 120, 1, 1);
		}
	}

	if(have_skill($skill[Demand Sandwich]) && (my_mp() > 85) && (my_level() >= 9) && (get_property("_demandSandwich").to_int() < 3))
	{
		use_skill(1, $skill[Demand Sandwich]);
	}

	if(have_skill($skill[Summon Smithsness]) && (my_mp() > 20))
	{
		use_skill(1, $skill[Summon Smithsness]);
	}

	# This is the list of castables that all MP sequences will use.
	boolean [skill] toCast = $skills[Advanced Cocktailcrafting, Advanced Saucecrafting, Communism!, Grab a Cold One, Lunch Break, Pastamastery, Perfect Freeze, Request Sandwich, Spaghetti Breakfast, Summon Alice\'s Army Cards, Summon Carrot, Summon Confiscated Things, Summon Crimbo Candy, Summon Geeky Gifts, Summon Hilarious Objects, Summon Holiday Fun!, Summon Kokomo Resort Pass, Summon Tasteful Items];

	if(my_maxmp() < 50)
	{
		buffMaintain($effect[Power Ballad of the Arrowsmith], 7, 1, 5);
		buffMaintain(whatStatSmile(), 15, 1, 10);
		buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 20, 1, 10);
		buffMaintain($effect[Leash of Linguini], 20, 1, 10);
		buffMaintain($effect[Empathy], 25, 1, 10);

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 25))
		{
			use_skill(1, libram);
		}

		foreach sk in toCast
		{
			if(have_skill(sk) && ((my_mp() - 40) >= mp_cost(sk)))
			{
				use_skill(1, sk);
			}
		}

		buffMaintain($effect[Singer\'s Faithful Ocelot], 35, 1, 10);
		buffMaintain($effect[Rage of the Reindeer], 30, 1, 10);
		buffMaintain($effect[Astral Shell], 35, 1, 10);
		buffMaintain($effect[Elemental Saucesphere], 30, 1, 10);

		if(my_location() != $location[The Broodling Grounds])
		{
			buffMaintain($effect[Spiky Shell], 20, 1, 10);
			buffMaintain($effect[Scarysauce], 25, 1, 10);
		}
		buffMaintain($effect[Ghostly Shell], 25, 1, 10);
		buffMaintain($effect[Walberg\'s Dim Bulb], 35, 1, 10);
#		buffMaintain($effect[Springy Fusilli], 40, 1, 10);
		buffMaintain($effect[Blubbered Up], 30, 1, 10);
#		buffMaintain($effect[Tenacity of the Snapper], 30, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 30, 1, 10);
		buffMaintain($effect[Disco Fever], 40, 1, 10);
		buffMaintain($effect[Seal Clubbing Frenzy], 10, 3, 4);
		buffMaintain($effect[Patience of the Tortoise], 10, 3, 4);
		buffMaintain($effect[Mariachi Mood], 25, 1, 4);
		buffMaintain($effect[Saucemastery], 25, 1, 4);
		buffMaintain($effect[Disco State of Mind], 25, 1, 4);
		buffMaintain($effect[Pasta Oneness], 25, 1, 4);

	}
	else if(my_maxmp() < 80)
	{
		buffMaintain($effect[Power Ballad of the Arrowsmith], 7, 1, 5);
		buffMaintain(whatStatSmile(), 20, 1, 10);
		buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 30, 1, 10);
		buffMaintain($effect[Leash of Linguini], 30, 1, 10);
		buffMaintain($effect[Empathy], 35, 1, 10);


		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 32))
		{
			use_skill(1, libram);
		}

		foreach sk in toCast
		{
			if(have_skill(sk) && ((my_mp() - 50) >= mp_cost(sk)))
			{
				use_skill(1, sk);
			}
		}
#		buffMaintain($effect[Prayer of Seshat], 5, 1, 10);

		buffMaintain($effect[Singer\'s Faithful Ocelot], 40, 1, 10);
		buffMaintain($effect[Rage of the Reindeer], 40, 1, 10);
		buffMaintain($effect[Astral Shell], 50, 1, 10);
		buffMaintain($effect[Elemental Saucesphere], 40, 1, 10);
		if(my_location() != $location[The Broodling Grounds])
		{
			buffMaintain($effect[Spiky Shell], 40, 1, 10);
			buffMaintain($effect[Scarysauce], 40, 1, 10);
			buffMaintain($effect[Jalape&ntilde;o Saucesphere], 50, 1, 10);
		}
		buffMaintain($effect[Ghostly Shell], 45, 1, 10);
		if(my_class() == $class[Turtle Tamer])
		{
			buffMaintain($effect[Disdain of the Storm Tortoise], 60, 1, 10);
		}
		buffMaintain($effect[Walberg\'s Dim Bulb], 50, 1, 10);
#		buffMaintain($effect[Springy Fusilli], 60, 1, 10);
#		buffMaintain($effect[Flimsy Shield of the Pastalord], 70, 1, 10);
		buffMaintain($effect[Blubbered Up], 60, 1, 10);
#		buffMaintain($effect[Tenacity of the Snapper], 50, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 50, 1, 10);
		buffMaintain($effect[Disco Fever], 60, 1, 10);
		buffMaintain($effect[Seal Clubbing Frenzy], 25, 3, 4);
		buffMaintain($effect[Patience of the Tortoise], 25, 3, 4);
		buffMaintain($effect[Mariachi Mood], 50, 3, 4);
		buffMaintain($effect[Saucemastery], 50, 3, 4);
		buffMaintain($effect[Disco State of Mind], 50, 3, 4);
		buffMaintain($effect[Pasta Oneness], 50, 3, 4);
	}
	else if(my_maxmp() < 170)
	{
		buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 50, 1, 10);
		buffMaintain(whatStatSmile(), 40, 1, 10);

		buffMaintain($effect[Empathy], 50, 1, 10);
		buffMaintain($effect[Leash of Linguini], 35, 1, 10);

		foreach sk in toCast
		{
			if(have_skill(sk) && ((my_mp() - 90) >= mp_cost(sk)))
			{
				use_skill(1, sk);
			}
		}

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 40))
		{
			use_skill(1, libram);
		}

#		buffMaintain($effect[Prayer of Seshat], 5, 1, 10);

		buffMaintain($effect[Singer\'s Faithful Ocelot], 80, 1, 10);
		buffMaintain($effect[Rage of the Reindeer], 80, 1, 10);
		buffMaintain($effect[Astral Shell], 80, 1, 10);
		buffMaintain($effect[Elemental Saucesphere], 80, 1, 10);
		if(my_location() != $location[The Broodling Grounds])
		{
			buffMaintain($effect[Spiky Shell], 80, 1, 10);
			buffMaintain($effect[Scarysauce], 80, 1, 10);
			buffMaintain($effect[Jalape&ntilde;o Saucesphere], 60, 1, 10);
		}
		buffMaintain($effect[Ghostly Shell], 80, 1, 10);
		if(my_class() == $class[Turtle Tamer])
		{
			buffMaintain($effect[Disdain of the Storm Tortoise], 80, 1, 10);
		}
		buffMaintain($effect[Walberg\'s Dim Bulb], 80, 1, 10);
		buffMaintain($effect[Springy Fusilli], 80, 1, 10);
#		buffMaintain($effect[Flimsy Shield of the Pastalord], 80, 1, 10);
		buffMaintain($effect[Blubbered Up], 80, 1, 10);
#		buffMaintain($effect[Tenacity of the Snapper], 80, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 80, 1, 10);
		buffMaintain($effect[Disco Fever], 80, 1, 10);
		buffMaintain($effect[Seal Clubbing Frenzy], 50, 5, 4);
		buffMaintain($effect[Patience of the Tortoise], 50, 5, 4);
#		buffMaintain($effect[Rotten Memories], 100, 1, 10);

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 80))
		{
			use_skill(1, libram);
		}

		if(my_mp() > 80)
		{
			if((my_mp() > 95) && (my_maxhp() > my_hp()))
			{
				useCocoon();
			}
			buffMaintain($effect[Takin\' It Greasy], 50, 1, 5);
			buffMaintain($effect[Intimidating Mien], 50, 1, 5);
		}
	}
	else
	{
		boolean didOutfit = false;
		if((my_basestat($stat[mysticality]) >= 200) && (my_buffedstat($stat[mysticality]) >= 200) && (get_property("kingLiberated") != "false") && (item_amount($item[Wand of Oscus]) > 0) && (item_amount($item[Oscus\'s Dumpster Waders]) > 0) && (item_amount($item[Oscus\'s Pelt]) > 0))
		{
			cli_execute("outfit save Backup");
			#Using the cli command may not upgrade our stats if our max mp drops
			#Not sure if the ASH command actually handles it properly, we'll see.
			#cli_execute("outfit Vile Vagrant Vestments");
			#outfit does not... damn it.
			outfit("Vile Vagrant Vestments");
			didOutfit = true;
		}

		boolean doML = true;
		if(get_property("kingLiberated").to_boolean())
		{
			doML = false;
		}
		if(equipped_amount($item[Space Trip Safety Headphones]) > 0)
		{
			doML = false;
		}
		if(((get_property("flyeredML").to_int() > 9999) || get_property("cc_hippyInstead").to_boolean()) && (my_level() >= 13))
		{
			doML = false;
			#change_mcd(0);
		}
		if((my_mp() > 150) && (my_maxhp() > 300) && (my_hp() < 140))
		{
			useCocoon();
		}
		if((my_mp() > 100) && (my_maxhp() > 500) && (my_hp() < 250))
		{
			useCocoon();
		}
		if((my_mp() > 75) && (my_maxhp() > 500) && (my_hp() < 200))
		{
			useCocoon();
		}
		if((my_mp() > 75) && (my_maxhp() > 700) && (my_hp() < 300))
		{
			useCocoon();
		}
		if((my_mp() > 75) && ((my_hp() == 0) || ((my_maxhp()/my_hp()) > 3)))
		{
			useCocoon();
		}

		buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 50, 1, 10);

		buffMaintain(whatStatSmile(), 40, 1, 10);

		buffMaintain($effect[Empathy], 50, 1, 10);
		buffMaintain($effect[Leash of Linguini], 35, 1, 10);

		foreach sk in toCast
		{
			if(have_skill(sk) && ((my_mp() - 85) >= mp_cost(sk)))
			{
				use_skill(1, sk);
			}
		}

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 32))
		{
			print("Mymp: " + my_mp() + " of " + my_maxmp() + " and cost: " + mp_cost(libram), "blue");
			boolean temp = false;
			try
			{
				#if(use_skill(1, libram)) {}
				temp = use_skill(1, libram);
			}
			finally
			{
				if(!temp)
				{
					print("No longer have enough MP and failed.", "red");
					print("Mymp: " + my_mp() + " of " + my_maxmp() + " and cost: " + mp_cost(libram), "blue");
				}
			}
		}

#		buffMaintain($effect[Prayer of Seshat], 5, 1, 10);

		buffMaintain($effect[Singer\'s Faithful Ocelot], 80, 1, 10);
		if(doML)
		{
			if((monster_level_adjustment() + (2 * my_level())) <= 150)
			{
				buffMaintain($effect[Ur-Kel\'s Aria of Annoyance], 80, 1, 10);
			}
			if((monster_level_adjustment() + 10) <= 150)
			{
				buffMaintain($effect[Drescher\'s Annoying Noise], 80, 1, 10);
			}
			if((monster_level_adjustment() + 10) <= 150)
			{
				buffMaintain($effect[Pride of the Puffin], 80, 1, 10);
			}
		}
		buffMaintain($effect[Rage of the Reindeer], 80, 1, 10);
		buffMaintain($effect[Astral Shell], 80, 1, 10);
		buffMaintain($effect[Elemental Saucesphere], 80, 1, 10);
		if(my_location() != $location[The Broodling Grounds])
		{
			buffMaintain($effect[Spiky Shell], 80, 1, 10);
			buffMaintain($effect[Scarysauce], 80, 1, 10);
			buffMaintain($effect[Jalape&ntilde;o Saucesphere], 60, 1, 10);
		}
		buffMaintain($effect[Ghostly Shell], 80, 1, 10);
		buffMaintain($effect[Disdain of the War Snapper], 80, 1, 10);
		buffMaintain($effect[Walberg\'s Dim Bulb], 80, 1, 10);
		buffMaintain($effect[Springy Fusilli], 80, 1, 10);
		buffMaintain($effect[Flimsy Shield of the Pastalord], 100, 1, 10);
		buffMaintain($effect[Blubbered Up], 80, 1, 10);
		if(my_level() < 13)
		{
			buffMaintain($effect[Aloysius\' Antiphon of Aptitude], 80, 1, 10);
		}
		buffMaintain($effect[Tenacity of the Snapper], 120, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 80, 1, 10);
		buffMaintain($effect[Antibiotic Saucesphere], 300, 1, 10);
		buffMaintain($effect[Disco Fever], 80, 1, 10);
		buffMaintain($effect[Seal Clubbing Frenzy], 50, 5, 4);
		buffMaintain($effect[Patience of the Tortoise], 50, 5, 4);
		buffMaintain($effect[Mariachi Mood], 50, 5, 4);
		buffMaintain($effect[Saucemastery], 50, 5, 4);
		buffMaintain($effect[Disco State of Mind], 50, 5, 4);
		buffMaintain($effect[Pasta Oneness], 50, 5, 4);
		if(familiar_weight(my_familiar()) < 20)
		{
			buffMaintain($effect[Curiosity of Br\'er Tarrypin], 50, 1, 2);
		}
		buffMaintain($effect[Jingle Jangle Jingle], 80, 1, 2);
		buffMaintain($effect[A Few Extra Pounds], 150, 1, 2);
		buffMaintain($effect[Boon of the War Snapper], 150, 1, 5);
		buffMaintain($effect[Boon of She-Who-Was], 150, 1, 5);
		buffMaintain($effect[Boon of the Storm Tortoise], 150, 1, 5);

		buffMaintain($effect[Ruthlessly Efficient], 50, 1, 5);
		buffMaintain($effect[Mathematically Precise], 150, 1, 5);
#		buffMaintain($effect[Rotten Memories], 150, 1, 10);

		if(get_property("kingLiberated").to_boolean())
		{
			if((have_skill($skill[Summon Rad Libs])) && (my_mp() > 6))
			{
				use_skill(3, $skill[Summon Rad Libs]);
			}
			if((have_skill($skill[Summon Geeky Gifts])) && (my_mp() > 5))
			{
				use_skill(1, $skill[Summon Geeky Gifts]);
			}
			if((have_skill($skill[Summon Stickers])) && (my_mp() > 6))
			{
				use_skill(3, $skill[Summon Stickers]);
			}
			if((have_skill($skill[Summon Sugar Sheets])) && (my_mp() > 6))
			{
				use_skill(3, $skill[Summon Sugar Sheets]);
			}
			if(have_skill($skill[Rainbow Gravitation]))
			{
				use_skill(3, $skill[Rainbow Gravitation]);
			}
		}

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 80))
		{
			use_skill(1, libram);
		}

		if(my_mp() > 80)
		{
			if((my_mp() > 95) && (my_maxhp() > my_hp()))
			{
				useCocoon();
			}
			buffMaintain($effect[Takin\' It Greasy], 50, 1, 5);
			buffMaintain($effect[Intimidating Mien], 50, 1, 5);
		}

		if(didOutfit)
		{
			cli_execute("outfit Backup");
		}
	}

	if(my_class() == $class[Pastamancer])
	{
		thrall cur = my_thrall();
		thrall consider = $thrall[none];

/*							Cost		L1				L5				L10
		Vampieroghi			12			1-2 (Dmg, Heal)	Dispel Neg		+60 Max HP
		Vermincelli			30			2 MP Regen		Dmg, Poison		+30 Max MP
		Angel Hair Wisp		60			5% init			Block Crits		Block
(Undead)Elbow Maraconi		100			Equalize Mus	+2 Weapon Dmg	+10% crit
		Penne Dreadful		150			Equalize Mox	Jump Delevel	DR + 10
		Spaghetti Elemental	150			+Stats Ceil(/3)	Block First Att	+5 spell dmg
		Lasagmbie			200			20+2 Meat		Spooky Dmg		+10 spooky spell dmg
		Spice Ghost			250			10+1 Item		Spices			Stun Increase
*/

		if((my_mp() >= (1.2 * mp_cost($skill[Bind Vermincelli]))) && (cur == $thrall[none]) && have_skill($skill[Bind Vermincelli]))
		{
			consider = $thrall[Vermincelli];
		}
		if((my_mp() >= (1.2 * mp_cost($skill[Bind Spice Ghost]))) && have_skill($skill[Bind Spice Ghost]) && (my_daycount() > 1) && (numeric_modifier("MP Regen Min").to_int() > 9))
		{
			consider = $thrall[Spice Ghost];
		}

		if((consider != cur) && (consider != $thrall[none]))
		{
			skill toEquip = to_skill("Bind " + consider);
			if(toEquip != $skill[none])
			{
				if(my_mp() >= mp_cost(toEquip))
				{
					use_skill(1, toEquip);
				}
			}
			else
			{
				print("Thrall handler error. Could not generate appropriate skill.", "red");
			}
		}
	}

	if(get_property("cc_cubeItems").to_boolean() && (item_amount($item[ring of detect boring doors]) == 1) && (item_amount($item[eleven-foot pole]) == 1) && (item_amount($item[pick-o-matic lockpicks]) == 1))
	{
		set_property("cc_cubeItems", false);
	}

	if(!get_property("cc_cubeItems").to_boolean() && (my_familiar() == $familiar[Gelatinous cubeling]) && !get_property("cc_100familiar").to_boolean())
	{
		if(have_familiar($familiar[Fist Turkey]))
		{
			use_familiar($familiar[Fist Turkey]);
		}
		else if(have_familiar($familiar[Piano Cat]))
		{
			use_familiar($familiar[Piano Cat]);
		}
	}

	if((my_daycount() == 1) && (my_familiar() == $familiar[Fist Turkey]) && (get_property("_turkeyBooze").to_int() >= 5)  && !get_property("cc_100familiar").to_boolean())
	{
		if(have_familiar($familiar[Angry Jung Man]))
		{
			use_familiar($familiar[Angry Jung Man]);
		}
		else if(have_familiar($familiar[Piano Cat]))
		{
			use_familiar($familiar[Piano Cat]);
		}
	}

	if(!get_property("kingLiberated").to_boolean())
	{
		if((my_daycount() == 1) && (my_bjorned_familiar() != $familiar[grim brother]) && (get_property("_grimFairyTaleDropsCrown").to_int() == 0) && (have_familiar($familiar[grim brother])) && (equipped_item($slot[back]) == $item[Buddy Bjorn]) && (my_familiar() != $familiar[Grim Brother]))
		{
			bjornify_familiar($familiar[grim brother]);
		}
		if((my_bjorned_familiar() == $familiar[grimstone golem]) && (get_property("_grimstoneMaskDropsCrown") == 1) && have_familiar($familiar[El Vibrato Megadrone]))
		{
			bjornify_familiar($familiar[el vibrato megadrone]);
		}
		if((my_bjorned_familiar() == $familiar[grim brother]) && (get_property("_grimFairyTaleDropsCrown").to_int() >= 1))
		{
			bjornify_familiar($familiar[el vibrato megadrone]);
		}
	}

	if(my_path() == "Heavy Rains")
	{
		print("Post adventure done: Thunder: " + my_thunder() + " Rain: " + my_rain() + " Lightning: " + my_lightning(), "green");
	}

	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && ((my_location() == $location[Barrrney\'s Barrr]) || (my_location() == $location[The Obligatory Pirate\'s Cove])))
	{
		print("Have " + numPirateInsults() + " insults.", "green");
	}

	if(my_location() == $location[The Broodling Grounds])
	{
		print("Have " + item_amount($item[Hellseal Brain]) + " brain(s).", "green");
		print("Have " + item_amount($item[Hellseal Hide]) + " hide(s).", "green");
		print("Have " + item_amount($item[Hellseal Sinew]) + " sinew(s).", "green");
	}

	if((my_location() == $location[The Hidden Bowling Alley]) && get_property("kingLiberated").to_boolean())
	{
		if(item_amount($item[Bowling Ball]) > 0)
		{
			put_closet(item_amount($item[Bowling Ball]), $item[Bowling Ball]);
		}
	}

	# We only do this in aftercore because we don't want a spiralling death loop in-run.
	if(get_property("kingLiberated").to_boolean() && (have_effect($effect[beaten up]) > 0) && (my_mp() >= mp_cost($skill[Tongue of the Walrus])) && have_skill($skill[Tongue of the Walrus]))
	{
		print("Owwie, was beaten up but trying to recover", "red");
		use_skill(1, $skill[Tongue of the Walrus]);
	}

	#Should we create a separate function to track these? How many are we going to track?
	if((last_monster() == $monster[writing desk]) && (get_property("lastEncounter") == $monster[Writing Desk]) && (have_effect($effect[Beaten Up]) == 0))
	{
		print("Fought " + get_property("writingDesksDefeated") + " writing desks.", "blue");
	}
	if((last_monster() == $monster[Gaudy Pirate]) && (get_property("lastEncounter") == $monster[Gaudy Pirate]) && (have_effect($effect[Beaten Up]) == 0))
	{
		set_property("cc_gaudypiratecount", "" + (get_property("cc_gaudypiratecount").to_int() + 1));
		print("Fought " + get_property("cc_gaudypiratecount") + " gaudy pirates.", "blue");
	}
	if((last_monster() == $monster[Modern Zmobie]) && (get_property("lastEncounter") == $monster[Modern Zmobie]) && (have_effect($effect[Beaten Up]) == 0))
	{
		set_property("cc_modernzmobiecount", "" + (get_property("cc_modernzmobiecount").to_int() + 1));
		print("Fought " + get_property("cc_modernzmobiecount") + " modern zmobies.", "blue");
	}

	print("Post Adventure done, beep.", "purple");
}

void main(){
	handlePostAdventure();
}
