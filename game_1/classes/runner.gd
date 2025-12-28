@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var ghimli: Character = Character.new(98, "Ghimli", "Axe")
	var courage: Hero = Hero.new(38, "Courage", "None", "Stealth")
	
	print(ghimli)
	print(courage)

	ghimli.attack()
	courage.attack()
