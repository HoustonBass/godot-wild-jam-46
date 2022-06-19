extends AudioStreamPlayer

export var intro: AudioStream
export var loop: AudioStream

func _ready():
	self.connect("finished", self, "_play_loop")

func play_track():
	if intro:
		stream = intro
	else:
		stream = loop
	play()

func _play_loop():
	stream = loop
	play()
