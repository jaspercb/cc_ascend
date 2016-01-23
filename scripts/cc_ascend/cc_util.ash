script "cc_util.ash";
import <zlib.ash>
import <cc_ascend/cc_chateaumantegna.ash>
import <cc_ascend/cc_ascend_header.ash>

// Public Prototypes
void debugMaximize(string req, int meat);			//This function will be removed.
boolean ccMaximize(string req, boolean simulate);
boolean ccMaximize(string req, int maxPrice, int priceLevel, boolean simulate);
aggregate ccMaximize(string req, int maxPrice, int priceLevel, boolean simulate, boolean includeEquip);
boolean snojoFightAvailable();
int doNumberology(string goal);
int doNumberology(string goal, boolean doIt);
boolean handleBarrelFullOfBarrels();
int solveCookie();
boolean use_barrels();
int ccCraft(string mode, int count, item item1, item item2);
int[item] cc_get_campground();
boolean haveSpleenFamiliar();
float elemental_resist_value(int resistance);
float elemental_resist_value(element resistance);
int elemental_resist(element goal);
boolean uneffect(effect toRemove);
boolean organsFull();
boolean set_property_ifempty(string setting, string change);
boolean restore_property(string setting, string source);
boolean clear_property_if(string setting, string cond);
int doRest();
boolean isFreeMonster(monster mon);
boolean in_ronin();
item whatHiMein();
boolean getDiscoStyle();
boolean getDiscoStyle(int choice);
int dreamJarDrops();
int powderedGoldDrops();
int grimTaleDrops();
int maxSealSummons();
string statCard();
effect whatStatSmile();
void tootGetMeat();
boolean ovenHandle();
boolean handleFaxMonster(monster enemy);
boolean handleFaxMonster(monster enemy, string option);
boolean handleFaxMonster(monster enemy, boolean fightIt);
boolean handleFaxMonster(monster enemy, boolean fightIt, string option);
boolean isGuildClass();
boolean handleRainDoh();
boolean handleSpookyPutty();
boolean handle4dCamera();
boolean handleIceSculpture();
int towerKeyCount();
void handleTracker(monster enemy, string tracker);
void handleTracker(monster enemy, skill toTrack, string tracker);
void handleTracker(monster enemy, string toTrack, string tracker);
void handleTracker(monster enemy, item toTrack, string tracker);
int internalQuestStatus(string prop);
string runChoice(string page_text);
int turkeyBooze();
int amountTurkeyBooze();
int numPirateInsults();
int fastenerCount();
int lumberCount();
skill preferredLibram();
boolean playwith(item toy, string prop);
boolean playwith(skill sk, string prop);
boolean ok_skill(skill sk, string prop);
boolean haveAny(boolean[item] array);
boolean haveGuitar();
boolean haveAccordion();
boolean haveDrum();
void pullAll(item it);
void pullAndUse(item it, int uses);
boolean pullXWhenHaveY(item it, int howMany, int whenHave);
effect[item] allBangPotions();
int numPotionsFound(effect need);
item bangPotionNeeded(effect need);
boolean solveBangPotion(effect need);
void pulverizeThing(item it);
boolean buy_item(item it, int quantity, int maxprice);
string tryBeerPong();
boolean useCocoon();
boolean hasShieldEquipped();
void shrugAT();
boolean buyUpTo(int num, item it);
boolean buyUpTo(int num, item it, int maxprice);
boolean buffMaintain(effect buff, int mp_min, int cases, int turns);
effect effectNeededFirstGate(string data);
boolean cc_deleteMail(kmessage msg);
boolean buyableMaintain(item toMaintain, int howMany);
boolean buyableMaintain(item toMaintain, int howMany, int meatMin);
boolean buyableMaintain(item toMaintain, int howMany, int meatMin, boolean condition);
int ns_crowd1();
stat ns_crowd2();
element ns_crowd3();
element ns_hedge1();
element ns_hedge2();
element ns_hedge3();
void woods_questStart();			//From Bale\'s woods.ash relay mod.
int howLongBeforeHoloWristDrop();
boolean is_avatar_potion(item it);	//From Veracity\'s "avatar potion" post
string cc_my_path();
boolean lastAdventureSpecialNC();

// Private Prototypes
boolean buffMaintain(item source, effect buff, int uses, int turns);
boolean buffMaintain(skill source, effect buff, int mp_min, int casts, int turns);
string beerPong(string page);
boolean beehiveConsider();
string safeString(string input);
string safeString(skill input);
string safeString(item input);
string safeString(monster input);

// Function Definitions

boolean ccMaximize(string req, boolean simulate)
{
	if(!simulate)
	{
		debugMaximize(req, 0);
#		user_confirm("Beep");
	}
	return maximize(req, simulate);
}

boolean ccMaximize(string req, int maxPrice, int priceLevel, boolean simulate)
{
	if(!simulate)
	{
		debugMaximize(req, maxPrice);
#		user_confirm("Beep");
	}
	return maximize(req, maxPrice, priceLevel, simulate);
}

aggregate ccMaximize(string req, int maxPrice, int priceLevel, boolean simulate, boolean includeEquip)
{
	if(!simulate)
	{
		debugMaximize(req, maxPrice);
#		user_confirm("Beep");
	}
	return maximize(req, maxPrice, priceLevel, simulate, includeEquip);
}

void debugMaximize(string req, int meat)
{
	if(req.index_of("-tie") == -1)
	{
		req = req + " -tie";
		print("Added -tie to maximize", "red");
	}
	print("Desired maximize: " + req, "blue");
	string situation = " " + my_class() + " " + my_path() + " " + my_sign();
	if(in_hardcore())
	{
		situation = "Hardcore" + situation;
	}
	else
	{
		situation = "Softcore" + situation;
	}
	boolean[effect] acquired;
	acquired[$effect[none]] = true;
	string tableDo = "<table border=1><tr><td colspan=3>Accepted: Maximizing: " + req + "</td><td colspan=3>" + situation + "</td></tr>";
	string tableDont = "<table border=1><tr><td colspan=3>Rejected: Maximizing: " + req + "</td><td colspan=3>" + situation + "</td></tr>";
	tableDo += "<tr><td>Score</td><td>Effect</td><td>Command</td><td>Skill</td><td>Item</td><td>Display</td></tr>";
	tableDont += "<tr><td>Score</td><td>Effect</td><td>Command</td><td>Skill</td><td>Item</td><td>Display</td></tr>";

	foreach it, entry in maximize(req, 0, 0, true, true)
	{
		string output = "";

		entry.display = replace_string(entry.display, "<html>", "");
		entry.display = replace_string(entry.display, "</html>", "");

		if(entry.skill != $skill[none])
		{
			output += "Skill(" + entry.skill + ") ";
		}
		if(entry.command != "")
		{
			output += "Command(" + entry.command + ") ";
		}
		string display = "Display(" + entry.display + ") ";
		if(entry.item != $item[none])
		{
			output += "Item(" + entry.item + ") ";
		}
		if(entry.effect != $effect[none])
		{
			output += "Effect(" + entry.effect + ") ";
		}
		output += "Score(" + entry.score + ")";

		boolean doThis = true;
		if(entry.score <= 0)
		{
			doThis = false;
		}
		if(entry.command.index_of("uneffect ") == 0)
		{
			doThis = false;
		}
		if(entry.display.index_of("uneffect ") == 0)
		{
			doThis = false;
		}
		if(entry.display.index_of("<font color=gray>") != -1)
		{
			doThis = false;
		}
		if(entry.skill != $skill[none])
		{
			if(turns_per_cast(entry.skill) <= 0)
			{
				doThis = false;
			}
			if(adv_cost(entry.skill) > 0)
			{
				doThis = false;
			}
			if(lightning_cost(entry.skill) > my_lightning())
			{
				doThis = false;
			}
			if(mp_cost(entry.skill) > my_mp())
			{
				doThis = false;
			}
			if(rain_cost(entry.skill) > my_rain())
			{
				doThis = false;
			}
			if(soulsauce_cost(entry.skill) > my_soulsauce())
			{
				doThis = false;
			}
			if(thunder_cost(entry.skill) > my_thunder())
			{
				doThis = false;
			}
		}
		else
		{
			//If not a skill, is it an item?
			if(entry.item != $item[none])
			{
				if(entry.display.index_of("drink ") == 0)
				{
					doThis = false;
				}
				if(entry.display.index_of("eat ") == 0)
				{
					doThis = false;
				}
				if(entry.display.index_of("play ") == 0)
				{
					doThis = false;
				}
				if(entry.display.index_of("bind ") == 0)
				{
					doThis = false;
				}
				if(entry.display.index_of("cast 1 Bind ") == 0)
				{
					doThis = false;
				}
				if(entry.display.index_of("chew ") == 0)
				{
					doThis = false;
				}
#				if(entry.display.index_of("...or ") == 0)
#				{
#					doThis = false;
#				}

				//Mafia likes to recommend pirate Ephemera that we can not buy.
				if(($items[Pirate Tract, Pirate Pamphlet, Pirate Brochure] contains entry.item) && ((my_ascensions() != get_property("lastPirateEphemeraReset").to_int()) || (entry.item != to_item(get_property("lastPirateEphemera"))) ))
				{
					doThis = false;
				}

				if(entry.display.index_of("make ") == 0)
				{
					//We can this make item.
					doThis = false;
				}
				if(entry.display.index_of("use ") == 0)
				{
					//We have this item
				}
				if(entry.display.index_of("buy ") == 0)
				{
					//We can buy this item
					if(npc_price(entry.item) > meat)
					{
						doThis = false;
					}
				}
			}
			else
			{
				//Not a skill or item, what is it?
				if(entry.display.index_of("telescope ") == 0)
				{}
				else if(entry.display.index_of("grim init ") == 0)
				{}
				else if(entry.display.index_of("unequip ") == 0)
				{}
				else if(entry.display.index_of("familiar ") == 0)
				{}
				else if(entry.display.index_of("bjorn ") == 0)
				{}
				else
				{
					doThis = false;
				}
			}
		}

		if((acquired contains entry.effect) && (entry.effect != $effect[none]))
		{
			dothis = false;
		}
		if((entry.effect != $effect[none]) && (have_effect(entry.effect) > 0))
		{
			doThis = false;
		}

		string curTable = "<td>" + entry.score + "</td>";
		curTable += "<td>" + entry.effect + "</td>";
		curTable += "<td>&nbsp;" + entry.command + "</td>";
		curTable += "<td>" + entry.skill + "</td>";
		curTable += "<td>" + entry.item + "</td>";
		curTable += "<td>&nbsp;" + entry.display + "</td>";

		if(doThis)
		{
			#use_skill(1, entry.skill);
			acquired[entry.effect] = true;
			output = "USE: " + output;
			tableDo += "<tr>" + curTable + "</tr>";
		}
		else
		{
			output = "REJECT: " + output;
			tableDont += "<tr>" + curTable + "</tr>";
		}
		print(output, "blue");
		print(display, "green");
	}

	tableDo += "</table>";
	tableDont += "</table>";
	print_html(tableDo);
	print_html(tableDont);

	if(get_property("cc_shareMaximizer").to_boolean() && get_property("cc_allowSharingData").to_boolean())
	{
		print("Sharing Maximizer data.", "blue");
		#print("http://cheesellc.com/kol/sharing.php?type=maximizer&data="+url_encode(tableDo + tableDont), "red");
		string temp = visit_url("http://cheesellc.com/kol/sharing.php?type=maximizer&data="+url_encode(tableDo + tableDont));
		if(contains_text(temp, "success"))
		{
			print("Data shared successfully", "green");
		}
		else
		{
			print("Data share failed", "green");
		}
	}

	//	A successive print will help make the table readable in cases where it is not rendered properly
	//cli_execute("ashref get_inventory");

}


