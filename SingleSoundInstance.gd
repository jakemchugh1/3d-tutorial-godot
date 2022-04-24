extends Spatial

func initialize(startLocation, sound):
	translation = startLocation
	$AudioStreamPlayer3D.stream = sound
	$AudioStreamPlayer3D.orthonormalize()
	
func setPitch(pitch):
	$AudioStreamPlayer3D.pitch_scale = pitch

func setDB(level):
	$AudioStreamPlayer3D.unit_db = level

func playSound():
	$AudioStreamPlayer3D.play()

func _on_AudioStreamPlayer3D_finished():
	queue_free()
