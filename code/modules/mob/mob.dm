/mob/proc/Cell()
	set category = "Admin"
	set hidden = 1

	if(!loc) return 0

	var/datum/gas_mixture/environment = loc.return_air()

	var/t = "\blue Coordinates: [x],[y] \n"
	t+= "\red Temperature: [environment.temperature] \n"
	t+= "\blue Nitrogen: [environment.nitrogen] \n"
	t+= "\blue Oxygen: [environment.oxygen] \n"
	t+= "\blue Plasma : [environment.toxins] \n"
	t+= "\blue Carbon Dioxide: [environment.carbon_dioxide] \n"
	for(var/datum/gas/trace_gas in environment.trace_gases)
		usr << "\blue [trace_gas.type]: [trace_gas.moles] \n"

	usr.show_message(t, 1)

/mob/proc/check_cache(ukey as text) // Checking the sound cache
	var/cached_users
	var/user
	cached_users = file2text("config/cached_users.txt") // Transfering text from a file to the variable
	user = findtext(cached_users,"  [ukey]  ",1) // Checking the key
	if (user == 0) // If there is no such key in the file, calling the cache_voice proc and adding the key to the textfile
		cache_voice()
		text2file("  [ukey]  ","config/cached_users.txt")

/mob/proc/cache_voice() //a proc to cache voice sound files, causes a certain lag, but happens quite rarely
	var/textfile
	textfile = file2text("config/voices.txt") //loading a textfile with all the sound files names
	var/findspace
	var/playsound
	for (var/i=0, i<700, i++) //playing all the sounds at minimum volume
		findspace = findtext(textfile," ")
		playsound = copytext(textfile,1,findspace) //getting a single word from the whole string
		playsound = addtext(addtext("sound/ai_voice/",playsound),".wav")
		usr << sound(playsound,0,0,0,0)
		textfile = copytext(textfile,findspace+1) //cutting out the word we just played
		if (findspace == 0) //end of a file, ending the loop
			break
/atom/proc/relaymove()
	return

/obj/effect/equip_e/process()
	return

/obj/effect/equip_e/proc/done()
	return

/obj/effect/equip_e/New()
	if (!ticker)
		del(src)
		return
	spawn(100)
		del(src)
		return
	..()
	return

/mob/proc/show_message(msg, type, alt, alt_type)//Message, type of message (1 or 2), alternative message, alt message type (1 or 2)
	if(!client)	return
	if (type)
		if ((type & 1 && (sdisabilities & 1 || (blinded || paralysis))))//Vision related
			if (!( alt ))
				return
			else
				msg = alt
				type = alt_type
		if ((type & 2 && (sdisabilities & 4 || ear_deaf)))//Hearing related
			if (!( alt ))
				return
			else
				msg = alt
				type = alt_type
				if ((type & 1 && sdisabilities & 1))
					return
	// Added voice muffling for Issue 41.
	if (stat == 1 || sleeping > 0)
		src << "<I>... You can almost hear someone talking ...</I>"
	else
		src << msg
	return

// Show a message to all mobs in sight of this one
// This would be for visible actions by the src mob
// message is the message output to anyone who can see e.g. "[src] does something!"
// self_message (optional) is what the src mob sees  e.g. "You do something!"
// blind_message (optional) is what blind people will hear e.g. "You hear something!"

/mob/visible_message(var/message, var/self_message, var/blind_message)
	for(var/mob/M in viewers(src))
		var/msg = message
		if(self_message && M==src)
			msg = self_message
		M.show_message( msg, 1, blind_message, 2)

// Show a message to all mobs in sight of this atom
// Use for objects performing visible actions
// message is output to anyone who can see, e.g. "The [src] does something!"
// blind_message (optional) is what blind people will hear e.g. "You hear something!"
/atom/proc/visible_message(var/message, var/blind_message)
	for(var/mob/M in viewers(src))
		M.show_message( message, 1, blind_message, 2)


