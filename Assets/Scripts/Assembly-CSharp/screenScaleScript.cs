using UnityEngine;
using UnityEngine.UI;

public class screenScaleScript : MonoBehaviour
{
	public Camera[] m_cameras;

	public CanvasScaler[] m_canvases;

	public titleBackgroundPan[] m_pans;

	public Transform[] m_nudges;

	private void Start()
	{
		SetResolution(Screen.width, Screen.height);
	}

	public void SetResolution(int _width, int _height)
	{
		float num = (float)_height / 200f;
		int num2 = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num2 == 1 && _width >= 1280 && _height >= 720)
		{
			num2 = 2;
		}
		for (int i = 0; i < m_cameras.Length; i++)
		{
			m_cameras[i].orthographicSize = num / (float)num2;
		}
		for (int j = 0; j < m_canvases.Length; j++)
		{
			m_canvases[j].scaleFactor = num2;
		}
		for (int k = 0; k < m_pans.Length; k++)
		{
			m_pans[k].orthoSize = num / (float)num2;
			m_pans[k].pixelScale = num2;
			m_pans[k].SetLerp();
		}
		uiCursor cursor = gameStateScript.GetCursor();
		if (cursor != null)
		{
			cursor.pixelSize = num2;
		}
	}
}
