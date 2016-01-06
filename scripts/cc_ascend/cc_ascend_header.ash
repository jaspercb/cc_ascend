script "cc_ascend_header.ash"

//	This is the primary (or will be) header file for cc_ascend.
//	All potentially cross-dependent functions should be defined here such that we can use them from
//	other scripts without the circular dependency issue. Thanks Ultibot for the advice regarding this.
//	Documentation can go here too, I suppose.
//	All functions that are defined outside of cc_ascend must include a note regarding where they come from
//		Seriously, it\'s rude not to.

//	Question Functions
//	Denoted as L<classification>[<path>]_<name>:
//		<classification>: Level to be used (Numeric, X for any). A for entire ascension.
//		<classification>: M for most of ascension, "sc" for Seal Clubber only
//		<path>: [optional] indicates path to be used in. "ed" for ed, "cs" for community service
//			Usually separated with _
boolean LA_cs_communityService();				//Defined in cc_ascend/cc_community_service.ash
boolean LM_edTheUndying();						//Defined in cc_ascend/cc_edTheUndying.ash

boolean LX_handleSpookyravenNecklace();
boolean LX_handleSpookyravenFirstFloor();
boolean LX_phatLootToken();
boolean LX_islandAccess();
boolean LX_fancyOilPainting();
boolean LX_setBallroomSong();
boolean LX_pirateOutfit();
boolean LX_pirateInsults();
boolean LX_pirateBlueprint();
boolean LX_pirateBeerPong();
boolean LX_fcle();
boolean LX_ornateDowsingRod();
boolean LX_getDictionary();
boolean LX_dictionary();
boolean LX_dinseylandfillFunbucks();
boolean LX_nastyBooty();
boolean LX_spookyravenSecond();
boolean LX_spookyBedroomCombat();
boolean LX_getDigitalKey();
boolean LX_guildUnlock();
boolean LX_hardcoreFoodFarm();
boolean LX_attemptPowerLevel();
boolean LX_bitchinMeatcar();

boolean Lsc_flyerSeals();

boolean L0_handleRainDoh();

boolean L1_ed_island();							//Defined in cc_ascend/cc_edTheUndying.ash
boolean L1_ed_dinsey();							//Defined in cc_ascend/cc_edTheUndying.ash
boolean L1_ed_island(int dickstabOverride);		//Defined in cc_ascend/cc_edTheUndying.ash
boolean L1_ed_islandFallback();					//Defined in cc_ascend/cc_edTheUndying.ash
boolean L2_mosquito();
boolean L2_treeCoin();
boolean L2_spookyMap();
boolean L2_spookyFertilizer();
boolean L2_spookySapling();

boolean L3_tavern();

boolean L4_batCave();
boolean L5_haremOutfit();
boolean L5_goblinKing();
boolean L5_getEncryptionKey();
boolean L6_friarsGetParts();
boolean L6_friarsHotWing();
boolean L8_trapperStart();
boolean L7_crypt();
boolean L8_trapperGround();
boolean L8_trapperYeti();
boolean L9_chasmStart();
boolean L9_chasmBuild();
boolean L9_highLandlord();
boolean L9_aBooPeak();
boolean L9_twinPeak();
boolean L9_oilPeak();
boolean L9_leafletQuest();

boolean L10_plantThatBean();
boolean L10_airship();
boolean L10_basement();
boolean L10_ground();
boolean L10_topFloor();
boolean L10_holeInTheSkyUnlock();
boolean L10_holeInTheSky();
boolean L11_palindome();
boolean L11_hiddenCity();
boolean L11_blackMarket();
boolean L11_forgedDocuments();
boolean L11_aridDesert();
boolean L11_mcmuffinDiary();
boolean L11_unlockHiddenCity();
boolean L11_hiddenCityZones();
boolean L11_talismanOfNam();
boolean L11_mauriceSpookyraven();
boolean L11_nostrilOfTheSerpent();
boolean L11_unlockPyramid();
boolean L11_unlockEd();
boolean L11_defeatEd();
boolean L11_getBeehive();
boolean L12_lastDitchFlyer();
boolean L12_flyerBackup();
boolean L12_flyerFinish();
boolean L12_preOutfit();
boolean L12_getOutfit();
boolean L12_startWar();
boolean L12_filthworms();
boolean L12_sonofaBeach();
boolean L12_sonofaFinish();
boolean L12_gremlins();
boolean L12_gremlinStart();
boolean L12_orchardFinalize();
boolean L12_orchardStart();
boolean L12_finalizeWar();
boolean L12_nunsTrickGlandGet();
boolean L13_sorceressDoor();
boolean L13_towerNSEntrance();
boolean L13_towerNSContests();
boolean L13_towerNSHedge();
boolean L13_towerNSTower();
boolean L13_towerNSNagamar();
boolean L13_towerNSTransition();
boolean L13_towerNSFinal();
boolean L13_ed_councilWarehouse();
boolean L13_ed_towerHandler();
boolean questOverride();


//
//	Primary adventuring functions, we need additonal functionality over adv1, so we do it here.
//	Note that, as of at least Mafia r16560, we can not use run_combat(<combat filter>).
//	Don\'t even try it, it requires a custom modification that we can not really do an ASH workaround for.

boolean ccAdv(location loc, string option);
boolean ccAdv(int num, location loc, string option);		//num is ignored
boolean ccAdv(int num, location loc);						//num is ignored
boolean ccAdvBypass(string url, location loc);
boolean ccAdvBypass(int snarfblat, location loc);
boolean ccAdvBypass(int snarfblat);
boolean ccAdvBypass(string url);


// Semi-rare Handlers:
boolean fortuneCookieEvent();

// Familiar Behavior, good stuff.
boolean handleFamiliar(familiar fam);

// Meat Generation
boolean autosellCrap();