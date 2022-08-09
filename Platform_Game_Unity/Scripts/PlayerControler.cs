using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerControler : MonoBehaviour
{
    private float mySpeedx;
    [SerializeField] float speed; //private
    [SerializeField] float jumpPower;
    private Rigidbody2D myBody;
    private Vector3 defaultLocalScale;
    public bool onGround;
    private bool canDoubleJump;
    [SerializeField] GameObject arrow;
    [SerializeField] bool attacked;
    [SerializeField] float currentAttackedTimer;
    [SerializeField] float defaultAttackedTimer;
    private Animator myAnimator;
    [SerializeField] int arrayNumber;
    [SerializeField] Text arrawNumberText;
    [SerializeField] AudioClip dieMusic;
    [SerializeField] GameObject winPanel, losePanel;
    // Start is called before the first frame update
    void Start()
    {
        attacked = false;
        myAnimator = GetComponent<Animator>();
        myBody = GetComponent<Rigidbody2D>();
        defaultLocalScale = transform.localScale;
        arrawNumberText.text = arrayNumber.ToString();
    }

    // Update is called once per frame
    void Update()
    {
        //Debug.Log(Input.GetAxis("Horizontal"));
        mySpeedx = Input.GetAxis("Horizontal"); //-1 ile 1 arasında değerler alacak
        myAnimator.SetFloat("Speed", Mathf.Abs(mySpeedx));
        myBody.velocity = new Vector2(mySpeedx*speed, myBody.velocity.y);

        #region sagsol yüzünün dönmesi
        //Debug.Log("Frame Mantığı");
        if (mySpeedx > 0)
        {
            transform.localScale = new Vector3(defaultLocalScale.x,defaultLocalScale.y, defaultLocalScale.z);
        }
        else if(mySpeedx < 0)
        {
            transform.localScale = new Vector3(-defaultLocalScale.x, defaultLocalScale.y, defaultLocalScale.z);
        }
        #endregion

        #region playerın zıplamasının kontrol edilmesi

        if (Input.GetKeyDown(KeyCode.Space))
        {
            //Debug.Log("Boşluk tuşuna basıldı");
            if (onGround == true)
            {
                myBody.velocity = new Vector2(myBody.velocity.x, jumpPower);
                canDoubleJump = true;
                myAnimator.SetTrigger("Jump");
            }
            else
            {
                if(canDoubleJump == true)
                {
                    myBody.velocity = new Vector2(myBody.velocity.x, jumpPower);
                    canDoubleJump = false;
                } 
            }
        }
        #endregion

        #region playerın ok atmasının kontrolü
        if (Input.GetMouseButtonDown(0) && arrayNumber > 0)
        {
            if (attacked == false)
            {
                attacked = true;
                myAnimator.SetTrigger("Attack");
                Invoke("Fire", 0.5f);
            }
        }
        #endregion

        if(attacked == true)
        {
            currentAttackedTimer -= Time.deltaTime;
            Debug.Log(currentAttackedTimer);
        }
        else
        {
            currentAttackedTimer = defaultAttackedTimer;
        }
       
        if(currentAttackedTimer <= 0)
        {
            attacked = false;
        }

    }
    void Fire()
    {
        GameObject okumuz = Instantiate(arrow, transform.position, Quaternion.identity);
        okumuz.transform.parent = GameObject.Find("Arrows").transform;
        okumuz.GetComponent<Rigidbody2D>().velocity = new Vector2(5f, 0f);

        if (transform.localScale.x > 0)
        {
            okumuz.GetComponent<Rigidbody2D>().velocity = new Vector2(5f, 0f);
        }
        else
        {
            Vector3 okumuzScale = okumuz.transform.localScale;
            okumuz.transform.localScale = new Vector3(-okumuzScale.x, okumuzScale.y, okumuzScale.z);
            okumuz.GetComponent<Rigidbody2D>().velocity = new Vector2(-5f, 0f);
        }

        arrayNumber--;
        arrawNumberText.text = arrayNumber.ToString();
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if(collision.gameObject.CompareTag("Enemy"))
        {
            GetComponent<TimeController>().enabled = false;
            Die();
        }
        else if(collision.gameObject.CompareTag("Finish"))
        {
            /*winPanel.active = true;
            Time.timeScale = 0;*/
            Destroy(collision.gameObject);
            StartCoroutine(Wait(true));


        }
    }

    public void Die()
    {
        GameObject.Find("Sound Controller").GetComponent<AudioSource>().clip = null;
        GameObject.Find("Sound Controller").GetComponent<AudioSource>().PlayOneShot(dieMusic);
        myAnimator.SetFloat("Speed", 0);
        myAnimator.SetTrigger("Die");

        //myBody.constraints = RigidbodyConstraints2D.FreezePosition;
        myBody.constraints = RigidbodyConstraints2D.FreezeAll;

        enabled = false;
        //losePanel.SetActive(false);
        //Time.timeScale = 0;
        StartCoroutine(Wait(false));
    }

    IEnumerator Wait(bool win)
    {
        yield return new WaitForSecondsRealtime(2f);
        Time.timeScale = 0;
        if (win == true)
        {
            winPanel.SetActive(true);
        }
        else
        {
            losePanel.SetActive(true);
        }
        
    }
}
