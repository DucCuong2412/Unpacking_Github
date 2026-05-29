using System.Collections;
using UnityEngine;

public class photoBorderSizeScript : MonoBehaviour
{
	public int m_offset = 51;

	private void OnEnable()
	{
		Resize();
	}

	public void SetSize()
	{
		StartCoroutine(ResizeAtEndOfFrame());
	}

	private IEnumerator ResizeAtEndOfFrame()
	{
		yield return new WaitForEndOfFrame();
		Resize();
	}

	private void Resize()
	{
		Canvas componentInParent = GetComponentInParent<Canvas>();
		GetComponent<RectTransform>().sizeDelta = Vector2.right * (componentInParent.GetComponent<RectTransform>().sizeDelta.y - (float)m_offset);
	}
}
