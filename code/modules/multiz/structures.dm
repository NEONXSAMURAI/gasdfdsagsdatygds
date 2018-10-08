//////////////////////////////
//Contents: Ladders, Stairs.//
//////////////////////////////

/obj/structure/ladder
	name = "ladder"
	desc = "A ladder. You can climb it up and down."
	icon_state = "ladder01"
	icon = 'icons/obj/structures.dmi'
	density = 0
	opacity = 0
	anchored = 1

	var/allowed_directions = DOWN
	var/obj/structure/ladder/target_up
	var/obj/structure/ladder/target_down

	var/const/climb_time = 2 SECONDS
	var/static/list/climbsounds = list('sound/effects/ladder.ogg','sound/effects/ladder2.ogg','sound/effects/ladder3.ogg','sound/effects/ladder4.ogg')

/obj/structure/ladder/Initialize()
	. = ..()
	// the upper will connect to the lower
	if(allowed_directions & DOWN) //we only want to do the top one, as it will initialize the ones before it.
		for(var/obj/structure/ladder/L in GetBelow(src))
			if(L.allowed_directions & UP)
				target_down = L
				L.target_up = src
				return
	update_icon()

/obj/structure/ladder/Destroy()
	if(target_down)
		target_down.target_up = null
		target_down = null
	if(target_up)
		target_up.target_down = null
		target_up = null
	return ..()

/obj/structure/ladder/attackby(obj/item/C as obj, mob/user as mob)
	climb(user)

/obj/structure/ladder/attack_hand(var/mob/M)
	climb(M)

/obj/structure/ladder/attack_ai(var/mob/M)
	var/mob/living/silicon/ai/ai = M
	if(!istype(ai))
		return
	var/mob/observer/eye/AIeye = ai.eyeobj
	if(istype(AIeye))
		instant_climb(AIeye)

/obj/structure/ladder/attack_robot(var/mob/M)
	climb(M)

/obj/structure/ladder/proc/instant_climb(var/mob/M)
	var/target_ladder = getTargetLadder(M)
	if(target_ladder)
		M.forceMove(get_turf(target_ladder))

/obj/structure/ladder/proc/climb(var/mob/M)
	if(!M.may_climb_ladders(src))
		return

	var/obj/structure/ladder/target_ladder = getTargetLadder(M)
	if(!target_ladder)
		return
	if(!M.Move(get_turf(src)))
		to_chat(M, "<span class='notice'>You fail to reach \the [src].</span>")
		return

	for (var/obj/item/grab/G in M)
		G.adjust_position()

	var/direction = target_ladder == target_up ? "up" : "down"

	M.visible_message("<span class='notice'>\The [M] begins climbing [direction] \the [src]!</span>",
	"You begin climbing [direction] \the [src]!",
	"You hear the grunting and clanging of a metal ladder being used.")

	target_ladder.audible_message("<span class='notice'>You hear something coming [direction] \the [src]</span>")

	if(do_after(M, climb_time, src))
		climbLadder(M, target_ladder)
		for (var/obj/item/grab/G in M)
			G.adjust_position(force = 1)

/obj/structure/ladder/attack_ghost(var/mob/M)
	instant_climb(M)

/obj/structure/ladder/proc/getTargetLadder(var/mob/M)
	if((!target_up && !target_down) || (target_up && !istype(target_up.loc, /turf) || (target_down && !istype(target_down.loc,/turf))))
		to_chat(M, "<span class='notice'>\The [src] is incomplete and can't be climbed.</span>")
		return
	if(target_down && target_up)
		var/direction = alert(M,"Do you want to go up or down?", "Ladder", "Up", "Down", "Cancel")

		if(direction == "Cancel")
			return

		if(!M.may_climb_ladders(src))
			return

		switch(direction)
			if("Up")
				return target_up
			if("Down")
				return target_down
	else
		return target_down || target_up

