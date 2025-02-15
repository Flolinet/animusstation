/obj/item/weapon/integrated_uplink
	name = "uplink module"
	desc = "An electronic uplink system of unknown origin."
	icon = 'module.dmi'
	icon_state = "power_mod"
	var/uses = 10
	var/obj/item/device/pda/hostpda = null
	var/orignote = null //Restore original notes when locked.
	var/active = 0 //Are we currently active??
	var/menu_message = ""
	var/lock_code = "password" //What's the password?
	var/traitor_job = null

//Communicate with traitor through the PDA's note function.
/obj/item/weapon/integrated_uplink/proc/print_to_host(var/text)
	if (isnull(hostpda))
		return
	hostpda.note = text

	for (var/mob/M in viewers(1, hostpda.loc))
		if (M.client && M.machine == hostpda)
			hostpda.attack_self(M)

	return

//Let's build a menu!
/obj/item/weapon/integrated_uplink/proc/generate_menu()
	menu_message = "<B>Syndicate Uplink Console:</B><BR>"
	menu_message += "Tele-Crystals left: [uses]<BR>"
	menu_message += "<HR>"
	menu_message += "<B>Request item:</B><BR>"
	menu_message += "<I>Each item costs a number of tele-crystals as indicated by the number following their name.</I><BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=revolver'>Revolver</A> (6)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=revolver_ammo'>Ammo-357</A> for use with Revolver (2)<BR>"
//	menu_message += "<A href='byond://?src=\ref[src];buy_item=suffocation_revolver_ammo'>Ammo-418</A> for use with Revolver (3)<BR>"	//This was useless and confusing -Pete
	menu_message += "<A href='byond://?src=\ref[src];buy_item=xbow'>Energy Crossbow</A> (5)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=sword'>Energy Sword</A> (4)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=jump'>Chameleon Jumpsuit</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=shoes'>Syndicate Shoes</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=card'>Syndicate Card</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=voice'>Voice-Changer</A> (4)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=imp_freedom'>Freedom Implant (with injector)</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=imp_uplink'>Uplink Implant (5 crystals inside)</A> (10)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=paralysispen'>Paralysis Pen</A> (3)<BR>" //Note that this goes to the updated sleepypen now.
//	menu_message += "<A href='byond://?src=\ref[src];buy_item=sleepypen'>Sleepy Pen</A> (5)<BR>" //Terrible -Pete.
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=detomatix'>Detomatix Cartridge</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=bomb'>Plastic Explosives</A> (2)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=spbomb'>Small Syndi Bomb (with detonator)</A> (4)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=lpbomb'>Medium Syndi Bomb(with detonator)</A> (7)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=powersink'>Power Sink</A> (5)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=space'>Syndicate-made Space Suit (inludes a helmet)</A> (3)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=projector'>Chameleon-projector</A> (4)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=cloak'>Cloaking Device</A> (4)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=emag'>Electromagnet Card</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=empbox'>5 EMP Grenades</A> (4)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=botchat'>Binary Translator</A> (3)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=lawmod'>Hacked AI Module</A> (7)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=singubeacon'>Singularity Beacon</A> (does not include a screwdriver) (7)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=toolbox'>Syndicate Toolbox</A> (Includes various tools) (1)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=soap'>Syndicate Soap</A> (1)<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=balloon'>Syndicate Balloon</A> (Useless) (10)<BR>"
	menu_message += "<BR>"
	menu_message += "<A href='byond://?src=\ref[src];buy_item=bundle'>Syndicate Bundle</A> (Contains an assorted selection of syndicate items)(10)<BR>"
	switch (traitor_job)
		if ("Clown")
			menu_message += "<A href='byond://?src=\ref[src];buy_item=clusterbang'>Clusterbang</A> (2)<BR>"
		if ("Atmospheric Technician")
			menu_message += "<A href='byond://?src=\ref[src];buy_item=t_valve'>Transfer Valve</A> (5)<BR>"
		if ("Scientist")
			menu_message += "<A href='byond://?src=\ref[src];buy_item=t_valve'>Transfer Valve</A> (5)<BR>"
		if ("Research Director")
			menu_message += "<A href='byond://?src=\ref[src];buy_item=t_valve'>Transfer Valve</A> (5)<BR>"
		if ("Geneticist")
			menu_message += "<A href='byond://?src=\ref[src];buy_item=gen_bundle'>Mutations Bundle</A> (6)<BR>"

	menu_message += "<HR>"
	return

/obj/item/weapon/integrated_uplink/proc/unlock()
	if ((isnull(hostpda)) || (active))
		return

	orignote = hostpda.note
	active = 1
	hostpda.mode = 1 //Switch right to the notes program

	generate_menu()
	print_to_host(menu_message)
	return

