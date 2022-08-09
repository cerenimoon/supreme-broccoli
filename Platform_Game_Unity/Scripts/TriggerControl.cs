using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerControl : MonoBehaviour
{
    [SerializeField] GameObject player;
    // Start is called before the first frame update
    private void OnTriggerEnter2D(Collider2D other)
    {
        player.GetComponent<PlayerControler>().onGround = true;
    }

    private void OnTriggerExit2D(Collider2D collision)
    {
        //Debug.Log("Triggerdan çıktı");
        player.GetComponent<PlayerControler>().onGround = false;
    }
}
