using UnityEngine;

public class uiAnchorScript : MonoBehaviour
{
	private void Start()
	{
		float num = 1.7777778f / ((float)Screen.width / (float)Screen.height);
		Vector3 position = base.transform.position;
		position.x /= 2.7f * num;
		position.y /= 2.7f;
		float orthographicSize = Camera.main.orthographicSize;
		position.x *= orthographicSize;
		position.y *= orthographicSize;
		base.transform.position = position;
	}
}
