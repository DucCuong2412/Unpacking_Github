using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class drawerScript : MonoBehaviour
{
	private drawerManagerScript m_manager;

	[Header("WWise Events")]
	public string m_audioName = "drawer";

	private GameObject m_audioPosition;

	public float m_audioOpen = 1f;

	private bool m_audioOpenPlayed;

	public float m_audioClose;

	private bool m_audioClosePlayed;

	[Space(15f)]
	public int m_height;

	public bool m_boost;

	public bool m_inFront;

	private Vector3 m_basePosition;

	private Vector2 m_movement = Vector2.zero;

	public int m_drawRange = 36;

	private int m_drawPosition;

	public AnimationCurve m_motion;

	public bool m_useReverseCurve;

	public AnimationCurve m_motionReverse;

	public AnimationCurve m_motionBounce;

	public Vector2 m_motionSpeed = new Vector2(3f, 3f);

	private float m_lerp;

	private float m_lerpTarget;

	private bool m_moving;

	private bool m_bounce;

	private float m_bounceLerp;

	private float m_bounceDistance = 1f;

	private itemScript m_bounceHit;

	private bool m_impact;

	private float m_impactTime;

	public AnimationCurve m_impactCurve;

	public extraNodesScript[] m_nodes;

	public Collider2D m_blocker;

	private List<itemScript> m_items = new List<itemScript>();

	private int m_usableIndex = -1;

	public bool isActive => m_lerp == 1f;

	public bool isClosed
	{
		get
		{
			if ((double)m_lerpTarget == 0.0 && !m_moving)
			{
				return !m_bounce;
			}
			return false;
		}
	}

	public bool isOpen => m_lerpTarget == 1f;

	public int drawHeight
	{
		get
		{
			if (!(m_lerpTarget > 0f))
			{
				return 99;
			}
			return m_height;
		}
	}

	public void AddItem(itemScript _item)
	{
		m_items.Add(_item);
		if ((double)m_lerp < 1.0)
		{
			_item.ActivateStack(_active: false);
		}
	}

	public void RemoveItem(itemScript _item)
	{
		m_items.Remove(_item);
	}

	public void ClearItems()
	{
		m_items.Clear();
	}

	public Vector3 GetOffset()
	{
		return base.transform.localPosition - m_basePosition - new Vector3((float)m_drawRange * m_movement.x, (float)m_drawRange * m_movement.y, 0f);
	}

	public GameObject Register(drawerManagerScript _manager, zoneScript.direction _direction, int _usableIndex)
	{
		m_usableIndex = _usableIndex;
		m_manager = _manager;
		m_basePosition = base.transform.localPosition;
		if (_direction == zoneScript.direction.xAxis)
		{
			m_movement = new Vector2(-0.02f, -0.01f);
		}
		else
		{
			m_movement = new Vector2(0.02f, -0.01f);
		}
		extraNodesScript[] nodes = m_nodes;
		for (int i = 0; i < nodes.Length; i++)
		{
			nodes[i].AddNodes(_manager.zone, new Vector3((float)m_drawRange * m_movement.x, (float)m_drawRange * m_movement.y, 0f), base.transform, m_height * 15 + (m_boost ? 100 : 0));
		}
		ActivateNodes(_active: false);
		m_blocker.enabled = false;
		m_audioPosition = new GameObject("audio");
		m_audioPosition.transform.parent = base.transform;
		m_audioPosition.transform.localPosition = Vector3.forward * (0f - base.transform.position.z);
		return m_audioPosition;
	}

	public void ActivateNodes(bool _active)
	{
		extraNodesScript[] nodes = m_nodes;
		for (int i = 0; i < nodes.Length; i++)
		{
			nodes[i].ActivateNodes(m_manager.zone, _active);
		}
		foreach (itemScript item in m_items)
		{
			if (item != null)
			{
				item.ActivateStack(_active);
			}
			else
			{
				Debug.LogWarning(base.name + " has a null Item!");
			}
		}
	}

	public bool ManualUpdate()
	{
		if (m_moving)
		{
			bool flag = m_lerpTarget > 0.5f;
			m_lerp = Mathf.MoveTowards(m_lerp, m_lerpTarget, Time.deltaTime * (flag ? m_motionSpeed.x : m_motionSpeed.y));
			if (flag)
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
				if (m_lerp == 0f)
				{
					m_blocker.enabled = false;
				}
				m_manager.EvaulateOpenDrawers();
			}
			float num = ((!m_useReverseCurve || flag) ? m_motion.Evaluate(m_lerp) : m_motionReverse.Evaluate(m_lerp));
			m_drawPosition = Mathf.RoundToInt((float)m_drawRange * num);
		}
		else if (m_bounce)
		{
			float bounceLerp = m_bounceLerp;
			m_bounceLerp = Mathf.MoveTowards(m_bounceLerp, 1f, Time.deltaTime / Mathf.Max(m_bounceDistance, 0.125f));
			if (bounceLerp < 0.2f && m_bounceLerp >= 0.2f)
			{
				if (m_bounceHit != null)
				{
					m_manager.AudioHit(m_bounceHit);
				}
				AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
			}
			else if (m_bounceLerp == 1f)
			{
				m_bounce = false;
				AkSoundEngine.PostEvent(m_audioName + "_close_closing_stop", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_end", m_audioPosition);
			}
			m_drawPosition = Mathf.RoundToInt((float)m_drawRange * m_bounceDistance * m_motionBounce.Evaluate(m_bounceLerp));
		}
		else if (m_impact)
		{
			m_impactTime += Time.deltaTime * 6f;
			m_drawPosition = Mathf.RoundToInt((float)m_drawRange + m_impactCurve.Evaluate(m_impactTime) * 1f);
			if (m_impactTime >= 1f)
			{
				m_impact = false;
			}
		}
		base.transform.localPosition = m_basePosition + new Vector3((float)m_drawPosition * m_movement.x, (float)m_drawPosition * m_movement.y, 0f);
		if (!(m_lerp > 0f))
		{
			return m_bounce;
		}
		return true;
	}

	public void Impact(float _offset)
	{
		if (m_lerpTarget == 1f)
		{
			m_impact = true;
			m_impactTime = _offset;
		}
	}

	public void TryClose(ref List<int> _useList)
	{
		if (m_lerpTarget != 0f)
		{
			Use(ref _useList);
		}
	}

	public int Use(ref List<int> _useList)
	{
		if (!m_moving && !m_bounce)
		{
			m_impact = false;
			if (m_lerpTarget == 0f)
			{
				int num = 0;
				if (m_nodes.Length != 0 && m_nodes[0].m_size > 1)
				{
					num = m_nodes[0].m_size - 1;
				}
				zoneScript.CheckResult checkResult = m_manager.TrySpace(m_height - num, ref _useList);
				if (!checkResult.result)
				{
					m_moving = true;
					m_lerpTarget = 1f;
					m_blocker.enabled = true;
				}
				else
				{
					m_bounce = true;
					m_bounceLerp = 0f;
					m_bounceDistance = Mathf.InverseLerp(3.35f, -1f, Mathf.Min(checkResult.value, 3f));
					m_bounceHit = checkResult.item;
				}
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
				vibrationScript.Trigger(m_manager.m_vibrationTrigger);
			}
			else
			{
				m_moving = true;
				m_lerpTarget = 0f;
				m_manager.ClearSpace();
				ActivateNodes(_active: false);
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				m_audioClosePlayed = false;
				vibrationScript.Trigger(m_manager.m_vibrationTrigger);
			}
			if (m_moving)
			{
				_useList.Add(m_usableIndex);
			}
			if (!m_moving)
			{
				return -1;
			}
			return m_usableIndex;
		}
		return -1;
	}

	public bool PlaybackUse(int _index, bool _animate)
	{
		if (m_usableIndex != _index)
		{
			return false;
		}
		if (_animate)
		{
			m_moving = true;
			if (m_lerpTarget == 0f)
			{
				m_lerpTarget = 1f;
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
			}
			else
			{
				m_lerpTarget = 0f;
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				m_audioClosePlayed = false;
			}
		}
		else
		{
			SetSaveData(m_lerpTarget == 0f);
		}
		return true;
	}

	public bool PlaybackMoving()
	{
		return m_moving;
	}

	private void OnDrawGizmosSelected()
	{
		if (!Application.isPlaying && base.transform.parent != null && base.transform.parent.GetComponent<drawerManagerScript>() != null)
		{
			Vector2 vector = new Vector2((base.transform.parent.GetComponent<drawerManagerScript>().m_direction == zoneScript.direction.xAxis) ? (-0.02f) : 0.02f, -0.01f);
			Vector2[] points = GetComponent<PolygonCollider2D>().points;
			Vector3 vector2 = (Vector2)base.transform.position + vector * m_drawRange;
			Gizmos.color = Color.cyan;
			for (int i = 0; i < points.Length; i++)
			{
				Gizmos.DrawLine((Vector3)points[i] + vector2, (Vector3)points[(i + 1) % points.Length] + vector2);
			}
		}
	}

	public void SetSaveData(bool _open)
	{
		m_moving = false;
		m_bounce = false;
		m_lerp = (_open ? 1f : 0f);
		m_lerpTarget = (_open ? 1f : 0f);
		m_drawPosition = Mathf.RoundToInt((float)m_drawRange * m_motion.Evaluate(m_lerp));
		base.transform.localPosition = m_basePosition + new Vector3((float)m_drawPosition * m_movement.x, (float)m_drawPosition * m_movement.y, 0f);
		ActivateNodes(_open);
		m_blocker.enabled = _open;
	}
}
