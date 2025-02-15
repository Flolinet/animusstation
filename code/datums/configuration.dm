/datum/configuration
	var/server_name = null				// server name (for world name / status)
	var/server_suffix = 0				// generate numeric suffix based on server port

	var/log_ooc = 0						// log OOC channel
	var/log_access = 0					// log login/logout
	var/log_say = 0						// log client say
	var/log_admin = 0					// log admin actions
	var/log_game = 0					// log game events
	var/log_vote = 0					// log voting
	var/log_whisper = 0					// log client whisper
	var/log_emote = 0					// log emotes
	var/log_attack = 0					// log attack messages
	var/log_adminchat = 0				// log admin chat messages
	var/log_adminwarn = 0				// log warnings admins get about bomb construction and such
	var/log_pda = 0						// log pda messages
	var/sql_enabled = 1					// for sql switching
	var/allow_vote_restart = 0 			// allow votes to restart
	var/allow_vote_mode = 0				// allow votes to change mode
	var/allow_admin_jump = 1			// allows admin jumping
	var/allow_admin_spawning = 1		// allows admin item spawning
	var/allow_admin_rev = 1				// allows admin revives
	var/vote_delay = 600				// minimum time between voting sessions (seconds, 10 minute default)
	var/vote_period = 60				// length of voting period (seconds, default 1 minute)
	var/vote_no_default = 1				// If 1 people voting = 100% population. If 0 everyone = 100% population
	var/vote_no_dead = 0				// Dead people (can vote and) are accounted when calculating needed votes
//	var/enable_authentication = 0		// goon authentication
	var/del_new_on_log = 1				// del's new players if they log before they spawn in
	var/feature_object_spell_system = 0 //spawns a spellbook which gives object-type spells instead of verb-type spells for the wizard
	var/traitor_scaling = 0 			//if amount of traitors scales based on amount of players
	var/protect_roles_from_antagonist = 0// If security and such can be tratior/cult/other
	var/Tensioner_Active = 0			// If the tensioner is running.
	var/allow_Metadata = 0				// Metadata is supported.
	var/popup_admin_pm = 0				//adminPMs to non-admins show in a pop-up 'reply' window when set to 1.
	var/Ticklag = 0.9
	var/Tickcomp = 0
	var/no_taj = 0

	var/list/mode_names = list()
	var/list/modes = list()				// allowed modes
	var/list/votable_modes = list()		// votable modes
	var/list/probabilities = list()		// relative probability of each mode
	var/allow_random_events = 0			// enables random events mid-round when set to 1
	var/allow_ai = 1					// allow ai job
	var/hostedby = null
	var/respawn = 1
	var/guest_jobban = 1
	var/usewhitelist = 0
	var/kick_inactive = 0				//force disconnect for inactive players
	var/load_jobs_from_txt = 0

	var/server
	var/banappeals
	var/wikiurl
	var/forumurl
	var/serverid = "ss13_white"					//server ID for some SQL tables

	var/enter_whitelist = 0
	var/whitelist_error_message = ""

	var/maxPlayers = 0
	var/anotherServer = "unknown"
	var/redirect_if_full = null
//	var/whitelist_commissar = 0

	//Alert level description
	var/alert_desc_green = "All threats to the station have passed. Security may not have weapons visible, privacy laws are once again fully enforced."
	var/alert_desc_blue_upto = "The station has received reliable information about possible hostile activity on the station. Security staff may have weapons visible, random searches are permitted."
	var/alert_desc_blue_downto = "The immediate threat has passed. Security may no longer have weapons drawn at all times, but may continue to have them visible. Random searches are still allowed."
	var/alert_desc_red_upto = "There is an immediate serious threat to the station. Security may have weapons unholstered at all times. Random searches are allowed and advised."
	var/alert_desc_red_downto = "The self-destruct mechanism has been deactivated, there is still however an immediate serious threat to the station. Security may have weapons unholstered at all times, random searches are allowed and advised."
	var/alert_desc_delta = "The station's self-destruct mechanism has been engaged. All crew are instructed to obey all instructions given by heads of staff. Any violations of these orders can be punished by death. This is not a drill."

	var/forbid_singulo_possession = 0
	var/useircbot = 0

	//game_options.txt configs

	var/health_threshold_crit = 0
	var/health_threshold_dead = -100

	var/revival_pod_plants = 1
	var/revival_cloning = 1
	var/revival_brain_life = -1

