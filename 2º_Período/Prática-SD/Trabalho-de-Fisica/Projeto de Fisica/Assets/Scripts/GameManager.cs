using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{

    public LevelLoader levelLoader;
	[SerializeField] public TMP_Text texto;
    public int alvos = 0;
    [SerializeField] public int alvosTotais;
    // Start is called before the first frame update
    void Start()
    {
        printarAlvos();
    }

    public int getAlvos()
    {
        return alvos;
    }

    public void aumentarAlvos()
    {
        alvos++;
        printarAlvos();
        if (alvos == alvosTotais && SceneManager.GetActiveScene().buildIndex != 3)
            levelLoader.LoadNextLevel(SceneManager.GetActiveScene().buildIndex + 1);
        if (SceneManager.GetActiveScene().buildIndex == 3 && alvos == alvosTotais)
        {
            Debug.Log("Voc� venceu!");
			levelLoader.LoadNextLevel(4);
        }
            
    }

    public void printarAlvos()
    {
        texto.text = "Alvos: " + alvos + "/" + alvosTotais;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

}
