extends Node3D

var xr_interface: XRInterface

var pins = []
var knocked_down_count = 0

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
		
	
	# Get all pins in the "pins" group
	pins = get_tree().get_nodes_in_group("pins")
	#print("pins:  ",pins.size())

func count_knocked_pins():
	knocked_down_count = 0
	#print("pins:  ",pins.size())
	for pin in pins:
		if pin.is_knocked_down:
			knocked_down_count += 1
	return knocked_down_count

func _process(delta):
	var knocked_pins = count_knocked_pins()
	if knocked_pins > 0:
		print("Pins knocked down: ", knocked_pins)
	# Reset for next round or display score
		
func ball_has_stopped() -> bool:
	#print("$Ball.get_child(0).linear_velocity.length():  ",$Ball.get_child(0).linear_velocity.length())
	return $Ball.get_child(0).linear_velocity.length() < 0.5  # Adjust threshold
	
