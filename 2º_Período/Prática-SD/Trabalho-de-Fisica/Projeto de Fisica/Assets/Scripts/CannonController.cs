using TMPro;
using UnityEngine;

public class CannonController : MonoBehaviour
{
    [Header("Rotation Settings")]
    [SerializeField] private float minAngle = 0f;  // �ngulo m�nimo permitido
    [SerializeField] private float maxAngle = 90f; // �ngulo m�ximo permitido
    public TMP_Text textoAngulo;

    void Update()
    {
        if (Input.GetMouseButton(0)) // 0 � o clique esquerdo do mouse
        {
            // Verifica se o mouse est� sobre o canh�o
            RaycastHit2D hit = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);

            if (hit.collider != null && hit.collider.gameObject == gameObject)
            {
                // Se o canh�o for clicado, rotaciona ele para a posi��o do mouse
                RotateCannonTowardsMouse();
                textoAngulo.text = "�ngulo: " + GetCannonAngle() + "�";
            }
        }

    }

    void RotateCannonTowardsMouse()
    {
        // Obt�m a posi��o do mouse na cena
        Vector3 mousePosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        mousePosition.z = 0; // Garante que o mouse esteja no plano 2D

        // Calcula o vetor dire��o para o mouse
        Vector3 direction = mousePosition - transform.position;

        // Calcula o �ngulo em graus
        float angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg;

        // Restringe o �ngulo ao intervalo permitido
        angle = Mathf.Clamp(angle, minAngle, maxAngle);

        // Define a rota��o do canh�o
        transform.rotation = Quaternion.Euler(0, 0, angle);
    }

    public float GetCannonAngle()
    {
        // Retorna o �ngulo atual do canh�o (em graus)
        float angle = transform.eulerAngles.z;
        if (angle > 180) angle -= 360; // Converte para intervalo [-180, 180]
        return Mathf.Clamp(angle, minAngle, maxAngle);
    }
}
