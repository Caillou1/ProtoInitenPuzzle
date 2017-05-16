using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundEmitter : MonoBehaviour {
    public AudioClip Sound;
    public float Portee;

    private AudioSource source;
    private Transform tf;

    private void Start()
    {
        source = GetComponent<AudioSource>();
        tf = transform;
    }

    public void PlaySound()
    {
        //source.PlayOneShot(Sound);

        float distance = Vector3.Distance(tf.position, Player.Instance.GetPosition());

        if(distance <= Portee)
        {
            Player.Instance.SetDestination(tf.position);
        }
    }
}
