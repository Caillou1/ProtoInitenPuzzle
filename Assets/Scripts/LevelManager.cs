using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour {
    public float Time1Star;
    public float Time2Stars;
    public float Time3Stars;

    private float startTime;

    public static LevelManager Instance;

	void Start () {
        Instance = this;
	}

    public void StartChrono()
    {
        startTime = Time.time;
    }

    public void Win()
    {
        int nbStars = 0;
        float time = Time.time - startTime;

        if(time <= Time3Stars)
        {
            nbStars = 3;
        } else if(time <= Time2Stars)
        {
            nbStars = 2;
        } else if(time <= Time1Star)
        {
            nbStars = 1;
        }

        Debug.Log("WIN " + nbStars + " STARS IN " + time + " SECONDS");
    }

    public void Lose()
    {
        Debug.Log("LOST");
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }
}
