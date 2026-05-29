using UnityEngine;

public class simpleSfkScript : attachmentBaseScript
{
	private itemScript m_target;

	public string m_audio;

	private void Start()
	{
		m_target = base.transform.parent.GetComponent<itemScript>();
	}

	public override void ChangePlaced(bool _value)
	{
		if (_value && !string.IsNullOrEmpty(m_audio) && m_target != null)
		{
			Camera.main.GetComponent<gameScript>().playAudio(m_audio, m_target.audioGO);
		}
	}
}
