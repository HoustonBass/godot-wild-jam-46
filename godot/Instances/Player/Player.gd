extends KinematicBody2D

onready var orbs = $Orbs
onready var sprite:Sprite = $Sprite
onready var anim_tree:AnimationTree = $AnimationTree
onready var camera:Camera2D = $Camera2D

export var debug_enabled: bool = false
export var attacking: bool = false
export var player_data: Resource = PlayerData

var state_machine: AnimationNodeStateMachinePlayback

var speed = 60.0
var velocity = Vector2.ZERO
var dead: bool = false
var attack_collided: Array = []

func _ready():
	camera.set_zoom(Vector2(0.5, 0.5))
	state_machine = anim_tree["parameters/playback"]
	for _i in range(player_data.health):
		orbs.add_orb(null)

func _process(_delta):
	if debug_enabled:
		if Input.is_action_just_pressed("ui_accept"):
			gain_health(null)
		if Input.is_action_just_pressed("ui_cancel"):
			lose_health()
	if dead:
		return

	if attacking:
		check_attack_collision()
	elif Input.is_action_just_pressed("ui_action"):
		attack()
	else:
		var movementDir = Vector2.ZERO
		
		set_dir()
		if Input.is_action_pressed("ui_right"):
			movementDir += Vector2.RIGHT
		if Input.is_action_pressed("ui_left"):
			movementDir += Vector2.LEFT
		if Input.is_action_pressed("ui_up"):
			movementDir += Vector2.UP
		if Input.is_action_pressed("ui_down"):
			movementDir += Vector2.DOWN
		
		velocity = movementDir.normalized() * speed
		#todo: getting close and personal with walls is wonky
		move()

func move():
	if velocity == Vector2.ZERO:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")
	velocity = move_and_slide(velocity)

func set_dir():
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x > global_position.x:
		sprite.scale = Vector2(1,1)
	else:
		sprite.scale = Vector2(-1,1)

func attack():
	attacking = true
	state_machine.travel("Attack")
	attack_collided = []

func check_attack_collision():
	for area in $Sprite/HitBox.get_overlapping_areas():
		if !attack_collided.has(area) and area.is_in_group('Enemy'):
			attack_collided.push_front(area)
			#todo: how do you scale the tree?
			area.get_parent().get_parent().lose_health()

func gain_health(orb):
	orbs.add_orb(orb)
	player_data.health += 1
func lose_health():
	orbs.remove_orb()
	player_data.health -= 1
	if player_data.health == 0:
		state_machine.travel("Die")
		dead = true
		Engine.time_scale = 0.3

func after_death():
	Engine.time_scale = 1.0
	
