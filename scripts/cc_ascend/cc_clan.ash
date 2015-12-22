script "cc_clan.ash"


//boolean eatFancyDog(item dog);
boolean eatFancyDog(string dog);
boolean drinkSpeakeasyDrink(item drink);
boolean drinkSpeakeasyDrink(string drink);
int [item] get_clan_furniture();
int changeClan(int toClan);			//Returns new clan ID (or old one if it failed)
int changeClan();					//To BAFH
int doHottub();						//Returns number of usages left.



/****

We might consider migrating faxbot stuff here as it is "clan". I dunno....

****/

int [item] get_clan_furniture()
{
    int [item] clanItems;
    string basic = visit_url("clan_rumpus.php");
	string vipMain = visit_url("clan_viplounge.php");
	string vipOld = visit_url("clan_viplounge.php?whichfloor=2");


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
