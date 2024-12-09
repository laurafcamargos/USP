using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class colisao : MonoBehaviour
{
    SpawnerManager spawner;
    GameManager gameManager;
    private void Start()
    {
        spawner = FindObjectOfType<SpawnerManager>();
        gameManager = FindObjectOfType<GameManager>();
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.layer == 6)
        {
            Debug.Log("Colis�o com ch�o");
            Destroy(gameObject);
        }

        if (collision.gameObject.layer == 7)
        {
            Debug.Log("Colis�o com alvo");
            Destroy(gameObject);
            Destroy(collision.gameObject);
            gameManager.aumentarAlvos();
            spawner.spawnarObjeto();
        }
    }
}
