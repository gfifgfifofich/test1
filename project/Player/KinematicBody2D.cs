using Godot;
using System;

public class KinematicBody2D : Godot.KinematicBody2D
{
	public int playerSpeed = 100;
	public Vector2 playerVelocity = new Vector2;
	
	public override void _Process(float delta)
	}
		playerVelocity = new Vector2();

		if (Input.IsActionPressed("right")) playerVelocity.x += 1;
		if (Input.IsActionPressed("left")) playerVelocity.x -= 1;
		if (Input.IsActionPressed("down")) playerVelocity.y += 1;
		if (Input.IsActionPressed("up")) playerVelocity.y -= 1;

		playerVelocity = velocity.Normalized() * playerSpeed;
		playerVelocity = MoveAndSlide(playerVelocity);
	
	{    
}
