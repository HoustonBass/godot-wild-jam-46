extends Node

onready var intro_player: AudioStreamPlayer = $IntroMusic
onready var credits_player: AudioStreamPlayer = $CreditsMusic
onready var boss_player: AudioStreamPlayer = $BossMusic
onready var dungeon_player: AudioStreamPlayer = $DungeonMusic

enum Songs { Intro, Dungeon, Boss, Credits }
var song_map
var current_player

func _ready():
	song_map = setup_song_map()

func swap_to_track(song: int):
	#todo, problly a bug here when swapping to the same song or something, idk didnt test it
	if current_player != song_map[song]:
		if current_player:
			current_player.stop()
		current_player = song_map[song]
		current_player.play_track()
		current_player.set_bus("Master")

func muffle_music():
	current_player.set_bus("Muffle")

func reset_effects():
	current_player.set_bus("Master")

func setup_song_map():
	return {
		Songs.Intro: intro_player,
		Songs.Boss: boss_player,
		Songs.Credits: credits_player,
		Songs.Dungeon: dungeon_player
	}
