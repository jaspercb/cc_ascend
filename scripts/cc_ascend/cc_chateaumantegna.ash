script "cc_chateaumantegna.ash"

boolean chateaumantegna_available()
{
	if((contains_text(visit_url("mountains.php"),"whichplace=chateau")) && is_unrestricted($item[Chateau Mantegna Room Key]))
	{
		return true;
	}
	return false;
}

void chateaumantegna_initializeSettings()
{
	if(chateaumantegna_available())
	{
		set_property("cc_chateaumantegna", "true");
	}
	set_property("cc_chateaumantegna", "false");
}

void chateaumantegna_useDesk()
{
	if(chateaumantegna_available())
	{
		string chateau = visit_url("place.php?whichplace=chateau");
		if(contains_text(chateau, "chateau_desk1"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk1");
		}
		else if(contains_text(chateau, "chateau_desk2"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk2");
		}
		else if(contains_text(chateau, "chateau_desk3"))
		{
			visit_url("place.php?whichplace=chateau&action=chateau_desk3");
		}
	}
}

boolean chateaumantegna_havePainting()
{
	if(chateaumantegna_available())
	{
		return !get_property("_chateauMonsterFought").to_boolean();
	}
	return false;
}

boolean chateaumantegna_usePainting()
{
	if(!chateaumantegna_available())
	{
		return false;
	}
	if(get_property("chateauMonster") == "lobsterfrogman")
	{
		if(item_amount($item[Barrel of Gunpowder]) >= 5)
		{
			return false;
		}
		if(get_property("sidequestLighthouseCompleted") != "none")
		{
			return false;
		}
	}
	if(get_property("chateauMonster") == "mountain man")
	{
		if((get_property("cc_trapper") == "yeti") || (get_property("cc_trapper") == "finished"))
		{
			return false;
		}
		item oreGoal = to_item(get_property("trapperOre"));
		if(item_amount(oreGoal) >= 3)
		{
			return false;
		}
	}
	if(chateaumantegna_available())
	{
		visit_url("place.php?whichplace=chateau&action=chateau_painting");
		return contains_text(visit_url("main.php"), "Combat");
	}
	return false;
}

boolean[item] chateaumantegna_decorations()
{
	boolean[item] retval;
	if(!chateaumantegna_available())
	{
		return retval;
	}
	string chateau = to_lower_case(visit_url("place.php?whichplace=chateau"));
	if(contains_text(chateau, "electric muscle stimulator"))
	{
		retval[$item[Electric Muscle Stimulator]] = true;
	}
	else if(contains_text(chateau, "foreign language tapes"))
	{
		retval[$item[Foreign Language Tapes]] = true;
	}
	else if(contains_text(chateau, "bowl of potpourri"))
	{
		retval[$item[Bowl of Potpourri]] = true;
	}
	if(contains_text(chateau, "antler chandelier"))
	{
		retval[$item[Antler Chandelier]] = true;
	}
	else if(contains_text(chateau, "artificial skylight"))
	{
		retval[$item[Artificial Skylight]] = true;
	}
	else if(contains_text(chateau, "ceiling fan"))
	{
		retval[$item[Ceiling Fan]] = true;
	}
	if(contains_text(chateau, "continental juice bar"))
	{
		retval[$item[Continental Juice Bar]] = true;
	}
	else if(contains_text(chateau, "fancy stationery set"))
	{
		retval[$item[Fancy Stationery Set]] = true;
	}
	else if(contains_text(chateau, "swiss piggy bank"))
	{
		retval[$item[Swiss Piggy Bank]] = true;
	}
	return retval;
}

void chateaumantegna_buyStuff(item toBuy)
{
	if(!chateaumantegna_available())
	{
		return;
	}

	if((toBuy == $item[Electric Muscle Stimulator]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=411&quantity=1", true);
	}
	if((toBuy == $item[Foreign Language Tapes]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=412&quantity=1", true);
	}
	if((toBuy == $item[Bowl of Potpourri]) && (my_meat() >= 500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=413&quantity=1", true);
	}

	if((toBuy == $item[Antler Chandelier]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=415&quantity=1", true);
	}
	if((toBuy == $item[Artificial Skylight]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=416&quantity=1", true);
	}
	if((toBuy == $item[Ceiling Fan]) && (my_meat() >= 1500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=414&quantity=1", true);
	}

	if((toBuy == $item[Continental Juice Bar]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=418&quantity=1", true);
	}
	if((toBuy == $item[Fancy Calligraphy Pen]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=419&quantity=1", true);
	}
	if((toBuy == $item[Swiss Piggy Bank]) && (my_meat() >= 2500))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=417&quantity=1", true);
	}

	if((toBuy == $item[Alpine Watercolor Set]) && (my_meat() >= 5000))
	{
		visit_url("shop.php?pwd=&whichshop=chateau&action=buyitem&whichrow=420&quantity=1", true);
	}
}


boolean chateaumantegna_nightstandSet()
{
	if(!chateaumantegna_available())
	{
		return false;
	}

	stat myStat = my_primestat();
	if(myStat == $stat[none])
	{
		return false;
	}
	if(get_property("kingLiberated").to_boolean())
	{
		return false;
	}

	boolean[item] furniture = chateaumantegna_decorations();
	item need = $item[none];
	if(myStat == $stat[Muscle])
	{
		need = $item[Electric Muscle Stimulator];
	}
	else if(myStat == $stat[Mysticality])
	{
		need = $item[Foreign Language Tapes];
	}
	else if(myStat == $stat[Moxie])
	{
		need = $item[Bowl of Potpourri];
	}

	if(furniture[need])
	{
		return false;
	}
	if(my_meat() < 500)
	{
		return false;
	}
	print("We have the wrong Chateau Nightstand item, replacing.", "blue");
	chateaumantegna_buyStuff(need);
	return true;
}
