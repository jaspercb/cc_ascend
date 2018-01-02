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
	//Should we do a possessEquipment check?
	//This will probably all be superceded by a mafia preference.

	int choice = 0;
	switch(it)
	{
	case $item[Deceased Crimbo Tree]:			choice = 1;		break;
	case $item[Broken Champagne Bottle]:		choice = 2;		break;
	case $item[Makeshift Garbage Shirt]:		choice = 5;		break;
	}

	if(choice == 0)
	{
		return 0;
	}

	int usesLeft = 0;

	string temp = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9690", false);
	temp = visit_url("choice.php?pwd=&whichchoice=1275&option=" + choice);

	matcher my_uses = create_matcher("Looks like (it has|you can read roughly) ([0-9,]+) ",temp);
	if(my_uses.find())
	{
		usesLeft = to_int(my_uses.group(2));
	}

	//Does this unequip ourself? And if so, are we going to put it back on?
	//Looks like it has 1,000 needles remaining.
	//Looks like it has 11 ounces of champagne remaining.
	//Looks like you can read roughly 37 scraps on your shirt.
	return usesLeft;
}

boolean januaryToteAcquire(item it)
{
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
	}

	if(choice == 0)
	{
		return false;
	}

	string temp = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9690", false);
	temp = visit_url("choice.php?pwd=&whichchoice=1275&option=" + choice);

	return true;
}
