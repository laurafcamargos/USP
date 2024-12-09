using UnityEngine;

//Estamos considerando que 1 unidade de distância no Unity é equivalente a 1 metro
//Então, ao utilizar medidas do SI, consideraremos esse detalhe para obter resultados realistas

public class PhysicsObject : MonoBehaviour
{
    public Vector2 initialVelocity { get; set; }
    public float mass { get; set; }
    public float gravidade {  get; set; }
    public float dragCoefficient { get; set; } // Coeficiente de arrasto (k), utilizado para calcular a força viscosa
    public Vector2 velocity;       // Velocidade atual do objeto
    private ForceManager forceManager; 

    void Start()
    {
        forceManager = new ForceManager();
        velocity = initialVelocity;
    }

    void Update()
    {
        // Força gravitacional constante
        forceManager.AddForce(new Force(Vector2.down, gravidade * mass)); // Peso: F = m * g
        
        // Cálculo da força viscosa, proporcional à velocidade
        Vector2 viscousForce = -dragCoefficient * velocity; // F = -k * v
        forceManager.AddForce(new Force(viscousForce.normalized, viscousForce.magnitude));

        Vector2 resultantForce = forceManager.GetResultantForce();

        // Para massas constantes: F = m * a -> a = F / m
        Vector2 acceleration = resultantForce / mass;
        velocity += acceleration * Time.deltaTime;

        // Conversão para Vector3 é necessária por conta do jeito que o unity lida com posição de objetos
        transform.position += (Vector3)(velocity * Time.deltaTime); 
        

        // Limpa as forças para o próximo frame
        forceManager.ClearForces();
    }
}
