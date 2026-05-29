using UnityEngine;
using UnityEngine.UI;

public class fontFilterScript : MonoBehaviour
{
	private void Start()
	{
		GetComponent<Text>().font.material.mainTexture.filterMode = FilterMode.Point;
	}
}