/mob/proc/may_climb_ladders(var/ladder)
	if(!Adjacent(ladder))
		to_chat(src, "<span class='warning'>You need to be next to \the [ladder] to start climbing.</span>")
		return FALSE
	if(incapacitated())
		to_chat(src, "<span class='warning'>You are physically unable to climb \the [ladder].</span>")
		return FALSE

	var/carry_count = 0
	for(var/obj/item/grab/G in src)
		if(!G.ladder_carry())
			to_chat(src, "<span class='warning'>You can't carry [G.affecting] up \the [ladder].</span>")
			return FALSE
		else
			carry_count++
	if(carry_count > 1)
		to_chat(src, "<span class='warning'>You can't carry more than one person up \the [ladder].</span>")
		return FALSE

	return TRUE

/mob/observer/ghost/may_climb_ladders(var/ladder)
	return TRUE

/obj/structure/ladder/proc/climbLadder(var/mob/M, var/target_ladder)
	var/turf/T = get_turf(target_ladder)
	for(var/atom/A in T)
		if(!A.CanPass(M, M.loc, 1.5, 0))
			to_chat(M, "<span class='notice'>\The [A] is blocking \the [src].</span>")
			return FALSE
	playsound(src, pick(climbsounds), 50)
	playsound(target_ladder, pick(climbsounds), 50)
	return M.Move(T)

/obj/structure/ladder/CanPass(obj/mover, turf/source, height, airflow)
	return airflow || !density

/obj/structure/ladder/update_icon()
	icon_state = "ladder[!!(allowed_directions & UP)][!!(allowed_directions & DOWN)]"

/obj/structure/ladder/up
	allowed_directions = UP
	icon_state = "ladder10"

/obj/structure/ladder/updown
	allowed_directions = UP|DOWN
	icon_state = "ladder11"

/obj/structure/stairs
	name = "Stairs"
	desc = "Stairs leading to another deck.  Not too useful if the gravity goes out."
	icon = 'icons/obj/stairs.dmi'
	density = 0
	opacity = 0
	anchored = 1
	plane = ABOVE_TURF_PLANE
	layer = RUNE_LAYER

	Initialize()
		for(var/turf/turf in locs)
			var/turf/simulated/open/above = GetAbove(turf)
			if(!above)
				warning("Stair created without level above: ([loc.x], [loc.y], [loc.z])")
				return INITIALIZE_HINT_QDEL
			if(!istype(above))
				above.ChangeTurf(/turf/simulated/open)
		. = ..()

	Uncross(atom/movable/A)
		if(A.dir == dir)
			// This is hackish but whatever.
			var/turf/target = get_step(GetAbove(A), dir)
			var/turf/source = A.loc
			var/turf/above = GetAbove(A)
			if(above.CanZPass(source, UP) && target.Enter(A, source))
				A.forceMove(target)
			else
				to_chat(A, "<span class='warning'>Something blocks the path.</span>")
			return 0
		return 1

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

	// type paths to make mapping easier.
	north
		dir = NORTH
		bound_height = 64
		bound_y = -32
		pixel_y = -32

	south
		dir = SOUTH
		bound_height = 64

	east
		dir = EAST
		bound_width = 64
		bound_x = -32
		pixel_x = -32

	west
		dir = WEST
		bound_width = 64

/* 1 Z LEVEL LADDERS - Kachnov */

/obj/structure/multiz
	name = "ladder"
	density = FALSE
	opacity = FALSE
	anchored = TRUE
	icon = 'icons/obj/stairs.dmi'
	var/istop = TRUE
	var/obj/structure/multiz/target

	New()
		. = ..()
		for(var/obj/structure/multiz/M in loc)
			if(M != src)
				spawn(1)
					world.log << "##MAP_ERROR: Multiple [initial(name)] at ([x],[y],[z])"
					qdel(src)
				return .

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

	proc/find_target()
		return

	Initialize()
		find_target()

	attack_tk(mob/user)
		return

	attack_ghost(mob/user)
		. = ..()
		user.Move(get_turf(target))

	attackby(obj/item/C, mob/user)
		. = ..()
		attack_hand(user)
		return

/obj/structure/multiz/ladder/ww2
	var/ladder_id = null
	var/area_id = "defaultareaid"

/obj/structure/multiz/ladder/ww2/Crossed(var/atom/movable/AM)
	if (find_target())
		if (isitem(AM) && !istype(AM, /obj/item/projectile))
			var/obj/item/I = AM
			if (I.w_class <= 2.0) // fixes maxim bug and probably some others - Kachnov
				I.forceMove(get_turf(find_target()))

