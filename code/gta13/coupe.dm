//rename to sportscar if you need
//mostly, my changes just update the C.pixel_ y and x on every iteration of the overlay update proc, since default vehicle code //only does that upon entering. Watch the weird formatting pastebin introduces.

/obj/gta13cars/car/sportscar
	name = "sports car"
	desc = "A very luxurious vehicle."
	icon = 'icons/gta13/cars/sportscar.dmi'
	icon_state = "sportscar"
	bound_width = 64
	bound_height = 64
	fits_passenger = 1
	passenger_item_visible = 1
	load_item_visible = 1
	load_offset_x = 0
	move_delay = 1
		//||pixel_y offset for mob overlay
	mob_offset_y = 7
	passenger_offset_y = 20
	var/main_icon_state = "sportscar"
	var/xd = 2
	var/yd = 20
	var/xp = 22
	var/yp = 20
//-------------------------------------------
// Standard procs
//-------------------------------------------

/obj/gta13cars/car/sportscar/New()
	..()
	update_dir_car_overlays()

/obj/gta13cars/car/sportscar/Initialize()
	. = ..()

/obj/gta13cars/car/sportscar/Move()
	..()
	update_dir_car_overlays()



/obj/gta13cars/car/sportscar/attackby(var/obj/item/W, var/mob/user)
	..()
	var/obj/item/grab/G = W
	if(!istype(G))
		return ..()

	if(!G.force_danger())
		user << "<span class='danger'>You need a better grip to do that!</span>"
		return

	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || (!user.canmove))
		return

		//||trunk is open and has room
	if(trunk_open && !trunk)
			//||car is empty
		if(!load && !passenger)
			var/choice = alert("Which seat do you want them to take?",,"Driver's", "Passenger's", "The trunk", "Cancel")
			switch(choice)
				if("Driver's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "driver")
						update_dir_car_overlays()
				if("Passenger's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "passenger")
						update_dir_car_overlays()
				if("The trunk")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "trunk")
				if("Cancel")
					return
			return
			//||passenger's seat is taken
		if(!load)
			var/choice = alert("Which seat do you want them to take?",,"Driver's", "The trunk", "Cancel")
			switch(choice)
				if("Driver's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "driver")
						update_dir_car_overlays()
				if("The trunk")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "trunk")
				if("Cancel")
					return
			return
			//||driver's seat is taken
		if(!passenger)
			var/choice = alert("Which seat do you want them to take?",, "Passenger's", "The trunk", "Cancel")
			switch(choice)
				if("Passenger's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "passenger")
						update_dir_car_overlays()
				if("The trunk")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "trunk")
				if("Cancel")
					return
			return
			//||trunk is closed
	if(!trunk_open || trunk)
			//||car is empty
		if(!load && !passenger)
			var/choice = alert("Which seat do you want them to take?",,"Driver's", "Passenger's", "Cancel")
			switch(choice)
				if("Driver's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "driver")
						update_dir_car_overlays()
				if("Passenger's")
					if(G.affecting)
						if(!canInteract(user, G.affecting))	return
						var/mob/M = G.affecting
						qdel(G)
						load(M, "passenger")
						update_dir_car_overlays()
				if("Cancel")
					return
			return
			//||passenger's seat is taken
		if(!load)
			if(G.affecting)
				if(!canInteract(user, G.affecting))	return
				var/mob/M = G.affecting
				qdel(G)
				load(M, "driver")
				update_dir_car_overlays()
			return
			//||driver's seat is taken
		if(!passenger)
			if(G.affecting)
				if(!canInteract(user, G.affecting))	return
				var/mob/M = G.affecting
				qdel(G)
				load(M, "passenger")
				update_dir_car_overlays()
			return
	if(!trunk_open)
		usr << "<span class='warning'>Open the trunk first!</span>"
	else if(trunk)
		usr << "<span class='warning'>There is already something in the trunk. Remove [trunk] first before loading [G.affecting] into the trunk.</span>"
	else if(trunk_open && !trunk)
		if(G.affecting)
			var/mob/M = G.affecting
			qdel(G)
			load(M, "trunk")


//| Mousedrop
/obj/gta13cars/car/sportscar/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || (!user.canmove) || !user.Adjacent(C) || !istype(C))
		return
	if(istype(C,/obj/vehicle/train))
		return
	if(ismob(C))
			//||trunk is open and has room
		if(trunk_open && !trunk)
				//||car is empty
			if(!load && !passenger)
				var/choice = alert("Which seat do you want them to take?",,"Driver's", "Passenger's", "The trunk", "Cancel")
				switch(choice)
					if("Driver's")
						if(!canInteract(user, C))	return
						load(C, "driver")
						update_dir_car_overlays()
					if("Passenger's")
						if(!canInteract(user, C))	return
						load(C, "passenger")
						update_dir_car_overlays()
					if("The trunk")
						if(!canInteract(user, C))	return
						load(C, "trunk")
					if("Cancel")
						return
				return
				//||passenger's seat is taken
			if(!load)
				var/choice = alert("Which seat do you want them to take?",,"Driver's", "The trunk", "Cancel")
				switch(choice)
					if("Driver's")
						if(!canInteract(user, C))	return
						load(C, "driver")
						update_dir_car_overlays()
					if("The trunk")
						if(!canInteract(user, C))	return
						load(C, "trunk")
					if("Cancel")
						return
				return
				//||driver's seat is taken
			if(!passenger)
				var/choice = alert("Which seat do you want them to take?",, "Passenger's", "The trunk", "Cancel")
				switch(choice)

					if("Passenger's")
						if(!canInteract(user, C))	return
						load(C, "passenger")
						update_dir_car_overlays()
					if("The trunk")
						if(!canInteract(user, C))	return
						load(C, "trunk")
					if("Cancel")
						return
				return
				//||trunk is closed or full
		if(!trunk_open || trunk)
				//||car is empty
			if(!load && !passenger)
				var/choice = alert("Which seat do you want them to take?",,"Driver's", "Passenger's", "Cancel")
				switch(choice)
					if("Driver's")
						if(!canInteract(user, C))	return
						load(C, "driver")
						update_dir_car_overlays()
					if("Passenger's")
						if(!canInteract(user, C))	return
						load(C, "passenger")
						update_dir_car_overlays()
					if("Cancel")
						return
				return
				//||passenger's seat is taken
			if(!load)
				if(!canInteract(user, C))	return
				load(C, "driver")
				update_dir_car_overlays()
				return
				//||driver's seat is taken
			if(!passenger)
				if(!canInteract(user, C))	return
				load(C, "passenger")
				update_dir_car_overlays()
				return
	if(!trunk_open)
		usr << "<span class='warning'>Open the trunk first!</span>"
	else if(trunk)
		usr << "<span class='warning'>There is already something in the trunk. Remove [trunk] first before loading [C] into the trunk.</span>"
	else if(trunk_open && !trunk)
		if(!canInteract(user, C))	return
		load(C, "trunk")

/obj/gta13cars/car/sportscar/proc/canInteract(mob/user, atom/movable/C)
	if(user.stat || user.restrained() || !Adjacent(user) || (!user.canmove) || (C && !user.Adjacent(C)) || (C && !istype(C)))
		return 0
	else
		return 1

/obj/gta13cars/car/sportscar/attack_hand(mob/living/user as mob)
	if(user.stat || user.restrained() || !Adjacent(user))
		return 0
	if(user != trunk && (user in src)) //||for handling players stuck in src
		user.forceMove(loc)

	src.add_fingerprint(user)
		//|the trunk is open & empty
	if(trunk_open && !trunk)
			//||user is already in the driver's seat; click vehicle to exit
		if(load == user)
			unload(user, "driver")
			if(passenger)
				update_dir_car_overlays()
			return
			//||user is already in the passenger's seat; click vehicle to exit
		if(passenger == user)
			unload(user, "passenger")
			update_dir_car_overlays()
			return
			//||user is already in the trunk; click vehicle to exit
		if(trunk == user)
			unload(user, "trunk")
			return
			//||what happens when there is already a passenger in the car
		if(!load && passenger && passenger != user)
			var/choice = alert("What would you like to do?",,"Enter driver's seat", "Remove passenger", "Climb into trunk","Cancel")
			switch(choice)
				if("Enter driver's seat")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Climb into trunk")
					if(!canInteract(user))	return
					load(user, "trunk")
				if("Cancel")
					return
			return
			//||what happens when there is already a driver in the car
		if(load && !passenger && load != user)
			var/choice = alert("What would you like to do?",,"Enter passenger's seat", "Remove driver", "Climb into trunk", "Cancel")
			switch(choice)
				if("Enter passenger's seat")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Climb into trunk")
					if(!canInteract(user))	return
					load(user, "trunk")
				if("Cancel")
					return
			return
			//||what happens when there are two people in the car
		if(load && passenger && load != user && passenger != user)
			var/choice = alert("What would you like to do?",,"Remove driver", "Remove passenger", "Climb into trunk", "Cancel")
			switch(choice)
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Climb into trunk")
					if(!canInteract(user))	return
					load(user, "trunk")
				if("Cancel")
					return
			return
			//||car is empty
		if(!load && !user.buckled && !passenger)
			var/choice = alert("How will you ride?",,"Drive", "Passenger", "In the trunk", "Cancel")
			switch(choice)
				if("Drive")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Passenger")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("In the trunk")
					if(!canInteract(user))	return
					load(user, "trunk")
				if("Cancel")
					return
			return
			//|the trunk is open & full
	if(trunk_open && trunk)
			//||user is already in the driver's seat; click vehicle to exit
		if(load == user)
			unload(user, "driver")
			if(passenger)
				update_dir_car_overlays()
			return
			//||user is already in the passenger's seat; click vehicle to exit
		if(passenger == user)
			unload(user, "passenger")
			update_dir_car_overlays()
			return
			//||user is already in the trunk; click vehicle to exit
		if(trunk == user)
			unload(user, "trunk")
			return
			//||what happens when there is already a passenger in the car
		if(!load && passenger && passenger != user)
			var/choice = alert("What would you like to do?",,"Enter driver's seat", "Remove passenger", "Remove from trunk", "Cancel")
			switch(choice)
				if("Enter driver's seat")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Remove from trunk")
					if(!canInteract(user))	return
					unload(trunk, "trunk")
				if("Cancel")
					return
			return
			//||what happens when there is already a driver in the car
		if(load && !passenger && load != user)
			var/choice = alert("What would you like to do?",,"Enter passenger's seat", "Remove driver", "Remove from trunk", "Cancel")
			switch(choice)
				if("Enter passenger's seat")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Remove from trunk")
					if(!canInteract(user))	return
					unload(trunk, "trunk")
				if("Cancel")
					return
			return
			//||what happens when there are two people in the car
		if(load && passenger && load != user && passenger != user)
			var/choice = alert("What would you like to do?",,"Remove driver", "Remove passenger", "Remove from trunk", "Cancel")
			switch(choice)
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Remove from trunk")
					if(!canInteract(user))	return
					unload(trunk, "trunk")
				if("Cancel")
					return
			return
			//||car is empty
		if(!load && !user.buckled && !passenger)
			var/choice = alert("What will you do?",,"Drive", "Be passenger", "Remove from trunk", "Cancel")
			switch(choice)
				if("Drive")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Be passenger")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("Remove from trunk")
					if(!canInteract(user))	return
					unload(trunk, "trunk")
				if("Cancel")
					return
			return
		//|the trunk is closed
	if(!trunk_open)
			//||user is already in the driver's seat; click vehicle to exit
		if(load == user)
			unload(user, "driver")
			if(passenger)
				update_dir_car_overlays()
			return
			//||user is already in the passenger's seat; click vehicle to exit
		if(passenger == user)
			unload(user, "passenger")
			update_dir_car_overlays()
			return
			//||user is already in the trunk; click vehicle to exit
		if(trunk == user)
			user << "<span class='warning'>The trunk is closed! You have to force it open.</span>"
			return
			//||what happens when there is already a passenger in the car
		if(!load && passenger && passenger != user)
			var/choice = alert("What would you like to do?",,"Enter driver's seat", "Remove passenger", "Cancel")
			switch(choice)
				if("Enter driver's seat")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Cancel")
					return
			return
			//||what happens when there is already a driver in the car
		if(load && !passenger && load != user)
			var/choice = alert("What would you like to do?",,"Enter passenger's seat", "Remove driver", "Cancel")
			switch(choice)
				if("Enter passenger's seat")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Cancel")
					return
			return
			//||what happens when there are two people in the car
		if(load && passenger && load != user && passenger != user)
			var/choice = alert("What would you like to do?",,"Remove driver", "Remove passenger", "Cancel")
			switch(choice)
				if("Remove driver")
					if(!canInteract(user))	return
					remove_occupant(user, load, "driver")
				if("Remove passenger")
					if(!canInteract(user))	return
					remove_occupant(user, passenger, "passenger")
				if("Cancel")
					return
			return
			//||car is empty
		if(!load && !user.buckled && !passenger)
			var/choice = alert("How will you ride?",,"Drive", "Passenger", "Cancel")
			switch(choice)
				if("Drive")
					if(!canInteract(user))	return
					load(user, "driver")
					update_dir_car_overlays()
				if("Passenger")
					if(!canInteract(user))	return
					load(user, "passenger")
					update_dir_car_overlays()
				if("Cancel")
					return
			return

	return 0

/obj/gta13cars/car/sportscar/proc/remove_occupant(user, occupant, who)
	var/mob/living/M	= user
	if(M.canmove && (M.last_special <= world.time))
		M.last_special = world.time + breakout

		M << "<span class='warning'>You attempt to pull [occupant] out of the vehicle. (This will take around 5 seconds and you need to stand still)</span>"
		for(var/mob/O in viewers(M))
			O.show_message( "<span class='danger'>[M] attempts to pull [occupant] out of the vehicle!</span>", 1)

		if(do_after(user, 50, 10, needhand = 1, target = src))
			if(M.restrained() || M.buckled)
				return
			for(var/mob/O in viewers(M))
				O.show_message("<span class='danger'>[M] pulls [occupant] out of their seat!</span>", 1)
			user << "<span class='notice'>You successfully remove [occupant] from the vehicle.</span>"
			switch (who)
				if("driver")
					unload(occupant, who)
				if("passenger")
					unload(occupant, who)
			update_dir_car_overlays()
			return
		else
			user << "<span class='notice'>You fail to remove [occupant] from the vehicle.</span>"
			return

/obj/gta13cars/car/sportscar/update_dir_car_overlays()
	var/atom/movable/C = src.load
	var/atom/movable/D = src.passenger
	src.overlays = null
	if(src.dir == NORTH||SOUTH||WEST)
		if(src.dir == NORTH)	//|| place car sprite over mobs
			var/image/I = new(icon, icon_state = "[main_icon_state]_north", layer = src.layer + 0.2)
			src.overlays += I

			src.mob_offset_x = xd
			src.mob_offset_y = 20
				//||move the driver & passenger back to the original layer
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer
			src.passenger_offset_x = xp
			src.passenger_offset_y = 20

		else if(src.dir == SOUTH)

			var/image/I = new(icon, icon_state = "[main_icon_state]_south", layer = src.layer + 0.2)
			overlays += I
				//||move the driver & passenger back to the original layer
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer
			src.mob_offset_x = 20
			src.mob_offset_y = 27

			src.passenger_offset_x = 3
			src.passenger_offset_y = 27

		else if(src.dir == WEST)

			src.mob_offset_x = 34
			src.mob_offset_y = 10
				//||move the driver the one layer above the passenger, so he is displayed properly when they overlap
			if(passenger && load)
				C.layer = default_layer + 0.1
				D.layer = default_layer
			src.passenger_offset_x = 34
			src.passenger_offset_y = 23

			var/image/I = new(icon, icon_state = "[main_icon_state]_west", layer = src.layer + 0.2)
			src.overlays += I
			if(passenger && !load)
				var/image/S = new(icon, icon_state = "[main_icon_state]_west_passenger", layer = src.layer + 0.2)
				src.overlays += S

		else if(src.dir == EAST)

			var/image/I = new(icon, icon_state = "[main_icon_state]_east_passenger", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon, icon_state = "[main_icon_state]_east", layer = src.layer + 0.2)
				src.overlays += S

	if(ismob(C))
		C.pixel_y = src.mob_offset_y
		C.pixel_x = src.mob_offset_x
	if(ismob(D))
		D.pixel_y = src.passenger_offset_y
		D.pixel_x = src.passenger_offset_x


//New vehicle additions

/obj/gta13cars/car/sportscar/policecar
	name = "police car"
	desc = "A vehicle designed for the defenders of the law."
	icon = 'icons/gta13/cars/policecar.dmi'
	icon_state = "policecar"
	move_delay = 0.7
/obj/gta13cars/car/sportscar/policecar/update_dir_car_overlays()
	var/atom/movable/C = src.load
	var/atom/movable/D = src.passenger
	src.overlays = null
	if(src.dir == NORTH||SOUTH||WEST)
		if(src.dir == NORTH)	//|| place car sprite over mobs
			var/image/I = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_north", layer = src.layer + 0.2)
			src.overlays += I

			src.mob_offset_x = 2
			src.mob_offset_y = 20
				//||move the driver & passenger back to the original layer
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer
			src.passenger_offset_x = 22
			src.passenger_offset_y = 20

		else if(src.dir == SOUTH)

			var/image/I = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_south", layer = src.layer + 0.2)
			overlays += I
				//||move the driver & passenger back to the original layer
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer
			src.mob_offset_x = 20
			src.mob_offset_y = 27

			src.passenger_offset_x = 3
			src.passenger_offset_y = 27

		else if(src.dir == WEST)

			src.mob_offset_x = 34
			src.mob_offset_y = 10
				//||move the driver the one layer above the passenger, so he is displayed properly when they overlap
			if(passenger && load)
				C.layer = default_layer + 0.1
				D.layer = default_layer
			src.passenger_offset_x = 34
			src.passenger_offset_y = 23

			var/image/I = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_west", layer = src.layer + 0.2)
			src.overlays += I
			if(passenger && !load)
				var/image/S = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_west_passenger", layer = src.layer + 0.2)
				src.overlays += S

		else if(src.dir == EAST)

			var/image/I = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_east_passenger", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon = 'icons/gta13/cars/policecar.dmi', icon_state = "policecar_east", layer = src.layer + 0.2)
				src.overlays += S

	if(ismob(C))
		C.pixel_y = src.mob_offset_y
		C.pixel_x = src.mob_offset_x
	if(ismob(D))
		D.pixel_y = src.passenger_offset_y
		D.pixel_x = src.passenger_offset_x

/obj/gta13cars/car/sportscar/policecar/closed
	name = "police car"
	desc = "A vehicle designed for the defenders of the law."
	icon = 'icons/gta13/cars/policecarrier.dmi'
	icon_state = "policecar"

	fits_passenger = 3
	passenger_item_visible = 0
	load_item_visible = 0

/obj/gta13cars/car/sportscar/policecar/closed/update_dir_car_overlays()
	var/atom/movable/C = src.load
	var/atom/movable/D = src.passenger
	src.overlays = null
	if(src.dir == NORTH||SOUTH||WEST)
		if(src.dir == NORTH)	//|| place car sprite over mobs

			var/image/I = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_north", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_north", layer = src.layer + 0.2)
				src.overlays += S

		else if(src.dir == SOUTH)

			var/image/I = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_south", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_south", layer = src.layer + 0.2)
				src.overlays += S

		else if(src.dir == WEST)

			var/image/I = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_west", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_west", layer = src.layer + 0.2)
				src.overlays += S

		else if(src.dir == EAST)

			var/image/I = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_east", layer = src.layer + 0.2)

			src.passenger_offset_x = 20
			src.passenger_offset_y = 10
				//||move the driver back to the original layer & passenger up one layer to prevent overlap
			if(passenger && load)
				C.layer = default_layer
				D.layer = default_layer + 0.1
			src.mob_offset_x = 20
			src.mob_offset_y = 23

			src.overlays += I

			if(!passenger )
				var/image/S = new(icon = 'icons/gta13/cars/policecarrier.dmi', icon_state = "policecar_east", layer = src.layer + 0.2)
				src.overlays += S

	if(ismob(C))
		C.pixel_y = src.mob_offset_y
		C.pixel_x = src.mob_offset_x
	if(ismob(D))
		D.pixel_y = src.passenger_offset_y
		D.pixel_x = src.passenger_offset_x

