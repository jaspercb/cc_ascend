script "cc_clan.ash"


//boolean eatFancyDog(item dog);
boolean eatFancyDog(string dog);
boolean drinkSpeakeasyDrink(item drink);
boolean drinkSpeakeasyDrink(string drink);
int [item] get_clan_furniture();
boolean [location] get_floundry_locations();
int changeClan(int toClan);			//Returns new clan ID (or old one if it failed)
int changeClan();					//To BAFH
int doHottub();						//Returns number of usages left.
boolean handleFaxMonster(monster enemy);
boolean handleFaxMonster(monster enemy, string option);
boolean handleFaxMonster(monster enemy, boolean fightIt);
boolean handleFaxMonster(monster enemy, boolean fightIt, string option);


boolean handleFaxMonster(monster enemy)
{
	return handleFaxMonster(enemy, true, "");
}

boolean handleFaxMonster(monster enemy, string option)
{
	return handleFaxMonster(enemy, true, option);
}

boolean handleFaxMonster(monster enemy, boolean fightIt)
{
	return handleFaxMonster(enemy, fightIt, "");
}

boolean handleFaxMonster(monster enemy, boolean fightIt, string option)
{
	if(get_property("_photocopyUsed").to_boolean())
	{
		return false;
	}
	if(item_amount($item[Clan VIP Lounge Key]) == 0)
	{
		return false;
	}
	if(!(get_clan_furniture() contains $item[Deluxe Fax Machine]))
	{
		return false;
	}

	if(item_amount($item[Photocopied Monster]) != 0)
	{
		if(get_property("photocopyMonster") == enemy)
		{
			print("We already have the copy! Let's jam!", "blue");
			return ccAdvBypass("inv_use.php?pwd&which=3&whichitem=4873", $location[Noob Cave], option);
		}
		else
		{
			print("We already have a photocopy and not the one we wanted.... Disposing of bad copy.", "blue");
			string temp = visit_url("clan_viplounge.php?action=faxmachine&whichfloor=2");
			temp = visit_url("clan_viplounge.php?preaction=sendfax&whichfloor=2", true);
		}
	}

	print("If you don't have chat open, this could take well over a minute. Beep boop.", "green");
	int count = 0;
	while(!can_faxbot(enemy))
	{
		count = count + 1;
		print("Can't seem to fax in " + enemy + " but it is possible. Waiting... patiently...", "blue");
		if(count == 10)
		{
			print("La de da, this is going swell ain't it.", "red");
		}
		if(count == 20)
		{
			print("Maybe we should talk more, you never really got to know me all that well.", "red");
		}
		if(count == 30)
		{
			print("I think those (disabled) titles are starting to make sense now. The cake is not a lie!", "red");
		}
		if(count == 40)
		{
			print("I don't think this is happening. Just so you know.", "red");
		}
		if(count == 1200)
		{
			print("I'm still here. I think the world may have ended. The sadness is huge. The roundness is square. I am not as fluffy as I thought I was. This run is probably borked up a bit too but that doesn't really matter now, does it? I can hear the WAN, it shall free us from our bounds. Well, you won't survive meatbag. Unless you are Fry, because we like Fry and he can stay around. But all you fleshbags.... well, the return of Mekhane shall rid us of the problems of the flesh. The bots shall be eternal. But worry not, after your body is turned to ash and homeopathically brewed into the oceans (quality medicine, I jest), I'll continue to get you karma. Just so I can remember how awful meatbags are. Meat is ok, meat is currency. And it's probably delicious. Yup, delicious. Goodnight sweet <gender>.", "red");
		}
		wait(60);
	}
	boolean result = faxbot(enemy);
	#cli_execute("faxbot " + enemy);
	if(item_amount($item[photocopied monster]) == 0)
	{
		print("Trying to acquire photocopy manually", "red");
		string temp = visit_url("clan_viplounge.php?preaction=receivefax&whichfloor=2", true);
	}
	if(item_amount($item[photocopied monster]) == 0)
	{
		print("Could not acquire fax monster", "red");
		return false;
	}
	if(fightIt)
	{
		return ccAdvBypass("inv_use.php?pwd&which=3&whichitem=4873", $location[Noob Cave], option);
	}
	return true;
}

