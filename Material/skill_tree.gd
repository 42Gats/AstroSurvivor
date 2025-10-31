extends Panel
 
var skill_tree
var total_stat : Stats
 
func _ready():
	load_skill_tree()
 
func load_skill_tree():
	if SaveData.skill_tree == []:
		set_skill_tree()
 
	skill_tree = SaveData.skill_tree
	for branch in get_children():
		for upgrade in branch.get_children():
			upgrade.enabled = skill_tree[branch.get_index()][upgrade.get_index()]
	get_total_stats()
 
func set_skill_tree():
	skill_tree = []
	for each_branch in get_children():
		var branch = []
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
		skill_tree.append(branch)
 
	SaveData.skill_tree = skill_tree
	SaveData.set_and_save()

func add_stats(stat):
	total_stat.Max_Health += stat.Max_Health
	total_stat.Shield += stat.Shield
	total_stat.Damage += stat.Damage
	total_stat.Projectile_Range += stat.Projectile_Range
	total_stat.Projectile_count += stat.Projectile_count
	total_stat.Critical_Chances += stat.Critical_Chances
	total_stat.Critical_Damage += stat.Critical_Damage
	total_stat.Attack_Speed += stat.Attack_Speed
	total_stat.Move_Speed += stat.Move_Speed
	total_stat.Pickup_Range += stat.Pickup_Range
 
func get_total_stats():
	total_stat = Stats.new()
	for branch in get_children():
		for upgrade in branch.get_children():
			if upgrade.enabled:
				add_stats(upgrade.skill.stats)
	Persistence.bonus_stats = total_stat
