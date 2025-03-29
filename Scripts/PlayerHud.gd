extends Control

func _ready():
	update_ui();
	
func update_ui():
	
	var account_balance_label = $VBoxContainer/AccountBalanceLabel
	account_balance_label.text = "Balance: $" + str(int(round(PlayerVariables.accountBalance)))
	
	var charge_remaining_label = $"VBoxContainer/EnergyChargeLabel"
	charge_remaining_label.text = "Charge: " + str(int(PlayerVariables.playerCharge)) + "%"
	
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
	
	return 1000 * PlayerVariables.numberOfCapturedPensioners;

func _on_interest_payment_timer_timeout() -> void:
	
	PlayerVariables.accountBalance = int(1.05 * PlayerVariables.accountBalance);
	update_ui()

func _on_capture_pensioner_timer_timeout() -> void:
	
	PlayerVariables.numberOfCapturedPensioners += 1
	if PlayerVariables.numberOfCapturedPensioners > PlayerVariables.pensionerCapacity:
		PlayerVariables.numberOfCapturedPensioners = PlayerVariables.pensionerCapacity;
	
	update_ui();
