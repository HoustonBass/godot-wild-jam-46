extends Node2D

var rng = RandomNumberGenerator.new()

onready var sprite = $Sprite
onready var offset_timer = $OffsetTimer

var speed = 1
var radius = 20

export var initial_angle: float
export var color: int = -1

var total_offset = 0.0

#todo: add broken orb particles

func _ready():
	rng.randomize()
	if color < 0 or color > 7:
		color = rng.randi_range(0, 7)
	sprite.frame = color
	sprite.position = Vector2(radius, 0)
	rotation = initial_angle

func _process(delta):
	var offset_fraction = total_offset/offset_timer.wait_time * delta
	rotation += speed * delta + offset_fraction
	if rotation > 2 * PI:
		rotation = fmod(rotation, 2*PI)

func reset_position(mod):
	total_offset = get_offset_distance(mod)
	offset_timer.start()

func get_offset_distance(mod) -> float:
	var rot = fposmod(rotation, PI*2.0) 
	var bound_rot = fmod(rot, mod)
	if bound_rot < (mod / PI*2.0):
		return bound_rot * -1
	else:
		return mod - bound_rot

func die():
	$AnimationPlayer.play("Die")

func _on_OffsetTimer_timeout():
	total_offset = 0
