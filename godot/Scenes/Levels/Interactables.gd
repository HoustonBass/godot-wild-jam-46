extends TileMapSpawner

const Stair = preload("res://Instances/Tiles/Stairs/Stairs.tscn")
export var Player: PackedScene

func handle_tile(tile_name: String, pos: Vector2):
	match tile_name:
		'Stair_Up_Right':
			_create_stairs_up(tile_name, pos)
		'Stair_Down_Right':
			_create_player(pos, true)
		'Stair_Down_Left':
			_create_player(pos, false)
		_:
			print('Could not create instance for tile: %s' % tile_name)

func _create_stairs_up(tile_name: String, pos: Vector2):
	var stair = Stair.instance()
	stair.setup(tile_name)
	stair.position = map_to_world(pos)
	add_to_parent(stair)

func _create_player(pos, right:bool):
	var player = Player.instance()
	var offset = 1 if right else 0
	var offset_pos = Vector2(pos.x + offset, pos.y)
	player.position = map_to_world(offset_pos)
	add_to_parent(player)
	LevelManager.register_player(player)
