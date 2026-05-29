using UnityEngine;

public class audioInteractScript : attachmentBaseScript
{
	public string m_audio;

	private GameObject m_audioGo;

	public override bool canPlacedInteract => true;

	public override bool PlacedInteract(bool _instant = false)
	{
		if (m_audioGo == null)
		{
			m_audioGo = base.transform.parent.GetComponent<itemScript>().audioGO;
		}
		AkSoundEngine.PostEvent(m_audio, m_audioGo);
		return false;
	}
}
