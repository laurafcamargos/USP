using TMPro;
using UnityEngine;

public class CannonController : MonoBehaviour
{
    [Header("Rotation Settings")]
    [SerializeField] private float minAngle = 0f;  // Ângulo mínimo permitido
    [SerializeField] private float maxAngle = 90f; // Ângulo máximo permitido
    public TMP_Text textoAngulo;

    void Update()
    {
        if (Input.GetMouseButton(0)) // 0 é o clique esquerdo do mouse
        {
            // Verifica se o mouse está sobre o canhão
            RaycastHit2D hit = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);

            if (hit.collider != null && hit.collider.gameObject == gameObject)
            {
                // Se o canhão for clicado, rotaciona ele para a posição do mouse
                RotateCannonTowardsMouse();
                textoAngulo.text = "Ângulo: " + GetCannonAngle() + "º";
            }
        }

    }

    void RotateCannonTowardsMouse()
    {
        // Obtém a posição do mouse na cena
        Vector3 mousePosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        mousePosition.z = 0; // Garante que o mouse esteja no plano 2D

        // Calcula o vetor direção para o mouse
        Vector3 direction = mousePosition - transform.position;

        // Calcula o ângulo em graus
        float angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg;

        // Restringe o ângulo ao intervalo permitido
        angle = Mathf.Clamp(angle, minAngle, maxAngle);

        // Define a rotação do canhão
        transform.rotation = Quaternion.Euler(0, 0, angle);
    }

    public float GetCannonAngle()
    {
        // Retorna o ângulo atual do canhão (em graus)
        float angle = transform.eulerAngles.z;
        if (angle > 180) angle -= 360; // Converte para intervalo [-180, 180]
        return Mathf.Clamp(angle, minAngle, maxAngle);
    }
}
