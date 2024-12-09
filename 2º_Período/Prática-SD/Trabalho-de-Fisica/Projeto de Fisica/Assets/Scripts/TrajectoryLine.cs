using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(LineRenderer))]
public class TrajectoryLine : MonoBehaviour
{
    [SerializeField] private int _segmentCount = 10; // Quantidade de segmentos da linha
    private float _timeStep; // Intervalo de tempo entre os pontos
    private LineRenderer _lineRenderer;

    void Start()
    {
        _lineRenderer = GetComponent<LineRenderer>();
        _lineRenderer.positionCount = _segmentCount;
        _timeStep = Time.deltaTime;
    }

    public void UpdateTrajectory(Vector2 startPosition, Vector2 initialVelocity, float dragCoefficient, float mass, float gravity)
    {
        Vector2[] points = new Vector2[_segmentCount];
        Vector2 currentPosition = startPosition;
        Vector2 currentVelocity = initialVelocity;

        for (int i = 0; i < _segmentCount; i++)
        {
            // Armazena o ponto atual
            points[i] = currentPosition;

            // Calcula a força viscosa
            Vector2 viscousForce = -dragCoefficient * currentVelocity;

            // Calcula a força resultante (gravidade + arrasto)
            Vector2 resultantForce = new Vector2(0, -gravity * mass) + viscousForce;

            // Calcula a aceleração
            Vector2 acceleration = resultantForce / mass;

            // Atualiza a velocidade e posição
            currentVelocity += acceleration * _timeStep;
            currentPosition += currentVelocity * _timeStep;
        }

        // Converte os pontos para Vector3 (necessário pelo LineRenderer)
        Vector3[] positions = new Vector3[_segmentCount];
        for (int i = 0; i < _segmentCount; i++)
        {
            positions[i] = new Vector3(points[i].x, points[i].y, 0);
        }

        // Atualiza o LineRenderer com os pontos
        _lineRenderer.SetPositions(positions);
    }
}
