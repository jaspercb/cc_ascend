script "kingLiberated.ash";
import <zlib.ash>
import <cc_util.ash>

void pullPVPJunk();

void handleKingLiberation()
{
	if((get_property("kingLiberated") == "true") && (get_property("cc_snapshot") == ""))
	{
		print("Yay! The King is saved. I suppose you should do stuff.");
		#visit_url("storage.php?action=pullall&pwd&");
		visit_url("storage.php?action=takemeat&pwd&amt=" + my_storage_meat());
		visit_url("storage.php?pwd&");
		put_display(item_amount($item[instant karma]), $item[instant karma]);
		put_display(item_amount($item[thwaitgold spider statuette]), $item[thwaitgold spider statuette]);
		put_display(item_amount($item[thwaitgold nit statuette]), $item[thwaitgold nit statuette]);
		put_display(item_amount($item[thwaitgold scarab beetle statuette]), $item[thwaitgold scarab beetle statuette]);

		if(my_familiar() != $familiar[Black Cat])
		{
			set_property("cc_100familiar", false);
		}

		print("Banishers: ", "green");
		print(get_property("cc_banishes_day1"), "blue");
		print(get_property("cc_banishes_day2"), "blue");
		print(get_property("cc_banishes_day3"), "blue");
		print("Yellow Rays: ", "green");
		print(get_property("cc_yellowRay_day1"), "blue");
		print(get_property("cc_yellowRay_day2"), "blue");
		print(get_property("cc_yellowRay_day3"), "blue");

		if(item_amount($item[wand of nagamar]) > 0)
		{
			cli_execute("untinker wand of nagamar");
		}

		pullAll($item[30669 scroll]);
		pullAll($item[33398 scroll]);
		pullAll($item[334 scroll]);
		pullAll($item[5-hour acrimony]);
		pullAll($item[64067 scroll]);
		pullAll($item[668 scroll]);
		pullAll($item[7-Foot Dwarven Mattock]);

		pullAll($item[angst burger]);
		pullAll($item[antique accordion]);
		pullAll($item[ass-stompers of violence]);
		pullAll($item[auxiliary backbone]);
		pullAll($item[backwoods banjo]);
		pullAll($item[bag o\' tricks]);
		pullAll($item[bag of park garbage]);
		pullAll($item[ball-in-a-cup]);
		pullAll($item[baneful bandolier]);

		pullAll($item[beach buck]);
		pullAll($item[beautiful rainbow]);
		pullAll($item[belt of loathing]);
		pullAndUse($item[bittycar meatcar], 1);
		pullAll($item[Boris\'s Helm]);
		pullAll($item[Boris\'s Helm (askew)]);
		pullAll($item[brand of violence]);
		pullAll($item[bricko eye brick]);
		pullAll($item[bricko brick]);
		pullAll($item[buddy bjorn]);
		pullAndUse($item[burrowgrub hive], 1);

		pullAll($item[camp scout backpack]);
		pullAll($item[can of rain-doh]);
		pullAll($item[carrot juice]);
		pullAll($item[carrot nose]);
		pullAll($item[caustic slime nodule]);
		pullAll($item[chamoisole]);
		pullAndUse($item[cheap toaster], 3);
		pullAndUse($item[chester\'s bag of candy], 1);
		pullAll($item[chibibuddy&trade; (on)]);
		pullAll($item[chibibuddy&trade; (off)]);
		pullAll($item[chroner]);
		pullAndUse($item[chroner cross], 1);
		pullAndUse($item[chroner trigger], 1);
		pullAll($item[claw of the infernal seal]);
		pullAll($item[cloak of dire shadows]);

		pullAll($item[The Cocktail Shaker]);
		pullAll($item[coinspiracy]);
		pullAll($item[cold stone of hatred]);
		pullAll($item[cold wad]);
		pullAll($item[confusing led clock]);
		pullAll($item[corroded breeches]);
		pullAll($item[corrosive cowl]);
		pullAll($item[crumpled felt fedora]);
		pullAll($item[csa fire-starting kit]);

		pullAll($item[das boot]);
		pullAll($item[diabolical crossbow]);
		pullAll($item[Dinsey\'s Brain]);
		pullAll($item[Dinsey\'s Glove]);
		pullAll($item[Dinsey\'s Oculus]);
		pullAll($item[Dinsey\'s Pants]);
		pullAll($item[Dinsey\'s Pizza Cutter]);
		pullAll($item[Dinsey\'s Radar Dish]);
		pullAll($item[dread tarragon]);

		pullAll($item[dreadful roast]);
		pullAll($item[drunkula\'s wineglass]);

		pullAll($item[electronic dulcimer pants]);
		pullAll($item[eleven-foot pole]);
		pullAll($item[empty agua de vida bottle]);
		pullAll($item[eternal car battery]);
		pullAll($item[Experimental Carbon Fiber Pasta Additive]);
		pullAll($item[Fake Washboard]);
		pullAll($item[fat loot token]);
		pullAndUse($item[festive warbear bank], 1);
		pullAll($item[filthy lucre]);

		pullAll($item[fishy pipe]);
		pullAll($item[Flaskfull of Hollow]);

		pullAll($item[fossilized necklace]);
		pullAll($item[Freddy Kruegerand]);
		pullAll($item[frying brainpan]);
		pullAll($item[fudgecycle]);
		pullAll($item[Funfunds&trade;]);
		pullAll($item[fuzzy slippers of hatred]);

		pullAll($item[game grid ticket]);
		pullAll($item[game grid token]);
		pullAll($item[Garbage Sticker]);
		pullAll($item[giant yellow hat]);
		pullAll($item[girdle of hatred]);

		pullAll($item[Glass Eye]);
		pullAndUse($item[glass gnoll eye], 1);
		pullAll($item[goggles of loathing]);
		pullAll($item[Golden Mr. Accessory]);

		pullAll($item[grandfather watch]);
		pullAll($item[Gravyskin Belt of the Sauceblob]);
		pullAll($item[great wolf\'s headband]);
		pullAll($item[Greatest American Pants]);
		pullAll($item[grisly shield]);
		pullAll($item[hairpiece on fire]);
		pullAll($item[handmade hobby horse]);
		pullAll($item[hardened slime belt]);
		pullAll($item[hardened slime hat]);
		pullAll($item[hardened slime pants]);
		pullAll($item[hobo nickel]);
		pullAll($item[holiday fun!]);
		pullAll($item[hot wad]);
		pullAll($item[instant karma]);
		pullAll($item[ittah bittah hookah]);
		pullAll($item[jarlsberg\'s pan]);
		pullAll($item[jarlsberg\'s pan (Cosmic Portal Mode)]);
		pullAll($item[jeans of loathing]);
		pullAll($item[Jewel-Eyed Wizard Hat]);
		pullAll($item[jodhpurs of violence]);
		pullAll($item[juju mojo mask]);
		pullAll($item[LARP Membership Card]);
		pullAll($item[leathery bat skin]);
		pullAll($item[the legendary beat]);
		pullAll($item[lens of hatred]);
		pullAll($item[lens of violence]);
		pullAll($item[lime]);
		pullAll($item[little wooden mannequin]);
		pullAll($item[llama lama gong]);
		pullAll($item[Loathing Legion Helicopter]);
		pullAll($item[Loathing Legion Jackhammer]);
		pullAll($item[Loathing Legion Knife]);
		pullAll($item[mace of the tortoise]);
		pullAll($item[Map to Kokomo]);
		pullAll($item[malevolent medallion]);
		pullAll($item[mayor ghost\'s scissors]);
		pullAll($item[mayfly bait necklace]);

		pullAll($item[mer-kin digpick]);
		pullAll($item[mer-kin gladiator mask]);
		pullAll($item[mer-kin gladiator tailpiece]);

		pullAll($item[Mercenary Pistol]);
		pullAll($item[Mesmereyes&trade; Contact Lenses]);

		pullAll($item[milk of magnesium]);
		pullAll($item[miner\'s helmet]);
		pullAll($item[miner\'s pants]);
		pullAll($item[Mr. Accessory]);
		pullAll($item[Mr. Accessory Jr.]);

		pullAll($item[mon tiki]);
		pullAll($item[moon-amber]);
		pullAll($item[nasty rat mask]);
		pullAll($item[Ninjammies]);
		pullAll($item[novelty belt buckle of violence]);

		pullAll($item[numberwang]);
		pullAll($item[odd silver coin]);
		pullAll($item[operation patriot shield]);
		pullAll($item[opium grenade]);
		pullAll($item[order of the silver wossname]);
		pullAll($item[ornamental sextant]);
		pullAll($item[oscus\'s dumpster waders]);
		pullAll($item[oscus\'s neverending soda]);
		pullAll($item[oscus\'s pelt]);
		pullAll($item[outrageous sombrero]);
		pullAll($item[Over-the-shoulder Folder Holder]);
		pullAll($item[pantaloons of hatred]);
		pullAll($item[pantsgiving]);
		pullAll($item[peppermint parasol]);
		pullAll($item[pernicious cudgel]);
		pullAll($item[Pick-O-Matic lockpicks]);
		pullAndUse($item[picky tweezers], 1);
		pullAll($item[pigsticker of violence]);
		pullAll($item[pocket square of loathing]);
		pullAll($item[poppy]);
		pullAll($item[possessed sugar cube]);
		pullAll($item[psychoanalytic jar]);
		pullAll($item[puppet strings]);

		pullAll($item[Ratskin Pajama Pants]);
		pullAll($item[red and green rain stick]);
		pullAll($item[reflection of a map]);
		pullAll($item[Ring of Detect Boring Doors]);
		pullAll($item[rubber spider]);

		pullAll($item[sand dollar]);
		pullAll($item[sasq&trade; watch]);
		pullAll($item[scepter of loathing]);

		pullAll($item[sea lasso]);
		pullAll($item[sea cowbell]);
		pullAll($item[sewing kit]);
		pullAll($item[set of jacks]);

		pullAll($item[shirt kit]);
		pullAll($item[Shore Inc. Ship Trip Scrip]);

		pullAll($item[silver cow creamer]);
		pullAll($item[Sister Accessory]);
		pullAll($item[sleaze wad]);
		pullAll($item[slime-covered club]);
		pullAll($item[slime-covered compass]);
		pullAll($item[slime-covered greaves]);
		pullAll($item[slime-covered helmet]);
		pullAll($item[slime-covered lantern]);
		pullAll($item[slime-covered necklace]);
		pullAll($item[slime-covered shovel]);
		pullAll($item[slime-covered speargun]);
		pullAll($item[slime-covered staff]);

		pullAll($item[Sneaky Pete\'s Leather Jacket]);
		pullAll($item[Sneaky Pete\'s Leather Jacket (Collar Popped)]);
		pullAll($item[snow suit]);

		pullAll($item[solid shifting time weirdness]);
		pullAll($item[Space Trip Safety Headphones]);
		pullAll($item[spooky putty sheet]);
		pullAll($item[spooky wad]);
		pullAll($item[staff of the scummy sink]);
		pullAll($item[staff of simmering hatred]);
		pullAll($item[stench wad]);
		pullAll($item[stinky cheese diaper]);
		pullAll($item[stinky cheese eye]);
		pullAll($item[stinky cheese sword]);
		pullAll($item[stinky cheese wheel]);


		pullAll($item[Stephen\'s Lab Coat]);
		pullAll($item[stick-knife of loathing]);
		pullAll($item[still-beating spleen]);
		pullAll($item[stinking agaricus]);
		pullAll($item[Stinky Fannypack]);
		pullAll($item[STYX Deodorant Body Spray]);

		pullAndUse($item[taco dan\'s taco stand flier], 1);
		pullAll($item[Tales of Spelunking]);
		pullAll($item[talisman of baio]);
		pullAll($item[Tenderizing Hammer]);
		pullAll($item[thor\'s pliers]);
		pullAll($item[time bandit time towel]);
		pullAll($item[time bandit badge of courage]);
		pullAll($item[time lord badge of honor]);
		pullAll($item[time shuriken]);
		pullAll($item[time sword]);
		pullAll($item[Time-twitching Toolbelt]);
		pullAll($item[tiny costume wardrobe]);
		pullAll($item[Toy Accordion]);
		pullAll($item[Travoltan trousers]);
		pullAll($item[Transmission from planet Xi]);
		pullAll($item[treads of loathing]);
		pullAndUse($item[Trivial Avocations Board Game], 1);
		pullAll($item[twinkly wad]);
		pullAll($item[unbearable light]);
		pullAll($item[Uncle Buck]);
		pullAll($item[unconscious collective dream jar]);
		pullAll($item[villainous scythe]);
		pullAll($item[Wand of Oscus]);
		pullAndUse($item[warbear breakfast machine], 1);
		pullAndUse($item[warbear soda machine], 1);
		pullAll($item[water wings for babies]);
		pullAll($item[Work is a Four Letter Sword]);
		pullAll($item[woven baling wire bracelets]);

		pullAll($item[Xiblaxian 5D printer]);
		pullAll($item[Xiblaxian Alloy]);
		pullAll($item[Xiblaxian Circuitry]);
		pullAll($item[xiblaxian holo-wrist-puter]);
		pullAll($item[Xiblaxian Polymer]);
		pullAll($item[Xiblaxian Stealth Cowl]);
		pullAll($item[zombo\'s empty eye]);

		if(item_amount($item[can of rain-doh]) > 0)
		{
			use(1, $item[can of rain-doh]);
		}


		pullPVPJunk();
/*
		if(item_amount($item[lime]) < 5)
		{
			buy(5 - item_amount($item[lime]), $item[lime]);
		}


		if(item_amount($item[boris\'s key]) > 0)
		{
			cli_execute("make boris's key lime");
		}
		if(item_amount($item[jarlsberg\'s key]) > 0)
		{
			cli_execute("make jarlsberg's key lime");
		}
		if(item_amount($item[sneaky pete\'s key]) > 0)
		{
			cli_execute("make sneaky pete's key lime");
		}
		if(item_amount($item[digital key]) > 0)
		{
			cli_execute("make digital key lime");
		}
		if(item_amount($item[Richard\'s Star Key]) > 0)
		{
			cli_execute("make star key lime");
		}
*/
//		visit_url("lair2.php?preaction=key&whichkey=436");

		visit_url("place.php?whichplace=desertbeach&action=db_nukehouse");
		#/goto store.php?whichstore=h &&
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
		visit_url("clan_rumpus.php?action=click&spot=1&furni=4");
		visit_url("clan_rumpus.php?action=click&spot=4&furni=2");
		visit_url("clan_rumpus.php?action=click&spot=9&furni=3");

		if(get_property("_clipartSummons").to_int() < 3)
		{
			cli_execute("make borrowed time");
		}
		if(get_property("_clipartSummons").to_int() < 3)
		{
			cli_execute("make " + (3 - get_property("_clipartSummons").to_int()) + " cold-filtered water");
		}

		if(get_property("cc_borrowedTimeOnLiberation").to_boolean() && (get_property("_borrowedTimeUsed") == "false"))
		{
			use(1, $item[borrowed time]);
		}

		if(item_amount($item[thor\'s pliers]) > 0)
		{
			int last = get_property("_thorsPliersCrafting").to_int();
			while((get_property("_thorsPliersCrafting").to_int() < 10) && ((item_amount($item[leathery bat skin]) > 0) || (mall_price($item[leathery bat skin]) < 800)))
			{
				if(item_amount($item[leathery bat skin]) == 0)
				{
					cli_execute("buy leathery bat skin");
				}
				cli_execute("buy shirt kit");
				cli_execute("make bat-ass leather jacket");
				int current = get_property("_thorsPliersCrafting").to_int();
				if(last == current)
				{
					break;
				}
				last = current;
			}
		}

		visit_url("campground.php?action=workshed");

		if(get_property("cc_snapshot") == "")
		{
			if(svn_info("bumcheekascend-snapshot").last_changed_rev > 0)
			{
				cli_execute("snapshot");
			}
			if(svn_info("ccascend-snapshot").last_changed_rev > 0)
			{
				cli_execute("cc_snapshot");
			}
			set_property("cc_snapshot", "done");
		}

		visit_url("place.php?whichplace=arcade&action=arcade_plumber");
		if(item_amount($item[defective game grid token]) > 0)
		{
			abort("Woohoo!!! You got a game grid tokON!!");
		}
	}

	if((get_property("kingLiberated") == "true") && (get_property("cc_aftercore") == ""))
	{
		buy_item($item[4-d camera], 1, 10000);
		buy_item($item[mojo filter], 2, 3500);
		buy_item($item[Cold Hi Mein], 9, 7000);
		buy_item($item[stone wool], 2, 3500);
		buy_item($item[drum machine], 1, 2500);
		buy_item($item[killing jar], 1, 500);
		buy_item($item[spooky-gro fertilizer], 1, 500);
#		buy_item($item[large box], 1, 3500);
#		buy_item($item[ring of teleportation], 1, 10000);
		buy_item($item[stunt nuts], 1, 500);
		buy_item($item[wet stew], 1, 3500);
		buy_item($item[star chart], 1, 500);
		buy_item($item[milk of magnesium], 2, 1200);
		buy_item($item[Boris\'s Key Lime Pie], 1, 8500);
		buy_item($item[Jarlsberg\'s Key Lime Pie], 1, 8500);
		buy_item($item[Sneaky Pete\'s Key Lime Pie], 1, 8500);
#		buy_item($item[Digital Key Lime Pie], 1, 8500);
		buy_item($item[Star Key Lime Pie], 3, 8500);
		buy_item($item[Ice Island Long Tea], 1, 9500);
		buy_item($item[Crystal Skeleton Vodka], 1, 9500);
		buy_item($item[The Big Book of Pirate insults], 1, 600);
		buy_item($item[hand in glove], 1, 5000);


		if(get_property("cc_dickstab").to_boolean())
		{
			while(item_amount($item[Shore Inc. Ship Trip Scrip]) < 3)
			{
				adventure(1, $location[The Shore\, Inc. Travel Agency]);
			}
			buy_item($item[frost flower], 1, 50000);
		}

		if(!have_familiar($familiar[grimstone golem]))
		{
			buy_item($item[grimstone mask], 0, 7500);
		}

		if(have_skill($skill[Iron Palm Technique]) && (have_effect($effect[Iron Palms]) == 0))
		{
			use_skill(1, $skill[Iron Palm Technique]);
		}

#		buy_item($item[Broberry Brogurt], 1, 50000);
#		buy_item($item[dumb mud], 5, 8500);

		set_property("cc_aftercore", "done");
	}

	print("King Liberation Complete. Thank you for playing", "blue");
	if(get_property("cc_dickstab").to_boolean())
	{
		print("Remember to get Shore Scrip!!", "red");
	}
	if(get_property("cc_clearCombatScripts").to_boolean())
	{
		set_property("kingLiberatedScript", "");
		set_property("afterAdventureScript", "");
		set_property("betweenAdventureScript", "");
	}
}


void pullPVPJunk()
{

}

void main(){
	handleKingLiberation();
}
