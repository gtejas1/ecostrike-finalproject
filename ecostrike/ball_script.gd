extends RigidBody3D

# Strength of the initial push
@export var roll_strength: float = 0.3
@export var direction: Vector3 = Vector3(0, 0, 1)
var initial_position: Vector3 = Vector3(0, 1, 2.5)
@export var reset_height: float = -3.0  # Threshold height for resetting the sphere


func _ready():
	initial_position = Vector3(0, 0, 2.5)


func _on_button_pressed(name: String) -> void:
	# Apply an impulse to roll the sphere
	#print('button pressed: ',name)
	if name == "ax_button":
		var forward_direction = -$"../XROrigin3D/RightController/RayCast3D".global_transform.basis.z.normalized()
		#apply_impulse(Vector3.ZERO, direction.normalized() * roll_strength)
		print("forward_direction ",forward_direction)
		print("Ray target position ",$"../XROrigin3D/RightController/RayCast3D".target_position)
		#apply_impulse(direction, forward_direction * roll_strength)
		apply_central_force(forward_direction * 50)
	#if name == "by_button":
		## Reset the sphere's position and stop its movement
		#reset_sphere()
		
	

func reset_sphere():
	# Reset the sphere's position and stop its movement
	#print(initial_position)
	print("before reset", global_transform.origin )
	$".".linear_velocity = Vector3.ZERO
	$".".angular_velocity = Vector3.ZERO
	$".".position.x = 0
	$".".position.y = 1
	$".".position.z = 2.5
	#print(self.global_transform.origin)
	print("after reset", position )
	print("Sphere reset to initial position")


	
