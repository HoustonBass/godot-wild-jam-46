extends Area2D

onready var notify_box  = $NotifyBox

enum Direction {RIGHT, LEFT}
var direction

func _get_direction_from_name(name: String):
	match name:
		'Stair_Up_Right':
			return Direction.RIGHT
		'Stair_Up_Left':
			return Direction.LEFT
		_:
			print('Could not figure out what direction from name %s' % name)

func setup(dir_name: String):
	direction = _get_direction_from_name(dir_name)

func _ready():
	match direction:
		Direction.RIGHT:
			pass
		Direction.LEFT:
			notify_box.transform.scale = Vector2(-1,1)
		_:
			print('did not handle direction %s for stairs' % direction)

func _on_Stairs_area_entered(area):
	if area.is_in_group("Player"):
		notify_box.call_deferred("set_disabled", true)
		LevelManager.call_deferred("next_level")
