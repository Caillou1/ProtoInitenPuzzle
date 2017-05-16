using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Door : MonoBehaviour {
    private List<PressurePlate> pressurePlates;

	void Start () {
        pressurePlates = new List<PressurePlate>();
	}

    public void Register(PressurePlate pp)
    {
        pressurePlates.Add(pp);
    }

    public void CheckOpenable()
    {
        bool canOpen = true;

        foreach(var p in pressurePlates)
        {
            if(!p.IsTriggered)
            {
                canOpen = false;
                break;
            }
        }

        if(canOpen)
        {
            Destroy(gameObject);
        }
    }
}