string safeString(string input)
{
	matcher comma = create_matcher("[,]", input);
	input = replace_all(comma, ".");
	return input;
}

string safeString(skill input)
{
	return safeString("" + input);
}

string safeString(item input)
{
	return safeString("" + input);
}
string safeString(monster input)
{
	return safeString("" + input);
}

void handleTracker(monster enemy, skill toTrack, string tracker)
{
	string cur = get_property(tracker);
	if(cur != "")
	{
		cur = cur + ", ";
	}
	cur = cur + "(" + my_daycount() + ":" + safeString(enemy) + ":" + safeString(toTrack) + ":" + my_turncount() + ")";
	set_property(tracker, cur);
}

void handleTracker(monster enemy, string toTrack, string tracker)
{
	string cur = get_property(tracker);
	if(cur != "")
	{
		cur = cur + ", ";
	}
	cur = cur + "(" + my_daycount() + ":" + safeString(enemy) + ":" + safeString(toTrack) + ":" + my_turncount() + ")";
	set_property(tracker, cur);
}

void handleTracker(monster enemy, item toTrack, string tracker)
{
	string cur = get_property(tracker);
	if(cur != "")
	{
		cur = cur + ", ";
	}
	cur = cur + "(" + my_daycount() + ":" + safeString(enemy) + ":" + safeString(toTrack) + ":" + my_turncount() + ")";
	set_property(tracker, cur);
}

void handleTracker(monster enemy, string tracker)
{
	string cur = get_property(tracker);
	if(cur != "")
	{
		cur = cur + ", ";
	}
	cur = cur + "(" + my_daycount() + ":" + safeString(enemy) + ":" + my_turncount() + ")";
	set_property(tracker, cur);
}

boolean organsFull()
{
	if(my_fullness() < fullness_limit())
	{
		return false;
	}
	if(my_inebriety() < inebriety_limit())
	{
		return false;
	}
	if(my_spleen_use() < spleen_limit())
	{
		return false;
	}
	return true;
}

boolean is_avatar_potion(item it)
{
	#From Veracity\'s "avatar potion" post
	#http://kolmafia.us/showthread.php?19302-Add-quot-avatar-potion-quot-as-an-item_type%28%29&p=129243&viewfull=1#post129243
	effect e = effect_modifier(it, "Effect");
	if(e == $effect[none])
	{
		return false;
	}
	string avatar = string_modifier(e, "Avatar");
	return (avatar != "");
}

int ccCraft(string mode, int count, item item1, item item2)
{
	if((mode == "combine") && !knoll_available())
	{
		if(my_meat() < (10 * count))
		{
			print("Count not combine " + item1 + " and " + item2 + " due to lack of meat paste.", "red");
			return 0;
		}
		int need = max(0, count - item_amount($item[Meat Paste]));
		if(need > 0)
		{
			cli_execute("make " + need + " meat paste");
		}
	}
	return craft(mode, count, item1, item2);
}

int internalQuestStatus(string prop)
{
	string status = get_property(prop);
	if(status == "unstarted")
	{
		return -1;
	}
	if(status == "started")
	{
		return 0;
	}
	if(status == "finished")
	{
		//Does not handle quests with over 9998 steps. That\'s the Gnome letter quest, yes?
		return 9999;
	}
	matcher my_element = create_matcher("step(\\d+)", status);
	if(my_element.find())
	{
		return to_int(my_element.group(1));
	}
	return -1;
}

int solveCookie()
{
	if(!contains_text(get_counters("Fortune Cookie", 0, 250), "Fortune Cookie"))
	{
		return -1;
	}
	int i=0;
	while(i < 250)
	{
		if(contains_text(get_counters("Fortune Cookie", 0, i), "Fortune Cookie"))
		{
			set_property("cc_cookie", my_turncount() + i);
			break;
		}
		i = i + 1;
	}

	return get_property("cc_cookie").to_int();
}

int dreamJarDrops()
{
	return get_property("_dreamJarDrops").to_int();
}

int powderedGoldDrops()
{
	return get_property("_powderedGoldDrops").to_int();
}

int grimTaleDrops()
{
	return get_property("_grimFairyTaleDrops").to_int();
}

string statCard()
{
	switch(my_primestat())
	{
	case $stat[Muscle]:
		return "68";
	case $stat[Mysticality]:
		return "70";
	case $stat[Moxie]:
		return "69";
	}
	return "";
}

boolean getDiscoStyle(int choice)
{
	getDiscoStyle();
    visit_url("place.php?whichplace=airport_hot&action=airport4_zone1");
    run_choice(choice);
	return true;
}

boolean getDiscoStyle()
{
	if(item_amount($item[Smooth Velvet Hanky]) > 0)
	{
		equip($slot[acc1], $item[Smooth Velvet Hanky]);
	}
	if(item_amount($item[Smooth Velvet Pocket Square]) > 0)
	{
		equip($slot[acc2], $item[Smooth Velvet Pocket Square]);
	}
	if(item_amount($item[Smooth Velvet Socks]) > 0)
	{
		equip($slot[acc3], $item[Smooth Velvet Socks]);
	}
	if(item_amount($item[Smooth Velvet Hat]) > 0)
	{
		equip($item[Smooth Velvet Hat]);
	}
	if(item_amount($item[Smooth Velvet Pants]) > 0)
	{
		equip($item[Smooth Velvet Pants]);
	}
	if(item_amount($item[Smooth Velvet Shirt]) > 0)
	{
		equip($item[Smooth Velvet Shirt]);
	}
	else if(item_amount($item[Smooth Velvet Bra]) > 0)
	{
		equip($item[Smooth Velvet Bra]);
	}
	return true;
}

boolean isGuildClass()
{
	return ($classes[Seal Clubber, Turtle Tamer, Sauceror, Pastamancer, Disco Bandit, Accordion Thief] contains my_class());
}

float elemental_resist_value(int resistance)
{
	float bonus = 0;
	if((my_class() == $class[Pastamancer]) || (my_class() == $class[Sauceror]) || (my_class() == $class[Ed]))
	{
		bonus = 5;
	}
	if(resistance <= 3)
	{
		return ((10.0 * resistance) + bonus);
	}
	float scale = 1.0;
	resistance = resistance - 4;
	while(resistance > 0)
	{
		scale = scale * 5.0/6.0;
		resistance = resistance - 1;
	}
	return (90.0 - (50.0 * scale) + bonus);
}

float elemental_resist_value(element resistance)
{
	return elemental_resist_value(elemental_resist(resistance));
}

int elemental_resist(element goal)
{
	string page = to_lower_case(visit_url("charsheet.php"));
	matcher my_element = create_matcher(to_string(goal) + " protection:(.*?)((\\d\+)\)", page);
	if(my_element.find())
	{
		return to_int(my_element.group(2));
	}
	return 0;
}

boolean uneffect(effect toRemove)
{
	if(have_effect(toRemove) == 0)
	{
		return true;
	}
	if(cli_execute("uneffect " + toRemove))
	{
		//Either we don\'t have the effect or it is shruggable.
		return true;
	}

	if(item_amount($item[Soft Green Echo Eyedrop Antidote]) > 0)
	{
		visit_url("uneffect.php?pwd=&using=Yep.&whicheffect=" + to_int(toRemove));
		print("Effect removed by Soft Green Echo Eyedrop Antidote.", "blue");
		return true;
	}
	else if(item_amount($item[Ancient Cure-All]) > 0)
	{
		visit_url("uneffect.php?pwd=&using=Yep.&whicheffect=" + to_int(toRemove));
		print("Effect removed by Ancient Cure-All.", "blue");
		return true;
	}
	return false;
}

int ns_crowd1()
{
	print("Default Test: Initiative", "red");
	return 1;
}
stat ns_crowd2()
{
	print("Off-Stat Test: " + get_property("nsChallenge1"), "red");
	return to_stat(get_property("nsChallenge1"));
}
element ns_crowd3()
{
	print("Elemental Test: " + get_property("nsChallenge2"), "red");
	return to_element(get_property("nsChallenge2"));
}
element ns_hedge1()
{
	print("Hedge Maze 1: " + get_property("nsChallenge3"), "red");
	return to_element(get_property("nsChallenge3"));
}
element ns_hedge2()
{
	print("Hedge Maze 2: " + get_property("nsChallenge4"), "red");
	return to_element(get_property("nsChallenge4"));
}
element ns_hedge3()
{
	print("Hedge Maze 3: " + get_property("nsChallenge5"), "red");
	return to_element(get_property("nsChallenge5"));
}

skill preferredLibram()
{
	if(have_skill($skill[Summon Brickos]))
	{
		return $skill[Summon Brickos];
	}
	if(have_skill($skill[Summon Resolutions]))
	{
		return $skill[Summon Resolutions];
	}
	if(have_skill($skill[Summon Taffy]))
	{
		return $skill[Summon Taffy];
	}
	return $skill[none];
}


