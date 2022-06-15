extends KinematicBody2D

onready var orbs = $Orbs

export var player_data: Resource = PlayerData

var speed = 60.0

func _ready():
	for i in range(player_data.health):
		gain_health()

func _process(_delta):
	var movementDir = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		movementDir += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		movementDir += Vector2.LEFT
	if Input.is_action_pressed("ui_up"):
		movementDir += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		movementDir += Vector2.DOWN
	if Input.is_action_just_pressed("ui_accept"):
		gain_health()
	if Input.is_action_just_pressed("ui_cancel"):
		lose_health()
	
	var vel = movementDir.normalized() * speed
	#todo: getting close and personal with walls is wonky
	var _collision = move_and_slide(vel)

func gain_health():
	orbs.add_orb()
func lose_health():
	orbs.remove_orb()