/obj/item/weapon/integrated_uplink/Topic(href, href_list)
	if ((isnull(hostpda)) || (!active))
		return

	if (usr.stat || usr.restrained() || !in_range(hostpda, usr))
		return

	if (href_list["buy_item"])
		switch(href_list["buy_item"])
			if("revolver")
				if (uses >= 6)
					uses -= 6
					new /obj/item/weapon/gun/projectile(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","RE")
			if("revolver_ammo")
				if (uses >= 2)
					uses -= 2
					new /obj/item/ammo_magazine/a357(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","RA")
			if("suffocation_revolver_ammo")
				if (uses >= 3)
					uses -= 3
					new /obj/item/ammo_magazine/a418(get_turf(hostpda))
			if("xbow")
				if (uses >= 5)
					uses -= 5
					new /obj/item/weapon/gun/energy/crossbow(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","XB")
			if("empbox")
				if (uses >= 4)
					uses -= 4
					new /obj/item/weapon/storage/emp_kit(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","EM")
			if("voice")
				if (uses >= 4)
					uses -= 4
					new /obj/item/clothing/mask/gas/voice(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","VC")
			if("jump")
				if (uses >= 3)
					uses -= 3
					new /obj/item/clothing/under/chameleon(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","CJ")
			if("shoes")
				if (uses >= 3)
					uses -= 3
					new /obj/item/clothing/shoes/syndigaloshes(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","SH")
			if("card")
				if (uses >= 3)
					uses -= 3
					new /obj/item/weapon/card/id/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","AC")
			if("emag")
				if (uses >= 3)
					uses -= 3
					new /obj/item/weapon/card/emag(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","EC")
			if("imp_freedom")
				if (uses >= 3)
					uses -= 3
					var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter(get_turf(hostpda))
					O.imp = new /obj/item/weapon/implant/freedom(O)
					feedback_add_details("traitor_uplink_items_bought","FI")
			if("imp_uplink")
				if (uses >= 10)
					uses -= 10
					var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter(get_turf(hostpda))
					O.imp = new /obj/item/weapon/implant/uplink(O)
					feedback_add_details("traitor_uplink_items_bought","UI")
			if("sleepypen")
				if (uses >= 5)
					uses -= 5
					new /obj/item/weapon/pen/sleepypen(get_turf(hostpda))
			if("paralysispen")
				if (uses >= 3)
					uses -= 3
					new /obj/item/weapon/pen/paralysis(get_turf(src))
					feedback_add_details("traitor_uplink_items_bought","PP")
			if("projector")
				if (uses >= 4)
					uses -= 4
					new /obj/item/device/chameleon(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","CP")
			if("cloak")
				if (uses >= 4)
					uses -= 4
					new /obj/item/weapon/cloaking_device(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","CD")
			if("sword")
				if (uses >= 4)
					uses -= 4
					new /obj/item/weapon/melee/energy/sword(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","ES")
			if("bomb")
				if (uses >= 2)
					uses -= 2
					new /obj/item/weapon/plastique(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","C4")
			if("powersink")
				if (uses >= 5)
					uses -= 5
					new /obj/item/device/powersink(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","PS")
			if("detomatix")
				if (uses >= 3)
					uses -= 3
					new /obj/item/weapon/cartridge/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","DC")
			if("space")
				if (uses >= 3)
					uses -= 3
					new /obj/item/clothing/suit/space/syndicate(get_turf(hostpda))
					new /obj/item/clothing/head/helmet/space/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","SS")
			if("lawmod")
				if (uses >= 7)
					uses -= 7
					new /obj/item/weapon/aiModule/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","AI")
			if("botchat")
				if (uses >= 3)
					uses -= 3
					new /obj/item/device/encryptionkey/binary(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","BT")
			if("singubeacon")
				if(uses >= 7)
					uses -= 7
					new /obj/machinery/singularity_beacon/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","SB")
			if("toolbox")
				if(uses)
					uses--
					new /obj/item/weapon/storage/toolbox/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","ST")
			if("soap")
				if(uses)
					uses--
					new /obj/item/weapon/soap/syndie(get_turf(src))
					feedback_add_details("traitor_uplink_items_bought","SP")
			if("balloon")
				if(uses >= 10)
					uses -= 10
					new /obj/item/toy/syndicateballoon(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","BS")
			if("spbomb")
				if (src.uses >= 4)
					src.uses -= 4
					new /obj/item/weapon/syndie/c4explosive(get_turf(hostpda))
			if("lpbomb")
				if (src.uses >= 7)
					src.uses -= 7
					new /obj/item/weapon/syndie/c4explosive/heavy(get_turf(hostpda))
			if("bundle")
				if(uses >= 10)
					uses -= 10
					new /obj/item/weapon/storage/box/syndicate(get_turf(hostpda))
					feedback_add_details("traitor_uplink_items_bought","BU")
			if("clusterbang")
				if(uses >= 2)
					uses -= 2
					new /obj/item/weapon/flashbang/clusterbang(get_turf(hostpda))
			if("t_valve")
				if(uses >= 5)
					uses -= 5
					new /obj/item/device/transfer_valve/syndie(get_turf(hostpda))
			if("gen_bundle")
				if(uses >= 6)
					uses -= 6
					new /obj/item/weapon/storage/box/gen_bundle/(get_turf(hostpda))

		generate_menu()
		print_to_host(menu_message)
		return

	return

/obj/item/weapon/integrated_uplink/proc/shutdown_uplink()
	if (isnull(src.hostpda))
		return
	active = 0
	hostpda.note = orignote
	if (hostpda.mode==1)
		hostpda.mode = 0
		hostpda.updateDialog()
	return