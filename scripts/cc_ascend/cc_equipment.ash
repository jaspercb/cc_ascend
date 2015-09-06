script "cc_ascend/cc_equipment.ash";
import <cc_util.ash>
void equipBaseline();
void equipBaselineWeapon();
void equipBaselinePants();
void equipBaselineBack();
void equipBaselineShirt();
void equipBaselineHat();
void equipBaselineAcc1();
void equipBaselineAcc2();
void equipBaselineAcc3();
void equipBaselineHat(boolean wantNC);
void equipRollover();
void handleOffHand();
boolean handleBjornify(familiar fam);
void makeStartingSmiths();
boolean possessEquipment(item equipment);

void makeStartingSmiths()
{
	if(!have_skill($skill[Summon Smithsness]))
	{
		return;
	}

	if(item_amount($item[Lump of Brituminous Coal]) == 0)
	{
		if(my_mp() < 6)
		{
			print("You don't have enough MP for initialization, it might be ok but probably not.", "red");
		}
		use_skill(3, $skill[summon smithsness]);
	}

	if(knoll_available())
	{
		buyUpTo(1, $item[maiden wig]);
	}

	switch(my_class())
	{
	case $class[Seal Clubber]:
		if(!possessEquipment($item[Meat Tenderizer is Murder]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[seal-clubbing club]);
		}
		if(!possessEquipment($item[Vicar\'s Tutu]) && (item_amount($item[Lump of Brituminous Coal]) > 0) && knoll_available())
		{
			buy(1, $item[Frilly Skirt]);
			craft("smith", 1, $item[Lump of Brituminous Coal], $item[Frilly Skirt]);
		}
		break;
	case $class[Turtle Tamer]:
		if(!possessEquipment($item[Work is a Four Letter Sword]))
		{
			buyUpTo(1, $item[Sword Hilt]);
			craft("smith", 1, $item[lump of Brituminous coal], $item[sword hilt]);
		}
		if(!possessEquipment($item[Ouija Board\, Ouija Board]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[turtle totem]);
		}
		break;
	case $class[Sauceror]:
		if(!possessEquipment($item[Saucepanic]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[Saucepan]);
		}
		if(!possessEquipment($item[A Light that Never Goes Out]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			craft("smith", 1, $item[Lump of Brituminous Coal], $item[Third-hand Lantern]);
		}
		break;
	case $class[Pastamancer]:
		if(!possessEquipment($item[Hand That Rocks the Ladle]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[Pasta Spoon]);
		}
		break;
	case $class[Disco Bandit]:
		if(!possessEquipment($item[Frankly Mr. Shank]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[Disco Ball]);
		}
		break;
	case $class[Accordion Thief]:
		if(!possessEquipment($item[Shakespeare\'s Sister\'s Accordion]))
		{
			craft("smith", 1, $item[lump of Brituminous coal], $item[Stolen Accordion]);
		}
		break;
	}

	if(knoll_available() && !possessEquipment($item[Hairpiece on Fire]) && (item_amount($item[lump of Brituminous Coal]) > 0))
	{
		craft("smith", 1, $item[lump of Brituminous coal], $item[maiden wig]);
	}
	buffMaintain($effect[Merry Smithsness], 0, 1, 10);
}

boolean possessEquipment(item equipment)
{
	if(equipment == $item[none])
	{
		return false;
	}

	if(item_amount(equipment) > 0)
	{
		return true;
	}
//	if(closet_amount(equipment) > 0)
//	{
//		return true;
//	}
	if(equipped_item($slot[hat]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[back]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[shirt]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[weapon]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[off-hand]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[pants]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc1]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc2]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc3]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[familiar]) == equipment)
	{
		return true;
	}
	return false;
}


boolean handleBjornify(familiar fam)
{
	if(in_hardcore())
	{
		return false;
	}

	if((equipped_item($slot[back]) != $item[buddy bjorn]) || (my_bjorned_familiar() == fam))
	{
		return false;
	}

	if(have_familiar(fam))
	{
		bjornify_familiar(fam);
	}
	else
	{
		if(have_familiar($familiar[El Vibrato Megadrone]))
		{
			bjornify_familiar($familiar[El Vibrato Megadrone]);
		}
		else
		{
			if((my_familiar() != $familiar[Grimstone Golem]) && have_familiar($familiar[Grimstone Golem]))
			{
				bjornify_familiar($familiar[Grimstone Golem]);
			}
			else if(have_familiar($familiar[Adorable Seal Larva]))
			{
				bjornify_familiar($familiar[Adorable Seal Larva]);
			}
			else
			{
				return false;
			}
		}
	}
	return true;
}


void handleOffHand()
{
	item toEquip = $item[none];
	boolean[item] poss;

	if((my_path() == "Heavy Rains") && (item_amount($item[Thor\'s Pliers]) == 1))
	{
		equip($slot[off-hand], $item[Thor\'s Pliers]);
		return;
	}

	if(weapon_hands(equipped_item($slot[weapon])) > 1)
	{
		return;
	}

	# string item_type($item[]) returns "shield" for shields, yay!
	#if weapon_type(equipped_item($slot[weapon]) == $stat[Moxie]) we can dual-wield other ranged weapons.
	if(my_class() != $class[Turtle Tamer])
	{
		if((have_skill($skill[Double-Fisted Skull Smashing])) && (weapon_type(equipped_item($slot[weapon])) != $stat[Moxie]))
		{
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Hot Plate, Spiked Femur, Wicker Shield, Operation Patriot Shield, Fake Washboard];
		}
		else
		{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Wicker Shield, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Operation Patriot Shield, Fake Washboard];
		}
	}
	if(my_class() == $class[Turtle Tamer])
	{
		poss = $items[Wicker Shield, Ouija Board\, Ouija Board, Operation Patriot Shield, Fake Washboard];
	}

	if(my_class() == $class[Pastamancer])
	{
		if((have_skill($skill[Double-Fisted Skull Smashing])) && (weapon_type(equipped_item($slot[weapon])) != $stat[Moxie]))
		{
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Spiked Femur, Wicker Shield, Operation Patriot Shield, Jarlsberg\'s Pan];
		}
		else
		{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Wicker Shield, Sticky Hand Whip, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Operation Patriot Shield, Jarlsberg\'s Pan];
		}
	}

	if(my_class() == $class[Sauceror])
	{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Wicker Shield, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Operation Patriot Shield, Jarlsberg\'s Pan, A Light that Never Goes Out];
	}

	if(my_class() == $class[Disco Bandit])
	{
		if((have_skill($skill[Double-Fisted Skull Smashing])) && (weapon_type(equipped_item($slot[weapon])) != $stat[Moxie]))
		{
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Spiked Femur, Wicker Shield, Operation Patriot Shield];
		}
		else
		{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Wicker Shield, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Operation Patriot Shield, Fake Washboard];
		}
	}

	if(my_class() == $class[Avatar of Jarlsberg])
	{
		poss = $items[Jarlsberg\'s Pan, Jarlsberg\'s Pan (Cosmic Portal Mode)];
	}

	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if(contains_text(holiday(), "Oyster Egg Day"))
	{
		poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid];
		if((toEquip == $item[none]) || (poss contains toEquip))
		{
			if(!possessEquipment($item[Oyster Basket]) && (my_meat() >= 300))
			{
				buy(1, $item[Oyster Basket]);
			}
			if(possessEquipment($item[Oyster Basket]))
			{
				toEquip = $item[Oyster Basket];
			}
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[off-hand])))
	{
		equip($slot[Off-hand], toEquip);
	}

}

void equipBaselineHat()
{
	equipBaselineHat(true);
}

void equipBaselinePants()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Old Sweatpants, Knob Goblin Harem Pants, three-legged pants, Knob Goblin Pants, Filthy Corduroys, Ninja Hot Pants, Leotarrrd, Swashbuckling Pants, Vicar\'s Tutu, Troll Britches, Distressed Denim Pants, Astral Shorts, Pantsgiving];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[pants])))
	{
		equip(toEquip);
	}
}

void equipBaselineShirt()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Astral Shirt, Stephen\'s Lab Coat, Sneaky Pete\'s Leather Jacket, Sneaky Pete\'s Leather Jacket (Collar Popped)];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[shirt])))
	{
		equip(toEquip);
	}
}

void equipBaselineBack()
{
	item toEquip = $item[none];

	boolean[item] poss;

	if(my_class() == $class[Ed])
	{
		poss = $items[Giant Gym Membership Card, Misty Cloak, Misty Cape, Misty Robe];
	}
	else
	{
		poss = $items[Giant Gym Membership Card, Misty Cloak, Misty Cape, Misty Robe, Makeshift Cape, Buddy Bjorn, Camp Scout Backpack];
	}
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[back])))
	{
		equip(toEquip);
	}
}

