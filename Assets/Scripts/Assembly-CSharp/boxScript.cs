using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class boxScript : MonoBehaviour
{
	[Serializable]
	public struct Art
	{
		public Sprite m_art;

		public Sprite m_artFlipped;

		public Sprite m_shadow;

		public Sprite m_mask;

		public Color m_contentTint;
	}

	private enum boxAnimMode
	{
		none = 0,
		open = 1,
		foldup = 2
	}

	protected class boxedItem
	{
		public itemScript m_item;

		public int m_itemID;

		public int m_variant;

		public int m_state;

		public bool m_zonePacked;

		private LineRenderer m_line;

		public boxedItem(itemScript _item, bool _zonePacked)
		{
			m_item = _item;
			m_itemID = Camera.main.GetComponent<gameScript>().GetItemIndex(_item.gameObject.name.Replace("(Clone)", ""));
			m_state = _item.GetState();
			m_zonePacked = _zonePacked;
		}

		public boxedItem(itemScript _item, int _itemID, int _variant, int _state, bool _zonePacked)
		{
			m_item = _item;
			m_itemID = _itemID;
			m_variant = _variant;
			m_state = _state;
			m_zonePacked = _zonePacked;
		}

		public void AddLine(Vector2 _boxPosition, bool _selected)
		{
			if (m_line == null)
			{
				m_line = UnityEngine.Object.Instantiate(Camera.main.GetComponent<gameScript>().m_linePrefab).GetComponent<LineRenderer>();
			}
			m_line.SetPosition(0, _boxPosition);
			Vector2 vector = (m_zonePacked ? (_boxPosition + Vector2.up * -0.15f) : ((Vector2)m_item.transform.position));
			m_line.SetPosition(1, vector);
			m_line.startColor = (_selected ? new Color32(128, 128, byte.MaxValue, 128) : new Color32(55, 55, byte.MaxValue, 96));
			m_line.endColor = (_selected ? new Color32(196, 196, byte.MaxValue, 196) : new Color32(55, 55, byte.MaxValue, 96));
			m_line.widthMultiplier = (_selected ? 0.05f : 0.025f);
		}

		public void RemoveLine()
		{
			if (m_line != null)
			{
				UnityEngine.Object.Destroy(m_line.gameObject);
			}
		}
	}

	public struct boxContent
	{
		public int id;

		public int variant;

		public int state;

		public boxContent(int _id, int _variant, int _state)
		{
			id = _id;
			variant = _variant;
			state = _state;
		}
	}

	private zoneScript m_zone;

	public SpriteRenderer m_art;

	private SpriteRenderer m_artSplit;

	public SpriteRenderer m_shadow;

	private SpriteMask m_mask;

	private SpriteMask m_maskShadow;

	private LineRenderer m_packOutline;

	private Transform m_textPivot;

	private static bool s_drawText;

	public Art[] m_artOpenAnim;

	public Art[] m_artCloseAnim;

	public float m_openAnimLength = 0.75f;

	public float m_closeAnimLength = 1f;

	public AnimationCurve m_closeAnimTiming;

	public AnimationCurve m_closeAnimMovement;

	private boxAnimMode m_animMode;

	private float m_animTime;

	public Sprite m_artClosed;

	public Sprite m_artClosedFlipped;

	public Sprite m_artOpen;

	public Sprite m_artOpenFlipped;

	public Sprite m_shadowOpen;

	public Vector2 m_contentsOffset = Vector2.zero;

	public Sprite[] m_contentsArt;

	public Sprite[] m_contentsArtFront;

	private int m_contentsArtIndex;

	public Sprite m_contentsMaskArt;

	private SpriteRenderer m_contents;

	private SpriteRenderer m_contentsFront;

	public float m_contentsRangeStart;

	public float m_contentsRange = -0.4f;

	public float m_contentsRangeEmpty = -0.5f;

	public bool m_contentsInverseExponential = true;

	public AnimationCurve m_contentsAnim;

	private int m_contentsLevel;

	private int m_contentsLevelFull;

	private float m_contentsPositionStart;

	private float m_contentsPositionEnd;

	private SpriteMask m_contentsOpenMask;

	private Transform m_contentsItem;

	private Transform m_contentsItemBack;

	private SpriteMask m_contentsItemMask;

	private SpriteMask m_contentsItemMaskBack;

	public int m_stackPosition;

	private bool m_open;

	private int m_node = -1;

	private boxScript m_stackChild;

	private boxScript m_stackParent;

	public int m_pixelGroundOffset = 5;

	public int m_pixelHeight = 75;

	public int m_sizeX = 6;

	public int m_sizeY = 5;

	public int m_sizeHeight = 4;

	private bool m_turned;

	private bool m_turnedNodes;

	private bool m_active;

	private int m_groundNode;

	private int m_contentsNext;

	private List<boxedItem> m_packedItems = new List<boxedItem>();

	private bool m_nodesCreated;

	private bool m_packEdit;

	private zoneScript m_packEditZone;

	private int m_packModeCurrentIndex;

	private Vector2[] m_polyPoints;

	private GameObject m_audioGO;

	public int xWidth
	{
		get
		{
			if (m_turned)
			{
				return m_sizeY;
			}
			return m_sizeX;
		}
	}

	public int yWidth
	{
		get
		{
			if (m_turned)
			{
				return m_sizeX;
			}
			return m_sizeY;
		}
	}

	public int size => 5;

	public bool isActive => m_active;

	public bool isUsable
	{
		get
		{
			if (!(m_stackChild == null))
			{
				return !m_stackChild.gameObject.activeSelf;
			}
			return true;
		}
	}

	public GameObject audioGO => m_audioGO;

	private Sprite ArtSprite
	{
		set
		{
			m_art.sprite = value;
			if (m_artSplit != null)
			{
				m_artSplit.sprite = value;
			}
		}
	}

	public static bool ToggleText()
	{
		s_drawText = !s_drawText;
		return s_drawText;
	}

	public int Node()
	{
		return m_node;
	}

	public int GetState()
	{
		if (!m_turned)
		{
			return 0;
		}
		return 1;
	}

	private void Awake()
	{
		m_polyPoints = GetComponent<PolygonCollider2D>().points;
		GameObject gameObject = new GameObject("mask");
		gameObject.transform.parent = m_art.transform;
		gameObject.transform.localPosition = Vector3.zero;
		m_mask = gameObject.AddComponent<SpriteMask>();
		m_mask.isCustomRangeActive = true;
		m_mask.frontSortingOrder = 11;
		m_mask.backSortingOrder = 1;
		m_mask.sprite = m_art.sprite;
		m_mask.transform.localScale = new Vector3(m_art.flipX ? (-1f) : 1f, 1f, 1f);
		gameObject = new GameObject("itemMask");
		gameObject.transform.parent = m_art.transform;
		m_contentsItemMask = gameObject.AddComponent<SpriteMask>();
		m_contentsItemMask.isCustomRangeActive = true;
		m_contentsItemMask.frontSortingOrder = 11;
		m_contentsItemMask.backSortingOrder = 1;
		m_contentsItemMask.enabled = false;
		gameObject = new GameObject("itemBackMask");
		gameObject.transform.parent = m_contentsItemMask.transform;
		m_contentsItemMaskBack = gameObject.AddComponent<SpriteMask>();
		m_contentsItemMaskBack.isCustomRangeActive = true;
		m_contentsItemMaskBack.frontSortingOrder = 11;
		m_contentsItemMaskBack.backSortingOrder = 1;
		m_contentsItemMaskBack.enabled = false;
	}

	public void SetPackModeIndex(int _index)
	{
		m_packModeCurrentIndex = _index;
	}

	private void Update()
	{
		if (m_animMode != boxAnimMode.none)
		{
			m_animTime += Time.deltaTime;
			if (m_animMode == boxAnimMode.open)
			{
				if (m_animTime >= m_openAnimLength)
				{
					m_animMode = boxAnimMode.none;
					ArtSprite = ((m_turned && m_artOpenFlipped != null) ? m_artOpenFlipped : m_artOpen);
					m_shadow.sprite = m_shadowOpen;
					if (m_contents != null && m_contentsNext > 0)
					{
						m_contentsOpenMask.enabled = false;
						m_contents.color = Color.white;
						if (m_contentsFront != null)
						{
							m_contentsFront.color = Color.white;
						}
					}
				}
				else
				{
					int num = Mathf.FloorToInt(Mathf.InverseLerp(0f, m_openAnimLength, m_animTime) * (float)m_artOpenAnim.Length);
					ArtSprite = ((m_turned && m_artOpenAnim[num].m_artFlipped != null) ? m_artOpenAnim[num].m_artFlipped : m_artOpenAnim[num].m_art);
					m_shadow.sprite = m_artOpenAnim[num].m_shadow;
					if (m_contents != null && m_contentsNext > 0)
					{
						if (!m_contents.enabled && m_artOpenAnim[num].m_mask != null)
						{
							m_contents.enabled = true;
							m_contentsOpenMask.enabled = true;
							if (m_contentsFront != null)
							{
								m_contentsFront.enabled = true;
							}
						}
						else if (m_contents.enabled && m_artOpenAnim[num].m_mask == null)
						{
							m_contentsOpenMask.enabled = false;
						}
						if (m_artOpenAnim[num].m_mask != null)
						{
							m_contentsOpenMask.sprite = m_artOpenAnim[num].m_mask;
						}
						m_contents.color = m_artOpenAnim[num].m_contentTint;
						if (m_contentsFront != null)
						{
							m_contentsFront.color = m_artOpenAnim[num].m_contentTint;
						}
					}
				}
				m_mask.sprite = m_art.sprite;
			}
			else if (m_animMode == boxAnimMode.foldup)
			{
				if (m_animTime >= m_closeAnimLength)
				{
					m_animMode = boxAnimMode.none;
					RemoveBox(m_zone);
				}
				else
				{
					float time = Mathf.InverseLerp(0f, m_closeAnimLength, m_animTime);
					int num2 = Mathf.FloorToInt(m_closeAnimTiming.Evaluate(time) * (float)m_artCloseAnim.Length);
					ArtSprite = ((m_turned && m_artCloseAnim[num2].m_artFlipped != null) ? m_artCloseAnim[num2].m_artFlipped : m_artCloseAnim[num2].m_art);
					m_shadow.sprite = m_artCloseAnim[num2].m_shadow;
					m_art.transform.localPosition = new Vector3(0f, Mathf.Round(m_closeAnimMovement.Evaluate(time) * 100f) / 100f, 0f);
				}
				m_mask.sprite = m_art.sprite;
			}
		}
		if (!m_packEdit)
		{
			return;
		}
		Vector2 boxPosition = base.transform.position;
		boxPosition.y += 0.5f;
		boxPosition.x += (float)m_packedItems.Count * 0.035f;
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			if (m_packedItems[i].m_item != null)
			{
				m_packedItems[i].m_item.BoxMode(_active: true);
				m_packedItems[i].AddLine(boxPosition, i == m_packedItems.Count - m_packModeCurrentIndex - 1);
				boxPosition.x -= 0.07f;
			}
			else
			{
				Debug.LogWarning("missing item found in box at index " + i);
				m_packedItems.RemoveAt(i);
				i--;
			}
		}
	}

	private void OnDrawGizmosSelected()
	{
		Gizmos.color = Color.yellow;
		Vector3 vector = Vector3.up * m_pixelGroundOffset * -0.01f;
		Gizmos.DrawLine(base.transform.position + vector, GetStackPosition() + vector);
	}

	private void OnDrawGizmos()
	{
		if (m_zone != null && m_node > -1)
		{
			Gizmos.color = Color.green;
			m_zone.GetHeight(m_node);
			m_zone.GetForeground(m_node);
			Vector3 vector = base.transform.position + GetComponent<extraNodesScript>().m_offset;
			Vector3 to = vector;
			float num = (float)Mathf.RoundToInt(vector.z * -33.75f + vector.y * 16.66667f + (float)(GetComponent<extraNodesScript>().m_xWidth + GetComponent<extraNodesScript>().m_yWidth - 2) * 1.1666666f) * -0.06f;
			int num2 = Mathf.RoundToInt(vector.y / 0.01f - 0.5f);
			num += ((float)num2 + 0.5f) * 0.01f;
			to.z = num * 0.5f;
			Gizmos.DrawLine(vector, to);
		}
	}

	private int stackHeight()
	{
		return size * (m_stackPosition + 1);
	}

	private int[] GetRemainingItemIndexes()
	{
		int[] array = new int[m_contentsNext];
		for (int i = 0; i < m_contentsNext; i++)
		{
			array[i] = m_packedItems[i].m_itemID;
		}
		return array;
	}

	public void Init(zoneScript _zone)
	{
		m_active = true;
		m_zone = _zone;
		m_contentsNext = m_packedItems.Count;
		if (m_contentsArt.Length != 0)
		{
			GameObject gameObject = new GameObject("contentsMask");
			gameObject.transform.parent = m_art.transform;
			gameObject.transform.localPosition = (Vector3)m_contentsOffset + Vector3.forward * -0.002f;
			gameObject.AddComponent<SpriteMask>().sprite = m_contentsMaskArt;
			gameObject.AddComponent<SortingGroup>();
			GameObject gameObject2 = new GameObject("OpenMask");
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.localPosition = -m_contentsOffset;
			m_contentsOpenMask = gameObject2.AddComponent<SpriteMask>();
			m_contentsOpenMask.enabled = false;
			gameObject2 = new GameObject("contents");
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.localPosition = Vector3.up * (Mathf.Round(m_contentsRangeStart * 100f) / 100f);
			m_contents = gameObject2.AddComponent<SpriteRenderer>();
			m_contents.maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
			m_contentsArtIndex = UnityEngine.Random.Range(0, m_contentsArt.Length);
			m_contents.sprite = m_contentsArt[m_contentsArtIndex];
			m_contents.sortingOrder = -1;
			m_contents.enabled = false;
			if (m_contentsArtFront.Length != 0)
			{
				gameObject2 = new GameObject("contentsFront");
				gameObject2.transform.parent = m_contents.transform;
				gameObject2.transform.localPosition = Vector3.zero;
				m_contentsFront = gameObject2.AddComponent<SpriteRenderer>();
				m_contentsFront.maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
				m_contentsFront.sprite = m_contentsArtFront[m_contentsArtIndex];
				m_contentsFront.sortingOrder = 1;
				m_contentsFront.enabled = false;
			}
			gameObject.transform.localScale = new Vector3(m_turned ? (-1f) : 1f, 1f, 1f);
			gameObject2 = new GameObject("raisedItem");
			m_contentsItem = gameObject2.transform;
			m_contentsItem.parent = m_contents.transform.parent;
			SpriteRenderer spriteRenderer = gameObject2.AddComponent<SpriteRenderer>();
			spriteRenderer.maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
			spriteRenderer.enabled = false;
			gameObject2 = new GameObject("raisedItemBack");
			m_contentsItemBack = gameObject2.transform;
			m_contentsItemBack.parent = m_contentsItem;
			m_contentsItemBack.localPosition = Vector3.zero;
			SpriteRenderer spriteRenderer2 = gameObject2.AddComponent<SpriteRenderer>();
			spriteRenderer2.maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
			spriteRenderer2.enabled = false;
			m_contentsLevelFull = _zone.GetItemsVolume(GetRemainingItemIndexes());
			m_contentsLevel = m_contentsLevelFull;
			m_contentsPositionEnd = 1f;
		}
		if (m_stackParent == null)
		{
			int gridForeground = _zone.GetGridForeground(m_node, xWidth, yWidth);
			Material sharedMaterial = UnityEngine.Object.FindObjectOfType<gameScript>().m_materials[1];
			Transform transform = new GameObject("ArtSplit").transform;
			m_artSplit = transform.gameObject.AddComponent<SpriteRenderer>();
			transform.parent = m_art.transform;
			m_artSplit.transform.localPosition = Vector3.forward * 0.07f;
			m_artSplit.sprite = m_art.sprite;
			m_artSplit.flipX = m_art.flipX;
			if (gridForeground != 0)
			{
				if (gridForeground < Mathf.Min(xWidth, yWidth))
				{
					base.transform.position += Vector3.forward * 100f * 0.06f;
				}
				else
				{
					m_artSplit.transform.localPosition += Vector3.forward * 100f * 0.06f;
				}
			}
			m_art.sharedMaterial = sharedMaterial;
			m_artSplit.sharedMaterial = sharedMaterial;
			MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
			m_art.GetPropertyBlock(materialPropertyBlock);
			materialPropertyBlock.SetFloat("_SplitStart", m_turned ? 0f : (-10f));
			materialPropertyBlock.SetFloat("_SplitEnd", m_turned ? 10f : 0f);
			m_art.SetPropertyBlock(materialPropertyBlock);
			m_artSplit.GetPropertyBlock(materialPropertyBlock);
			materialPropertyBlock.SetFloat("_SplitStart", m_turned ? (-10f) : 0f);
			materialPropertyBlock.SetFloat("_SplitEnd", m_turned ? 0f : 10f);
			m_artSplit.SetPropertyBlock(materialPropertyBlock);
			m_shadow.transform.localPosition = m_artSplit.transform.localPosition + Vector3.forward * 0.001f;
		}
		Sprite sprite = ((m_stackParent == null) ? m_zone.GetBoxMask(m_node) : null);
		if (m_stackParent != null || sprite != null)
		{
			GameObject gameObject3 = new GameObject("mask");
			gameObject3.transform.parent = base.transform;
			if (sprite != null)
			{
				gameObject3.transform.position = Vector3.forward * m_shadow.transform.position.z;
			}
			else
			{
				gameObject3.transform.position = m_stackParent.GetStackPosition() + Vector3.forward * 0f;
			}
			m_maskShadow = gameObject3.AddComponent<SpriteMask>();
			m_maskShadow.isCustomRangeActive = true;
			m_maskShadow.frontSortingOrder = 1;
			m_maskShadow.backSortingOrder = 0;
			if (sprite != null)
			{
				m_maskShadow.sprite = sprite;
			}
			else
			{
				m_maskShadow.sprite = m_stackParent.GetShadow().sprite;
				m_maskShadow.transform.localScale = new Vector3(m_stackParent.GetShadow().flipX ? (-1f) : 1f, 1f, 1f);
			}
			gameObject3.AddComponent<SortingGroup>();
			m_shadow.maskInteraction = SpriteMaskInteraction.VisibleInsideMask;
			m_shadow.transform.parent = gameObject3.transform;
		}
		extraNodesScript component = GetComponent<extraNodesScript>();
		if ((bool)component)
		{
			if (m_turned != m_turnedNodes)
			{
				int num = component.m_xWidth;
				component.m_xWidth = component.m_yWidth;
				component.m_yWidth = num;
				m_turnedNodes = !m_turnedNodes;
			}
			Vector3 vector = base.transform.position + component.m_offset;
			int height = Mathf.RoundToInt(vector.z * -33.3333f + vector.y * 16.6666f + (float)(component.m_xWidth + component.m_yWidth - 2) * 1.5f);
			component.AddNodes(_zone, Vector3.zero, null, height, 99, stackHeight());
			component.SetMaskLevel(_zone, 1);
			component.SetBoxTop(_zone, _boxTop: true);
			m_nodesCreated = true;
			if (m_stackChild != null)
			{
				component.ActivateNodes(_zone, _active: false);
			}
		}
		m_audioGO = new GameObject("audio");
		m_audioGO.transform.parent = base.transform;
		m_audioGO.transform.localPosition = Vector3.forward * (0f - base.transform.position.z);
	}

	public bool CreateNodes(zoneScript _zone, bool _value)
	{
		if (_value)
		{
			extraNodesScript component = GetComponent<extraNodesScript>();
			if ((bool)component && m_stackChild == null)
			{
				if (m_turned != m_turnedNodes)
				{
					int num = component.m_xWidth;
					component.m_xWidth = component.m_yWidth;
					component.m_yWidth = num;
					m_turnedNodes = !m_turnedNodes;
				}
				Vector3 vector = base.transform.position + component.m_offset;
				int height = Mathf.RoundToInt(vector.z * -33.3333f + vector.y * 16.6666f + (float)(component.m_xWidth + component.m_yWidth - 2) * 1.5f);
				component.AddNodes(_zone, Vector3.zero, null, height, 99, stackHeight());
				component.SetMaskLevel(_zone, 1);
				component.SetBoxTop(_zone, _boxTop: true);
				m_nodesCreated = true;
				return true;
			}
		}
		else if (m_nodesCreated)
		{
			GetComponent<extraNodesScript>().RemoveNodes(_zone);
			m_nodesCreated = false;
			return true;
		}
		return false;
	}

	public void Turn()
	{
		m_turned = !m_turned;
		if (m_artClosedFlipped != null)
		{
			ArtSprite = (m_turned ? m_artClosedFlipped : m_artClosed);
		}
		else
		{
			m_art.flipX = m_turned;
			if (m_artSplit != null)
			{
				m_artSplit.flipX = m_turned;
			}
		}
		m_shadow.flipX = m_turned;
		m_mask.sprite = m_art.sprite;
		m_mask.transform.localScale = new Vector3(m_art.flipX ? (-1f) : 1f, 1f, 1f);
		if (m_contents != null)
		{
			m_contents.transform.parent.localScale = new Vector3(m_turned ? (-1f) : 1f, 1f, 1f);
		}
		PolygonCollider2D component = GetComponent<PolygonCollider2D>();
		if (m_turned)
		{
			Vector2[] array = new Vector2[m_polyPoints.Length];
			for (int i = 0; i < m_polyPoints.Length; i++)
			{
				array[i] = m_polyPoints[i];
				array[i].x *= -1f;
			}
			component.points = array;
		}
		else
		{
			component.points = m_polyPoints;
		}
	}

	public void Hover(Vector3 _position, boxScript _stackParent, bool _valid)
	{
		float num = 0f;
		if (_valid)
		{
			if (_stackParent == null)
			{
				num = (float)Mathf.Min(xWidth, yWidth) - 1f;
			}
			else
			{
				float num2 = (float)(xWidth - _stackParent.xWidth) / 2f;
				float num3 = (float)(yWidth - _stackParent.yWidth) / 2f;
				_position -= new Vector3((num2 - num3) * 0.14f, (num2 + num3) * 0.07f);
			}
			m_art.color = Color.white;
			m_shadow.enabled = true;
			m_art.sortingOrder = 0;
		}
		else
		{
			_position.z = -9f;
			m_art.color = new Color(1f, 1f, 1f, 0.5f);
			m_shadow.enabled = false;
			m_art.sortingOrder = 20;
		}
		_position.x = Mathf.Round(_position.x * 100f) / 100f;
		_position.y = Mathf.Round((_position.y - 0.005f) * 100f) / 100f + 0.005f;
		_position.z += num * 0.08f;
		base.transform.position = _position;
		base.transform.parent = null;
		m_art.transform.localPosition = new Vector3(0f, 0.04f, 0f);
		GetComponent<Collider2D>().enabled = false;
		m_node = -1;
	}

	public void Place(Vector3 _position, int _node, boxScript _stackParent, Transform _zone)
	{
		float num = (float)Mathf.Min(xWidth, yWidth) - 1f;
		m_art.color = Color.white;
		m_art.sortingOrder = 0;
		_position.x = Mathf.Round(_position.x * 100f) / 100f;
		_position.y = Mathf.Round((_position.y - 0.005f) * 100f) / 100f + 0.005f;
		if (_stackParent == null)
		{
			_position.z += num * 0.08f;
		}
		else
		{
			float num2 = (float)(xWidth - _stackParent.xWidth) / 2f;
			float num3 = (float)(yWidth - _stackParent.yWidth) / 2f;
			_position -= new Vector3((num2 - num3) * 0.14f, (num2 + num3) * 0.07f);
		}
		base.transform.position = _position;
		base.transform.parent = _zone;
		m_art.transform.localPosition = Vector3.zero;
		GetComponent<Collider2D>().enabled = true;
		if (_stackParent != null)
		{
			m_stackParent = _stackParent;
			m_stackPosition = m_stackParent.m_stackPosition + 1;
			m_stackParent.Stack(this);
		}
		else
		{
			m_stackPosition = 0;
		}
		m_shadow.enabled = true;
		m_node = _node;
	}

	public void Stack(boxScript _child)
	{
		m_stackChild = _child;
	}

	public boxScript UnStack()
	{
		boxScript result = null;
		if (m_stackParent != null)
		{
			result = m_stackParent;
			m_stackParent.m_stackChild = null;
			m_stackParent = null;
		}
		return result;
	}

	public boxScript GetBox()
	{
		if ((bool)m_stackChild)
		{
			return m_stackChild.GetBox();
		}
		return this;
	}

	public string GetContentsHeader()
	{
		int num = m_sizeX * m_sizeY * m_sizeHeight;
		int num2 = 0;
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			num2 += m_packedItems[i].m_item.m_xWidth * m_packedItems[i].m_item.m_yWidth * m_packedItems[i].m_item.m_size;
		}
		return "box fill " + num2 + " / " + num;
	}

	public string[] GetContents()
	{
		string[] array = new string[m_packedItems.Count];
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			int index = m_packedItems.Count - 1 - i;
			string text = (m_packedItems[index].m_zonePacked ? "# " : "");
			itemScript.itemState state = (itemScript.itemState)m_packedItems[index].m_state;
			array[i] = text + m_packedItems[index].m_item.gameObject.name.Remove(0, 4).Replace("(Clone)", "") + m_packedItems[index].m_item.GetVariantName() + ((state == itemScript.itemState.normal) ? "" : (" (" + state.ToString() + ")"));
		}
		return array;
	}

	public int GetItemState(itemScript _item)
	{
		int num = FindItem(_item);
		if (num != -1)
		{
			return m_packedItems[num].m_state;
		}
		return 0;
	}

	public int FindItem(itemScript _item)
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			if (m_packedItems[i].m_item == _item)
			{
				return i;
			}
		}
		return -1;
	}

	public bool MatchOrphan(zoneScript _zone, itemScript _item, int _itemIndex, int _itemVariant)
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			if (m_packedItems[i].m_item == null && m_packedItems[i].m_itemID == _itemIndex && m_packedItems[i].m_variant == _itemVariant)
			{
				m_packedItems[i].m_item = _item;
				_item.BoxAssign(_zone, this);
				return true;
			}
		}
		return false;
	}

	public int SelectItem(itemScript _item)
	{
		return m_packModeCurrentIndex = m_packedItems.Count - FindItem(_item) - 1;
	}

	public bool AddContents(zoneScript _zone, itemScript _item, bool _zonePacked)
	{
		if (FindItem(_item) == -1)
		{
			m_packedItems.Insert(0, new boxedItem(_item, _zonePacked));
			_item.BoxAssign(_zone, this);
			_item.BoxMode(_active: true);
			return true;
		}
		return false;
	}

	public void AddContents(zoneScript _zone, itemScript _item, int _itemID, int _variant, int _itemState, int _boxOrder, bool _zonePacked)
	{
		if (_boxOrder == -1)
		{
			m_packedItems.Add(new boxedItem(_item, _itemID, _variant, _itemState, _zonePacked));
		}
		else
		{
			while (m_packedItems.Count <= _boxOrder)
			{
				m_packedItems.Add(new boxedItem(null, -1, 0, -1, _zonePacked: false));
			}
			if (m_packedItems[_boxOrder].m_itemID != -1)
			{
				Debug.LogWarning("item being assigned to boxOrder " + _boxOrder + " but a valid item already exists! | item being assigned to end of list instead");
				m_packedItems.Add(new boxedItem(_item, _itemID, _variant, _itemState, _zonePacked));
			}
			else
			{
				m_packedItems[_boxOrder] = new boxedItem(_item, _itemID, _variant, _itemState, _zonePacked);
			}
		}
		if (_item != null)
		{
			_item.BoxAssign(_zone, this);
		}
	}

	public void TransferContents(zoneScript _zone, boxScript _target)
	{
		_target.TransferContents(_zone, m_packedItems);
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			m_packedItems[i].RemoveLine();
		}
		m_packedItems.Clear();
	}

	protected void TransferContents(zoneScript _zone, List<boxedItem> _contents)
	{
		for (int i = 0; i < _contents.Count; i++)
		{
			m_packedItems.Add(new boxedItem(_contents[i].m_item, _contents[i].m_itemID, _contents[i].m_variant, _contents[i].m_state, _contents[i].m_zonePacked));
			m_packedItems[i].m_item.BoxAssign(_zone, this);
		}
	}

	public void SettleContents()
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			if (m_packedItems[i] == null || m_packedItems[i].m_itemID < 0)
			{
				m_packedItems.RemoveAt(i);
				i--;
			}
		}
	}

	public void ClearBoxContents()
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			m_packedItems[i].RemoveLine();
			m_packedItems[i].m_item.BoxAssign(null, null);
			m_packedItems[i].m_item.BoxMode(_active: true);
		}
		m_packedItems.Clear();
	}

	public bool RemoveContents(itemScript _item)
	{
		int num = FindItem(_item);
		if (num != -1)
		{
			m_packedItems[num].RemoveLine();
			m_packedItems.RemoveAt(num);
			_item.BoxAssign(null, null);
			_item.BoxMode(_active: true);
			return true;
		}
		return false;
	}

	public void UpdateZoneForContents(zoneScript _zone)
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			m_packedItems[i].m_item.BoxAssign(_zone, this);
		}
	}

	public bool Contains(itemScript _item)
	{
		return FindItem(_item) != -1;
	}

	public itemScript GetItemByIndex(int _index)
	{
		int index = m_packedItems.Count - 1 - _index;
		return m_packedItems[index].m_item;
	}

	public void SetEdit(zoneScript _zone)
	{
		m_packEditZone = _zone;
		SetEdit(_value: true);
	}

	public void SetEdit(bool _value)
	{
		bool flag = m_packOutline != null && m_packOutline.enabled;
		if (_value)
		{
			if (flag)
			{
				ShowPackOutline(2);
			}
			else
			{
				m_art.color = new Color(0.5f, 0.5f, 1f);
			}
		}
		else
		{
			if (flag)
			{
				ShowPackOutline(1);
			}
			else
			{
				m_art.color = Color.white;
			}
			foreach (boxedItem packedItem in m_packedItems)
			{
				packedItem.m_item.BoxMode(_active: false);
				packedItem.RemoveLine();
			}
		}
		m_packEdit = _value;
	}

	public void RemoveLines()
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			m_packedItems[i].RemoveLine();
		}
	}

	public bool CompareEditZone(zoneScript _zone)
	{
		return _zone == m_packEditZone;
	}

	public Vector3 GetStackPosition()
	{
		return base.transform.position - new Vector3(0f, (float)m_pixelHeight * -0.01f, 0.005f);
	}

	public void RandomiseItemStates()
	{
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			m_packedItems[i].m_state = m_packedItems[i].m_item.GetRandomState();
		}
	}

	public bool FixItemStates(int _hangPref, bool _tops, bool _bottoms)
	{
		bool result = false;
		int num = 0;
		List<int> list = new List<int>();
		for (int i = 0; i < m_packedItems.Count; i++)
		{
			if (_hangPref == 0 && (m_packedItems[i].m_state == 16 || m_packedItems[i].m_state == 17))
			{
				num += ((m_packedItems[i].m_state == 16) ? 1 : (-1));
				list.Add(i);
				continue;
			}
			int num2 = m_packedItems[i].m_item.FixBoxState(m_packedItems[i].m_state, _hangPref, _tops, _bottoms);
			if (m_packedItems[i].m_state != num2)
			{
				m_packedItems[i].m_state = num2;
				result = true;
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			int num3 = m_packedItems[j].m_item.FixBoxState(m_packedItems[j].m_state, (num >= 0) ? 1 : 2, _tops, _bottoms);
			if (m_packedItems[j].m_state != num3)
			{
				m_packedItems[j].m_state = num3;
				result = true;
			}
		}
		return result;
	}

	public void MoveItem(int _index, int _direction)
	{
		int num = m_packedItems.Count - 1 - _index;
		boxedItem value = m_packedItems[num + _direction];
		m_packedItems[num + _direction] = m_packedItems[num];
		m_packedItems[num] = value;
	}

	public void AdvanceItemState(int _index)
	{
		int index = m_packedItems.Count - 1 - _index;
		m_packedItems[index].m_state = m_packedItems[index].m_item.GetNextState(m_packedItems[index].m_state);
	}

	public Vector2 PlaybackContentSnap(Vector2 _offset, int _volume)
	{
		m_contentsLevel -= _volume;
		m_contentsPositionEnd = (float)m_contentsLevel / (float)m_contentsLevelFull;
		if (m_contentsInverseExponential)
		{
			m_contentsPositionEnd = 1f - m_contentsPositionEnd;
			m_contentsPositionEnd *= m_contentsPositionEnd;
			m_contentsPositionEnd = 1f - m_contentsPositionEnd;
		}
		if (m_contentsArt.Length > 1)
		{
			int num = UnityEngine.Random.Range(0, m_contentsArt.Length - 1);
			if (num >= m_contentsArtIndex)
			{
				num++;
			}
			m_contentsArtIndex = num;
		}
		m_contents.sprite = m_contentsArt[m_contentsArtIndex];
		if ((bool)m_contentsFront)
		{
			m_contentsFront.sprite = m_contentsArtFront[m_contentsArtIndex];
		}
		RaiseItemContentsSlide(1f);
		Vector2 vector = _offset;
		vector.x += (float)(xWidth - yWidth) * 0.07f;
		if (m_turned)
		{
			vector.x *= -1f;
		}
		vector.y += 1.25f;
		return base.transform.TransformPoint(vector);
	}

	public Vector2[] RaiseItemStart(Sprite _item, Sprite _itemBack, bool _flipped, bool _flippedBack, Vector2 _offset, int _volume)
	{
		if (m_contents == null)
		{
			return new Vector2[0];
		}
		m_contentsLevel -= _volume;
		m_contentsPositionStart = m_contentsPositionEnd;
		m_contentsPositionEnd = (float)m_contentsLevel / (float)m_contentsLevelFull;
		if (m_contentsInverseExponential)
		{
			m_contentsPositionEnd = 1f - m_contentsPositionEnd;
			m_contentsPositionEnd *= m_contentsPositionEnd;
			m_contentsPositionEnd = 1f - m_contentsPositionEnd;
		}
		if (m_contentsArt.Length > 1)
		{
			int num = UnityEngine.Random.Range(0, m_contentsArt.Length - 1);
			if (num >= m_contentsArtIndex)
			{
				num++;
			}
			m_contentsArtIndex = num;
		}
		m_contents.sprite = m_contentsArt[m_contentsArtIndex];
		if ((bool)m_contentsFront)
		{
			m_contentsFront.sprite = m_contentsArtFront[m_contentsArtIndex];
		}
		Vector2 vector = _offset;
		vector.x += (float)(xWidth - yWidth) * 0.07f;
		if (m_turned)
		{
			vector.x *= -1f;
		}
		m_contentsItem.localPosition = vector;
		if (_item != null)
		{
			m_contentsItem.GetComponent<SpriteRenderer>().enabled = true;
			m_contentsItem.GetComponent<SpriteRenderer>().sprite = _item;
			m_contentsItem.GetComponent<SpriteRenderer>().flipX = _flipped;
			m_contentsItemMask.enabled = true;
			m_contentsItemMask.sprite = _item;
			m_contentsItemMask.transform.position = m_contentsItem.position;
		}
		m_contentsItemMask.transform.localScale = new Vector3(_flipped ? (-1f) : 1f, 1f, 1f);
		if (_itemBack != null)
		{
			m_contentsItemBack.GetComponent<SpriteRenderer>().enabled = true;
			m_contentsItemBack.GetComponent<SpriteRenderer>().sprite = _itemBack;
			m_contentsItemBack.GetComponent<SpriteRenderer>().flipX = _flippedBack;
			m_contentsItemMaskBack.enabled = true;
			m_contentsItemMaskBack.sprite = _itemBack;
		}
		Vector2[] array = new Vector2[4];
		array[0] = m_contentsItem.position;
		array[1] = array[0] + Vector2.up * 1.25f;
		array[2] = array[1];
		return array;
	}

	public void RaiseItemMove(Vector2 _position)
	{
		_position.x = Mathf.Round(_position.x * 100f) / 100f;
		_position.y = Mathf.Round((_position.y - 0.005f) * 100f) / 100f + 0.005f;
		m_contentsItem.position = _position;
		m_contentsItemMask.transform.position = _position;
	}

	public void RaiseItemContentsSlide(float _contentsLerp)
	{
		float num = Mathf.Lerp((m_contentsLevel == 0) ? m_contentsRangeEmpty : m_contentsRange, m_contentsRangeStart, Mathf.Lerp(m_contentsPositionStart, m_contentsPositionEnd, m_contentsAnim.Evaluate(_contentsLerp)));
		num = Mathf.Round(num * 100f) / 100f;
		m_contents.transform.localPosition = Vector2.up * num;
		if (_contentsLerp >= 1f && m_contentsLevel == 0)
		{
			m_contents.enabled = false;
			if (m_contentsFront != null)
			{
				m_contentsFront.enabled = false;
			}
		}
	}

	public void RaiseItemEnd()
	{
		m_contentsItem.GetComponent<SpriteRenderer>().enabled = false;
		m_contentsItemBack.GetComponent<SpriteRenderer>().enabled = false;
		m_contentsItemMask.enabled = false;
		m_contentsItemMaskBack.enabled = false;
	}

	public bool ClosedOrEmpty()
	{
		if (m_open)
		{
			return m_contentsNext == 0;
		}
		return true;
	}

	public bool Empty()
	{
		if (m_open && m_contentsNext == 0)
		{
			return m_animMode == boxAnimMode.none;
		}
		return false;
	}

	public bool CanOpen(zoneScript _zone)
	{
		if (!isUsable)
		{
			return false;
		}
		if (m_animMode == boxAnimMode.open && m_animTime < 0.4f)
		{
			return false;
		}
		extraNodesScript component = GetComponent<extraNodesScript>();
		if (component != null)
		{
			return component.CheckNodes(_zone);
		}
		return true;
	}

	public int Use(zoneScript _zone, out int _variant, out int _state)
	{
		_variant = 0;
		_state = -1;
		if (m_stackChild != null && m_stackChild.gameObject.activeSelf)
		{
			return -1;
		}
		if (!m_open)
		{
			extraNodesScript component = GetComponent<extraNodesScript>();
			if (component != null)
			{
				if (!component.CheckNodes(_zone))
				{
					return -1;
				}
				component.ActivateNodes(_zone, _active: false);
			}
			m_open = true;
			if (s_drawText)
			{
				DrawText(_enable: true);
			}
			m_animMode = boxAnimMode.open;
			m_animTime = 0f;
			return -2;
		}
		if (m_contentsNext > 0)
		{
			m_contentsNext--;
			if (s_drawText)
			{
				DrawText(_enable: true);
			}
			_variant = m_packedItems[m_contentsNext].m_variant;
			_state = m_packedItems[m_contentsNext].m_state;
			return m_packedItems[m_contentsNext].m_itemID;
		}
		if (m_contentsNext == 0 && m_animMode == boxAnimMode.none)
		{
			m_animMode = boxAnimMode.foldup;
			m_animTime = 0f;
			m_active = false;
			GetComponent<Collider2D>().enabled = false;
			return -3;
		}
		return -1;
	}

	public void PlaybackOpenOrClear(bool _animate)
	{
		if (!m_open)
		{
			m_open = true;
			if (_animate)
			{
				m_animMode = boxAnimMode.open;
				m_animTime = 0f;
				return;
			}
			ArtSprite = ((m_turned && m_artOpenFlipped != null) ? m_artOpenFlipped : m_artOpen);
			m_shadow.sprite = m_shadowOpen;
			if (m_contents != null && m_contentsNext != 0)
			{
				m_contentsArtIndex = UnityEngine.Random.Range(0, m_contentsArt.Length);
				m_contents.sprite = m_contentsArt[m_contentsArtIndex];
				m_contents.enabled = true;
				m_contents.color = m_artOpenAnim[m_artOpenAnim.Length - 1].m_contentTint;
				if (m_contentsFront != null)
				{
					m_contentsFront.sprite = m_contentsArtFront[m_contentsArtIndex];
					m_contentsFront.enabled = true;
					m_contentsFront.color = m_artOpenAnim[m_artOpenAnim.Length - 1].m_contentTint;
				}
				float contentsRangeStart = m_contentsRangeStart;
				contentsRangeStart = Mathf.Round(contentsRangeStart * 100f) / 100f;
				m_contents.transform.localPosition = Vector2.up * contentsRangeStart;
			}
		}
		else if (m_contentsNext == 0 && m_animMode == boxAnimMode.none)
		{
			m_active = false;
			m_contents.enabled = false;
			if (m_contentsFront != null)
			{
				m_contentsFront.enabled = false;
			}
			if (_animate)
			{
				m_animMode = boxAnimMode.foldup;
				m_animTime = 0f;
			}
			else
			{
				base.gameObject.SetActive(value: false);
			}
		}
	}

	public int PlaybackTake(out int _variant, out int _state)
	{
		m_contentsNext--;
		_variant = m_packedItems[m_contentsNext].m_variant;
		_state = m_packedItems[m_contentsNext].m_state;
		return m_packedItems[m_contentsNext].m_itemID;
	}

	public void DrawText(bool _enable)
	{
		if (_enable && m_contentsNext > 0)
		{
			if (m_textPivot == null)
			{
				m_textPivot = new GameObject("text").transform;
				m_textPivot.transform.parent = base.transform;
				m_textPivot.localScale = Vector3.one;
				m_textPivot.transform.localPosition = Vector3.up * ((float)(xWidth + yWidth) * 0.035f + (float)size * 0.08f - 0.07f) + Vector3.forward * -10f;
				TextMesh textMesh = m_textPivot.gameObject.AddComponent<TextMesh>();
				textMesh.color = Color.white;
				textMesh.anchor = TextAnchor.MiddleCenter;
				textMesh.alignment = TextAlignment.Center;
				textMesh.fontSize = 32;
				textMesh.characterSize = 0.03f;
				textMesh.offsetZ = -0.006f;
			}
			itemScript itemScript2 = UnityEngine.Object.FindObjectOfType<gameScript>().m_itemTypes[m_packedItems[m_contentsNext - 1].m_itemID];
			m_textPivot.GetComponent<TextMesh>().text = itemScript2.name + itemScript2.GetVariantString() + " (" + (m_contentsNext - 1) + ")";
		}
		else if (m_textPivot != null)
		{
			UnityEngine.Object.Destroy(m_textPivot.gameObject);
		}
	}

	public SpriteRenderer GetShadow()
	{
		return m_shadow;
	}

	private void RemoveBox(zoneScript _zone)
	{
		if (m_stackPosition == 0)
		{
			if (m_node != -1)
			{
				_zone.SetGrid(m_node, xWidth, yWidth, _used: false, 0);
			}
		}
		else
		{
			extraNodesScript component = m_stackParent.GetComponent<extraNodesScript>();
			if (component != null)
			{
				component.ActivateNodes(_zone, _active: true);
			}
		}
		_zone.BoxEffect(m_art.transform.position);
		base.gameObject.SetActive(value: false);
	}

	public void DestroyBox()
	{
		foreach (boxedItem packedItem in m_packedItems)
		{
			if (packedItem.m_item != null)
			{
				packedItem.m_item.BoxAssign(null, null);
				packedItem.m_item.BoxMode(_active: false);
				packedItem.RemoveLine();
			}
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	public void DestroyBox(zoneScript _zone)
	{
		if (m_stackPosition == 0 && m_node != -1)
		{
			_zone.SetGrid(m_node, xWidth, yWidth, _used: false, 0);
		}
		foreach (boxedItem packedItem in m_packedItems)
		{
			if (packedItem.m_item != null)
			{
				packedItem.m_item.BoxAssign(null, null);
				packedItem.m_item.BoxMode(_active: false);
				packedItem.RemoveLine();
			}
		}
		if (m_nodesCreated)
		{
			GetComponent<extraNodesScript>().RemoveNodes(_zone);
			m_nodesCreated = false;
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	public List<boxContent> GetAllRemainingItems()
	{
		List<boxContent> list = new List<boxContent>();
		while (m_contentsNext > 0)
		{
			m_contentsNext--;
			list.Add(new boxContent(m_packedItems[m_contentsNext].m_itemID, m_packedItems[m_contentsNext].m_variant, m_packedItems[m_contentsNext].m_state));
		}
		extraNodesScript component = GetComponent<extraNodesScript>();
		if (component != null)
		{
			component.ActivateNodes(m_zone, _active: false);
		}
		m_active = false;
		if (m_stackPosition == 0 && m_node != -1)
		{
			m_zone.SetGrid(m_node, xWidth, yWidth, _used: false, 0);
		}
		base.gameObject.SetActive(value: false);
		return list;
	}

	public void Collision(bool _value)
	{
		GetComponent<Collider2D>().enabled = _value;
	}

	public void PackingModeShow(bool _value)
	{
		m_art.color = ((!_value) ? Color.clear : (m_packEdit ? new Color(0.5f, 0.5f, 1f) : Color.white));
		m_shadow.color = (_value ? new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 70) : new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 0));
		ShowPackOutline((!_value) ? ((!m_packEdit) ? 1 : 2) : 0);
	}

	private void ShowPackOutline(int _value)
	{
		if (_value == 0)
		{
			if (m_packOutline != null)
			{
				m_packOutline.enabled = false;
			}
			return;
		}
		if (m_packOutline == null)
		{
			m_packOutline = UnityEngine.Object.Instantiate(Camera.main.GetComponent<gameScript>().m_linePrefab).GetComponent<LineRenderer>();
			m_packOutline.transform.parent = m_art.transform;
			m_packOutline.transform.localPosition = Vector3.forward * -0.01f;
			Vector2[] path = GetComponent<PolygonCollider2D>().GetPath(0);
			Vector3[] array = new Vector3[path.Length + 1];
			for (int i = 0; i < path.Length; i++)
			{
				array[i] = path[i];
			}
			array[path.Length] = path[0];
			m_packOutline.positionCount = array.Length;
			m_packOutline.SetPositions(array);
		}
		else
		{
			m_packOutline.enabled = true;
		}
		if (_value == 1)
		{
			m_packOutline.startColor = new Color32(0, 0, byte.MaxValue, byte.MaxValue);
			m_packOutline.endColor = new Color32(0, 0, byte.MaxValue, byte.MaxValue);
		}
		else
		{
			m_packOutline.startColor = new Color32(128, 128, byte.MaxValue, byte.MaxValue);
			m_packOutline.endColor = new Color32(128, 128, byte.MaxValue, byte.MaxValue);
		}
		m_packOutline.widthMultiplier = ((_value == 2) ? 0.05f : 0.01f);
	}

	public int GetFullItemCount()
	{
		return m_packedItems.Count;
	}

	public int GetRemainingItemCount()
	{
		return m_contentsNext;
	}

	public saveData.saveDataBox GetSaveData()
	{
		return new saveData.saveDataBox(m_active ? (m_contentsNext + ((!m_open) ? 1 : 0)) : (-1), m_contentsArtIndex);
	}

	public void SetSaveData(saveData.saveDataBox _data, zoneScript _zone)
	{
		if (_data.next == -1)
		{
			extraNodesScript component = GetComponent<extraNodesScript>();
			if (component != null)
			{
				component.ActivateNodes(m_zone, _active: false);
			}
			if (m_stackPosition == 0)
			{
				if (m_node != -1)
				{
					m_zone.SetGrid(m_node, xWidth, yWidth, _used: false, 0);
				}
			}
			else
			{
				component = m_stackParent.GetComponent<extraNodesScript>();
				if (component != null)
				{
					component.ActivateNodes(m_zone, _active: true);
				}
			}
			m_active = false;
			base.gameObject.SetActive(value: false);
		}
		else
		{
			if (_data.next > m_packedItems.Count)
			{
				return;
			}
			extraNodesScript component2 = GetComponent<extraNodesScript>();
			if (component2 != null)
			{
				component2.ActivateNodes(m_zone, _active: false);
			}
			m_open = true;
			m_contentsNext = _data.next;
			ArtSprite = ((m_turned && m_artOpenFlipped != null) ? m_artOpenFlipped : m_artOpen);
			m_shadow.sprite = m_shadowOpen;
			m_mask.sprite = m_art.sprite;
			if (m_contents != null && m_contentsNext != 0)
			{
				m_contentsArtIndex = _data.contentArt;
				m_contents.sprite = m_contentsArt[m_contentsArtIndex];
				m_contents.enabled = true;
				m_contents.color = m_artOpenAnim[m_artOpenAnim.Length - 1].m_contentTint;
				if (m_contentsFront != null)
				{
					m_contentsFront.sprite = m_contentsArtFront[m_contentsArtIndex];
					m_contentsFront.enabled = true;
					m_contentsFront.color = m_artOpenAnim[m_artOpenAnim.Length - 1].m_contentTint;
				}
				m_contentsLevel = _zone.GetItemsVolume(GetRemainingItemIndexes());
				m_contentsPositionEnd = (float)m_contentsLevel / (float)m_contentsLevelFull;
				if (m_contentsInverseExponential)
				{
					m_contentsPositionEnd = 1f - m_contentsPositionEnd;
					m_contentsPositionEnd *= m_contentsPositionEnd;
					m_contentsPositionEnd = 1f - m_contentsPositionEnd;
				}
				float num = Mathf.Lerp(m_contentsRange, m_contentsRangeStart, m_contentsPositionEnd);
				num = Mathf.Round(num * 100f) / 100f;
				m_contents.transform.localPosition = Vector2.up * num;
			}
		}
	}
}
