//|| Roads	#TODO - sometime in the future not a huge priority - handle directional icon changes in update_icon for road in-game construction as well as make damage icons
#define world.realtimeCHANGE (change_time_of_day())

/turf/simulated/floor/outdoors/road
	name = "Road"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "road"
	light_color = "#ebf7fe"
	light_power = 5
	light_range = 2

/turf/simulated/floor/outdoors/road/vertical/
	icon_state = "road1"
/turf/simulated/floor/outdoors/road/vertical/zebra
	icon_state = "zebra1"
/turf/simulated/floor/outdoors/road/horizontal
	icon_state = "road10"
/turf/simulated/floor/outdoors/road/horizontal/zebra
	icon_state = "zebra2"
/turf/simulated/floor/outdoors/road/vertical/east/
	icon_state = "road3"
/turf/simulated/floor/outdoors/road/vertical/west
	icon_state = "road2"
/turf/simulated/floor/outdoors/road/horizontal/north
	icon_state = "road5"
/turf/simulated/floor/outdoors/road/horizontal/south
	icon_state = "road4"

//| Road corners
/turf/simulated/floor/outdoors/road/northeast
	icon_state = "road6"
/turf/simulated/floor/outdoors/road/northwest
	icon_state = "road7"
/turf/simulated/floor/outdoors/road/southeast
	icon_state = "road8"
/turf/simulated/floor/outdoors/road/southwest
	icon_state = "road9"
/turf/simulated/floor/outdoors/road/northeastsmall
	icon_state = "road13"
/turf/simulated/floor/outdoors/road/northwestsmall
	icon_state = "road12"
/turf/simulated/floor/outdoors/road/southeastsmall
	icon_state = "road14"
/turf/simulated/floor/outdoors/road/southwestsmall
	icon_state = "road11"


//| Pavement corners
/turf/simulated/floor/outdoors/pavement
	name = "pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved"
/turf/simulated/floor/outdoors/pavement/stone
	icon_state = "stonepavement"
/turf/simulated/floor/outdoors/pavement/east
	icon_state = "paved2"
/turf/simulated/floor/outdoors/pavement/west
	icon_state = "paved4"
/turf/simulated/floor/outdoors/pavement/north
	icon_state = "paved5"
/turf/simulated/floor/outdoors/pavement/south
	icon_state = "paved6"
/turf/simulated/floor/outdoors/pavement/edge/southeast
	icon_state = "paved10"
/turf/simulated/floor/outdoors/pavement/edge/southeast/corner
	icon_state = "paved3"
/turf/simulated/floor/outdoors/pavement/edge/northeast
	icon_state = "paved11"
/turf/simulated/floor/outdoors/pavement/edge/northeast/corner
	icon_state = "paved7"
/turf/simulated/floor/outdoors/pavement/edge/southwest
	icon_state = "paved12"
/turf/simulated/floor/outdoors/pavement/edge/southwest/corner
	icon_state = "paved8"
/turf/simulated/floor/outdoors/pavement/edge/northwest
	icon_state = "paved13"
/turf/simulated/floor/outdoors/pavement/edge/northwest/corner
	icon_state = "paved9"


//| Ржавчина
/turf/simulated/floor/outdoors/rust
	name = "rust floor"
	icon = 'icons/gta13/rust.dmi'
	icon_state = "rust"
/turf/simulated/floor/outdoors/rust/up
	icon_state = "rustup"
/turf/simulated/floor/outdoors/rust/left
	icon_state = "rustleft"
/turf/simulated/floor/outdoors/rust/right
	icon_state = "rustright"
/turf/simulated/floor/outdoors/rust/upleft
	icon_state = "rust1"
/turf/simulated/floor/outdoors/rust/upright
	icon_state = "rust2"
/turf/simulated/floor/outdoors/rust/downright
	icon_state = "rust3"
/turf/simulated/floor/outdoors/rust/downleft
	icon_state = "rust4"

//| fountain floor
/turf/simulated/floor/outdoors/fountain
	name = "fountain pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved200"

/turf/simulated/floor/outdoors/fountain2
	name = "fountain pavement"
	icon = 'icons/gta13/pave.dmi'
	icon_state = "paved201"
//borders
/turf/simulated/floor/outdoors/borders
	name = "border"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "border1"

/turf/simulated/floor/outdoors/borders/border2
	icon_state = "border2"

/turf/simulated/floor/outdoors/borders/border3
	icon_state = "border3"

/turf/simulated/floor/outdoors/borders/border4
	icon_state = "border4"

/turf/simulated/floor/outdoors/borders/border5
	icon_state = "border5"

/turf/simulated/floor/outdoors/borders/border6
	icon_state = "border6"

/turf/simulated/floor/outdoors/borders/border7
	icon_state = "border7"

/turf/simulated/floor/outdoors/borders/border8
	icon_state = "border8"

/turf/simulated/floor/outdoors/borders/border9
	icon_state = "border9"

/turf/simulated/floor/outdoors/borders/border10
	icon_state = "border10"

/turf/simulated/floor/outdoors/borders/border11
	icon_state = "border11"

/turf/simulated/floor/outdoors/borders/border12
	icon_state = "border12"

/turf/simulated/floor/outdoors/borders/border13
	icon_state = "border13"

/turf/simulated/floor/outdoors/borders/border14
	icon_state = "border14"

/turf/simulated/floor/outdoors/borders/border15
	icon_state = "border15"

/turf/simulated/floor/outdoors/borders/border16
	icon_state = "border16"

//something new
/turf/simulated/floor/outdoors/grooved
	name = "grooved"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "grooved"

/turf/simulated/floor/outdoors/grooved/another
	icon_state = "grooved2"

/turf/simulated/floor/outdoors/tiledwood
	name = "tiled wooden floor"
	icon = 'icons/gta13/roads.dmi'
	icon_state = "tiledwood"

/turf/simulated/floor/outdoors/tiledwood/another
	icon_state = "tiledwood2"