void equipBaselineHat(boolean wantNC)
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Hollandaise Helmet, Viking Helmet, Chef\'s Hat, Crown of the Goblin King, Safarrri Hat, Mohawk Wig, Hairpiece On Fire, Fuzzy Earmuffs, Reinforced Beaded Headband, Giant Yellow Hat, 8185];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}

		if(my_class() == $class[Ed])
		{
			if(possessEquipment(thing) && (thing == $item[8185]))
			{
				toEquip = thing;
				visit_url("inv_equip.php?pwd=&which=2&action=equip&whichitem=8185");
				return;
			}
		}
	}

	if(wantNC)
	{
		if(possessEquipment($item[Xiblaxian Stealth Cowl]))
		{
			toEquip = $item[Xiblaxian Stealth Cowl];
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[hat])))
	{
		equip(toEquip);
	}
}

void equipBaselineWeapon()
{
	item toEquip = $item[none];
	boolean[item] poss;

	switch(my_class())
	{
	case $class[Seal Clubber]:
		poss = $items[Meat Tenderizer Is Murder];
		break;
	case $class[Turtle Tamer]:
		poss = $items[Work Is A Four Letter Sword];
		break;
	case $class[Sauceror]:
		poss = $items[Saucepanic];
		break;
	case $class[Pastamancer]:
		poss = $items[Hand That Rocks The Ladle];
		break;
	case $class[Disco Bandit]:
		poss = $items[Frankly Mr. Shank];
		break;
	case $class[Accordion Thief]:
		poss = $items[Shakespeare\'s Sister\'s Accordion];
		break;
	case $class[Ed]:
#		poss = $items[Titanium Assault Umbrella, Staff of Ed];
		poss = $items[Spiked Femur, Grassy Cutlass, Oversized Pizza Cutter, Titanium Assault Umbrella, Ocarina of Space, 7961, sewage-clogged pistol];
		break;
	case $class[Avatar of Jarlsberg]:
		poss = $items[Staff of the Standalone Cheese];
		break;
	default:
		abort("You don't have a valid class for this equipper, must be an avatar path or something.");
		break;
	}

	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[weapon])))
	{
		equip($slot[weapon], toEquip);
	}

	handleOffHand();
}


