/obj/item/weapon/clipboard
	name = "clipboard"
	icon = 'bureaucracy.dmi'
	icon_state = "clipboard"
	item_state = "clipboard"
	throwforce = 0
	w_class = 2.0
	throw_speed = 3
	throw_range = 10
	var/obj/item/weapon/pen/haspen		//The stored pen.
	var/obj/item/weapon/paper/toppaper	//The topmost piece of paper.
	flags = FPRINT | TABLEPASS | ONBELT
	pressure_resistance = 10

/obj/item/weapon/clipboard/New()
	update_icon()

/obj/item/weapon/clipboard/MouseDrop(obj/over_object as obj) //Quick clipboard fix. -Agouri
	if(ishuman(usr) || ismonkey(usr)) //Can monkeys even place items in the pocket slots? Leaving this in just in case~
		var/mob/M = usr
		if (!(istype(over_object, /obj/screen) ))
			return ..()
		if((!(M.restrained()) && !(M.stat)))
			if(over_object.name == "r_hand")
				if(!(M.r_hand))
					M.u_equip(src)
					M.r_hand = src
			else
				if(over_object.name == "l_hand")
					if(!(M.l_hand))
						M.u_equip(src)
						M.l_hand = src
			M.update_clothing()
			src.add_fingerprint(usr)
			return

/obj/item/weapon/clipboard/update_icon()
	overlays = null
	if(toppaper)
		overlays += toppaper.icon_state
		overlays += toppaper.overlays
	if(haspen)
		overlays += "clipboard_pen"
	overlays += "clipboard_over"
	return

/obj/item/weapon/clipboard/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/paper))
		user.drop_item()
		W.loc = src
		toppaper = W
		user << "\blue You clip the paper onto the clipboard."
		update_icon()
	else if(toppaper)
		toppaper.attackby(usr.get_active_hand(), usr)
		update_icon()
	return

/obj/item/weapon/clipboard/attack_self(mob/user as mob)
	var/dat = "<title>Clipboard</title>"
	if (haspen)
		dat += "<A href='?src=\ref[src];pen=1'>Remove Pen</A><BR><HR>"
	else
		dat += "<A href='?src=\ref[src];addpen=1'>Add Pen</A><BR><HR>"

	//The topmost paper. I don't think there's any way to organise contents in byond, so this is what we're stuck with.	-Pete
	if(toppaper)
		var/obj/item/weapon/paper/P = toppaper
		dat += "<A href='?src=\ref[src];write=\ref[P]'>Write</A> <A href='?src=\ref[src];remove=\ref[P]'>Remove</A> - <A href='?src=\ref[src];read=\ref[P]'>[P.name]</A><BR><HR>"

		for(P in src)
			if(P == toppaper)
				continue
			dat += "<A href='?src=\ref[src];write=\ref[P]'>Write</A> <A href='?src=\ref[src];remove=\ref[P]'>Remove</A> <A href='?src=\ref[src];top=\ref[P]'>Move to top</A> - <A href='?src=\ref[src];read=\ref[P]'>[P.name]</A><BR>"
	user << browse(dat, "window=clipboard")
	onclose(user, "clipboard")
	add_fingerprint(usr)
	return

/obj/item/weapon/clipboard/Topic(href, href_list)
	..()
	if ((usr.stat || usr.restrained()))
		return

	if (usr.contents.Find(src))

		if(href_list["pen"])
			if(haspen)
				haspen.loc = usr.loc
				if(ishuman(usr))
					if(!usr.get_active_hand())
						usr.put_in_hand(haspen)
						haspen = null

		if(href_list["addpen"])
			if(!haspen)
				if(istype(usr.get_active_hand(), /obj/item/weapon/pen))
					var/obj/item/weapon/pen/W = usr.get_active_hand()
					usr.drop_item()
					W.loc = src
					haspen = W
					usr << "\blue You slot the pen into the clipboard."

		if(href_list["write"])
			var/obj/item/P = locate(href_list["write"])
			if(P)
				if(usr.get_active_hand())
					P.attackby(usr.get_active_hand(), usr)

		if(href_list["remove"])
			var/obj/item/P = locate(href_list["remove"])
			if(P)
				P.loc = usr.loc
				if(ishuman(usr))
					if(!usr.get_active_hand())
						usr.put_in_hand(P)
				else
					P.loc = get_turf(usr)
				if(P == toppaper)
					var/obj/item/weapon/paper/newtop = locate(/obj/item/weapon/paper in src)
					if(newtop && (newtop != toppaper))
						toppaper = newtop
					else
						toppaper = null

		if(href_list["read"])
			var/obj/item/weapon/paper/P = locate(href_list["read"])
			if(P)
				if(!(istype(usr, /mob/living/carbon/human) || istype(usr, /mob/dead/observer) || istype(usr, /mob/living/silicon)))
					usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY>[stars(P.info)][P.stamps]</BODY></HTML>", "window=[P.name]")
					onclose(usr, "[P.name]")
				else
					usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY>[P.info][P.stamps]</BODY></HTML>", "window=[P.name]")
					onclose(usr, "[P.name]")

		if(href_list["top"])
			var/obj/item/P = locate(href_list["top"])
			if(P)
				toppaper = P
				usr << "You move [P.name] to the top."

		//Update everything
		attack_self(usr)
		update_icon()
	return