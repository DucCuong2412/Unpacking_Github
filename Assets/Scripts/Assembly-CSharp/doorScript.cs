using System;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PolygonCollider2D))]
public class doorScript : MonoBehaviour
{
	public enum doorType
	{
		splits = 0,
		simpleDepth = 1,
		mask = 2
	}

	[Serializable]
	public class doorFrame
	{
		public Sprite m_frame;

		public Sprite m_frameShadow;

		public Vector2[] m_nodePositions;

		private int[] m_nodeIndexes;

		private float m_depth = float.PositiveInfinity;

		public float m_depthOverride;

		public Vector2[] m_splits;

		public float depth => m_depth;

		public int[] indexes => m_nodeIndexes;

		public bool hasGrids => m_nodeIndexes.Length != 0;

		public doorFrame(Sprite _frame, Sprite _shadow = null)
		{
			m_frame = _frame;
			m_frameShadow = _shadow;
			m_nodePositions = new Vector2[0];
			m_nodeIndexes = new int[0];
		}

		public void matchIndexes(zoneScript _zone, float _depth)
		{
			m_depth = _depth;
			m_nodeIndexes = new int[m_nodePositions.Length];
			for (int i = 0; i < m_nodePositions.Length; i++)
			{
				m_nodeIndexes[i] = _zone.GetClosestGridNoCheck(m_nodePositions[i]);
			}
		}

		public void matchIndexesSimple(zoneScript _zone, float _depth)
		{
			m_depth = _depth;
			m_nodeIndexes = new int[m_nodePositions.Length];
			for (int i = 0; i < m_nodePositions.Length; i++)
			{
				m_nodeIndexes[i] = _zone.GetClosestGridNoCheck(m_nodePositions[i]);
			}
		}

		public int calculateSplits(zoneScript _zone, float _xPosition)
		{
			if (m_nodePositions.Length == 0)
			{
				m_splits = new Vector2[0];
				return 0;
			}
			List<int> list = new List<int>();
			for (int i = 0; i < m_nodePositions.Length; i++)
			{
				bool flag = false;
				for (int j = 0; j < list.Count; j++)
				{
					if (Mathf.Approximately(m_nodePositions[i].x, m_nodePositions[list[j]].x))
					{
						flag = true;
						if (m_nodePositions[i].y < m_nodePositions[list[j]].y)
						{
							list[j] = i;
						}
					}
				}
				if (!flag)
				{
					list.Add(i);
				}
			}
			for (int k = 0; k < list.Count - 1; k++)
			{
				for (int l = 0; l < list.Count - k - 1; l++)
				{
					if (m_nodePositions[list[l]].x > m_nodePositions[list[l + 1]].x)
					{
						int value = list[l];
						list[l] = list[l + 1];
						list[l + 1] = value;
					}
				}
			}
			float y = m_nodePositions[list[0]].y;
			for (int m = 1; m < list.Count; m++)
			{
				if (!Mathf.Approximately(m_nodePositions[list[m]].y, y))
				{
					y = m_nodePositions[list[m]].y;
					continue;
				}
				list.RemoveAt(m);
				m--;
			}
			m_splits = new Vector2[list.Count - 1];
			for (int n = 0; n < m_splits.Length; n++)
			{
				m_splits[n] = new Vector2(m_nodePositions[list[n]].x - _xPosition, _zone.GetGridDepth(m_nodeIndexes[list[n]]) - 0.045f);
				if (m_nodePositions[list[n]].y < m_nodePositions[list[n + 1]].y)
				{
					m_splits[n].x += 0.14f;
				}
			}
			return list.Count;
		}
	}

	private zoneScript m_zone;

	[Header("Audio")]
	public string m_audioName = "cupboard";

	public float m_audioOpen = 1f;

	private bool m_audioOpenPlayed;

	public float m_audioClose;

	private bool m_audioClosePlayed;

	[Space(15f)]
	public GameObject m_audioPosition;

	public float m_doorSpeed = 5f;

	public int m_startHeight;

	public int m_height;

	public float m_openDepth;

	public float m_openFinishDepth;

	public SpriteMask m_mask;

	public bool m_maskOpenOnly;

	private Vector3 m_basePosition;

	public Transform m_additional;

	private SpriteRenderer[] m_renderers;

	public SpriteRenderer m_shadowRenderer;