/mob/proc/findname(msg)
	for(var/mob/M in world)
		if (M.real_name == text("[]", msg))
			return M
	return 0

/mob/proc/movement_delay()
	return 0

/mob/proc/Life()
//	if(organStructure)
//		organStructure.ProcessOrgans()
	return

/mob/proc/update_clothing()
	return

/mob/proc/restrained()
	if (handcuffed)
		return 1
	return

/mob/proc/db_click(text, t1)
	var/obj/item/weapon/W = equipped()
	switch(text)
		if("mask")
			if (wear_mask)
				return
			if (!( istype(W, /obj/item/clothing/mask) ))
				return
			u_equip(W)
			wear_mask = W
			W.equipped(src, text)
		if("back")
			if ((back || !( istype(W, /obj/item/weapon) )))
				return
			if (!( W.flags & 1 ))
				return
			u_equip(W)
			back = W
			W.equipped(src, text)
		else
	return



/mob/proc/drop_item_v()
	if (stat == 0)
		drop_item()
	return

/mob/proc/drop_from_slot(var/obj/item/item)
	if(!item)
		return
	if(!(item in contents))
		return
	u_equip(item)
	if (client)
		client.screen -= item
	if (item)
		item.loc = loc
		item.dropped(src)
		if (item)
			item.layer = initial(item.layer)
		var/turf/T = get_turf(loc)
		if (istype(T))
			T.Entered(item)
	return

/mob/proc/drop_item(var/atom/target)
	var/obj/item/W = equipped()

	if (W)
		u_equip(W)
		if (client)
			client.screen -= W
		if (W)
			W.layer = initial(W.layer)
			if(target)
				W.loc = target.loc
			else
				W.loc = loc
			W.dropped(src)
		var/turf/T = get_turf(loc)
		if (istype(T))
			T.Entered(W)
	return

/mob/proc/before_take_item(var/obj/item/item)
	item.loc = null
	item.layer = initial(item.layer)
	u_equip(item)
	//if (client)
	//	client.screen -= item
	//update_clothing()
	return

/mob/proc/get_active_hand()
	if (hand)
		return l_hand
	else
		return r_hand

/mob/proc/get_inactive_hand()
	if (!hand)
		return l_hand
	else
		return r_hand

/mob/proc/put_in_hand(var/obj/item/I)
	if(!I) return
	I.loc = src
	if (hand)
		l_hand = I
	else
		r_hand = I
	I.layer = 20
	update_clothing()

/mob/proc/put_in_inactive_hand(var/obj/item/I)
	I.loc = src
	if (!hand)
		l_hand = I
	else
		r_hand = I
	I.layer = 20
	update_clothing()

/mob/proc/reset_view(atom/A)
	if (client)
		if (istype(A, /atom/movable))
			client.perspective = EYE_PERSPECTIVE
			client.eye = A
		else
			if (isturf(loc))
				client.eye = client.mob
				client.perspective = MOB_PERSPECTIVE
			else
				client.perspective = EYE_PERSPECTIVE
				client.eye = loc
	return

/mob/proc/equipped()
	if(issilicon(src))
		if(isrobot(src))
			if(src:module_active)
				return src:module_active
	else
		if (hand)
			return l_hand
		else
			return r_hand
		return

