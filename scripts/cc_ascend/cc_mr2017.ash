script "cc_mr2017.ash"

#   This is meant for items that have a date of 2017.
#   Handling: Space Jellyfish, heart-shaped crate

boolean getSpaceJelly();
boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem);
boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem, string option);

boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem)
{
	return loveTunnelAcquire(enforcer, statItem, engineer, loveEffect, equivocator, giftItem, "");
}

boolean loveTunnelAcquire(boolean enforcer, stat statItem, boolean engineer, int loveEffect, boolean equivocator, int giftItem, string option)
{
	if(get_property("_cc_loveTunnelDone").to_boolean())
	{
		return false;
	}
	if((loveEffect < 0) || (loveEffect > 4))
	{
		return false;
	}
	if((giftItem < 0) || (giftItem > 7))
	{
		return false;
	}
	if((giftItem == 6) && !have_familiar($familiar[Space Jellyfish]))
	{
		return false;
	}

	set_property("_cc_loveTunnelDone", true);

	string temp = visit_url("place.php?whichplace=town_wrong");
	if(!(contains_text(temp, "townwrong_tunnel")))
	{
		return false;
	}

	#string temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	if(contains_text(temp, "Come back tomorrow!"))
	{
		print("Already visited L.O.V.E. Tunnel. Can't be visiting again.", "red");
		temp = visit_url("choice.php?pwd=&whichchoice=1222&option=2");
		return false;
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1222&option=1");

	if(enforcer || engineer || equivocator)
	{
		set_property("cc_disableAdventureHandling", "yes");
	}

	if(enforcer)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1223&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1223&option=2");
	}


	int statValue = 4;
	if(statItem == $stat[none])
	{
		statItem = my_primestat();
	}
	switch(statItem)
	{
	case $stat[Muscle]:			statValue = 1;		break;
	case $stat[Mysticality]:	statValue = 2;		break;
	case $stat[Moxie]:			statValue = 3;		break;
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1224&option=" + statValue);
#1		Cardigan,			LOV Eardigan	Shirt - 25% Muscle Stats, 8-12HP Regen, +25ML, End of Day
#2		Epaulettes,			LOV Epaulettes	Back  - 25% Myst Stats, 4-6MP Regen, -3MPCombatSkills, End of Day
#3		Earrings			LOV Earrings	Acc   - 25% Moxie Stats, +3 PrismRes, +50% Meat, End of Day
#4		Nothing


	if(engineer)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1225&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1225&option=2");
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1226&option=" + loveEffect);
#1	Lovebotamy					+10 stats per fight
#2	Open Heart Surgery			+10 familiar weight (50 adventures)
#3	Wandering Eye Surgery		+50% item drops (50 adventures)
#4	Nothing

	if(equivocator)
	{
		ccAdvBypass("choice.php?pwd=&whichchoice=1227&option=1", option);
	}
	else
	{
		string temp = visit_url("choice.php?pwd=&whichchoice=1227&option=2");
	}

	temp = visit_url("choice.php?pwd=&whichchoice=1228&option=" + giftItem);
#1		Boomerang			LOV Enamorang (combat item) stagger, consumed (15 turn later copy?)
#2		Toy Dart Gun		LOV Emotionizer (usable self/others)
#3		Chocolate			LOV Extraterrestrial Chocolate (+3/2/1 advs, independent chocolate?)
#4		Flowers				LOV Echinacea Bouquet (Spleen). (stats + small hp/mp, 1 toxicity)
#5		Plush Elephant		LOV Elephant (Shield, DR+10)
#6		Toast? Only with Space Jellyfish?
#7		Nothing

	if(enforcer || engineer || equivocator)
	{
		set_property("cc_disableAdventureHandling", "no");
		cli_execute("postcheese");
	}

	return true;
}




boolean getSpaceJelly()
{
	if(is100FamiliarRun($familiar[Space Jellyfish]))
	{
		return false;
	}
	if(get_property("_seaJellyHarvested").to_boolean())
	{
		return false;
	}
	if(!have_familiar($familiar[Space Jellyfish]))
	{
		return false;
	}
	if(my_level() < 11)
	{
		return false;
	}
	if(my_path() != "Standard")
	{
		if(!get_property("kingLiberated").to_boolean())
		{
			return false;
		}
	}

	if(internalQuestStatus("questS01OldGuy") < 0)
	{
		string temp = visit_url("oldman.php");
		temp = visit_url("place.php?whichplace=sea_oldman&action=oldman_oldman");
	}
	familiar old = my_familiar();
	use_familiar($familiar[Space Jellyfish]);
	string temp = visit_url("place.php?whichplace=thesea");
	temp = visit_url("place.php?whichplace=thesea&action=thesea_left2");
	temp = visit_url("choice.php?pwd=&whichchoice=1219&option=1");
	use_familiar(old);
	return true;
}
