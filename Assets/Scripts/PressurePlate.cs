using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PressurePlate : MonoBehaviour {
    public Door[] LinkedDoor;
    public bool CanBeTriggeredByAnimals;

    public bool IsTriggered {
        get
        {
            return triggered;
        }
    }

    private bool triggered;

	void Start () {
        foreach (var d in LinkedDoor)
        {
            d.Register(this);
        }

        triggered = false;
	}

    private void Trigger()
    {
        foreach (var d in LinkedDoor)
        {
            if (d != null)
            {
                triggered = true;
                d.CheckOpenable();
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            Trigger();
        } else if(CanBeTriggeredByAnimals && other.CompareTag("Animal"))
        {
            Trigger();
        }
    }
}
