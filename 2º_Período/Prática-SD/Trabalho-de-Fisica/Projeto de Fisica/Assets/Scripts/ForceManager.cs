using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// essa classe é responsável por administrar ar forças atuantes em um objeto,
// e calcular sua resultante
public class ForceManager
{
   
    private List<Force> forces = new List<Force>();

    public void AddForce(Force force)
    {
        forces.Add(force);
    }

    public void ClearForces()
    {
        forces.Clear();
    }

    public Vector2 GetResultantForce()
    {
        Vector2 resultant = Vector2.zero;
        foreach (var force in forces)
        {
            resultant += force.GetForceVector();
        }
        return resultant;
    }

}
