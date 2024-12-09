using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuManager : MonoBehaviour
{
    public LevelLoader levelLoader;

    [SerializeField] private GameObject principal;
    [SerializeField] private GameObject level;

	public void Start()
	{
		principal.SetActive(true);
		level.SetActive(false);
	}

	public void Jogar(){
        principal.SetActive(false);
        level.SetActive(true);
    }

	public void Sair(){
        Application.Quit();
    }

    public void Voltar(){
        principal.SetActive(true);
        level.SetActive(false);
    }

    public void Level(int level){
        levelLoader.LoadNextLevel(level);
    }
}
