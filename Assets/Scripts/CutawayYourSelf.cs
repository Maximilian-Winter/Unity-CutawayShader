using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CutawayYourSelf : MonoBehaviour {

    public Transform cutter;
    public Renderer rend;
    void Start()
    {
        rend = GetComponent<Renderer>();
    }
    void Update()
    {
        rend.material.SetVector("_CutawayPosition", cutter.position);
        rend.material.SetVector("_CutawayNormal", Vector3.Normalize(cutter.forward));
    }
}
