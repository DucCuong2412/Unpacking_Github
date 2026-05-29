using System;
using System.Collections;
using System.IO;
using SFB;
using TMPro;
using UnityEngine;

public class uiSavePathScript : MonoBehaviour
{
	public enum pathType
	{
		image = 0,
		gif = 1,
		video = 2
	}

	public pathType m_type;

	public void ChangePath()
	{
		StartCoroutine(OpenPanel());
	}

	private IEnumerator OpenPanel()
	{
		yield return null;
		string text = "";
		if (m_type == pathType.image)
		{
			text = gameStateScript.GetPathScreenshot();
		}
		else if (m_type == pathType.video)
		{
			text = gameStateScript.GetPathVideo();
		}
		else if (m_type == pathType.gif)
		{
			text = gameStateScript.GetPathGif();
		}
		try
		{
			if (!Directory.Exists(text))
			{
				Directory.CreateDirectory(text);
			}
			Cursor.visible = true;
			StandaloneFileBrowser.OpenFolderPanelAsync(GetComponent<TextMeshProUGUI>().text, text, multiselect: false, delegate(string[] paths)
			{
				SetPath(paths);
			});
		}
		catch (Exception ex)
		{
			Debug.LogWarning("path set failed : " + ex.ToString());
		}
	}

	private void SetPath(string[] _result)
	{
		if (_result.Length != 0)
		{
			if (m_type == pathType.image)
			{
				gameStateScript.SetPathScreenshot(_result[0]);
			}
			else if (m_type == pathType.video)
			{
				gameStateScript.SetPathVideo(_result[0]);
			}
			else if (m_type == pathType.gif)
			{
				gameStateScript.SetPathGif(_result[0]);
			}
		}
	}

	public void Reset()
	{
		if (m_type == pathType.image)
		{
			gameStateScript.SetPathScreenshot();
		}
		else if (m_type == pathType.video)
		{
			gameStateScript.SetPathVideo();
		}
		else if (m_type == pathType.gif)
		{
			gameStateScript.SetPathGif();
		}
	}
}
