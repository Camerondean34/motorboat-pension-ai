extends Node

class_name Pensioner

var forename: String
var payout: int
var healthRemaining: int

func _init():
	forename = GeneratePensionerName()
	payout = GeneratePensionerPayoutSum()
	healthRemaining = GenerateRandomHealthRemaining()

func GeneratePensionerName() -> String:
	var names = ["Janet", "Margaret", "Dorothy", "Barbara", "Ethel", 
				 "Norman", "Albert", "Gerald", "Harold", "Edith"]
	return names[randi() % names.size()]

func GeneratePensionerPayoutSum() -> int:
	var random_number = randi_range(0, 80) + 20
	return random_number * 50

func GenerateRandomHealthRemaining() -> int:
	
	var random_number = randi_range(0, 60)
	random_number += 40
	
	return random_number
