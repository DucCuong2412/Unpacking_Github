using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class doorFoldingScript : MonoBehaviour
{
	private zoneScript m_zone;

	[Header("Audio")]
	public string m_audioName = "folding_door";

	public float m_audioOpen = 1f;

	private bool m_audioOpenPlayed;

	public float m_audioClose;

	private bool m_audioClosePlayed;

	public string m_audioImpact;

	[Space(15f)]
	public GameObject m_audioPosition;

	public float m_doorSpeed = 5f;

	public SpriteMask m_spriteMask;

	public bool m_spriteMaskOnOpen;

	public Sprite[] m_spriteMaskFrames;

	public Sprite[] m_animFrames;

	public AnimationCurve m_motionOpen;

	public AnimationCurve m_motionClose;

	public AnimationCurve m_motionBounce;

	public drawerManagerScript m_drawers;

	private bool m_moving;

	private float m_lerp;

	private float m_lerpTarget;

	private bool m_bounce;

	private float m_bounceLerp;

	public float m_bounceFraction = 1f;

	public bool m_depthChangeOnOpening;

	public float m_depthChange;

	private Vector3 m_startPosition;

	private Vector2[] m_physicsClosed;

	private Vector2[] m_physicsOpen;

	public PolygonCollider2D m_polygon;

	private int[] m_nodes;

	public PolygonCollider2D m_polygonOpen;

	private int[] m_nodesOpen;

	public vibrationScript.moment m_vibrationTrigger;

	public vibrationScript.moment m_vibrationCollision = vibrationScript.moment.collision;

	private int m_usableIndex = -1;

	public bool isOpen => m_lerpTarget == 1f;

	public void Register(zoneScript _zone, int _usableIndex)
	{
		m_usableIndex = _usableIndex;
		m_zone = _zone;
		if (m_audioPosition == null)
		{
			m_audioPosition = base.gameObject;
		}
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(m_zone.reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audioPosition, akAuxSendArray, 1u);
		List<Vector2> list = new List<Vector2>();
		m_animFrames[0].GetPhysicsShape(0, list);
		m_physicsClosed = list.ToArray();
		m_animFrames[m_animFrames.Length - 1].GetPhysicsShape(0, list);
		m_physicsOpen = list.ToArray();
		if ((bool)m_drawers)
		{
			m_drawers.EnableDrawers(_value: false);
		}
		m_nodes = ((m_polygon != null) ? m_zone.GetAllGridsWithinPolygon(m_polygon) : new int[0]);
		m_zone.SetGridActive(m_nodes, _active: false);
		m_nodesOpen = ((m_polygonOpen != null) ? m_zone.GetAllGridsWithinPolygon(m_polygonOpen) : new int[0]);
		if (m_depthChangeOnOpening)
		{
			m_startPosition = base.transform.localPosition;
		}
	}

	private void Update()
	{
		int num = 0;
		bool flag = false;
		if (m_moving)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, m_lerpTarget, Time.deltaTime * m_doorSpeed);
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
			}
			int num2 = m_animFrames.Length - 1;
			num = ((m_lerpTarget > m_lerp) ? Mathf.CeilToInt(m_motionOpen.Evaluate(m_lerp) * (float)num2) : Mathf.FloorToInt(m_motionClose.Evaluate(m_lerp) * (float)num2));
			flag = true;
		}
		else if (m_bounce)
		{
			float bounceLerp = m_bounceLerp;
			m_bounceLerp = Mathf.MoveTowards(m_bounceLerp, 1f, Time.deltaTime / Mathf.Max(m_bounceFraction, 0.0625f * m_doorSpeed) * m_doorSpeed * 0.4f);
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
				m_drawers.Impact();
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
				}
			}
			int num3 = m_animFrames.Length - 1;
			num = num3 - Mathf.CeilToInt(m_motionBounce.Evaluate(m_bounceLerp) * (float)num3 * m_bounceFraction);
			flag = true;
		}
		if (!flag)
		{
			return;
		}
		GetComponent<SpriteRenderer>().sprite = m_animFrames[num];
		if ((bool)m_spriteMask && (m_spriteMaskOnOpen || m_moving))
		{
			m_spriteMask.sprite = ((m_spriteMaskOnOpen || num < m_animFrames.Length - 1) ? MaskFrame(num) : null);
		}
		if (m_depthChangeOnOpening)
		{
			Vector3 startPosition = m_startPosition;
			if (num > 0)
			{
				startPosition.z = m_depthChange;
			}
			base.transform.localPosition = startPosition;
		}
	}

	private Sprite MaskFrame(int _frame)
	{
		if (m_spriteMaskFrames != null && m_spriteMaskFrames.Length > _frame && m_spriteMaskFrames[_frame] != null)
		{
			return m_spriteMaskFrames[_frame];
		}
		return m_animFrames[_frame];
	}

	public bool Check()
	{
		if (m_lerpTarget > 0f)
		{
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
			return true;
		}
		return false;
	}

	public int Use()
	{
		if (!m_moving && !m_bounce)
		{
			if (m_lerpTarget == 0f)
			{
				m_moving = true;
				m_lerpTarget = 1f;
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
				vibrationScript.Trigger(m_vibrationTrigger);
				GetComponent<PolygonCollider2D>().points = m_physicsOpen;
				if ((bool)m_drawers)
				{
					m_drawers.EnableDrawers(_value: true);
				}
				m_zone.SetGridActive(m_nodes, _active: true);
				m_zone.SetItemsActive(m_nodes);
				m_zone.SetGridActive(m_nodesOpen, _active: false);
				m_zone.SetItemsActive(m_nodesOpen);
				return m_usableIndex;
			}
			AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
			AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
			m_audioClosePlayed = false;
			vibrationScript.Trigger(m_vibrationTrigger);
			if (!m_drawers || m_drawers.CheckClosed())
			{
				m_moving = true;
				m_lerpTarget = 0f;
				GetComponent<PolygonCollider2D>().points = m_physicsClosed;
				if ((bool)m_drawers)
				{
					m_drawers.EnableDrawers(_value: false);
				}
				m_zone.SetGridActive(m_nodes, _active: false);
				m_zone.SetItemsActive(m_nodes);
				m_zone.SetGridActive(m_nodesOpen, _active: true);
				m_zone.SetItemsActive(m_nodesOpen);
				return m_usableIndex;
			}
			m_bounce = true;
			m_bounceLerp = 0f;
		}
		return -1;
	}

	private void OnDrawGizmosSelected()
	{
		if (m_animFrames != null && m_animFrames.Length != 0)
		{
			Vector3 localPosition = base.transform.localPosition;
			if (m_depthChangeOnOpening)
			{
				localPosition.z = m_depthChange;
			}
			List<Vector2> list = new List<Vector2>();
			m_animFrames[m_animFrames.Length - 1].GetPhysicsShape(0, list);
			Gizmos.color = Color.cyan;
			for (int i = 0; i < list.Count; i++)
			{
				Gizmos.DrawLine(localPosition + (Vector3)list[i], localPosition + (Vector3)list[(i + 1) % list.Count]);
			}
		}
		if (m_zone != null)
		{
			Gizmos.color = Color.red;
			for (int j = 0; j < m_nodes.Length; j++)
			{
				Gizmos.DrawWireSphere(m_zone.GetGrid(m_nodes[j]), 0.025f);
			}
			Gizmos.color = Color.blue;
			for (int k = 0; k < m_nodesOpen.Length; k++)
			{
				Gizmos.DrawWireSphere(m_zone.GetGrid(m_nodesOpen[k]), 0.025f);
			}
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
				m_moving = true;
				m_lerpTarget = 1f;
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
			}
			else
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				m_audioClosePlayed = false;
				m_moving = true;
				m_lerpTarget = 0f;
			}
		}
		else
		{
			SetSaveData(m_lerpTarget == 0f);
		}
		return true;
	}

	public void SetSaveData(bool _open)
	{
		m_moving = false;
		m_bounce = false;
		m_lerp = (_open ? 1f : 0f);
		m_lerpTarget = (_open ? 1f : 0f);
		int num = (_open ? (m_animFrames.Length - 1) : 0);
		GetComponent<SpriteRenderer>().sprite = m_animFrames[num];
		GetComponent<PolygonCollider2D>().points = (_open ? m_physicsOpen : m_physicsClosed);
		if ((bool)m_spriteMask)
		{
			m_spriteMask.sprite = ((!_open || m_spriteMaskOnOpen) ? MaskFrame(num) : null);
		}
		if ((bool)m_drawers)
		{
			m_drawers.EnableDrawers(_open);
		}
		m_zone.SetGridActive(m_nodes, _open);
		m_zone.SetItemsActive(m_nodes);
		m_zone.SetGridActive(m_nodesOpen, !_open);
		m_zone.SetItemsActive(m_nodesOpen);
		if (m_depthChangeOnOpening)
		{
			Vector3 startPosition = m_startPosition;
			if (num > 0)
			{
				startPosition.z = m_depthChange;
			}
			base.transform.localPosition = startPosition;
		}
	}
}
