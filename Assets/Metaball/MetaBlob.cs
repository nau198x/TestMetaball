using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MetaBlob : MonoBehaviour {

    private Material mat;
    private float time;

	void Start () {
        mat = gameObject.GetComponent<Renderer>().material;
        mat.SetFloat("_rangeY", 0.5f);
	}
	
	void Update () {
        time += Time.deltaTime;
        mat.SetFloat("_ControlTime", time);
        Debug.Log(time);
    }
}
