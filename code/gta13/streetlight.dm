/obj/machinery/streetlight
	name = "street light"
	icon = 'icons/gta13/streetlight.dmi'
	icon_state = "streetlamp1"
	desc = "A street lighting fixture."
	light_color = "#ebf7fe"
	light_power = 5
	light_range = 4
	plane = -11
	layer = 3.7
	density = 1
	anchored = 1
	var/on = 1
	var/obj/item/weapon/cell/cell = null
	var/use = 200 // 200W light
	var/unlocked = 0
	var/open = 0
	var/brightness_on = 4		//can't remember what the maxed out value is
