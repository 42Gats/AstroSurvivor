extends CharacterBody2D
 
var Max_Health : float = 100.0 :
	set(value):
		Max_Health = value
		%"Max Health".text = "H : " + str(value)

var Damage : float = 1.0 :
	set(value):
		Damage = value
		%Damage.text = "D : " + str(value)

var Attack_Speed : float = 1.0 :
	set(value):
		Attack_Speed = value
		%"Attack Speed".text = "AS : " + str(value)
var Move_Speed : float = 150
var Shield : float = 50
var gold : float = 0
var Critical_Chances : float = 0
var Critical_Damage : float = 150
var Pickup_Range : float = 50
var Projectile_Range : float = 500
var Projectile_count : float = 1
var health : float = 100.0 :
	set(value):
		health = value
		%Health.value = value
		if health <= 0:
			get_tree().paused = true
 
var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = INF

var level : int = 1:
	set(value):
		level = value
		%Level.text = str(value)
		%Options.show_options()
		if level >= 2:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40
var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0

func add_gold(earned_gold):
	gold += earned_gold

func _ready():
	Persistence.gain_bonus_stats(self) 

func _physics_process(delta):
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else:
		nearest_enemy_distance = INF
	velocity = Input.get_vector("left","right","up","down") * Move_Speed
	move_and_collide(velocity * delta)
 
	check_XP()
 
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
 
func take_damage(amount):
	health -= amount
	#print(amount)
 
func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1
 
func _on_self_damage_body_entered(body):
	take_damage(body.damage)
 
func gain_XP(amount):
	print("amoun:", amount)
	XP += amount
	total_XP += amount
 


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
