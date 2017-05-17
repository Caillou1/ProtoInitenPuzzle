using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Animal : MonoBehaviour {
    public bool ChasePlayer;

    private Transform tf;
    private NavMeshAgent navMeshAgent;

    void Start()
    {
        navMeshAgent = GetComponent<NavMeshAgent>();
        tf = transform;
    }

    public void SetDestination(Vector3 Destination)
    {
        navMeshAgent.SetDestination(Destination);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (ChasePlayer && other.CompareTag("Player"))
        {
            float distance = Vector3.Distance(tf.position, Player.Instance.GetPosition());
            var hits = Physics.RaycastAll(tf.position, (Player.Instance.GetPosition() - tf.position).normalized, distance);
            bool canAttack = true;

            foreach (var hit in hits)
            {
                if (hit.collider.CompareTag("Wall"))
                {
                    canAttack = false;
                    break;
                }
            }

            if (canAttack)
            {
                navMeshAgent.SetDestination(Player.Instance.GetPosition());
            }
        }
    }
}
