extends Node2D
var coins = 0
signal addcoin

func add_coin(amnt):
	coins += amnt
	addcoin.emit(coins)
