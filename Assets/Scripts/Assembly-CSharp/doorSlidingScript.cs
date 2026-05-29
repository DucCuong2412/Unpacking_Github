using System;
using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class doorSlidingScript : MonoBehaviour
{
	[Serializable]
	public struct blockedDrawers
	{
		public drawerManagerScript m_drawers;

		public float m_bounceFraction;

		public blockedDrawers(drawerManagerScript _drawers, float _bounceFraction)
		{
			m_drawers = _drawers;
			m_bounceFraction = _bounceFraction;
		}
	}

	private zoneScript m_zone;

	[Header("Audio")]
	public string m_audioName = "drawer";

	public float m_audioOpen = 1f;

	private bool m_audioOpenPlayed;

	public float m_audioClose;

	private bool m_audioClosePlayed;

	public string m_audioImpact;

	[Space(15f)]
	public GameObject m_audioPosition;

	public zoneScript.direction m_direction = zoneScript.direction.yAxis;

	public int m_doorRange = 10;

	public AnimationCurve m_motion;

	public bool m_useReverseCurve;

	public AnimationCurve m_motionReverse;

	public AnimationCurve m_motionBounce;

	public float m_doorSpeed = 0.333f;

	private Vector3 m_basePosition;

	private bool m_moving;

	private float m_lerp;

	private float m_lerpTarget;

	private bool m_bounce;

	private float m_bounceLerp;

	public float m_bounceFraction = 1f;

	public bool m_bouncePositive = true;

	public doorSlidingScript m_connectedDoor;

	public doorSlidingScript m_linkedDoor;

	public doorSlidingScript[] m_additionalDoors;

	public Collider2D m_connectedBlocker;

	public vibrationScript.moment m_vibrationCollision = vibrationScript.moment.collision;

	public blockedDrawers[] m_blockedDrawers;

	public drawerManagerScript m_drawers;

	public SpriteMask m_spriteMask;

	public int m_maskThreshold;

	public PolygonCollider2D m_polygon;

	protected int[] m_nodes;

	public PolygonCollider2D m_openCollision;

	private Vector2[] m_closeCollisionPoints = new Vector2[0];

	private int m_doorPosition;

	private int m_usableIndex = -1;

	public bool isOpen => m_lerpTarget == 1f;

	public float lerp => m_lerp;

	public int doorPosition => m_doorPosition;

	public int usableIndex => m_usableIndex;

	public void Register(zoneScript _zone, int _usableIndex)
	{
		m_usableIndex = _usableIndex;
		m_zone = _zone;
		m_basePosition = base.transform.localPosition;
		if (m_audioPosition == null)
		{
			m_audioPosition = base.gameObject;
		}
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(m_zone.reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audioPosition, akAuxSendArray, 1u);
		for (int i = 0; i < m_blockedDrawers.Length; i++)
		{
			m_blockedDrawers[i].m_drawers.EnableDrawers(_value: false);
		}
		m_nodes = ((m_polygon != null) ? m_zone.GetAllGridsWithinPolygon(m_polygon) : new int[0]);
		m_zone.SetGridActive(m_nodes, _active: false);
		if (m_polygon != null)
		{
			m_polygon.gameObject.SetActive(value: false);
		}
		if (m_openCollision != null)
		{
			m_closeCollisionPoints = GetComponent<PolygonCollider2D>().points;
			m_openCollision.gameObject.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (m_moving)
		{
			Vector2 vector = new Vector2((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? (-0.02f) : 0.02f, (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-0.01f) : 0.01f);
			m_lerp = Mathf.MoveTowards(m_lerp, m_lerpTarget, Time.deltaTime * (1f / m_doorSpeed));
			if (m_lerpTarget > 0.5f)
			{
				if (!m_audioOpenPlayed && m_lerp >= m_audioOpen)
				{
					AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_open_end", m_audioPosition);
					m_audioOpenPlayed = true;
				}
			}
			else if (!m_audioClosePlayed && m_lerp <= m_audioClose)
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_closing_stop", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_end", m_audioPosition);
				m_audioClosePlayed = true;
			}
			if (m_lerp == m_lerpTarget)
			{
				m_moving = false;
				if (m_lerp == 1f && m_spriteMask != null && m_maskThreshold == 0)
				{
					m_spriteMask.enabled = false;
				}
			}
			float num = ((m_lerpTarget > 0.5f || !m_useReverseCurve) ? m_motion.Evaluate(m_lerp) : m_motionReverse.Evaluate(m_lerp));
			int num2 = Mathf.RoundToInt((float)m_doorRange * num);
			base.transform.localPosition = m_basePosition + new Vector3((float)num2 * vector.x, (float)num2 * vector.y, 0f);
			m_doorPosition = num2;
			if (m_maskThreshold > 0 && m_spriteMask != null)
			{
				m_spriteMask.enabled = num2 < m_maskThreshold;
			}
		}
		else
		{
			if (!m_bounce)
			{
				return;
			}
			Vector2 vector2 = new Vector2((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? (-0.02f) : 0.02f, (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-0.01f) : 0.01f);
			float bounceLerp = m_bounceLerp;
			m_bounceLerp = Mathf.MoveTowards(m_bounceLerp, 1f, Time.deltaTime * (1f / (m_doorSpeed * Mathf.Max(m_bounceFraction, 0.15f)) * 0.3f));
			if (bounceLerp < 0.25f && m_bounceLerp >= 0.25f)
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_closing_stop", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_end", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
				if (!string.IsNullOrEmpty(m_audioImpact))
				{
					AkSoundEngine.PostEvent(m_audioImpact, m_audioPosition);
				}
				for (int i = 0; i < m_blockedDrawers.Length; i++)
				{
					if (m_blockedDrawers[i].m_drawers.isOpen && m_blockedDrawers[i].m_bounceFraction == m_bounceFraction)
					{
						m_blockedDrawers[i].m_drawers.Impact();
					}
				}
				vibrationScript.Trigger(m_vibrationCollision);
			}
			else
			{
				if (!m_audioOpenPlayed && m_bounceLerp >= m_audioOpen)
				{
					AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_open_end", m_audioPosition);
					m_audioOpenPlayed = true;
				}
				if (m_bounceLerp == 1f)
				{
					m_bounce = false;
					if (m_spriteMask != null && m_maskThreshold == 0)
					{
						m_spriteMask.enabled = false;
					}
				}
			}
			float num3 = m_motionBounce.Evaluate(m_bounceLerp);
			int num4 = Mathf.RoundToInt((float)m_doorRange * num3 * m_bounceFraction);
			if (!m_bouncePositive)
			{
				num4 = m_doorRange - num4;
			}
			base.transform.localPosition = m_basePosition + new Vector3((float)num4 * vector2.x, (float)num4 * vector2.y, 0f);
			m_doorPosition = num4;
			if (m_maskThreshold > 0 && m_spriteMask != null)
			{
				m_spriteMask.enabled = num4 < m_maskThreshold;
			}
		}
	}

	public bool Check(out int _usableIndex)
	{
		if (m_lerpTarget > 0f)
		{
			if (m_bounce)
			{
				_usableIndex = -1;
				return true;
			}
			for (int i = 0; i < m_blockedDrawers.Length; i++)
			{
				if (m_blockedDrawers[i].m_drawers.isOpen)
				{
					m_bounceFraction = m_blockedDrawers[i].m_bounceFraction;
					m_bounce = true;
					m_bounceLerp = 0f;
					_usableIndex = -1;
					return true;
				}
			}
			if (m_moving)
			{
				AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
			}
			else
			{
				m_moving = true;
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
			}
			m_lerpTarget = 0f;
			AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
			m_audioClosePlayed = false;
			if (m_spriteMask != null && m_maskThreshold == 0)
			{
				m_spriteMask.enabled = true;
			}
			m_zone.SetGridActive(m_nodes, _active: false);
			SetItemsActive();
			for (int j = 0; j < m_blockedDrawers.Length; j++)
			{
				m_blockedDrawers[j].m_drawers.EnableDrawers(_value: false);
			}
			_usableIndex = m_usableIndex;
			return true;
		}
		_usableIndex = -1;
		return false;
	}

	public int Use()
	{
		return Use(_link: false);
	}

	public int Use(bool _link)
	{
		if (m_connectedDoor != null && m_connectedDoor.Check(out var _usableIndex))
		{
			return _usableIndex;
		}
		if (!m_moving && !m_bounce)
		{
			for (int i = 0; i < m_blockedDrawers.Length; i++)
			{
				if (m_blockedDrawers[i].m_drawers.isOpen)
				{
					m_bounceFraction = m_blockedDrawers[i].m_bounceFraction;
					m_bounce = true;
					m_bounceLerp = 0f;
					AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
					return -1;
				}
			}
			m_moving = true;
			if (m_lerpTarget == 0f)
			{
				m_lerpTarget = 1f;
				if (!_link)
				{
					AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
					m_audioOpenPlayed = false;
				}
				if (m_connectedBlocker != null)
				{
					m_connectedBlocker.enabled = false;
				}
				m_zone.SetGridActive(m_nodes, _active: true);
				SetItemsActive();
				for (int j = 0; j < m_blockedDrawers.Length; j++)
				{
					m_blockedDrawers[j].m_drawers.EnableDrawers(_value: true);
				}
				if (m_openCollision != null)
				{
					GetComponent<PolygonCollider2D>().points = m_openCollision.points;
				}
			}
			else
			{
				m_lerpTarget = 0f;
				if (!_link)
				{
					AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
					m_audioClosePlayed = false;
				}
				if (m_connectedBlocker != null)
				{
					m_connectedBlocker.enabled = true;
				}
				if (m_spriteMask != null && m_maskThreshold == 0)
				{
					m_spriteMask.enabled = true;
				}
				m_zone.SetGridActive(m_nodes, _active: false);
				SetItemsActive();
				for (int k = 0; k < m_blockedDrawers.Length; k++)
				{
					m_blockedDrawers[k].m_drawers.EnableDrawers(_value: false);
				}
				if (m_openCollision != null)
				{
					GetComponent<PolygonCollider2D>().points = m_closeCollisionPoints;
				}
			}
			if (!_link && m_linkedDoor != null)
			{
				m_linkedDoor.Use(_link: true);
			}
			return m_usableIndex;
		}
		return -1;
	}

	private void OnDrawGizmosSelected()
	{
		Vector2 vector = new Vector2((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? (-0.02f) : 0.02f, (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-0.01f) : 0.01f);
		PolygonCollider2D component = GetComponent<PolygonCollider2D>();
		Vector2[] points = component.points;
		Vector3 vector2 = ((m_lerp > 0f) ? m_basePosition : base.transform.position) + (Vector3)component.offset + (Vector3)(vector * m_doorRange);
		Gizmos.color = Color.cyan;
		if (m_openCollision == null)
		{
			for (int i = 0; i < points.Length; i++)
			{
				Gizmos.DrawLine((Vector3)points[i] + vector2, (Vector3)points[(i + 1) % points.Length] + vector2);
			}
		}
		if (m_zone != null)
		{
			Gizmos.color = Color.red;
			for (int j = 0; j < m_nodes.Length; j++)
			{
				Gizmos.DrawWireSphere(m_zone.GetGrid(m_nodes[j]), 0.025f);
			}
		}
	}

	private void SetItemsActive()
	{
		m_zone.SetItemsActive(m_nodes);
		for (int i = 0; i < m_additionalDoors.Length; i++)
		{
			m_zone.SetItemsActive(m_additionalDoors[i].m_nodes);
		}
	}

	public bool PlaybackUse(int _index, bool _animate)
	{
		if (m_usableIndex != _index)
		{
			return false;
		}
		if (_animate)
		{
			if (m_lerpTarget == 0f)
			{
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
			}
			else
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				m_audioClosePlayed = false;
			}
		}
		PlaybackUse(_animate);
		if (m_linkedDoor != null)
		{
			m_linkedDoor.PlaybackUse(_animate);
		}
		return true;
	}

	public void PlaybackUse(bool _animate)
	{
		if (_animate)
		{
			m_moving = true;
			if (m_lerpTarget == 0f)
			{
				m_lerpTarget = 1f;
				return;
			}
			m_lerpTarget = 0f;
			if (m_spriteMask != null && m_maskThreshold == 0)
			{
				m_spriteMask.enabled = true;
			}
		}
		else
		{
			SetSaveData(m_lerpTarget == 0f);
		}
	}

	public void SetSaveData(bool _open)
	{
		m_moving = false;
		m_bounce = false;
		m_lerp = (_open ? 1f : 0f);
		m_lerpTarget = (_open ? 1f : 0f);
		Vector2 vector = new Vector2((m_direction == zoneScript.direction.xAxis || m_direction == zoneScript.direction.yAxisNeg) ? (-0.02f) : 0.02f, (m_direction == zoneScript.direction.xAxisNeg || m_direction == zoneScript.direction.yAxisNeg) ? (-0.01f) : 0.01f);
		if (m_spriteMask != null)
		{
			m_spriteMask.enabled = !_open || !(m_spriteMask != null);
		}
		int num = Mathf.RoundToInt((float)m_doorRange * m_lerp);
		base.transform.localPosition = m_basePosition + new Vector3((float)num * vector.x, (float)num * vector.y, 0f);
		m_doorPosition = num;
		bool flag = false;
		for (int i = 0; i < m_additionalDoors.Length; i++)
		{
			flag |= m_additionalDoors[i].isOpen;
		}
		if (!flag)
		{
			for (int j = 0; j < m_blockedDrawers.Length; j++)
			{
				m_blockedDrawers[j].m_drawers.EnableDrawers(_open);
			}
			m_zone.SetGridActive(m_nodes, _open);
			SetItemsActive();
			if (_open && m_openCollision != null)
			{
				GetComponent<PolygonCollider2D>().points = m_openCollision.points;
			}
		}
	}
}
