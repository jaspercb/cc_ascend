script "cc_cooking.ash"

import<cc_ascend/cc_clan.ash>
import<cc_ascend/cc_util.ash>



#
#	Handler for in-run consumption
#
#


void consumeStuff();
boolean makePerfectBooze();
item getAvailablePerfectBooze();
boolean dealWithMilkOfMagnesium(boolean useAdv);
boolean ccEat(int howMany, item toEat);
boolean ccDrink(int howMany, item toDrink);
boolean ccOverdrink(int howMany, item toOverdrink);
boolean ccChew(int howMany, item toChew);
boolean tryPantsEat();
boolean tryCookies();

item getAvailablePerfectBooze()
{
	switch(my_primestat())
	{
	case $stat[Muscle]:
		foreach booze in $items[Perfect Old-Fashioned, Perfect Cosmopolitan, Perfect Paloma, Perfect Mimosa, Perfect Negroni, Perfect Dark and Stormy]
		{
			if(item_amount(booze) > 0)
			{
				return booze;
			}
		}
		break;
	case $stat[Mysticality]:
		foreach booze in $items[Perfect Dark and Stormy, Perfect Mimosa, Perfect Negroni, Perfect Cosmopolitan, Perfect Paloma, Perfect Old-Fashioned]
		{
			if(item_amount(booze) > 0)
			{
				return booze;
			}
		}
		break;
	case $stat[Moxie]:
		foreach booze in $items[Perfect Paloma, Perfect Negroni, Perfect Old-Fashioned, Perfect Dark and Stormy, Perfect Cosmopolitan, Perfect Mimosa]
		{
			if(item_amount(booze) > 0)
			{
				return booze;
			}
		}
		break;
	}
	return $item[none];
}

boolean makePerfectBooze()
{
	if(item_amount($item[Perfect Ice Cube]) == 0)
	{
		return false;
	}

	int starting = item_amount($item[Perfect Ice Cube]);

	switch(my_primestat())
	{
	case $stat[Muscle]:
		if(item_amount($item[Bottle of Whiskey]) > 0)
		{
			cli_execute("make " + $item[Perfect Old-Fashioned]);
		}
		else if(item_amount($item[Bottle of Vodka]) > 0)
		{
			cli_execute("make " + $item[Perfect Cosmopolitan]);
		}
		else if(item_amount($item[Bottle of Tequila]) > 0)
		{
			cli_execute("make " + $item[Perfect Paloma]);
		}
		else if(item_amount($item[Boxed Wine]) > 0)
		{
			cli_execute("make " + $item[Perfect Mimosa]);
		}
		else if(item_amount($item[Bottle of Gin]) > 0)
		{
			cli_execute("make " + $item[Perfect Negroni]);
		}
		else if(item_amount($item[Bottle of Rum]) > 0)
		{
			cli_execute("make " + $item[Perfect Dark and Stormy]);
		}
		break;
	case $stat[Mysticality]:
		if(item_amount($item[Bottle of Rum]) > 0)
		{
			cli_execute("make " + $item[Perfect Dark and Stormy]);
		}
		else if(item_amount($item[Boxed Wine]) > 0)
		{
			cli_execute("make " + $item[Perfect Mimosa]);
		}
		else if(item_amount($item[Bottle of Gin]) > 0)
		{
			cli_execute("make " + $item[Perfect Negroni]);
		}
		else if(item_amount($item[Bottle of Vodka]) > 0)
		{
			cli_execute("make " + $item[Perfect Cosmopolitan]);
		}
		else if(item_amount($item[Bottle of Tequila]) > 0)
		{
			cli_execute("make " + $item[Perfect Paloma]);
		}
		else if(item_amount($item[Bottle of Whiskey]) > 0)
		{
			cli_execute("make " + $item[Perfect Old-Fashioned]);
		}
		break;
	case $stat[Moxie]:
		if(item_amount($item[Bottle of Tequila]) > 0)
		{
			cli_execute("make " + $item[Perfect Paloma]);
		}
		else if(item_amount($item[Bottle of Gin]) > 0)
		{
			cli_execute("make " + $item[Perfect Negroni]);
		}
		else if(item_amount($item[Bottle of Whiskey]) > 0)
		{
			cli_execute("make " + $item[Perfect Old-Fashioned]);
		}
		else if(item_amount($item[Bottle of Rum]) > 0)
		{
			cli_execute("make " + $item[Perfect Dark and Stormy]);
		}
		else if(item_amount($item[Bottle of Vodka]) > 0)
		{
			cli_execute("make " + $item[Perfect Cosmopolitan]);
		}
		else if(item_amount($item[Boxed Wine]) > 0)
		{
			cli_execute("make " + $item[Perfect Mimosa]);
		}
		break;
	}

	return !(starting == item_amount($item[Perfect Ice Cube]));
}


