/obj/structure/closet/crate
	desc = "A crate."
	name = "Crate"
	icon = 'storage.dmi'
	icon_state = "crate"
	density = 1
	icon_opened = "crateopen"
	icon_closed = "crate"
	req_access = null
	opened = 0
	flags = FPRINT
//	mouse_drag_pointer = MOUSE_ACTIVE_POINTER	//???

/obj/structure/closet/crate/internals
	desc = "A internals crate."
	name = "Internals crate"
	icon = 'storage.dmi'
	icon_state = "o2crate"
	density = 1
	icon_opened = "o2crateopen"
	icon_closed = "o2crate"

/obj/structure/closet/crate/trashcart
	desc = "A heavy, metal trashcart with wheels."
	name = "Trash Cart"
	icon = 'storage.dmi'
	icon_state = "trashcart"
	density = 1
	icon_opened = "trashcartopen"
	icon_closed = "trashcart"

/obj/structure/closet/crate/hat
	desc = "A crate filled with Valuable Collector's Hats!."
	name = "Hat Crate"
	icon = 'storage.dmi'
	icon_state = "crate"
	density = 1
	icon_opened = "crateopen"
	icon_closed = "crate"

/obj/structure/closet/crate/contraband
	name = "Contraband crate"
	desc = "A random assortment of items manufactured by providers NOT listed under Nanotrasen's whitelist."
	icon = 'storage.dmi'
	icon_state = "crate"
	density = 1
	icon_opened = "crateopen"
	icon_closed = "crate"

/obj/structure/closet/crate/medical
	desc = "A medical crate."
	name = "Medical crate"
	icon = 'storage.dmi'
	icon_state = "medicalcrate"
	density = 1
	icon_opened = "medicalcrateopen"
	icon_closed = "medicalcrate"

/obj/structure/closet/crate/rcd
	desc = "A crate for the storage of the RCD."
	name = "RCD crate"
	icon = 'storage.dmi'
	icon_state = "crate"
	density = 1
	icon_opened = "crateopen"
	icon_closed = "crate"

/obj/structure/closet/crate/freezer
	desc = "A freezer."
	name = "Freezer"
	icon = 'storage.dmi'
	icon_state = "freezer"
	density = 1
	icon_opened = "freezeropen"
	icon_closed = "freezer"
	var
		target_temp = T0C - 40
		cooling_power = 40

	return_air()
		var/datum/gas_mixture/gas = (..())
		if(!gas)	return null
		var/datum/gas_mixture/newgas = new/datum/gas_mixture()
		newgas.oxygen = gas.oxygen
		newgas.carbon_dioxide = gas.carbon_dioxide
		newgas.nitrogen = gas.nitrogen
		newgas.toxins = gas.toxins
		newgas.volume = gas.volume
		newgas.temperature = gas.temperature
		if(newgas.temperature <= target_temp)	return

		if((newgas.temperature - cooling_power) > target_temp)
			newgas.temperature -= cooling_power
		else
			newgas.temperature = target_temp
		return newgas


/obj/structure/closet/crate/bin
	desc = "A large bin."
	name = "Large bin"
	icon = 'storage.dmi'
	icon_state = "largebin"
	density = 1
	icon_opened = "largebinopen"
	icon_closed = "largebin"

/obj/structure/closet/crate/radiation
	desc = "A crate with a radiation sign on it."
	name = "Radioactive gear crate"
	icon = 'storage.dmi'
	icon_state = "radiation"
	density = 1
	icon_opened = "radiationopen"
	icon_closed = "radiation"

/obj/structure/closet/crate/secure/weapon
	desc = "A secure weapons crate."
	name = "Weapons crate"
	icon = 'storage.dmi'
	icon_state = "weaponcrate"
	density = 1
	icon_opened = "weaponcrateopen"
	icon_closed = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = "A secure plasma crate."
	name = "Plasma crate"
	icon = 'storage.dmi'
	icon_state = "plasmacrate"
	density = 1
	icon_opened = "plasmacrateopen"
	icon_closed = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "A secure gear crate."
	name = "Gear crate"
	icon = 'storage.dmi'
	icon_state = "secgearcrate"
	density = 1
	icon_opened = "secgearcrateopen"
	icon_closed = "secgearcrate"

