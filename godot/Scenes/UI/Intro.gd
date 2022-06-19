extends Node

var max_anim_states: int
var animation_state = 1

onready var background = $CC/Background

onready var anim_tree:AnimationTree = $AnimationTree
var state_machine: AnimationNodeStateMachinePlayback

func _ready():
	LevelManager.register_level(self)
	MusicPlayer.swap_to_track(MusicPlayer.Songs.Intro)
	max_anim_states = background.get_child_count()
	for child in background.get_children():
		child.visible = false
	state_machine = anim_tree["parameters/playback"]
	state_machine.travel(str(animation_state))

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if animation_state < max_anim_states:
			animation_state += 1
			state_machine.travel(str(animation_state))
		else:
			state_machine.travel("End")

func start_game():
	LevelManager.next_level()