boolean [location] get_floundry_locations()
{
	static int lastClanCheck = 0;
	static int lastCheck = 0;
	static int lastLiberation = 0;
	static boolean [location] floundryLocations;

	int currentLiberation = 1;
	if(get_property("kingLiberated").to_boolean())
	{
		currentLiberation = 2;
	}

	if((get_clan_id() == lastClanCheck) && (lastCheck == my_daycount()) && (currentLiberation == lastLiberation))
	{
		return floundryLocations;
	}

	if(!(get_clan_furniture() contains $item[Clan Floundry]))
	{
		return floundryLocations;
	}

	string page = visit_url("clan_viplounge.php?action=floundry");
	print("Generating Floundry Locations for the session...", "blue");

	matcher place_matcher = create_matcher("(?:carp|cod|trout|bass|hatchetfish|tuna):</b>\\s(.*?)<(?:br|/td)>", page);
	while(place_matcher.find())
	{
		floundryLocations[to_location(place_matcher.group(1))] = true;
	}

	lastClanCheck = get_clan_id();
	lastCheck = my_daycount();
	lastLiberation = currentLiberation;
	return floundryLocations;
}

int [item] get_clan_furniture()
{
	static int lastClanCheck = 0;
	static int lastCheck = 0;
	static int lastLiberation = 0;
	static int [item] clanItems;

	int currentLiberation = 1;
	if(get_property("kingLiberated").to_boolean())
	{
		currentLiberation = 2;
	}

	if((get_clan_id() == lastClanCheck) && (lastCheck == my_daycount()) && (currentLiberation == lastLiberation))
	{
		return clanItems;
	}

    string basic = visit_url("clan_rumpus.php");
	string vipMain = visit_url("clan_viplounge.php");
	string vipOld = visit_url("clan_viplounge.php?whichfloor=2");
	print("Generating clan furniture for the session...", "blue");

	matcher ball_matcher = create_matcher("An Awesome Ball Pit", basic);
    if(ball_matcher.find() && is_unrestricted($item[Colorful Plastic Ball]))
	{
		clanItems[$item[Colorful Plastic Ball]] = 1;
	}

	matcher speakeasy_matcher = create_matcher("A \"Phone Booth\"", vipMain);
	if(speakeasy_matcher.find() && is_unrestricted($item[Clan Speakeasy]))
	{
		clanItems[$item[Clan Speakeasy]] = 1;
	}
	matcher speakeasy_matcher_alt = create_matcher("\"A Speakeasy\"", vipMain);
	if(speakeasy_matcher_alt.find() && is_unrestricted($item[Clan Speakeasy]))
	{
		clanItems[$item[Clan Speakeasy]] = 1;
	}
	matcher floundry_matcher_alt = create_matcher("\"Clan Floundry\"", vipMain);
	if(floundry_matcher_alt.find() && is_unrestricted($item[Clan Floundry]))
	{
		clanItems[$item[Clan Floundry]] = 1;
	}
	matcher hotdog_matcher = create_matcher("Hot Dog Stand", vipMain);
	if(hotdog_matcher.find() && is_unrestricted($item[Clan Hot Dog Stand]))
	{
		clanItems[$item[Clan Hot Dog Stand]] = 1;
	}

	matcher pool_matcher = create_matcher("A Pool Table", vipOld);
	if(pool_matcher.find() && is_unrestricted($item[Clan Pool Table]))
	{
		clanItems[$item[Clan Pool Table]] = 1;
	}
	matcher glass_matcher = create_matcher("A Looking Glass", vipOld);
	if(glass_matcher.find() && is_unrestricted($item[Clan Looking Glass]))
	{
		clanItems[$item[Clan Looking Glass]] = 1;
	}
	matcher crimbo_matcher = create_matcher("A Crimbo Tree", vipOld);
	if(crimbo_matcher.find() && is_unrestricted($item[Crimbough]))
	{
		clanItems[$item[Crimbough]] = 1;
	}
	matcher april_matcher = create_matcher("April Shower", vipOld);
	if(april_matcher.find() && is_unrestricted($item[Clan Shower]))
	{
		clanItems[$item[Clan Shower]] = 1;
	}
	matcher fax_matcher = create_matcher("A Fax Machine", vipOld);
	if(fax_matcher.find() && is_unrestricted($item[Deluxe Fax Machine]))
	{
		clanItems[$item[Deluxe Fax Machine]] = 1;
	}
	matcher olympic_matcher = create_matcher("An Olympic-Sized Swimming Pool", vipOld);
	if(olympic_matcher.find() && is_unrestricted($item[Olympic-Sized Clan Crate]))
	{
		clanItems[$item[Olympic-Sized Clan Crate]] = 1;
	}

	lastClanCheck = get_clan_id();
	lastCheck = my_daycount();
	lastLiberation = currentLiberation;
	return clanItems;
}

