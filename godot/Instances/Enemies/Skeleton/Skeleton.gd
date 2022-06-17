extends KinematicBody2D

onready var sprite:Sprite = $Sprite
onready var debug_path:Line2D = $DebugLine
onready var player_detector:RayCast2D = $PlayerDetector
onready var rerun_nav:Timer = $RerunNav
onready var anim_tree:AnimationTree = $AnimationTree

export var enemy_data: Resource = EnemyData
export var Orb: PackedScene = null

export var debug_enabled: bool = false
export var attacking: bool = false
export var can_attack: bool = true

var speed = 10
var close_enough = 10.0
var close_enough_to_player = 30.0
var velocity = Vector2.ZERO
var near_enough = 4
var found_player: bool = false
var attack_collided:bool = false

var health: int = 0
var path: Array = []
var player = null
var nav: Navigation2D = null
var state_machine: AnimationNodeStateMachinePlayback

func _ready():
	health = enemy_data.health
	player = LevelManager.get_player()
	player_detector.player = player
	assert(player)
	nav = LevelManager.get_nav2d()
	assert(nav)
	state_machine = anim_tree["parameters/playback"]

func _process(_delta):
	if debug_enabled:
		debug_path.global_position = Vector2.ZERO
	velocity = Vector2.ZERO
	
	if found_player:
		if attacking:
			check_attack_collision()
			velocity = Vector2.ZERO
		else:
			if check_attack_range():
				return
			handle_movement()
	else:
		find_player()

func handle_movement():
	if player.global_position.x > global_position.x:
		sprite.scale = Vector2(1,1)
	else:
		sprite.scale = Vector2(-1,1)
	navigate()
	if path.empty():
		generate_path()
	move()

func navigate():
	if close_enough_to_player > global_position.distance_to(player.global_position):
		return
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		if global_position.distance_to(path[1]) < close_enough:
			path.pop_front()

func move():
	if velocity == Vector2.ZERO:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")
	
	velocity = move_and_slide(velocity)

func generate_path():
	path = nav.get_simple_path(global_position, player.global_position, false)
	if debug_enabled:
		debug_path.points = path

func check_player_in_range():
	var found = player_detector.get_collider()
	return found and (found == player or found.get_parent() == player)

func find_player():
	if check_player_in_range():
		found_player = true
		rerun_nav.start()
		player_detector.use_attack_distance()

func check_attack_range():
	if can_attack and check_player_in_range():
		attacking = true
		can_attack = false
		state_machine.travel("Attack")
		return true
	return false

func lose_health():
	health -= 1
	if health == 0:
		state_machine.travel('Die')

func _on_RerunNav_timeout():
	generate_path()

func _on_AttackCooldown_timeout():
	can_attack = true
	attack_collided = false
	$AttackCooldown.stop()

func spawn_orb():
	var orb = Orb.instance()
	orb.position = global_position
	get_parent().call_deferred('add_child', orb)

func check_attack_collision():
	if attack_collided:
		return
	for area in $Sprite/HitBox.get_overlapping_areas():
		#print(area)
		if area.get_parent().is_in_group('Player'):
			attack_collided = true
			print(area.get_parent())
			#area.get_parent().lose_health()
	
