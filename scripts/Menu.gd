extends CanvasLayer

export var bgm_bus_name := "BGM"
export var sfx_bus_name := "SFX"

onready var bgm_bus := AudioServer.get_bus_index(bgm_bus_name)
onready var sfx_bus := AudioServer.get_bus_index(sfx_bus_name)

enum {MAIN_MENU, PAUSED, OPTIONS, GAME}
var state = MAIN_MENU
var last_state = -1

func _ready():
	$Options/Column/BGM/BGMVolumeSlider.value = db2linear(AudioServer.get_bus_volume_db(bgm_bus))
	$Options/Column/SFX/SFXVolumeSlider.value = db2linear(AudioServer.get_bus_volume_db(sfx_bus))

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE and state == GAME:
		pause_game()
	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var start = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Start.get_global_rect()
		var options = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Options.get_global_rect()
		var exit = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Exit.get_global_rect()
		var credits = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Credits.get_global_rect()
		var paused_continue = $PauseMenu/MarginContainer/HBoxContainer/Continue.get_global_rect()
		var paused_options = $PauseMenu/MarginContainer/HBoxContainer/Options.get_global_rect()
		var main_menu = $PauseMenu/MarginContainer/HBoxContainer/MainMenu.get_global_rect()
		var back = $Options/Column/Back.get_global_rect()
		
		if start.has_point(event.position):
			start_game()
		elif options.has_point(event.position):
			$MainMenu.hide()
			$Options.show()
			change_state(OPTIONS)
		elif exit.has_point(event.position):
			get_tree().quit()
		elif credits.has_point(event.position):
			# TODO
			pass
		elif state == PAUSED:
			if paused_continue.has_point(event.position):
				$PauseMenu.hide()
				get_parent().resume_game()
				change_state(GAME)
			elif paused_options.has_point(event.position):
				$PauseMenu.hide()
				$Options.show()
				change_state(OPTIONS)
			elif main_menu.has_point(event.position):
				# TODO: confirm popup
				$PauseMenu.hide()
				$MainMenu.show()
				$BG.show()
				change_state(MAIN_MENU)
		elif state == OPTIONS:
			if back.has_point(event.position):
				$Options.hide()
				if last_state == MAIN_MENU:
					$MainMenu.show()
					change_state(MAIN_MENU)
				elif last_state == PAUSED:
					change_state(GAME)


func start_game():
	change_state(GAME)
	get_parent().start_game()
	$MainMenu.hide()
	$BG.hide()


func pause_game():
	change_state(PAUSED)
	get_parent().pause_game()
	$PauseMenu.show()


func change_state(new_state):
	last_state = state
	state = new_state

func undo_state():
	state = last_state


func _on_BGMVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(bgm_bus, linear2db($Options/Column/BGM/BGMVolumeSlider.value))


func _on_SFXVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear2db($Options/Column/SFX/SFXVolumeSlider.value))


func _on_BGMVolumeSlider_mouse_exited():
	$Options/Column/BGM/BGMVolumeSlider.release_focus()


func _on_SFXVolumeSlider_mouse_exited():
	$Options/Column/SFX/SFXVolumeSlider.release_focus()
