using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulleBehaviour : MonoBehaviour {
    private RectTransform tf;

	void Start () {
        tf = GetComponent<RectTransform>();
    }
	
	void Update ()
    {
        var direction = (Camera.main.transform.position - tf.position).normalized;
        var lookRotation = Quaternion.LookRotation(direction);
        lookRotation = Quaternion.Euler(lookRotation.eulerAngles.x, lookRotation.eulerAngles.y, tf.rotation.eulerAngles.z);
        //tf.rotation = lookRotation;
    }
}
