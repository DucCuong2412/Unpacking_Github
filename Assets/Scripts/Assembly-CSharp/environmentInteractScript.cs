using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class environmentInteractScript : MonoBehaviour
{
	public Sprite[] m_animFrames;

	public AnimationCurve m_animCurve;

	public float m_animSpeed = 1f;

	private bool m_animate;

	private float m_lerp;

	public GameObject m_audioPosition;

	private uint m_audioId;

	public string m_audioEventAction;

	public string m_audioEventCooldown;

	public float m_audioEventCooldownTime;

	private float m_audioEventCooldownTimer;

	public statsScript.unlocks m_toiletId;

	private void Start()
	{
		if (m_audioPosition == null)
		{
			m_audioPosition = base.gameObject;
		}
		Vector3 position = m_audioPosition.transform.position;
		position.z = 0f;
		m_audioPosition.transform.position = position;
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(base.transform.parent.GetComponent<zoneScript>().reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audioPosition, akAuxSendArray, 1u);
	}

	public void Use()
	{
		if (!m_animate)
		{
			m_audioPosition.transform.parent = Camera.main.GetComponent<gameScript>().audioWheel;
			m_animate = true;
			m_lerp = 0f;
			if (!string.IsNullOrEmpty(m_audioEventAction))
			{
				AkSoundEngine.PostEvent(m_audioEventAction, m_audioPosition);
			}
			if (!string.IsNullOrEmpty(m_audioEventCooldown) && m_audioEventCooldownTimer == 0f)
			{
				m_audioEventCooldownTimer = m_audioEventCooldownTime;
				m_audioId = AkSoundEngine.PostEvent(m_audioEventCooldown, m_audioPosition);
				statsScript.SpecialEvent(statsScript.specialEvents.toiletFlush);
				statsScript.ToiletFlush(m_toiletId);
			}
		}
	}

	private void Update()
	{
		if (m_animate)
		{
			m_lerp += Time.deltaTime * m_animSpeed;
			if (m_lerp >= 1f)
			{
				GetComponent<SpriteRenderer>().sprite = m_animFrames[0];
				m_animate = false;
				m_lerp = 0f;
			}
			else
			{
				int num = m_animFrames.Length - 1;
				GetComponent<SpriteRenderer>().sprite = m_animFrames[Mathf.RoundToInt(m_animCurve.Evaluate(m_lerp) * (float)num)];
			}
		}
		if (m_audioEventCooldownTimer > 0f)
		{
			m_audioEventCooldownTimer = Mathf.MoveTowards(m_audioEventCooldownTimer, 0f, Time.deltaTime);
		}
	}

	private void OnDestroy()
	{
		AkSoundEngine.StopPlayingID(m_audioId);
	}
}
