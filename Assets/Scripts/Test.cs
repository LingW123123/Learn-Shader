using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Vector3 v = new Vector3(11, 0, 11);
        Vector3 v1 = new Vector3(12, 0, 0);
        var dot = Vector3.Dot(v1, v);
        Debug.Log(dot);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
