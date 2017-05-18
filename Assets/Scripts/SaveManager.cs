using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SaveManager : MonoBehaviour {
    public List<Material> AvailableInitens;
    public AudioClip[] AvailableSounds;
    public Sprite[] AvailableButtons;

    private Material[] AssociatedMaterials;

    public static SaveManager Instance = null;

	void Awake () {
		if(Instance == null)
        {
            Instance = this;
        } else
        {
            Destroy(gameObject);
        }

        InitTab();

        DontDestroyOnLoad(gameObject);
	}

    public Sprite GetSpriteForSound(AudioClip Sound)
    {
        return AvailableButtons[FindIndex(Sound)];
    }

    private void InitTab()
    {
        AssociatedMaterials = new Material[AvailableSounds.Length];
        for(int i = 0; i< AssociatedMaterials.Length; i++)
        {
            AssociatedMaterials[i] = null;
        }
    }

    public Material GetMat(AudioClip Sound)
    {
        return AssociatedMaterials[FindIndex(Sound)];
    }

    public bool IsSet(AudioClip Sound)
    {
        return AssociatedMaterials[FindIndex(Sound)] != null;
    }

    private int FindIndex(AudioClip Sound)
    {
        int index = -1;

        for (int i = 0; i < AvailableSounds.Length; i++)
        {
            if (AvailableSounds[i].name == Sound.name)
            {
                index = i;
                break;
            }
        }

        return index;
    }

    public void SetMaterial(AudioClip Sound, Material Mat)
    {
        AssociatedMaterials[FindIndex(Sound)] = Mat;
        AvailableInitens.Remove(Mat);
    }
}