/datum/configuration/New()
	var/list/L = typesof(/datum/game_mode) - /datum/game_mode
	for (var/T in L)
		// I wish I didn't have to instance the game modes in order to look up
		// their information, but it is the only way (at least that I know of).
		var/datum/game_mode/M = new T()

		if (M.config_tag)
			if(!(M.config_tag in modes))		// ensure each mode is added only once
				diary << "Adding game mode [M.name] ([M.config_tag]) to configuration."
				src.modes += M.config_tag
				src.mode_names[M.config_tag] = M.name
				src.probabilities[M.config_tag] = M.probability
				if (M.votable)
					src.votable_modes += M.config_tag
		del(M)
	src.votable_modes += "secret"

/datum/configuration/proc/load(filename, type = "config") //the type can also be game_options, in which case it uses a different switch. not making it separate to not copypaste code - Urist
	var/text = file2text(filename)

	if (!text)
		diary << "No [filename] file found, setting defaults"
		src = new /datum/configuration()
		return

	diary << "Reading configuration file [filename]"

	var/list/CL = dd_text2list(text, "\n")

	for (var/t in CL)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		if(type == "config")
			switch (name)
				if ("log_ooc")
					config.log_ooc = 1

				if ("log_access")
					config.log_access = 1

				if ("sql_enabled")
					config.sql_enabled = text2num(value)

				if ("log_say")
					config.log_say = 1

				if ("log_admin")
					config.log_admin = 1

				if ("log_game")
					config.log_game = 1

				if ("log_vote")
					config.log_vote = 1

				if ("log_whisper")
					config.log_whisper = 1

				if ("log_attack")
					config.log_attack = 1

				if ("log_emote")
					config.log_emote = 1

				if ("log_adminchat")
					config.log_adminchat = 1

				if ("log_adminwarn")
					config.log_adminwarn = 1

				if ("log_pda")
					config.log_pda = 1

				if ("allow_vote_restart")
					config.allow_vote_restart = 1

				if ("allow_vote_mode")
					config.allow_vote_mode = 1

				if ("allow_admin_jump")
					config.allow_admin_jump = 1

				if("allow_admin_rev")
					config.allow_admin_rev = 1

				if ("allow_admin_spawning")
					config.allow_admin_spawning = 1

				if ("no_dead_vote")
					config.vote_no_dead = 1

				if ("default_no_vote")
					config.vote_no_default = 1

				if ("vote_delay")
					config.vote_delay = text2num(value)

				if ("vote_period")
					config.vote_period = text2num(value)

				if ("allow_ai")
					config.allow_ai = 1

//				if ("authentication")
//					config.enable_authentication = 1

				if ("norespawn")
					config.respawn = 0

				if ("servername")
					config.server_name = value

				if ("serversuffix")
					config.server_suffix = 1

				if ("hostedby")
					config.hostedby = value

				if ("server")
					config.server = value

				if ("banappeals")
					config.banappeals = value

				if ("wikiurl")
					config.wikiurl = value

				if ("forumurl")
					config.forumurl = value

				if ("guest_jobban")
					config.guest_jobban = 1

				if ("usewhitelist")
					config.usewhitelist = 1

