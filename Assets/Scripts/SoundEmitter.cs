using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundEmitter : MonoBehaviour {
    public AudioClip Sound;

    private AudioSource source;
    private Transform tf;
    private float portee;

    private void Start()
    {
        source = GetComponent<AudioSource>();
        tf = transform;
        portee = GetComponent<SphereCollider>().radius;
    }

    public void PlaySound()
    {
        float distance = Vector3.Distance(tf.position, Player.Instance.GetPosition());

        if(distance <= portee)
        {
            source.PlayOneShot(Sound, distance/portee);
            Player.Instance.SetDestination(tf.position);
        }
    }
}
