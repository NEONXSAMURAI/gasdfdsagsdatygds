//|| Roads	#TODO - sometime in the future not a huge priority - handle directional icon changes in update_icon for road in-game construction as well as make damage icons
#define world.realtimeCHANGE (change_time_of_day())

/turf/simulated/floor/road
	name = "Road"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "road"
	light_color = "#ebf7fe"
	light_power = 5
	light_range = 2

/turf/simulated/floor/road/lightroad
	icon_state = "road"
/turf/simulated/floor/road/vertical/
	icon_state = "road1"
/turf/simulated/floor/road/vertical/zebra
	icon_state = "zebra1"
/turf/simulated/floor/road/horizontal
	icon_state = "road10"
/turf/simulated/floor/road/horizontal/zebra
	icon_state = "zebra2"
/turf/simulated/floor/road/vertical/east/
	icon_state = "road3"
/turf/simulated/floor/road/vertical/west
	icon_state = "road2"
/turf/simulated/floor/road/horizontal/north
	icon_state = "road5"
/turf/simulated/floor/road/horizontal/south
	icon_state = "road4"

//| Road corners
/turf/simulated/floor/road/northeast
	icon_state = "road6"
/turf/simulated/floor/road/northwest
	icon_state = "road7"
/turf/simulated/floor/road/southeast
	icon_state = "road8"
/turf/simulated/floor/road/southwest
	icon_state = "road9"
/turf/simulated/floor/road/northeastsmall
	icon_state = "road13"
/turf/simulated/floor/road/northwestsmall
	icon_state = "road12"
/turf/simulated/floor/road/southeastsmall
	icon_state = "road14"
/turf/simulated/floor/road/southwestsmall
	icon_state = "road11"

/turf/simulated/floor/road/lightroad/New()
	spawn()
		while(1)
			change_time_of_day()

/turf/simulated/floor/road/lightroad/proc/change_time_of_day()
	if(light_power == 5)
		sleep(60)
		light_power = 4.5

	if(light_power == 4.5)
		sleep(60)
		light_power = 4

	if(light_power == 4)
		sleep(60)
		light_power = 3.5

	if(light_power == 3.5)
		sleep(60)
		light_power = 3

	if(light_power == 3)
		sleep(60)
		light_power = 2.5

	if(light_power == 2.5)
		sleep(60)
		light_power = 2

	if(light_power == 2)
		sleep(60)
		light_power = 1.5

	if(light_power == 1.5)
		sleep(60)
		light_power = 1

	if(light_power == 1)
		sleep(60)
		light_power = 1.6

	if(light_power == 1.6)
		sleep(60)
		light_power = 2.1

	if(light_power == 2.1)
		sleep(60)
		light_power = 2.6


	if(light_power == 2.6)
		sleep(60)
		light_power = 3.1

	if(light_power == 3.1)
		sleep(60)
		light_power = 3.6

	if(light_power == 3.6)
		sleep(60)
		light_power = 4.1

	if(light_power == 4.1)
		sleep(60)
		light_power = 4.6

	if(light_power == 4.6)
		sleep(60)
		light_power = 5

//| Pavement corners
/turf/simulated/floor/pavement
	name = "pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved"
/turf/simulated/floor/pavement/stone
	icon_state = "stonepavement"
/turf/simulated/floor/pavement/east
	icon_state = "paved2"
/turf/simulated/floor/pavement/west
	icon_state = "paved4"
/turf/simulated/floor/pavement/north
	icon_state = "paved5"
/turf/simulated/floor/pavement/south
	icon_state = "paved6"
/turf/simulated/floor/pavement/edge/southeast
	icon_state = "paved10"
/turf/simulated/floor/pavement/edge/southeast/corner
	icon_state = "paved3"
/turf/simulated/floor/pavement/edge/northeast
	icon_state = "paved11"
/turf/simulated/floor/pavement/edge/northeast/corner
	icon_state = "paved7"
/turf/simulated/floor/pavement/edge/southwest
	icon_state = "paved12"
/turf/simulated/floor/pavement/edge/southwest/corner
	icon_state = "paved8"
/turf/simulated/floor/pavement/edge/northwest
	icon_state = "paved13"
/turf/simulated/floor/pavement/edge/northwest/corner
	icon_state = "paved9"


//| Ржавчина
/turf/simulated/floor/rust
	name = "rust floor"
	icon = 'icons/gta13/rust.dmi'
	icon_state = "rust"
/turf/simulated/floor/rust/up
	icon_state = "rustup"
/turf/simulated/floor/rust/left
	icon_state = "rustleft"
/turf/simulated/floor/rust/right
	icon_state = "rustright"
/turf/simulated/floor/rust/upleft
	icon_state = "rust1"
/turf/simulated/floor/rust/upright
	icon_state = "rust2"
/turf/simulated/floor/rust/downright
	icon_state = "rust3"
/turf/simulated/floor/rust/downleft
	icon_state = "rust4"

//| fountain floor
/turf/simulated/floor/fountain
	name = "fountain pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved200"

/turf/simulated/floor/fountain2
	name = "fountain pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved201"
//borders
/turf/simulated/floor/borders
	name = "border"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "border1"

/turf/simulated/floor/borders/border2
	icon_state = "border2"

/turf/simulated/floor/borders/border3
	icon_state = "border3"

/turf/simulated/floor/borders/border4
	icon_state = "border4"

/turf/simulated/floor/borders/border5
	icon_state = "border5"

/turf/simulated/floor/borders/border6
	icon_state = "border6"

/turf/simulated/floor/borders/border7
	icon_state = "border7"

/turf/simulated/floor/borders/border8
	icon_state = "border8"

/turf/simulated/floor/borders/border9
	icon_state = "border9"

/turf/simulated/floor/borders/border10
	icon_state = "border10"

/turf/simulated/floor/borders/border11
	icon_state = "border11"

/turf/simulated/floor/borders/border12
	icon_state = "border12"

/turf/simulated/floor/borders/border13
	icon_state = "border13"

/turf/simulated/floor/borders/border14
	icon_state = "border14"

/turf/simulated/floor/borders/border15
	icon_state = "border15"

/turf/simulated/floor/borders/border16
	icon_state = "border16"

//something new
/turf/simulated/floor/grooved
	name = "grooved"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "grooved"

/turf/simulated/floor/grooved/another
	icon_state = "grooved2"

/turf/simulated/floor/tiledwood
	name = "tiled wooden floor"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "tiledwood"

/turf/simulated/floor/tiledwood/another
	icon_state = "tiledwood2"