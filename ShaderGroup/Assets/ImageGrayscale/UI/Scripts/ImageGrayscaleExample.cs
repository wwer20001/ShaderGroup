using UnityEngine;
using UnityEngine.UI;

public class ImageGrayscaleExample : MonoBehaviour
{
    public Material grayscaleMaterial;
    private Image image;

    void Start()
    {
        Material m = new Material(grayscaleMaterial);

        image = GetComponent<Image>();
        image.material = m;
    }

    float timer = 0f;
    void Update()
    {
        timer += Time.deltaTime;
        image.material.SetFloat("_Saturation", (Mathf.Sin(timer) + 1f) * 0.5f);
    }
}
