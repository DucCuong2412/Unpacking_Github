using UnityEngine;

public class itemAnimAudioScript : MonoBehaviour
{
	private bool m_init;

	private GameObject m_audio;

	public Transform audioTransform => m_audio.transform;

	private void Start()
	{
		Init();
	}

	private void Init()
	{
		if (!m_init)
		{
			m_init = true;
			m_audio = new GameObject("audioGO");
			m_audio.transform.parent = base.transform;
		}
	}

	public void SetReverb(uint _reverbID)
	{
		Init();
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(_reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audio, akAuxSendArray, 1u);
		m_audio.transform.localPosition = Vector3.forward * (0f - base.transform.position.z);
	}

	public void PlaySound(string _audio)
	{
		Init();
		Debug.Log("PLAYING " + _audio);
		AkSoundEngine.PostEvent(_audio, m_audio);
	}
}