/obj/gta13cars/car/sportscar/redsportcar
	name = "red sports car"
	desc = "A very luxurious vehicle."
	icon = 'icons/gta13/cars/redsportscar.dmi'
	icon_state = "redsportscar"
	main_icon_state = "redsportscar"

/obj/gta13cars/car/sportscar/bluesportcar
	name = "blue sports car"
	desc = "A very luxurious vehicle."
	icon = 'icons/gta13/cars/bluesportscar.dmi'
	icon_state = "bluesportscar"
	main_icon_state = "bluesportscar"

/obj/gta13cars/car/sportscar/greensportcar
	name = "green sports car"
	desc = "A very luxurious vehicle."
	icon = 'icons/gta13/cars/greensportscar.dmi'
	icon_state = "greensportscar"
	main_icon_state = "greensportscar"


/obj/gta13cars/car/sportscar/jeepmesa
	name = "green sports44 car"
	desc = "A very luxur4ious vehicle."
	icon = 'icons/gta13/cars/jeep-vehicles.dmi'
	icon_state = "jeep_mesa"
	main_icon_state = "jeep_mesa"
	xd = 12
/*
Øàáëîí ñîçäàíèÿ íîâûõ äâóõìåñòíûõ ìàøèí êàáðèîëåòîâ
/obj/gta13cars/car/sportscar/âàøà ìàøèíà - Ïóòü
	name = "ÒÓÒ ÍÀÇÂÀÍÈÅ ÌÀØÈÍÛ"
	desc = "ÅÅ ÎÏÈÑÀÍÈÅ"
	icon = 'icons/gta13/cars/ÍÀÇÂÀÍÈÅ ÔÀÉËÀ ÑÎ ÑÏÐÀÉÒÎÌ.dmi'
	icon_state = "4-ÅÕ ÍÀÏÐÀÂËßÅÍÍÛÉ ÑÏÐÀÉÒ ÌÀØÈÍÛ(ÑÌÎÒÐÈÒÅ ÏÎ ÀÍÀËÎÃÈÈ Ñ Î ÑÒÀÐÛÌÈ ÔÀÉËÀÌÈ ÑÏÐÀÉÒÎÂ)"
	move_delay = ÇÍÀ×ÅÍÈÅ - ×åì ìåíüøå, òåì áîëüøå ñêîðîñòü
*/
