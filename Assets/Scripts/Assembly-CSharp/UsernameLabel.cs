using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class UsernameLabel : MonoBehaviour
{
	private TextMeshProUGUI m_label;

	private RawImage m_image;

	private void Awake()
	{
		base.gameObject.SetActive(value: false);
	}
}
