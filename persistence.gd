extends Node2D

@onready var bonus_stats : Stats = Stats.new()

func gain_bonus_stats(player):
	player.Max_Health += bonus_stats.Max_Health
	player.Shield += bonus_stats.Shield
	player.Attack_Speed += bonus_stats.Attack_Speed
	player.Critical_Chances += bonus_stats.Critical_Chances
	player.Critical_Damage += bonus_stats.Critical_Damage
	player.Move_Speed += bonus_stats.Move_Speed
	player.Pickup_Range += bonus_stats.Pickup_Range
	player.Projectile_Range += bonus_stats.Projectile_Range
	player.Projectile_count += bonus_stats.Projectile_count
	player.Damage += bonus_stats.Damage
