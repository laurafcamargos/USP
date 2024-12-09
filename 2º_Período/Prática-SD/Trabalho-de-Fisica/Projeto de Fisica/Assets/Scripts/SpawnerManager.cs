using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnerManager : MonoBehaviour
{
    [SerializeField] public GameObject alvo;
    [SerializeField] public Vector2 tamanhoRetangulo; // O tamanho do retângulo (largura e altura)

    // Start is called before the first frame update
    private void Start()
    {
        spawnarObjeto();
    }

    public void spawnarObjeto()
    {
        // Gera uma posição aleatória dentro do retângulo
        Vector3 randomPos = new Vector3(Random.Range(-tamanhoRetangulo.x / 2, tamanhoRetangulo.x / 2), Random.Range(-tamanhoRetangulo.y / 2, tamanhoRetangulo.y / 2), 0);

        // Adiciona a posição base do spawner
        randomPos += this.transform.position;

        Instantiate(alvo, randomPos, Quaternion.identity);
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;

        // Desenha o retângulo na cena
        Gizmos.DrawWireCube(this.transform.position, new Vector3(tamanhoRetangulo.x, tamanhoRetangulo.y, 0.1f));
    }
}
