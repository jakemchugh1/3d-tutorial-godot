extends Spatial

func initialize(startLocation, sound):
	translation = startLocation
	$AudioStreamPlayer3D.stream = sound
	
func setPitch(pitch):
	$AudioStreamPlayer3D.pitch_scale = pitch
	
func playSound():
	$AudioStreamPlayer3D.play()

func _on_AudioStreamPlayer3D_finished():
	queue_free()
