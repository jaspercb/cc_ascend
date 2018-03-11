script "cc_mr2018.ash"

#	This is meant for items that have a date of 2018.

int januaryToteTurnsLeft(item it)
{
	if(item_amount($item[January\'s Garbage Tote]) == 0)
	{
		return 0;
	}
	if(!is_unrestricted($item[January\'s Garbage Tote]))
	{
		return 0;
	}

	int score = 0;
	switch(it)
	{
	case $item[Deceased Crimbo Tree]:		score = get_property("_garbageTreeCharge").to_int();		break;
	case $item[Broken Champagne Bottle]:	score = get_property("_garbageChampagneCharge").to_int();	break;
	case $item[Makeshift Garbage Shirt]:	score = get_property("_garbageShirtCharge").to_int();		break;
	}
	return score;
}

boolean januaryToteAcquire(item it)
{
	if(possessEquipment(it))
	{
		return false;
	}
	if(item_amount($item[January\'s Garbage Tote]) == 0)
	{
		return false;
	}
	if(!is_unrestricted($item[January\'s Garbage Tote]))
	{
		return false;
	}

	int choice = 0;
	switch(it)
	{
	case $item[Deceased Crimbo Tree]:			choice = 1;		break;
	case $item[Broken Champagne Bottle]:		choice = 2;		break;
	case $item[Tinsel Tights]:					choice = 3;		break;
	case $item[Wad Of Used Tape]:				choice = 4;		break;
	case $item[Makeshift Garbage Shirt]:		choice = 5;		break;
	case $item[Letter For Melvign The Gnome]:	choice = 7;		break;
	}

	if((choice == 5) && !hasTorso())
	{
		return false;
	}

	if(choice == 0)
	{
		return false;
	}

	if(choice == 7)
	{
		if(get_property("questM22Shirt") != "unstarted")
		{
			return false;
		}
		if(hasTorso())
		{
			return false;
		}
		if(item_amount($item[Letter For Melvign The Gnome]) > 0)
		{
			return false;
		}
		choice = 5;
	}

	string temp = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9690", false);
	temp = visit_url("choice.php?pwd=&whichchoice=1275&option=" + choice);

	return true;
}
