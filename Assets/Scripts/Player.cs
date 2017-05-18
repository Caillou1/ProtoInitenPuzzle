using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Player : MonoBehaviour {
    private GameObject CanHear;
    private GameObject CantHear;

    private NavMeshAgent navMeshAgent;
    private Transform tf;

    public static Player Instance;

	void Start () {
        Instance = this;

        tf = transform;

        CanHear = tf.FindChild("Canvas").FindChild("CanHear").gameObject;
        CantHear = tf.FindChild("Canvas").FindChild("CantHear").gameObject;
        CanHear.SetActive(false);
        CantHear.SetActive(false);

        navMeshAgent = GetComponent<NavMeshAgent>();
	}

    public void SetDestination(Vector3 Destination)
    {
        navMeshAgent.SetDestination(Destination);
    }

    public Vector3 GetPosition()
    {
        return tf.position;
    }

    public void Kill()
    {
        StartCoroutine(DelayedReset());
    }

    private IEnumerator DelayedReset()
    {
        yield return new WaitForSeconds(5);
        LevelManager.Instance.Lose();
    }

    public void CanHearSound(bool b)
    {
        if(b)
        {
            CanHear.SetActive(true);
            StartCoroutine(DelayedDesactivate(CanHear));
        } else
        {
            CantHear.SetActive(true);
            StartCoroutine(DelayedDesactivate(CantHear));
        }
    }

    IEnumerator DelayedDesactivate(GameObject obj)
    {
        yield return new WaitForSeconds(1);
        obj.SetActive(false);
    }
}
