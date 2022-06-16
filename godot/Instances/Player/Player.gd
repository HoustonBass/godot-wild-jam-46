extends KinematicBody2D

onready var orbs = $Orbs
onready var animation_player = $AnimationPlayer
onready var sprite:Sprite = $Sprite

export var player_data: Resource = PlayerData

enum Direction {RIGHT, LEFT}

var dir = Direction.RIGHT
var speed = 60.0

func _ready():
	for _i in range(player_data.health):
		gain_health()

func _process(_delta):
	set_dir()
	var movementDir = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		movementDir += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		movementDir += Vector2.LEFT
	if Input.is_action_pressed("ui_up"):
		movementDir += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		movementDir += Vector2.DOWN
	
	if Input.is_action_just_pressed("ui_action"):
		attack()
	if Input.is_action_just_pressed("ui_accept"):
		gain_health()
	if Input.is_action_just_pressed("ui_cancel"):
		lose_health()
	
	var vel = movementDir.normalized() * speed
	#todo: getting close and personal with walls is wonky
	var _collision = move_and_slide(vel)

func set_dir():
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x > global_position.x:
		sprite.set_flip_h(false)
		dir = Direction.LEFT
	else:
		sprite.set_flip_h(true)
		dir = Direction.LEFT
func attack():
	animation_player.play("Attack - Right")
func gain_health():
	orbs.add_orb()
func lose_health():
	orbs.remove_orb()
