extends Node

export (PackedScene) var mob_scene = preload("res://Mob.tscn")
export (PackedScene) var soundInstance = preload("res://SoundInstance.tscn")
export (AudioStream) var squeakSound = preload("res://sounds/squeak_0.wav")
export (AudioStream) var squashSound = preload("res://sounds/squeak_1.wav")
export (AudioStream) var jumpSound = preload("res://sounds/updown.wav")

func _ready():
	randomize()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	
	var mob_spawn_location = $SpawnPath/SpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	
	add_child(mob)
	mob.initialize(mob_spawn_location.translation, player_position)
	mob.connect("squashed", self, "_on_Mob_squashed")
	mob.connect("squeak", self, "_on_Squeak")

func _on_Mob_squashed(startLocation):
	$UserInterface/ScoreLabel._on_Mob_squashed()
	var sound = soundInstance.instance()
	add_child(sound)
	sound.initialize(startLocation, squashSound)
	sound.setPitch(rand_range(0.8,1))
	sound.setDB(15)
	sound.playSound()

func _on_Player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
	
func _on_Squeak(startLocation):
	var sound = soundInstance.instance()
	add_child(sound)
	sound.initialize(startLocation, squeakSound)
	sound.setPitch(rand_range(1.5,1.7))
	sound.setDB(10)
	sound.playSound()


func _on_Player_squeak(startLocation):
	var sound = soundInstance.instance()
	add_child(sound)
	sound.initialize(startLocation, squeakSound)
	sound.setPitch(rand_range(1.8,2))
	sound.setDB(20)
	sound.playSound()


func _on_Player_jump(startLocation):
	var sound = soundInstance.instance()
	add_child(sound)
	sound.initialize(startLocation, jumpSound)
	sound.setPitch(rand_range(0.8,1))
	sound.setDB(15)
	sound.playSound()
