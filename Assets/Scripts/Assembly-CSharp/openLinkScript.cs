using UnityEngine;

public class openLinkScript : MonoBehaviour
{
	public string m_url;

	public void OpenURL()
	{
		AkSoundEngine.PostEvent("ui_click_medium", base.gameObject);
		Application.OpenURL(m_url);
	}
}
