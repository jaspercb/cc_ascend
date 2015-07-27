script "cc_deckofeverycard.ash"

#sed -r "s/<option value=([[:digit:]]+)>([[:alnum:][:space:]-]+)<\/option>/cards[\"\2\"] = \1;/g" temp >> cc_deckofeverycard.ash

boolean deck_available()
{
	return item_amount($item[Deck of Every Card]) > 0;
}

int deck_draws_left()
{
	if(!deck_available())
	{
		return 0;
	}
	return 15 - get_property("_deckCardsDrawn").to_int();
}


boolean deck_draw()
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() <= 0)
	{
		return false;
	}
	string page = visit_url("inv_use.php?pwd=&which=3&whichitem=8382");
	page = visit_url("choice.php?pwd=&whichchoice=1085&option=1", true);
	return true;
}

boolean deck_cheat(string cheat)
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() <= 0)
	{
		return false;
	}
	static int [string] cards;
	cards["X of Clubs"] = 1;
	cards["X of Hearts"] = 2;
	cards["X of Diamonds"] = 3;
	cards["X of Spades"] = 4;
	cards["X of Cups"] = 5;
	cards["X of Wands"] = 6;
	cards["X of Swords"] = 7;
	cards["X of Coins"] = 8;
	cards["XIII - Death"] = 9;
	cards["Goblin Sapper"] = 10;

	cards["The Hive"] = 11;
	cards["Hunky Fireman Card"] = 12;
	cards["V - The Hierophant"] = 13;
	cards["XVIII - The Moon"] = 14;
	cards["Werewolf"] = 15;
	cards["XV - The Devil"] = 16;
	cards["Fire Elemental"] = 17;
	cards["Slimer Trading Card"] = 18;
	cards["VII - The Chariot"] = 19;
	cards["II - The High Priestess"] = 20;


	cards["XII - The Hanged Man"] = 21;
	cards["Plantable Greeting Card"] = 22;
	cards["Pirate Birthday Card"] = 23;
	cards["XIV - Temperance"] = 24;
	cards["Unstable Portal"] = 25;
	cards["XVII - The Star"] = 26;
	cards["Suit Warehouse Discount Card"] = 27;
	cards["Christmas Card"] = 28;
	cards["Go Fish"] = 29;
	cards["Aquarius Horoscope"] = 30;

	cards["Plains"] = 31;
	cards["Swamp"] = 32;
	cards["Mountain"] = 33;
	cards["Forest"] = 34;
	cards["Island"] = 35;
	cards["Healing Salve"] = 36;
	cards["Dark Ritual"] = 37;
	cards["Lightning Bolt"] = 38;
	cards["Giant Growth"] = 39;
	cards["Ancestral Recall"] = 40;

	cards["Gift Card"] = 41;
	cards["X of Papayas"] = 42;
	cards["X of Salads"] = 43;
	cards["IX - The Hermit"] = 44;
	cards["IV - The Emperor"] = 45;
	cards["Green Card"] = 46;
	cards["XVI - The Tower"] = 47;
	cards["The Race Card"] = 48;
	cards["0 - The Fool"] = 49;
	cards["I - The Magician"] = 50;

	cards["XI - Strength"] = 51;
	cards["Lead Pipe"] = 52;
	cards["Rope"] = 53;
	cards["Wrench"] = 54;
	cards["Candlestick"] = 55;
	cards["Knife"] = 56;
	cards["Revolver"] = 57;
	cards["1952 Mickey Mantle"] = 58;
	cards["Spare Tire"] = 59;
	cards["Extra Tank"] = 60;

	cards["Sheep"] = 61;
	cards["Year of Plenty"] = 62;
	cards["Mine"] = 63;
	cards["Laboratory"] = 64;
	cards["X of Kumquats"] = 65;
	cards["Professor Plum"] = 66;
	cards["X - The Wheel of Fortune"] = 67;
	cards["XXI - The World"] = 68;
	cards["VI - The Lovers"] = 69;
	cards["III - The Empress"] = 70;




	cards["PVP"] = 1;
	cards["fites"] = 1;
	cards["spade"] = 4;
	cards["white mana"] = 31;
	cards["black mana"] = 32;
	cards["red mana"] = 33;
	cards["green mana"] = 34;
	cards["blue mana"] = 36;
	cards["key"] = 47;
	cards["init"] = 48;
	cards["moxie buff"] = 49;
	cards["myst buff"] = 50;
	cards["mysticality buff"] = 50;
	cards["meat"] = 58;
	cards["muscle buff"] = 51;
	cards["stone wool"] = 61;
	cards["ore"] = 63;
	cards["items"] = 67;
	cards["muscle stat"] = 68;
	cards["moxie stat"] = 69;
	cards["myst stat"] = 70;
	cards["mysticality stat"] = 70;


	string page = visit_url("inv_use.php?cheat=1&pwd=&whichitem=8382");

	//	Check that a valid card was selected, otherwise this wastes 5 draws.
	int card = cards[cheat];
	if(card != 0)
	{
		string page = visit_url("choice.php?pwd=&option=1&whichchoice=1086&which=" + card, true);
		page = visit_url("choice.php?pwd=&whichchoice=1085&option=1", true);
		//	Check if a combat has been started and try to resolve it? Can we resolve it here?
		//	If we had #includes, we probably could resolve it here... hmm...
		#print(page, "red");
		return true;
	}
	return false;
}


boolean deck_useScheme(string action)
{
	if(!deck_available())
	{
		return false;
	}
	if(deck_draws_left() < 15)
	{
		return false;
	}
	if((action == "turns") && (my_daycount() <= 2))
	{
		deck_cheat("Ancestral Recall");
		deck_cheat("Island");
		if((get_property("cc_trapper") == "") || (get_property("cc_trapper") == "start"))
		{
			deck_cheat("Mine");
		}
		while(item_amount($item[Blue Mana]) > 0)
		{
			use_skill(1, $skill[Ancestral Recall]);
		}
		return true;
	}
	if(action == "farming")
	{
		deck_cheat("Ancestral Recall");
		deck_cheat("Island");
		deck_cheat("1952 Mickey Mantle");
		while(item_amount($item[Blue Mana]) > 0)
		{
			use_skill(1, $skill[Ancestral Recall]);
		}
		return true;
	}
	return false;
}
