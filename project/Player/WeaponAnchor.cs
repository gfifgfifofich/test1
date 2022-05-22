using Godot;
using System;

public class WeaponAnchor : Sprite
{
    
    
    protected Vector2 mousePosition;
    public override void _Process(float delta)
    {
    
       mousePosition = GetLocalMousePosition();
       Rotation += mousePosition.Angle();
    }
}
