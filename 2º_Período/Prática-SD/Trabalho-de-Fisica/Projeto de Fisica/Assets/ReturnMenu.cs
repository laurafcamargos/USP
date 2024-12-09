using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ReturnMenu : MonoBehaviour
{
    public LevelLoader levelLoader;

    void Update()
    {
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			levelLoader.LoadNextLevel(0);
		}
	}
}
