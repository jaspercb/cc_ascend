script "cc_summerfun.ash"

import<cc_util.ash>

boolean ocrs_initializeSettings()
{
	if(my_path() == "One Crazy Random Summer")
	{
		set_property("cc_spookyfertilizer", "");
		set_property("cc_getStarKey", true);
		set_property("cc_holeinthesky", true);
		set_property("cc_wandOfNagamar", true);
	}
	return true;
}
