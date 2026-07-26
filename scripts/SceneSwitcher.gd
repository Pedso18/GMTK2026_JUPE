extends Node

var target_scene_path: String = ""

func switch_to_scene(path: String) -> void:
	target_scene_path = path
	# Request the load in the background
	ResourceLoader.load_threaded_request(target_scene_path)
	# Turn on processing to monitor the load progress
	set_process(true)

func _ready() -> void:
	# Keep process disabled until a scene switch is requested
	set_process(false)

func _process(_delta: float) -> void:
	if target_scene_path.is_empty():
		return
		
	var progress = []
	# Poll the load status frame-by-frame
	var status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		# 1. Fetch the loaded PackedScene resource from memory
		var packed_scene: PackedScene = ResourceLoader.load_threaded_get(target_scene_path)
		
		# 2. Free current scene and swap to the new one
		get_tree().change_scene_to_packed(packed_scene)
		
		# Reset and turn off process loop
		target_scene_path = ""
		set_process(false)
		
	elif status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		push_error("Failed to load scene: " + target_scene_path)
		target_scene_path = ""
		set_process(false)