void equipBaseline()
{
	equipBaselineHat();
	equipBaselineShirt();
	equipBaselineWeapon();
	equipBaselinePants();
	equipBaselineBack();
	equipBaselineAcc1();
	equipBaselineAcc2();
	equipBaselineAcc3();

	if(my_familiar() != $familiar[none])
	{
		if((my_path() != "Heavy Rains") && (item_amount($item[Astral Pet Sweater]) > 0))
		{
			equip($item[Astral Pet Sweater]);
		}
		if((my_path() == "Heavy Rains") && (item_amount($item[miniature life preserver]) > 0))
		{
			equip($item[miniature life preserver]);
		}
		if((my_path() != "Heavy Rains") && (item_amount($item[Snow Suit]) > 0))
		{
			equip($item[Snow Suit]);
		}
		if((equipped_item($slot[familiar]) != $item[none]) && !is_familiar_equipment_locked())
		{
			lock_familiar_equipment(true);
		}
	}

	if(my_daycount() == 1)
	{
		if(have_familiar($familiar[grimstone golem]))
		{
			if(get_property("_grimFairyTaleDropsCrown").to_int() >= 1)
			{
				handleBjornify($familiar[el vibrato megadrone]);
			}
		}
		else
		{
			handleBjornify($familiar[el vibrato megadrone]);
		}
	}
	if(my_daycount() == 2)
	{
		handleBjornify($familiar[el vibrato megadrone]);
	}

	if(get_property("cc_diceMode").to_boolean())
	{
		if(item_amount($item[Dice Ring]) > 0)
		{
			equip($slot[acc1], $item[Dice Ring]);
		}
		if(item_amount($item[Dice Belt Buckle]) > 0)
		{
			equip($slot[acc2], $item[Dice Belt Buckle]);
		}
		if(item_amount($item[Dice Sunglasses]) > 0)
		{
			equip($slot[acc3], $item[Dice Sunglasses]);
		}
		if(item_amount($item[Dice-Print Do-Rag]) > 0)
		{
			equip($slot[hat], $item[Dice-Print Do-Rag]);
		}
		if(item_amount($item[Dice-Shaped Backpack]) > 0)
		{
			equip($slot[back], $item[Dice-Shaped Backpack]);
		}
		if(item_amount($item[Dice-Print Pajama Pants]) > 0)
		{
			equip($slot[pants], $item[Dice-Print Pajama Pants]);
		}
		if(item_amount($item[Kill Screen]) > 0)
		{
			equip($slot[familiar], $item[Kill Screen]);
		}
	}

}

