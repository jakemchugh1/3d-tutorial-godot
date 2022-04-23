extends Spatial

func initialize(startLocation, sound):
	translation = startLocation
	$AudioStreamPlayer3D.stream = sound
	
func setPitch(pitch):
	$AudioStreamPlayer3D.pitch_scale = pitch
	
func playSound():
	$AudioStreamPlayer3D.play()
	
func _process(_delta):
	if not $AudioStreamPlayer3D.playing:
		queue_free()