/obj/structure/closet/crate/secure/bin
	desc = "A secure bin."
	name = "Secure bin"
	icon_state = "largebins"
	icon_opened = "largebinsopen"
	icon_closed = "largebins"
	redlight = "largebinr"
	greenlight = "largebing"
	sparks = "largebinsparks"
	emag = "largebinemag"

/obj/structure/closet/crate/secure
	desc = "A secure crate."
	name = "Secure crate"
	icon_state = "securecrate"
	icon_opened = "securecrateopen"
	icon_closed = "securecrate"
	var/redlight = "securecrater"
	var/greenlight = "securecrateg"
	var/sparks = "securecratesparks"
	var/emag = "securecrateemag"
	var/broken = 0
	var/locked = 1

/obj/structure/closet/crate/hydroponics
	name = "Hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon = 'storage.dmi'
	icon_state = "hydrocrate"
	icon_opened = "hydrocrateopen"
	icon_closed = "hydrocrate"
	density = 1

/obj/structure/closet/crate/hydroponics/prespawned
	//This exists so the prespawned hydro crates spawn with their contents.
/*	name = "Hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon = 'storage.dmi'
	icon_state = "hydrocrate"
	icon_opened = "hydrocrateopen"
	icon_closed = "hydrocrate"
	density = 1*/
	New()
		..()
		new /obj/item/weapon/plantbgone(src)
		new /obj/item/weapon/plantbgone(src)
		new /obj/item/weapon/plantbgone(src)
		new /obj/item/weapon/hatchet(src)
		new /obj/item/weapon/minihoe(src)
//		new /obj/item/weapon/weedspray(src)
//		new /obj/item/weapon/weedspray(src)
//		new /obj/item/weapon/pestspray(src)
//		new /obj/item/weapon/pestspray(src)
//		new /obj/item/weapon/pestspray(src)

/obj/structure/closet/crate/New()
	..()
	spawn(1)
		if(!opened)		// if closed, any item at the crate's loc is put in the contents
			for(var/obj/item/I in src.loc)
				if(I.density || I.anchored || I == src) continue
				I.loc = src

/obj/structure/closet/crate/secure/New()
	..()
	if(locked)
		overlays = null
		overlays += redlight
	else
		overlays = null
		overlays += greenlight

/obj/structure/closet/crate/rcd/New()
	..()
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd(src)

/obj/structure/closet/crate/radiation/New()
	..()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/obj/structure/closet/crate/open()
	playsound(src.loc, 'click.ogg', 15, 1, -3)

	for(var/obj/O in src)
		O.loc = get_turf(src)

	for(var/mob/M in src)
		M.loc = get_turf(src)

	icon_state = icon_opened
	src.opened = 1

/obj/structure/closet/crate/close()
	playsound(src.loc, 'click.ogg', 15, 1, -3)

	for(var/obj/O in get_turf(src))
		if(O.density || O.anchored || O == src) continue
		O.loc = src

	icon_state = icon_closed
	src.opened = 0

/obj/structure/closet/crate/attack_hand(mob/user as mob)
	if(opened) close()
	else open()
	return

/obj/structure/closet/crate/secure/attack_hand(mob/user as mob)
	if(locked && !broken)
		if (allowed(user))
			user << "\blue You unlock the [src]."
			src.locked = 0
			overlays = null
			overlays += greenlight
			return
		else
			user << "\red It's locked."
			return
	else
		..()

