using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Button : MonoBehaviour {
    public SoundEmitter[] LinkedSoundEmitters;
    public AudioClip SoundToPlay;
    public Material Mat;

    public void SetMaterials()
    {
        foreach (var emitter in LinkedSoundEmitters)
        {
            emitter.SetMaterial(Mat);
        }
    }

    public void PlaySoundAtEmitters()
    {
        int ShortestIndex = FindShortestIndex();

        for(int i = 0; i<LinkedSoundEmitters.Length; i++)
        {
            if (i == ShortestIndex)
                LinkedSoundEmitters[i].PlaySound(SoundToPlay, true);
            else
                LinkedSoundEmitters[i].PlaySound(SoundToPlay, false);
        }
    }

    public void TestSound()
    {
        SoundManager.Instance.TestSound(SoundToPlay);
    }

    public int FindShortestIndex()
    {
        int index = -1;
        float shortest = 99999;

        for(int i = 0; i < LinkedSoundEmitters.Length; i++)
        {
            float dist = Vector3.Distance(LinkedSoundEmitters[i].GetPosition(), Player.Instance.GetPosition());
            if(dist < shortest && LinkedSoundEmitters[i].CanReachPlayer())
            {
                index = i;
                shortest = dist;
            }
        }
        return index;
    }
}
