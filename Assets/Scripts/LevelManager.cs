using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour {
    public int Coup1Star;
    public int Coup2Stars;
    public int Coup3Stars;

    private int coups;

    public static LevelManager Instance;

	void Start () {
        Instance = this;
        coups = 0;
	}

    public void Win()
    {
        int nbStars = 0;

        if(coups <= Coup3Stars)
        {
            nbStars = 3;
        } else if(coups <= Coup2Stars)
        {
            nbStars = 2;
        } else if(coups <= Coup1Star)
        {
            nbStars = 1;
        }

        Debug.Log("WIN " + nbStars + " STARS");
    }

    public void AddHit()
    {
        coups++;
    }

    public void Lose()
    {
        Debug.Log("LOST");
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }
}