/mob/proc/show_inv(mob/user as mob)
	user.machine = src
	var/dat = text("<TT>\n<B><FONT size=3>[]</FONT></B><BR>\n\t<B>Head(Mask):</B> <A href='?src=\ref[];item=mask'>[]</A><BR>\n\t<B>Left Hand:</B> <A href='?src=\ref[];item=l_hand'>[]</A><BR>\n\t<B>Right Hand:</B> <A href='?src=\ref[];item=r_hand'>[]</A><BR>\n\t<B>Back:</B> <A href='?src=\ref[];item=back'>[]</A><BR>\n\t[]<BR>\n\t[]<BR>\n\t[]<BR>\n\t<A href='?src=\ref[];item=pockets'>Empty Pockets</A><BR>\n<A href='?src=\ref[];mach_close=mob[]'>Close</A><BR>\n</TT>", name, src, (wear_mask ? text("[]", wear_mask) : "Nothing"), src, (l_hand ? text("[]", l_hand) : "Nothing"), src, (r_hand ? text("[]", r_hand) : "Nothing"), src, (back ? text("[]", back) : "Nothing"), ((istype(wear_mask, /obj/item/clothing/mask) && istype(back, /obj/item/weapon/tank) && !( internal )) ? text(" <A href='?src=\ref[];item=internal'>Set Internal</A>", src) : ""), (internal ? text("<A href='?src=\ref[];item=internal'>Remove Internal</A>", src) : ""), (handcuffed ? text("<A href='?src=\ref[];item=handcuff'>Handcuffed</A>", src) : text("<A href='?src=\ref[];item=handcuff'>Not Handcuffed</A>", src)), src, user, name)
	user << browse(dat, text("window=mob[];size=325x500", name))
	onclose(user, "mob[name]")
	return



/mob/proc/u_equip(W as obj)
	if (W == r_hand)
		r_hand = null
	else if (W == l_hand)
		l_hand = null
	else if (W == handcuffed)
		handcuffed = null
	else if (W == back)
		back = null
	else if (W == wear_mask)
		wear_mask = null
	update_clothing()
	return


//Attemps to remove an object on a mob.  Will not move it to another area or such, just removes from the mob.
/mob/proc/remove_from_mob(var/obj/O)
	src.u_equip(O)
	if (src.client)
		src.client.screen -= O
	O.layer = initial(O.layer)
	O.screen_loc = null
	return 1


