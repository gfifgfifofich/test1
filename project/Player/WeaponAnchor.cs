using Godot;
using System;

public class WeaponAnchor : KinematicBody2D
{
    public float rotationSpeed = 20;
    protected Vector2 mousePosition;
    public override void _Process(float delta)
    {
       mousePosition = GetLocalMousePosition();
       Rotation = mousePosition.Angle();
    }
}