//				if ("whitelist_commissar")
//					config.whitelist_commissar = 1

				if ("feature_object_spell_system")
					config.feature_object_spell_system = 1

				if ("allow_metadata")
					config.allow_Metadata = 1

				if ("traitor_scaling")
					config.traitor_scaling = 1

				if("protect_roles_from_antagonist")
					config.protect_roles_from_antagonist = 1

				if("tensioner_active")
					config.Tensioner_Active = 1

				if ("probability")
					var/prob_pos = findtext(value, " ")
					var/prob_name = null
					var/prob_value = null

					if (prob_pos)
						prob_name = lowertext(copytext(value, 1, prob_pos))
						prob_value = copytext(value, prob_pos + 1)
						if (prob_name in config.modes)
							config.probabilities[prob_name] = text2num(prob_value)
						else
							diary << "Unknown game mode probability configuration definition: [prob_name]."
					else
						diary << "Incorrect probability configuration definition: [prob_name]  [prob_value]."

				if("allow_random_events")
					config.allow_random_events = 1

				if("kick_inactive")
					config.kick_inactive = 1

				if("load_jobs_from_txt")
					load_jobs_from_txt = 1

				if("enterwhitelist")
					config.enter_whitelist = 1
				if("whiteerrmsg")
					config.whitelist_error_message = value

				if ("serverid")
					config.serverid = value

				if ("max_players")
					config.maxPlayers = text2num(value)
				if ("another_server")
					config.anotherServer = value
				if ("redirect_if_full")
					config.redirect_if_full = value

				if("alert_red_upto")
					config.alert_desc_red_upto = value

				if("alert_red_downto")
					config.alert_desc_red_downto = value

				if("alert_blue_downto")
					config.alert_desc_blue_downto = value

				if("alert_blue_upto")
					config.alert_desc_blue_upto = value

				if("alert_green")
					config.alert_desc_green = value

				if("alert_delta")
					config.alert_desc_delta = value

				if("forbid_singulo_possession")
					forbid_singulo_possession = 1

				if("popup_admin_pm")
					config.popup_admin_pm = 1

				if("allow_holidays")
					Holiday = 1

				if("useircbot")
					useircbot = 1

				if("ticklag")
					Ticklag = text2num(value)

				if("tickcomp")
					Tickcomp = 1

				if("no_taj")
					no_taj = 1

				else
					diary << "Unknown setting in configuration: '[name]'"

		else if(type == "game_options")
			if(!value)
				diary << "Unknown value for setting [name] in [filename]."
			value = text2num(value)

			switch(name)
				if("health_threshold_crit")
					config.health_threshold_crit = value
				if("health_threshold_dead")
					config.health_threshold_dead = value
				if("revival_pod_plants")
					config.revival_pod_plants = value
				if("revival_cloning")
					config.revival_cloning = value
				if("revival_brain_life")
					config.revival_brain_life = value
				else
					diary << "Unknown setting in configuration: '[name]'"

/datum/configuration/proc/loadsql(filename)  // -- TLE
	var/text = file2text(filename)

	if (!text)
		diary << "No dbconfig.txt file found, retaining defaults"
		world << "No dbconfig.txt file found, retaining defaults"
		return

	diary << "Reading database configuration file [filename]"

	var/list/CL = dd_text2list(text, "\n")

	for (var/t in CL)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		switch (name)
			if ("address")
				sqladdress = value
			if ("port")
				sqlport = value
			if ("database")
				sqldb = value
			if ("login")
				sqllogin = value
			if ("password")
				sqlpass = value
			if ("feedback_database")
				sqlfdbkdb = value
			if ("feedback_login")
				sqlfdbklogin = value
			if ("feedback_password")
				sqlfdbkpass = value
			if ("enable_stat_tracking")
				sqllogging = 1
			else
				diary << "Unknown setting in configuration: '[name]'"

/datum/configuration/proc/loadforumsql(filename)  // -- TLE
	var/text = file2text(filename)

	if (!text)
		diary << "No forumdbconfig.txt file found, retaining defaults"
		world << "No forumdbconfig.txt file found, retaining defaults"
		return

	diary << "Reading forum database configuration file [filename]"

	var/list/CL = dd_text2list(text, "\n")

	for (var/t in CL)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		switch (name)
			if ("address")
				forumsqladdress = value
			if ("port")
				forumsqlport = value
			if ("database")
				forumsqldb = value
			if ("login")
				forumsqllogin = value
			if ("password")
				forumsqlpass = value
			if ("activatedgroup")
				forum_activated_group = value
			if ("authenticatedgroup")
				forum_authenticated_group = value
			else
				diary << "Unknown setting in configuration: '[name]'"

/datum/configuration/proc/pick_mode(mode_name)
	// I wish I didn't have to instance the game modes in order to look up
	// their information, but it is the only way (at least that I know of).
	for (var/T in (typesof(/datum/game_mode) - /datum/game_mode))
		var/datum/game_mode/M = new T()
		if (M.config_tag && M.config_tag == mode_name)
			return M
		del(M)
	return null

/datum/configuration/proc/get_runnable_modes()
	var/list/datum/game_mode/runnable_modes = new
	for (var/T in (typesof(/datum/game_mode) - /datum/game_mode))
		var/datum/game_mode/M = new T()
		//world << "DEBUG: [T], tag=[M.config_tag], prob=[probabilities[M.config_tag]]"
		if (!(M.config_tag in modes))
			del(M)
			continue
		if (probabilities[M.config_tag]<=0)
			del(M)
			continue
		if (M.can_start())
			runnable_modes[M] = probabilities[M.config_tag]
			//world << "DEBUG: runnable_mode\[[runnable_modes.len]\] = [M.config_tag]"
	return runnable_modes
