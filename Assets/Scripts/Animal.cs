using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Animal : MonoBehaviour {
    private NavMeshAgent navMeshAgent;

    void Start()
    {
        navMeshAgent = GetComponent<NavMeshAgent>();
    }

    public void SetDestination(Vector3 Destination)
    {
        navMeshAgent.SetDestination(Destination);
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            navMeshAgent.SetDestination(Player.Instance.GetPosition());
        }
    }
}