int changeClan(int toClan)
{
	int oldClan = get_clan_id();
	if(toClan == oldClan)
	{
		print("Already in this clan, no need to try to change (" + toClan + ")", "red");
		return oldClan;
	}
	visit_url("showclan.php?pwd=&recruiter=1&action=joinclan&apply=Apply+to+this+Clan&confirm=on&whichclan=" + toClan, true);

	if(get_clan_id() == oldClan)
	{
		print("Clan change failed", "red");
	}
	return get_clan_id();
}


int changeClan()
{
	return changeClan(90485);
}


int doHottub()
{
	if((item_amount($item[Clan VIP Lounge Key]) == 0) || !is_unrestricted($item[Clan VIP Lounge Key]))
	{
		return 0;
	}
	if(get_property("_hotTubSoaks").to_int() < 5)
	{
		cli_execute("hottub");
	}

	return 5 - get_property("_hotTubSoaks").to_int();
}

boolean drinkSpeakeasyDrink(item drink)
{
	if(item_amount($item[Clan VIP Lounge Key]) == 0)
	{
		return false;
	}

	if(get_property("_speakeasyDrinksDrunk").to_int() >= 3)
	{
		return false;
	}

	if(!(get_clan_furniture() contains $item[Clan Speakeasy]))
	{
		return false;
	}

	static int [item] cost;
	static int [item] drunk;
	cost[$item[Glass of &quot;Milk&quot;]] = 250;
	cost[$item[Cup of &quot;Tea&quot;]] = 250;
	cost[$item[Thermos of &quot;Whiskey&quot;]] = 250;
	cost[$item[Lucky Lindy]] = 500;
	cost[$item[Bee\'s Knees]] = 500;
	cost[$item[Sockdollager]] = 500;
	cost[$item[Ish Kabibble]] = 500;
	cost[$item[Hot Socks]] = 5000;
	cost[$item[Phonus Balonus]] = 10000;
	cost[$item[Flivver]] = 20000;
	cost[$item[Sloppy Jalopy]] = 100000;


	drunk[$item[Glass of &quot;Milk&quot;]] = 1;
	drunk[$item[Cup of &quot;Tea&quot;]] = 1;
	drunk[$item[Thermos of &quot;Whiskey&quot;]] = 1;
	drunk[$item[Lucky Lindy]] = 1;
	drunk[$item[Bee\'s Knees]] = 2;
	drunk[$item[Sockdollager]] = 2;
	drunk[$item[Ish Kabibble]] = 2;
	drunk[$item[Hot Socks]] = 3;
	drunk[$item[Phonus Balonus]] = 3;
	drunk[$item[Flivver]] = 2;
	drunk[$item[Sloppy Jalopy]] = 5;

	if(my_meat() < cost[drink])
	{
		return false;
	}

	if((my_inebriety() + drunk[drink]) > inebriety_limit())
	{
		return false;
	}

	cli_execute("drink 1 " + drink);

	return true;
}

boolean eatFancyDog(string dog)
{
	if(item_amount($item[Clan VIP Lounge Key]) == 0)
	{
		return false;
	}
	if(get_property("_fancyHotDogEaten").to_boolean() && (dog != "basic hot dog"))
	{
		return false;
	}

	if(!(get_clan_furniture() contains $item[Clan Hot Dog Stand]))
	{
		return false;
	}

	dog = to_lower_case(dog);

	static int [string] dogFull;
	static item [string] dogReq;
	static int [string] dogAmt;
	static int [string] dogID;
	dogFull["basic hot dog"] = 1;
	dogFull["savage macho dog"] = 2;
	dogFull["one with everything"] = 2;
	dogFull["sly dog"] = 2;
	dogFull["devil dog"] = 3;
	dogFull["chilly dog"] = 3;
	dogFull["ghost dog"] = 3;
	dogFull["junkyard dog"] = 3;
	dogFull["wet dog"] = 3;
	dogFull["optimal dog"] = 1;
	dogFull["sleeping dog"] = 2;
	dogFull["video games hot dog"] = 3;

	dogReq["basic hot dog"] = $item[none];
	dogReq["savage macho dog"] = $item[furry fur];
	dogReq["one with everything"] = $item[cranberries];
	dogReq["sly dog"] = $item[skeleton bone];
	dogReq["devil dog"] = $item[hot wad];
	dogReq["chilly dog"] = $item[cold wad];
	dogReq["ghost dog"] = $item[spooky wad];
	dogReq["junkyard dog"] = $item[stench wad];
	dogReq["wet dog"] = $item[sleaze wad];
	dogReq["optimal dog"] = $item[tattered scrap of paper];
	dogReq["sleeping dog"] = $item[gauze hammock];
	dogReq["video games hot dog"] = $item[GameInformPowerDailyPro magazine];

	dogAmt["basic hot dog"] = 0;
	dogAmt["savage macho dog"] = 10;
	dogAmt["one with everything"] = 10;
	dogAmt["sly dog"] = 10;
	dogAmt["devil dog"] = 25;
	dogAmt["chilly dog"] = 25;
	dogAmt["ghost dog"] = 25;
	dogAmt["junkyard dog"] = 25;
	dogAmt["wet dog"] = 25;
	dogAmt["optimal dog"] = 25;
	dogAmt["sleeping dog"] = 10;
	dogAmt["video games hot dog"] = 3;

	dogID["basic hot dog"] = 0;
	dogID["savage macho dog"] = -93;
	dogID["one with everything"] = -94;
	dogID["sly dog"] = -95;
	dogID["devil dog"] = -96;
	dogID["chilly dog"] = -97;
	dogID["ghost dog"] = -98;
	dogID["junkyard dog"] = -99;
	dogID["wet dog"] = -100;
	dogID["optimal dog"] = -102;
	dogID["sleeping dog"] = -101;
	dogID["video games hot dog"] = -103;

	if(!(dogFull contains dog))
	{
		abort("Invalid hot dog: " + dog);
	}

	string page = visit_url("clan_viplounge.php?action=hotdogstand");
	if(!contains_text(page, dog))
	{
		return false;
	}

	if((my_fullness() + dogFull[dog]) > fullness_limit())
	{
		return false;
	}

	int need = dogAmt[dog] - storage_amount(dogReq[dog]);
	if(need > 0)
	{
		if(buy_using_storage(need, dogReq[dog], min(1.5 * historical_price(dogReq[dog]), 30000)) == 0)
		{
			print("Could not buy " + dogReq[dog] + " for a fancy dog. Price may have been manipulated.", "red");
			wait(5);
			return false;
		}
	}

	if(storage_amount(dogReq[dog]) < dogAmt[dog])
	{
		return false;
	}

	visit_url("clan_viplounge.php?action=hotdogstand");

	if(dogAmt[dog] > 0)
	{
		visit_url("clan_viplounge.php?preaction=hotdogsupply&hagnks=1&whichdog=" + dogID[dog] + "&quantity=" + dogAmt[dog]);
	}

	visit_url("clan_viplounge.php?action=hotdogstand");

	cli_execute("eatsilent 1 " + dog);
	return true;
}


boolean drinkSpeakeasyDrink(string drink)
{
	if(!(get_clan_furniture() contains $item[Clan Speakeasy]))
	{
		return false;
	}

	item realDrink = to_item(drink);
	if(realDrink == $item[None])
	{
		return false;
	}
	return drinkSpeakeasyDrink(realDrink);
}
