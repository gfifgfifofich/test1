using Godot;
using System;

public class KinematicBody2D : Godot.KinematicBody2D
{
	public int currentHealth, maxHealth;
	
	private float playerSpeed = 3.5f;
	private Vector2 playerVelocity = new Vector2();
	
	public override void _Ready()
	{
		maxHealth = 100; currentHealth = maxHealth;
	}
	public override void _Process(float delta)
	{
		playerVelocity = new Vector2();

		if (Input.IsActionPressed("ui_right")) playerVelocity.x += 1;
		if (Input.IsActionPressed("ui_left")) playerVelocity.x -= 1;
		if (Input.IsActionPressed("ui_down")) playerVelocity.y += 1;
		if (Input.IsActionPressed("ui_up")) playerVelocity.y -= 1;

		playerVelocity = playerVelocity.Normalized() * playerSpeed / delta;
		playerVelocity = MoveAndSlide(playerVelocity);

		if(currentHealth > maxHealth) currentHealth = maxHealth;
	
	}  
}
