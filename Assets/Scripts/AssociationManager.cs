using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class AssociationManager : MonoBehaviour {

    public List<Material> Initen;
    public GameObject BastIniten;
    public Transform CamAssociation;
    public float distFromCam;
    public float distFromCenter;
    public float sphereSize;
    public float launchDelay;
    public float rotationSpeed;
    private Button [] soundButtons;
    AudioSource source;
    int index;
    int originalLength;

    void Start () {
        soundButtons = GameObject.FindObjectsOfType<Button>();
        source = GetComponent<AudioSource>();
        index = 0;
        Invoke("SetUp", 1f);
        originalLength = soundButtons.Length;

    }

    public void Associate(Material m, int pos)
    {
        soundButtons[index].Mat = m;
        index++;

        if (index == soundButtons.Length)
            EndAssociation();

        if (Initen.Count > 0)
            SpawnIniten(pos, 0f);
    }

    void SetUp()
    {
        for (int i = 0; i < soundButtons.Length; i++)
        {
            if (Initen.Count <= 0)
                break;
            SpawnIniten(i, launchDelay * i);
        }

        CamAssociation.GetChild(0).DORotate(new Vector3(0f, 0f, -360f), rotationSpeed, RotateMode.WorldAxisAdd).SetLoops(100).SetEase(Ease.Linear);
    }

    void SpawnIniten(int pos, float delay)
    {
        GameObject clone = Instantiate(BastIniten, CamAssociation.GetChild(0));
        clone.GetComponent<InitenClick>().associator = this;
        clone.GetComponent<InitenClick>().pos = pos;
        int m = Random.Range(0, Initen.Count);
        clone.GetComponent<MeshRenderer>().material = Initen[m];
        Initen.RemoveAt(m);
        clone.transform.localRotation = Quaternion.identity;
        clone.transform.Rotate(Vector3.forward, (360 / originalLength) * pos);
        clone.transform.localPosition = new Vector3(0, 0, distFromCam);
        clone.transform.localScale = Vector3.zero;
        clone.transform.DOScale(sphereSize, 1f).SetDelay(delay);
        clone.transform.DOLocalMove(clone.transform.localPosition + clone.transform.up * distFromCenter, 3f).SetEase(Ease.OutElastic, 1f).SetDelay(delay);
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