	public vibrationScript.moment m_vibrationTrigger;

	public vibrationScript.moment m_vibrationCollision = vibrationScript.moment.collision;

	public doorType m_type;

	public doorFrame[] m_frames;

	public float m_depthBoostOnOpen;

	public float m_depthBoostRatio;

	public float m_depthBoostExtra;

	public Sprite[] m_animFrames;

	public AnimationCurve m_motion;

	public bool m_useReverseCurve;

	public AnimationCurve m_motionReverse;

	public AnimationCurve m_motionBounce;

	public PolygonCollider2D m_colliderOpen;

	private Vector2[] m_pointsClosed;

	private Vector2[] m_pointsOpen;

	public groundNodeDefineScript m_sweepNode;

	public groundNodeDefineScript m_openNode;

	private bool m_moving;

	private float m_lerp;

	private float m_lerpTarget;

	private bool m_bounce;

	private bool m_bounceOpen;

	private float m_bounceLerp;

	private float m_bounceFraction = 1f;

	private int m_bounceFrame = -1;

	public drawerManagerScript m_drawerBlocker;

	public doorScript m_doorBlocker;

	public drawerManagerScript m_drawerAbove;

	public PolygonCollider2D m_polygon;

	private int[] m_nodes;

	public PolygonCollider2D m_polygonOpen;

	private int[] m_nodesOpen;

	private int m_usableIndex = -1;

	public int m_sizeHint;

	public bool isOpen => m_lerpTarget == 1f;

	public void Register(zoneScript _zone, int _usableIndex)
	{
		m_usableIndex = _usableIndex;
		m_zone = _zone;
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(m_zone.reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_audioPosition, akAuxSendArray, 1u);
		if ((bool)m_sweepNode)
		{
			m_sweepNode.Register(m_zone);
		}
		if ((bool)m_openNode)
		{
			m_openNode.Register(m_zone);
		}
		if (m_frames == null || m_frames.Length == 0)
		{
			m_frames = new doorFrame[m_animFrames.Length];
			for (int i = 0; i < m_animFrames.Length; i++)
			{
				m_frames[i] = new doorFrame(m_animFrames[i]);
			}
		}
		m_basePosition = base.transform.localPosition;
		float z = m_basePosition.z;
		int num = 0;
		for (int j = 0; j < m_frames.Length; j++)
		{
			float num2 = (((float)j >= m_depthBoostRatio * (float)m_frames.Length) ? m_depthBoostOnOpen : 0f);
			if (m_type == doorType.splits)
			{
				m_frames[j].matchIndexes(m_zone, z + num2);
				num = Mathf.Max(num, m_frames[j].calculateSplits(m_zone, base.transform.position.x));
			}
			else if (m_type == doorType.simpleDepth)
			{
				m_frames[j].matchIndexesSimple(m_zone, z + m_frames[j].m_depthOverride);
			}
			else
			{
				_ = m_type;
				_ = 2;
			}
		}
		m_renderers = new SpriteRenderer[num + 1];
		m_renderers[0] = GetComponent<SpriteRenderer>();
		if (num > 0)
		{
			Material sharedMaterial = UnityEngine.Object.FindObjectOfType<gameScript>().m_materials[1];
			m_renderers[0].sharedMaterial = sharedMaterial;
			for (int k = 1; k < m_renderers.Length; k++)
			{
				GameObject gameObject = new GameObject(base.gameObject.name + "slice" + k);
				gameObject.transform.parent = base.transform;
				gameObject.transform.localPosition = Vector3.zero;
				m_renderers[k] = gameObject.AddComponent<SpriteRenderer>();
				m_renderers[k].sharedMaterial = sharedMaterial;
				m_renderers[k].enabled = false;
			}
		}
		m_pointsClosed = GetComponent<PolygonCollider2D>().points;
		if (m_colliderOpen != null)
		{
			m_pointsOpen = m_colliderOpen.points;
		}
		else if (m_frames.Length != 0)
		{
			List<Vector2> list = new List<Vector2>();
			m_frames[m_frames.Length - 1].m_frame.GetPhysicsShape(0, list);
			m_pointsOpen = list.ToArray();
		}
		else
		{
			m_pointsOpen = new Vector2[0];
		}
		m_nodes = ((m_polygon != null) ? m_zone.GetAllGridsWithinPolygon(m_polygon) : new int[0]);
		m_zone.SetGridActive(m_nodes, _active: false);
		m_nodesOpen = ((m_polygonOpen != null) ? m_zone.GetAllGridsWithinPolygon(m_polygonOpen) : new int[0]);
		if (m_frames.Length != 0)
		{
			SetFrame(0);
		}
	}

