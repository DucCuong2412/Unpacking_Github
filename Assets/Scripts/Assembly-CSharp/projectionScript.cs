using UnityEngine;

public class projectionScript : MonoBehaviour
{
	public float ho;

	public float vo;

	private void OnEnable()
	{
		SetObliqueness(ho * 0.01f, vo * 0.01f);
	}

	private void OnDisable()
	{
		if ((bool)GetComponent<Camera>())
		{
			GetComponent<Camera>().ResetProjectionMatrix();
		}
	}

	private void SetObliqueness(float horizObl, float vertObl)
	{
		Matrix4x4 projectionMatrix = GetComponent<Camera>().projectionMatrix;
		projectionMatrix[0, 2] = horizObl;
		projectionMatrix[1, 2] = vertObl;
		GetComponent<Camera>().projectionMatrix = projectionMatrix;
	}
}
