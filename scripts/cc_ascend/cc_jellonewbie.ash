script "cc_jellonewbie.ash"
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_list.ash>
import <cc_ascend/cc_ascend_header.ash>


// Skills start at 23000
// (descid % 125) + 23001 -> skill absorbed
//	_noobSkillCount	
//  noobDefferedPoints
//  noobPoints

void jello_initializeSettings();
string[item] jello_lister();
string[item] jello_lister(string goal);
boolean jello_buySkills();
boolean LM_jello();



void jello_initializeSettings()
{
	if(my_path() == "Gelatinous Noob")
	{
		set_property("cc_cubeItems", false);
		set_property("cc_getStarKey", true);
	}
}

boolean jello_buySkills()
{
	/*
		Need to consider skill orders, how to handle when we have starting skills.
		Blacklist and whitelist are just for testing for now, need more work.
	*/

	boolean[item] blacklist = $items[LOV Enamorang, Enchanted Bean];
	boolean[item] whitelist = $items[Dirty Bottlecap, Potted Cactus, hermit permit];

	while(my_absorbs() < min((my_level() + 2),15))
	{
		string[item] available = jello_lister();
		int start = my_absorbs();
		int earlyTerm = max(5, get_property("_noobSkillCount").to_int() * my_daycount());
		foreach sk in $skills[Large Intestine, Small Intestine, Stomach-Like Thing, Rudimentary Alimentary Canal, Central Hypothalamus, Arrogance, Sense of Pride, Sense of Purpose, Basic Self-Worth, Work Ethic, Visual Cortex, Saccade Reflex, Optic Nerves, Right Eyeball, Left Eyeball, Thumbs, Index Fingers, Middle Fingers, Ring Fingers, Pinky Fingers, Sunglasses, Sense of Sarcasm, Beating Human Heart, Oversized Right Kidney, Anterior Cruciate Ligaments, Achilles Tendons, Kneecaps, Ankle Joints, Hamstrings, Pathological Greed, Sense of Entitlement, Business Acumen, Financial Ambition, The Concept of Property, Bravery Gland, Subcutaneous Fat, Adrenal Gland, Nasal Septum, Hyperactive Amygdala, Nasal Lamina Propria, Right Eyelid, Pinchable Nose, Left Eyelid, Nose Hair, Overalls, Rigid Rib Cage, Rigid Headbone]
		{
			earlyTerm --;
			if(earlyTerm <= 0)
			{
				break;
			}
			if(!have_skill(sk))
			{
				item[int] possible;
				int count = 0;
				foreach it in available
				{
					if(!blacklist[it] && it.noob_skill == sk)
					{
						possible[count(possible)] = it;
					}
				}
				int bound = count(possible);
				if(bound == 0)
				{
					continue;
				}

				sort possible by mall_price(value);

				print("Trying to acquire skill " + sk + " and considering: " , "green");
				for(int i=0; i<bound; i++)
				{
					print(possible[i] + ": " + mall_price(possible[i]), "blue");
				}
				abort("Need to validate blacklists");

				for(int i=0; (i<bound) && !have_skill(sk); i++)
				{
					if(item_amount(possible[i]) == 0)
					{
						if(creatable_amount(possible[i]) == 0)
						{
							if(npc_price(possible[i]) < my_meat())
							{
								buyUpTo(1, possible[i], npc_price(possible[i]));
							}
							else
							{
								continue;
							}
						}
						else
						{
							cli_execute("make " + possible[i]);
						}
					}
					cli_execute("absorb " + possible[i]);
				}
			}
		}

		if(start == my_absorbs())
		{
			break;
		}
	}
	return true;
}


string[item] jello_lister(string goal)
{
	string[item] retval;
	int output = 0;
	foreach it in $items[]
	{
		boolean canGet = (item_amount(it) > 0) || (creatable_amount(it) > 0); # || (available_amount(it) > 0);
		if((npc_price(it) > 0) && (my_meat() >= npc_price(it)))
		{
			canGet = true;
		}
		if(canGet && (it.noob_skill != $skill[none]) && !have_skill(it.noob_skill))
		{
			string result = string_modifier(it.noob_skill, "Modifiers");
			if(contains_text(result, goal))
			{
				string color = "green";
				if((output % 2) == 1)
				{
					color = "blue";
				}
				print(it + ": " + result, color);
				output++;
				retval[it] = result;
			}
		}
	}
	return retval;
}

string[item] jello_lister()
{
	return jello_lister("");
}

boolean LM_jello()
{
	if(my_path() != "Gelatinous Noob")
	{
		return false;
	}
	jello_buySkills();
	return false;
}
