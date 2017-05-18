using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class AssociationManager : MonoBehaviour {

    public List<Material> Initen;
    public GameObject BaseIniten;
    public Transform CamAssociation;
    public float distFromCam;
    public float distFromCenter;
    public float sphereSize;
    public float launchDelay;
    public float rotationSpeed;
    public int sphereDisplayed;
    private Button [] soundButtons;
    AudioSource source;
    int index;

    void Start () {
        soundButtons = GameObject.FindObjectsOfType<Button>();
        source = GetComponent<AudioSource>();
        index = 0;
        Invoke("SetUp", 1f);
        CamAssociation.GetChild(0).position += new Vector3(0, 0, distFromCam);
    }

    public void Associate(Material m, int pos)
    {
        soundButtons[index].Mat = m;
        index++;

        if (index == soundButtons.Length)
            EndAssociation();

        if (Initen.Count > 0)
            SpawnIniten(pos, 0f);
        Invoke("PlaySound", 1f);
    }

    void SetUp()
    {
        for (int i = 0; i < sphereDisplayed; i++)
        {
            if (Initen.Count <= 0)
                break;
            SpawnIniten(i, launchDelay * i);
        }

        CamAssociation.GetChild(0).DORotate(new Vector3(0f, 0f, -360f), rotationSpeed, RotateMode.WorldAxisAdd).SetLoops(100).SetEase(Ease.Linear);
        PlaySound();
    }

    void SpawnIniten(int pos, float delay)
    {
        GameObject clone = Instantiate(BaseIniten, CamAssociation.GetChild(0).position,CamAssociation.GetChild(0).rotation, CamAssociation.GetChild(0));
        clone.GetComponent<InitenClick>().associator = this;
        clone.GetComponent<InitenClick>().pos = pos;
        int m = Random.Range(0, Initen.Count);
        clone.GetComponent<MeshRenderer>().material = Initen[m];
        Initen.RemoveAt(m);
        clone.transform.Rotate(Vector3.forward, (360 / sphereDisplayed) * pos);
        clone.transform.DOLocalMove(clone.transform.up * distFromCenter, 3f).SetEase(Ease.OutElastic, 1f).SetDelay(delay);
        clone.transform.localScale = Vector3.zero;
        clone.transform.DOScale(sphereSize, 1f).SetDelay(delay);
    }

    void PlaySound () {
        if (soundButtons[0].SoundToPlay != null)
            source.PlayOneShot(soundButtons[0].SoundToPlay);
	}

    void EndAssociation()
    {
        gameObject.SetActive(false);
        foreach (Button btn in soundButtons)
        {
            btn.SetMaterials();
        }
    }
}
