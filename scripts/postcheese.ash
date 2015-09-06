script "postcheese.ash";
import <cc_util.ash>

boolean ocrs_postHelper();

boolean ocrs_postHelper()
{
	if(my_path() != "One Crazy Random Summer")
	{
		return false;
	}

	set_property("cc_useCleesh", false);
	return true;
}


void handlePostAdventure()
{
	if(get_property("cc_bedroomHandler1") == "yes")
	{
		set_property("cc_bedroomHandler1", "no");
		if(contains_text(visit_url("main.php"), "choice.php"))
		{
			return;
		}
	}

	if(get_property("cc_disableAdventureHandling") == "yes")
	{
		return;
	}

	if((my_location() == $location[The Lower Chambers]) && (item_amount($item[2334]) == 0))
	{
		return;
	}

	ocrs_postHelper();
	if(last_monster().random_modifiers["clingy"])
	{
		return;
	}


	if(my_path() == "Actually Ed the Undying")
	{
		int maxBuff = min(5, 660 - my_turncount());
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

		buffMaintain($effect[Hide of Sobek], 200, 1, maxBuff);
		if(my_location() == $location[Hippy Camp])
		{
			buffMaintain($effect[Hide of Sobek], 20, 1, maxBuff);
		}

		if(my_location() != $location[The Secret Government Laboratory])
		{
			buffMaintain($effect[Bounty of Renenutet], 20, 1, maxBuff);
		}

		if((my_servant() == $servant[Priest]) && ($servant[Priest].experience < 196))
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}
		if(my_servant() == $servant[Cat])
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}
		if((my_servant() == $servant[Belly-Dancer]) && ($servant[Belly-Dancer].experience < 196))
		{
			buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
		}


		while(my_mp() > 100)
		{
			int start = my_mp();
			int maxBuff = 750 - my_turncount();
			buffMaintain($effect[Prayer of Seshat], 5, 1, maxBuff);
			buffMaintain($effect[Wisdom of Thoth], 5, 1, maxBuff);
			#buffMaintain($effect[Power of Heka], 10, 1, maxBuff);
			#buffMaintain($effect[Purr of the Feline], 10, 1, maxBuff);
			buffMaintain($effect[Hide of Sobek], 10, 1, maxBuff);
			buffMaintain($effect[Bounty of Renenutet], 20, 1, maxBuff);
			if(start == my_mp())
			{
				break;
			}
		}

		if((my_level() < 13) && (my_level() > 3))
		{
			buffMaintain($effect[Blessing of Serqet], 15, 1, 1);
		}

		#+NC Maintenance
		if((my_location() == $location[The Penultimate Fantasy Airship]) ||
			(my_location() == $location[Twin Peak]) ||
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
			(my_location() == $location[The Spooky Forest]) ||
			(my_location() == $location[Inside the Palindome]) ||
			(my_location() == $location[The Hidden Hospital]) ||
			(my_location() == $location[The Obligatory Pirate\'s Cove]) ||
			(my_location() == $location[Wartime Hippy Camp]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Top Floor)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)])
		)
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
				else if(item_amount($item[Holy Spring Water]) > 0)
				{
					use(1, $item[Holy Spring Water]);
				}
			}
			buffMaintain($effect[Shelter of Shed], 15, 1, 1);
		}

		return;
	}

	skill libram = preferredLibram();

	buffMaintain($effect[Merry Smithsness], 0, 1, 10);

	if((have_effect($effect[Cunctatitis]) > 0) && (my_mp() >= 12) && have_skill($skill[Disco Nap]))
	{
		use_skill(1, $skill[Disco Nap]);
	}

	#Deal with Poison, (should do all of them actually)
	if((have_effect($effect[Really Quite Poisoned]) > 0) || (have_effect($effect[A Little Bit Poisoned]) > 0) || (have_effect($effect[Majorly Poisoned]) > 0))
	{
		if((my_mp() > 12) && have_skill($skill[Disco Nap]))
		{
			use_skill(1, $skill[Disco Nap]);
		}
		else
		{
			buy(1, $item[anti-anti-antidote]);
#			visit_url("shop.php?pwd=&whichshop=doc&action=buyitem&quantity=1&whichrow=694", true);
			use(1, $item[anti-anti-antidote]);
		}
	}

	if(have_effect($effect[temporary amnesia]) > 0)
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
		if(have_skill($skill[Summon Taffy]))
		{
			libram = $skill[Summon Taffy];
		}

		boolean [skill] toCast = $skills[Pastamastery, Advanced Saucecrafting, Advanced Cocktailcrafting, Summon Confiscated Things, Summon Holiday Fun!, Summon Kokomo Resort Pass, Summon Carrot, Request Sandwich, Summon Hilarious Objects, Summon Tasteful Items, Summon Alice\'s Army Cards, Summon Crimbo Candy, Summon Geeky Gifts, Lunch Break, Grab a Cold One, Spaghetti Breakfast];

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

		return;
	}

	if(my_class() == $class[Sauceror])
	{
		if((my_level() >= 6) && (have_effect($effect[Blood Sugar Sauce Magic]) == 0) && have_skill($skill[Blood Sugar Sauce Magic]) && !in_hardcore())
		{
			use_skill(1, $skill[Blood Sugar Sauce Magic]);
		}

		if((my_level() <= 8) && (my_soulsauce() >= 92))
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
	if((my_location() == $location[The F\'c\'le]) ||
		(my_location() == $location[Sonofa Beach]) ||
		(my_location() == $location[The Black Forest])
	)
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
	}


	if(have_skill($skill[Summon Smithsness]) && (my_mp() > 20))
	{
		use_skill(1, $skill[Summon Smithsness]);
	}

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

		if(my_mp() > 40)
		{
			if(have_skill($skill[Summon Geeky Gifts]))
			{
				use_skill(1, $skill[Summon Geeky Gifts]);
			}
			if(have_skill($skill[Summon Confiscated Things]))
			{
				use_skill(1, $skill[Summon Confiscated Things]);
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

		if(my_mp() > 50)
		{
			if(have_skill($skill[Summon Geeky Gifts]))
			{
				use_skill(1, $skill[Summon Geeky Gifts]);
			}
			if(have_skill($skill[Summon Confiscated Things]))
			{
				use_skill(1, $skill[Summon Confiscated Things]);
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
		buffMaintain($effect[Disdain of the War Snapper], 60, 1, 10);
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
		if(my_mp() > 80)
		{
			if(have_skill($skill[Pastamastery]))
			{
				use_skill(1, $skill[Pastamastery]);
			}
			if(have_skill($skill[Advanced Saucecrafting]))
			{
				use_skill(1, $skill[Advanced Saucecrafting]);
			}
			if(have_skill($skill[Advanced Cocktailcrafting]))
			{
				use_skill(1, $skill[Advanced Cocktailcrafting]);
			}
			if(have_skill($skill[Summon Geeky Gifts]))
			{
				use_skill(1, $skill[Summon Geeky Gifts]);
			}
			if(have_skill($skill[Summon Confiscated Things]))
			{
				use_skill(1, $skill[Summon Confiscated Things]);
			}
		}

		if((my_mp() > 95) && (have_skill($skill[Grab a Cold One])))
		{
			use_skill($skill[Grab a Cold One]);
		}
		if((my_mp() > 95) && (have_skill($skill[Spaghetti Breakfast])))
		{
			use_skill($skill[Spaghetti Breakfast]);
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
		buffMaintain($effect[Disdain of the War Snapper], 80, 1, 10);
		buffMaintain($effect[Walberg\'s Dim Bulb], 80, 1, 10);
		buffMaintain($effect[Springy Fusilli], 80, 1, 10);
#		buffMaintain($effect[Flimsy Shield of the Pastalord], 80, 1, 10);
		buffMaintain($effect[Blubbered Up], 80, 1, 10);
#		buffMaintain($effect[Tenacity of the Snapper], 80, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 80, 1, 10);
		buffMaintain($effect[Disco Fever], 80, 1, 10);
		buffMaintain($effect[Seal Clubbing Frenzy], 50, 5, 4);
		buffMaintain($effect[Patience of the Tortoise], 50, 5, 4);
		buffMaintain($effect[Rotten Memories], 100, 1, 10);

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
#			buffMaintain($effect[Takin\' It Greasy], 50, 1, 25);
#			buffMaintain($effect[Intimidating Mien], 50, 1, 25);
#			buffMaintain($effect[Takin\' It Greasy], 50, 1, 45);
#			buffMaintain($effect[Intimidating Mien], 50, 1, 45);
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
		if((my_mp() > 75) && ((my_maxhp()/my_hp()) > 3))
		{
			useCocoon();
		}

		buffMaintain($effect[Fat Leon\'s Phat Loot Lyric], 50, 1, 10);

		buffMaintain(whatStatSmile(), 40, 1, 10);

		buffMaintain($effect[Empathy], 50, 1, 10);
		buffMaintain($effect[Leash of Linguini], 35, 1, 10);

		if(my_mp() > 80)
		{
			if(have_skill($skill[Pastamastery]))
			{
				use_skill(1, $skill[Pastamastery]);
			}
			if(have_skill($skill[Advanced Saucecrafting]))
			{
				use_skill(1, $skill[Advanced Saucecrafting]);
			}
			if(have_skill($skill[Advanced Cocktailcrafting]))
			{
				use_skill(1, $skill[Advanced Cocktailcrafting]);
			}
			if(have_skill($skill[Summon Geeky Gifts]))
			{
				use_skill(1, $skill[Summon Geeky Gifts]);
			}
			if(have_skill($skill[Summon Confiscated Things]))
			{
				use_skill(1, $skill[Summon Confiscated Things]);
			}
		}
		if((my_mp() > 85) && have_skill($skill[Grab a Cold One]))
		{
			use_skill($skill[Grab a Cold One]);
		}
		if((my_mp() > 85) && have_skill($skill[Spaghetti Breakfast]))
		{
			use_skill($skill[Spaghetti Breakfast]);
		}

		if((libram != $skill[none]) && ((my_mp() - mp_cost(libram)) > 32))
		{
			print("Mymp: " + my_mp() + " of " + my_maxmp() + " and cost: " + mp_cost(libram), "blue");
			try
			{
				if(use_skill(1, libram)) {}
			}
			finally
			{
				#This is only here because of the bug when changing outfits that mafia does not update any losses in MP that occurs.
			}
		}

#		buffMaintain($effect[Prayer of Seshat], 5, 1, 10);

		buffMaintain($effect[Singer\'s Faithful Ocelot], 80, 1, 10);
		if(doML)
		{
			buffMaintain($effect[Ur-Kel\'s Aria of Annoyance], 80, 1, 10);
			buffMaintain($effect[Drescher\'s Annoying Noise], 80, 1, 10);
			buffMaintain($effect[Pride of the Puffin], 80, 1, 10);
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
		buffMaintain($effect[Flimsy Shield of the Pastalord], 80, 1, 10);
		buffMaintain($effect[Blubbered Up], 80, 1, 10);
		if(my_level() < 13)
		{
			buffMaintain($effect[Aloysius\' Antiphon of Aptitude], 80, 1, 10);
		}
		buffMaintain($effect[Tenacity of the Snapper], 120, 1, 10);
		buffMaintain($effect[Reptilian Fortitude], 80, 1, 10);
		buffMaintain($effect[Antibiotic Saucesphere], 140, 1, 10);
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
		buffMaintain($effect[Rotten Memories], 150, 1, 10);

		if((have_skill($skill[Summon Holiday Fun!])) && (my_mp() > 11))
		{
			use_skill(1, $skill[Summon Holiday Fun!]);
		}
		if((have_skill($skill[Summon Kokomo Resort Pass])) && (my_mp() > 1))
		{
			use_skill(1, $skill[Summon Kokomo Resort Pass]);
		}
		if((have_skill($skill[Summon Carrot])) && (my_mp() > 11))
		{
			use_skill(1, $skill[Summon Carrot]);
		}
		if((have_skill($skill[Summon Confiscated Things])) && (my_mp() > 5))
		{
			use_skill(3, $skill[Summon Confiscated Things]);
		}
		if((have_skill($skill[Request Sandwich])) && (my_mp() > 5))
		{
			use_skill(1, $skill[Request Sandwich]);
		}
		if((have_skill($skill[Summon Hilarious Objects])) && (my_mp() > 5))
		{
			use_skill(1, $skill[Summon Hilarious Objects]);
		}
		if((have_skill($skill[Summon Tasteful Items])) && (my_mp() > 5))
		{
			use_skill(1, $skill[Summon Tasteful Items]);
		}
		if((have_skill($skill[Summon Alice\'s Army Cards])) && (my_mp() > 5))
		{
			use_skill(1, $skill[Summon Alice\'s Army Cards]);
		}
		if((have_skill($skill[Summon Crimbo Candy])) && (my_mp() > 5))
		{
			use_skill(1, $skill[Summon Crimbo Candy]);
		}
		if((have_skill($skill[Lunch Break])) && (my_mp() > 10))
		{
			use_skill(1, $skill[Lunch Break]);
		}


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
#			buffMaintain($effect[Takin\' It Greasy], 150, 1, 25);
#			buffMaintain($effect[Intimidating Mien], 150, 1, 25);
#			buffMaintain($effect[Takin\' It Greasy], 250, 1, 45);
#			buffMaintain($effect[Intimidating Mien], 250, 1, 45);
		}

#		if(my_mp() > 150)
#		{
#			int casts = (my_mp() - 150) / 60;
#			if(casts == 0)
#			{
#				casts = 1;
#			}
#			if(have_skill($skill[Grease Up]))
#			{
#				use_skill(casts, $skill[Grease Up]);
#			}
#			if(have_skill($skill[Intimidating Mien]))
#			{
#				use_skill(casts, $skill[Intimidating Mien]);
#			}
#		}

		if(didOutfit)
		{
			cli_execute("outfit Backup");
		}
	}

	if((get_property("cc_cubeItems") == "") && (item_amount($item[ring of detect boring doors]) == 1) && (item_amount($item[eleven-foot pole]) == 1) && (item_amount($item[pick-o-matic lockpicks]) == 1))
	{
		set_property("cc_cubeItems", "done");
	}

	if((get_property("cc_cubeItems") == "done") && (my_familiar() == $familiar[Gelatinous cubeling]) && !get_property("cc_100familiar").to_boolean())
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


	if((my_daycount() == 1) && (my_bjorned_familiar() != $familiar[grim brother]) && (get_property("_grimFairyTaleDropsCrown").to_int() == 0) && (have_familiar($familiar[grim brother])) && (equipped_item($slot[back]) == $item[Buddy Bjorn]))
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

	if(my_path() == "Heavy Rains")
	{
		print("Post adventure done: Thunder: " + my_thunder() + " Rain: " + my_rain() + " Lightning: " + my_lightning(), "green");
	}

	if((my_location() == $location[Barrrney\'s Barrr]) || (my_location() == $location[The Obligatory Pirate\'s Cove]))
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
	if((get_property("kingLiberated") != "false") && (have_effect($effect[beaten up]) > 0) && (my_mp() >= 11) && have_skill($skill[Tongue of the Walrus]))
	{
		print("Owwie, was beaten up but trying to recover", "red");
		use_skill(1, $skill[Tongue of the Walrus]);
	}

	#Should we create a separate function to track these? How many are we going to track?
	if(last_monster() == $monster[writing desk])
	{
		print("Fought " + get_property("writingDesksDefeated") + " writing desks.", "blue");
	}
	if((last_monster() == $monster[Gaudy Pirate]) && (have_effect($effect[Beaten Up]) == 0))
	{
		set_property("cc_gaudypiratecount", "" + (get_property("cc_gaudypiratecount").to_int() + 1));
		print("Fought " + get_property("cc_gaudypiratecount") + " gaudy pirates.", "blue");
	}
	if((last_monster() == $monster[Modern Zmobie]) && (have_effect($effect[Beaten Up]) == 0))
	{
		set_property("cc_modernzmobiecount", "" + (get_property("cc_modernzmobiecount").to_int() + 1));
		print("Fought " + get_property("cc_modernzmobiecount") + " modern zmobies.", "blue");
	}

	print("Post Adventure done, beep.", "purple");
}

void main(){
	handlePostAdventure();
}
