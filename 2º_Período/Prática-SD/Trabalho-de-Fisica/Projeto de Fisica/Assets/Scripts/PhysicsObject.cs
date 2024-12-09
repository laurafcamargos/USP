using UnityEngine;

//Estamos considerando que 1 unidade de dist�ncia no Unity � equivalente a 1 metro
//Ent�o, ao utilizar medidas do SI, consideraremos esse detalhe para obter resultados realistas

public class PhysicsObject : MonoBehaviour
{
    public Vector2 initialVelocity { get; set; }
    public float mass { get; set; }
    public float gravidade {  get; set; }
    public float dragCoefficient { get; set; } // Coeficiente de arrasto (k), utilizado para calcular a for�a viscosa
    public Vector2 velocity;       // Velocidade atual do objeto
    private ForceManager forceManager; 

    void Start()
    {
        forceManager = new ForceManager();
        velocity = initialVelocity;
    }

    void Update()
    {
        // For�a gravitacional constante
        forceManager.AddForce(new Force(Vector2.down, gravidade * mass)); // Peso: F = m * g
        
        // C�lculo da for�a viscosa, proporcional � velocidade
        Vector2 viscousForce = -dragCoefficient * velocity; // F = -k * v
        forceManager.AddForce(new Force(viscousForce.normalized, viscousForce.magnitude));

        Vector2 resultantForce = forceManager.GetResultantForce();

        // Para massas constantes: F = m * a -> a = F / m
        Vector2 acceleration = resultantForce / mass;
        velocity += acceleration * Time.deltaTime;

        // Convers�o para Vector3 � necess�ria por conta do jeito que o unity lida com posi��o de objetos
        transform.position += (Vector3)(velocity * Time.deltaTime); 
        

        // Limpa as for�as para o pr�ximo frame
        forceManager.ClearForces();
    }
}
