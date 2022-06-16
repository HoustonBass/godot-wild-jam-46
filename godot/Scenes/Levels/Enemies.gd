extends TileMapSpawner

export var Skelly: PackedScene

func _ready():
	#todo, check if there is a better way to get specifically the stair tiles
	var tiles = get_used_cells()
	for pos in tiles:
		var tile_name = _convert_to_tile_name(pos)
		match tile_name:
			'Skeleton':
				_create_skeleton(pos)
			_:
				print('Could not create instance for tile: %s' % tile_name)
		set_cellv(pos, -1)

func _convert_to_tile_name(pos: Vector2):
	var cell_tile_id = self.get_cellv(pos)
	var tile_name = self.get_tileset().tile_get_name(cell_tile_id)
	return tile_name

func _create_skeleton(pos: Vector2):
	var skeleton = Skelly.instance()
	map_to_world(pos)
	skeleton.position = map_to_world(pos)# - Vector2(75, 75)
	#todo, check if this is the best place/way to add this
	add_to_parent(skeleton)
