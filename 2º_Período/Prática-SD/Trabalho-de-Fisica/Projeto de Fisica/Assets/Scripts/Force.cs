using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Force
{
    //definiremos a for�a como um conjunto entre dire�ao e magnitude
    //C�digos externos podem ler essas propriedas, mas apenas � poss�vel alter�-los dentro da classe
    public Vector2 Direction { get; private set; }
    public float Magnitude { get; private set; }

    public Force(Vector2 direction, float magnitude)
    {
        Direction = direction.normalized;
        Magnitude = magnitude;
    }

    public Vector2 GetForceVector()
    {
        return Direction * Magnitude;
    }
}
