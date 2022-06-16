extends KinematicBody2D

onready var sprite:Sprite = $Sprite
onready var debug_path:Line2D = $DebugLine

var speed = 5
var velocity = Vector2.ZERO
var near_enough = 4

var path = []
var player = null
var nav: Navigation2D = null

func _ready():
	player = LevelManager.get_player()
	assert(player)
	nav = LevelManager.get_nav2d()
	assert(nav)

func _process(_delta):
	debug_path.global_position = Vector2.ZERO
	#debug_path
	velocity = Vector2.ZERO
	if path.empty():
		generate_path()
	navigate()
	move()

func navigate():
	if !path.empty():
		velocity = global_position.direction_to(path[1]) * speed
		
		if global_position == path[1]:
			path.pop_front()

func move():
	velocity = move_and_slide(velocity)

func generate_path():
	path = nav.get_simple_path(global_position, player.global_position, false)
	debug_path.points = path

func _on_HitBox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Players"):
		body.take_damage()


func _on_DetectPlayer_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Players"):
		player = body
