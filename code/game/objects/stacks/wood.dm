/*
CONTAINS:
WOOD PLANKS
*/

var/global/list/datum/stack_recipe/wood_recipes = list ( \
	new/datum/stack_recipe("wooden sandals", /obj/item/clothing/shoes/sandal, 1), \
	new/datum/stack_recipe("table parts", /obj/item/weapon/table_parts/wood, 2), \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 5, time = 30, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("wooden door", /obj/structure/mineral_door/wood, 10, time = 20, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("zip gun", /obj/item/weapon/zip_gun, 2, time = 50),\
	)

/obj/item/stack/sheet/wood
	New(var/loc, var/amount=null)
		recipes = wood_recipes
		return ..()