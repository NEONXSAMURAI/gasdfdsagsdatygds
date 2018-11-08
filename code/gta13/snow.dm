/turf/simulated/floor/outdoors/snow
	name = "snow"
	icon_state = "snow"
	edge_blending_priority = 6
	initial_flooring = /decl/flooring/snow
	turf_layers = list(
		/turf/simulated/floor/outdoors/rocks,
		/turf/simulated/floor/outdoors/dirt
		)
	var/list/crossed_dirs = list()


/turf/simulated/floor/outdoors/snow/Entered(atom/A)
	if(isliving(A))
		var/mdir = "[A.dir]"
		crossed_dirs[mdir] = 1
		update_icon()
	. = ..()

/turf/simulated/floor/outdoors/snow/update_icon()
	..()
	for(var/d in crossed_dirs)
		overlays +=(image(icon = 'icons/turf/outdoors.dmi', icon_state = "snow_footprints", dir = text2num(d)))


/turf/simulated/floor/outdoors/ice
	name = "ice"
	icon_state = "ice"
	desc = "Looks slippery."

/turf/simulated/floor/outdoors/ice/Entered(var/mob/living/M)
	sleep(1 * world.tick_lag)
	if(istype(M, /mob/living))
		if(M.stunned == 0)
			to_chat(M, "<span class='warning'>You slide across the ice!</span>")
		M.SetStunned(1)
		step(M,M.dir)
