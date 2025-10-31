extends VBoxContainer

@export var weapons : HBoxContainer
var OptionSlot = preload("res://UI/Options/option_slot.tscn")

@export var particles: GPUParticles2D

func _ready():
	hide()
	particles.hide()
	
func close_option():
	hide()
	particles.hide()
	get_tree().paused = false
	
func get_available_weapons():
	var weapons_resource = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapons_resource.append(weapon.weapon)
	return weapons_resource
	
func show_options():
	var weapons_available = get_available_weapons()
	if weapons_available.size() == 0:
		return
		
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgradable():
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
	
	if option_size == 0:
		return
		
	show()
	particles.show()
	get_tree().paused = true
