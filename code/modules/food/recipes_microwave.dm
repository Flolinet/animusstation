
// see code/datums/recipe.dm

/datum/recipe/telebacon
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/device/assembly/signaler
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/telebacon

/datum/recipe/syntitelebacon
	items = list(
		/obj/item/weapon/syntiflesh,
		/obj/item/device/assembly/signaler
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/telebacon

/datum/recipe/friedegg
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/friedegg

/datum/recipe/boiledegg
	reagents = list("water" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/boiledegg

/*
/datum/recipe/bananaphone
	reagents = list("psilocybin" = 5) //Trippin' balls, man.
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana,
		/obj/item/device/radio
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/bananaphone
*/

/datum/recipe/jellydonut
	reagents = list("berryjuice" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/jellydonut

/datum/recipe/donut
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/donut

/datum/recipe/human
	//invalid recipe
	make_food(var/obj/container as obj)
		var/human_name
		var/human_job
		for (var/obj/item/weapon/reagent_containers/food/snacks/meat/human/HM in container)
			if (!HM.subjectname)
				continue
			human_name = HM.subjectname
			human_job = HM.subjectjob
			break
		var/lastname_index = findtext(human_name, " ")
		if (lastname_index)
			human_name = copytext(human_name,lastname_index+1)

		var/obj/item/weapon/reagent_containers/food/snacks/human/HB = ..(container)
		HB.name = human_name+HB.name
		HB.job = human_job
		return HB

/datum/recipe/human/burger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat/human
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/human/burger

/*
/datum/recipe/monkeyburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat/monkey
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeyburger
*/

/datum/recipe/plainburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat //do not place this recipe before /datum/recipe/humanburger
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeyburger

/datum/recipe/syntiburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/syntiflesh
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeyburger

/datum/recipe/brainburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/brain
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/brainburger

/* NO FUN ALLOWED
/datum/recipe/roburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/robot_parts/head
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/roburger
*/

/datum/recipe/xenoburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/xenoburger

/datum/recipe/fishburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/carpmeat
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/fishburger

/datum/recipe/tofuburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/tofu
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/tofuburger

/datum/recipe/ghostburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/ectoplasm
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/ghostburger

/datum/recipe/clownburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/clothing/mask/gas/clown_hat,
		/* /obj/item/weapon/reagent_containers/food/snacks/grown/banana, */
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/clownburger

/datum/recipe/mimeburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/clothing/head/beret
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/mimeburger

/datum/recipe/waffles
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/waffles

/*
/datum/recipe/faggot
	monkeymeat_amount = 1
	humanmeat_amount = 1
	creates = "/obj/item/weapon/reagent_containers/food/snacks/faggot"
*/

/datum/recipe/donkpocket
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/donkpocket //SPECIAL
	proc/warm_up(var/obj/item/weapon/reagent_containers/food/snacks/donkpocket/being_cooked)
		being_cooked.warm = 1
		being_cooked.reagents.add_reagent("tricordrazine", 5)
		being_cooked.bitesize = 6
		being_cooked.name = "Warm " + being_cooked.name
		being_cooked.cooltime()
	make_food(var/obj/container as obj)
		var/obj/item/weapon/reagent_containers/food/snacks/donkpocket/being_cooked = ..(container)
		warm_up(being_cooked)
		return being_cooked

/datum/recipe/donkpocket/warm
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/donkpocket
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/donkpocket //SPECIAL
	make_food(var/obj/container as obj)
		var/obj/item/weapon/reagent_containers/food/snacks/donkpocket/being_cooked = locate() in container
		if(being_cooked && !being_cooked.warm)
			warm_up(being_cooked)
		return being_cooked

/datum/recipe/meatbread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/meatbread

/datum/recipe/syntibread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/meatbread

/*
/datum/recipe/meatbreadhuman
	flour_amount = 3
	humanmeat_amount = 3
	cheese_amount = 3
	creates = "/obj/item/weapon/reagent_containers/food/snacks/meatbread"
*/

/datum/recipe/xenomeatbread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat,
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat,
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/xenomeatbread

/datum/recipe/bananabread
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/bananabread

/datum/recipe/omelette
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/omelette

/datum/recipe/muffin
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/muffin

/datum/recipe/eggplantparm
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/eggplantparm

/datum/recipe/soylenviridians
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/soybeans
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/soylenviridians

/datum/recipe/soylentgreen
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat/human,
		/obj/item/weapon/reagent_containers/food/snacks/meat/human,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/soylentgreen

/datum/recipe/carrotcake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot //TODO: more carrots
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/carrotcake

/datum/recipe/cheesecake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/cheesecake

/datum/recipe/plaincake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/plaincake

/datum/recipe/meatpie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/meatpie

/datum/recipe/tofupie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/tofupie

/datum/recipe/xemeatpie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/xemeatpie

/datum/recipe/pie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		 /obj/item/weapon/reagent_containers/food/snacks/grown/banana,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/pie
/*
/datum/recipe/berrypie
	reagents = list("berryjuice" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/berrypie
*/
/datum/recipe/berryclafoutis
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/berries,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/berryclafoutis

/datum/recipe/wingfangchu
	reagents = list("soysauce" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/xenomeat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/wingfangchu

/datum/recipe/chaosdonut
	reagents = list("frostoil" = 2, "capsaicin" = 2, )
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/chaosdonut

/datum/recipe/human/kabob
	items = list(
		/obj/item/stack/rods,
		/obj/item/weapon/reagent_containers/food/snacks/meat/human,
		/obj/item/weapon/reagent_containers/food/snacks/meat/human,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/human/kabob

/datum/recipe/monkeykabob
	items = list(
		/obj/item/stack/rods,
		/obj/item/weapon/reagent_containers/food/snacks/meat/monkey,
		/obj/item/weapon/reagent_containers/food/snacks/meat/monkey,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeykabob

/datum/recipe/syntikabob
	items = list(
		/obj/item/stack/rods,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/syntiflesh,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeykabob

/datum/recipe/tofukabob
	items = list(
		/obj/item/stack/rods,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/tofukabob

/datum/recipe/tofubread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/tofubread

/datum/recipe/loadedbakedpotato
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/potato,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/loadedbakedpotato

/datum/recipe/cheesyfries
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/fries,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/cheesyfries

/datum/recipe/cubancarp
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/chili,
		/obj/item/weapon/reagent_containers/food/snacks/carpmeat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/cubancarp

/datum/recipe/popcorn
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/corn
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/popcorn

/datum/recipe/fortunecookie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/paper,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/fortunecookie
	make_food(var/obj/container as obj)
		var/obj/item/weapon/paper/paper = locate() in container
		paper.loc = null //prevent deletion
		var/obj/item/weapon/reagent_containers/food/snacks/fortunecookie/being_cooked = ..(container)
		paper.loc = being_cooked
		return being_cooked
	check_items(var/obj/container as obj)
		. = ..()
		if (.)
			var/obj/item/weapon/paper/paper = locate() in container
			if (!paper.info)
				return 0
		return .

/datum/recipe/meatsteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/meatsteak

/datum/recipe/syntisteak
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/weapon/syntiflesh
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/meatsteak

/datum/recipe/pizzamargherita
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/margherita

/datum/recipe/meatpizza
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/meatpizza

/datum/recipe/syntipizza
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/syntiflesh,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/meatpizza

/datum/recipe/mushroompizza
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/mushroompizza

/datum/recipe/vegetablepizza
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant,
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot,
		/obj/item/weapon/reagent_containers/food/snacks/grown/corn,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza

/datum/recipe/spacylibertyduff
	reagents = list("water" = 5, "vodka" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/spacylibertyduff

/datum/recipe/amanitajelly
	reagents = list("water" = 5, "vodka" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/amanitajelly
	make_food(var/obj/container as obj)
		var/obj/item/weapon/reagent_containers/food/snacks/amanitajelly/being_cooked = ..(container)
		being_cooked.reagents.del_reagent("amatoxin")
		return being_cooked

/datum/recipe/meatballsoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/faggot ,
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot,
		/obj/item/weapon/reagent_containers/food/snacks/grown/potato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/meatballsoup

/datum/recipe/vegetablesoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot,
		/obj/item/weapon/reagent_containers/food/snacks/grown/corn,
		/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant,
		/obj/item/weapon/reagent_containers/food/snacks/grown/potato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/vegetablesoup

/datum/recipe/nettlesoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/grown/nettle,
		/obj/item/weapon/reagent_containers/food/snacks/grown/potato,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/nettlesoup

/datum/recipe/wishsoup
	reagents = list("water" = 20)
	result= /obj/item/weapon/reagent_containers/food/snacks/wishsoup

/datum/recipe/hotchili
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/grown/chili,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/hotchili

/datum/recipe/coldchili
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/grown/icepepper,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/coldchili

/datum/recipe/amanita_pie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/amanita_pie

/datum/recipe/plump_pie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/plumphelmet,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/plump_pie

/datum/recipe/spellburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/clothing/head/wizard/fake,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/spellburger

/datum/recipe/spellburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/clothing/head/wizard,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/spellburger

/datum/recipe/bigbiteburger
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/bigbiteburger

/datum/recipe/enchiladas
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/grown/chili,
		/obj/item/weapon/reagent_containers/food/snacks/grown/chili,
		/obj/item/weapon/reagent_containers/food/snacks/grown/corn,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/enchiladas

/datum/recipe/creamcheesebread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/creamcheesebread

/datum/recipe/monkeysdelight
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/monkeycube,
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/monkeysdelight

/datum/recipe/baguette
	reagents = list("sodiumchloride" = 1, "blackpepper" = 1)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/baguette

/datum/recipe/fishandchips
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/fries,
		/obj/item/weapon/reagent_containers/food/snacks/carpmeat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/fishandchips

/datum/recipe/birthdaycake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/clothing/head/cakehat
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/birthdaycake

/datum/recipe/bread
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/bread

/datum/recipe/sandwich
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/meatsteak,
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sandwich

/datum/recipe/toastedsandwich
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/sandwich
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/toastedsandwich

/datum/recipe/grilledcheese
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/grilledcheese

/datum/recipe/tomatosoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/tomatosoup

/datum/recipe/rofflewaffles
	reagents = list("psilocybin" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/rofflewaffles

/datum/recipe/stew
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/grown/potato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot,
		/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/stew

/datum/recipe/metroidtoast
	reagents = list("metroid" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/metroidtoast

/datum/recipe/milosoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/soydope,
		/obj/item/weapon/reagent_containers/food/snacks/soydope,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/milosoup

/datum/recipe/stewedsoymeat
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/soydope,
		/obj/item/weapon/reagent_containers/food/snacks/soydope,
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/stewedsoymeat


/datum/recipe/boiledspagetti
	reagents = list("water" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/spagetti,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/boiledspagetti

/datum/recipe/pastatomato
	reagents = list("water" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/spagetti,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/pastatomato

/datum/recipe/poppypretzel
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/seeds/poppyseed,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/poppypretzel

/datum/recipe/meatballspagetti
	reagents = list("water" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/spagetti,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/meatballspagetti

/datum/recipe/spesslaw
	reagents = list("water" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/spagetti,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/spesslaw

/datum/recipe/superbiteburger
	reagents = list("sodiumchloride" = 5, "blackpepper" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/tomato,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,

	)
	result = /obj/item/weapon/reagent_containers/food/snacks/superbiteburger

/datum/recipe/candiedapple
	reagents = list("water" = 5, "sugar" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/apple
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/candiedapple

/datum/recipe/applepie
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/apple,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/applepie

/datum/recipe/applecake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/apple,
		/obj/item/weapon/reagent_containers/food/snacks/grown/apple,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/applecake

/datum/recipe/metroidburger
	reagents = list("metroid" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/metroidburger

/datum/recipe/twobread
	reagents = list("wine" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/twobread

/datum/recipe/metroidsandwich
	reagents = list("metroid" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
		/obj/item/weapon/reagent_containers/food/snacks/breadslice,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/metroidsandwich

/datum/recipe/orangecake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/orange,
		/obj/item/weapon/reagent_containers/food/snacks/grown/orange,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/orangecake

/datum/recipe/limecake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/lime,
		/obj/item/weapon/reagent_containers/food/snacks/grown/lime,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/limecake

/datum/recipe/lemoncake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/lemon,
		/obj/item/weapon/reagent_containers/food/snacks/grown/lemon,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/lemoncake

/datum/recipe/chocolatecake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatebar,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatebar,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/chocolatecake

/datum/recipe/bloodsoup
	reagents = list("blood" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/bloodtomato,
		/obj/item/weapon/reagent_containers/food/snacks/grown/bloodtomato,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/bloodsoup


/datum/recipe/metroidsoup
	reagents = list("water" = 10, "metroid" = 5)
	items = list(
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/metroidsoup

/datum/recipe/clownstears
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana,
		/obj/item/weapon/ore/clown,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/clownstears

/datum/recipe/boiledmetroidcore
	reagents = list("water" = 5)
	items = list(
		/obj/item/metroid_core,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/boiledmetroidcore

/datum/recipe/braincake
	reagents = list("milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/mob/living/carbon/brain,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/braincake

/datum/recipe/chocolateegg
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatebar,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/chocolateegg

/datum/recipe/sausage
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/faggot,
		/obj/item/weapon/reagent_containers/food/snacks/meat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sausage

/datum/recipe/fishfingers
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/carpmeat,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/fishfingers

/datum/recipe/mysterysoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/badrecipe,
		/obj/item/weapon/reagent_containers/food/snacks/tofu,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/cheesewedge,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/mysterysoup

/datum/recipe/pumpkinpie
	reagents = list("milk" = 5, "sugar" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/pumpkin,
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/sliceable/pumpkinpie

/datum/recipe/plumphelmetbiscuit
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/flour,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/plumphelmet,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/plumphelmetbiscuit

/datum/recipe/mushroomsoup
	reagents = list("water" = 5, "milk" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/chanterelle,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/mushroomsoup

/datum/recipe/chawanmushi
	reagents = list("water" = 5, "soysauce" = 5)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/chanterelle,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/chawanmushi

/datum/recipe/beetsoup
	reagents = list("water" = 10)
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/grown/whitebeet,
		/obj/item/weapon/reagent_containers/food/snacks/grown/cabbage,
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/beetsoup