script "awol.ash"

import<cc_ascend/cc_util.ash>
import<cc_ascend/cc_ascend_header.ash>

boolean awol_initializeSettings()
{
	if(my_path() == "Avatar of West of Loathing")
	{
		set_property("cc_awolLastSkill", 0);
		set_property("cc_getBeehive", true);
		set_property("cc_getStarKey", true);
		set_property("cc_holeinthesky", true);
		set_property("cc_wandOfNagamar", true);
	}
	return false;
}

boolean awol_buyskills()
{
	if(get_property("cc_awolLastSkill").to_int() == 0)
	{
		//Catch that Mafia does not see our second/third skillbook at ascension start
		cli_execute("refresh inv");
	}

	if(get_property("cc_awolLastSkill").to_int() < my_level())
	{
		set_property("cc_awolLastSkill", my_level());
	}
	else
	{
		return false;
	}

	if(item_amount($item[Tales of the West: Cow Punching]) > 0)
	{
		string page = visit_url("inv_use.php?pwd=&which=3&whichitem=8955");
		matcher my_skillPoints = create_matcher("You can learn (\\d\+) more skill", page);
		if(my_skillPoints.find())
		{
			int skillPoints = to_int(my_skillPoints.group(1));
			print("Cow points found: " + skillPoints);
			while(skillPoints > 0)
			{
				if(my_class() == $class[Cow Puncher])
				{
					if(!have_skill($skill[Rugged Survivalist]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=5", true);
					}
					else if(!have_skill($skill[Larger Than Life]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=6", true);
					}
					else if(!have_skill($skill[Cowcall]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=1", true);
					}
					else if(!have_skill($skill[Hard Drinker]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=8", true);
					}
					else if(!have_skill($skill[One-Two Punch]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=0", true);
					}
					else if(!have_skill($skill[Pistolwhip]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=2", true);
					}
					else if(!have_skill($skill[Walk: Cautious Prowl]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=9", true);
					}
					else if(!have_skill($skill[Hogtie]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=3", true);
					}
					else if(!have_skill($skill[True Outdoorsperson]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=4", true);
					}
					else if(!have_skill($skill[Unleash Cowrruption]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=7", true);
					}
				}
				else
				{
					if(!have_skill($skill[Hard Drinker]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=8", true);
					}
					else if(!have_skill($skill[Rugged Survivalist]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=5", true);
					}
					else if(!have_skill($skill[Walk: Cautious Prowl]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=9", true);
					}
					else if(!have_skill($skill[Larger Than Life]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=6", true);
					}
					else if(!have_skill($skill[Cowcall]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=1", true);
					}
					else if(!have_skill($skill[One-Two Punch]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=0", true);
					}
					else if(!have_skill($skill[Pistolwhip]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=2", true);
					}
					else if(!have_skill($skill[Hogtie]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=3", true);
					}
					else if(!have_skill($skill[True Outdoorsperson]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=4", true);
					}
					else if(!have_skill($skill[Unleash Cowrruption]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1177&whichskill=7", true);
					}
				}
				skillPoints -= 1;
			}
		}
	}
	if(item_amount($item[Tales of the West: Beanslinging]) > 0)
	{
		string page = visit_url("inv_use.php?pwd=&which=3&whichitem=8956");
		matcher my_skillPoints = create_matcher("You can learn (\\d\+) more skill", page);
		if(my_skillPoints.find())
		{
			int skillPoints = to_int(my_skillPoints.group(1));
			print("Bean points found: " + skillPoints);
			while(skillPoints > 0)
			{
				if(my_class() == $class[Beanslinger])
				{
					if(!have_skill($skill[Beanstorm]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=6", true);
					}
					else if(!have_skill($skill[Beanscreen]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=3", true);
					}
					else if(!have_skill($skill[Canhandle]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=2", true);
					}
					else if(!have_skill($skill[Prodigious Appetite]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=8", true);
					}
					else if(!have_skill($skill[Lavafava]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=0", true);
					}
					else if(!have_skill($skill[Bean Runner]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=4", true);
					}
					else if(!have_skill($skill[Beancannon]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=7", true);
					}
					else if(!have_skill($skill[Walk: Prideful Strut]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=9", true);
					}
					else if(!have_skill($skill[Beanweaver]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=5", true);
					}
					else if(!have_skill($skill[Pungent Mung]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=1", true);
					}
				}
				else
				{
					if(!have_skill($skill[Prodigious Appetite]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=8", true);
					}
					else if(!have_skill($skill[Walk: Prideful Strut]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=9", true);
					}
					else if(!have_skill($skill[Beanstorm]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=6", true);
					}
					else if(!have_skill($skill[Beanscreen]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=3", true);
					}
					else if(!have_skill($skill[Canhandle]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=2", true);
					}
					else if(!have_skill($skill[Lavafava]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=0", true);
					}
					else if(!have_skill($skill[Bean Runner]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=4", true);
					}
					else if(!have_skill($skill[Beancannon]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=7", true);
					}
					else if(!have_skill($skill[Beanweaver]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=5", true);
					}
					else if(!have_skill($skill[Pungent Mung]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1178&whichskill=1", true);
					}
				}
				skillPoints -= 1;
			}
		}
	}
	if(item_amount($item[Tales of the West: Snake Oiling]) > 0)
	{
		string page = visit_url("inv_use.php?pwd=&which=3&whichitem=8957");
		matcher my_skillPoints = create_matcher("You can learn (\\d\+) more skill", page);
		if(my_skillPoints.find())
		{
			int skillPoints = to_int(my_skillPoints.group(1));
			print("Snake points found: " + skillPoints);
			while(skillPoints > 0)
			{
				if(my_class() == $class[Snake Oiler])
				{
					if(!have_skill($skill[Good Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=6", true);
					}
					else if(!have_skill($skill[Bad Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=3", true);
					}
					else if(!have_skill($skill[Extract Oil]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=2", true);
					}
					else if(!have_skill($skill[Tolerant Constitution]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=8", true);
					}
					else if(!have_skill($skill[Snakewhip]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=0", true);
					}
					else if(!have_skill($skill[Patent Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=4", true);
					}
					else if(!have_skill($skill[Long Con]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=7", true);
					}
					else if(!have_skill($skill[Walk: Leisurely Amble]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=9", true);
					}
					else if(!have_skill($skill[Well-Oiled Guns]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=5", true);
					}
					else if(!have_skill($skill[Fan Hammer]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=1", true);
					}
				}
				else
				{
					if(!have_skill($skill[Tolerant Constitution]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=8", true);
					}
					else if(!have_skill($skill[Long Con]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=7", true);
					}
					else if(!have_skill($skill[Good Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=6", true);
					}
					else if(!have_skill($skill[Bad Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=3", true);
					}
					else if(!have_skill($skill[Extract Oil]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=2", true);
					}
					else if(!have_skill($skill[Snakewhip]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=0", true);
					}
					else if(!have_skill($skill[Patent Medicine]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=4", true);
					}
					else if(!have_skill($skill[Walk: Leisurely Amble]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=9", true);
					}
					else if(!have_skill($skill[Well-Oiled Guns]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=5", true);
					}
					else if(!have_skill($skill[Fan Hammer]))
					{
						page = visit_url("choice.php?pwd=&option=1&whichchoice=1179&whichskill=1", true);
					}
				}
				skillPoints -= 1;
			}
		}
	}

	return false;
}
