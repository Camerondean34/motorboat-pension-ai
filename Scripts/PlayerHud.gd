extends Control

func _ready():
	update_ui();
	
func update_ui():
	
	var account_balance_label = $VBoxContainer/AccountBalanceLabel
	account_balance_label.text = "Balance: $" + str(int(100 * round(PlayerVariables.accountBalance))/100)
	
	var charge_remaining_label = $"VBoxContainer/EnergyChargeLabel"
	charge_remaining_label.text = "Charge: " + str(int(100 * PlayerVariables.playerCharge)/100) + "%"
	
	var boat_health_label = $VBoxContainer/BoatHealthLabel
	boat_health_label.text = "Boat HP: " + str(int(round(PlayerVariables.boatHealth))) + "%"
	
func _on_pension_payout_timer_timeout() -> void:
	
	PlayerVariables.accountBalance += calculate_pension_payout();
	update_ui()
	

func _on_charge_depletion_timer_timeout() -> void:
	
	PlayerVariables.playerCharge *= 0.99
	if PlayerVariables.playerCharge < 0:
		PlayerVariables.playerCharge = 0
	
	update_ui()

func calculate_pension_payout() -> int:
	
	return 1000;

func _on_interest_payment_timer_timeout() -> void:
	
	PlayerVariables.accountBalance = int(10 * 1.05 * PlayerVariables.accountBalance) / 10;
	update_ui()
