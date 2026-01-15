extends Node2D

const TARGET_SCORE := 10

var current_score := 0

@onready var ui: Control = $UI
@onready var hand: TextureRect = $UI/Hand

func _ready() -> void:
	print("Endless Bullseye ready. Target score: %d" % TARGET_SCORE)
	_connect_ui()
	_update_title()
	_setup_hand()

func _process(_delta: float) -> void:
	_update_hand_position()

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

func _setup_hand() -> void:
	if hand == null:
		return
	if hand.texture != null:
		hand.size = hand.texture.get_size()
	_update_hand_position()

func _update_hand_position() -> void:
	if hand == null or ui == null:
		return
	if hand.texture == null:
		return
	var local_mouse := ui.to_local(get_viewport().get_mouse_position())
	var clamped_y := clamp(local_mouse.y - (hand.size.y * 0.5), 0.0, ui.size.y - hand.size.y)
	hand.position = Vector2(ui.size.x - hand.size.x, clamped_y)