void equipBaselineAcc1()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Ghost of a Necklace, Astral Mask, Astral Belt, Astral Ring, Astral Bracer, Over-The-Shoulder Folder Holder];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc1])))
	{
		equip($slot[acc1], toEquip);
	}
}

void equipBaselineAcc2()
{
	item toEquip = $item[none];
	boolean[item] poss;
	if((my_level() >= 13) && (get_property("flyeredML").to_int() >= 10000))
	{
		poss = $items[Glowing Red Eye, Bonerdagon Necklace, Batskin Belt, Jangly Bracelet, Pirate Fledges, Iron Beta of Industry, World\'s Best Adventurer Sash];
	}
	else
	{
		poss = $items[imp unity ring, batskin belt, Jolly Roger Charrrm Bracelet, Glowing Red Eye, Jangly Bracelet, Pirate Fledges, Compression Stocking, Iron Beta of Industry, perfume-soaked bandana, World\'s Best Adventurer Sash, Hand In Glove, barrel hoop earring, Gumshoes, Caveman Dan\'s Favorite Rock];
	}
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc2])))
	{
		equip($slot[acc2], toEquip);
	}
}

void equipBaselineAcc3()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[ring of telling skeletons what to do, Glow-in-the-dark necklace, Glowing Red Eye, Xiblaxian Holo-Wrist-Puter, Badge Of Authority, Numberwang];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}
}


void equipRollover()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Hairpiece on Fire];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[hat])))
	{
		equip($slot[hat], toEquip);
	}


	toEquip = $item[none];
	poss = $items[Time Bandit Time Towel, Auxiliary Backbone];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[back])))
	{
		equip($slot[back], toEquip);
	}


	toEquip = $item[none];
	poss = $items[Sneaky Pete\'s Leather Jacket, Sneaky Pete\'s Leather Jacket (Collar Popped)];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[shirt])))
	{
		equip($slot[shirt], toEquip);
	}

	toEquip = $item[none];
	poss = $items[Chrome Sword, Sword Behind Inappropriate Prepositions, Time Sword, The Nuge\'s Favorite Crossbow];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[weapon])))
	{
		equip($slot[weapon], toEquip);
	}

	toEquip = $item[none];
	poss = $items[blue LavaCo Lamp&trade;, green LavaCo Lamp&trade;, red LavaCo Lamp&trade;, Silver Cow Creamer];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[off-hand])))
	{
		equip($slot[off-hand], toEquip);
	}

	toEquip = $item[none];
	poss = $items[Vicar\'s Tutu, Ninjammies, Pantaloons of Hatred, Ratskin Pajama Pants];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[pants])))
	{
		equip($slot[pants], toEquip);
	}
	equip($slot[acc1], $item[none]);
	equip($slot[acc2], $item[none]);
	equip($slot[acc3], $item[none]);

	toEquip = $item[none];
	poss = $items[Numberwang];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc1])))
	{
		equip($slot[acc1], toEquip);
	}

	toEquip = $item[none];
	poss = $items[Dead Guy\'s Watch, Sasq&trade; Watch];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc2])))
	{
		equip($slot[acc2], toEquip);
	}

	toEquip = $item[none];
	poss = $items[Gold Wedding Ring, Fudgecycle, Treads of Loathing];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}

	if(my_familiar() != $familiar[none])
	{
		toEquip = $item[none];
		poss = $items[Solid Shifting Time Weirdness];
		foreach thing in poss
		{
			if(possessEquipment(thing) && can_equip(thing))
			{
				toEquip = thing;
			}
		}
		if((toEquip != $item[none]) && (toEquip != equipped_item($slot[familiar])))
		{
			equip($slot[familiar], toEquip);
		}
	}
}
