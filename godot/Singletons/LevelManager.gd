extends Node

var Level_1 = preload("res://Scenes/Levels/Level_1.tscn")
var Level_2 = preload("res://Scenes/Levels/Level_2.tscn")
var Level_3 = preload("res://Scenes/Levels/Level_3.tscn")
var Level_4 = preload("res://Scenes/Levels/Level_4.tscn")
var Level_5 = preload("res://Scenes/Levels/Level_5.tscn")

var level = 1
var level_map
var current_level
onready var root = get_tree().get_root()

func _ready():
	level_map = _level_map()

func _level_map():
	return {
		1: Level_1,
		2: Level_2,
		3: Level_3,
		4: Level_4,
		5: Level_5
	}

func next_level():
	level += 1
	var next_level = level_map[level].instance()
	
	root.add_child(next_level)
