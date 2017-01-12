script "cc_cooking.ash"

import<cc_ascend/cc_clan.ash>
import<cc_ascend/cc_util.ash>
import<cc_ascend/cc_community_service.ash>
import<cc_ascend/cc_ascend_header.ash>

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
		buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
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
	if(fullness_left() > 0)
	{
		foreach it in $items[Tasty Tart, Deviled Egg, Actual Tapas, Cold Mashed Potatoes, Dinner Roll, Whole Turkey Leg, Can of Sardines, High-Calorie Sugar Substitute, Pat of Butter]
		{
			if((it == $item[Actual Tapas]) && (my_level() < 11))
			{
				continue;
			}

			if(item_amount(it) > 0)
			{
				cli_execute("refresh inv");
				if(item_amount(it) == 0)
				{
					print("Error, mafia thought you had " + it + " but you didn't....", "red");
					return false;
				}
				if((get_property("mayoInMouth") == "") && (cc_get_campground() contains $item[Portable Mayo Clinic]))
				{
					if((item_amount($item[Mayoflex]) == 0) && (my_meat() > 12000))
					{
						buy(1, $item[Mayoflex]);
					}
					if(item_amount($item[Mayoflex]) > 0)
					{
						use(1, $item[Mayoflex]);
					}
				}
				buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
				eatsilent(1, it);
				return true;
			}
		}
	}
	return false;
}

