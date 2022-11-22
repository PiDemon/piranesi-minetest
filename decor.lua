---------
--decor--
---------
minetest.register_node("piranesi:black", {
		description = "Black",
		tiles = {"black.png"},
		groups = {cracky = 1, pickaxey=2, handy=1}
})
minetest.register_node("piranesi:black_with_yellow", {
		description = "black with yellow",
		tiles = {{name = "black_with_yellow.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3}}},
		light_source = 14,
		paramtype = "light",
		groups = {crumbly=1},
})
minetest.register_node("piranesi:pine_tree", {
	description = "Breakable Pine Tree",
	tiles = {"default_pine_tree_top.png", "default_pine_tree_top.png",
		"default_pine_tree.png"},
	paramtype2 = "facedir",
	
	groups = {axe = 1, tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})
minetest.register_node("piranesi:dirt_with_grass", {
	description = "Breakable Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png",
		{name = "default_dirt.png^default_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, shovel=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})
minetest.register_alias("invisible_blocks:invisible_barriers","piranesi:barrier")
minetest.register_node("piranesi:barrier", {
	description = "barrier",
	inventory_image = "default_steel_ingot.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
	drop = "",
	groups = {cracky=1}
})
minetest.register_node("piranesi:altar", {
	description = "altar",
	tiles = {"altar_top.png", "altar_top.png", "altar_side.png", "altar_side.png", "altar_side.png", "altar_side.png"},
	paramtype = "light",
	light_source = 8,
	groups = {crumbly=1},
})