/mob/proc/ret_grab(obj/effect/list_container/mobl/L as obj, flag)
	if ((!( istype(l_hand, /obj/item/weapon/grab) ) && !( istype(r_hand, /obj/item/weapon/grab) )))
		if (!( L ))
			return null
		else
			return L.container
	else
		if (!( L ))
			L = new /obj/effect/list_container/mobl( null )
			L.container += src
			L.master = src
		if (istype(l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = l_hand
			if (!( L.container.Find(G.affecting) ))
				L.container += G.affecting
				if (G.affecting)
					G.affecting.ret_grab(L, 1)
		if (istype(r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = r_hand
			if (!( L.container.Find(G.affecting) ))
				L.container += G.affecting
				if (G.affecting)
					G.affecting.ret_grab(L, 1)
		if (!( flag ))
			if (L.master == src)
				var/list/temp = list(  )
				temp += L.container
				//L = null
				del(L)
				return temp
			else
				return L.container
	return

/mob/verb/mode()
	set name = "Activate Held Object"
	set category = "IC"

	set src = usr

	var/obj/item/W = equipped()
	if (W)
		W.attack_self(src)
	return

/*
/mob/verb/dump_source()

	var/master = "<PRE>"
	for(var/t in typesof(/area))
		master += text("[]\n", t)
		//Foreach goto(26)
	src << browse(master)
	return
*/

/mob/verb/memory()
	set name = "Notes"
	set category = "OOC"
	if(mind)
		mind.show_memory(src)
	else
		src << "The game appears to have misplaced your mind datum, so we can't show you your notes."

/mob/verb/add_memory(msg as message)
	set name = "Add Note"
	set category = "OOC"

	msg = copytext(msg, 1, MAX_MESSAGE_LEN)
	msg = sanitize(msg)

	if(mind)
		mind.store_memory(msg)
	else
		src << "The game appears to have misplaced your mind datum, so we can't show you your notes."

/mob/proc/store_memory(msg as message, popup, sane = 1)
	msg = copytext(msg, 1, MAX_MESSAGE_LEN)

	if (sane)
		msg = sanitize(msg)

	if (length(memory) == 0)
		memory += msg
	else
		memory += "<BR>[msg]"

	if (popup)
		memory()

/*
/mob/verb/help()
	set name = "Help"
	src << browse('help.html', "window=help")
	return
*/

/mob/verb/abandon_mob()
	set name = "Respawn"
	set category = "OOC"

	if (!( abandon_allowed ))
		return
	if ((stat != 2 || !( ticker )))
		usr << "\blue <B>You must be dead to use this!</B>"
		return

	log_game("[usr.name]/[usr.key] used abandon mob.")

	usr << "\blue <B>Please roleplay correctly!</B>"

	if(!client)
		log_game("[usr.key] AM failed due to disconnect.")
		return
	for(var/obj/screen/t in usr.client.screen)
		if (t.loc == null)
			//t = null
			del(t)
	if(!client)
		log_game("[usr.key] AM failed due to disconnect.")
		return

	var/mob/new_player/M = new /mob/new_player()
	if(!client)
		log_game("[usr.key] AM failed due to disconnect.")
		del(M)
		return



	if(client && client.holder && (client.holder.state == 2))
		client.admin_play()
		return

	M.key = client.key
	M.Login()
	return

/mob/verb/cmd_rules()
	set name = "Rules"
	set category = "OOC"
	src << browse(rules, "window=rules;size=480x320")

/mob/verb/changes()
	set name = "Changelog"
	set category = "OOC"
	if (client)
		src.getFiles('postcardsmall.jpg',
							 'somerights20.png',
							 '88x31.png',
							 'bug-minus.png',
							 'cross-circle.png',
							 'hard-hat-exclamation.png',
							 'image-minus.png',
							 'image-plus.png',
							 'music-minus.png',
							 'music-plus.png',
							 'tick-circle.png',
							 'wrench-screwdriver.png',
							 'spell-check.png',
							 'burn-exclamation.png',
							 'chevron.png',
							 'chevron-expand.png',
							 'changelog.css',
							 'changelog.js'
							 )
		src << browse('changelog.html', "window=changes;size=675x650")
		client.changes = 1

/client/var/ghost_ears = 1
/client/verb/toggle_ghost_ears()
	set name = "Ghost ears"
	set category = "OOC"
	set desc = "Hear talks from everywhere"
	ghost_ears = !ghost_ears
	if (ghost_ears)
		usr << "\blue Now you hear all speech in the world"
	else
		usr << "\blue Now you hear speech only from nearest creatures."

/client/var/ghost_sight = 1
/client/verb/toggle_ghost_sight()
	set name = "Ghost sight"
	set category = "OOC"
	set desc = "Hear emotes from everywhere"
	ghost_sight = !ghost_sight
	if (ghost_sight)
		usr << "\blue Now you hear all emotes in the world"
	else
		usr << "\blue Now you hear emotes only from nearest creatures."



/mob/verb/observe()
	set name = "Observe"
	set category = "OOC"
	var/is_admin = 0

	if (client.holder && client.holder.level >= 1 && ( client.holder.state == 2 || client.holder.level > 3 ))
		is_admin = 1
	else if (istype(src, /mob/new_player) || stat != 2)
		usr << "\blue You must be observing to use this!"
		return

	if (is_admin && stat == 2)
		is_admin = 0

	var/list/names = list()
	var/list/namecounts = list()
	var/list/creatures = list()

	for (var/obj/item/weapon/disk/nuclear/D in world)
		var/name = "Nuclear Disk"
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		creatures[name] = D

	for (var/obj/machinery/singularity/S in world)
		var/name = "Singularity"
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		creatures[name] = S

	for (var/obj/machinery/bot/B in world)
		var/name = "BOT: [B.name]"
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		creatures[name] = B
/*
	for (var/mob/living/silicon/decoy/D in world)
		var/name = "[D.name]"
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		creatures[name] = D
*/



//THIS IS HOW YOU ADD OBJECTS TO BE OBSERVED

	creatures += getmobs()
//THIS IS THE MOBS PART: LOOK IN HELPERS.DM

	client.perspective = EYE_PERSPECTIVE

	var/eye_name = null

	if (is_admin)
		eye_name = input("Please, select a player!", "Admin Observe", null, null) as null|anything in creatures
	else
		eye_name = input("Please, select a player!", "Observe", null, null) as null|anything in creatures

	if (!eye_name)
		return

	var/mob/eye = creatures[eye_name]
	if (is_admin)
		if (eye)
			reset_view(eye)
			client.adminobs = 1
			if(eye == client.mob)
				client.adminobs = 0
		else
			reset_view(null)
			client.adminobs = 0
	else
		if(ticker)
//		 world << "there's a ticker"
			if(ticker.mode.name == "AI malfunction")
//				world << "ticker says its malf"
				var/datum/game_mode/malfunction/malf = ticker.mode
				for (var/datum/mind/B in malf.malf_ai)
//					world << "comparing [B.current] to [eye]"
					if (B.current == eye)
						for (var/mob/living/silicon/decoy/D in world)
							if (eye)
								eye = D
		if (client)
			if (eye)
				client.eye = eye
			else
				client.eye = client.mob

/mob/verb/cancel_camera()
	set name = "Cancel Camera View"
	set category = "OOC"
	reset_view(null)
	machine = null
	if(istype(src, /mob/living))
		if(src:cameraFollow)
			src:cameraFollow = null


/client/Topic(href, href_list)
	if(href_list["priv_msg"])
		var/client/C = locate(href_list["priv_msg"])
		if(ismob(C)) //Old stuff can pass in mobs instead of clients
			var/mob/M = C
			C = M.client
		cmd_admin_pm(C,null)
	else
		..()

/mob/Topic(href, href_list)
	if(href_list["priv_msg"])	//for priv_msg references that have yet to be updated to target clients. Forwards it to client/Topic()
		if(client)
			client.Topic(href, href_list)

	if(href_list["mach_close"])
		var/t1 = text("window=[href_list["mach_close"]]")
		machine = null
		src << browse(null, t1)
	..()
	return

/mob/proc/get_damage()
	return health

/mob/proc/UpdateLuminosity()
	if(src.total_luminosity == src.last_luminosity)	return 0//nothing to do here
	src.last_luminosity = src.total_luminosity
	sd_SetLuminosity(min(src.total_luminosity,7))//Current hardcode max at 7, should likely be a const somewhere else
	return 1

/mob/MouseDrop(mob/M as mob)
	..()
	if(M != usr) return
	if(usr == src) return
	if(get_dist(usr,src) > 1) return
	if(istype(M,/mob/living/silicon/ai)) return
	if(LinkBlocked(usr.loc,loc)) return
	show_inv(usr)

/atom/movable/verb/pull()
	set name = "Pull"
	set category = "IC"
	set src in oview(1)

	if (!( usr ))
		return

	if(ishuman(usr))
		if(usr.hand) // if he's using his left hand.
			var/datum/organ/external/temp = usr:get_organ("l_hand")
			if(temp.destroyed)
				usr << "\blue You look at your stump."
				return
		else
			var/datum/organ/external/temp = usr:get_organ("r_hand")
			if(temp.destroyed)
				usr << "\blue You look at your stump."
				return

	if (!( anchored ))
		usr.pulling = src
		if(ismob(src))
			var/mob/M = src
			if(!istype(usr, /mob/living/carbon))
				M.LAssailant = null
			else
				M.LAssailant = usr
	return

/atom/verb/examine()
	set name = "Examine"
	set category = "IC"
	set src in oview(12)	//make it work from farther away

	if (!( usr ))
		return
	usr << "That's \a [src]." //changed to "That's" from "This is" because "This is some metal sheets" sounds dumb compared to "That's some metal sheets" ~Carn
	usr << desc
	// *****RM
	//usr << "[name]: Dn:[density] dir:[dir] cont:[contents] icon:[icon] is:[icon_state] loc:[loc]"
	return

/client/New()
	if(findtextEx(key, "Telnet @"))
		src << "Sorry, this game does not support Telnet."
		del(src)

	addIdIp(ckey,computer_id,address)

	if (address in blockedip)
		del(src)

	if (config.enter_whitelist && !(ckey in enter_whitelist))
		alert(src, "You are not in whitelist!",null)
		src << config.whitelist_error_message
		del(src)

	var/isbanned = CheckBan(src)
	if (isbanned)
		log_access("Failed Login: [src] - Banned")
		message_admins("\blue Failed Login: [src] - Banned")
		src << "<font color=red>You have been banned.</font><br>Reason : [isbanned]"
		del(src)

	if (!guests_allowed && IsGuestKey(key))
		log_access("Failed Login: [src] - Guests not allowed")
		message_admins("\blue Failed Login: [src] - Guests not allowed")
		src << "<font color=red>You cannot play here.</font><br>Reason : Guests not allowed"
		del(src)

	if (((world.address == address || !(address)) && !(host)))
		host = key
		world.update_status()

	..()

	if (join_motd)
		src << "<div class=\"motd\">[join_motd]</div>"

//	authorize()				//old gooncode

	if(admins.Find(ckey))
		holder = new /obj/admins(src)
		holder.rank = admins[ckey]
		update_admins(admins[ckey])
	else
		var/hc = 0
		for (var/mob/M in world)
			if (!M.client)
				continue
			hc++
		if(config.maxPlayers && hc > config.maxPlayers)
			src << "<font color=red>Sorry, server is full!</font><br>Try another server: [config.anotherServer]"
			if(config.redirect_if_full)
				src << "<font color=green><b>Redirecting...</b></font>"
				src << link("byond://[config.redirect_if_full]")
			else
				del(src)

	log_access("Login: [key_name(src)] from [address ? address : "localhost"]")
	message_admins("User: [key_name(src)] logged in")

	if(ticker && ticker.mode && ticker.mode.name =="sandbox")
		mob.CanBuild()

/client/Del()
	spawn(0)
		if(holder)
			del(holder)
	return ..()

/mob/proc/can_use_hands()
	if(handcuffed)
		return 0
	if(buckled && ! istype(buckled, /obj/structure/stool/bed/chair)) // buckling does not restrict hands
		return 0
	return ..()

/mob/proc/is_active()
	return (0 >= usr.stat)

/mob/proc/see(message)
	if(!is_active())
		return 0
	src << message
	return 1

/mob/proc/show_viewers(message)
	for(var/mob/M in viewers())
		M.see(message)

/*
adds a dizziness amount to a mob
use this rather than directly changing var/dizziness
since this ensures that the dizzy_process proc is started
currently only humans get dizzy

value of dizziness ranges from 0 to 1000
below 100 is not dizzy
*/
/mob/proc/make_dizzy(var/amount)
	if(!istype(src, /mob/living/carbon/human)) // for the moment, only humans get dizzy
		return

	dizziness = min(1000, dizziness + amount)	// store what will be new value
													// clamped to max 1000
	if(dizziness > 100 && !is_dizzy)
		spawn(0)
			dizzy_process()


/*
dizzy process - wiggles the client's pixel offset over time
spawned from make_dizzy(), will terminate automatically when dizziness gets <100
note dizziness decrements automatically in the mob's Life() proc.
*/
/mob/proc/dizzy_process()
	is_dizzy = 1
	while(dizziness > 100)
		if(client)
			var/amplitude = dizziness*(sin(dizziness * 0.044 * world.time) + 1) / 70
			client.pixel_x = amplitude * sin(0.008 * dizziness * world.time)
			client.pixel_y = amplitude * cos(0.008 * dizziness * world.time)

		sleep(1)
	//endwhile - reset the pixel offsets to zero
	is_dizzy = 0
	if(client)
		client.pixel_x = 0
		client.pixel_y = 0

// jitteriness - copy+paste of dizziness

/mob/proc/make_jittery(var/amount)
	if(!istype(src, /mob/living/carbon/human)) // for the moment, only humans get dizzy
		return

	jitteriness = min(1000, jitteriness + amount)	// store what will be new value
													// clamped to max 1000
	if(jitteriness > 100 && !is_jittery)
		spawn(0)
			jittery_process()


// Typo from the oriignal coder here, below lies the jitteriness process. So make of his code what you will, the previous comment here was just a copypaste of the above.
/mob/proc/jittery_process()
	var/old_x = pixel_x
	var/old_y = pixel_y
	is_jittery = 1
	while(jitteriness > 100)
//		var/amplitude = jitteriness*(sin(jitteriness * 0.044 * world.time) + 1) / 70
//		pixel_x = amplitude * sin(0.008 * jitteriness * world.time)
//		pixel_y = amplitude * cos(0.008 * jitteriness * world.time)

		var/amplitude = min(4, jitteriness / 100)
		pixel_x = rand(-amplitude, amplitude)
		pixel_y = rand(-amplitude/3, amplitude/3)

		sleep(1)
	//endwhile - reset the pixel offsets to zero
	is_jittery = 0
	pixel_x = old_x
	pixel_y = old_y

/mob/Stat()
	..()

	statpanel("Status")

	if (client && client.holder)
		stat(null, "([x], [y], [z])")
		stat(null, "CPU: [world.cpu]")
		stat(null, "Controller: [controllernum]")
		if (master_controller)
			stat(null, "Current Iteration: [controller_iteration]")

	if (spell_list.len)

		for(var/obj/effect/proc_holder/spell/S in spell_list)
			switch(S.charge_type)
				if("recharge")
					statpanel("Spells","[S.charge_counter/10.0]/[S.charge_max/10]",S)
				if("charges")
					statpanel("Spells","[S.charge_counter]/[S.charge_max]",S)
				if("holdervar")
					statpanel("Spells","[S.holder_var_type] [S.holder_var_amount]",S)
	if(isys && isys.implants && isys.implants.len)
		for(var/I in isys.implants)
			statpanel("Implants", "[I:action] ", I)


// facing verbs
/mob/proc/canface()
	if(!canmove)						return 0
	if(client.moving)					return 0
	if(world.time < client.move_delay)	return 0
	if(stat==2)							return 0
	if(anchored)						return 0
	if(monkeyizing)						return 0
	if(restrained())					return 0
	return 1


/mob/verb/eastface()
	set hidden = 1
	if(!canface())	return 0
	dir = EAST
	client.move_delay += movement_delay()
	return 1


/mob/verb/westface()
	set hidden = 1
	if(!canface())	return 0
	dir = WEST
	client.move_delay += movement_delay()
	return 1


/mob/verb/northface()
	set hidden = 1
	if(!canface())	return 0
	dir = NORTH
	client.move_delay += movement_delay()
	return 1


/mob/verb/southface()
	set hidden = 1
	if(!canface())	return 0
	dir = SOUTH
	client.move_delay += movement_delay()
	return 1


/mob/proc/IsAdvancedToolUser()//This might need a rename but it should replace the can this mob use things check
	return 0

/mob/proc/createGeas()
/*
	var/obj/effect/stop/S
	for(var/obj/effect/stop/temp in loc)
		if(temp.victim == src)
			S = temp

	if(!S)
		S = new /obj/effect/stop
		S.victim = src
		S.loc = src.loc
		geaslist += S
*/
	return


/mob/proc/Stun(amount)
	if(canstun)
		stunned = max(max(stunned,amount),0) //can't go below 0, getting a low amount of stun doesn't lower your current stun
		if(stunned)
			createGeas()
	else
		if(istype(src, /mob/living/carbon/alien))	// add some movement delay
			var/mob/living/carbon/alien/Alien = src
			Alien.move_delay_add = min(Alien.move_delay_add + round(amount / 2), 10) // a maximum delay of 10
	return

/mob/proc/SetStunned(amount) //if you REALLY need to set stun to a set amount without the whole "can't go below current stunned"
	if(canstun)
		stunned = max(amount,0)
		if(stunned)
			createGeas()
	return

/mob/proc/AdjustStunned(amount)
	if(canstun)
		stunned = max(stunned + amount,0)
		if(stunned)
			createGeas()
	return

/mob/proc/Weaken(amount)
	if(canweaken)
		weakened = max(max(weakened,amount),0)
		if(weakened)
			createGeas()
	return

/mob/proc/SetWeakened(amount)
	if(canweaken)
		weakened = max(amount,0)
		if(weakened)
			createGeas()
	return

/mob/proc/AdjustWeakened(amount)
	if(canweaken)
		weakened = max(weakened + amount,0)
		if(weakened)
			createGeas()
	return

/mob/proc/Paralyse(amount)
	paralysis = max(max(paralysis,amount),0)
	if(paralysis)
		createGeas()
	return

/mob/proc/SetParalysis(amount)
	paralysis = max(amount,0)
	return
	if(paralysis)
		createGeas()

/mob/proc/AdjustParalysis(amount)
	paralysis = max(paralysis + amount,0)
	if(paralysis)
		createGeas()
	return

/mob/proc/Sleeping(amount)
	sleeping = max(max(sleeping,amount),0)
	if(sleeping)
		createGeas()
	return

/mob/proc/SetSleeping(amount)
	sleeping = max(amount,0)
	return
	if(sleeping)
		createGeas()


/mob/proc/AdjustSleeping(amount)
	sleeping = max(sleeping + amount,0)
	if(sleeping)
		createGeas()
	return

/mob/proc/Resting(amount)
	resting = max(max(resting,amount),0)
	if(resting)
		createGeas()
	return

/mob/proc/SetResting(amount)
	resting = max(amount,0)
	return
	if(resting)
		createGeas()

/mob/proc/AdjustResting(amount)
	resting = max(resting + amount,0)
	if(resting)
		createGeas()
	return


// ++++ROCKDTBEN++++ MOB PROCS -- Ask me before touching

/mob/proc/getBruteLoss()
	return bruteloss

/mob/proc/adjustBruteLoss(var/amount)
	bruteloss = max(bruteloss + amount, 0)

/mob/proc/getOxyLoss()
	return oxyloss

/mob/proc/adjustOxyLoss(var/amount)
	oxyloss = max(oxyloss + amount, 0)

/mob/proc/setOxyLoss(var/amount)
	oxyloss = amount

/mob/proc/getToxLoss()
	return toxloss

/mob/proc/adjustToxLoss(var/amount)
	toxloss = max(toxloss + amount, 0)

/mob/proc/setToxLoss(var/amount)
	toxloss = amount

/mob/proc/getFireLoss()
	return fireloss

/mob/proc/adjustFireLoss(var/amount)
	fireloss = max(fireloss + amount, 0)

/mob/proc/getCloneLoss()
	return cloneloss

/mob/proc/adjustCloneLoss(var/amount)
	cloneloss = max(cloneloss + amount, 0)

/mob/proc/setCloneLoss(var/amount)
	cloneloss = amount

/mob/proc/getHalLoss()
	return halloss

/mob/proc/adjustHalLoss(var/amount)
	halloss = max(halloss + amount, 0)

/mob/proc/setHalLoss(var/amount)
	halloss = amount



/mob/proc/getBrainLoss()
	return brainloss

/mob/proc/adjustBrainLoss(var/amount)
	brainloss = max(brainloss + amount, 0)

/mob/proc/setBrainLoss(var/amount)
	brainloss = amount

/mob/proc/getDNA()
	return dna

/mob/proc/setDNA(var/datum/dna/newDNA)
	dna = newDNA

/mob/proc/getMaxHealth()
	return maxHealth

/mob/proc/setMaxHealth(var/newMaxHealth)
	maxHealth = newMaxHealth

// ++++ROCKDTBEN++++ MOB PROCS //END

/*
 * Sends resource files to client cache
 */
/mob/proc/getFiles()
	if(!isemptylist(args))
		for(var/file in args)
			src << browse_rsc(file)
		return 1
	return 0