boolean ccDrink(int howMany, item toDrink)
{
	if((toDrink == $item[none]) || (howMany <= 0))
	{
		return false;
	}
	if(item_amount(toDrink) < howMany)
	{
		return false;
	}

	int expectedInebriety = toDrink.inebriety * howMany;

	if(possessEquipment($item[Wrist-Boy]) && (my_meat() > 6500))
	{
		if((have_effect($effect[Drunk and Avuncular]) < expectedInebriety) && (item_amount($item[Drunk Uncles Holo-Record]) == 0))
		{
			buyUpTo(1, $item[Drunk Uncles Holo-Record]);
		}
		buffMaintain($effect[Drunk and Avuncular], 0, 1, expectedInebriety);
	}

	boolean retval = false;
	while(howMany > 0)
	{
		retval = drink(1, toDrink);
		if(retval)
		{
			handleTracker(toDrink, "cc_drunken");
		}
		howMany = howMany - 1;
	}
	return retval;



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
	if((toEat == $item[none]) || (howMany <= 0))
	{
		return false;
	}
	if(item_amount(toEat) < howMany)
	{
		return false;
	}

	int expectedFullness = toEat.fullness * howMany;
	if(expectedFullness >= 15)
	{
		dealwithMilkOfMagnesium(true);
	}

	if(expectedFullness >= 10)
	{
		buffMaintain($effect[Got Milk], 0, 1, expectedFullness);
	}

	if(possessEquipment($item[Wrist-Boy]) && (my_meat() > 6500))
	{
		if((have_effect($effect[Record Hunger]) < expectedFullness) && (item_amount($item[The Pigs Holo-Record]) == 0))
		{
			buyUpTo(1, $item[The Pigs Holo-Record]);
		}
		buffMaintain($effect[Record Hunger], 0, 1, expectedFullness);
	}

	boolean retval = false;
	while(howMany > 0)
	{
		buffMaintain($effect[Song of the Glorious Lunch], 10, 1, toEat.fullness);
		if((cc_get_campground() contains $item[Portable Mayo Clinic]) && (my_meat() > 11000) && (get_property("mayoInMouth") == ""))
		{
			buyUpTo(1, $item[Mayoflex], 1000);
			use(1, $item[Mayoflex]);
		}
		retval = eatsilent(1, toEat);
		if(retval)
		{
			handleTracker(toEat, "cc_eaten");
		}
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

	if(!have_skill($skill[Advanced Saucecrafting]))
	{
		if((fullness_left() >= 5) && (inebriety_left() >= 2))
		{
			if((item_amount($item[Yellow Pixel]) >= 10) && (item_amount($item[Pixel Lemon]) == 0))
			{
				cli_execute("make " + $item[Pixel Lemon]);
			}
			if(item_amount($item[Pixel Lemon]) > 0)
			{
				eat(1, $item[Pixel Lemon]);
			}
		}
	}

	if((spleen_left() >= 8) && (my_level() >= 11) && (my_adventures() < 40) && (item_amount($item[astral energy drink]) > 0))
	{
		chew(1, $item[astral energy drink]);
	}


	if((my_inebriety() <= 8) || (my_adventures() < 20) || hasSpookyravenLibraryKey() || (get_property("questM20Necklace") == "finished"))
	{
		if((inebriety_left() >= 3) && (my_mp() >= mpForOde) && (my_level() >= 5))
		{
			makePerfectBooze();
			item booze = getAvailablePerfectBooze();
			if(booze != $item[none])
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 3);
				drink(1, booze);
			}
		}

		if((inebriety_left() >= 2) && (my_mp() < mpForOde) && (my_maxmp() > mpForOde))
		{
			if((item_amount($item[Yellow Pixel]) >= 10) || (item_amount($item[Pixel Daiquiri]) > 0) || (item_amount($item[Robin Nog]) > 0) || (item_amount($item[Sacramento Wine]) > 0))
//			if((item_amount($item[Yellow Pixel]) >= 10) || (item_amount($item[Pixel Daiquiri]) > 0) || (item_amount($item[Robin\'s Egg]) > 0) || (item_amount($item[Robin Nog]) > 0) || (item_amount($item[Sacramento Wine]) > 0)))
			{
				if(my_meat() > 10000)
				{
					while(my_mp() < mpForOde)
					{
						if(((my_class() == $class[Sauceror]) || (my_class() == $class[Pastamancer])) && guild_store_available() && (my_level() >= 6) && (my_meat() > npc_price($item[Magical Mystery Juice])))
						{
							buyUpTo(1, $item[Magical Mystery Juice]);
							use(1, $item[Magical Mystery Juice]);
						}
						else if(my_meat() > npc_price($item[Magical Mystery Juice]))
						{
							buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
							use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
						}
					}
				}
			}
		}

		if(((my_inebriety() + item_amount($item[Sacramento Wine])) <= inebriety_limit()) && (my_mp() >= mpForOde))
		{
			if(item_amount($item[Sacramento Wine]) > 0)
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 3);
				drink(min(item_amount($item[Sacramento Wine]), have_effect($effect[Ode to Booze])), $item[Sacramento Wine]);
			}
		}
		if((inebriety_left() >= 2) && (my_mp() >= mpForOde))
		{
			if((item_amount($item[Yellow Pixel]) >= 10) && (item_amount($item[Pixel Daiquiri]) == 0))
			{
				cli_execute("make " + $item[Pixel Daiquiri]);
			}
			if(item_amount($item[Pixel Daiquiri]) > 0)
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 3);
				drink(1, $item[Pixel Daiquiri]);
			}
		}
		if((inebriety_left() >= 2) && (my_mp() >= mpForOde))
		{
			if((item_amount($item[Robin\'s Egg]) >= 10) && (item_amount($item[Robin Nog]) == 0) && (my_meat() >= npc_price($item[Fermenting Powder])) && isGeneralStoreAvailable())
			{
				cli_execute("make " + $item[Robin Nog]);
			}
			if(item_amount($item[Robin Nog]) > 0)
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 3);
				drink(1, $item[Robin Nog]);
			}
		}
	}

	if((my_inebriety() <= 6) || (my_adventures() < 20) || hasSpookyravenLibraryKey() || (get_property("questM20Necklace") == "finished"))
	{
		if((inebriety_left() >= 4) && (my_mp() < mpForOde) && (my_maxmp() > mpForOde))
		{
			if((item_amount($item[Hacked Gibson]) > 0) && (my_level() >= 4))
			{
				if(my_meat() > 10000)
				{
					while(my_mp() < mpForOde)
					{
						if(((my_class() == $class[Sauceror]) || (my_class() == $class[Pastamancer])) && guild_store_available() && (my_level() >= 6) && (my_meat() > npc_price($item[Magical Mystery Juice])))
						{
							buyUpTo(1, $item[Magical Mystery Juice]);
							use(1, $item[Magical Mystery Juice]);
						}
						else if(my_meat() > npc_price($item[Magical Mystery Juice]))
						{
							buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
							use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
						}
					}
				}
			}
		}

		if((inebriety_left() >= 4) && (my_mp() >= mpForOde) && (item_amount($item[Hacked Gibson]) > 0) && (my_level() >= 4))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			drink(1, $item[Hacked Gibson]);
		}
	}

	if((fullness_left() >= 4) && (my_level() >= 4))
	{
		int browserCookies = min(fullness_left()/4, item_amount($item[Browser Cookie]));
		ccEat(browserCookies, $item[Browser Cookie]);
	}


	if(my_daycount() == 1)
	{
		if((my_spleen_use() == 0) && (item_amount($item[grim fairy tale]) > 0))
		{
			chew(1, $item[grim fairy tale]);
		}

		//	Try to drink more on day 1 please!

		if((my_meat() > 400) && (item_amount($item[handful of smithereens]) == 3) && (get_property("cc_mosquito") == "finished") && (cc_my_path() != "KOLHS") && (cc_my_path() != "Nuclear Autumn"))
		{
			cli_execute("make 3 paint a vulgar pitcher");
		}

		if((inebriety_left() >= 2) && (my_mp() >= mpForOde) && (item_amount($item[Agitated Turkey]) >= 2))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(2, $item[Agitated Turkey]);
		}

		if((inebriety_left() >= 1) && (my_mp() >= mpForOde) && (item_amount($item[Cold One]) >= 1) && (my_level() >= 11))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Cold One]);
		}

		if((spleen_left() >= 8) && (my_level() >= 10) && (my_adventures() < 3) && (item_amount($item[astral energy drink]) > 0))
		{
			chew(1, $item[astral energy drink]);
		}

		if((my_mp() > mpForOde) && (my_level() >= 3) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
			if(item_amount($item[paint a vulgar pitcher]) > 0)
			{
				drink(1, $item[paint a vulgar pitcher]);
			}
		}

		if((my_mp() > mpForOde) && is100FamiliarRun() && (my_inebriety() == 0) && (my_meat() >= 500) && (item_amount($item[Clan VIP Lounge Key]) > 0))
		{
			shrugAT($effect[Ode to Booze]);

			if(inebriety_left() >= 1)
			{
				buffMaintain($effect[Ode to Booze], 50, 1, 1);
				cli_execute("drink 1 lucky lindy");
			}

			if((inebriety_left() >= 4) && is_unrestricted($item[Ice Island Long Tea]))
			{
				pullXWhenHaveY($item[ice island long tea], 1, 0);
				drink(1, $item[Ice Island Long Tea]);
			}
		}

		if((my_mp() > mpForOde) && is100FamiliarRun() && (my_inebriety() == 13) && (item_amount($item[Cold One]) > 0) && (my_level() >= 10))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Cold One]);
		}

		if((my_mp() > mpForOde) && (amountTurkeyBooze() >= 2) && (my_inebriety() == 0) && (my_meat() >= 500) && (item_amount($item[Clan VIP Lounge Key]) > 0))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			cli_execute("drink 1 lucky lindy");
			while((amountTurkeyBooze() > 0) && (my_inebriety() < 3) && (inebriety_left() > 0))
			{
				if((item_amount($item[Friendly Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Friendly Turkey]);
				}
				else if((item_amount($item[Agitated Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Agitated Turkey]);
				}
				else if((item_amount($item[Ambitious Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Ambitious Turkey]);
				}
			}
		}

		if((my_mp() > mpForOde) && (turkeyBooze() >= 5) && (amountTurkeyBooze() >= 3) && (my_inebriety() < 6))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 3);
			while((amountTurkeyBooze() > 0) && (my_inebriety() < 6) && (inebriety_left() > 0))
			{
				if((item_amount($item[Friendly Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Friendly Turkey]);
				}
				else if((item_amount($item[Agitated Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Agitated Turkey]);
				}
				else if((item_amount($item[Ambitious Turkey]) > 0) && (inebriety_left() >= 1))
				{
					drink(1, $item[Ambitious Turkey]);
				}
			}
		}

		if((get_property("cc_ballroomsong") == "finished") && (inebriety_left() >= 2) && (get_property("_speakeasyDrinksDrunk").to_int() == 1) && (my_mp() >= (mpForOde+30)) && ((my_inebriety() + 2) <= inebriety_limit()) && !($classes[Avatar of Boris, Ed] contains my_class()))
		{
			if(item_amount($item[Clan VIP Lounge Key]) > 0)
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 2);
				drinkSpeakeasyDrink($item[Sockdollager]);
			}
			while(acquireHermitItem($item[Ten-leaf Clover]));
		}

		if((my_adventures() < 4) && (my_fullness() == 0) && (my_level() >= 7) && !in_hardcore())
		{
			dealWithMilkOfMagnesium(true);
			if((item_amount($item[Spaghetti Breakfast]) > 0) && (fullness_left() >= 1))
			{
				buffMaintain($effect[Got Milk], 0, 1, 1);
				buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
				ccEat(1, $item[Spaghetti Breakfast]);
			}
			if(fullness_left() >= 10)
			{
				pullXWhenHaveY(whatHiMein(), 2, 0);
			}
			if((item_amount(whatHiMein()) >= 2) && (fullness_left() >= 10))
			{
				buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
				buffMaintain($effect[Got Milk], 0, 1, 1);
				ccEat(2, whatHiMein());
			}
			if((item_amount($item[digital key lime pie]) > 0) && (fullness_left() >= 4))
			{
				buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
				buffMaintain($effect[Got Milk], 0, 1, 1);
				ccEat(1, $item[digital key lime pie]);
				tryPantsEat();
			}
			else
			{
				if(fullness_left() == 5)
				{
					pullXWhenHaveY(whatHiMein(), 1, 0);
					if(item_amount(whatHiMein()) > 0)
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
						ccEat(1, whatHiMein());
					}
				}
				else if(fullness_left() >= 4)
				{
					pullXWhenHaveY($item[Digital Key Lime Pie], 1, 0);
					if(item_amount($item[Digital Key Lime Pie]) > 0)
					{
						buffMaintain($effect[Got Milk], 0, 1, 1);
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						ccEat(1, $item[Digital Key Lime Pie]);
					}
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
				foreach it in toEat
				{
					while((canEat > 0) && (item_amount(it) > 0) && (fullness_left() >= 5))
					{
						buffMaintain($effect[Got Milk], 0, 1, 1);
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						ccEat(1, it);
						canEat = canEat - 1;
					}
				}
			}
		}

		if((my_adventures() < 4) && (fullness_left() >= 12) && (my_level() >= 6) && (item_amount($item[Boris\'s Key Lime Pie]) > 0) && (item_amount($item[Jarlsberg\'s Key Lime Pie]) > 0) && (item_amount($item[Sneaky Pete\'s Key Lime Pie]) > 0) && !in_hardcore())
		{
			dealWithMilkOfMagnesium(true);
			buffMaintain($effect[Got Milk], 0, 1, 1);
			buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
			ccEat(1, $item[Boris\'s Key Lime Pie]);
			ccEat(1, $item[Jarlsberg\'s Key Lime Pie]);
			ccEat(1, $item[Sneaky Pete\'s Key Lime Pie]);
			tryPantsEat();
			tryPantsEat();
			tryPantsEat();
		}

		if((fullness_limit() > 15) && (fullness_left() > 0))
		{
			tryCookies();
			if((my_adventures() < 5) && (spleen_left() <= 3) && (my_inebriety() >= 14))
			{
				tryPantsEat();
			}
		}

		if((my_spleen_use() == 4) && (spleen_left() == 11) && (item_amount($item[carrot nose]) > 0))
		{
			use(1, $item[carrot nose]);
			chew(1, $item[carrot juice]);
		}

		if(in_hardcore())
		{
			while((spleen_left() >= 4) && (item_amount($item[Unconscious Collective Dream Jar]) > 0))
			{
				chew(1, $item[Unconscious Collective Dream Jar]);
			}
			while((spleen_left() >= 4) && (item_amount($item[Powdered Gold]) > 0))
			{
				chew(1, $item[Powdered Gold]);
			}
			while((spleen_left() >= 4) && (item_amount($item[Grim Fairy Tale]) > 0))
			{
				chew(1, $item[Grim Fairy Tale]);
			}
		}

		if((((my_spleen_use() >= 4) && (my_spleen_use() < 7)) || ((my_spleen_use() >= 12) && (my_spleen_use() < 15))) && (spleen_left() >= 3))
		{
			# Reconsider this in light of the new dimensions of Spleen.
			if((item_amount($item[tenderizing hammer]) == 0) && have_skill($skill[Pulverize]))
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

		if((my_fullness() >= 15) && ((spleen_left() == 8) || (my_level() == 10)) && (my_inebriety() >= 14) && (my_adventures() < 5))
		{
			if((item_amount($item[astral energy drink]) > 0) && (spleen_left() >= 8))
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

			if(towerKeyCount() == 3)
			{
				if((item_amount(whatHiMein()) >= 3) && (fullness_left() >= 15))
				{
					buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
					buffMaintain($effect[Got Milk], 0, 1, 1);
					ccEat(3, whatHiMein());
				}
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
					if((item_amount($item[Spaghetti Breakfast]) > 0) && (fullness_left() > 0))
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, $item[Spaghetti Breakfast]);
					}
					if(fullness_left() >= 4)
					{
						pullXWhenHaveY($item[Boris\'s Key Lime Pie], 1, 0);
					}
					if((item_amount($item[Boris\'s Key Lime Pie]) > 0) && (fullness_left() >= 4))
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, $item[Boris\'s Key Lime Pie]);
					}
					if(fullness_left() >= 10)
					{
						pullXWhenHaveY(whatHiMein(), 2, 0);
					}
					if((item_amount(whatHiMein()) > 0) && (fullness_left() >= 5))
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
						if(item_amount($item[Mayoflex]) > 0)
						{
							use(1, $item[Mayoflex]);
						}
						ccEat(1, whatHiMein());
					}
					if((item_amount(whatHiMein()) > 0) && (fullness_left() >= 5))
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
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
				if(((item_amount($item[Boris\'s Key Lime Pie]) > 0) || (item_amount($item[Jarlsberg\'s Key Lime Pie]) > 0) || (item_amount($item[Sneaky Pete\'s Key Lime Pie]) > 0)) && (fullness_left() >= 4))
				{
					buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
					buffMaintain($effect[Got Milk], 0, 1, 1);
				}
				if((item_amount($item[Boris\'s Key Lime Pie]) > 0) && (fullness_left() >= 4))
				{
					ccEat(1, $item[Boris\'s Key Lime Pie]);
				}
				if((item_amount($item[Jarlsberg\'s Key Lime Pie]) > 0) && (fullness_left() >= 4))
				{
					ccEat(1, $item[Jarlsberg\'s Key Lime Pie]);
				}
				if((item_amount($item[Sneaky Pete\'s Key Lime Pie]) > 0) && (fullness_left() >= 4))
				{
					ccEat(1, $item[Sneaky Pete\'s Key Lime Pie]);
				}
				#cli_execute("eat 1 video games hot dog");
				if(fullness_left() > 0)
				{
					tryPantsEat();
					tryPantsEat();
					tryPantsEat();
				}
			}
		}

		if(in_hardcore() && isGuildClass() && have_skill($skill[Pastamastery]))
		{
			int canEat = fullness_left() / 5;
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
				foreach it in toEat
				{
					while((canEat > 0) && (item_amount(it) > 0) && (fullness_left() >= 5))
					{
						buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
						buffMaintain($effect[Got Milk], 0, 1, 1);
						ccEat(1, it);
						canEat = canEat - 1;
					}
				}
			}
		}

		if((fullness_limit() >= 15) && (fullness_left() > 0))
		{
			tryCookies();
			if((my_adventures() < 5) && (spleen_left() == 0) && (my_inebriety() >= 14))
			{
				tryPantsEat();
			}
		}

		if((my_inebriety() == 0) && (my_mp() >= mpForOde) && (my_meat() > 300) && (item_amount($item[handful of smithereens]) >= 2) && (cc_my_path() != "KOLHS") && (cc_my_path() != "Nuclear Autumn"))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 4);
			cli_execute("make 2 paint a vulgar pitcher");
			drink(2, $item[paint a vulgar pitcher]);
		}

		if((my_inebriety() == 4) && (my_mp() >= mpForOde) && (my_meat() > 150) && (item_amount($item[handful of smithereens]) >= 1) && (cc_my_path() != "KOLHS") && (cc_my_path() != "Nuclear Autumn"))
		{
			shrugAT($effect[Ode to Booze]);
			cli_execute("make 1 paint a vulgar pitcher");
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}

		if((inebriety_left() >= 5) && (my_adventures() < 10) && (my_meat() > 150) && (my_mp() >= mpForOde) && (cc_my_path() != "KOLHS") && (cc_my_path() != "Nuclear Autumn"))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 4);
			if(item_amount($item[handful of smithereens]) > 0)
			{
				cli_execute("make 1 paint a vulgar pitcher");
				drink(1, $item[paint a vulgar pitcher]);
			}
			else if(my_meat() > 35000)
			{
				drinkSpeakeasyDrink($item[Flivver]);
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
						shrugAT($effect[Ode to Booze]);
						buffMaintain($effect[Ode to Booze], 50, 1, 1);
						drink(1, $item[ambitious turkey]);
					}
				}
			}
		}


		if(in_hardcore() && (my_mp() > mpForOde) && (item_amount($item[Pixel Daiquiri]) > 0) && (inebriety_left() >= 2))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Pixel Daiquiri]);
		}
		if(in_hardcore() && (my_mp() > mpForOde) && (item_amount($item[Dinsey Whinskey]) > 0) && (inebriety_left() >= 2))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[Dinsey Whinskey]);
		}

		if((my_level() >= 11) && (my_mp() > mpForOde) && (item_amount($item[Cold One]) > 1) && (inebriety_left() >= 2))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(2, $item[Cold One]);
		}

		if((my_inebriety() >= 6) && (my_inebriety() <= 11) && (get_property("cc_orchard") == "finished") && (my_mp() >= mpForOde))
		{
			if((get_property("cc_nuns") != "finished") && (get_property("cc_nuns") != "done") && (get_property("currentNunneryMeat").to_int() == 0))
			{
				if(item_amount($item[ambitious turkey]) > 0)
				{
					shrugAT($effect[Ode to Booze]);
					buffMaintain($effect[Ode to Booze], 50, 1, 1);
					drink(1, $item[ambitious turkey]);
				}
			}
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (my_meat() > 150) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (inebriety_left() > 0) && (my_meat() > 500) && (get_property("_speakeasyDrinksDrunk").to_int() < 3) && (item_amount($item[Clan VIP Lounge Key]) > 0))
		{
			# We could check for good drinks here but I don't know what would be good checks
			int canDrink = inebriety_left();
			#Consider Ish Kabibble for A-Boo Peak (2)

			item toDrink = $item[none];
			if(canDrink >= 2)
			{
				toDrink = $item[Bee\'s Knees];
			}
			else if(canDrink >= 1)
			{
				toDrink = $item[glass of &quot;milk&quot;];
			}

			if(toDrink != $item[none])
			{
				shrugAT($effect[Ode to Booze]);
				buffMaintain($effect[Ode to Booze], 50, 1, 4);
				drinkSpeakeasyDrink(toDrink);
			}
		}

/*****	This section needs to merge into a "Standard equivalent"		*****/
		if((cc_my_path() == "Standard") && (my_mp() >= mpForOde) && (my_meat() > 150) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}


		if((cc_my_path() == "Standard") && (my_mp() >= mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
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
#				shrugAT($effect[Ode to Booze]);
#				buffMaintain($effect[Ode to Booze], 50, 1, 4);
#				cli_execute("drink 1 " + toDrink);
#				print("drink 1 " + toDrink);
#			}
		}


/*****	End of Standard equivalent secton								*****/


		if((my_level() >= 11) && (spleen_left() == 15) && (item_amount($item[astral energy drink]) >= 2))
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

			if((item_amount($item[Star Key Lime Pie]) >= 3) && (fullness_left() >= 12))
			{
				buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
				buffMaintain($effect[Got Milk], 0, 1, 1);
				ccEat(3, $item[Star Key Lime Pie]);
				tryPantsEat();
				tryPantsEat();
				tryPantsEat();
			}
			else
			{
				if(fullness_left() >= 15)
				{
					pullXWhenHaveY(whatHiMein(), 3, 0);
				}
				if((item_amount(whatHiMein()) >= 3) && (fullness_left() >= 15))
				{
					buffMaintain($effect[Song of the Glorious Lunch], 10, 1, 1);
					buffMaintain($effect[Got Milk], 0, 1, 1);
					eatsilent(3, whatHiMein());
				}
			}
		}

		if((item_amount($item[handful of smithereens]) > 0) && (my_meat() > 300) && (cc_my_path() != "KOLHS") && (cc_my_path() != "Nuclear Autumn"))
		{
			cli_execute("make paint a vulgar pitcher");
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[paint a vulgar pitcher]) > 0) && ((my_inebriety() + 2) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 2);
			drink(1, $item[paint a vulgar pitcher]);
		}

		if((cc_my_path() == "Picky") && (my_mp() > mpForOde) && (item_amount($item[Ambitious Turkey]) > 0) && ((my_inebriety() + 1) <= inebriety_limit()))
		{
			shrugAT($effect[Ode to Booze]);
			buffMaintain($effect[Ode to Booze], 50, 1, 1);
			drink(1, $item[Ambitious Turkey]);
		}
	}
}