/obj/structure/multiz/ladder/ww2/find_target()
	for (var/obj/structure/multiz/ladder/ww2/ladder in world) // todo: get rid of
		if (ladder_id == ladder.ladder_id && ladder != src)
			return ladder

/obj/structure/multiz/ladder/ww2/ex_act(severity)
	return

/obj/structure/multiz/ladder/ww2/up
	icon_state = "ladderup"
	istop = FALSE

/obj/structure/multiz/ladder/ww2/Destroy()
	if(target && istop)
		qdel(target)
	return ..()

/* manholes! These are just ww2 ladders. The top manhole should be paired
 * with a bottom ladder that has the same ID */

/obj/structure/multiz/ladder/ww2/manhole
	icon_state = "manhole"
	density = FALSE
	name = "manhole"

/obj/structure/multiz/ladder/ww2/manhole/proc/fell(var/mob/living/M)
	if (icon_state == "manhole-open" && target)
		M.visible_message("<span class = 'warning'>[M] falls down the manhole!</span>", "<span class = 'userdanger'>You fall down the manhole!</span>")
		M.adjustBruteLoss(rand(15,20))
		M.loc = get_turf(target)

/obj/structure/multiz/ladder/ww2/manhole/attack_hand(var/mob/M)
	if (isobserver(M))
		return ..(M)
	switch (icon_state)
		if ("manhole")
			visible_message("<span class = 'danger'>[M] starts to move the cover off of the manhole.</span>")
			icon_state = "manhole-opening"
			if (do_after(M, 35, src)) // it takes 3.5 seconds for the animation
				visible_message("<span class = 'danger'>[M] moves the cover off of the manhole.</span>")
				icon_state = "manhole-open"
			else
				icon_state = "manhole"
		if ("manhole-opening")
			return
		if ("manhole-open")
			var/I = input(M, "Climb down the manhole or put the cover back on?") in list("Climb Down", "Replace the Cover", "Cancel")
			if (I == "Cancel")
				return
			else
				switch (I)
					if ("Climb Down")
						return ..(M)
					if ("Replace the Cover")
						visible_message("<span class = 'danger'>[M] starts to replace the cover back on to the manhole.</span>")
						icon_state = "manhole-closing"
						if (do_after(M, 35, src)) // it takes 3.5 seconds for the animation
							visible_message("<span class = 'danger'>[M] moves the cover off of the manhole.</span>")
							icon_state = "manhole"
						else
							icon_state = "manhole-open"

/obj/structure/multiz/stairs/active/find_target()
	var/turf/targetTurf = istop ? GetBelow(src) : GetAbove(src)
	target = locate(/obj/structure/multiz/stairs/enter) in targetTurf

/obj/structure/multiz/stairs
	name = "Stairs"
	icon_state = "rampup"
	layer = 2.4

/obj/structure/multiz/stairs/enter
	icon_state = "ramptop"

/obj/structure/multiz/stairs/enter/bottom
	icon_state = "rampbottom"
	istop = FALSE

/obj/structure/multiz/stairs/active
	density = TRUE

/obj/structure/multiz/stairs/active/find_target()
	var/turf/targetTurf = istop ? GetBelow(src) : GetAbove(src)
	target = locate(/obj/structure/multiz/stairs/enter) in targetTurf

/obj/structure/multiz/stairs/active/Bumped(var/atom/movable/M)
	if(isnull(M))
		return

	if(ismob(M) && usr.client)
		usr.client.moving = TRUE
		usr.Move(get_turf(target))
		usr.client.moving = FALSE
	else
		M.Move(get_turf(target))


/obj/structure/stairs/active/attack_hand(mob/user)
	. = ..()
	if(Adjacent(user))
		Bumped(user)

/obj/structure/multiz/stairs/active/bottom
	icon_state = "rampdark"
	istop = FALSE

/obj/structure/multiz/stairs/active/bottom/Bumped(var/atom/movable/M)
	//If on bottom, only let them go up stairs if they've moved to the entry tile first.
	if(!locate(/obj/structure/multiz/stairs/enter) in M.loc)
		return
	return ..()
