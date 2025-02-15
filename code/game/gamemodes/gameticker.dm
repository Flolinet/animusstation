var/global/datum/controller/gameticker/ticker

#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4


/datum/controller/gameticker
	var/const/restart_timeout = 250
	var/current_state = GAME_STATE_PREGAME

	var/hide_mode = 0
	var/datum/game_mode/mode = null
	var/event_time = null
	var/event = 0

	var/login_music			// music played in pregame lobby

	var/list/datum/mind/minds = list()//The people in the game. Used for objective tracking.

	var/Bible_icon_state	// icon_state the chaplain has chosen for his bible
	var/Bible_item_state	// item_state the chaplain has chosen for his bible
	var/Bible_name			// name of the bible
	var/Bible_deity_name

	var/random_players = 0 	// if set to nonzero, ALL players who latejoin or declare-ready join will have random appearances/genders


	var/pregame_timeleft = 0


/datum/controller/gameticker/proc/pregame()
	login_music = pick('title2.ogg','Parity.ogg','Spesschem.ogg','Zombienomad.ogg') // choose title music!

	do
		pregame_timeleft = 30
		world << "<B><FONT color='blue'>Welcome to the pre-game lobby!</FONT></B>"
		world << "Please, setup your character and select ready. Game will start in [pregame_timeleft] seconds"
		while(current_state == GAME_STATE_PREGAME)
			sleep(10)
			if(going)
				pregame_timeleft--

			if(pregame_timeleft <= 0)
				current_state = GAME_STATE_SETTING_UP
	while (!setup())

/datum/controller/gameticker/proc/setup()
	//Create and announce mode
	if(master_mode=="secret")
		src.hide_mode = 1
	var/list/datum/game_mode/runnable_modes
	if((master_mode=="random") || (master_mode=="secret"))
		runnable_modes = config.get_runnable_modes()
		if (runnable_modes.len==0)
			current_state = GAME_STATE_PREGAME
			world << "<B>Unable to choose playable game mode.</B> Reverting to pre-game lobby."
			return 0
		if(secret_force_mode != "secret")
			var/datum/game_mode/M = config.pick_mode(secret_force_mode)
			if(M.can_start())
				src.mode = config.pick_mode(secret_force_mode)
		job_master.ResetOccupations()
		if(!src.mode)
			src.mode = pickweight(runnable_modes)
		if(src.mode)
			var/mtype = src.mode.type
			src.mode = new mtype
	else
		src.mode = config.pick_mode(master_mode)

	if (!src.mode.can_start())
		world << "<B>Unable to start [mode.name].</B> Not enough players, [mode.required_players] players needed. Reverting to pre-game lobby."
		del(mode)
		current_state = GAME_STATE_PREGAME
		job_master.ResetOccupations()
		return 0

	//Configure mode and assign player to special mode stuff

	job_master.DivideOccupations() //Distribute jobs
	var/can_continue = src.mode.pre_setup()//Setup special modes
	if(!can_continue)
		del(mode)
		current_state = GAME_STATE_PREGAME
		world << "<B>Error setting up [master_mode].</B> Reverting to pre-game lobby."
		job_master.ResetOccupations()
		return 0

	if(hide_mode)
		var/list/modes = new
		for (var/datum/game_mode/M in runnable_modes)
			modes+=M.name
		modes = sortList(modes)
		world << "<B>The current game mode is - Secret!</B>"
		world << "<B>Possibilities:</B> [english_list(modes)]"
	else
		src.mode.announce()

	create_characters() //Create player characters and transfer them
	collect_minds()
	equip_characters()
	data_core.manifest()
	current_state = GAME_STATE_PLAYING

	spawn(0)//Forking here so we dont have to wait for this to finish
		mode.post_setup()
		//Cleanup some stuff
		for(var/obj/effect/landmark/start/S in world)
			//Deleting Startpoints but we need the ai point to AI-ize people later
			if (S.name != "AI")
				del(S)
		spawn(-1)
			world << "<FONT color='blue'><B>Enjoy the game!</B></FONT>"
			world << sound('welcome.ogg') // Skie
			//Holiday Round-start stuff	~Carn
			Holiday_Game_Start()

	start_events() //handles random events and space dust.

	spawn() supply_ticker() // Added to kick-off the supply shuttle regenerating points -- TLE

	//Start master_controller.process()
	spawn master_controller.process()
	if (config.sql_enabled)
		spawn(300)
		statistic_cycle() // Polls population totals regularly and stores them in an SQL DB -- TLE
	return 1

