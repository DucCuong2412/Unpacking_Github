using UnityEngine;

public class titlePlayMusicEvent : MonoBehaviour
{
	private static bool m_fired;

	private void Start()
	{
		if (!m_fired)
		{
			AkSoundEngine.PostEvent("Play_music", base.gameObject);
			m_fired = true;
		}
	}
}
