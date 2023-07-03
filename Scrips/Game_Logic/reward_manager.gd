extends Node

class_name REWARD_MANAGER

static func set_reward(_enemy: PhysicsBody2D, _reward: int): #Now this is just set_reward
	if _enemy.has_method("set_reward"):
		_enemy.set_reward(_reward)                         #But in the future reward will be random
