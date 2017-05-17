﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundEmitter : MonoBehaviour {
    public Material Mat;

    private AudioSource source;
    private Transform tf;
    private float portee;

    private void Start()
    {
        source = GetComponent<AudioSource>();
        tf = transform;
        portee = GetComponent<SphereCollider>().radius;
    }

    public void SetMaterial(Material m)
    {
        GetComponent<MeshRenderer>().material = m;
    }

    public void PlaySound(AudioClip Sound)
    {
        float distance = Vector3.Distance(tf.position, Player.Instance.GetPosition());

        if(distance <= portee)
        {
            var hits = Physics.RaycastAll(tf.position, (Player.Instance.GetPosition() - tf.position).normalized, distance);
            bool canPlaySound = true;

            foreach(var hit in hits)
            {
                if(hit.collider.CompareTag("Wall"))
                {
                    canPlaySound = false;
                    break;
                }
            }

            if (canPlaySound)
            {
                source.PlayOneShot(Sound, 1 - (distance / portee));
                Player.Instance.SetDestination(tf.position);
            }
        }

        var others = Physics.OverlapSphere(tf.position, portee);

        foreach(var other in others)
        {
            if(other.CompareTag("Animal"))
            {
                var hits = Physics.RaycastAll(tf.position, (Player.Instance.GetPosition() - tf.position).normalized, Vector3.Distance(tf.position, other.transform.position));
                bool canPlaySound = true;

                foreach (var hit in hits)
                {
                    if (hit.collider.CompareTag("Wall"))
                    {
                        canPlaySound = false;
                        break;
                    }
                }

                if (canPlaySound)
                {
                    other.GetComponent<Animal>().SetDestination(tf.position);
                }
            }
        }
    }
}