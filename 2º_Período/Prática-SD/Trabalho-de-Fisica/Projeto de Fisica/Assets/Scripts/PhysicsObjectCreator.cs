using UnityEngine;
using TMPro;

public class PhysicsObjectManager : MonoBehaviour
{
    [Header("UI Elements (TMP)")]
    public TMP_InputField initialSpeedInput;     // Velocidade inicial (m/s)
    public TMP_InputField massInput;             // Massa (kg)
    public TMP_InputField dragCoefficientInput;  // Coeficiente de arrasto
    public UnityEngine.UI.Button createButton;   // Botão para criar o objeto

    [Header("Default Values")]
    [SerializeField] private float defaultSpeed = 10f;              // Velocidade inicial padrão
    [SerializeField] private float defaultMass = 1f;                // Massa padrão
    [SerializeField] private float defaultDragCoefficient = 0.1f;  // Coeficiente de arrasto padrão
    [SerializeField] private float gravidade = 9.81f;

    [Header("Object Settings")]
    [SerializeField] private GameObject physicsObjectPrefab; // Prefab do PhysicsObject
    [SerializeField] private Transform cannonTransform;             // Referência ao canhão
    [SerializeField] private CannonController cannonController;     // Referência ao script do canhão

    [Header("Spawn Settings")]
    [SerializeField] private Transform spawnPoint; // Ponto inicial de spawn

    [SerializeField] public TrajectoryLine trajectoryLine;


    private void Start()
    {
        // Inicializa os campos com valores padrão
        InitializeFields();

        // Adiciona validações aos campos
        initialSpeedInput.onEndEdit.AddListener((input) => ValidateAndSetDefault(input, initialSpeedInput, defaultSpeed, 0));
        massInput.onEndEdit.AddListener((input) => ValidateAndSetDefault(input, massInput, defaultMass, 0.01f));
        dragCoefficientInput.onEndEdit.AddListener((input) => ValidateAndSetDefault(input, dragCoefficientInput, defaultDragCoefficient, 0));

        // Adiciona funcionalidade ao botão
        createButton.onClick.AddListener(CreatePhysicsObject);
    }

    private void Update()
    {
        if (trajectoryLine != null && spawnPoint != null)
        {
            // Obtém os valores atuais da UI
            float initialSpeed = float.Parse(initialSpeedInput.text);
            float mass = float.Parse(massInput.text);
            float dragCoefficient = float.Parse(dragCoefficientInput.text);
            float gravity = gravidade;

            // Calcula o ângulo do canhão em radianos
            float angleDegrees = cannonController.GetCannonAngle();
            float angleRadians = Mathf.Deg2Rad * angleDegrees;

            // Calcula a velocidade inicial em componentes X e Y
            Vector2 initialVelocity = new Vector2(
                initialSpeed * Mathf.Cos(angleRadians),
                initialSpeed * Mathf.Sin(angleRadians)
            );

            // Atualiza a linha da trajetória
            trajectoryLine.UpdateTrajectory(spawnPoint.position, initialVelocity, dragCoefficient, mass, gravity);
        }
    }


    private void InitializeFields()
    {
        initialSpeedInput.text = defaultSpeed.ToString("F2");
        massInput.text = defaultMass.ToString("F2");
        dragCoefficientInput.text = defaultDragCoefficient.ToString("F2");
    }

    private void ValidateAndSetDefault(string input, TMP_InputField field, float defaultValue, float minValue, float maxValue = float.MaxValue)
    {
        if (!float.TryParse(input, out float value) || value < minValue || value > maxValue)
        {
            field.text = defaultValue.ToString("F2");
        }
    }

    private void CreatePhysicsObject()
    {
        // Recupera e valida os valores da UI
        float initialSpeed = float.Parse(initialSpeedInput.text);
        float mass = float.Parse(massInput.text);
        float dragCoefficient = float.Parse(dragCoefficientInput.text);

        // Obtém o ângulo do canhão
        float angleDegrees = cannonController.GetCannonAngle();
        float angleRadians = Mathf.Deg2Rad * angleDegrees;

        // Calcula as componentes da velocidade
        float velocityX = initialSpeed * Mathf.Cos(angleRadians);
        float velocityY = initialSpeed * Mathf.Sin(angleRadians);

        // Instancia o prefab
        GameObject newObject = Instantiate(physicsObjectPrefab, spawnPoint.position, Quaternion.identity);

        // Configura os parâmetros no PhysicsObject
        PhysicsObject physicsObject = newObject.GetComponent<PhysicsObject>();
        if (physicsObject != null)
        {
            physicsObject.initialVelocity = new Vector2(velocityX, velocityY);
            physicsObject.mass = mass;
            physicsObject.dragCoefficient = dragCoefficient;
            physicsObject.gravidade = gravidade;
        }
    }
}
