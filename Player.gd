extends KinematicBody

signal hit

export var speed = 14.0
export var jump_impulse = 20.0
export var fall_acceleration = 75.0
export var bounce_impulse = 16.0

var velocity = Vector3.ZERO

func die():
	emit_signal("hit")
	queue_free()

func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if(direction != Vector3.ZERO):
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4.0
	else:
		$AnimationPlayer.playback_speed = 1.0
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_impulse
		$Sounds/JumpSound.pitch_scale = rand_range(0.8,1.0)
		$Sounds/JumpSound.play()
	
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			if Vector3.UP.dot(collision.normal) > 0.1:
				mob.squash()
				velocity.y = bounce_impulse
				
	$Pivot.rotation.x = PI / 6.0 * velocity.y / jump_impulse

func squeak():
	$Sounds/Squeak.pitch_scale = rand_range(1.8,2.0)
	$Sounds/Squeak.play()


func _on_Mob_squashed():
	$Sounds/Squash.pitch_scale = rand_range(0.8,1.0)
	$Sounds/Squash.play()

func _on_MobDetector_body_entered(body):
	die()