boolean tryCookies()
{
	string cookie = get_counters("Fortune Cookie", 0, 200);
	if(contains_text(cookie, "Fortune Cookie"))
	{
		return true;
	}
	if(my_fullness() < 12)
	{
		return false;
	}
	if((cc_my_path() == "Heavy Rains") && (get_property("cc_orchard") == "finished"))
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
		if(contains_text(cookie, "Fortune Cookie"))
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

boolean ccDrink(int howMany, item toDrink)
{
	return drink(howMany, toDrink);
}

boolean ccOverdrink(int howMany, item toOverdrink)
{
	return overdrink(howMany, toOverdrink);
}

boolean ccChew(int howMany, item toChew)
{
	return chew(howMany, toChew);
}

boolean ccEat(int howMany, item toEat)
{
	boolean retval = false;
	while(howMany > 0)
	{
		if((cc_get_campground() contains $item[Portable Mayo Clinic]) && (my_meat() > 11000))
		{
			buyUpTo(1, $item[Mayoflex], 1000);
			use(1, $item[Mayoflex]);
		}
		retval = eat(1, toEat);
		howMany = howMany - 1;
	}
	return retval;
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
		if((item_amount($item[Scrumptious Reagent]) == 0) && (my_mp() >= mp_cost($skill[Advanced Saucecrafting])))
		{
			if(get_property("reagentSummons").to_int() == 0)
			{
				use_skill(1, $skill[Advanced Saucecrafting]);
			}
		}

		if(item_amount($item[Scrumptious Reagent]) > 0)
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
	}
	pullXWhenHaveY($item[Milk of Magnesium], 1, 0);
	return true;
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
	if(cc_my_path() == "Community Service")
	{
		cs_eat_spleen();
		return;
	}

	int mpForOde = 50;
	if(!have_skill($skill[The Ode to Booze]))
	{
		mpForOde = 0;
	}

	if(((my_inebriety() + 3) <= inebriety_limit()) && (my_mp() >= mpForOde))
	{
		makePerfectBooze();
		item booze = getAvailablePerfectBooze();
		if(booze != $item[none])
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			drink(1, booze);
		}
	}
	if(((my_inebriety() + 2) <= inebriety_limit()) && (my_mp() >= mpForOde))
	{
		if((item_amount($item[Yellow Pixel]) >= 10) && (item_amount($item[Pixel Daiquiri]) == 0))
		{
			cli_execute("make " + $item[Pixel Daiquiri]);
		}
		if(item_amount($item[Pixel Daiquiri]) > 0)
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			drink(1, $item[Pixel Daiquiri]);
		}
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

		if((my_mp() > mpForOde) && (my_level() >= 3) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
			if(item_amount($item[paint a vulgar pitcher]) > 0)
			{
				drink(1, $item[paint a vulgar pitcher]);
			}
		}

		if((my_mp() > mpForOde) && get_property("cc_100familiar").to_boolean() && (my_inebriety() == 0) && (my_meat() >= 500) && (item_amount($item[Clan VIP Lounge Key]) > 0))
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

		if((my_mp() > mpForOde) && (amountTurkeyBooze() >= 2) && (my_inebriety() == 0) && (my_meat() >= 500) && (item_amount($item[Clan VIP Lounge Key]) > 0))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			cli_execute("drink 1 lucky lindy");
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

		if((get_property("cc_ballroomsong") == "finished") && (get_property("_speakeasyDrinksDrunk").to_int() == 1) && (my_mp() >= (mpForOde+30)) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			if(item_amount($item[Clan VIP Lounge Key]) > 0)
			{
				shrugAT();
				buffMaintain($effect[Ode to Booze], 50, 1, 2);
				visit_url("clan_viplounge.php?action=speakeasy");
				cli_execute("drink 1 sockdollager");
			}
			hermit(10, $item[ten-leaf clover]);
		}

		if((my_adventures() < 4) && (my_fullness() == 0) && (my_level() >= 7) && !in_hardcore())
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
			int canEat = (fullness_limit() - my_fullness()) / 5;
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
					if((item_amount($item[Bubblin\' Crude]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Bubblin\' Crude]);
					}
					else if((item_amount($item[Goat Cheese]) > 0) && (item_amount($item[Scrumptious Reagent]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Goat Cheese], $item[Scrumptious Reagent]);
						ccCraft("cook", 1, $item[Dry Noodles], $item[Fancy Schmancy Cheese Sauce]);
					}
					else if((item_amount($item[Ectoplasmic Orbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Ectoplasmic Orbs]);
					}
					else if((item_amount($item[Pestopiary]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Pestopiary]);
					}
					else if((item_amount($item[Salacious Crumbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Salacious Crumbs]);
					}
				}
				dealWithMilkOfMagnesium(!in_hardcore());
				buffMaintain($effect[Got Milk], 0, 1, 1);
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

		if(in_hardcore() && isGuildClass() && have_skill($skill[Pastamastery]))
		{
			int canEat = (fullness_limit() - my_fullness()) / 5;
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
					if((item_amount($item[Bubblin\' Crude]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Bubblin\' Crude]);
					}
					else if((item_amount($item[Goat Cheese]) > 0) && (item_amount($item[Scrumptious Reagent]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Goat Cheese], $item[Scrumptious Reagent]);
						ccCraft("cook", 1, $item[Dry Noodles], $item[Fancy Schmancy Cheese Sauce]);
					}
					else if((item_amount($item[Ectoplasmic Orbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Ectoplasmic Orbs]);
					}
					else if((item_amount($item[Pestopiary]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Pestopiary]);
					}
					else if((item_amount($item[Salacious Crumbs]) > 0) && (item_amount($item[Dry Noodles]) > 0))
					{
						ccCraft("cook", 1, $item[Dry Noodles], $item[Salacious Crumbs]);
					}
				}
				dealWithMilkOfMagnesium(true);
				buffMaintain($effect[Got Milk], 0, 1, 1);
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

#		if(in_hardcore() && isGuildClass() && have_skill($skill[Pastamastery]))
#		{
#			if(((my_fullness() + 6) <= fullness_limit()) && (my_level() >= 6) && ovenHandle())
#			{
#				if(item_amount($item[Hell Broth]) == 0)
#				{
#					while((item_amount($item[Hellion Cube]) > 0) && (item_amount($item[Scrumptious Reagent]) > 0) && (item_amount($item[Hell Broth]) < 2))
#					{
#						cli_execute("make Hell Broth");
#					}
#				}
#				while((item_amount($item[Hell Broth]) > 0) && (item_amount($item[Dry Noodles]) > 0) && (item_amount($item[Hell Ramen]) < 2))
#				{
#					cli_execute("make Hell Ramen");
#				}
#
#				while((item_amount($item[Hell Ramen]) > 0) && ((my_fullness() + 6) <= fullness_limit()))
#				{
#					dealWithMilkOfMagnesium(true);
#					ccEat(1, $item[Hell Ramen]);
#				}
#			}
#		}


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
		if(in_hardcore() && (my_mp() > mpForOde) && (item_amount($item[Dinsey Whinskey]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Dinsey Whinskey]);
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

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (my_inebriety() <= inebriety_limit()) && (my_meat() > 500) && (get_property("_speakeasyDrinksDrunk").to_int() < 3) && (item_amount($item[Clan VIP Lounge Key]) > 0))
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
		if((cc_my_path() == "Standard") && (my_mp() >= mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((cc_my_path() == "Standard") && (my_mp() >= mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}

		if((cc_my_path() == "Standard") && (my_mp() >= mpForOde) && (my_inebriety() <= inebriety_limit()) && (my_meat() > 500) && (get_property("_speakeasyDrinksDrunk").to_int() < 3))
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
			if(item_amount($item[mojo filter]) > 0)
			{
				use(1, $item[mojo filter]);
				chew(1, $item[astral energy drink]);
			}
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

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT();
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}
	}
}
