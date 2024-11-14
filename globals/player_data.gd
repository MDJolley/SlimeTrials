extends Node

var gem_collection : Array

func collect_gem(gem : Gem) -> void:
	if !check_if_gem_collected(gem):
		gem_collection.append(gem.id)
		GameManager.collect_gem()
	#Add score if necessary?
	gem.queue_free()
	

func check_if_gem_collected(gem : Gem ) -> bool:
	return true if gem_collection.has(gem.id) else false
