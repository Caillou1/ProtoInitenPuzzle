using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PressurePlate : MonoBehaviour {
    public Door LinkedDoor;
    public bool CanBeTriggeredByAnimals;

    public bool IsTriggered {
        get
        {
            return triggered;
        }
    }

    private bool triggered;

	void Start () {
        LinkedDoor.Register(this);

        triggered = false;
	}

    private void Trigger()
    {
        triggered = true;
        if(LinkedDoor!=null)
            LinkedDoor.CheckOpenable();
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
