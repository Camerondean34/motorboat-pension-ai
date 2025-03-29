extends Node

func GeneratePensionerPayoutSum() -> int:
	# Generate random number between 0 and 80
	var random_number = randi_range(0, 80)
	
	# Add 20
	random_number += 20
	
	# Multiply by 50
	var payout = random_number * 50
	
	return payout