boolean lastAdventureSpecialNC()
{
	if(my_class() == $class[Turtle Tamer])
	{
		if($strings[Nantucket Snapper, Blue Monday, Capital!, Training Day, Boxed In, Duel Nature, Slow Food, A Rolling Turtle Gathers No Moss, The Horror..., Slow Road to Hell, C\'mere\, Little Fella, The Real Victims, Like That Time in Tortuga, Cleansing your Palette, Harem Scarum, Turtle in peril, No Man\, No Hole, Slow and Steady Wins the Brawl, Stormy Weather, Turtles of the Universe, O Turtle Were Art Thou, Allow 6-8 Weeks For Delivery, Kick the Can, Turtles All The Way Around, More eXtreme Than Usual, Jewel in the Rough, The worst kind of drowning, Even Tamer Than Usual, Never Break the Chain, Close\, but Yes Cigar, Armchair Quarterback, This Turtle Rocks!, Really Sticking Her Neck Out, It Came from Beneath the Sewer? Great!, Don\'t Be Alarmed\, Now, Puttin\' it on Wax, More Like... Hurtle, Musk! Musk! Musk!, Silent Strolling] contains get_property("lastEncounter"))
		{
			return true;
		}
	}

	//I suppose we really do not need to validate that we have a Haunted Doghouse actually.
	if($strings[Wooof! Wooooooof!, Playing Fetch*, Your Dog Found Something Again, Dog Diner Afternoon, Labrador Conspirator, Doggy Heaven, Lava Dogs, Fruuuuuuuit, Boooooze Hound, Baker\'s Dogzen, Dog Needs Food Badly, Ratchet-catcher, Something About Hot Wings, Seeing-Eyes Dog, Carpenter Dog, Are They Made of Real Dogs?, Gunbowwowder, It Isn\'t a Poodle] contains get_property("lastEncounter"))
	{
		return true;
	}

	return false;
}

int doRest()
{
	if(chateaumantegna_available())
	{
		chateaumantegna_nightstandSet();

		boolean[item] restBonus = chateaumantegna_decorations();
		stat bonus = $stat[none];
		if(restBonus contains $item[Electric Muscle Stimulator])
		{
			bonus = $stat[Muscle];
		}
		else if(restBonus contains $item[Foreign Language Tapes])
		{
			bonus = $stat[Mysticality];
		}
		else if(restBonus contains $item[Bowl of Potpourri])
		{
			bonus = $stat[Moxie];
		}

		boolean closet = false;
		item grab = $item[none];
		item replace = $item[none];
		switch(bonus)
		{
		case $stat[Muscle]:
			replace = equipped_item($slot[off-hand]);
			grab = $item[Fake Washboard];
		break;
		case $stat[Mysticality]:
			replace = equipped_item($slot[off-hand]);
			grab = $item[Basaltamander Buckler];
		break;
		case $stat[Moxie]:
			replace = equipped_item($slot[weapon]);
			grab = $item[Backwoods Banjo];
		break;
		}

		if(possessEquipment(grab) && (replace != grab))
		{
			equip(grab);
		}
		if(!possessEquipment(grab) && (replace != grab) && (closet_amount(grab) > 0))
		{
			closet = true;
			take_closet(1, grab);
			equip(grab);
		}

		visit_url("place.php?whichplace=chateau&action=chateau_restbox");

		if(replace != grab)
		{
			equip(replace);
		}
		if(closet)
		{
			put_closet(1, grab);
		}

	}
	else
	{
		set_property("restUsingChateau", false);
		cli_execute("rest");
		set_property("restUsingChateau", true);
	}
	return get_property("timesRested").to_int();
}

boolean buyableMaintain(item toMaintain, int howMany)
{
	return buyableMaintain(toMaintain, howMany, 0, true);
}

boolean buyableMaintain(item toMaintain, int howMany, int meatMin)
{
	return buyableMaintain(toMaintain, howMany, meatMin, true);
}

boolean buyableMaintain(item toMaintain, int howMany, int meatMin, boolean condition)
{
	if((!condition) || (my_meat() < meatMin))
	{
		return false;
	}

	return buyUpTo(howMany, toMaintain);
}


effect whatStatSmile()
{
	switch(my_class())
	{
	case $class[Seal Clubber]:
	case $class[Turtle Tamer]:
		return $effect[Patient Smile];
	case $class[Sauceror]:
	case $class[Pastamancer]:
		return $effect[Wry Smile];
	case $class[Disco Bandit]:
	case $class[Accordion Thief]:
		return $effect[Knowing Smile];
	}
	return $effect[none];
}

item whatHiMein()
{
	if(my_level() < 8)
	{
		return $item[none];
	}
	if(my_level() < 9)
	{
		return $item[Fettucini Inconnu];
	}
	if(!in_hardcore() && (my_level() >= 13) && (pulls_remaining() > 0))
	{
		switch(my_class())
		{
		case $class[Seal Clubber]:
		case $class[Turtle Tamer]:
			return $item[Cold Hi Mein];
		case $class[Sauceror]:
		case $class[Pastamancer]:
		case $class[Ed]:
			return $item[Spooky Hi Mein];
		case $class[Disco Bandit]:
		case $class[Accordion Thief]:
			return $item[Sleazy Hi Mein];
		}
	}
	return $item[crudles];
}

void tootGetMeat()
{
	autosell(item_amount($item[hamethyst]), $item[hamethyst]);
	autosell(item_amount($item[baconstone]), $item[baconstone]);
	autosell(item_amount($item[porquoise]), $item[porquoise]);
}


boolean ovenHandle()
{
	if(cc_get_campground() contains $item[Dramatic&trade; range])
	{
		print("Oven found! We can cook!", "blue");
		set_property("cc_haveoven", true);
	}

	if(!get_property("cc_haveoven").to_boolean() && (my_meat() > 4000))
	{
		buyUpTo(1, $item[Dramatic&trade; range]);
		use(1, $item[Dramatic&trade; range]);
		set_property("cc_haveoven", true);
	}
	return get_property("cc_haveoven").to_boolean();
}

boolean isFreeMonster(monster mon)
{
	boolean[monster] classRevamp = $monsters[Box of Crafty Dinner, depressing french accordionist, Frozen Bag of Tortellini, lively cajun accordionist, Possessed Can of Creepy Pasta, Possessed Can of Linguine-Os, Possessed Jar of Alphredo&trade;, quirky indie-rock accordionist];

	boolean[monster] bricko = $monsters[BRICKO airship, BRICKO bat, BRICKO cathedral, BRICKO elephant, BRICKO gargantuchicken, BRICKO octopus, BRICKO ooze, BRICKO oyster, BRICKO python, BRICKO turtle, BRICKO vacuum cleaner];

	boolean[monster] gothKid = $monsters[Black Crayon Beast, Black Crayon Beetle, Black Crayon Constellation, Black Crayon Golem, Black Crayon Demon, Black Crayon Man, Black Crayon Elemental, Black Crayon Crimbo Elf, Black Crayon Fish, Black Crayon Goblin, Black Crayon Hippy, Black Crayon Hobo, Black Crayon Shambling Monstrosity, Black Crayon Manloid, Black Crayon Mer-kin, Black Crayon Frat Orc, Black Crayon Penguin, Black Crayon Pirate, Black Crayon Flower, Black Crayon Slime, Black Crayon Undead Thing, Black Crayon Spiraling Shape];

	boolean[monster] hipster = $monsters[angry bassist, blue-haired girl, evil ex-girlfriend, peeved roommate, random scenester];

	boolean[monster] infernalSeals = $monsters[Broodling Seal, Centurion of Sparky, Hermetic Seal, Spawn of Wally, Heat Seal, Navy Seal, Servant of Grodstank, Shadow of Black Bubbles, Watertight Seal, Wet Seal];

	boolean[monster] other = $monsters[lynyrd, giant rubber spider, Travoltron];

	if(classRevamp contains mon)
	{
		return true;
	}
	if(bricko contains mon)
	{
		return true;
	}
	if(gothKid contains mon)
	{
		return true;
	}
	if(hipster contains mon)
	{
		return true;
	}
	if(infernalSeals contains mon)
	{
		return true;
	}
	if(other contains mon)
	{
		return true;
	}

	if($monsters[Perceiver of Sensations, Performer of Actions, Thinker of Thoughts] contains mon)
	{
		if((my_familiar() == $familiar[Machine Elf]) && (get_property("_machineTunnelsAdv").to_int() < 5) && (my_location() == $location[The Deep Machine Tunnels]))
		{
			return true;
		}
	}

	if($monster[X-32-F Combat Training Snowman] == mon)
	{
		if(get_property("_snojoFreeFights") < 10)
		{
			return true;
		}
	}

	return false;
}


boolean cc_deleteMail(kmessage msg)
{
	if((msg.fromid == 0) && (contains_text(msg.message, "We found this telegram at the bottom of an old bin of mail.")))
	{
		return true;
	}
	if((msg.fromid == 0) && (contains_text(msg.message, "One of my agents found a copy of a telegram in the Council\'s fileroom")))
	{
		return true;
	}
	if(msg.fromname == "Lady Spookyraven\\'s Ghost")
	{
		return true;
	}
	if(msg.fromname == "Lady Spookyraven\'s Ghost")
	{
		return true;
	}
	return false;
}

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

	print("If you don't have chat open, this could take well over a minute. Beep boop.", "green");
	cli_execute("faxbot " + enemy);
	if(item_amount($item[photocopied monster]) == 0)
	{
		print("Trying to acquire photocopy manually", "red");
		visit_url("clan_viplounge.php?preaction=receivefax&whichfloor=2", true);
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


boolean handleRainDoh()
{
	if(get_property("rainDohMonster") == "")
	{
		abort("Rain-doh has no monster so we can't use it");
	}
	return ccAdvBypass("inv_use.php?pwd&which=3&whichitem=5564", $location[Noob Cave]);
}

boolean handleSpookyPutty()
{
	if(get_property("spookyPuttyMonster") == "")
	{
		abort("Spooky Putty has no monster so we can't use it");
	}
	return ccAdvBypass("inv_use.php?pwd&which=3&whichitem=3667", $location[Noob Cave]);
}

boolean handle4dCamera()
{
	if(get_property("_cameraUsed").to_boolean())
	{
		abort("4-D Camera was already used, we don't have another use today");
	}
	return ccAdvBypass("inv_use.php?pwd=&whichitem=4170", $location[Noob Cave]);
}

boolean handleIceSculpture()
{
	if(item_amount($item[Ice Sculpture]) > 0)
	{
		return ccAdvBypass("inv_use.php?pwd=&whichitem=7080", $location[Noob Cave]);
	}
	return false;
}

int maxSealSummons()
{
	if(item_amount($item[Claw of the Infernal Seal]) > 0)
	{
		return 10;
	}
	return 5;
}

boolean handleSealArmored()
{
	if((get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of an armored seal]) > 0) && (item_amount($item[seal-blubber candle]) >= 10))
	{
		return ccAdvBypass("inv_use.php?pwd=&whichitem=3904&checked=1", $location[Noob Cave]);
	}
	else
	{
		abort("Can't use an Armored Seal for some reason");
	}
	return false;
}
boolean handleSealAncient()
{
	if((get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of an ancient seal]) > 0) && (item_amount($item[seal-blubber candle]) >= 3))
	{
		return ccAdvBypass("inv_use.php?pwd=&whichitem=3905&checked=1", $location[Noob Cave]);
	}
	else
	{
		abort("Can't use an Ancient Seal for some reason");
	}
	return false;
}
boolean handleSealElement(element flavor)
{
	string page = "";
	if((flavor == $element[hot]) && (get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of a charred seal]) > 0) && (item_amount($item[imbued seal-blubber candle]) > 0))
	{
		page = "inv_use.php?pwd=&whichitem=3909&checked=1";
	}
	if((flavor == $element[cold]) && (get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of a cold seal]) > 0) && (item_amount($item[imbued seal-blubber candle]) > 0))
	{
		page = "inv_use.php?pwd=&whichitem=3910&checked=1";
	}
	if((flavor == $element[sleaze]) && (get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of a slippery seal]) > 0) && (item_amount($item[imbued seal-blubber candle]) > 0))
	{
		page = "inv_use.php?pwd=&whichitem=3911&checked=1";
	}
	if((flavor == $element[spooky]) && (get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of a shadowy seal]) > 0) && (item_amount($item[imbued seal-blubber candle]) > 0))
	{
		page = "inv_use.php?pwd=&whichitem=3907&checked=1";
	}
	if((flavor == $element[stench]) && (get_property("_sealsSummoned").to_int() < maxSealSummons()) && (item_amount($item[figurine of a stinking seal]) > 0) && (item_amount($item[imbued seal-blubber candle]) > 0))
	{
		page = "inv_use.php?pwd=&whichitem=3908&checked=1";
	}
	return ccAdvBypass(page, $location[Noob Cave]);
}



