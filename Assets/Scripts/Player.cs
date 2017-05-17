using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Player : MonoBehaviour {
    private NavMeshAgent navMeshAgent;
    private Transform tf;

    public static Player Instance;

	void Start () {
        Instance = this;

        tf = transform;

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
}
