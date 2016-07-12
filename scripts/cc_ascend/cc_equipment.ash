script "cc_ascend/cc_equipment.ash";
import <cc_ascend/cc_util.ash>
import <cc_ascend/cc_ascend_header.ash>
void equipBaseline();
void equipBaselineWeapon();
void equipBaselinePants();
void equipBaselineBack();
void equipBaselineShirt();
void equipBaselineHat();
void equipBaselineAcc1();
void equipBaselineAcc2();
void equipBaselineAcc3();
void equipBaselineHolster();
void equipBaselineFam();
void equipBaselineHat(boolean wantNC);
void equipRollover();
void handleOffHand();
void removeNonCombat();
boolean handleBjornify(familiar fam);
void makeStartingSmiths();


//	Replace the current acc3 item (from baseline) with another. Mostly for our Xiblaxian handling so that is why this is the only one implemented.
void replaceBaselineAcc3();

void makeStartingSmiths()
{
	if(!have_skill($skill[Summon Smithsness]))
	{
		return;
	}

	if(item_amount($item[Lump of Brituminous Coal]) == 0)
	{
		if(my_mp() < (3 * mp_cost($skill[Summon Smithsness])))
		{
			print("You don't have enough MP for initialization, it might be ok but probably not.", "red");
		}
		use_skill(3, $skill[Summon Smithsness]);
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
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[seal-clubbing club]);
		}
		if(!possessEquipment($item[Vicar\'s Tutu]) && (item_amount($item[Lump of Brituminous Coal]) > 0) && knoll_available())
		{
			buy(1, $item[Frilly Skirt]);
			ccCraft("smith", 1, $item[Lump of Brituminous Coal], $item[Frilly Skirt]);
		}
		break;
	case $class[Turtle Tamer]:
		if(!possessEquipment($item[Work is a Four Letter Sword]))
		{
			buyUpTo(1, $item[Sword Hilt]);
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[sword hilt]);
		}
		if(!possessEquipment($item[Ouija Board\, Ouija Board]))
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[turtle totem]);
		}
		break;
	case $class[Sauceror]:
		if(!possessEquipment($item[Saucepanic]))
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[Saucepan]);
		}
		if(!possessEquipment($item[A Light that Never Goes Out]) && (item_amount($item[Lump of Brituminous Coal]) > 0))
		{
			ccCraft("smith", 1, $item[Lump of Brituminous Coal], $item[Third-hand Lantern]);
		}
		break;
	case $class[Pastamancer]:
		if(!possessEquipment($item[Hand That Rocks the Ladle]))
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[Pasta Spoon]);
		}
		break;
	case $class[Disco Bandit]:
		if(!possessEquipment($item[Frankly Mr. Shank]))
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[Disco Ball]);
		}
		break;
	case $class[Accordion Thief]:
		if(!possessEquipment($item[Shakespeare\'s Sister\'s Accordion]))
		{
			ccCraft("smith", 1, $item[lump of Brituminous coal], $item[Stolen Accordion]);
		}
		break;
	}

	if(knoll_available() && !possessEquipment($item[Hairpiece on Fire]) && (item_amount($item[lump of Brituminous Coal]) > 0))
	{
		ccCraft("smith", 1, $item[lump of Brituminous coal], $item[maiden wig]);
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
	foreach mySlot in $slots[]
	{
		if(equipped_item(mySlot) == equipment)
		{
			return true;
		}
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

	if(get_property("cc_100familiar").to_boolean() && (fam == my_familiar()))
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
	if(my_familiar() == $familiar[none])
	{
		if(my_bjorned_familiar() == $familiar[Grimstone Golem])
		{
			handleFamiliar("stat");
		}
		else if(my_bjorned_familiar() == $familiar[Grim Brother])
		{
			handleFamiliar("item");
		}
		else
		{
			handleFamiliar("item");
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
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Hot Plate, Spiked Femur, Yorick, Sawblade Shield, Wicker Shield, Keg Shield, Operation Patriot Shield, Ox-head Shield, Fake Washboard, Barrel Lid];
		}
		else
		{
			poss = $items[7-ball, 5-ball, 2-ball, 1-ball, Hot Plate, Disturbing Fanfic, Coffin Lid, Tesla\'s Electroplated Beans, Heavy-Duty Clipboard, Sawblade Shield, Wicker Shield, Keg Shield, Whatsian Ionic Pliers, Little Black Book, Yorick, Astral Shield, A Light That Never Goes Out, Astral Statuette, Operation Patriot Shield, Ox-head Shield, Fake Washboard, Barrel Lid];

			if(have_skill($skill[Beancannon]) && (get_property("_beancannonUsed").to_int() < 5))
			{
				poss = $items[7-ball, 5-ball, 2-ball, 1-ball, Hot Plate, Disturbing Fanfic, Coffin Lid, Astral Statuette, Heavy-Duty Clipboard, Sawblade Shield, Wicker Shield, Keg Shield, Whatsian Ionic Pliers, Little Black Book, Tesla\'s Electroplated Beans, World\'s Blackest-Eyed Peas, Trader Olaf\'s Exotic Stinkbeans, Shrub\'s Premium Baked Beans, Hellfire Spicy Beans, Frigid Northern Beans, Heimz Fortified Kidney Beans, Pork \'n\' Pork \'n\' Pork \'n\' Beans, Mixed Garbanzos and Chickpeas, Yorick, Astral Shield, A Light That Never Goes Out, Ox-head Shield, Operation Patriot Shield, Fake Washboard, Barrel Lid];
			}
		}
	}
	if(my_class() == $class[Turtle Tamer])
	{
		poss = $items[Sewer Turtle, Barskin Buckler, Turtle Wax Shield, Clownskin Buckler, Hot Plate, Box Turtle, Demon Buckler, Meat Shield, Gnauga Hide Buckler, Yakskin Buckler, Penguin Skin Buckler, Hippo Skin Buckler, Tortoboggan Shield, Padded Tortoise, Painted Shield, Spiky Turtle Shield, Wicker Shield, Catskin Buckler, Keg Shield, Ouija Board\, Ouija Board, Ox-head Shield, Barrel Lid, Operation Patriot Shield, Fake Washboard];
	}

	if(my_class() == $class[Pastamancer])
	{
		if((have_skill($skill[Double-Fisted Skull Smashing])) && (weapon_type(equipped_item($slot[weapon])) != $stat[Moxie]))
		{
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Spiked Femur, Wicker Shield, Keg Shield, Yorick, Ox-head Shield, Barrel Lid, Basaltamander Buckler, Operation Patriot Shield, Jarlsberg\'s Pan];
		}
		else
		{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Sawblade Shield, Wicker Shield, Keg Shield, Sticky Hand Whip, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Yorick, A Light That Never Goes Out, Ox-head Shield, Barrel Lid, Basaltamander Buckler, Operation Patriot Shield, Jarlsberg\'s Pan];
		}
	}

	if(my_class() == $class[Sauceror])
	{
			poss = $items[Hot Plate, Low-Budget Shield, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Sawblade Shield, Wicker Shield, Keg Shield, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Yorick, Ox-head Shield, Operation Patriot Shield, Jarlsberg\'s Pan, Barrel Lid, Basaltamander Buckler, A Light that Never Goes Out];
	}

	if(my_class() == $class[Disco Bandit])
	{
		if((have_skill($skill[Double-Fisted Skull Smashing])) && (weapon_type(equipped_item($slot[weapon])) != $stat[Moxie]))
		{
			poss = $items[Turtle Totem, Knob Goblin Scimitar, Sabre Teeth, Pitchfork, Cardboard Wakizashi, Oversized Pizza Cutter, Spiked Femur, Wicker Shield, Yorick, Keg Shield, Ox-head Shield, Barrel Lid, Operation Patriot Shield];
		}
		else
		{
			poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Heavy-Duty Clipboard, Sawblade Shield, Wicker Shield, Keg Shield, Whatsian Ionic Pliers, Little Black Book, Astral Shield, Astral Statuette, Yorick, Ox-head Shield, Operation Patriot Shield, Fake Washboard, A Light That Never Goes Out, Barrel Lid];
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
/*
	if(contains_text(holiday(), "Oyster Egg Day"))
	{
		poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid, Sawblade Shield, Wicker Shield, Keg Shield, Barrel Lid];
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
*/
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[off-hand])))
	{
		if((weapon_type(toEquip) != $stat[none]) && (equipped_item($slot[weapon]) == $item[none]))
		{
			return;
		}

		if(equipped_item($slot[weapon]) != toEquip)
		{
			equip($slot[Off-hand], toEquip);
		}
		else if((equipped_item($slot[weapon]) == toEquip) && (item_amount(toEquip) > 0))
		{
			equip($slot[Off-hand], toEquip);
		}
	}

}

void equipBaselineHat()
{
	equipBaselineHat(true);
}

void equipBaselinePants()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Old Sweatpants, Knob Goblin Harem Pants, three-legged pants, Knob Goblin Pants, Stylish Swimsuit, Filthy Corduroys, Demonskin Trousers, Antique Greaves, Ninja Hot Pants, Leotarrrd, Swashbuckling Pants, Vicar\'s Tutu, Troll Britches, Xiblaxian Stealth Trousers, Distressed Denim Pants, Troutsers, Bankruptcy Barrel, Astral Shorts, Pantsgiving];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[pants])))
	{
		equip($slot[pants],toEquip);
	}
}

void equipBaselineShirt()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Barskin Cloak, Harem Girl T-Shirt, Clownskin Harness, White Snakeskin Duster, Demonskin Jacket, Gnauga Hide Vest, Tuxedo Shirt, Grungy Flannel Shirt, Lynyrdskin Tunic, Surgical Apron, Punk Rock Jacket, Bat-Ass Leather Jacket, Yak Anorak, Astral Shirt, Stephen\'s Lab Coat, Sneaky Pete\'s Leather Jacket, Sneaky Pete\'s Leather Jacket (Collar Popped)];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[shirt])))
	{
		equip($slot[shirt],toEquip);
	}
}

void equipBaselineBack()
{
	item toEquip = $item[none];

	boolean[item] poss;

	if(my_class() == $class[Ed])
	{
		poss = $items[Black Cloak, Giant Gym Membership Card, Makeshift Cape, Misty Cloak, Misty Cape, Misty Robe, Camp Scout Backpack];
	}
	else
	{
		poss = $items[Whatsit-Covered Turtle Shell, Black Cloak, Pillow Shell, Oil Shell, Giant Gym Membership Card, Frozen Turtle Shell, Misty Cloak, Misty Cape, Misty Robe, Makeshift Cape, Polyester Parachute, Buddy Bjorn, Camp Scout Backpack];
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
		equip($slot[back],toEquip);
	}
}

void equipBaselineHat(boolean wantNC)
{
	item toEquip = $item[none];

	boolean[item] poss;
	poss = $items[Ravioli Hat, Hollandaise Helmet, Viking Helmet, Eyepatch, Oversized Skullcap, Dolphin King\'s Crown, Chef\'s Hat, Bellhop\'s Hat, Crown of the Goblin King, Van der Graaf helmet, Safarrri Hat, Mohawk Wig, Brown Felt Tophat, Mark I Steam-Hat, Mark II Steam-Hat, Cold Water Bottle, Beer Helmet, Mark III Steam-Hat, Mark IV Steam-Hat, Training Helmet, Fuzzy Earmuffs, Mark V Steam-Hat, Hairpiece On Fire, Reinforced Beaded Headband, Giant Yellow Hat, Very Pointy Crown, Boris\'s Helm, Boris\'s Helm (askew), The Crown of Ed the Undying];

	if(my_path() == "Avatar of West of Loathing")
	{
		poss = $items[Ravioli Hat, Hollandaise Helmet, Viking Helmet, Eyepatch, Dolphin King\'s Crown, Chef\'s Hat, Bellhop\'s Hat, Crown of the Goblin King, one-gallon hat, two-gallon hat, three-gallon hat, four-gallon hat, five-gallon hat, six-gallon hat, seven-gallon hat, Mohawk Wig, Brown Felt Tophat, eight-gallon hat, nine-gallon hat, ten-gallon hat, eleven-gallon hat, Safarrri Hat, Mark I Steam-Hat, Mark II Steam-Hat, Mark III Steam-Hat, Mark IV Steam-Hat, Training Helmet, Fuzzy Earmuffs, Mark V Steam-Hat, Hairpiece On Fire, Reinforced Beaded Headband, Giant Yellow Hat, Very Pointy Crown, The Crown of Ed the Undying];
	}
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if(wantNC)
	{
		if(possessEquipment($item[Very Pointy Crown]))
		{
			toEquip = $item[Very Pointy Crown];
		}
		else if(possessEquipment($item[Xiblaxian Stealth Cowl]))
		{
			toEquip = $item[Xiblaxian Stealth Cowl];
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[hat])))
	{
		equip($slot[hat],toEquip);
	}
}

void equipBaselineWeapon()
{
	item toEquip = $item[none];
	boolean[item] poss;

	switch(my_class())
	{
	case $class[Seal Clubber]:
		poss = $items[Seal-Clubbing Club, Gnollish Flyswatter, Club of Corruption, Remaindered Axe, Skeleton Bone, Corrupt Club of Corruption, Flaming Crutch, Homoerotic Frat-Paddle, Kneecapping Stick, Corrupt Club of Corrupt Corruption, Spiked Femur, Severed Flipper, Mannequin Leg, Infernal Toilet Brush, Hilarious Comedy Prop, Giant Foam Finger, Red Hot Poker, Maxwell\'s Silver Hammer, Elegant Nightstick, Oversized Pipe, Ghast Iron Cleaver, Frozen Seal Spine, Stainless Steel Shillelagh, Porcelain Police Baton, Fish Hatchet, Lead Pipe, Meat Tenderizer Is Murder, Dented Scepter];
		break;
	case $class[Turtle Tamer]:
		poss = $items[Turtle Totem, Witty Rapier, Antique Machete, Short-Handled Mop, Rope, Lead Pipe, Work Is A Four Letter Sword, Fish Hatchet, Garbage Sticker];
		break;
	case $class[Sauceror]:
		poss = $items[Saucepan, Dishrag, Corn Holder, Eggbeater, Cardboard Wakizashi, Witty Rapier, Thor\'s Pliers, Candlestick, Bass Clarinet, Saucepanic];
		break;
	case $class[Pastamancer]:
		poss = $items[Pasta Spoon, Dishrag, Corn Holder, Eggbeater, Cardboard Wakizashi, Witty Rapier, Thor\'s Pliers, Wrench, Bass Clarinet, Hand That Rocks The Ladle];
		break;
	case $class[Disco Bandit]:
		poss = $items[Knife, Bass Clarinet, Frankly Mr. Shank];
		break;
	case $class[Accordion Thief]:
		poss = $items[Revolver, accord ion, Bass Clarinet, Shakespeare\'s Sister\'s Accordion];
		break;
	case $class[Avatar of Boris]:
		poss = $items[Trusty];
		break;
	case $class[Ed]:
#		poss = $items[Titanium Assault Umbrella, Staff of Ed];
		poss = $items[Spiked Femur, Grassy Cutlass, Oversized Pizza Cutter, Titanium Assault Umbrella, Ocarina of Space, 7961, sewage-clogged pistol];
		break;
	case $class[Avatar of Jarlsberg]:
		poss = $items[Staff of the Standalone Cheese];
		break;
	case $class[Cow Puncher]:
		poss = $items[Seal-Clubbing Club, Gnollish Flyswatter, Club of Corruption, Remaindered Axe, Skeleton Bone, Corrupt Club of Corruption, Flaming Crutch, Homoerotic Frat-Paddle, Kneecapping Stick, Corrupt Club of Corrupt Corruption, Spiked Femur, Severed Flipper, Mannequin Leg, Infernal Toilet Brush, Hilarious Comedy Prop, Giant Foam Finger, Red Hot Poker, Maxwell\'s Silver Hammer, Elegant Nightstick, Oversized Pipe, Ghast Iron Cleaver, Frozen Seal Spine, Stainless Steel Shillelagh, Porcelain Police Baton, Lead Pipe, Meat Tenderizer Is Murder, Dented Scepter];
		break;
	case $class[Beanslinger]:
		poss = $items[Pasta Spoon, Cardboard Wakizashi, Dishrag, Corn Holder, Eggbeater, Oversized Pizza Cutter, Chopsticks, Thor\'s Pliers, Wrench];
		break;
	case $class[Snake Oiler]:
		poss = $items[Finger Cymbals, Double-Barreled Sling, Hilarious Comedy Prop, Space Tourist Phaser, Knife, Thor\'s Pliers, Frankly Mr. Shank];
		break;


	default:
		print("If you just started an ascension (Ed primarily) enter 'refresh all' and then restart", "red");
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

void equipBaselineFam()
{
	if(my_familiar() == $familiar[none])
	{
		return;
	}

	if(my_path() == "Heavy Rains")
	{
		if(item_amount($item[miniature life preserver]) > 0)
		{
			equip($slot[familiar], $item[miniature life preserver]);
			if(!is_familiar_equipment_locked() && boolean_modifier(equipped_item($slot[familiar]), "Generic"))
			{
				lock_familiar_equipment(true);
			}
		}
	}
	else
	{
		item toEquip = $item[none];

		boolean[item] poss = $items[Chocolate-stained Collar, Tiny Bowler, Guard Turtle Collar, Vicious Spiked Collar, Ant Hoe, Ant Pick, Ant Rake, Ant Pitchfork, Ant Sickle, Anniversary Tiny Latex Mask, Origami &quot;Gentlemen\'s&quot; Magazine, Tiny Fly Glasses, Annoying Pitchfork, Li\'l Businessman Kit, Lead Necklace, Flaming Familiar Doppelg&auml;nger, Wax Lips, Lucky Tam O\'Shanter, Lucky Tam O\'Shatner, Miniature Gravy-Covered Maypole, Kill Screen, Loathing Legion Helicopter, Little Box of Fireworks, Filthy Child Leash, Mayflower Bouquet, Plastic Pumpkin Bucket, Moveable Feast, Ittah Bittah Hookah, Snow Suit, Astral Pet Sweater];
		foreach thing in poss
		{
			if(possessEquipment(thing) && can_equip(thing))
			{
				toEquip = thing;
			}
		}

		if((toEquip != $item[none]) && (toEquip != equipped_item($slot[familiar])))
		{
			if(is_familiar_equipment_locked() && boolean_modifier(equipped_item($slot[familiar]), "Generic"))
			{
				lock_familiar_equipment(false);
			}
			equip($slot[familiar], toEquip);
		}
	}
	if(!is_familiar_equipment_locked() && boolean_modifier(equipped_item($slot[familiar]), "Generic"))
	{
		lock_familiar_equipment(true);
	}
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
	equipBaselineFam();
	equipBaselineHolster();

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
		if((item_amount($item[Kill Screen]) > 0) && (my_familiar() != $familiar[none]))
		{
			equip($slot[familiar], $item[Kill Screen]);
		}
	}
}

void equipBaselineAcc1()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Vampire Collar, Infernal Insoles, Batskin Belt, Ghost of a Necklace, Sphygmayomanometer, Numberwang, Astral Mask, Astral Belt, Bram\'s Choker, Astral Ring, Astral Bracer, Codpiece, Over-The-Shoulder Folder Holder];

	if(possessEquipment($item[barrel hoop earring]))
	{
		poss = $items[Vampire Collar, Infernal Insoles, Batskin Belt, Ghost of a Necklace, Sphygmayomanometer, Numberwang, Astral Mask, Astral Belt, Bram\'s Choker, Astral Ring, Astral Bracer, your cowboy boots, Over-The-Shoulder Folder Holder];
	}

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
		poss = $items[Jaunty Feather, Stuffed Shoulder Parrot, Glow-in-the-dark necklace, Glowing Red Eye, Bonerdagon Necklace, Batskin Belt, Jangly Bracelet, Pirate Fledges, Iron Beta of Industry, Your Cowboy Boots, Sphygmayomanometer, Barrel Hoop Earring, Codpiece, World\'s Best Adventurer Sash];
	}
	else
	{
		poss = $items[Jaunty Feather, Vampire Collar, Stuffed Shoulder Parrot, imp unity ring, garish pinky ring, batskin belt, Jolly Roger Charrrm Bracelet, Glowing Red Eye, Jangly Bracelet, Pirate Fledges, glow-in-the-dark necklace, Compression Stocking, Wicker Kickers, Iron Beta of Industry, Sphygmayomanometer, perfume-soaked bandana, your cowboy boots, World\'s Best Adventurer Sash, Hand In Glove, barrel hoop earring, Gumshoes, Caveman Dan\'s Favorite Rock, Battle Broom];
	}
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing) && (equipped_item($slot[acc1]) != thing))
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
	boolean[item] poss = $items[Jaunty Feather, ring of telling skeletons what to do, Glowing Red Eye, grumpy old man charrrm bracelet, Pirate Fledges, Plastic Detective Badge, Bronze Detective Badge, Mr. Accessory Jr., Silver Detective Badge, Gold Detective Badge, Glow-in-the-dark necklace, Xiblaxian Holo-Wrist-Puter, Sphygmayomanometer, Badge Of Authority, Codpiece, Mr. Cheeng\'s Spectacles, Numberwang, Barrel Hoop Earring];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing) && (equipped_item($slot[acc1]) != thing) && (equipped_item($slot[acc2]) != thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}
}

void replaceBaselineAcc3()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[ring of telling skeletons what to do, Glowing Red Eye, grumpy old man charrrm bracelet, Pirate Fledges, Glow-in-the-dark necklace, Xiblaxian Holo-Wrist-Puter, Badge Of Authority, Mr. Cheeng\'s Spectacles, Numberwang, Barrel Hoop Earring];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing) && (equipped_item($slot[acc1]) != thing) && (equipped_item($slot[acc2]) != thing) && (equipped_item($slot[acc3]) != thing))
		{
			toEquip = thing;
		}
	}
	if(toEquip == $item[none])
	{
		equip($slot[acc3], $item[none]);
	}
	else if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}
}

void equipBaselineHolster()
{
	if(my_path() != "Avatar of West of Loathing")
	{
		return;
	}

	item toEquip = $item[none];
	boolean[item] poss = $items[toy sixgun, rinky-dink sixgun, reliable sixgun, makeshift sixgun, custom sixgun, porquoise-handled sixgun, hamethyst-handled sixgun, baconstone-handled sixgun, Pecos Dave\'s sixgun];
	foreach thing in poss
	{
#		if(possessEquipment(thing) && can_equip(thing))
		if(possessEquipment(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[holster])))
	{
		equip($slot[holster], toEquip);
	}
}


void removeNonCombat()
{
	foreach sl in $slots[Hat, Weapon, Off-Hand, Back, Shirt, Pants, Acc1, Acc2, Acc3]
	{
		if(numeric_modifier(equipped_item(sl), "Combat Rate") < 0.0)
		{
			equip(sl, $item[none]);
		}
	}
}

void equipRollover()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Sea Cowboy Hat, Hairpiece on Fire, Spelunker\'s Fedora, Leather Aviator\'s Cap, Very Pointy Crown];
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
	poss = $items[Time Bandit Time Towel, Auxiliary Backbone, Octolus-Skin Cloak];
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
	poss = $items[General Sage\'s Lonely Diamonds Club Jacket, Sneaky Pete\'s Leather Jacket, Sneaky Pete\'s Leather Jacket (Collar Popped)];
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
	poss = $items[Ancient Calendar, Mer-kin stopwatch, Astral Statuette, blue LavaCo Lamp&trade;, green LavaCo Lamp&trade;, red LavaCo Lamp&trade;, Silver Cow Creamer, Ox-Head Shield, Royal Scepter];
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
	poss = $items[Paperclip Pants, Electronic Dulcimer Pants, Vicar\'s Tutu, Ninjammies, Pantaloons of Hatred, Ratskin Pajama Pants];
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
	poss = $items[BGE Pocket Calendar, Boots of Twilight Whispers, Numberwang];
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
	poss = $items[Dead Guy\'s Watch, Grandfather Watch, Sasq&trade; Watch];
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
	poss = $items[Gold Wedding Ring, Ticksilver Ring, Fudgecycle, Treads of Loathing];
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
