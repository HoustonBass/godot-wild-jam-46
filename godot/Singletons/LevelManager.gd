extends Node

var Level_0 = preload("res://Scenes/Levels/Tower/Level_0.tscn")
var Level_1 = preload("res://Scenes/Levels/Tower/Level_1.tscn")
var Level_2 = preload("res://Scenes/Levels/Tower/Level_2.tscn")
var Level_3 = preload("res://Scenes/Levels/Tower/Level_3.tscn")
var Level_4 = preload("res://Scenes/Levels/Tower/Level_4.tscn")
var Level_5 = preload("res://Scenes/Levels/Tower/Level_5.tscn")

var level = 0
var level_map

var current_level = null setget register_level, get_level

func register_level(node):
	current_level = node
func get_level():
	return current_level

onready var root = get_tree().get_root()

func _ready():
	level_map = _level_map()

func _level_map():
	return {
		0: Level_0,
		1: Level_1,
		2: Level_2,
		3: Level_3,
		4: Level_4,
		5: Level_5
	}

func next_level():
	level += 1
	
	root.remove_child(current_level)
	current_level.call_deferred("queue_free")
	var next_level = level_map[level].instance()
	current_level = next_level
	root.call_deferred("add_child", next_level)

#registration section
var nav2d: Navigation2D = null setget register_nav2d, get_nav2d

func register_nav2d(node):
	nav2d = node
func get_nav2d():
	return nav2d

var player = null setget register_player, get_player

func register_player(node):
	player = node
func get_player():
	return player