int towerKeyCount()
{
	int tokens = item_amount($item[fat loot token]);
	if(item_amount($item[boris\'s key]) > 0)
	{
		tokens = tokens + 1;
	}
	if(item_amount($item[jarlsberg\'s key]) > 0)
	{
		tokens = tokens + 1;
	}
	if(item_amount($item[sneaky pete\'s key]) > 0)
	{
		tokens = tokens + 1;
	}
	return tokens;
}

boolean handleBarrelFullOfBarrels()
{
	if(!get_property("barrelShrineUnlocked").to_boolean())
	{
		return false;
	}

	string page = visit_url("barrel.php");

	if(!contains_text(page, "The Barrel Full of Barrels"))
	{
		return false;
	}

	boolean [string] locations;
	int smashed = 0;
	matcher mimic_matcher = create_matcher("<div class=\"ex\">((?:<div class=\"mimic\">!</div>)|)<a class=\"spot\" href=\"choice.php[?]whichchoice=1099[&]pwd=(?:.*?)[&]option=1[&]slot=(\\d\\d)\"><img title=\"(.*?)\"", page);
	while(mimic_matcher.find())
	{
		string mimic = mimic_matcher.group(1);
		string slotID = mimic_matcher.group(2);
		string label = mimic_matcher.group(3);

		if(mimic != "")
		{
			print("Found mimic in slot: " + slotID, "red");
		}
		else if(label == "A barrel")
		{
			smashed = smashed + 1;
			visit_url("choice.php?whichchoice=1099&pwd&option=1&slot=" + slotID);
		}
	}
	return (smashed > 0);
}

boolean use_barrels()
{
	if(!get_property("barrelShrineUnlocked").to_boolean())
	{
		return false;
	}

	boolean [item] barrels = $items[little firkin, normal barrel, big tun, weathered barrel, dusty barrel, disintegrating barrel, moist barrel, rotting barrel, mouldering barrel, barnacled barrel];

	boolean retval = false;
	foreach it in barrels
	{
		retval = retval | (item_amount(it) > 0);
		use(item_amount(it), it);
	}
	return retval;
}

string runChoice(string page_text)
{
	while(contains_text(page_text , "choice.php"))
	{
		## Get choice adventure number
		int begin_choice_adv_num = index_of(page_text , "whichchoice value=") + 18;
		int end_choice_adv_num = index_of(page_text , "><input" , begin_choice_adv_num);
		string choice_adv_num = substring(page_text , begin_choice_adv_num , end_choice_adv_num);

		string choice_adv_prop = "choiceAdventure" + choice_adv_num;
		string choice_num = get_property(choice_adv_prop);
		if(choice_num == "")
		{
			abort("Unsupported Choice Adventure!");
		}

		string url = "choice.php?pwd&whichchoice=" + choice_adv_num + "&option=" + choice_num;
		page_text = visit_url(url);
	}
	return page_text;
}

boolean set_property_ifempty(string setting, string change)
{
	if(get_property(setting) == "")
	{
		set_property(setting, change);
		return true;
	}
	return false;
}

boolean restore_property(string setting, string source)
{
	string data = get_property(source);
	set_property(setting, data);
	set_property(source, "");
	return (data != "");
}

boolean clear_property_if(string setting, string cond)
{
	if(get_property(setting) == cond)
	{
		set_property(setting, "");
		return true;
	}
	return false;
}

int turkeyBooze()
{
	return get_property("_turkeyBooze").to_int();
}

int amountTurkeyBooze()
{
	return item_amount($item[Agitated Turkey]) + item_amount($item[Ambitious Turkey]) + item_amount($item[Friendly Turkey]);
}

int numPirateInsults()
{
	int retval = 0;
	int i = 1;
	while(i <= 8)
	{
		if(get_property("lastPirateInsult"+i) == "true")
		{
			retval = retval + 1;
		}
		i = i + 1;
	}
	return retval;
}


int fastenerCount()
{
	int base = get_property("chasmBridgeProgress").to_int();
	base = base + item_amount($item[Morningwood Plank]);
	base = base + item_amount($item[Raging Hardwood Plank]);
	base = base + item_amount($item[Weirdwood Plank]);

	return base;
}
int lumberCount()
{
	int base = get_property("chasmBridgeProgress").to_int();
	base = base + item_amount($item[Thick Caulk]);
	base = base + item_amount($item[Long Hard Screw]);
	base = base + item_amount($item[Messy Butt Joint]);

	return base;
}

boolean snojoFightAvailable()
{
	if(!get_property("snojoAvailable").to_boolean())
	{
		return false;
	}
	if(get_property("snojoSetting") == "NONE")
	{
		print("Snojo not set, attempting to set to " + my_primestat(), "blue");
		visit_url("place.php?whichplace=snojo&action=snojo_controller");
	}
	return (get_property("_snojoFreeFights").to_int() < 10);
}

int doNumberology(string goal)
{
	return doNumberology(goal, true);
}

int doNumberology(string goal, boolean doIt)
{
	if(!have_skill($skill[Calculate the Universe]))
	{
		return -1;
	}
	if(get_property("_universeCalculated").to_boolean())
	{
		return -1;
	}
	if(my_mp() < 12)
	{
		return -1;
	}
	static int [string] signs;
	signs["Mongoose"] = 1;
	signs["Wallaby"] = 2;
	signs["Vole"] = 3;
	signs["Platypus"] = 4;
	signs["Opossum"] = 5;
	signs["Marmot"] = 6;
	signs["Wombat"] = 7;
	signs["Blender"] = 8;
	signs["Packrat"] = 9;
	signs["Bad Moon"] = 10; #Derp Mode? Derp Mode.

	static string [int] numberwang;
	numberwang[0] = "meat";
	numberwang[1] = "muscle";
	numberwang[2] = "sleepy";
	numberwang[3] = "confused";
	numberwang[4] = "embarrassed";
	numberwang[5] = "far out";
	numberwang[6] = "wings";
	numberwang[7] = "beaten up";
	numberwang[8] = "poisoned";
	numberwang[9] = "perfume";
	numberwang[10] = "steroid";
	numberwang[11] = "inebriety";
	numberwang[12] = "gnoll";
	numberwang[13] = "???";
	numberwang[14] = "moxieweed";
	numberwang[15] = "meat";
	numberwang[16] = "magicalness-in-a-can";
	numberwang[17] = "adventures";
	numberwang[18] = "booze";
	numberwang[19] = "+moxie";
	numberwang[20] = "-moxie";
	numberwang[21] = "fites";
	numberwang[22] = "phone";
	numberwang[23] = "muscle";
	numberwang[27] = "moxie";
	numberwang[30] = "ghuol";
	numberwang[33] = "magicalness-in-a-can";
	numberwang[34] = "+moxie";
	numberwang[35] = "-muscle";
	numberwang[36] = "adventures2";
	numberwang[37] = "fites3";
	numberwang[38] = "+myst";
	numberwang[40] = "meat";
	numberwang[44] = "booze";
	numberwang[48] = "butt";
	numberwang[51] = "battlefield";
	numberwang[58] = "teleportitis";
	numberwang[69] = "adventures3";
	numberwang[75] = "booze";
	numberwang[99] = "booze";

	# seed + ascensions + moonsign * (spleen + level) + turns
	int melancholy = my_spleen_use() + my_level();
	int score = my_adventures() + (melancholy * (my_ascensions() + signs[my_sign()]));

	score = score % 100;
	int i=0;
	while(i < 100)
	{
		int current = (score + (melancholy * i)) % 100;
		if(numberwang[current] == goal)
		{
			print("Found option for Numberology: " + current, "blue");
			if(!doIt)
			{
				return i;
			}
			visit_url("runskillz.php?pwd&action=Skillz&whichskill=144&quantity=1", true);
			visit_url("choice.php?whichchoice=1103&pwd=&option=1&num=" + i);
			return i;
		}
		i = i + 1;
	}
	return -1;
}

boolean haveAny(boolean[item] array)
{
	foreach thing in array
	{
		if(item_amount(thing) > 0)
		{
			return true;
		}
	}
	return false;
}

boolean in_ronin()
{
	return !can_interact();
}


void pullAll(item it)
{
	if(storage_amount(it) > 0)
	{
		take_storage(storage_amount(it), it);
	}
}

void pullAndUse(item it, int uses)
{
	pullAll(it);
	while((item_amount(it) > 0) && (uses > 0))
	{
		use(1, it);
		uses = uses - 1;
	}
}

boolean pullXWhenHaveY(item it, int howMany, int whenHave)
{
	if(in_hardcore())
	{
		return false;
	}
	if(it == $item[none])
	{
		return false;
	}
	if(!is_unrestricted(it) && !get_property("kingLiberated").to_boolean())
	{
		return false;
	}
	if(item_amount(it) == whenHave)
	{
		int lastStorage = storage_amount(it);
		while(storage_amount(it) < howMany)
		{
			int oldPrice = historical_price(it) * 1.2;
			int curPrice = mall_price(it);
			if((curPrice <= oldPrice) && (curPrice < 30000) && (my_storage_meat() >= curPrice))
			{
				buy_using_storage(howMany - storage_amount(it), it, curPrice);
			}
			else
			{
				if(curPrice > oldPrice)
				{
					print("Price of " + it + " may have been mall manipulated. Expected to pay at most: " + oldPrice, "red");
				}
				if(my_storage_meat() < curPrice)
				{
					print("Do not have enough meat in Hagnk's to buy " + it + ". Need " + curPrice + " have " + my_storage_meat() + ".", "blue");
				}
			}
			if(lastStorage == storage_amount(it))
			{
				break;
			}
			lastStorage = storage_amount(it);
		}

		if(storage_amount(it) < howMany)
		{
			print("Can not pull what we don't have. Sorry");
			return false;
		}

		print("Trying to pull " + howMany + " of " + it, "blue");
		boolean retval = take_storage(howMany, it);
		if(item_amount(it) != howMany)
		{
			print("Failed pulling " + howMany + " of " + it, "red");
		}
		return retval;
	}
	return false;
}

//From Bale\'s woods.ash relay script.
void woods_questStart()
{
	if((item_amount($item[continuum transfunctioner]) > 0) || (equipped_amount($item[Continuum Transfunctioner]) > 0))
	{
		return;
	}
	visit_url("place.php?whichplace=woods");
	visit_url("place.php?whichplace=forestvillage&action=fv_mystic");
	visit_url("choice.php?pwd=&whichchoice=664&option=1&choiceform1=Sure%2C+old+man.++Tell+me+all+about+it.");
	visit_url("choice.php?pwd=&whichchoice=664&option=1&choiceform1=Against+my+better+judgment%2C+yes.");
	visit_url("choice.php?pwd=&whichchoice=664&option=1&choiceform1=Er,+sure,+I+guess+so...");
	if(knoll_available())
	{
		visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");
	}
	if(knoll_available())
	{
		visit_url("place.php?whichplace=knoll_friendly&action=dk_innabox");
		visit_url("place.php?whichplace=forestvillage&action=fv_untinker");
	}
}


void pulverizeThing(item it)
{
	if(!have_skill($skill[Pulverize]))
	{
		return;
	}

	if(item_amount(it) == 0)
	{
		if(closet_amount(it) == 0)
		{
			return;
		}
		take_closet(1, it);
	}
	cli_execute("pulverize 1 " + it);
}

boolean buy_item(item it, int quantity, int maxprice)
{
	take_closet(closet_amount(it), it);
	if(get_property("kingLiberated") != "false")
	{
		take_storage(storage_amount(it), it);
	}
	while((item_amount(it) < quantity) && (mall_price(it) < maxprice))
	{
		if(mall_price(it) > my_meat())
		{
			abort("Don't have enough meat to restock, big sad");
		}
		if(buy(1, it, maxprice) == 0)
		{
			print("Price of " + it + " exceeded expected mall price of " + maxprice + ".", "blue");
			return false;
		}
	}
	if(item_amount(it) < quantity)
	{
		if(mall_price(it) >= maxprice)
		{
			print("Price of " + it + " exceeded expected mall price of " + maxprice + ".", "blue");
		}
		return false;
	}
	return true;
}

//Thanks, Rinn!
string beerPong(string page)
{
	record r {
		string insult;
		string retort;
	};

	r [int] insults;
	insults[1].insult="Arrr, the power of me serve'll flay the skin from yer bones!";
	insults[1].retort="Obviously neither your tongue nor your wit is sharp enough for the job.";
	insults[2].insult="Do ye hear that, ye craven blackguard?  It be the sound of yer doom!";
	insults[2].retort="It can't be any worse than the smell of your breath!";
	insults[3].insult="Suck on <i>this</i>, ye miserable, pestilent wretch!";
	insults[3].retort="That reminds me, tell your wife and sister I had a lovely time last night.";
	insults[4].insult="The streets will run red with yer blood when I'm through with ye!";
	insults[4].retort="I'd've thought yellow would be more your color.";
	insults[5].insult="Yer face is as foul as that of a drowned goat!";
	insults[5].retort="I'm not really comfortable being compared to your girlfriend that way.";
	insults[6].insult="When I'm through with ye, ye'll be crying like a little girl!";
	insults[6].retort="It's an honor to learn from such an expert in the field.";
	insults[7].insult="In all my years I've not seen a more loathsome worm than yerself!";
	insults[7].retort="Amazing!  How do you manage to shave without using a mirror?";
	insults[8].insult="Not a single man has faced me and lived to tell the tale!";
	insults[8].retort="It only seems that way because you haven't learned to count to one.";

	while(!page.contains_text("victory laps"))
	{
		string old_page = page;

		if(!page.contains_text("Insult Beer Pong"))
		{
			abort("You don't seem to be playing Insult Beer Pong.");
		}

		if(page.contains_text("Phooey"))
		{
			print("Looks like something went wrong and you lost.", "lime");
			return page;
		}

		foreach i in insults
		{
			if(page.contains_text(insults[i].insult))
			{
				if(page.contains_text(insults[i].retort))
				{
					print("Found appropriate retort for insult.", "lime");
					print("Insult: " + insults[i].insult, "lime");
					print("Retort: " + insults[i].retort, "lime");
					page = visit_url("beerpong.php?value=Retort!&response=" + i);
					break;
				}
				else
				{
					print("Looks like you needed a retort you haven't learned.", "red");
					print("Insult: " + insults[i].insult, "lime");
					print("Retort: " + insults[i].retort, "lime");

					// Give a bad retort
					page = visit_url("beerpong.php?value=Retort!&response=9");
					return page;
				}
			}
		}

		if(page == old_page)
		{
			abort("String not found. There may be an error with one of the insult or retort strings.");
		}
	}

	print("You won a thrilling game of Insult Beer Pong!", "lime");
	return page;
}

boolean useCocoon()
{
	if(!have_skill($skill[Cannelloni Cocoon]))
	{
		return false;
	}
	if(my_hp() < my_maxhp())
	{
		if(my_mp() >= 20)
		{
			use_skill(1, $skill[Cannelloni Cocoon]);
			return true;
		}
		return false;
	}
	return true;
}

int howLongBeforeHoloWristDrop()
{
	int drops = get_property("_holoWristDrops").to_int() + 1;
	int need = (drops * ((drops * 5) + 17)) / 2;
	drops = drops - 1;
	need = need - (drops * ((drops * 5) + 17)) / 2;
	return need - get_property("_holoWristProgress").to_int();
}

boolean hasShieldEquipped()
{
	return item_type(equipped_item($slot[off-hand])) == "shield";
}

boolean beehiveConsider()
{
	if(in_hardcore())
	{
		if(have_skill($skill[Shell Up]) && have_skill($skill[Sauceshell]))
		{
			set_property("cc_getBeehive", false);
		}
		else
		{
			set_property("cc_getBeehive", true);
		}
	}
	else
	{
		if(have_skill($skill[Shell Up]) || have_skill($skill[Sauceshell]))
		{
			set_property("cc_getBeehive", false);
		}
		else
		{
			set_property("cc_getBeehive", true);
		}
	}
	return true;
}


void shrugAT()
{
	int maxSongs = 3;
	if(have_equipped($item[Brimstone Beret]) || have_equipped($item[Operation Patriot Shield]) || have_equipped($item[Plexiglass Pendant]) || have_equipped($item[Scandalously Skimpy Bikini]) || have_equipped($item[Sombrero De Vida]) || have_equipped($item[Super-Sweet Boom Box]))
	{
		maxSongs = 4;
	}

	if(have_equipped($item[La Hebilla del Cintur&oacute;n de Lopez]))
	{
		maxSongs += 1;
	}
	if(have_equipped($item[Zombie Accordion]))
	{
		maxSongs += 1;
	}
	if(have_skill($skill[Mariachi Memory]))
	{
		maxSongs += 1;
	}


	int count = 1;
	#Put these in priority of keeping.
	boolean[effect] songs = $effects[Inigo\'s Incantation of Inspiration, The Ballad of Richie Thingfinder, Chorale of Companionship, Ode to Booze, Ur-Kel\'s Aria of Annoyance, Carlweather\'s Cantata of Confrontation, The Sonata of Sneakiness, Aloysius\' Antiphon of Aptitude, Fat Leon\'s Phat Loot Lyric, Polka of Plenty, Donho\'s Bubbly Ballad, Prelude of Precision, Elron\'s Explosive Etude, Benetton\'s Medley of Diversity, Dirge of Dreadfulness, Stevedave\'s Shanty of Superiority, Psalm of Pointiness, Brawnee\'s Anthem of Absorption, Jackasses\' Symphony of Destruction, Power Ballad of the Arrowsmith, Cletus\'s Canticle of Celerity, Cringle\'s Curative Carol, The Magical Mojomuscular Melody, The Moxious Madrigal];

	foreach song in songs
	{
		if(have_effect(song) > 0)
		{
			count += 1;
			if(count > maxSongs)
			{
				uneffect(song);
			}
		}
	}
}

string cc_my_path()
{
	// This is for handling the situation briefly after a new path is created so that we can
	// attempt to use proper names.
	// Most of the time, it is just a pointless wrapper.
	// This is only needed in mainline files, path specific files have already been supported.
	return my_path();
}

boolean haveSpleenFamiliar()
{
	boolean [familiar] spleenies = $familiars[Baby Sandworm, Rogue Program, Pair of Stomping Boots, Bloovian Groose, Unconscious Collective, Grim Brother, Golden Monkey];

	foreach fam in spleenies
	{
		if(have_familiar(fam))
		{
			return true;
		}
	}
	return false;
}

int [item] cc_get_campground()
{
	int [item] campItems = get_campground();

	if(campItems contains $item[Ice Harvest])
	{
		campItems[$item[packet of winter seeds]] = 1;
	}
	if(campItems contains $item[Frost Flower])
	{
		campItems[$item[packet of winter seeds]] = 1;
	}
	if(campItems contains $item[handful of barley])
	{
		campItems[$item[packet of beer seeds]] = 1;
	}
	if(campItems contains $item[fancy beer label])
	{
		campItems[$item[packet of beer seeds]] = 1;
	}
	if(campItems contains $item[skeleton])
	{
		campItems[$item[packet of dragon\'s teeth]] = 1;
	}
	if(campItems contains $item[giant candy cane])
	{
		campItems[$item[Peppermint Pip Packet]] = 1;
	}
	if(campItems contains $item[peppermint sprout])
	{
		campItems[$item[Peppermint Pip Packet]] = 1;
	}
	if(campItems contains $item[ginormous pumpkin])
	{
		campItems[$item[packet of pumpkin seeds]] = 1;
	}
	if(campItems contains $item[huge pumpkin])
	{
		campItems[$item[packet of pumpkin seeds]] = 1;
	}
	if(campItems contains $item[pumpkin])
	{
		campItems[$item[packet of pumpkin seeds]] = 1;
	}

	if(!(campItems contains $item[Dramatic&trade; range]) && get_property("cc_haveoven").to_boolean())
	{
		campItems[$item[Dramatic&trade; range]] = 1;
	}

	return campItems;
}

//Thanks, Rinn!
string tryBeerPong()
{
	string page = visit_url("adventure.php?snarfblat=157");
	if(contains_text(page, "Arrr You Man Enough?"))
	{
		page = beerPong(visit_url("choice.php?pwd&whichchoice=187&option=1"));
	}
	return page;
}

boolean buyUpTo(int num, item it)
{
	return buyUpTo(num, it, 20000);
}

boolean buyUpTo(int num, item it, int maxprice)
{
	num = num - item_amount(it);
	if(num > 0)
	{
		buy(num, it, maxprice);
	}
	return (item_amount(it) == num);
}

boolean buffMaintain(skill source, effect buff, int mp_min, int casts, int turns)
{
	if((!have_skill(source)) || (have_effect(buff) >= turns))
	{
		return false;
	}

	if((my_mp() < mp_min) || (my_mp() < (casts * mp_cost(source))))
	{
		return false;
	}
	if(my_adventures() < (casts * adv_cost(source)))
	{
		return false;
	}
	if(my_lightning() < (casts * lightning_cost(source)))
	{
		return false;
	}
	if(my_rain() < (casts * rain_cost(source)))
	{
		return false;
	}
	if(my_soulsauce() < (casts * soulsauce_cost(source)))
	{
		return false;
	}
	if(my_thunder() < (casts * thunder_cost(source)))
	{
		return false;
	}
	use_skill(casts, source);
	return true;
}

boolean buffMaintain(item source, effect buff, int uses, int turns)
{
	if(have_effect(buff) >= turns)
	{
		return false;
	}
	if(item_amount(source) < uses)
	{
		buy(uses - item_amount(source), source, 1000);
	}
	if(item_amount(source) < uses)
	{
		return false;
	}
	use(uses, source);
	return true;
}

boolean buffMaintain(effect buff, int mp_min, int casts, int turns)
{
	skill useSkill = $skill[none];
	item useItem = $item[Instant Karma];

	if(buff == $effect[none])
	{
		return false;
	}

	switch(buff)
	{
	#Jalapeno Saucesphere
	case $effect[A Few Extra Pounds]:			useSkill = $skill[Holiday Weight Gain];			break;
	case $effect[A Little Bit Poisoned]:		useSkill = $skill[Disco Nap];					break;
	case $effect[Adorable Lookout]:				useItem = $item[Giraffe-Necked Turtle];			break;
	case $effect[All Fired Up]:					useItem = $item[Ant Agonist];					break;
	case $effect[All Glory To The Toad]:		useItem = $item[Colorful Toad];					break;
	case $effect[Aloysius\' Antiphon of Aptitude]:useSkill = $skill[Aloysius\' Antiphon of Aptitude];break;
	case $effect[Amazing]:						useItem = $item[Pocket Maze];					break;
	case $effect[Antibiotic Saucesphere]:		useSkill = $skill[Antibiotic Saucesphere];		break;
	case $effect[Arched Eyebrow of the Archmage]:useSkill = $skill[Arched Eyebrow of the Archmage];break;
	case $effect[Armor-Plated]:					useItem = $item[Bent Scrap Metal];				break;
	case $effect[Ashen Burps]:					useItem = $item[ash soda];						break;
	case $effect[Astral Shell]:					useSkill = $skill[Astral Shell];				break;
	case $effect[Balls of Ectoplasm]:			useItem = $item[Ectoplasmic Orbs];				break;
	case $effect[Big Meat Big Prizes]:			useItem = $item[Meat-Inflating Powder];			break;
	case $effect[Biologically Shocked]:			useItem = $item[glowing syringe];				break;
	case $effect[Bitterskin]:					useItem = $item[Bitter Pill];					break;
	case $effect[Black Eyes]:					useItem = $item[Black Eye Shadow];				break;
	case $effect[Blessing of Serqet]:			useSkill = $skill[Blessing of Serqet];			break;
	case $effect[Bloody Potato Bits]:			useSkill = $skill[none];						break;
	case $effect[Bloodstain-Resistant]:			useItem = $item[Bloodstain Stick];				break;
	case $effect[Blubbered Up]:					useSkill = $skill[Blubber Up];					break;
	case $effect[Blue Swayed]:					useItem = $item[Pulled Blue Taffy];				break;
	case $effect[Boon of She-Who-Was]:			useSkill = $skill[Spirit Boon];					break;
	case $effect[Boon of the Storm Tortoise]:	useSkill = $skill[Spirit Boon];					break;
	case $effect[Boon of the War Snapper]:		useSkill = $skill[Spirit Boon];					break;
	case $effect[Bounty of Renenutet]:			useSkill = $skill[Bounty of Renenutet];			break;
	case $effect[Brawnee\'s Anthem of Absorption]:useSkill = $skill[Brawnee\'s Anthem of Absorption];break;
	case $effect[Brilliant Resolve]:			useItem = $item[Resolution: Be Smarter];		break;
	case $effect[Browbeaten]:					useItem = $item[Old Eyebrow Pencil];			break;
	case $effect[Busy Bein\' Delicious]:		useItem = $item[Crimbo fudge];					break;
	case $effect[Butt-Rock Hair]:				useItem = $item[Hair Spray];					break;
	case $effect[Carlweather\'s Cantata of Confrontation]:useSkill = $skill[Carlweather\'s Cantata of Confrontation];break;
	case $effect[Celestial Camouflage]:			useItem = $item[Celestial Squid Ink];			break;
	case $effect[Celestial Saltiness]:			useItem = $item[Celestial Au Jus];				break;
	case $effect[Celestial Sheen]:				useItem = $item[Celestial Olive Oil];			break;
	case $effect[Cinnamon Challenger]:			useItem = $item[Pulled Red Taffy];				break;
	case $effect[Cletus\'s Canticle of Celerity]:	useSkill = $skill[Cletus\'s Canticle of Celerity];break;
	case $effect[Clyde\'s Blessing]:			useItem = $item[The Legendary Beat];			break;
	case $effect[Chalky Hand]:					useItem = $item[Handful of Hand Chalk];			break;
	case $effect[Cranberry Cordiality]:			useItem = $item[Cranberry Cordial];				break;
	case $effect[Cold Hard Skin]:				useItem = $item[Frost-Rimed Seal Hide];			break;
	case $effect[Contemptible Emanations]:		useItem = $item[Cologne of Contempt];			break;
	case $effect[The Cupcake of Wrath]:			useItem = $item[Green-Frosted Astral Cupcake];	break;
	case $effect[Curiosity of Br\'er Tarrypin]:	useSkill = $skill[Curiosity of Br\'er Tarrypin];break;
	case $effect[Dance of the Sugar Fairy]:		useItem = $item[Sugar Fairy];					break;
	case $effect[Destructive Resolve]:			useItem = $item[Resolution: Be Feistier];		break;
	case $effect[Dexteri Tea]:					useItem = $item[cuppa Dexteri tea];				break;
	case $effect[Digitally Converted]:			useItem = $item[Digital Underground Potion];	break;
	case $effect[The Dinsey Look]:				useItem = $item[Dinsey Face Paint];				break;
	case $effect[Dirge of Dreadfulness]:		useSkill = $skill[Dirge of Dreadfulness];		break;
	case $effect[Disco Fever]:					useSkill = $skill[Disco Fever];					break;
	case $effect[Disco Leer]:					useSkill = $skill[Disco Leer];					break;
	case $effect[Disco Smirk]:					useSkill = $skill[Disco Smirk];					break;
	case $effect[Disco State of Mind]:			useSkill = $skill[Disco Aerobics];				break;
	case $effect[Disdain of She-Who-Was]:		useSkill = $skill[Blessing of She-Who-Was];		break;
	case $effect[Disdain of the Storm Tortoise]:useSkill = $skill[Blessing of the Storm Tortoise];break;
	case $effect[Disdain of the War Snapper]:	useSkill = $skill[Blessing of the War Snapper];	break;
	case $effect[Drenched With Filth]:			useItem = $item[Concentrated Garbage Juice];	break;
	case $effect[Drescher\'s Annoying Noise]:	useSkill = $skill[Drescher\'s Annoying Noise];	break;
	case $effect[Eau D\'enmity]:				useItem = $item[Perfume of Prejudice];			break;
	case $effect[Eau de Tortue]:				useItem = $item[Turtle Pheromones];				break;
	case $effect[Elemental Saucesphere]:		useSkill = $skill[Elemental Saucesphere];		break;
	case $effect[Empathy]:						useSkill = $skill[Empathy of the Newt];			break;
	case $effect[Erudite]:						useItem = $item[Black Sheepskin Diploma];		break;
	case $effect[Expert Oiliness]:				useItem = $item[Oil of Expertise];				break;
	case $effect[Experimental Effect G-9]:		useItem = $item[Experimental Serum G-9];		break;
	case $effect[Extra Backbone]:				useItem = $item[Really Thick Spine];			break;
	case $effect[Extreme Muscle Relaxation]:	useItem = $item[Mick\'s IcyVapoHotness Rub];	break;
	case $effect[Everything Must Go!]:			useItem = $item[Violent Pastilles];				break;
	case $effect[Eyes All Black]:				useItem = $item[Delicious Candy];				break;
	case $effect[Far Out]:						useItem = $item[Patchouli Incense Stick];		break;
	case $effect[Fat Leon\'s Phat Loot Lyric]:	useSkill = $skill[Fat Leon\'s Phat Loot Lyric];	break;
	case $effect[Feroci Tea]:					useItem = $item[cuppa Feroci tea];				break;
	case $effect[Fire Inside]:					useItem = $item[Hot Coal];						break;
	case $effect[Fishy\, Oily]:					useItem = $item[Gourmet Gourami Oil];			break;
	case $effect[Fishy Fortification]:			useItem = $item[Fish-Liver Oil];				break;
	case $effect[Fishy Whiskers]:				useItem = $item[Catfish Whiskers];				break;
	case $effect[Flame-Retardant Trousers]:		useItem = $item[Hot Powder];					break;
	case $effect[Flamibili Tea]:				useItem = $item[cuppa Flamibili Tea];			break;
	case $effect[Flexibili Tea]:				useItem = $item[cuppa Flexibili Tea];			break;
	case $effect[Flimsy Shield of the Pastalord]:useSkill = $skill[Shield of the Pastalord];	break;
	case $effect[Florid Cheeks]:				useItem = $item[Henna Face Paint];				break;
	case $effect[Football Eyes]:				useItem = $item[Black Facepaint];				break;
	case $effect[Fortunate Resolve]:			useItem = $item[Resolution: Be Luckier];		break;
	case $effect[Frigidalmatian]:				useSkill = $skill[Frigidalmatian];				break;
	case $effect[Frog in Your Throat]:			useItem = $item[Frogade];						break;
	case $effect[From Nantucket]:				useItem = $item[Ye Olde Bawdy Limerick];		break;
	case $effect[Frost Tea]:					useItem = $item[cuppa Frost tea];				break;
	case $effect[Frostbeard]:					useSkill = $skill[Beardfreeze];					break;
	case $effect[Frosty]:						useItem = $item[Frost Flower];					break;
	case $effect[Gelded]:						useItem = $item[Chocolate Filthy Lucre];		break;
	case $effect[Ghostly Shell]:				useSkill = $skill[Ghostly Shell];				break;
	case $effect[The Glistening]:				useItem = $item[Vial of the Glistening];		break;
	case $effect[Glittering Eyelashes]:			useItem = $item[Glittery Mascara];				break;
	case $effect[Go Get \'Em\, Tiger!]:			useItem = $item[Ben-gal&trade; Balm];			break;
	case $effect[Got Milk]:						useItem = $item[Milk of Magnesium];				break;
	case $effect[Gr8tness]:						useItem = $item[Potion of Temporary Gr8tness];	break;
	case $effect[Greedy Resolve]:				useItem = $item[Resolution: Be Wealthier];		break;
	case $effect[Gummi-Grin]:					useItem = $item[Gummi Turtle];					break;
	case $effect[Hairy Palms]:					useItem = $item[Orcish Hand Lotion];			break;
	case $effect[Ham-Fisted]:					useItem = $item[Vial of Hamethyst Juice];		break;
	case $effect[Hardened Fabric]:				useItem = $item[Fabric Hardener];				break;
	case $effect[Hardly Poisoned At All]:		useSkill = $skill[Disco Nap];					break;
	case $effect[Healthy Blue Glow]:			useItem = $item[gold star];						break;
	case $effect[Heightened Senses]:			useItem = $item[airborne mutagen];				break;
	case $effect[Hide of Sobek]:				useSkill = $skill[Hide of Sobek];				break;
	case $effect[High Colognic]:				useItem = $item[Musk Turtle];					break;
	case $effect[Hippy Stench]:					useItem = $item[reodorant];						break;
	case $effect[How to Scam Tourists]:			useItem = $item[How to Avoid Scams];			break;
	case $effect[Human-Beast Hybrid]:			useItem = $item[Gene Tonic: Beast];				break;
	case $effect[Human-Constellation Hybrid]:	useItem = $item[Gene Tonic: Constellation];		break;
	case $effect[Human-Demon Hybrid]:			useItem = $item[Gene Tonic: Demon];				break;
	case $effect[Human-Elemental Hybrid]:		useItem = $item[Gene Tonic: Elemental];			break;
	case $effect[Human-Fish Hybrid]:			useItem = $item[Gene Tonic: Fish];				break;
	case $effect[Human-Human Hybrid]:			useItem = $item[Gene Tonic: Dude];				break;
	case $effect[Human-Humanoid Hybrid]:		useItem = $item[Gene Tonic: Humanoid];			break;
	case $effect[Human-Machine Hybrid]:			useItem = $item[Gene Tonic: Construct];			break;
	case $effect[Human-Mer-kin Hybrid]:			useItem = $item[Gene Tonic: Mer-kin];			break;
	case $effect[Human-Pirate Hybrid]:			useItem = $item[Gene Tonic: Pirate];			break;
	case $effect[Hyphemariffic]:				useItem = $item[Black Eyedrops];				break;
	case $effect[Icy Glare]:					useSkill = $skill[Icy Glare];					break;
	case $effect[Industrial Strength Starch]:	useItem = $item[Industrial Strength Starch];	break;
	case $effect[Insulated Trousers]:			useItem = $item[Cold Powder];					break;
	case $effect[Intimidating Mien]:			useSkill = $skill[Intimidating Mien];			break;
	case $effect[Irresistible Resolve]:			useItem = $item[Resolution: Be Sexier];			break;
	case $effect[Jackasses\' Symphony of Destruction]:useSkill = $skill[Jackasses\' Symphony of Destruction];	break;
	case $effect[Jalape&ntilde;o Saucesphere]:	useSkill = $skill[Jalape&ntilde;o Saucesphere];	break;
	case $effect[Jingle Jangle Jingle]:			useSkill = $skill[Jingle Bells];				break;
	case $effect[Joyful Resolve]:				useItem = $item[Resolution: Be Happier];		break;
	case $effect[Juiced and Jacked]:			useItem = $item[Pumpkin Juice];					break;
	case $effect[Leash of Linguini]:			useSkill = $skill[Leash of Linguini];			break;
	case $effect[Liquidy Smoky]:				useItem = $item[Liquid Smoke];					break;
	case $effect[Lit Up]:						useItem = $item[Bottle of Lighter Fluid];		break;
	case $effect[Litterbug]:					useItem = $item[Old Candy Wrapper];				break;
	case $effect[Locks Like the Raven]:			useItem = $item[Black No. 2];					break;
	case $effect[Loyal Tea]:					useItem = $item[cuppa Loyal Tea];				break;
	case $effect[Lycanthropy\, Eh?]:			useItem = $item[Weremoose Spit];				break;
	case $effect[Kindly Resolve]:				useItem = $item[Resolution: Be Kinder];			break;
	case $effect[Knob Goblin Perfume]:			useItem = $item[Knob Goblin Perfume];			break;
	case $effect[Knowing Smile]:				useSkill = $skill[Knowing Smile];				break;
	case $effect[Macaroni Coating]:				useSkill = $skill[none];						break;
	case $effect[The Magical Mojomuscular Melody]:useSkill = $skill[The Magical Mojomuscular Melody];break;
	case $effect[Majorly Poisoned]:				useSkill = $skill[Disco Nap];					break;
	case $effect[Manbait]:						useItem = $item[The Most Dangerous Bait];		break;
	case $effect[Mariachi Mood]:				useSkill = $skill[Moxie of the Mariachi];		break;
	case $effect[Mathematically Precise]:		useSkill = $skill[Mathematical Precision];		break;
	case $effect[Mayeaugh]:						useItem = $item[Glob of Spoiled Mayo];			break;
	case $effect[Memories of Puppy Love]:		useItem = $item[Old Love Note];					break;
	case $effect[Merry Smithsness]:				useItem = $item[Flaskfull of Hollow];			break;
	case $effect[The Moxious Madrigal]:			useSkill = $skill[The Moxious Madrigal];		break;
	case $effect[Musk of the Moose]:			useSkill = $skill[Musk of the Moose];			break;
	case $effect[Mysteriously Handsome]:		useItem = $item[Handsomeness Potion];			break;
	case $effect[Mystically Oiled]:				useItem = $item[Ointment of the Occult];		break;
	case $effect[Nearly All-Natural]:			useItem = $item[bag of grain];					break;
	case $effect[Neuroplastici Tea]:			useItem = $item[cuppa Neuroplastici tea];		break;
	case $effect[Neutered Nostrils]:			useItem = $item[Polysniff Perfume];				break;
	case $effect[Newt Gets In Your Eyes]:		useItem = $item[eyedrops of newt];				break;
	case $effect[Nigh-Invincible]:				useItem = $item[pixel star];					break;
	case $effect[Notably Lovely]:				useItem = $item[Confiscated Love Note];			break;
	case $effect[Obscuri Tea]:					useItem = $item[cuppa Obscuri tea];				break;
	case $effect[Ode to Booze]:					useSkill = $skill[The Ode to Booze];			break;
	case $effect[Oiled-Up]:						useItem = $item[Pec Oil];						break;
	case $effect[OMG WTF]:						useItem = $item[Confiscated Cell Phone];		break;
	case $effect[One Very Clear Eye]:			useItem = $item[Cyclops Eyedrops];				break;
	case $effect[Orange Crusher]:				useItem = $item[Pulled Orange Taffy];			break;
	case $effect[Pasta Eyeball]:				useSkill = $skill[none];						break;
	case $effect[Pasta Oneness]:				useSkill = $skill[Manicotti Meditation];		break;
	case $effect[Patience of the Tortoise]:		useSkill = $skill[Patience of the Tortoise];	break;
	case $effect[Patient Smile]:				useSkill = $skill[Patient Smile];				break;
	case $effect[Penne Fedora]:					useSkill = $skill[none];						break;
	case $effect[Peppermint Bite]:				useItem = $item[Crimbo Peppermint Bark];		break;
	case $effect[Peppermint Twisted]:			useItem = $item[Peppermint Twist];				break;
	case $effect[Perceptive Pressure]:			useItem = $item[Pressurized Potion of Perception];	break;
	case $effect[Perspicacious Pressure]:		useItem = $item[Pressurized Potion of Perspicacity];break;
	case $effect[Phorcefullness]:				useItem = $item[Philter of Phorce];				break;
	case $effect[Physicali Tea]:				useItem = $item[cuppa Physicali tea];			break;
	case $effect[Pill Power]:
		if(item_amount($item[miniature power pill]) > 0)
		{
			useItem = $item[miniature power pill];
		}
		else
		{
			useItem = $item[power pill];
		}																						break;
	case $effect[Pill Party!]:					useItem = $item[Pill Cup];						break;
	case $effect[Pisces in the Skyces]:			useItem = $item[tobiko marble soda];			break;
	case $effect[Prayer of Seshat]:				useSkill = $skill[Prayer of Seshat];			break;
	case $effect[Pride of the Puffin]:			useSkill = $skill[Pride of the Puffin];			break;
	case $effect[Polar Express]:				useItem = $item[Cloaca Cola Polar];				break;
	case $effect[Polka of Plenty]:				useSkill = $skill[The Polka of Plenty];			break;
	case $effect[Polonoia]:						useItem = $item[Polo Trophy];					break;
	case $effect[Power Ballad of the Arrowsmith]:useSkill = $skill[The Power Ballad of the Arrowsmith];break;
	case $effect[Power of Heka]:				useSkill = $skill[Power of Heka];				break;
	case $effect[Protection from Bad Stuff]:	useItem = $item[scroll of Protection from Bad Stuff];break;
	case $effect[Puddingskin]:					useItem = $item[scroll of Puddingskin];			break;
	case $effect[Pulchritudinous Pressure]:		useItem = $item[Pressurized Potion of Pulchritude];break;
	case $effect[Purity of Spirit]:				useItem = $item[cold-filtered water];			break;
	case $effect[Purr of the Feline]:			useSkill = $skill[Purr of the Feline];			break;
	case $effect[Purple Reign]:					useItem = $item[Pulled Violet Taffy];			break;
	case $effect[Puzzle Fury]:					useItem = $item[37x37x37 puzzle cube];			break;
	case $effect[Pyromania]:					useSkill = $skill[Pyromania];					break;
	case $effect[\'Roids of the Rhinoceros]:	useItem = $item[Bottle of Rhinoceros Hormones];	break;
	case $effect[Radiating Black Body&trade;]:	useItem = $item[Black Body&trade; Spray];		break;
	case $effect[Rage of the Reindeer]:			useSkill = $skill[Rage of the Reindeer];		break;
	case $effect[Rainy Soul Miasma]:
		if(item_amount($item[Thin Black Candle]) > 0)
		{
			useItem = $item[Thin Black Candle];
		}
		else if(item_amount($item[Drizzlers&trade; Black Licorice]) > 0)
		{
			useItem = $item[Drizzlers&trade; Black Licorice];
		}																						break;
	case $effect[Really Quite Poisoned]:		useSkill = $skill[Disco Nap];					break;
	case $effect[Red Lettered]:					useItem = $item[Red Letter];					break;
	case $effect[Red Door Syndrome]:			useItem = $item[Can of Black Paint];			break;
	case $effect[Reptilian Fortitude]:			useSkill = $skill[Reptilian Fortitude];			break;
	case $effect[A Rose by Any Other Material]:	useItem = $item[Squeaky Toy Rose];				break;
	case $effect[Rosewater Mark]:				useItem = $item[Old Rosewater Cream];			break;
	case $effect[Rotten Memories]:				useSkill = $skill[Rotten Memories];				break;
	case $effect[Ruthlessly Efficient]:			useSkill = $skill[Ruthless Efficiency];			break;
	case $effect[Salamander in Your Stomach]:	useItem = $item[Salamander Slurry];				break;
	case $effect[Saucemastery]:					useSkill = $skill[Sauce Contemplation];			break;
	case $effect[Sauce Monocle]:				useSkill = $skill[Sauce Monocle];				break;
	case $effect[Savage Beast Inside]:			useItem = $item[jar of &quot;Creole Lady&quot; marrrmalade];break;
	case $effect[Scarysauce]:					useSkill = $skill[Scarysauce];					break;
	case $effect[Scowl of the Auk]:				useSkill = $skill[Scowl of the Auk];			break;
	case $effect[Seal Clubbing Frenzy]:			useSkill = $skill[Seal Clubbing Frenzy];		break;
	case $effect[Sealed Brain]:					useItem = $item[Seal-Brain Elixir];				break;
	case $effect[Seeing Colors]:				useItem = $item[Funky Dried Mushroom];			break;
	case $effect[Sepia Tan]:					useItem = $item[Old Bronzer];					break;
	case $effect[Serendipi Tea]:				useItem = $item[cuppa Serendipi tea];			break;
	case $effect[Seriously Mutated]:			useItem = $item[Extra-Potent Gremlin Mutagen];	break;
	case $effect[Shield of the Pastalord]:		useSkill = $skill[Shield of the Pastalord];		break;
	case $effect[Shelter of Shed]:				useSkill = $skill[Shelter of Shed];				break;
	case $effect[Simmering]:					useSkill = $skill[Simmer];						break;
	case $effect[Simply Irresistible]:			useItem = $item[Irresistibility Potion];		break;
	case $effect[Singer\'s Faithful Ocelot]:	useSkill = $skill[Singer\'s Faithful Ocelot];	break;
	case $effect[Sinuses For Miles]:			useItem = $item[Mick\'s IcyVapoHotness Inhaler];break;
	case $effect[Sleaze-Resistant Trousers]:	useItem = $item[Sleaze Powder];					break;
	case $effect[Sleazy Hands]:					useItem = $item[Lotion of Sleaziness];			break;
	case $effect[Slightly Larger Than Usual]:	useItem = $item[Giant Giant Moth Dust];			break;
	case $effect[Slinking Noodle Glob]:			useSkill = $skill[none];						break;
	case $effect[Smelly Pants]:					useItem = $item[Stench Powder];					break;
	case $effect[Smooth Movements]:				useSkill = $skill[Smooth Movement];				break;
	case $effect[Snarl of the Timberwolf]:		useSkill = $skill[Snarl of the Timberwolf];		break;
	case $effect[Snow Shoes]:					useItem = $item[Snow Cleats];					break;
	case $effect[Somewhat Poisoned]:			useSkill = $skill[Disco Nap];					break;
	case $effect[Song of Bravado]:				useSkill = $skill[Song of Bravado];				break;
	case $effect[Song of the North]:			useSkill = $skill[Song of the North];			break;
	case $effect[Song of Sauce]:				useSkill = $skill[Song of Sauce];				break;
	case $effect[Song of Slowness]:				useSkill = $skill[Song of Slowness];			break;
	case $effect[Song of Starch]:				useSkill = $skill[Song of Starch];				break;
	case $effect[The Sonata of Sneakiness]:		useSkill = $skill[The Sonata of Sneakiness];	break;
	case $effect[Soulerskates]:					useSkill = $skill[Soul Rotation];				break;
	case $effect[Sour Softshoe]:				useItem = $item[pulled yellow taffy];			break;
	case $effect[Spice Haze]:					useSkill = $skill[Bind Spice Ghost];			break;
	case $effect[Spiky Hair]:					useItem = $item[Super-Spiky Hair Gel];			break;
	case $effect[Spiky Shell]:					useSkill = $skill[Spiky Shell];					break;
	case $effect[Spiritually Awake]:			useItem = $item[Holy Spring Water];				break;
	case $effect[Spiritually Aware]:			useItem = $item[Spirit Beer];					break;
	case $effect[Spiritually Awash]:			useItem = $item[Sacramental Wine];				break;
	case $effect[Spooky Hands]:					useItem = $item[Lotion of Spookiness];			break;
	case $effect[Spookypants]:					useItem = $item[Spooky Powder];					break;
	case $effect[Springy Fusilli]:				useSkill = $skill[Springy Fusilli];				break;
	case $effect[Squatting and Thrusting]:		useItem = $item[Squat-Thrust Magazine];			break;
	case $effect[Stabilizing Oiliness]:			useItem = $item[Oil of Stability];				break;
	case $effect[Steroid Boost]:				useItem = $item[Knob Goblin Steroids];			break;
	case $effect[Stevedave\'s Shanty of Superiority]:useSkill = $skill[Stevedave\'s Shanty of Superiority];			break;
	case $effect[Stickler for Promptness]:		useItem = $item[Potion of Punctual Companionship];	break;
	case $effect[Stinky Hands]:					useItem = $item[Lotion of Stench];				break;
	case $effect[Stone-Faced]:					useItem = $item[Stone Wool];					break;
	case $effect[Strong Grip]:					useItem = $item[Finger Exerciser];				break;
	case $effect[Strong Resolve]:				useItem = $item[Resolution: Be Stronger];		break;
	case $effect[Sugar Rush]:
		foreach it in $items[Breath Mint, Tasty Fun Good Rice Candy, That Gum You Like, Angry Farmer Candy]
		{
			if(item_amount(it) > 0)
			{
				useItem = it;
			}
		}																						break;
	case $effect[Superheroic]:					useItem = $item[Confiscated Comic Book];		break;
	case $effect[Superhuman Sarcasm]:			useItem = $item[Serum of Sarcasm];				break;
	case $effect[Suspicious Gaze]:				useSkill = $skill[Suspicious Gaze];				break;
	case $effect[Sweet\, Nuts]:					useItem = $item[Crimbo Candied Pecan];			break;
	case $effect[Takin\' It Greasy]:			useSkill = $skill[Grease Up];					break;
	case $effect[Taunt of Horus]:				useItem = $item[Talisman of Horus];				break;
	case $effect[Temporary Lycanthropy]:		useItem = $item[Blood of the Wereseal];			break;
	case $effect[Tenacity of the Snapper]:		useSkill = $skill[Tenacity of the Snapper];		break;
	case $effect[There is a Spoon]:				useItem = $item[Dented Spoon];					break;
	case $effect[Throwing Some Shade]:			useItem = $item[Shady Shades];					break;
	case $effect[Ticking Clock]:				useItem = $item[Cheap wind-up Clock];			break;
	case $effect[Toad in the Hole]:				useItem = $item[Anti-anti-antidote];			break;
	case $effect[Tomato Power]:					useItem = $item[Tomato Juice of Powerful Power];break;
	case $effect[Tortious]:						useItem = $item[Mocking Turtle];				break;
	case $effect[Truly Gritty]:					useItem = $item[True Grit];						break;
	case $effect[Twen Tea]:						useItem = $item[cuppa Twen tea];				break;
	case $effect[Ur-Kel\'s Aria of Annoyance]:	useSkill = $skill[Ur-Kel\'s Aria of Annoyance];	break;
	case $effect[Using Protection]:				useItem = $item[Orcish Rubber];					break;
	case $effect[Vitali Tea]:					useItem = $item[cuppa Vitali tea];				break;
	case $effect[Walberg\'s Dim Bulb]:			useSkill = $skill[Walberg\'s Dim Bulb];			break;
	case $effect[WAKKA WAKKA WAKKA]:			useItem = $item[Yellow Pixel Potion];			break;
	case $effect[Wasabi Sinuses]:				useItem = $item[Knob Goblin Nasal Spray];		break;
	case $effect[Wasabi With You]:				useItem = $item[Wasabi Marble Soda];			break;
	case $effect[Well-Oiled]:					useItem = $item[Oil of Parrrlay];				break;
	case $effect[Well-Swabbed Ear]:				useItem = $item[Swabbie&trade; Swab];			break;
	case $effect[Wet and Greedy]:				useItem = $item[Goblin Water];					break;
	case $effect[Whispering Strands]:			useSkill = $skill[none];						break;
	case $effect[Wisdom of Thoth]:				useSkill = $skill[Wisdom of Thoth];				break;
	case $effect[Wit Tea]:						useItem = $item[cuppa Wit tea];					break;
	case $effect[Woad Warrior]:					useItem = $item[Pygmy Pygment];					break;
	case $effect[Wry Smile]:					useSkill = $skill[Wry Smile];					break;
	case $effect[Yoloswagyoloswag]:				useItem = $item[Yolo&trade; Chocolates];		break;
	case $effect[You Read the Manual]:			useItem = $item[O\'Rly Manual];					break;
	default: abort("Effect (" + buff + ") is not known to us. Beep.");							break;
	}

	if(my_class() != $class[Pastamancer])
	{
		switch(buff)
		{
		case $effect[Bloody Potato Bits]:		useSkill = $skill[Bind Vampieroghi];			break;
		case $effect[Macaroni Coating]:			useSkill = $skill[Bind Undead Elbow Macaroni];	break;
		case $effect[Pasta Eyeball]:			useSkill = $skill[Bind Lasagmbie];				break;
		case $effect[Penne Fedora]:				useSkill = $skill[Bind Penne Dreadful];			break;
		case $effect[Slinking Noodle Glob]:		useSkill = $skill[Bind Vermincelli];			break;
		case $effect[Spice Haze]:				useSkill = $skill[Bind Spice Ghost];			break;
		case $effect[Whispering Strands]:		useSkill = $skill[Bind Angel Hair Wisp];		break;
		}
	}

	if(my_class() == $class[Turtle Tamer])
	{
		switch(buff)
		{
		case $effect[Boon of the War Snapper]:
			useSkill = $skill[Spirit Boon];
			if((have_effect($effect[Glorious Blessing of the War Snapper]) == 0) && (have_effect($effect[Grand Blessing of the War Snapper]) == 0) && (have_effect($effect[Blessing of the War Snapper]) == 0))
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Boon of She-Who-Was]:
			useSkill = $skill[Spirit Boon];
			if((have_effect($effect[Glorious Blessing of She-Who-Was]) == 0) && (have_effect($effect[Grand Blessing of She-Who-Was]) == 0) && (have_effect($effect[Blessing of She-Who-Was]) == 0))
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Boon of the Storm Tortoise]:
			useSkill = $skill[Spirit Boon];
			if((have_effect($effect[Glorious Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Grand Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Blessing of the Storm Tortoise]) == 0))
			{
				useSkill = $skill[none];
			}
			break;

		case $effect[Disdain of the War Snapper]:
			useSkill = $skill[none];
			if((have_effect($effect[Glorious Blessing of the War Snapper]) == 0) && (have_effect($effect[Grand Blessing of the War Snapper]) == 0) && (have_effect($effect[Blessing of the War Snapper]) == 0))
			{
				useSkill = $skill[Blessing of the War Snapper];
			}
			if((have_effect($effect[Glorious Blessing of the Storm Tortoise]) != 0) || (have_effect($effect[Grand Blessing of the Storm Tortoise]) != 0) || (have_effect($effect[Blessing of the Storm Tortoise]) != 0))
			{
				useSkill = $skill[none];
			}
			if((have_effect($effect[Glorious Blessing of She-Who-Was]) != 0) || (have_effect($effect[Grand Blessing of She-Who-Was]) != 0) || (have_effect($effect[Blessing of She-Who-Was]) != 0))
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Disdain of She-Who-Was]:
			useSkill = $skill[none];
			if((have_effect($effect[Glorious Blessing of She-Who-Was]) == 0) && (have_effect($effect[Grand Blessing of She-Who-Was]) == 0) && (have_effect($effect[Blessing of She-Who-Was]) == 0))
			{
				useSkill = $skill[Blessing of She-Who-Was];
			}
			if((have_effect($effect[Glorious Blessing of the Storm Tortoise]) != 0) || (have_effect($effect[Grand Blessing of the Storm Tortoise]) != 0) || (have_effect($effect[Blessing of the Storm Tortoise]) != 0))
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Disdain of the Storm Tortoise]:
			useSkill = $skill[none];
			if((have_effect($effect[Glorious Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Grand Blessing of the Storm Tortoise]) == 0) && (have_effect($effect[Blessing of the Storm Tortoise]) == 0))
			{
				useSkill = $skill[Blessing of the Storm Tortoise];
			}
			break;
		}
	}
	else
	{
		switch(buff)
		{
		case $effect[Disdain of She-Who-Was]:
			useSkill = $skill[Blessing of She-Who-Was];
			if(have_effect($effect[Disdain of the War Snapper]) > 0)
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Disdain of the Storm Tortoise]:
			useSkill = $skill[Blessing of the Storm Tortoise];
			if((have_effect($effect[Disdain of She-Who-Was]) > 0) || (have_effect($effect[Disdain of the War Snapper]) > 0))
			{
				useSkill = $skill[none];
			}
			break;
		case $effect[Disdain of the War Snapper]:
			useSkill = $skill[Blessing of the War Snapper];
			break;
		}
	}


	if(useItem != $item[Instant Karma])
	{
		return buffMaintain(useItem, buff, casts, turns);
	}
	if((useSkill != $skill[none]) && have_skill(useSkill))
	{
		return buffMaintain(useSkill, buff, mp_min, casts, turns);
	}
	return true;
}