/obj/structure/closet/crate/secure/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/card) && src.allowed(user) && !locked && !opened && !broken)
		user << "\red You lock the [src]."
		src.locked = 1
		overlays = null
		overlays += redlight
		return
	else if ( (istype(W, /obj/item/weapon/card/emag)||istype(W, /obj/item/weapon/melee/energy/blade)) && locked &&!broken)
		overlays = null
		overlays += emag
		overlays += sparks
		spawn(6) overlays -= sparks //Tried lots of stuff but nothing works right. so i have to use this *sadface*
		playsound(src.loc, "sparks", 60, 1)
		src.locked = 0
		src.broken = 1
		user << "\blue You unlock the [src]."
		return

	else if(istype(W, /obj/item/device/multitool) && !src.broken)
		var/obj/item/device/multitool/multi = W
		if(multi.is_used)
			user << "\red This multitool is already in use!"
			return
		multi.is_used = 1
		user << "\red Resetting circuitry(0/6)..."
		playsound(user, 'lockreset.ogg', 50, 1)
		var/obj/structure/closet/crate/secure/crat = src
		src = null
		if(do_mob(user, crat, 200))
			user << "\red Resetting circuitry(1/6)..."
			for(var/mob/O in viewers(world.view, user))
				if(O != user)
					O.show_message(text("\red <B>[] picks in wires of the [] with a multitool.</B>", user, crat), 1)
			if(do_mob(user, crat, 200))
				user << "\red Resetting circuitry(2/6)..."
				for(var/mob/O in viewers(world.view, user))
					if(O != user)
						O.show_message(text("\red <B>[] picks in wires of the [] with a multitool.</B>", user, crat), 1)
				if(do_mob(user, crat, 200))
					user << "\red Resetting circuitry(3/6)..."
					for(var/mob/O in viewers(world.view, user))
						if(O != user)
							O.show_message(text("\red <B>[] picks in wires of the [] with a multitool.</B>", user, crat), 1)
					if(do_mob(user, crat, 200))
						user << "\red Resetting circuitry(4/6)..."
						for(var/mob/O in viewers(world.view, user))
							if(O != user)
								O.show_message(text("\red <B>[] picks in wires of the [] with a multitool.</B>", user, crat), 1)
						if(do_mob(user, crat, 200))
							user << "\red Resetting circuitry(5/6)..."
							for(var/mob/O in viewers(world.view, user))
								if(O != user)
									O.show_message(text("\red <B>[] picks in wires of the [] with a multitool.</B>", user, crat), 1)
							if(do_mob(user, crat, 200))
								crat.locked = !crat.locked
								if(crat.locked)
									crat.overlays = null
									crat.overlays += crat.redlight
									user << "\blue You enable the locking modules."
									for(var/mob/O in viewers(world.view, user))
										if(O != user)
											O.show_message(text("\red <B>[] locks [] with a multitool.</B>", user, crat), 1)
								else
									crat.overlays = null
									crat.overlays += crat.greenlight
									user << "\blue You disable the locking modules."
									for(var/mob/O in viewers(world.view, user))
										if(O != user)
											O.show_message(text("\red <B>[] unlocks [] with a multitool.</B>", user, crat), 1)
		multi.is_used = 0
		return

	return ..()

/obj/structure/closet/crate/attack_paw(mob/user as mob)
	return attack_hand(user)

/obj/structure/closet/crate/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(opened)
		if(isrobot(user))
			return
		user.drop_item()
		if(W)
			W.loc = src.loc
	else if(istype(W, /obj/item/weapon/packageWrap))
		return
	else return attack_hand(user)

/obj/structure/closet/crate/secure/emp_act(severity)
	for(var/obj/O in src)
		O.emp_act(severity)
	if(!broken && !opened  && prob(50/severity))
		if(!locked)
			src.locked = 1
			overlays = null
			overlays += redlight
		else
			overlays = null
			overlays += emag
			overlays += sparks
			spawn(6) overlays -= sparks //Tried lots of stuff but nothing works right. so i have to use this *sadface*
			playsound(src.loc, 'sparks4.ogg', 75, 1)
			src.locked = 0
	if(!opened && prob(20/severity))
		if(!locked)
			open()
		else
			src.req_access = list()
			src.req_access += pick(get_all_accesses())
	..()


/obj/structure/closet/crate/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/obj/O in src.contents)
				del(O)
			del(src)
			return
		if(2.0)
			for(var/obj/O in src.contents)
				if(prob(50))
					del(O)
			del(src)
			return
		if(3.0)
			if (prob(50))
				del(src)
			return
		else
	return