/datum/controller/gameticker
	//station_explosion used to be a variable for every mob's hud. Which was a waste!
	//Now we have a general cinematic centrally held within the gameticker....far more efficient!
	var/obj/screen/cinematic = null

	//Plus it provides an easy way to make cinematics for other events. Just use this as a template :)
	proc/station_explosion_cinematic(var/station_missed=0, var/override = null)
		if( cinematic )	return	//already a cinematic in progress!

		//initialise our cinematic screen object
		cinematic = new(src)
		cinematic.icon = 'station_explosion.dmi'
		cinematic.icon_state = "start"
		cinematic.layer = 20
		cinematic.mouse_opacity = 0
		cinematic.screen_loc = "1,3"	//TODO resize them

		var/obj/structure/stool/bed/temp_buckle = new(src)
		//Incredibly hackish. It creates a bed within the gameticker (lol) to stop mobs running around
		if(station_missed)
			for(var/mob/M in world)
				M.buckled = temp_buckle				//buckles the mob so it can't do anything
				if(M.client)
					M.client.screen += cinematic	//show every client the cinematic
		else	//nuke kills everyone on z-level 1 to prevent "hurr-durr I survived"
			for(var/mob/M in world)
				M.buckled = temp_buckle
				if(M.client)
					M.client.screen += cinematic
				switch(M.z)
					if(0)	//inside a crate or something
						var/turf/T = get_turf(M)
						if(T && T.z==1)				//we don't use M.death(0) because it calls a for(/mob) loop and
							M.health = 0
							M.stat = DEAD
					if(1)	//on a z-level 1 turf.
						M.health = 0
						M.stat = DEAD

		//Now animate the cinematic
		switch(station_missed)
			if(2)	//nuke was nowhere nearby	//TODO: a really distant explosion animation
				sleep(50)
				world << sound('explosionfar.ogg')

			if(1)	//nuke was nearby but (mostly) missed
				if( mode && !override )
					override = mode.name
				switch( override )
					if("nuclear emergency")
						flick("start_nuke",cinematic)
						sleep(50)
						world << sound('explosionfar.ogg')
						flick("explode2",cinematic)
						cinematic.icon_state = "loss_nuke2"
					else
						sleep(50)
						world << sound('explosionfar.ogg')
						flick("explode2",cinematic)

			else	//station was destroyed
				if( mode && !override )
					override = mode.name
				switch( override )
					if("nuclear emergency")
						flick("start_nuke",cinematic)
						sleep(50)
						world << sound('explosionfar.ogg')
						cinematic.icon_state = "end"
						flick("explode",cinematic)
						cinematic.icon_state = "loss_nuke"

					if("AI malfunction")
						flick("start_malf",cinematic)
						sleep(50)
						world << sound('explosionfar.ogg')
						cinematic.icon_state = "end"
						flick("explode",cinematic)
						cinematic.icon_state = "loss_malf"

					if("blob")
						flick("start_blob",cinematic)			//TODO: make a blob one
						sleep(50)
						world << sound('explosionfar.ogg')
						cinematic.icon_state = "end"
						flick("explode",cinematic)
						cinematic.icon_state = "loss_blob"		//TODO: make a blob one

					else
						//default station-destroyed ending
						sleep(50)
						world << sound('explosionfar.ogg')
						cinematic.icon_state = "end"
						flick("explode",cinematic)
						cinematic.icon_state = "loss_general"
		sleep(100)

		//Tidy-up time!
		if(cinematic)	del(cinematic)		//end the cinematic
		if(temp_buckle)	del(temp_buckle)	//release everybody
		return


	proc/create_characters()
		for(var/mob/new_player/player in world)
			if(player.ready)
				addJobsStartStatistics(player.key,player.mind.assigned_role,1)
				if(player.mind && player.mind.assigned_role=="AI")
					player.close_spawn_windows()
					player.AIize()
				else if(player.mind)
					player.create_character()
					del(player)


	proc/collect_minds()
		for(var/mob/living/player in world)
			if(player.mind)
				ticker.minds += player.mind


	proc/equip_characters()
		var/captainless=1
		for(var/mob/living/carbon/human/player in world)
			if(player && player.mind && player.mind.assigned_role)
				if(player.mind.assigned_role == "Captain")
					captainless=0
				if(player.mind.assigned_role != "MODE")
					job_master.EquipRank(player, player.mind.assigned_role, 0)
		if(captainless)
			world << "Captainship not forced on anyone."


	proc/process()
		if(current_state != GAME_STATE_PLAYING)
			return 0

		mode.process()

		emergency_shuttle.process()

		if(!mode.explosion_in_progress && mode.check_finished())
			current_state = GAME_STATE_FINISHED

			spawn
				declare_completion()

			spawn(50)
				if (mode.station_was_nuked)
					feedback_set_details("end_proper","nuke")
					world << "\blue <B>Rebooting due to destruction of station in [restart_timeout/10] seconds</B>"
				else
					feedback_set_details("end_proper","proper completion")
					world << "\blue <B>Restarting in [restart_timeout/10] seconds</B>"


				if(blackbox)
					blackbox.save_all_data_to_sql()

				sleep(restart_timeout)
				world.Reboot()

		return 1


/datum/controller/gameticker/proc/declare_completion()

	for (var/mob/living/silicon/ai/aiPlayer in world)
		if (aiPlayer.stat != 2)
			world << "<b>[aiPlayer.name] (Played by: [aiPlayer.key])'s laws at the end of the game were:</b>"
		else
			world << "<b>[aiPlayer.name] (Played by: [aiPlayer.key])'s laws when it was deactivated were:</b>"
		aiPlayer.show_laws(1)

		if (aiPlayer.connected_robots.len)
			var/robolist = "<b>The AI's loyal minions were:</b> "
			for(var/mob/living/silicon/robot/robo in aiPlayer.connected_robots)
				robolist += "[robo.name][robo.stat?" (Deactivated)  (Played by: [robo.key]), ":",  (Played by: [robo.key])"]"
			world << "[robolist]"

	for (var/mob/living/silicon/robot/robo in world)
		if (!robo.connected_ai)
			if (robo.stat != 2)
				world << "<b>[robo.name] (Played by: [robo.key]) survived as an AI-less borg! Its laws were:</b>"
			else
				world << "<b>[robo.name] (Played by: [robo.key]) was unable to survive the rigors of being a cyborg without an AI. Its laws were:</b>"
			robo.laws.show_laws(world)

	mode.declare_completion()//To declare normal completion.

	//calls auto_declare_completion_* for all modes
	for (var/handler in typesof(/datum/game_mode/proc))
		if (findtext("[handler]","auto_declare_completion_"))
			call(mode, handler)()

	return 1
