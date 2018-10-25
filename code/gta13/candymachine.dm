/obj/machinery/sweet
	name = "\improper Sweet Machine"
	desc = "Insert coin, receive a pack of sweets!"
	icon = 'icons/obj/candymachine.dmi'
	icon_state = "sweetmachine"
	anchored = 1
	density = 1
	obj_flags = OBJ_FLAG_ANCHORABLE
	use_power = 0

/obj/machinery/sweet/attackby(var/obj/O as obj, var/mob/user as mob)
	if (stat & (NOPOWER|BROKEN))
		return ..()
	if (is_type_in_list(O, list(/obj/item/weapon/coin/)))
		if(user.drop_item(O, src))
			user.visible_message("<span class='notice'>[user] puts a coin into [src] and turns the knob.", "<span class='notice'>You put a coin into [src] and turn the knob.</span>")
			src.visible_message("<span class='notice'>[src] clicks softly.</span>")
			sleep(rand(10,15))
			src.visible_message("<span class='notice'>[src] dispenses a bag of sweets!</span>")
			new/obj/item/weapon/storage/pill_bottle/sweets(src.loc)

		if(istype(O, /obj/item/weapon/coin/))
			var/obj/item/weapon/coin/real_coin = O
			if(real_coin.string_attached)
				if(prob(30))
					to_chat(user, "<SPAN CLASS='notice'>You were able to force the knob around and successfully pulled the coin out before [src] could swallow it.</SPAN>")
					user.put_in_hands(O)
				else
					to_chat(user, "<SPAN CLASS='notice'>You weren't able to pull the coin out fast enough, the machine ate it, string and all.</SPAN>")
					qdel(O)
		else
			qdel(O)
	else
		return ..()