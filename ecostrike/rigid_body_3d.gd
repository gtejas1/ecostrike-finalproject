extends RigidBody3D

# Strength of the initial push
@export var roll_strength: float = 0.3
@export var direction: Vector3 = Vector3(0, 0, 1)
var initial_position: Vector3 = Vector3(0, 1, 2.5)
@export var reset_height: float = -3.0  # Threshold height for resetting the sphere
var current_ball: RigidBody3D = null
var selected_sphere: RigidBody3D = null
@export var highlight_material: Material
@export var default_material: Material

func _ready():
	initial_position = Vector3(0, 1, 2.5)

func _physics_process(delta):
	pass
	# Check if the sphere has fallen below the reset height
	#if self.global_transform.origin.y < reset_height:
		#reset_sphere() 
		
		#current_ball = spawn_ball()
		#queue_free()

#func _on_button_pressed(name: String) -> void:
	#
	##print('button pressed: ',name)
	#if name == "ax_button":
		#var forward_direction = -$"../XROrigin3D/RightController/RayCast3D".global_transform.basis.z.normalized()
		##apply_impulse(Vector3.ZERO, direction.normalized() * roll_strength)
		##print("forward_direction ",forward_direction)
		##print("Ray target position ",$"../XROrigin3D/RightController/RayCast3D".target_position)
		##apply_impulse(direction, forward_direction * roll_strength)
		#
		#if selected_sphere != null:
			#if selected_sphere.name == "RigidBodySphere1":
				#selected_sphere.apply_central_force(forward_direction * 400)
			#if selected_sphere.name == "RigidBodySphere2":
				#selected_sphere.apply_central_force(forward_direction * 600)
		#if current_ball != null :
			#current_ball.apply_central_force(forward_direction * 50)
	#if name == "by_button":
		## Reset the sphere's position and stop its movement
		#reset_sphere()
	#if name == "trigger_click":
		#select_sphere()
	

func reset_sphere():
	# Reset the sphere's position and stop its movement
	#print(initial_position)
	#print("before reset", global_transform.origin )
	var collision_point: Vector3
	var raycast = $"../XROrigin3D/RightController/RayCast3D"
	if raycast.is_colliding():
		collision_point = raycast.get_collision_point()
		
	if selected_sphere != null:
		selected_sphere.linear_velocity = Vector3.ZERO
		selected_sphere.angular_velocity = Vector3.ZERO
		selected_sphere.position = collision_point
		selected_sphere.global_transform.origin = collision_point
	#print(self.global_transform.origin)
	#print("after reset", position )
	print("Sphere reset to initial position")

#func spawn_ball():
	#var ball_instance = ball_scene.instantiate()
	##ball_instance.global_transform.origin = initial_position
	#
	#get_parent().add_child(ball_instance)
	#ball_instance.global_transform.origin = initial_position
	#ball_instance.position = initial_position
	#return ball_instance.get_child(0)
	
	
func select_sphere():
	var raycast = $"../XROrigin3D/RightController/RayCast3D"
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		print(collider.name)
		if selected_sphere != null:
			selected_sphere.get_node("CSGSphere3D").material_override = default_material
		if collider.name == "RigidBodySphere1" or collider.name == "RigidBodySphere2":
			selected_sphere = collider
			selected_sphere.get_node("CSGSphere3D").material_override = highlight_material 
		#print("Selected sphere:", selected_sphere)
		#if collider.name == "Sphere1" or collider.name == "Sphere2":
			#selected_sphere = collider
			#print("Selected sphere:", selected_sphere.name)
