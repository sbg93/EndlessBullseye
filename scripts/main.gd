extends Node2D

const TARGET_SCORE := 10

var current_score := 0

func _ready() -> void:
	print("Endless Bullseye ready. Target score: %d" % TARGET_SCORE)
	_connect_ui()
	_update_title()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		add_point()

func add_point() -> void:
	current_score = clampi(current_score + 1, 0, TARGET_SCORE)
	_update_title()

func _update_title() -> void:
	var label := $WelcomeLabel
	if label is Label:
		label.text = "Endless Bullseye\nPuntos: %d / %d" % [current_score, TARGET_SCORE]

func _connect_ui() -> void:
	var upgrades_button := $UI/TopBar/TopBarMargin/TopBarContent/UpgradesMenuButton
	if upgrades_button is Button:
		upgrades_button.pressed.connect(_on_upgrades_button_pressed)

	var close_button := $UI/UpgradesMenu/UpgradesMenuMargin/UpgradesMenuVBox/UpgradesMenuHeader/UpgradesCloseButton
	if close_button is Button:
		close_button.pressed.connect(_on_upgrades_close_button_pressed)

func _on_upgrades_button_pressed() -> void:
	var menu := $UI/UpgradesMenu
	if menu is Control:
		menu.visible = true

func _on_upgrades_close_button_pressed() -> void:
	var menu := $UI/UpgradesMenu
	if menu is Control:
		menu.visible = false
