using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InitenClick : MonoBehaviour {

    public AssociationManager associator;
    public int pos;

	public void OnClick () {
        associator.Associate(GetComponent<MeshRenderer>().sharedMaterial, pos);
        Destroy(gameObject);
	}
}
