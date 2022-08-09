using UnityEngine;
using UnityEngine.UI;

public class CoinController : MonoBehaviour
{
    [SerializeField] Text scoreValueText;
    [SerializeField] float coinRotateSpeed;

    private void Update()
    {
        transform.Rotate(new Vector3(0f, coinRotateSpeed, 0f));
    }
    // Start is called before the first frame update
   
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            GameObject.Find("Level Manager").GetComponent<LevelManager>().AddScore(50);
            Destroy(gameObject);
        }
    }
}
