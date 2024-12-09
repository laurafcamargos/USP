using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VoltarMenu : MonoBehaviour
{
	public LevelLoader levelLoader;

	public void Level(int level)
	{
		levelLoader.LoadNextLevel(level);
	}
}
