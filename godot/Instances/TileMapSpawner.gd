extends TileMap
class_name TileMapSpawner

func _ready():
	#todo, check if there is a better way to get specifically the stair tiles
	var stair_tiles = get_used_cells()
	for pos in stair_tiles:
		var tile_name = _convert_to_tile_name(pos)
		handle_tile(tile_name, pos)

func handle_tile(_tile_name: String, _pos: Vector2):
	pass

func _convert_to_tile_name(pos: Vector2):
	var cell_tile_id = self.get_cellv(pos)
	var tile_name = self.get_tileset().tile_get_name(cell_tile_id)
	return tile_name

func add_to_parent(node):
	#todo, check if this is the best place/way to add this
	get_parent().call_deferred("add_child", node)
