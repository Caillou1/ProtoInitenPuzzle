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
    private List<Button> soundButtons;
    List<GameObject> spheres = new List<GameObject>();
    AudioSource source;
    int index;

    void Start () {
        soundButtons = ButtonArrayToList(GameObject.FindObjectsOfType<Button>());
        source = GetComponent<AudioSource>();
        index = 0;
        Invoke("SetUp", 1f);
        CamAssociation.GetChild(0).position += new Vector3(0, 0, distFromCam);
    }

    private List<Button> ButtonArrayToList(Button[] tab)
    {
        List<Button> liste = new List<Button>();

        foreach(var b in tab)
        {
            if(SaveManager.Instance.IsSet(b.SoundToPlay))
            {
                liste.Add(b);
            } else
            {
                b.Mat = SaveManager.Instance.GetMat(b.SoundToPlay);
            }
        }

        return liste;
    }

    public void Associate(Material m, int pos, GameObject go)
    {
        soundButtons[index].Mat = m;
        index++;
        spheres.Remove(go);

        if (index == soundButtons.Count)
            FinishAssociation();

        if (index < soundButtons.Count)
        {
            Invoke("PlaySound", 1f);
            if (Initen.Count > 0)
                SpawnIniten(pos, 0f);
        }
        
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
        Invoke("PlaySound", 1.5f);
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
        clone.transform.DOLocalMove(CamAssociation.GetChild(0).InverseTransformDirection(clone.transform.up) * distFromCenter, 3f).SetEase(Ease.OutElastic, 1f).SetDelay(delay);
        clone.transform.localScale = Vector3.zero;
        clone.transform.DOScale(sphereSize, 1f).SetDelay(delay);
        spheres.Add(clone);
    }

    void PlaySound () {
        if (soundButtons[index].SoundToPlay != null)
            source.PlayOneShot(soundButtons[index].SoundToPlay);
	}

    void FinishAssociation() // Tout le code de fin de phase
    {
        foreach (Button btn in soundButtons)
        {
            btn.SetMaterials();
        }

        foreach (GameObject go in spheres)
        {
            go.transform.DOLocalMove(Vector3.zero, 1f).SetEase(Ease.InBack).OnComplete(EndAssociation);
            go.transform.DOScale(0f, 0.9f).SetEase(Ease.InSine);
        }
    }

    void EndAssociation()  // Après FinishAssociation, quand toutes les anims sont finies
    {
        LevelManager.Instance.StartChrono();
        gameObject.SetActive(false);
    }
}
