extends Node3D
var is_knocked_down = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("global_transform.basis.z.y:  ",global_transform.basis.z.y)
	if not is_knocked_down and $RigidBodyCylinder.global_transform.basis.z.y > 0.5:
		is_knocked_down = true
