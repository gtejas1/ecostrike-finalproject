#extends XRController3D
#
#var entered_area = null
#var grabbed = null
#var active_collider = null
#var grabbed_object = null
#var grabbed_distance = 0.0
#
#var last_pos
#var last_velocity = Vector3.ZERO
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#last_pos = global_position
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var start = global_position + (-global_basis.z * 0.1)
	#var end = (-global_basis.z * 0.1) + start
	#print("start: ",start)
	#print("end: ",end)
	#$MeshInstance3D.points[0] = start
	#$MeshInstance3D.points[1] = end
	#$"RayCast3D".target_position = $"RayCast3D".to_local(end)
	#
	#if $"RayCast3D".is_colliding():
		#var cur_collider = $"RayCast3D".get_collider()
		#print("cur_collider: ",cur_collider)
		##if grabbed_object == null:
		#if active_collider == null or active_collider != cur_collider:
			#active_collider = cur_collider
			#
		#$MeshInstance3D.points[1] = $"RayCast3D".get_collision_point()
		##grabbed_distance = global_position.distance_to($"LineRenderer".points[1])
	#elif active_collider != null:
		#active_collider = null
#
	#if grabbed_object != null:
		#print(" Before grabbed_object.global_position: ",grabbed_object.global_position)
		#print("moving...")
		##print("grabbed_distance: ",grabbed_distance)
		#grabbed_object.global_position =global_position + (-global_basis.z * grabbed_distance)
		#print(" After grabbed_object.global_position: ",grabbed_object.global_position)
##
##func _on_input_float_changed(name: String, value: float) -> void:
	##
	##if name == "grip":
		##if grabbed == null and entered_area != null and value >= 0.2:
			##grabbed = entered_area.get_parent_node_3d()
		##
		##if grabbed != null and value < 0.2:
			##grabbed = null
	##
	###if name == "grip":
		###if grabbed == null and entered_area != null and value >= 0.2:
			###grabbed = entered_area.get_parent_node_3d()
				###
		###elif grabbed != null and value < 0.2:
			###grabbed = null
#
#
##func _on_area_3d_area_entered(area):
	##print("entered:",area)
	##entered_area = area
	##
##
##func _on_area_3d_area_exited(area):
	##print("exited:",area)
	##entered_area = null
#
#
#func _on_button_pressed(name: String) -> void:
	#if name == "grip_click":
		#if active_collider != null:
			##grabbed_object = active_collider.get_parent_node_3d()
			#grabbed_object = active_collider
			#print("grabbed_object: ", grabbed_object)
			#grabbed_distance = global_position.distance_to($MeshInstance3D.points[1])
			#
			##grabbed_distance=0.1
			#print("grabbed_distance: ",grabbed_distance)
#
#
#func _on_button_released(name: String) -> void:
	#if name == "grip_click":
		#grabbed_object = null


extends XRController3D
 
var entered_area = null
var grabbed = null
var active_collider = null
var grabbed_object = null
var grabbed_distance = 0.0
 
var last_pos
var last_velocity = Vector3.ZERO
 
# Called when the node enters the scene tree for the first time.
func _ready():
	last_pos = global_position
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var start = global_position + (-global_basis.z * 0.1)
	var end = (-global_basis.z * 0.1) + start
	#print("start: ", start)
	#print("end: ", end)
	$MeshInstance3D.points[0] = start
	$MeshInstance3D.points[1] = end
	$"RayCast3D".target_position = $"RayCast3D".to_local(end)
	if $"RayCast3D".is_colliding():
		var cur_collider = $"RayCast3D".get_collider()
		#print("cur_collider: ", cur_collider)
		if active_collider == null or active_collider != cur_collider:
			active_collider = cur_collider
		$MeshInstance3D.points[1] = $"RayCast3D".get_collision_point()
	elif active_collider != null:
		active_collider = null
 
	if grabbed_object != null:
		#print("Before grabbed_object.global_position: ", grabbed_object.global_position)
		#print("moving...")
		grabbed_object.global_position = global_position + (-global_basis.z * grabbed_distance)
		#print("After grabbed_object.global_position: ", grabbed_object.global_position)
	# Calculate velocity of the controller
	calculate_velocity(delta)
 
# Function to calculate the velocity of the controller
func calculate_velocity(delta):
	var current_pos = global_position
	last_velocity = (current_pos - last_pos) / delta
	last_pos = current_pos
 
func _on_button_pressed(name: String) -> void:
	if name == "trigger_click":
		if active_collider != null:
			grabbed_object = active_collider
			#print("grabbed_object: ", grabbed_object)
			grabbed_distance = global_position.distance_to($MeshInstance3D.points[1])
			#print("grabbed_distance: ", grabbed_distance)
			
	#if name == "ax_button":
		#$"../../RigidBodySphere1".linear_velocity = Vector3.ZERO
		#$"../../RigidBodySphere1".angular_velocity = Vector3.ZERO
		#$"../../RigidBodySphere1".position = Vector3(0.499,0,3.208)
		#$"../../RigidBodySphere1".global_transform.origin = Vector3(0.499,0,3.208)
 
func _on_button_released(name: String) -> void:
	if name == "trigger_click":
		if grabbed_object != null:
			# Apply the velocity calculated from the controller to the grabbed object
			if grabbed_object is RigidBody3D:
				grabbed_object.linear_velocity = last_velocity
				#print("Throwing object with velocity: ", last_velocity)
		grabbed_object = null
		
	if name == "by_button":
		XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
