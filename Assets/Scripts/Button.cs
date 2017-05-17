using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Button : MonoBehaviour {
    public SoundEmitter[] LinkedSoundEmitters;
    public AudioClip SoundToPlay;
    public Material Mat;

	void Start () {
		foreach(var emitter in LinkedSoundEmitters)
        {
            emitter.SetMaterial(Mat);
        }
	}

    public void PlaySoundAtEmitters()
    {
        foreach(var emitter in LinkedSoundEmitters)
        {
            emitter.PlaySound(SoundToPlay);
        }
    }
}