	private void Update()
	{
		int frame = 0;
		bool flag = false;
		if (m_moving)
		{
			m_lerp = Mathf.MoveTowards(m_lerp, m_lerpTarget, Time.deltaTime * m_doorSpeed);
			if (m_lerpTarget > 0f)
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
			float num = ((m_lerpTarget > 0.5f || !m_useReverseCurve) ? m_motion.Evaluate(m_lerp) : m_motionReverse.Evaluate(m_lerp));
			int num2 = m_frames.Length - 1;
			frame = ((m_lerpTarget > m_lerp) ? Mathf.CeilToInt(num * (float)num2) : Mathf.FloorToInt(num * (float)num2));
			flag = true;
		}
		else if (m_bounce)
		{
			float bounceLerp = m_bounceLerp;
			m_bounceLerp = Mathf.MoveTowards(m_bounceLerp, 1f, Time.deltaTime / Mathf.Max(m_bounceFraction, 0.0625f * m_doorSpeed) * m_doorSpeed * 0.4f);
			if (bounceLerp < 0.25f && m_bounceLerp >= 0.25f)
			{
				if (m_bounceOpen)
				{
					AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				}
				else
				{
					AkSoundEngine.PostEvent(m_audioName + "_close_closing_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				}
				vibrationScript.Trigger(m_vibrationCollision);
				itemScript[] itemsOnGrids = m_zone.GetItemsOnGrids(m_frames[m_bounceFrame].indexes, m_startHeight);
				if (itemsOnGrids.Length != 0)
				{
					gameScript component = Camera.main.GetComponent<gameScript>();
					for (int i = 0; i < itemsOnGrids.Length; i++)
					{
						component.AudioPlace(itemsOnGrids[i], _collision: true);
						component.BounceStart(itemsOnGrids[i]);
					}
				}
			}
			else if (m_bounceLerp == 1f)
			{
				m_bounce = false;
				if (m_bounceOpen)
				{
					AkSoundEngine.PostEvent(m_audioName + "_close_closing_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_close_end", m_audioPosition);
				}
				else
				{
					AkSoundEngine.PostEvent(m_audioName + "_open_opening_stop", m_audioPosition);
					AkSoundEngine.PostEvent(m_audioName + "_open_end", m_audioPosition);
				}
			}
			int num3 = m_frames.Length - 1;
			frame = ((!m_bounceOpen) ? (num3 - Mathf.FloorToInt(m_motionBounce.Evaluate(m_bounceLerp) * (float)num3 * m_bounceFraction)) : Mathf.CeilToInt(m_motionBounce.Evaluate(m_bounceLerp) * (float)num3 * m_bounceFraction));
			flag = true;
		}
		if (flag)
		{
			SetFrame(frame);
		}
	}

	private void SetFrame(int _frame)
	{
		if (_frame >= m_frames.Length)
		{
			Debug.LogWarning(m_zone.name + " | " + base.name + " | wants frame " + _frame + " but array is only " + m_frames.Length);
			return;
		}
		Vector3 basePosition = m_basePosition;
		if (_frame != 0)
		{
			basePosition.z = m_frames[_frame - 1].depth;
		}
		base.transform.localPosition = basePosition;
		int num = ((_frame != 0) ? m_frames[_frame].m_splits.Length : 0);
		for (int i = 0; i < m_renderers.Length; i++)
		{
			MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
			if (i <= num)
			{
				m_renderers[i].enabled = true;
				m_renderers[i].sprite = m_frames[_frame].m_frame;
				m_renderers[i].GetPropertyBlock(materialPropertyBlock);
				if (i == 0)
				{
					materialPropertyBlock.SetFloat("_SplitStart", -10f);
				}
				else
				{
					materialPropertyBlock.SetFloat("_SplitStart", m_frames[_frame].m_splits[i - 1].x);
					Vector3 basePosition2 = m_basePosition;
					basePosition2.z = m_frames[_frame].m_splits[i - 1].y + m_depthBoostExtra;
					basePosition2.x = base.transform.position.x;
					m_renderers[i].transform.position = basePosition2;
				}
				if (i == num)
				{
					materialPropertyBlock.SetFloat("_SplitEnd", 10f);
				}
				else
				{
					materialPropertyBlock.SetFloat("_SplitEnd", m_frames[_frame].m_splits[i].x);
				}
				m_renderers[i].SetPropertyBlock(materialPropertyBlock);
			}
			else
			{
				m_renderers[i].enabled = false;
			}
		}
		if (m_shadowRenderer != null)
		{
			m_shadowRenderer.sprite = m_frames[_frame].m_frameShadow;
		}
		if (m_mask != null)
		{
			m_mask.sprite = ((_frame == 0 || (m_maskOpenOnly && _frame < m_frames.Length - 1)) ? null : m_frames[_frame].m_frame);
		}
	}

	public bool TryClose(ref List<int> _useList)
	{
		if ((double)m_lerpTarget != 0.0)
		{
			return Use(ref _useList) > -1;
		}
		return true;
	}

	public int Use(ref List<int> _useList)
	{
		if (m_frames.Length == 0)
		{
			return -1;
		}
		if (!m_moving && !m_bounce)
		{
			int num = TrySpace(ref _useList);
			if (m_lerpTarget == 0f)
			{
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_audioOpenPlayed = false;
				vibrationScript.Trigger(m_vibrationTrigger);
				if (num == -1)
				{
					m_moving = true;
					m_lerpTarget = 1f;
					GetComponent<PolygonCollider2D>().points = m_pointsOpen;
					m_zone.SetGridActive(m_nodes, _active: true);
					m_zone.SetItemsActive(m_nodes);
					m_zone.SetGridActive(m_nodesOpen, _active: false);
					m_zone.SetItemsActive(m_nodesOpen);
					_useList.Add(m_usableIndex);
					return m_usableIndex;
				}
				m_bounce = true;
				m_bounceOpen = true;
				m_bounceLerp = 0f;
				m_bounceFrame = num;
				m_bounceFraction = Mathf.InverseLerp(0f, m_frames.Length, m_bounceFrame);
			}
			else
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
				m_audioClosePlayed = false;
				vibrationScript.Trigger(m_vibrationTrigger);
				if (num == -1)
				{
					m_moving = true;
					m_lerpTarget = 0f;
					GetComponent<PolygonCollider2D>().points = m_pointsClosed;
					m_zone.SetGridActive(m_nodes, _active: false);
					m_zone.SetItemsActive(m_nodes);
					m_zone.SetGridActive(m_nodesOpen, _active: true);
					m_zone.SetItemsActive(m_nodesOpen);
					_useList.Add(m_usableIndex);
					return m_usableIndex;
				}
				m_bounce = true;
				m_bounceOpen = false;
				m_bounceLerp = 0f;
				m_bounceFrame = num;
				m_bounceFraction = Mathf.InverseLerp(m_frames.Length, 0f, m_bounceFrame + 2);
			}
		}
		return -1;
	}

	public void RefreshGridSize()
	{
		if (m_lerpTarget > 0f)
		{
			m_zone.SetGridSize(m_frames[m_frames.Length - 1].indexes, m_startHeight);
		}
	}

	public int TrySpace(ref List<int> _useList)
	{
		bool flag = m_lerpTarget == 0f;
		if ((bool)m_drawerBlocker)
		{
			m_drawerBlocker.TryClose(ref _useList);
		}
		if ((bool)m_doorBlocker && !m_doorBlocker.TryClose(ref _useList))
		{
			return 1;
		}
		if (!flag)
		{
			m_zone.SetGridSize(m_frames[m_frames.Length - 1].indexes, 99);
			if ((bool)m_drawerAbove)
			{
				m_drawerAbove.RefreshGridSize();
			}
		}
		if (flag)
		{
			for (int i = 0; i < m_frames.Length; i++)
			{
				if (m_frames[i].hasGrids && m_zone.CheckGridHeight(m_frames[i].indexes, m_startHeight, m_height))
				{
					return i;
				}
			}
		}
		else
		{
			for (int num = m_frames.Length - 2; num > -1; num--)
			{
				if (m_frames[num].hasGrids && m_zone.CheckGridHeight(m_frames[num].indexes, m_startHeight, m_height))
				{
					m_zone.SetGridSize(m_frames[m_frames.Length - 1].indexes, m_startHeight);
					return num;
				}
			}
		}
		if (flag)
		{
			m_zone.SetGridSize(m_frames[m_frames.Length - 1].indexes, m_startHeight);
		}
		return -1;
	}

	private void OnDrawGizmosSelected()
	{
		if ((bool)m_sweepNode)
		{
			Gizmos.color = Color.cyan;
			Vector3 position = m_sweepNode.transform.position;
			Vector3 vector = Vector3.up * 0.17f * m_startHeight;
			Vector3 vector2 = new Vector3(0.14f, 0.07f);
			Vector3 vector3 = new Vector3(-0.14f, 0.07f);
			Vector3 vector4 = position + -vector2 * 0.5f + -vector3 * 0.5f;
			Vector3 vector5 = position + vector2 * ((float)m_sweepNode.m_xWidth - 0.5f) + -vector3 * 0.5f;
			Vector3 vector6 = position + vector2 * ((float)m_sweepNode.m_xWidth - 0.5f) + vector3 * ((float)m_sweepNode.m_yWidth - 0.5f);
			Vector3 vector7 = position + -vector2 * 0.5f + vector3 * ((float)m_sweepNode.m_yWidth - 0.5f);
			if (m_startHeight > 0)
			{
				Gizmos.DrawLine(vector4 + vector, vector5 + vector);
				Gizmos.DrawLine(vector5 + vector, vector6 + vector);
				Gizmos.DrawLine(vector6 + vector, vector7 + vector);
				Gizmos.DrawLine(vector7 + vector, vector4 + vector);
			}
			if (m_height > 0)
			{
				vector = Vector3.up * 0.17f * m_height;
				Gizmos.DrawLine(vector4 + vector, vector5 + vector);
				Gizmos.DrawLine(vector5 + vector, vector6 + vector);
				Gizmos.DrawLine(vector6 + vector, vector7 + vector);
				Gizmos.DrawLine(vector7 + vector, vector4 + vector);
			}
		}
		Sprite sprite = GetComponent<SpriteRenderer>().sprite;
		for (int i = 0; i < m_frames.Length - 1; i++)
		{
			if (m_frames[i + 1].m_frame == sprite)
			{
				Gizmos.color = Color.red;
				for (int j = 0; j < m_frames[i].m_splits.Length - 1; j++)
				{
					Vector3 vector8 = Vector2.right * (m_frames[i].m_splits[j].x + base.transform.position.x);
					vector8.z = m_frames[i].m_splits[j].y;
					Gizmos.DrawLine(vector8 - Vector3.up * 2f, vector8 + Vector3.up * 2f);
				}
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
				AkSoundEngine.PostEvent(m_audioName + "_open_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_open_opening", m_audioPosition);
				m_moving = true;
				m_lerpTarget = 1f;
			}
			else
			{
				AkSoundEngine.PostEvent(m_audioName + "_close_start", m_audioPosition);
				AkSoundEngine.PostEvent(m_audioName + "_close_closing", m_audioPosition);
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
		if (m_frames.Length == 0)
		{
			Debug.LogWarning(m_zone.name + " | " + base.name + " | m_frame array length " + m_frames.Length);
			return;
		}
		m_moving = false;
		m_bounce = false;
		int frame = (_open ? (m_frames.Length - 1) : 0);
		m_lerp = (_open ? 1f : 0f);
		m_lerpTarget = (_open ? 1f : 0f);
		GetComponent<PolygonCollider2D>().points = (_open ? m_pointsOpen : m_pointsClosed);
		SetFrame(frame);
		if ((bool)m_additional)
		{
			m_additional.gameObject.SetActive(_open);
		}
		m_zone.SetGridSize(m_frames[m_frames.Length - 1].indexes, _open ? m_startHeight : 99);
		if (!_open && (bool)m_drawerAbove)
		{
			m_drawerAbove.RefreshGridSize();
		}
		m_zone.SetGridActive(m_nodes, _open);
		m_zone.SetItemsActive(m_nodes);
		m_zone.SetGridActive(m_nodesOpen, !_open);
		m_zone.SetItemsActive(m_nodesOpen);
	}
}
