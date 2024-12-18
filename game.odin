package game

import rl "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

GRAVITY :: 400

PLAYER_JUMP_SPD :: 350.0
PLAYER_HOR_SPD :: 200.0

Player :: struct {
	position: rl.Vector2,
	speed: f32,
	canJump: bool
}

EnvItem :: struct {
	rect: rl.Rectangle,
	blocking: int,
	color: rl.Color
}

main :: proc() {
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "MyGame")
	defer rl.CloseWindow()

	player := Player{
		position = {400, 200},
		speed = 0,
		canJump = false
	}
	env_items := []EnvItem{
	    {rect = {0, 0, 1000, 400}, blocking = 1, color = rl.LIGHTGRAY},
	    {rect = {0, 400, 1000, 200}, blocking = 1, color = rl.GRAY},
	    {rect = {300, 200, 400, 10}, blocking = 1, color = rl.GRAY},
	    {rect = {250, 300, 100, 10}, blocking = 1, color = rl.GRAY},
	    {rect = {650, 300, 100, 10}, blocking = 1, color = rl.GRAY},
	}

	camera := rl.Camera2D { 
		target = 0,
		offset = {SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0},
		rotation = 0.0,
		zoom = 1.0 
	}

	rl.SetTargetFPS(60)
	for !rl.WindowShouldClose() {
		// Do nothing for now
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.RAYWHITE)
			for item, i in env_items {
				rl.DrawRectangleRec(env_items[i].rect, env_items[i].color)
			}
			player_rect := rl.Rectangle {
				x = player.position.x - 20,
				y = player.position.y -40,
				w = 40.0,
				h = 40.0
			}

			rl.DrawRectangleRec(player_rect, rl.RED)
			rl.DrawCircleV(player.position, 5.0, rl.GOLD)

		rl.BeginMode2D(camera)

		rl.EndMode2D()

        rl.DrawText("Controls:", 20, 20, 10, rl.BLACK);
        rl.DrawText("- Right/Left to move", 40, 40, 10, rl.DARKGRAY);
        rl.DrawText("- Space to jump", 40, 60, 10, rl.DARKGRAY);
	}
} 