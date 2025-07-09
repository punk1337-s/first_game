extends Node

enum LOCATIONS {START, GAME, SHOP}

signal location_changed(location: LOCATIONS)
signal game_over
signal points_changed(points: int)
signal knives_changed(knives: int)
signal apples_changed(apples: int)
signal stage_changed(stage: Stage)
