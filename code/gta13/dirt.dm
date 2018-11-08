/turf/simulated/floor/dirt
	name = "dirt"
	icon = 'icons/gta13/dirt.dmi'
	icon_state = "dirt"

/turf/simulated/floor/dirt/another
	icon_state = "dirt1"

/turf/simulated/floor/dirt/another2
	icon_state = "dirt2"

/turf/simulated/floor/outdoors/dirt
	name = "dirt"
	desc = "Quite dirty!"
	icon_state = "dirt-dark"
	edge_blending_priority = 2
	turf_layers = list(/turf/simulated/floor/outdoors/rocks)
	initial_flooring = /decl/flooring/dirt
	var/grass_chance = 20
	var/tree_chance = 2
	var/list/grass_types = list(
		/obj/structure/flora/ausbushes/sparsegrass,
		/obj/structure/flora/ausbushes/fullgrass
		)

/turf/simulated/floor/outdoors/dirt/Initialize()
	if(prob(50))
		icon_state = "[initial(icon_state)]2"
		//edge_blending_priority++

	if(grass_chance && prob(grass_chance))
		var/grass_type = pick(grass_types)
		new grass_type(src)
	. = ..()

/turf/simulated/floor/outdoors/dirt/indoors
	outdoors = 0