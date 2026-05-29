using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

public class zoneScript : MonoBehaviour
{
	public enum direction
	{
		xAxis = 0,
		yAxis = 1,
		xAxisNeg = 2,
		yAxisNeg = 3
	}

	public enum zoneType
	{
		kitchen = 0,
		bedroom = 1,
		livingroom = 2,
		bathroom = 3,
		wall = 4,
		diningroom = 5,
		office = 6,
		nursery = 7,
		closet = 8,
		toilet = 9,
		foyer = 10
	}

	public enum zoneKitchen
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		sink = 8,
		underSink = 0x10,
		drawer = 0x20,
		prepArea = 0x40,
		limitedShelf = 0x80,
		stovetop = 0x100,
		insideSink = 0x200,
		windowsill = 0x400,
		table = 0x800,
		counter = 0x1000,
		islandCounter = 0x2000,
		cupboard = 0x4000
	}

	public enum zoneBedroom
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		bed = 8,
		desk = 0x10,
		drawer = 0x20,
		deskAlt = 0x40,
		pillow = 0x80,
		closet = 0x100,
		underDesk = 0x200,
		underBed = 0x400,
		lowStorage = 0x800,
		cupboard = 0x1000,
		bedsideTable = 0x2000,
		closetDrawer = 0x4000,
		closetShelf = 0x8000
	}

	public enum zoneBathroom
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		sink = 8,
		underSink = 0x10,
		drawer = 0x20,
		cistern = 0x40,
		bathShelf = 0x80,
		showerFloor = 0x100,
		tpHolder = 0x200,
		bath = 0x400,
		bathMat = 0x800
	}

	public enum zoneDiningRoom
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		table = 8,
		zone4 = 0x10,
		drawer = 0x20
	}

	public enum zoneLivingRoom
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		coffeetable = 8,
		tvstand = 0x10,
		drawer = 0x20,
		couch = 0x40,
		endtable = 0x80,
		couchArm = 0x100,
		tvstandtop = 0x200,
		coffeetableunder = 0x400
	}

	public enum zoneOffice
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		cabinet = 8,
		desk = 0x10,
		drawer = 0x20,
		underdesk = 0x40,
		deskAlt = 0x80
	}

	public enum zoneNursery
	{
		nothing = 0,
		floor = 2,
		shelf = 4,
		bed = 8,
		chair = 0x10,
		drawer = 0x20,
		changeMat = 0x40,
		storageShelf = 0x80,
		endTable = 0x100
	}

	public enum zoneWall
	{
		nothing = 0,
		generic = 2,
		magnetic = 4,
		pinboard = 8,
		important = 0x10,
		bathroom = 0x20
	}

	[Serializable]
	public struct boxMask
	{
		public int height;

		public Sprite mask;
	}

	public enum itemPackType
	{
		none = 0,
		box = 1,
		unmovable = 2,
		movable = 3,
		zone = 4
	}

	[Serializable]
	public struct itemData
	{
		public string name;

		public float x;

		public float y;

		public int state;

		public int stackCount;

		public string zonePack;

		public int boxIndex;

		public int boxState;

		public int boxOrder;

		public string zone;

		public Vector3 move;

		public int moveState;

		public itemPackType packState
		{
			get
			{
				if (boxIndex >= 0)
				{
					return itemPackType.box;
				}
				if (boxIndex == -2)
				{
					return itemPackType.unmovable;
				}
				if (boxIndex == -3)
				{
					return itemPackType.movable;
				}
				if (boxIndex == -4)
				{
					return itemPackType.zone;
				}
				return itemPackType.none;
			}
		}

		public itemData(string _name, float _x, float _y, int _state, int _stackCount, int _boxIndex, int _boxState, int _boxOrder, int _moveState, Vector3 _move, string _zonePack)
		{
			name = _name;
			x = _x;
			y = _y;
			state = _state;
			stackCount = _stackCount;
			boxIndex = _boxIndex;
			boxState = _boxState;
			boxOrder = _boxOrder;
			zone = null;
			move = _move;
			moveState = _moveState;
			zonePack = _zonePack;
		}
	}

	[Serializable]
	public struct boxData
	{
		public string name;

		public float x;

		public float y;

		public int state;

		public int stackPosition;

		public boxData(string _name, float _x, float _y, int _state, int _stackPosition)
		{
			name = _name;
			x = _x;
			y = _y;
			state = _state;
			stackPosition = _stackPosition;
		}
	}

	[Serializable]
	public struct zonePackedData
	{
		public string name;

		public int boxIndex;

		public int boxState;

		public int boxOrder;

		public zonePackedData(string _name, int _boxIndex, int _boxState, int _boxOrder)
		{
			name = _name;
			boxIndex = _boxIndex;
			boxState = _boxState;
			boxOrder = _boxOrder;
		}
	}

	[Serializable]
	public struct nodeData
	{
		[SerializeField]
		private int m_x;

		[SerializeField]
		private int m_y;

		[SerializeField]
		private int m_height;

		[SerializeField]
		private int m_size;

		[SerializeField]
		private itemNode.nodeType m_type;

		[SerializeField]
		private itemNode.audioSurface m_audioId;

		public bool m_nonVisible;

		public bool m_foreground;

		public bool m_bar;

		public bool m_rack;

		public int x => m_x;

		public int y => m_y;

		public int height
		{
			get
			{
				return m_height;
			}
			set
			{
				m_height = value;
			}
		}

		public int size
		{
			get
			{
				return m_size;
			}
			set
			{
				m_size = value;
			}
		}

		public itemNode.nodeType type
		{
			get
			{
				return m_type;
			}
			set
			{
				m_type = value;
			}
		}

		public itemNode.audioSurface audio
		{
			get
			{
				return m_audioId;
			}
			set
			{
				m_audioId = value;
			}
		}

		public Vector3 position
		{
			get
			{
				float num = (float)m_height * -0.06f;
				if (m_foreground)
				{
					num += -6f;
				}
				num += ((float)m_y + 0.5f) * 0.01f;
				return new Vector3((float)(m_x + 1) * 0.01f, ((float)m_y + 0.5f) * 0.01f, num);
			}
		}

		public Vector3 positionLeft
		{
			get
			{
				float num = (float)m_height * -0.06f;
				if (m_type == itemNode.nodeType.zone2)
				{
					num += (float)m_y * -0.0001f;
				}
				num -= (float)m_x * 0.003f;
				return new Vector3((float)(m_x + 1) * 0.01f, ((float)m_y + 0.5f) * 0.01f, num);
			}
		}

		public Vector3 positionRight
		{
			get
			{
				float num = (float)m_height * -0.06f;
				if (m_type == itemNode.nodeType.zone2)
				{
					num += (float)m_y * -0.0001f;
				}
				num += (float)m_x * 0.003f;
				return new Vector3((float)(m_x + 1) * 0.01f, ((float)m_y + 0.5f) * 0.01f, num);
			}
		}

		public nodeData(int _x, int _y, int _height, int _size, itemNode.nodeType _type, itemNode.audioSurface _audio, bool _nonVisible, bool _foreground, bool _bar, bool _rack)
		{
			m_x = _x;
			m_y = _y;
			m_height = _height;
			m_size = _size;
			m_type = _type;
			m_audioId = _audio;
			m_nonVisible = _nonVisible;
			m_foreground = _foreground;
			m_bar = _bar;
			m_rack = _rack;
		}

		public nodeData Clone()
		{
			return new nodeData(m_x, m_y, m_height, m_size, m_type, m_audioId, m_nonVisible, m_foreground, m_bar, m_rack);
		}

		public void Offset(int _xOffset, int _yOffset)
		{
			m_x += _xOffset;
			m_y += _yOffset;
		}
	}

	[Serializable]
	public struct itemNode
	{
		public enum nodeStyle
		{
			flat = 0,
			hook = 1,
			vertical = 2,
			verticalFlipped = 3,
			hookFlipped = 4,
			holder = 5,
			holderFlipped = 6,
			bar = 7,
			barFlipped = 8,
			rack = 9,
			rackFlipped = 10
		}

		public enum nodeType
		{
			none = 0,
			zone1 = 2,
			zone2 = 4,
			zone3 = 8,
			zone4 = 0x10,
			zone5 = 0x20,
			zone6 = 0x40,
			zone7 = 0x80,
			zone8 = 0x100,
			zone9 = 0x200,
			zone10 = 0x400,
			zone11 = 0x800,
			zone12 = 0x1000,
			zone13 = 0x2000,
			zone14 = 0x4000,
			zone15 = 0x8000,
			overflow = 0x10000
		}

		public enum audioSurface
		{
			bed = 0,
			benchtop = 1,
			box = 2,
			carpet = 3,
			ceramic = 4,
			glass = 5,
			linoleum = 6,
			plastic = 7,
			shelf = 8,
			sink = 9,
			stove = 10,
			tile = 11,
			woodfloor = 12
		}

		public bool m_active;

		public bool m_nonVisible;

		public bool m_foreground;

		public bool m_boxTop;

		[SerializeField]
		private int m_x;

		[SerializeField]
		private int m_y;

		[SerializeField]
		private int m_height;

		[SerializeField]
		private int m_size;

		private int m_sizeTemp;

		[SerializeField]
		private nodeType m_type;

		public nodeStyle m_style;

		[SerializeField]
		private Vector3 m_position;

		[SerializeField]
		private audioSurface m_audioId;

		public bool m_used;

		public int m_usedSize;

		public int m_boxSize;

		public int[] m_connections;

		public int[] m_inverseNodes;

		private Transform m_parent;

		public int m_maskLevel;

		public int x => m_x;

		public int y => m_y;

		public int height => m_height;

		public string audio => m_audioId.ToString();

		public Transform parent => m_parent;

		public int size
		{
			get
			{
				return Mathf.Min(m_size, m_sizeTemp);
			}
			set
			{
				m_sizeTemp = value;
			}
		}

		public int sizeFull => m_size;

		public bool valid => !m_nonVisible;

		public nodeType type => m_type;

		public bool wall
		{
			get
			{
				if (m_style != nodeStyle.vertical)
				{
					return m_style == nodeStyle.verticalFlipped;
				}
				return true;
			}
		}

		public bool selectable
		{
			get
			{
				if (!m_used)
				{
					return m_type != nodeType.overflow;
				}
				return false;
			}
		}

		public Vector3 position => m_position;

		public float depth => m_position.z;

		public itemNode(nodeData _node, nodeStyle _style)
		{
			m_active = true;
			m_nonVisible = _node.m_nonVisible;
			m_foreground = _node.m_foreground;
			m_boxTop = false;
			m_x = _node.x;
			m_y = _node.y;
			m_height = _node.height;
			m_size = _node.size;
			m_sizeTemp = 99;
			m_type = _node.type;
			m_audioId = _node.audio;
			m_used = false;
			m_usedSize = 0;
			switch (_style)
			{
			case nodeStyle.vertical:
				m_position = _node.positionLeft;
				break;
			case nodeStyle.verticalFlipped:
				m_position = _node.positionRight;
				break;
			default:
				m_position = _node.position;
				break;
			}
			m_connections = new int[4];
			for (int i = 0; i < 4; i++)
			{
				m_connections[i] = -1;
			}
			m_inverseNodes = new int[0];
			m_style = (_node.m_bar ? nodeStyle.bar : (_node.m_rack ? nodeStyle.rack : _style));
			m_parent = null;
			m_maskLevel = 0;
			m_boxSize = 0;
		}

		public itemNode(int x, int y, int height, int size, nodeType type, audioSurface audioId, Transform parent, int _boxSize)
		{
			m_active = true;
			m_nonVisible = false;
			m_foreground = false;
			m_boxTop = false;
			m_x = x;
			m_y = y;
			m_height = height;
			m_size = size;
			m_sizeTemp = 99;
			m_type = type;
			m_audioId = audioId;
			m_used = false;
			m_usedSize = 0;
			float num = 0f;
			num += (float)m_height * -0.06f;
			num += ((float)m_y + 0.5f) * 0.01f;
			m_position = new Vector3((float)(m_x + 1) * 0.01f, ((float)m_y + 0.5f) * 0.01f, num * ((_boxSize > 0) ? 0.5f : 1f));
			m_connections = new int[4];
			for (int i = 0; i < 4; i++)
			{
				m_connections[i] = -1;
			}
			m_inverseNodes = new int[0];
			m_style = nodeStyle.flat;
			m_parent = parent;
			m_maskLevel = 0;
			m_boxSize = _boxSize;
		}

		public itemNode(Vector3 _position, nodeType type, hookScript.hookType hookType, int size, Transform parent, int[] _inverseNodes)
		{
			m_active = true;
			m_nonVisible = false;
			m_foreground = false;
			m_boxTop = false;
			m_x = 0;
			m_y = 0;
			m_height = -1;
			m_size = size;
			m_sizeTemp = 99;
			m_type = type;
			m_audioId = audioSurface.tile;
			m_used = false;
			m_usedSize = 0;
			m_position = _position;
			m_connections = new int[4];
			for (int i = 0; i < 4; i++)
			{
				m_connections[i] = -1;
			}
			m_inverseNodes = new int[_inverseNodes.Length];
			for (int j = 0; j < m_inverseNodes.Length; j++)
			{
				m_inverseNodes[j] = _inverseNodes[j];
			}
			m_style = nodeStyle.flat;
			switch (hookType)
			{
			case hookScript.hookType.hook:
				m_style = nodeStyle.hook;
				break;
			case hookScript.hookType.hookFlipped:
				m_style = nodeStyle.hookFlipped;
				break;
			case hookScript.hookType.holder:
				m_style = nodeStyle.holder;
				break;
			case hookScript.hookType.holderFlipped:
				m_style = nodeStyle.holderFlipped;
				break;
			}
			m_parent = parent;
			m_maskLevel = 0;
			m_boxSize = 0;
		}

		public itemNode(int _x, int _y, int _height, int _size, nodeType _type, nodeStyle _style, int[] _inverseNodes)
		{
			m_active = true;
			m_nonVisible = false;
			m_foreground = false;
			m_boxTop = false;
			m_x = _x;
			m_y = _y;
			m_height = _height;
			m_size = _size;
			m_sizeTemp = 99;
			m_type = _type;
			m_audioId = audioSurface.tile;
			m_used = false;
			m_usedSize = 0;
			float num = 0f;
			num += (float)m_height * -0.06f;
			num += ((float)m_y + 0.5f) * 0.01f;
			m_position = new Vector3((float)(m_x + 1) * 0.01f, ((float)m_y + 0.5f) * 0.01f, num);
			m_connections = new int[4];
			for (int i = 0; i < 4; i++)
			{
				m_connections[i] = -1;
			}
			m_inverseNodes = new int[_inverseNodes.Length];
			for (int j = 0; j < m_inverseNodes.Length; j++)
			{
				m_inverseNodes[j] = _inverseNodes[j];
			}
			m_style = _style;
			m_parent = null;
			m_maskLevel = 0;
			m_boxSize = 0;
		}

		public void Offset(Vector3 _offset)
		{
			m_position += _offset;
		}

		public void Refresh()
		{
			m_sizeTemp = 99;
		}
	}

	public struct CheckResult
	{
		public bool result;

		public int value;

		public itemScript item;

		public CheckResult(int _value, itemScript _item)
		{
			result = _value != -1;
			value = _value;
			item = _item;
		}
	}

	private struct boxEntry
	{
		public int boxID;

		public int itemID;

		public itemScript item;

		public int itemVariant;

		public int itemState;

		public int boxOrder;

		public bool zonePacked;

		public boxEntry(int _ID, int _itemID, itemScript _item, int _itemVariant, int _itemState, int _boxOrder, bool _zonePacked)
		{
			boxID = _ID;
			itemID = _itemID;
			item = _item;
			itemVariant = _itemVariant;
			itemState = _itemState;
			boxOrder = _boxOrder;
			zonePacked = _zonePacked;
		}
	}

	private struct attachmentStates
	{
		public itemScript script;

		public int[] data;

		public attachmentStates(itemScript _script, int[] _data)
		{
			script = _script;
			data = _data;
		}
	}

	private struct searchNode : IComparable<searchNode>
	{
		public int index;

		public float distance;

		public searchNode(int _index, float _distance)
		{
			index = _index;
			distance = _distance;
		}

		public int CompareTo(searchNode _compare)
		{
			return distance.CompareTo(_compare.distance);
		}
	}

	private enum validType
	{
		any = 0,
		valid = 1,
		invalid = 2
	}

	private gameScript game;

	private Transform m_boxParticles;

	public int m_floorplanFloor;

	public Vector2 m_floorplanPosition = Vector2.zero;

	public Rect[] m_floorplanHighlight;

	public Bounds m_zoneBounds = new Bounds(Vector3.zero, Vector3.one);

	public zoneType m_type;

	public Color m_color = Color.white;

	public SpriteRenderer[] m_outline;

	public bool m_useAmbience = true;

	private string m_ambience;

	public boxMask[] m_boxMasks;

	private drawerManagerScript[] m_drawers;

	private doorScript[] m_doors;

	private doorFoldingScript[] m_doorsFolding;

	private doorSlidingScript[] m_doorsSliding;

	private shelfStandScript[] m_shelves;

	private environmentLampScript[] m_lamps;

	[HideInInspector]
	public nodeData[] m_nodeDataHorizontal;

	[HideInInspector]
	public nodeData[] m_nodeDataVerticalLeft;

	[HideInInspector]
	public nodeData[] m_nodeDataVerticalRight;

	private itemNode[] m_nodes;

	private List<int> m_nodesToRemove = new List<int>();

	private bool m_gridShowToggle;

	private bool m_gridDirty = true;

	private List<GameObject> m_gridShow;

	private GameObject m_gridShowValidRootNode;

	private List<itemScript> m_items = new List<itemScript>();

	private List<boxScript> m_boxes = new List<boxScript>();

	private List<itemScript> m_itemsUnmovable = new List<itemScript>();

	private List<itemScript> m_itemsMovable = new List<itemScript>();

	private List<itemScript> m_itemsLimbo = new List<itemScript>();

	private List<computerScript> m_computers = new List<computerScript>();

	private List<itemScript> m_proximityItems = new List<itemScript>();

	private List<KeyValuePair<Transform, Transform>> m_keepAlive = new List<KeyValuePair<Transform, Transform>>();

	private bool m_fileOpen;

	private bool m_levelLoad;

	private int m_validItems;

	private stickerUnlockAreaScript[] m_stickerUnlockAreas;

	private validAreaScript[] m_validAreas;

	private limitedHeightAreaScript[] m_limitedHeightAreas;

	private televisionDisplayScript m_television;

	[HideInInspector]
	public List<itemData> m_loadedItemData = new List<itemData>();

	[HideInInspector]
	public List<boxData> m_loadedBoxData = new List<boxData>();

	[HideInInspector]
	public List<zonePackedData> m_loadedZonePacked = new List<zonePackedData>();

	private uint m_reverbID;

	public bool isLoad
	{
		get
		{
			if (!m_levelLoad)
			{
				return m_fileOpen;
			}
			return true;
		}
	}

	public uint reverbID
	{
		get
		{
			return m_reverbID;
		}
		set
		{
			m_reverbID = value;
		}
	}

	public bool isZoneValid => m_validItems == m_items.Count;

	public bool isZoneInvalid => m_validItems - m_itemsUnmovable.Count == 0;

	public void KeepAliveAdd(Transform _transform)
	{
		m_keepAlive.Add(new KeyValuePair<Transform, Transform>(_transform, _transform.parent));
	}

	public void KeepAliveRemove(Transform _transform)
	{
		for (int i = 0; i < m_keepAlive.Count; i++)
		{
			if (m_keepAlive[i].Key.Equals(_transform))
			{
				m_keepAlive.RemoveAt(i);
				break;
			}
		}
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.yellow;
		Gizmos.DrawWireCube(m_zoneBounds.center, m_zoneBounds.size);
	}

	public void SetAmbience(GameObject go)
	{
		if (m_useAmbience && !string.IsNullOrEmpty(m_ambience))
		{
			AkSoundEngine.SetState("Room_State", m_ambience);
			AkSoundEngine.PostEvent("Seek" + m_ambience, go);
		}
	}

	public void SetOutlineColor()
	{
		if (m_outline != null)
		{
			for (int i = 0; i < m_outline.Length; i++)
			{
				m_outline[i].sortingOrder = 0;
				m_outline[i].color = Color.white;
			}
		}
	}

	public void SetOutlineColor(Color _color)
	{
		if (m_outline != null)
		{
			Color.RGBToHSV(_color, out var H, out var S, out var V);
			Color color = Color.HSVToRGB(H, S * 1.35f, V * 0.7f);
			for (int i = 0; i < m_outline.Length; i++)
			{
				m_outline[i].sortingOrder = -1;
				m_outline[i].color = color;
			}
		}
	}

	private void BeginGrid()
	{
		if (m_nodeDataHorizontal != null)
		{
			_ = m_nodeDataHorizontal.LongLength;
		}
		if (m_nodeDataHorizontal == null)
		{
			m_nodeDataHorizontal = new nodeData[0];
		}
		m_nodes = new itemNode[m_nodeDataHorizontal.Length + m_nodeDataVerticalLeft.Length + m_nodeDataVerticalRight.Length];
		for (int i = 0; i < m_nodeDataHorizontal.Length; i++)
		{
			m_nodes[i] = new itemNode(m_nodeDataHorizontal[i], itemNode.nodeStyle.flat);
		}
		for (int j = 0; j < m_nodeDataVerticalLeft.Length; j++)
		{
			m_nodes[m_nodeDataHorizontal.Length + j] = new itemNode(m_nodeDataVerticalLeft[j], itemNode.nodeStyle.vertical);
		}
		for (int k = 0; k < m_nodeDataVerticalRight.Length; k++)
		{
			m_nodes[m_nodeDataHorizontal.Length + m_nodeDataVerticalLeft.Length + k] = new itemNode(m_nodeDataVerticalRight[k], itemNode.nodeStyle.verticalFlipped);
		}
		FindNeighbours(m_nodes);
	}

	private void FindNeighbours(itemNode[] _nodes)
	{
		for (int i = 0; i < _nodes.Length; i++)
		{
			if (_nodes[i].m_style == itemNode.nodeStyle.flat || _nodes[i].m_style == itemNode.nodeStyle.bar || _nodes[i].m_style == itemNode.nodeStyle.barFlipped || _nodes[i].m_style == itemNode.nodeStyle.rack || _nodes[i].m_style == itemNode.nodeStyle.rackFlipped)
			{
				for (int j = 0; j < 4; j++)
				{
					_nodes[i].m_connections[j] = -1;
				}
				for (int k = 0; k < _nodes.Length; k++)
				{
					if (i != k && _nodes[i].height == _nodes[k].height)
					{
						if (_nodes[i].x == _nodes[k].x + 14 && _nodes[i].y == _nodes[k].y - 7)
						{
							_nodes[i].m_connections[0] = k;
						}
						else if (_nodes[i].x == _nodes[k].x - 14 && _nodes[i].y == _nodes[k].y - 7)
						{
							_nodes[i].m_connections[1] = k;
						}
						else if (_nodes[i].x == _nodes[k].x - 14 && _nodes[i].y == _nodes[k].y + 7)
						{
							_nodes[i].m_connections[2] = k;
						}
						else if (_nodes[i].x == _nodes[k].x + 14 && _nodes[i].y == _nodes[k].y + 7)
						{
							_nodes[i].m_connections[3] = k;
						}
					}
				}
			}
			else if (_nodes[i].m_style == itemNode.nodeStyle.vertical)
			{
				for (int l = 0; l < 4; l++)
				{
					_nodes[i].m_connections[l] = -1;
				}
				for (int m = 0; m < _nodes.Length; m++)
				{
					if (i != m && _nodes[i].height == _nodes[m].height)
					{
						if (_nodes[i].x == _nodes[m].x && _nodes[i].y == _nodes[m].y - 17)
						{
							_nodes[i].m_connections[0] = m;
						}
						else if (_nodes[i].x == _nodes[m].x + 14 && _nodes[i].y == _nodes[m].y - 7)
						{
							_nodes[i].m_connections[1] = m;
						}
						else if (_nodes[i].x == _nodes[m].x && _nodes[i].y == _nodes[m].y + 17)
						{
							_nodes[i].m_connections[2] = m;
						}
						else if (_nodes[i].x == _nodes[m].x - 14 && _nodes[i].y == _nodes[m].y + 7)
						{
							_nodes[i].m_connections[3] = m;
						}
					}
				}
			}
			else
			{
				if (_nodes[i].m_style != itemNode.nodeStyle.verticalFlipped)
				{
					continue;
				}
				for (int n = 0; n < 4; n++)
				{
					_nodes[i].m_connections[n] = -1;
				}
				for (int num = 0; num < _nodes.Length; num++)
				{
					if (i != num && _nodes[i].height == _nodes[num].height)
					{
						if (_nodes[i].x == _nodes[num].x && _nodes[i].y == _nodes[num].y - 17)
						{
							_nodes[i].m_connections[0] = num;
						}
						else if (_nodes[i].x == _nodes[num].x - 14 && _nodes[i].y == _nodes[num].y - 7)
						{
							_nodes[i].m_connections[1] = num;
						}
						else if (_nodes[i].x == _nodes[num].x && _nodes[i].y == _nodes[num].y + 17)
						{
							_nodes[i].m_connections[2] = num;
						}
						else if (_nodes[i].x == _nodes[num].x + 14 && _nodes[i].y == _nodes[num].y + 7)
						{
							_nodes[i].m_connections[3] = num;
						}
					}
				}
			}
		}
	}

	public int ExpandGridRackBar(bool _rack, Vector3 _startPos, direction _direction, int _segments, int _height, int _size, itemNode.nodeType _type, Vector3 _groundPos, int _groundDepth)
	{
		itemNode[] nodes = m_nodes;
		m_nodes = new itemNode[nodes.Length + _segments];
		for (int i = 0; i < nodes.Length; i++)
		{
			m_nodes[i] = nodes[i];
		}
		int num = Mathf.RoundToInt(_startPos.x / 0.01f - 1f);
		int num2 = Mathf.RoundToInt(_startPos.y / 0.01f - 0.5f);
		int num3 = ((_direction == direction.xAxis || _direction == direction.yAxisNeg) ? 14 : (-14));
		int num4 = ((_direction == direction.xAxis || _direction == direction.yAxis) ? 7 : (-7));
		itemNode.nodeStyle style = ((!_rack) ? ((_direction == direction.xAxis || _direction == direction.xAxisNeg) ? itemNode.nodeStyle.barFlipped : itemNode.nodeStyle.bar) : ((_direction == direction.xAxis || _direction == direction.xAxisNeg) ? itemNode.nodeStyle.rack : itemNode.nodeStyle.rackFlipped));
		int[] array = new int[_groundDepth];
		for (int j = 0; j < _segments; j++)
		{
			int x = num + j * num3;
			int y = num2 + j * num4;
			for (int k = 0; k < _groundDepth; k++)
			{
				array[k] = FindClosestGrid(_groundPos + new Vector3(num3 * j + num3 * k, num4 * j - num4 * k, 0f) * 0.01f, _flat: true);
				if (array[k] == -1)
				{
					Debug.LogWarning("ExpandGridRackBar could not find inverse node segment " + j + ", depth " + k);
				}
				else
				{
					m_nodes[array[k]].m_inverseNodes = new int[1] { nodes.Length + j };
				}
			}
			m_nodes[nodes.Length + j] = new itemNode(x, y, _height, _size, _type, style, array);
		}
		for (int l = nodes.Length; l < m_nodes.Length; l++)
		{
			for (int m = nodes.Length; m < m_nodes.Length; m++)
			{
				if (l != m && m_nodes[l].height == m_nodes[m].height)
				{
					if (m_nodes[l].x == m_nodes[m].x + 14 && m_nodes[l].y == m_nodes[m].y - 7)
					{
						m_nodes[l].m_connections[0] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x - 14 && m_nodes[l].y == m_nodes[m].y - 7)
					{
						m_nodes[l].m_connections[1] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x - 14 && m_nodes[l].y == m_nodes[m].y + 7)
					{
						m_nodes[l].m_connections[2] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x + 14 && m_nodes[l].y == m_nodes[m].y + 7)
					{
						m_nodes[l].m_connections[3] = m;
					}
				}
			}
		}
		return nodes.Length;
	}

	public int ExpandGrid(Vector3 _startPos, int _xCount, int _yCount, int _height, int _size, Transform _parent, itemNode.nodeType _type, itemNode.audioSurface _audio, int _boxSize)
	{
		itemNode[] nodes = m_nodes;
		m_nodes = new itemNode[nodes.Length + _xCount * _yCount];
		for (int i = 0; i < nodes.Length; i++)
		{
			m_nodes[i] = nodes[i];
		}
		int num = Mathf.RoundToInt(_startPos.x / 0.01f - 1f);
		int num2 = Mathf.RoundToInt(_startPos.y / 0.01f - 0.5f);
		for (int j = 0; j < _xCount; j++)
		{
			for (int k = 0; k < _yCount; k++)
			{
				int x = num + j * 14 - k * 14;
				int y = num2 + j * 7 + k * 7;
				m_nodes[nodes.Length + j * _yCount + k] = new itemNode(x, y, _height, _size, _type, _audio, _parent, _boxSize);
			}
		}
		for (int l = nodes.Length; l < m_nodes.Length; l++)
		{
			for (int m = nodes.Length; m < m_nodes.Length; m++)
			{
				if (l != m && m_nodes[l].height == m_nodes[m].height)
				{
					if (m_nodes[l].x == m_nodes[m].x + 14 && m_nodes[l].y == m_nodes[m].y - 7)
					{
						m_nodes[l].m_connections[0] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x - 14 && m_nodes[l].y == m_nodes[m].y - 7)
					{
						m_nodes[l].m_connections[1] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x - 14 && m_nodes[l].y == m_nodes[m].y + 7)
					{
						m_nodes[l].m_connections[2] = m;
					}
					else if (m_nodes[l].x == m_nodes[m].x + 14 && m_nodes[l].y == m_nodes[m].y + 7)
					{
						m_nodes[l].m_connections[3] = m;
					}
				}
			}
		}
		return nodes.Length;
	}

	public void RemoveGrid(int _startIndex, int _xCount, int _yCount)
	{
		int num = _startIndex;
		for (int i = 0; i < _xCount; i++)
		{
			int num2 = num;
			for (int j = 0; j < _yCount; j++)
			{
				m_nodesToRemove.Add(num2);
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
	}

	private void RemoveMarkedNodes()
	{
		if (m_nodes == null || m_nodesToRemove.Count == 0)
		{
			return;
		}
		itemNode[] nodes = m_nodes;
		m_nodes = new itemNode[nodes.Length - m_nodesToRemove.Count];
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		int i = 0;
		for (int j = 0; j < m_nodes.Length; j++)
		{
			for (; i < nodes.Length && m_nodesToRemove.Contains(i); i++)
			{
			}
			m_nodes[j] = nodes[i];
			if (j != i)
			{
				dictionary.Add(i, j);
			}
			i++;
		}
		m_nodesToRemove.Clear();
		if (dictionary.Count <= 0)
		{
			return;
		}
		for (int k = 0; k < m_nodes.Length; k++)
		{
			for (int l = 0; l < 4; l++)
			{
				if (dictionary.ContainsKey(m_nodes[k].m_connections[l]))
				{
					m_nodes[k].m_connections[l] = dictionary[m_nodes[k].m_connections[l]];
				}
			}
			for (int m = 0; m < m_nodes[k].m_inverseNodes.Length; m++)
			{
				if (dictionary.ContainsKey(m_nodes[k].m_inverseNodes[m]))
				{
					m_nodes[k].m_inverseNodes[m] = dictionary[m_nodes[k].m_inverseNodes[m]];
				}
			}
		}
	}

	public int AddGrid(Vector3 _pos, Transform _parent, hookScript.hookType _hookType, itemNode.nodeType _type, int size, Vector3 _groundNode)
	{
		itemNode[] nodes = m_nodes;
		m_nodes = new itemNode[nodes.Length + 1];
		for (int i = 0; i < nodes.Length; i++)
		{
			m_nodes[i] = nodes[i];
		}
		int[] array = new int[(size < 99) ? 1 : 0];
		if (size < 99)
		{
			int num = FindClosestGrid(_groundNode, _flat: true);
			if (num != -1)
			{
				array[0] = num;
				m_nodes[num].m_inverseNodes = new int[1] { nodes.Length };
			}
			else
			{
				Debug.LogWarning("hook " + _parent.name + " failed to find ground node at offset " + _groundNode);
				array = new int[0];
			}
		}
		m_nodes[nodes.Length] = new itemNode(_pos, _type, _hookType, size, _parent, array);
		return nodes.Length;
	}

	public void DrawGrid()
	{
		m_gridDirty = false;
		m_gridShowToggle = !m_gridShowToggle;
		if (m_gridShowToggle)
		{
			for (int i = 0; i < m_nodes.Length; i++)
			{
				GameObject gameObject = new GameObject("grid");
				gameObject.AddComponent<SpriteRenderer>();
				gameObject.GetComponent<SpriteRenderer>().sprite = game.m_grid;
				if (m_nodes[i].m_style == itemNode.nodeStyle.vertical)
				{
					gameObject.GetComponent<SpriteRenderer>().sprite = game.m_gridVertical;
					gameObject.GetComponent<SpriteRenderer>().flipX = true;
				}
				else if (m_nodes[i].m_style == itemNode.nodeStyle.verticalFlipped)
				{
					gameObject.GetComponent<SpriteRenderer>().sprite = game.m_gridVertical;
				}
				gameObject.transform.localPosition = m_nodes[i].position;
				gameObject.GetComponent<SpriteRenderer>().sortingOrder = 11;
				if (m_nodes[i].m_used)
				{
					gameObject.GetComponent<SpriteRenderer>().color = Color.magenta;
				}
				else if (m_nodes[i].m_maskLevel == -1)
				{
					gameObject.GetComponent<SpriteRenderer>().color = Color.yellow;
				}
				else
				{
					gameObject.GetComponent<SpriteRenderer>().color = new Color((float)m_nodes[i].size * 0.1f, 1f, m_nodes[i].m_active ? 1f : 0f);
				}
				m_gridShow.Add(gameObject);
				for (int j = 0; j < 4; j++)
				{
					if (m_nodes[i].m_connections[j] != -1)
					{
						GameObject gameObject2 = new GameObject("join");
						gameObject2.AddComponent<SpriteRenderer>();
						gameObject2.GetComponent<SpriteRenderer>().sprite = game.m_join;
						gameObject2.transform.localPosition = m_nodes[i].position;
						if (j == 1 || j == 2)
						{
							gameObject2.GetComponent<SpriteRenderer>().flipX = true;
						}
						if (j == 2 || j == 3)
						{
							gameObject2.GetComponent<SpriteRenderer>().flipY = true;
						}
						m_gridShow.Add(gameObject2);
					}
				}
			}
			return;
		}
		foreach (GameObject item in m_gridShow)
		{
			UnityEngine.Object.Destroy(item);
		}
		m_gridShow.Clear();
	}

	public void ShowGridValid(itemScript _item)
	{
		if (_item == null)
		{
			ClearGridValid();
		}
		else
		{
			ShowGridValid(_item.m_zonesKitchen, _item.m_zonesBedroom, _item.m_zonesBathroom, _item.m_zonesLivingRoom, _item.m_zonesDiningRoom, _item.m_zonesOffice, _item.m_zonesNursery, _item.m_zonesWall);
		}
	}

	public void ShowGridValid(zoneKitchen _kitchen, zoneBedroom _bedroom, zoneBathroom _bathroom, zoneLivingRoom _livingRoom, zoneDiningRoom _diningRoom, zoneOffice _office, zoneNursery _nursery, zoneWall _wall)
	{
		ClearGridValid();
		m_gridShowValidRootNode = new GameObject("gridValid");
		m_gridShowValidRootNode.hideFlags = HideFlags.HideAndDontSave;
		Transform parent = m_gridShowValidRootNode.transform;
		itemNode.nodeType nodeType = itemNode.nodeType.none;
		if (m_type == zoneType.kitchen)
		{
			nodeType = (itemNode.nodeType)_kitchen;
		}
		else if (m_type == zoneType.bedroom || m_type == zoneType.closet)
		{
			nodeType = (itemNode.nodeType)_bedroom;
		}
		else if (m_type == zoneType.bathroom || m_type == zoneType.toilet)
		{
			nodeType = (itemNode.nodeType)_bathroom;
		}
		else if (m_type == zoneType.livingroom || m_type == zoneType.foyer)
		{
			nodeType = (itemNode.nodeType)_livingRoom;
		}
		else if (m_type == zoneType.diningroom)
		{
			nodeType = (itemNode.nodeType)_diningRoom;
		}
		else if (m_type == zoneType.office)
		{
			nodeType = (itemNode.nodeType)_office;
		}
		else if (m_type == zoneType.nursery)
		{
			nodeType = (itemNode.nodeType)_nursery;
		}
		Color color = new Color(0.1f, 1f, 0.1f, 0.5f);
		Color color2 = new Color(1f, 1f, 0.1f, 0.5f);
		Color color3 = new Color(1f, 0.1f, 0.1f, 0.5f);
		for (int i = 0; i < m_nodes.Length; i++)
		{
			GameObject gameObject = new GameObject("grid");
			gameObject.AddComponent<SpriteRenderer>();
			gameObject.GetComponent<SpriteRenderer>().sprite = game.m_grid;
			if (m_nodes[i].m_style == itemNode.nodeStyle.vertical)
			{
				gameObject.GetComponent<SpriteRenderer>().sprite = game.m_gridVertical;
				gameObject.GetComponent<SpriteRenderer>().flipX = true;
			}
			else if (m_nodes[i].m_style == itemNode.nodeStyle.verticalFlipped)
			{
				gameObject.GetComponent<SpriteRenderer>().sprite = game.m_gridVertical;
			}
			gameObject.transform.localPosition = m_nodes[i].position;
			gameObject.GetComponent<SpriteRenderer>().sortingOrder = 11;
			if (m_nodes[i].type == itemNode.nodeType.overflow)
			{
				gameObject.GetComponent<SpriteRenderer>().color = color2;
			}
			else if (m_nodes[i].m_style == itemNode.nodeStyle.vertical || m_nodes[i].m_style == itemNode.nodeStyle.verticalFlipped)
			{
				if (m_nodes[i].type != itemNode.nodeType.none && ((uint)_wall & (uint)m_nodes[i].type) == (uint)m_nodes[i].type)
				{
					gameObject.GetComponent<SpriteRenderer>().color = color;
				}
				else
				{
					gameObject.GetComponent<SpriteRenderer>().color = color3;
				}
			}
			else if (m_nodes[i].type != itemNode.nodeType.none && (nodeType & m_nodes[i].type) == m_nodes[i].type)
			{
				gameObject.GetComponent<SpriteRenderer>().color = color;
			}
			else
			{
				gameObject.GetComponent<SpriteRenderer>().color = color3;
			}
			gameObject.transform.parent = parent;
		}
	}

	public void ClearGridValid()
	{
		if (m_gridShowValidRootNode != null)
		{
			UnityEngine.Object.Destroy(m_gridShowValidRootNode);
			m_gridShowValidRootNode = null;
		}
	}

	public string[] RoomNames()
	{
		string[] names = Enum.GetNames(typeof(zoneType));
		string[] array = new string[names.Length + 1];
		array[0] = "show all";
		for (int i = 0; i < names.Length; i++)
		{
			if (m_type == (zoneType)i)
			{
				array[i + 1] = "[" + names[i] + "]";
			}
			else
			{
				array[i + 1] = names[i];
			}
		}
		return array;
	}

	public string[] ZoneNames(int _zoneType)
	{
		string[] array = new string[1];
		switch (_zoneType)
		{
		case 0:
			array = Enum.GetNames(typeof(zoneKitchen));
			break;
		case 1:
		case 8:
			array = Enum.GetNames(typeof(zoneBedroom));
			break;
		case 3:
		case 9:
			array = Enum.GetNames(typeof(zoneBathroom));
			break;
		case 2:
		case 10:
			array = Enum.GetNames(typeof(zoneLivingRoom));
			break;
		case 5:
			array = Enum.GetNames(typeof(zoneDiningRoom));
			break;
		case 6:
			array = Enum.GetNames(typeof(zoneOffice));
			break;
		case 7:
			array = Enum.GetNames(typeof(zoneNursery));
			break;
		case 4:
			array = Enum.GetNames(typeof(zoneWall));
			break;
		}
		if (array.Length != 0)
		{
			array[0] = "show all";
		}
		return array;
	}

	public void Init(gameScript _game)
	{
		game = _game;
		m_boxParticles = UnityEngine.Object.Instantiate(game.m_boxParticles);
		m_gridShow = new List<GameObject>();
		BeginGrid();
		hookScript[] componentsInChildren = base.gameObject.GetComponentsInChildren<hookScript>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].Register(this);
		}
		rackBarScript[] componentsInChildren2 = base.gameObject.GetComponentsInChildren<rackBarScript>(includeInactive: true);
		for (int j = 0; j < componentsInChildren2.Length; j++)
		{
			componentsInChildren2[j].Register(this);
		}
		int num = 0;
		m_drawers = base.gameObject.GetComponentsInChildren<drawerManagerScript>(includeInactive: true);
		for (int k = 0; k < m_drawers.Length; k++)
		{
			num = m_drawers[k].Register(this, num);
		}
		m_doors = base.gameObject.GetComponentsInChildren<doorScript>(includeInactive: true);
		for (int l = 0; l < m_doors.Length; l++)
		{
			m_doors[l].Register(this, num);
			num++;
		}
		m_doorsFolding = base.gameObject.GetComponentsInChildren<doorFoldingScript>(includeInactive: true);
		for (int m = 0; m < m_doorsFolding.Length; m++)
		{
			m_doorsFolding[m].Register(this, num);
			num++;
		}
		m_doorsSliding = base.gameObject.GetComponentsInChildren<doorSlidingScript>(includeInactive: true);
		for (int n = 0; n < m_doorsSliding.Length; n++)
		{
			m_doorsSliding[n].Register(this, num);
			num++;
		}
		m_shelves = base.gameObject.GetComponentsInChildren<shelfStandScript>(includeInactive: true);
		for (int num2 = 0; num2 < m_shelves.Length; num2++)
		{
			m_shelves[num2].Register(this);
		}
		m_ambience = "_" + base.gameObject.name;
		m_stickerUnlockAreas = base.gameObject.GetComponentsInChildren<stickerUnlockAreaScript>(includeInactive: true);
		for (int num3 = 0; num3 < m_stickerUnlockAreas.Length; num3++)
		{
			m_stickerUnlockAreas[num3].Register(this);
		}
		m_validAreas = base.gameObject.GetComponentsInChildren<validAreaScript>(includeInactive: true);
		for (int num4 = 0; num4 < m_validAreas.Length; num4++)
		{
			m_validAreas[num4].Register(this);
		}
		m_limitedHeightAreas = base.gameObject.GetComponentsInChildren<limitedHeightAreaScript>(includeInactive: true);
		for (int num5 = 0; num5 < m_limitedHeightAreas.Length; num5++)
		{
			m_limitedHeightAreas[num5].Register(this);
		}
		m_television = base.gameObject.GetComponentInChildren<televisionDisplayScript>(includeInactive: true);
		if (m_television != null)
		{
			m_television.Init();
		}
		simpleLayerMaskScript[] componentsInChildren3 = base.gameObject.GetComponentsInChildren<simpleLayerMaskScript>(includeInactive: true);
		for (int num6 = 0; num6 < componentsInChildren3.Length; num6++)
		{
			componentsInChildren3[num6].Init(this);
		}
		m_lamps = base.gameObject.GetComponentsInChildren<environmentLampScript>(includeInactive: true);
		for (int num7 = 0; num7 < m_lamps.Length; num7++)
		{
			m_lamps[num7].Register(this, num);
			num++;
		}
	}

	private void LateUpdate()
	{
		if (m_gridShowToggle && m_gridDirty)
		{
			DrawGrid();
			DrawGrid();
		}
	}

	public void HideGrid()
	{
		if (m_gridShowToggle)
		{
			DrawGrid();
		}
	}

	private bool IsHookOrHolder(itemNode.nodeStyle _style)
	{
		if (_style != itemNode.nodeStyle.hook && _style != itemNode.nodeStyle.hookFlipped && _style != itemNode.nodeStyle.holder)
		{
			return _style == itemNode.nodeStyle.holderFlipped;
		}
		return true;
	}

	public int[] GetAllGridsWithinPolygon(PolygonCollider2D _polygon, bool _wallNodes = false)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if ((IsHookOrHolder(m_nodes[i].m_style) || m_nodes[i].parent == null) && _wallNodes == GetWall(i))
			{
				Vector2 point = m_nodes[i].position;
				if (_polygon.OverlapPoint(point))
				{
					list.Add(i);
				}
			}
		}
		return list.ToArray();
	}

	public int[] GetAllGridsConnected(Vector2 _startPosition)
	{
		int closestGrid = GetClosestGrid(_startPosition);
		if (closestGrid == -1)
		{
			return new int[0];
		}
		return GetAllGridsConnected(closestGrid);
	}

	public int[] GetAllGridsConnected(int _index)
	{
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		list.Add(_index);
		list2.Add(_index);
		while (list2.Count > 0)
		{
			List<int> list3 = new List<int>();
			for (int i = 0; i < list2.Count; i++)
			{
				for (int j = 0; j < m_nodes[list2[i]].m_connections.Length; j++)
				{
					int num = m_nodes[list2[i]].m_connections[j];
					if (num != -1 && !list.Contains(num))
					{
						list.Add(num);
						list3.Add(num);
					}
				}
			}
			list2.Clear();
			list2.AddRange(list3);
		}
		return list.ToArray();
	}

	private int GetClosestGrid(Vector2 _position)
	{
		int result = -1;
		float num = float.PositiveInfinity;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			float num2 = Vector2.Distance(_position, m_nodes[i].position);
			if (num2 < 0.28f && num2 < num)
			{
				num = num2;
				result = i;
			}
		}
		return result;
	}

	public int GetClosestGridNoCheck(Vector2 _position, bool _boxCheck = false)
	{
		int result = -1;
		float num = float.PositiveInfinity;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!_boxCheck || !m_nodes[i].m_boxTop || m_nodes[i].m_active)
			{
				float num2 = Vector2.Distance(_position, m_nodes[i].position);
				if (num2 < 0.28f && num2 < num)
				{
					num = num2;
					result = i;
				}
			}
		}
		return result;
	}

	public int GetClosestGrid(Vector2 _cursor, bool _flat)
	{
		return GetClosestGrid(_cursor, _flat, -1, 0, 0, float.PositiveInfinity, -1);
	}

	public int GetClosestGrid(Vector2 _cursor, bool _flat, int _wall, int _size, int _footprint, float _minDepth, int _lastNode, bool _drawerOnly = false)
	{
		int num = -1;
		float num2 = 0.14f;
		bool flag = _minDepth < float.PositiveInfinity;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!m_nodes[i].m_active || ((!_flat || m_nodes[i].m_style != itemNode.nodeStyle.flat) && (_flat || (m_nodes[i].m_style != itemNode.nodeStyle.vertical && m_nodes[i].m_style != itemNode.nodeStyle.verticalFlipped))) || m_nodes[i].m_used || m_nodes[i].size < _size || (_footprint <= 1 && !m_nodes[i].valid) || (m_nodes[i].height == 1 && flag) || !(m_nodes[i].position.z < _minDepth) || (_drawerOnly && (!(m_nodes[i].parent != null) || !m_nodes[i].parent.CompareTag("drawer"))))
			{
				continue;
			}
			if (!_flat)
			{
				if (m_nodes[i].type == itemNode.nodeType.zone2 || m_nodes[i].type == itemNode.nodeType.zone3)
				{
					if (_wall == 0 || ((uint)_wall & (uint)m_nodes[i].type) != (uint)m_nodes[i].type)
					{
						continue;
					}
				}
				else if (_wall != 0 && (_wall & 0xC) == _wall)
				{
					continue;
				}
			}
			Vector2 vector = _cursor - (Vector2)m_nodes[i].position;
			float num3 = ((_lastNode == -1 || m_nodes[i].height != m_nodes[_lastNode].height) ? 0f : ((_lastNode != i) ? 0.03f : 0.09f));
			if (i == _lastNode || (!(Mathf.Abs(vector.x) - num3 > num2) && !(Mathf.Abs(vector.y) - num3 > num2)))
			{
				float num4 = vector.magnitude - num3;
				if (num4 < num2)
				{
					num2 = num4;
					num = i;
				}
			}
		}
		if (num != -1)
		{
			Debug.DrawRay(m_nodes[num].position, Vector3.up * 0.1f, Color.red);
		}
		return num;
	}

	public int GetClosestBar(Vector2 _cursor, int _size, int _width, float _minDepth, int _lastNode)
	{
		int result = -1;
		float num = 0.21f;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!m_nodes[i].m_active || (m_nodes[i].m_style != itemNode.nodeStyle.bar && m_nodes[i].m_style != itemNode.nodeStyle.barFlipped) || m_nodes[i].m_used || m_nodes[i].size < _size || !(m_nodes[i].position.z < _minDepth))
			{
				continue;
			}
			float num2 = Vector2.Distance(_cursor, m_nodes[i].position);
			if (_lastNode != -1)
			{
				if (m_nodes[i].height == m_nodes[_lastNode].height)
				{
					num2 -= 0.03f;
				}
				if (i == _lastNode)
				{
					num2 -= 0.06f;
				}
			}
			if (num2 < num)
			{
				num = num2;
				result = i;
			}
		}
		return result;
	}

	public int GetClosestRack(Vector2 _cursor, int _size, float _minDepth, int _lastNode)
	{
		int result = -1;
		float num = 0.21f;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!m_nodes[i].m_active || (m_nodes[i].m_style != itemNode.nodeStyle.rack && m_nodes[i].m_style != itemNode.nodeStyle.rackFlipped) || m_nodes[i].m_used || m_nodes[i].size < _size || !(m_nodes[i].position.z < _minDepth))
			{
				continue;
			}
			float num2 = Vector2.Distance(_cursor, m_nodes[i].position);
			if (_lastNode != -1)
			{
				if (m_nodes[i].height == m_nodes[_lastNode].height)
				{
					num2 -= 0.03f;
				}
				if (i == _lastNode)
				{
					num2 -= 0.06f;
				}
			}
			if (num2 < num)
			{
				num = num2;
				result = i;
			}
		}
		return result;
	}

	public int FindClosestGrid(Vector2 _cursor, bool _flat)
	{
		int result = -1;
		float num = 0.14f;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if ((_flat && m_nodes[i].m_style == itemNode.nodeStyle.flat) || (!_flat && (m_nodes[i].m_style == itemNode.nodeStyle.vertical || m_nodes[i].m_style == itemNode.nodeStyle.verticalFlipped)))
			{
				float num2 = Vector2.Distance(_cursor, m_nodes[i].position);
				if (num2 < num)
				{
					num = num2;
					result = i;
				}
			}
		}
		return result;
	}

	private bool SingleNode(itemNode.nodeStyle _value)
	{
		if (_value != itemNode.nodeStyle.hook && _value != itemNode.nodeStyle.hookFlipped && _value != itemNode.nodeStyle.holder)
		{
			return _value == itemNode.nodeStyle.holderFlipped;
		}
		return true;
	}

	private bool SpecialNode(itemNode.nodeStyle _value)
	{
		if (_value != itemNode.nodeStyle.hook && _value != itemNode.nodeStyle.hookFlipped && _value != itemNode.nodeStyle.holder && _value != itemNode.nodeStyle.holderFlipped && _value != itemNode.nodeStyle.bar && _value != itemNode.nodeStyle.barFlipped && _value != itemNode.nodeStyle.rack)
		{
			return _value == itemNode.nodeStyle.rackFlipped;
		}
		return true;
	}

	public bool SetGrid(int _startIndex, int _xSteps, int _ySteps, bool _used, int _usedSize)
	{
		if (_startIndex != -1 && SingleNode(m_nodes[_startIndex].m_style))
		{
			m_nodes[_startIndex].m_used = _used;
			m_nodes[_startIndex].m_usedSize = _usedSize;
			if (m_nodes[_startIndex].m_inverseNodes.Length != 0)
			{
				_ = m_nodes[m_nodes[_startIndex].m_inverseNodes[0]].size;
				int num = (_used ? _usedSize : 0);
				m_nodes[m_nodes[_startIndex].m_inverseNodes[0]].size = ((num != 0) ? (m_nodes[m_nodes[_startIndex].m_inverseNodes[0]].sizeFull - num) : 99);
			}
			m_gridDirty = true;
			return true;
		}
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		int num2 = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num3 = num2;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num3 == -1)
				{
					Debug.LogWarning(base.gameObject.name + "!!! (SetGrid) " + _startIndex);
					return false;
				}
				list.Add(num3);
				for (int k = 0; k < m_nodes[num3].m_inverseNodes.Length; k++)
				{
					if (!list2.Contains(m_nodes[num3].m_inverseNodes[k]))
					{
						list2.Add(m_nodes[num3].m_inverseNodes[k]);
					}
				}
				num3 = m_nodes[num3].m_connections[0];
			}
			num2 = m_nodes[num2].m_connections[1];
		}
		foreach (int item in list)
		{
			m_nodes[item].m_used = _used;
			m_nodes[item].m_usedSize = _usedSize;
		}
		foreach (int item2 in list2)
		{
			int num4 = 0;
			for (int l = 0; l < m_nodes[item2].m_inverseNodes.Length; l++)
			{
				num4 = Mathf.Max(num4, m_nodes[m_nodes[item2].m_inverseNodes[l]].m_used ? m_nodes[m_nodes[item2].m_inverseNodes[l]].m_usedSize : 0);
			}
			m_nodes[item2].size = ((num4 != 0) ? (m_nodes[item2].sizeFull - num4) : 99);
		}
		m_gridDirty = true;
		return true;
	}

	public bool CheckGridHeight(int[] _indexes, int _minSize, int _maxSize)
	{
		for (int i = 0; i < _indexes.Length; i++)
		{
			if ((m_nodes[_indexes[i]].m_used && m_nodes[_indexes[i]].m_usedSize > _minSize) || m_nodes[_indexes[i]].size <= _maxSize)
			{
				return true;
			}
		}
		return false;
	}

	public itemScript GetItemOnGrid(int _index)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Node() == _index)
			{
				itemScript itemScript2 = m_items[i];
				while (itemScript2.stackChild != null)
				{
					itemScript2 = itemScript2.stackChild;
				}
				return itemScript2;
			}
		}
		return null;
	}

	public itemScript[] GetItemsOnGrids(int[] _indexes, int _minSize)
	{
		List<itemScript> list = new List<itemScript>();
		for (int i = 0; i < _indexes.Length; i++)
		{
			if (m_nodes[_indexes[i]].m_used && m_nodes[_indexes[i]].m_usedSize > _minSize)
			{
				itemScript itemScript2 = FindItem(_indexes[i]);
				if (itemScript2 != null && !list.Contains(itemScript2))
				{
					list.Add(itemScript2);
				}
			}
		}
		return list.ToArray();
	}

	public itemScript GetItemOnGrid(int _index, int _direction)
	{
		if (_direction == 0 || (_direction > 0 && m_nodes[_index].m_connections[1] == -1) || (_direction < 0 && m_nodes[_index].m_connections[3] == -1))
		{
			return null;
		}
		int num = m_nodes[_index].m_connections[(_direction > 0) ? 1 : 3];
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Node() == num)
			{
				return m_items[i];
			}
		}
		return null;
	}

	public CheckResult CheckGridHeight(int _startIndex, int _xSteps, int _ySteps, int _minSize, int _maxSize, direction _direction)
	{
		int num = -1;
		int num2 = -1;
		int num3 = _startIndex;
		itemScript item = null;
		for (int i = 0; i < _xSteps; i++)
		{
			int num4 = num3;
			for (int j = 0; j < _ySteps; j++)
			{
				if (m_nodes[num4].m_used && m_nodes[num4].m_usedSize > _minSize)
				{
					num2 = ((_direction == direction.xAxis || _direction == direction.yAxis) ? Mathf.Max(num2, (_direction == direction.xAxis) ? i : j) : ((num2 != -1) ? Mathf.Min(num2, (_direction == direction.xAxisNeg) ? i : j) : ((_direction == direction.xAxisNeg) ? i : j)));
					if (num != num2)
					{
						if (m_nodes[num4].m_used)
						{
							item = FindItem(num4);
						}
						num = num2;
					}
				}
				num4 = m_nodes[num4].m_connections[0];
			}
			num3 = m_nodes[num3].m_connections[1];
		}
		if (num2 > -1 && (_direction == direction.xAxisNeg || _direction == direction.yAxisNeg))
		{
			num2 = ((_direction == direction.xAxisNeg) ? (_xSteps - num2) : (_ySteps - num2));
		}
		return new CheckResult(num2, item);
	}

	public CheckResult CheckGrid(int _startIndex, int _xSteps, int _ySteps, int _size, direction _direction)
	{
		int num = -1;
		int num2 = -1;
		int num3 = _startIndex;
		itemScript item = null;
		for (int i = 0; i < _xSteps; i++)
		{
			int num4 = num3;
			for (int j = 0; j < _ySteps; j++)
			{
				if (m_nodes[num4].m_used && m_nodes[num4].m_usedSize > _size)
				{
					num2 = ((_direction == direction.xAxis || _direction == direction.yAxis) ? Mathf.Max(num2, (_direction == direction.xAxis) ? i : j) : ((num2 != -1) ? Mathf.Min(num2, (_direction == direction.xAxisNeg) ? i : j) : ((_direction == direction.xAxisNeg) ? i : j)));
					if (num != num2)
					{
						item = FindItem(num4);
						num = num2;
					}
				}
				num4 = m_nodes[num4].m_connections[0];
			}
			num3 = m_nodes[num3].m_connections[1];
		}
		if (num2 > -1 && (_direction == direction.xAxisNeg || _direction == direction.yAxisNeg))
		{
			num2 = ((_direction == direction.xAxisNeg) ? (_xSteps - num2) : (_ySteps - num2));
		}
		return new CheckResult(num2, item);
	}

	private itemScript FindItem(int _index)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Stacked() || m_items[i].isNonFlatState || !m_items[i].gameObject.activeSelf)
			{
				continue;
			}
			int num = m_items[i].Node();
			for (int j = 0; j < m_items[i].xWidth; j++)
			{
				int num2 = num;
				for (int k = 0; k < m_items[i].yWidth; k++)
				{
					if (num2 == -1)
					{
						Debug.LogWarning(base.gameObject.name + "!!! (FindItem) " + m_items[i].name);
						return null;
					}
					if (num2 == _index)
					{
						return m_items[i];
					}
					num2 = m_nodes[num2].m_connections[0];
				}
				num = m_nodes[num].m_connections[1];
			}
		}
		return null;
	}

	public bool FindStackTop(int _gridIndex, out itemScript _item)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Node() == _gridIndex)
			{
				_item = m_items[i].TopStack();
				return true;
			}
		}
		_item = null;
		return false;
	}

	public void SetGridSize(int _startIndex, int _xSteps, int _ySteps, int _size)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				m_nodes[num2].size = _size;
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		m_gridDirty = true;
	}

	public void SetGridSize(int[] _indexes, int _size)
	{
		for (int i = 0; i < _indexes.Length; i++)
		{
			m_nodes[_indexes[i]].size = _size;
		}
		m_gridDirty = true;
	}

	public void SetGridActive(int _startIndex, int _xSteps, int _ySteps, bool _active)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				m_nodes[num2].m_active = _active;
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		m_gridDirty = true;
	}

	public void SetGridActive(int[] _nodes, bool _active)
	{
		for (int i = 0; i < _nodes.Length; i++)
		{
			m_nodes[_nodes[i]].m_active = _active;
			if (SingleNode(m_nodes[_nodes[i]].m_style) && !m_nodes[_nodes[i]].m_used)
			{
				m_nodes[_nodes[i]].parent.GetComponent<hookScript>().Collision(_active);
			}
		}
		m_gridDirty = true;
	}

	public void SetItemsActive(int[] _nodes)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			int num = m_items[i].Node();
			for (int j = 0; j < _nodes.Length; j++)
			{
				if (num == _nodes[j])
				{
					m_items[i].Activate(GetGridActive(m_items[i].Node(), m_items[i].xValidate, m_items[i].yValidate));
					break;
				}
			}
		}
	}

	private bool GetGridActive(int _startIndex, int _xSteps, int _ySteps)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1 || num2 >= m_nodes.Length)
				{
					Debug.LogWarning(base.gameObject.name + " GetGridActive (start index " + _startIndex + ") _xSteps : " + _xSteps + " | _ySteps : " + _ySteps);
					return false;
				}
				if (m_nodes[num2].m_active)
				{
					return true;
				}
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		return false;
	}

	public bool GetGridActive(int _index)
	{
		if (_index < 0 || _index >= m_nodes.Length)
		{
			return false;
		}
		return m_nodes[_index].m_active;
	}

	public void SetGridForeground(int _startIndex, int _xSteps, int _ySteps, bool _foreground)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				m_nodes[num2].m_foreground = _foreground;
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
	}

	public void SetGridBoxTop(int _startIndex, int _xSteps, int _ySteps, bool _boxTop)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				m_nodes[num2].m_boxTop = _boxTop;
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
	}

	public void SetGridMaskLevel(int _startIndex, int _xSteps, int _ySteps, int _maskLevel)
	{
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1)
				{
					Debug.LogWarning("!!! (SetGridMaskLevel) | " + base.name);
					return;
				}
				m_nodes[num2].m_maskLevel = _maskLevel;
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		int height = m_nodes[_startIndex].height;
		foreach (itemScript item in m_items)
		{
			if (item.Node() != -1 && m_nodes[item.Node()].height == height)
			{
				item.SetMaskLevel(GetMaskLevel(item.Node(), item.xWidth, item.yWidth));
			}
		}
	}

	public int FitGridSpecial(int _startIndex, int _xSteps, int _ySteps, int _size, itemScript _item)
	{
		if (_startIndex == -1)
		{
			return -1;
		}
		List<int> list = new List<int>();
		int xWidth = _item.xWidth;
		int yWidth = _item.yWidth;
		int num = _item.Node();
		for (int i = 0; i < xWidth; i++)
		{
			int num2 = num;
			for (int j = 0; j < yWidth; j++)
			{
				if (num2 == -1 || !m_nodes[num2].m_used)
				{
					Debug.LogWarning(base.gameObject.name + " FitGridSpecial " + _item.name);
					return -1;
				}
				list.Add(num2);
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		foreach (int item in list)
		{
			m_nodes[item].m_used = false;
		}
		int result = FitGrid(_startIndex, _xSteps, _ySteps, _size);
		foreach (int item2 in list)
		{
			m_nodes[item2].m_used = true;
		}
		return result;
	}

	public int FitGrid(int _startIndex, int _xSteps, int _ySteps, int _size)
	{
		if (_startIndex == -1)
		{
			return -1;
		}
		bool valid = m_nodes[_startIndex].valid;
		int num = Mathf.CeilToInt((float)(_xSteps - 1) / 2f);
		int num2 = Mathf.CeilToInt((float)(_ySteps - 1) / 2f);
		int num3 = 0;
		int num4 = 0;
		int[] array = new int[4];
		while (num3 == 0 && num4 < 12)
		{
			int[] array2 = new int[4];
			bool[] array3 = new bool[4];
			for (int i = 0; i < 4; i++)
			{
				array2[i] = 0;
			}
			bool flag = valid;
			int[] array4 = new int[4]
			{
				_ySteps - 1 - num2,
				_xSteps - 1 - num,
				num2,
				num
			};
			for (int j = 0; j < 4; j++)
			{
				int num5 = 0;
				int num6 = _startIndex;
				while (array2[j] < 2 && num5 <= array4[j])
				{
					if (m_nodes[num6].m_connections[j] != -1 && !m_nodes[m_nodes[num6].m_connections[j]].m_used && m_nodes[m_nodes[num6].m_connections[j]].size >= _size)
					{
						num6 = m_nodes[num6].m_connections[j];
						if (!flag && num5 < array4[j])
						{
							flag = m_nodes[num6].valid;
						}
						if (num5 < array4[j])
						{
							int[] array5 = ((j != 1 && j != 3) ? new int[2] { 1, 3 } : new int[2] { 0, 2 });
							foreach (int num7 in array5)
							{
								int num8 = 0;
								int num9 = num6;
								while (array2[num7] < 2 && num8 <= array4[num7])
								{
									if (m_nodes[num9].m_connections[num7] != -1 && !m_nodes[m_nodes[num9].m_connections[num7]].m_used && m_nodes[m_nodes[num9].m_connections[num7]].size >= _size)
									{
										num9 = m_nodes[num9].m_connections[num7];
										if (!flag && m_nodes[num9].valid)
										{
											if (num8 < array4[num7])
											{
												flag = true;
											}
											else
											{
												array3[num7] = true;
											}
										}
									}
									else if (num8 == array4[num7])
									{
										array2[num7] = Mathf.Max(array2[num7], 1);
									}
									else
									{
										array2[num7] = 2;
									}
									num8++;
								}
							}
						}
					}
					else if (num5 == array4[j])
					{
						array2[j] = Mathf.Max(array2[j], 1);
					}
					else
					{
						array2[j] = 2;
					}
					num5++;
				}
			}
			if (flag && array2[0] < 2 && array2[1] < 2 && array2[2] < 2 && array2[3] < 2)
			{
				num3 = 1;
			}
			else if ((array2[3] == 2 || (!flag && array3[1])) && array2[1] == 0 && num > 0)
			{
				num--;
			}
			else if ((array2[2] == 2 || (!flag && array3[0])) && array2[0] == 0 && num2 > 0)
			{
				num2--;
			}
			else if ((array2[1] == 2 || (!flag && array3[3])) && array2[3] == 0 && num < _xSteps - 1)
			{
				num++;
			}
			else if ((array2[0] == 2 || (!flag && array3[2])) && array2[2] == 0 && num2 < _ySteps - 1)
			{
				num2++;
			}
			else if ((array2[0] == 2 || array2[2] == 2) && array2[1] == 0 && num > 0 && array[1] < 2)
			{
				num--;
				array[1] = 1;
				if (array[3] == 1)
				{
					array[3] = 2;
				}
			}
			else if ((array2[1] == 2 || array2[3] == 2) && array2[0] == 0 && num2 > 0 && array[0] < 2)
			{
				num2--;
				array[0] = 1;
				if (array[2] == 1)
				{
					array[2] = 2;
				}
			}
			else if ((array2[0] == 2 || array2[2] == 2) && array2[3] == 0 && num < _xSteps - 1 && array[3] < 2)
			{
				num++;
				array[3] = 1;
				if (array[1] == 1)
				{
					array[1] = 2;
				}
			}
			else if ((array2[1] == 2 || array2[3] == 2) && array2[2] == 0 && num2 < _ySteps - 1 && array[2] < 2)
			{
				num2++;
				array[2] = 1;
				if (array[0] == 1)
				{
					array[0] = 2;
				}
			}
			else
			{
				num3 = 2;
			}
			num4++;
		}
		if (num3 == 1)
		{
			int num10 = _startIndex;
			for (int l = 0; l < num; l++)
			{
				num10 = m_nodes[num10].m_connections[3];
			}
			for (int m = 0; m < num2; m++)
			{
				num10 = m_nodes[num10].m_connections[2];
			}
			return num10;
		}
		return -1;
	}

	public void FitStoveNode()
	{
		new PolygonCollider2D();
	}

	public int GetMaskLevel(int _startIndex, int _xSteps, int _ySteps)
	{
		if (_startIndex == -1 || SpecialNode(m_nodes[_startIndex].m_style))
		{
			return 0;
		}
		int num = -1;
		int num2 = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num3 = num2;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num3 == -1)
				{
					Debug.LogWarning(base.gameObject.name + " GetMaskLevel (start index " + _startIndex + ") _xSteps : " + _xSteps + " | _ySteps : " + _ySteps);
					return num;
				}
				if ((m_nodes[num3].m_style == itemNode.nodeStyle.vertical || m_nodes[num3].m_style == itemNode.nodeStyle.verticalFlipped) && m_nodes[num3].m_maskLevel == -1)
				{
					return -1;
				}
				if (num <= 0 || (m_nodes[num3].m_maskLevel > 0 && m_nodes[num3].m_maskLevel < num))
				{
					num = m_nodes[num3].m_maskLevel;
				}
				num3 = m_nodes[num3].m_connections[0];
			}
			num2 = m_nodes[num2].m_connections[1];
		}
		return num;
	}

	public Sprite GetBoxMask(int _index)
	{
		if (m_boxMasks == null)
		{
			return null;
		}
		int height = m_nodes[_index].height;
		for (int i = 0; i < m_boxMasks.Length; i++)
		{
			if (m_boxMasks[i].height == height)
			{
				return m_boxMasks[i].mask;
			}
		}
		return null;
	}

	private bool CanItemUseNode(int _index, itemScript _item)
	{
		switch (m_nodes[_index].m_style)
		{
		case itemNode.nodeStyle.bar:
		case itemNode.nodeStyle.barFlipped:
			return _item.m_usesBar;
		case itemNode.nodeStyle.holder:
		case itemNode.nodeStyle.holderFlipped:
			return _item.m_usesHolder;
		case itemNode.nodeStyle.hook:
		case itemNode.nodeStyle.hookFlipped:
			return _item.m_usesHook;
		case itemNode.nodeStyle.rack:
		case itemNode.nodeStyle.rackFlipped:
			if (!_item.m_usesRack)
			{
				return _item.m_usesHanger;
			}
			return true;
		case itemNode.nodeStyle.vertical:
		case itemNode.nodeStyle.verticalFlipped:
			return _item.m_usesWall;
		default:
			return true;
		}
	}

	public bool GetIsFlatSurface(int _index)
	{
		if (_index != -1 && _index < m_nodes.Length)
		{
			return m_nodes[_index].m_style == itemNode.nodeStyle.flat;
		}
		return false;
	}

	public itemScript.nodeStyle GetStyle(int _index)
	{
		if (_index == -1 || _index >= m_nodes.Length)
		{
			return itemScript.nodeStyle.flat;
		}
		if (m_nodes[_index].m_boxTop)
		{
			return itemScript.nodeStyle.box;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.hook)
		{
			return itemScript.nodeStyle.hooked;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.hookFlipped)
		{
			return itemScript.nodeStyle.hookedFlipped;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.holder)
		{
			return itemScript.nodeStyle.holder;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.holderFlipped)
		{
			return itemScript.nodeStyle.holderFlipped;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.vertical)
		{
			return itemScript.nodeStyle.wallLeft;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.verticalFlipped)
		{
			return itemScript.nodeStyle.wallRight;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.bar)
		{
			return itemScript.nodeStyle.bar;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.barFlipped)
		{
			return itemScript.nodeStyle.barFlipped;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.rack)
		{
			return itemScript.nodeStyle.rack;
		}
		if (m_nodes[_index].m_style == itemNode.nodeStyle.rackFlipped)
		{
			return itemScript.nodeStyle.rackFlipped;
		}
		return itemScript.nodeStyle.flat;
	}

	public itemScript.pinState GetPinState(int _index)
	{
		if (_index > -1 && (m_nodes[_index].m_style == itemNode.nodeStyle.vertical || m_nodes[_index].m_style == itemNode.nodeStyle.verticalFlipped))
		{
			if (m_nodes[_index].type == itemNode.nodeType.zone2)
			{
				return itemScript.pinState.fridge;
			}
			if (m_nodes[_index].type == itemNode.nodeType.zone3)
			{
				return itemScript.pinState.pinboard;
			}
		}
		return itemScript.pinState.none;
	}

	public int GetHeight(int _index)
	{
		if (_index == -1)
		{
			return 0;
		}
		return m_nodes[_index].height;
	}

	public bool CompareHeight(int _index1, int _index2)
	{
		if (_index1 == -1 || _index2 == -1)
		{
			return false;
		}
		if (m_nodes[_index1].height == m_nodes[_index2].height)
		{
			return m_nodes[_index1].parent == m_nodes[_index2].parent;
		}
		return false;
	}

	public bool GetForeground(int _index)
	{
		if (_index == -1)
		{
			return false;
		}
		return m_nodes[_index].m_foreground;
	}

	public bool GetWall(int _index)
	{
		if (_index == -1)
		{
			return false;
		}
		if (m_nodes[_index].m_style != itemNode.nodeStyle.vertical)
		{
			return m_nodes[_index].m_style == itemNode.nodeStyle.verticalFlipped;
		}
		return true;
	}

	public bool GetHang(int _index)
	{
		if (_index == -1)
		{
			return false;
		}
		if (m_nodes[_index].m_style != itemNode.nodeStyle.vertical && m_nodes[_index].m_style != itemNode.nodeStyle.verticalFlipped && m_nodes[_index].m_style != itemNode.nodeStyle.hook && m_nodes[_index].m_style != itemNode.nodeStyle.hookFlipped && m_nodes[_index].m_style != itemNode.nodeStyle.holder && m_nodes[_index].m_style != itemNode.nodeStyle.holderFlipped && m_nodes[_index].m_style != itemNode.nodeStyle.bar)
		{
			return m_nodes[_index].m_style == itemNode.nodeStyle.barFlipped;
		}
		return true;
	}

	public zoneType GetType(int _node)
	{
		if (_node != -1 && m_nodes[_node].wall)
		{
			return zoneType.wall;
		}
		return m_type;
	}

	public bool CheckGridSize(int _startIndex, int _xSteps, int _ySteps)
	{
		if (_startIndex == -1)
		{
			return false;
		}
		if (SpecialNode(m_nodes[_startIndex].m_style))
		{
			return true;
		}
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1)
				{
					return false;
				}
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		return true;
	}

	public bool CheckGridSize(int _startIndex, int _xSteps, int _ySteps, int _size)
	{
		if (_startIndex == -1)
		{
			return false;
		}
		bool flag = m_nodes[_startIndex].valid;
		if (SpecialNode(m_nodes[_startIndex].m_style))
		{
			return m_nodes[_startIndex].size >= _size;
		}
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1 || m_nodes[num2].m_used || m_nodes[num2].size < _size)
				{
					return false;
				}
				if (!flag && m_nodes[num2].valid)
				{
					flag = true;
				}
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		return flag;
	}

	public itemNode.nodeType CheckType(int _startIndex, int _xSteps, int _ySteps)
	{
		if (_startIndex == -1)
		{
			return itemNode.nodeType.none;
		}
		if (SpecialNode(m_nodes[_startIndex].m_style))
		{
			return m_nodes[_startIndex].type;
		}
		itemNode.nodeType nodeType = itemNode.nodeType.none;
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1)
				{
					Debug.LogWarning(base.name + "!!! (CheckType)");
					return itemNode.nodeType.none;
				}
				if (m_nodes[num2].type == itemNode.nodeType.none)
				{
					return itemNode.nodeType.none;
				}
				if (m_nodes[num2].type != itemNode.nodeType.overflow)
				{
					nodeType |= m_nodes[num2].type;
				}
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		return nodeType;
	}

	public string GetSurfaceName(int _index)
	{
		if (_index != -1)
		{
			return m_nodes[_index].audio;
		}
		return "";
	}

	public Vector3 GetGrid(int _index)
	{
		return m_nodes[_index].position;
	}

	public float GetGridDepth(int _index)
	{
		return m_nodes[_index].depth;
	}

	public bool GetCompact(int _index)
	{
		return m_nodes[_index].parent != null;
	}

	public Transform GetParent(int _index)
	{
		if (_index == -1 || _index >= m_nodes.Length)
		{
			return base.transform;
		}
		Transform parent = m_nodes[_index].parent;
		if (parent == null)
		{
			return base.transform;
		}
		return parent;
	}

	private int DirectionToConnection(direction _direction)
	{
		int result = 0;
		switch (_direction)
		{
		case direction.xAxis:
			result = 3;
			break;
		case direction.yAxis:
			result = 2;
			break;
		case direction.xAxisNeg:
			result = 1;
			break;
		}
		return result;
	}

	public int FindGridSpan(int _index, int _depth, direction _direction)
	{
		int[] array = new int[_depth];
		array[0] = _index;
		for (int i = 1; i < _depth; i++)
		{
			array[i] = m_nodes[array[i - 1]].m_connections[(_direction != direction.xAxis && _direction != direction.xAxisNeg) ? 1 : 0];
			if (array[i] == -1)
			{
				return 0;
			}
		}
		bool flag = false;
		int num = DirectionToConnection(_direction);
		int num2 = 0;
		while (!flag)
		{
			num2++;
			for (int j = 0; j < _depth; j++)
			{
				array[j] = m_nodes[array[j]].m_connections[num];
				if (array[j] == -1)
				{
					flag = true;
				}
			}
		}
		return num2;
	}

	public int FindGridIndex(int _index, int _skip, direction _direction)
	{
		int num = _index;
		int num2 = DirectionToConnection(_direction);
		for (int i = 0; i < _skip; i++)
		{
			num = m_nodes[num].m_connections[num2];
			if (num == -1)
			{
				Debug.LogWarning("!!! (FindGridIndex)");
				return _index;
			}
		}
		return num;
	}

	public bool GetGridUsed(int _startIndex, int _xSteps, int _ySteps)
	{
		bool result = false;
		int num = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num2 = num;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num2 == -1)
				{
					Debug.LogWarning(base.gameObject.name.ToString() + " (GetGridUsed) bad index encountered");
					return result;
				}
				if (m_nodes[num2].m_used)
				{
					result = true;
				}
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		return result;
	}

	public int GetGridSize(int _index)
	{
		return m_nodes[_index].size;
	}

	public int GetGridSize(int _startIndex, int _xSteps, int _ySteps)
	{
		int num = 99;
		int num2 = _startIndex;
		for (int i = 0; i < _xSteps; i++)
		{
			int num3 = num2;
			for (int j = 0; j < _ySteps; j++)
			{
				if (num3 == -1)
				{
					Debug.LogWarning(base.gameObject.name.ToString() + " (GetGridSize) bad index encountered");
					return num;
				}
				num = Mathf.Min(num, m_nodes[num3].size);
				num3 = m_nodes[num3].m_connections[0];
			}
			num2 = m_nodes[num2].m_connections[1];
		}
		return num;
	}

	public int GetGridSize(itemScript _item)
	{
		int num = 99;
		int num2 = _item.Node();
		_item.GetStackDimentions(out var _xWidth, out var _yWidth);
		for (int i = 0; i < _xWidth; i++)
		{
			int num3 = num2;
			for (int j = 0; j < _yWidth; j++)
			{
				if (num3 == -1)
				{
					Debug.LogWarning(base.gameObject.name.ToString() + " (GetGridSize) bad index encountered");
					return num;
				}
				num = Mathf.Min(num, m_nodes[num3].size);
				num3 = m_nodes[num3].m_connections[0];
			}
			num2 = m_nodes[num2].m_connections[1];
		}
		return num;
	}

	public int GetBoxSize(int _index)
	{
		if (_index == -1)
		{
			return 0;
		}
		return m_nodes[_index].m_boxSize;
	}

	public int GetGridForeground(int _startIndex, int _xSteps, int _ySteps)
	{
		if (_startIndex == -1 || !m_nodes[_startIndex].m_foreground)
		{
			return 0;
		}
		int num = Mathf.Max(_xSteps, _ySteps);
		int num2 = 1;
		int num3 = _startIndex;
		for (int i = 0; i < num; i++)
		{
			if (num3 == -1)
			{
				Debug.LogWarning(base.gameObject.name.ToString() + " (GetGridForeground) bad index encountered");
				return 0;
			}
			if (m_nodes[num3].m_foreground)
			{
				num2 = i + 1;
			}
			num3 = m_nodes[num3].m_connections[(_xSteps > _ySteps) ? 1 : 0];
		}
		if (num2 == num)
		{
			return 0;
		}
		return num2;
	}

	private void CheckProximity(itemScript _item)
	{
		int xWidth = _item.xWidth;
		int yWidth = _item.yWidth;
		int num = _item.Node();
		List<int> list = new List<int>();
		for (int i = 0; i < xWidth; i++)
		{
			int num2 = num;
			for (int j = 0; j < yWidth; j++)
			{
				if (num2 == -1)
				{
					Debug.LogWarning(base.gameObject.name.ToString() + " (CheckGridTouch) bad index encountered");
					return;
				}
				list.AddRange(m_nodes[num2].m_connections);
				num2 = m_nodes[num2].m_connections[0];
			}
			num = m_nodes[num].m_connections[1];
		}
		for (int k = 0; k < m_proximityItems.Count; k++)
		{
			xWidth = m_proximityItems[k].xWidth;
			yWidth = m_proximityItems[k].yWidth;
			num = m_proximityItems[k].Node();
			for (int l = 0; l < xWidth; l++)
			{
				int num3 = num;
				for (int m = 0; m < yWidth; m++)
				{
					if (num3 == -1)
					{
						Debug.LogWarning(base.gameObject.name.ToString() + " (CheckGridTouch) bad index encountered");
						return;
					}
					if (list.Contains(num3))
					{
						statsScript.AwardSticker(statsScript.stickers.sticker_plushToys);
						return;
					}
					num3 = m_nodes[num3].m_connections[0];
				}
				num = m_nodes[num].m_connections[1];
			}
		}
	}

	public void AddItem(itemScript _item)
	{
		m_items.Add(_item);
		if (_item.isValid)
		{
			m_validItems++;
			if (_item.IsComputer())
			{
				computerScript computer = _item.GetComputer();
				m_computers.Add(computer);
				if (computer.usesTelevision && m_television != null)
				{
					computer.SetTelevision(m_television);
				}
				for (int i = 0; i < m_items.Count; i++)
				{
					if (m_items[i].isValid || computer.usesTelevision)
					{
						computer.AddItem(m_items[i]);
					}
				}
			}
			else
			{
				for (int j = 0; j < m_computers.Count; j++)
				{
					m_computers[j].AddItem(_item);
				}
			}
			if (_item.IsProximity())
			{
				if (m_proximityItems.Count > 0)
				{
					CheckProximity(_item);
				}
				m_proximityItems.Add(_item);
			}
		}
		else
		{
			for (int k = 0; k < m_computers.Count; k++)
			{
				if (m_computers[k].usesTelevision)
				{
					m_computers[k].AddItem(_item);
				}
			}
		}
		if (!m_fileOpen)
		{
			for (int l = 0; l < m_stickerUnlockAreas.Length; l++)
			{
				m_stickerUnlockAreas[l].Check(_item);
			}
		}
		if (game.state == gameScript.gameState.arrange && !m_fileOpen)
		{
			SaveItems(_auto: true);
			zoneScript boxZone = _item.GetBoxZone();
			if (boxZone != null && boxZone != this)
			{
				boxZone.SaveItems(_auto: true);
			}
		}
	}

	public void RemoveItem(itemScript _item)
	{
		m_items.Remove(_item);
		if (_item.isValid)
		{
			m_validItems--;
			if (_item.IsComputer())
			{
				computerScript computer = _item.GetComputer();
				m_computers.Remove(computer);
				computer.PickedUp();
			}
			else
			{
				for (int i = 0; i < m_computers.Count; i++)
				{
					m_computers[i].RemoveItem(_item);
				}
			}
			if (m_proximityItems.Contains(_item))
			{
				m_proximityItems.Remove(_item);
			}
		}
		else
		{
			for (int j = 0; j < m_computers.Count; j++)
			{
				if (m_computers[j].usesTelevision)
				{
					m_computers[j].RemoveItem(_item);
				}
			}
		}
		if (game.state == gameScript.gameState.arrange && !m_fileOpen)
		{
			SaveItems(_auto: true);
			zoneScript boxZone = _item.GetBoxZone();
			if (boxZone != null && boxZone != this)
			{
				boxZone.SaveItems(_auto: true);
			}
		}
	}

	public bool AddItemUnmovable(itemScript _item)
	{
		if (m_itemsUnmovable.Contains(_item))
		{
			return false;
		}
		itemScript itemScript2 = _item.StackParent();
		while (itemScript2 != null)
		{
			if (itemScript2.inBox)
			{
				return false;
			}
			itemScript2 = itemScript2.StackParent();
		}
		m_itemsUnmovable.Add(_item);
		itemScript2 = _item.StackParent();
		while (itemScript2 != null && !m_itemsUnmovable.Contains(itemScript2))
		{
			if (m_itemsMovable.Contains(itemScript2))
			{
				m_itemsMovable.Remove(itemScript2);
			}
			m_itemsUnmovable.Add(itemScript2);
			if (game.state == gameScript.gameState.pack)
			{
				itemScript2.PackingMode(2);
				if (!m_fileOpen && !game.GetUnpackShow(gameScript.packShow.unmovable))
				{
					itemScript2.PackingModeShow(_value: false);
				}
			}
			itemScript2 = itemScript2.StackParent();
		}
		if (game.state == gameScript.gameState.pack)
		{
			_item.PackingMode(2);
			if (!m_fileOpen)
			{
				SaveItems(_auto: true);
				if (!game.GetUnpackShow(gameScript.packShow.unmovable))
				{
					_item.PackingModeShow(_value: false);
				}
			}
		}
		return true;
	}

	public bool RemoveItemUnmovable(int _index)
	{
		return RemoveItemUnmovable(m_itemsUnmovable[_index]);
	}

	public bool RemoveItemUnmovable(itemScript _item)
	{
		if (!m_itemsUnmovable.Contains(_item))
		{
			return false;
		}
		m_itemsUnmovable.Remove(_item);
		if (game.state == gameScript.gameState.pack)
		{
			_item.PackingMode(0);
			if (!m_fileOpen)
			{
				SaveItems(_auto: true);
				_item.PackingModeShow(game.GetUnpackShow(gameScript.packShow.unboxed));
			}
		}
		return true;
	}

	public bool AddItemMovable(itemScript _item)
	{
		if (m_itemsMovable.Contains(_item))
		{
			return false;
		}
		itemScript itemScript2 = _item.StackParent();
		while (itemScript2 != null)
		{
			if (itemScript2.inBox)
			{
				return false;
			}
			itemScript2 = itemScript2.StackParent();
		}
		m_itemsMovable.Add(_item);
		itemScript2 = _item.StackParent();
		while (itemScript2 != null && !m_itemsUnmovable.Contains(itemScript2) && !m_itemsMovable.Contains(itemScript2))
		{
			m_itemsMovable.Add(itemScript2);
			if (game.state == gameScript.gameState.pack)
			{
				itemScript2.PackingMode(3);
				if (!m_fileOpen && !game.GetUnpackShow(gameScript.packShow.movable))
				{
					itemScript2.PackingModeShow(_value: false);
				}
			}
			itemScript2 = itemScript2.StackParent();
		}
		if (game.state == gameScript.gameState.pack)
		{
			_item.PackingMode(3);
			if (!m_fileOpen)
			{
				SaveItems(_auto: true);
				if (!game.GetUnpackShow(gameScript.packShow.movable))
				{
					_item.PackingModeShow(_value: false);
				}
			}
		}
		return true;
	}

	public bool RemoveItemMovable(int _index)
	{
		return RemoveItemMovable(m_itemsMovable[_index]);
	}

	public bool RemoveItemMovable(itemScript _item)
	{
		if (!m_itemsMovable.Contains(_item))
		{
			return false;
		}
		m_itemsMovable.Remove(_item);
		if (game.state == gameScript.gameState.pack)
		{
			_item.PackingMode(0);
			if (!m_fileOpen)
			{
				SaveItems(_auto: true);
				_item.PackingModeShow(game.GetUnpackShow(gameScript.packShow.unboxed));
			}
		}
		return true;
	}

	public int[] GetPackingCounts()
	{
		int[] array = new int[3] { 0, 0, 0 };
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].inBox)
			{
				array[0]++;
			}
		}
		array[1] = m_itemsUnmovable.Count;
		array[2] = m_itemsMovable.Count;
		return array;
	}

	public string[] GetUnmovableNames()
	{
		if (m_itemsUnmovable.Count == 0)
		{
			return new string[0];
		}
		string[] array = new string[m_itemsUnmovable.Count];
		for (int i = 0; i < m_itemsUnmovable.Count; i++)
		{
			array[i] = m_itemsUnmovable[i].gameObject.name.Replace("(Clone)", "") + m_itemsUnmovable[i].GetVariantString();
		}
		return array;
	}

	public string[] GetMovableNames()
	{
		if (m_itemsMovable.Count == 0)
		{
			return new string[0];
		}
		string[] array = new string[m_itemsMovable.Count];
		for (int i = 0; i < m_itemsMovable.Count; i++)
		{
			array[i] = m_itemsMovable[i].gameObject.name.Replace("(Clone)", "") + m_itemsMovable[i].GetVariantString();
		}
		return array;
	}

	public void SetUnmovable()
	{
		foreach (itemScript item in m_itemsUnmovable)
		{
			if (!item.isValid)
			{
				m_validItems++;
			}
			item.unmovable = true;
		}
		shelfStandScript[] shelves = m_shelves;
		for (int i = 0; i < shelves.Length; i++)
		{
			shelves[i].SetCollisionIfUnmovable();
		}
	}

	public void SetUnpackMode(int _mode)
	{
		foreach (itemScript item in m_itemsUnmovable)
		{
			item.PackingMode((_mode == 1) ? 2 : 4);
		}
		foreach (itemScript item2 in m_itemsMovable)
		{
			item2.PackingMode((_mode == 2) ? 3 : 4);
		}
		foreach (boxScript box in m_boxes)
		{
			box.Collision(_mode != 1);
			m_gridDirty |= box.CreateNodes(this, _mode == 2);
		}
		RemoveMarkedNodes();
		SetPackMovableItems(_mode == 2 && base.gameObject.activeSelf);
	}

	public void UpdatePackMovableLines()
	{
		foreach (itemScript item in m_itemsMovable)
		{
			item.PackMovableUpdate();
		}
	}

	public void AddBox(boxScript _box)
	{
		m_boxes.Add(_box);
		_box.UpdateZoneForContents(this);
		if (game.state == gameScript.gameState.pack && !m_fileOpen)
		{
			SaveItems(_auto: true);
		}
	}

	public void RemoveBox(boxScript _box)
	{
		m_boxes.Remove(_box);
		if (game.state == gameScript.gameState.pack && !m_fileOpen)
		{
			SaveItems(_auto: true);
		}
	}

	public void BoxEffect(Vector3 _pos)
	{
		m_boxParticles.position = _pos;
		m_boxParticles.GetComponent<ParticleSystem>().Emit(20);
	}

	public void BoxModeItems()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].BoxMode(_active: false);
		}
	}

	public int GetBoxIndex(boxScript _box)
	{
		for (int i = 0; i < m_boxes.Count; i++)
		{
			if (m_boxes[i] == _box)
			{
				return i;
			}
		}
		return -1;
	}

	public boxScript GetBoxByIndex(int _index)
	{
		if (_index < 0 || _index >= m_boxes.Count)
		{
			Debug.LogError("GetBoxByIndex out of range");
			return null;
		}
		return m_boxes[_index];
	}

	public int GetItemIndex(itemScript _item)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i] == _item)
			{
				return i;
			}
		}
		return -1;
	}

	public itemScript GetItemByIndex(int _index)
	{
		if (_index < 0 || _index >= m_items.Count)
		{
			Debug.LogWarning("GetItemByIndex out of range");
			return null;
		}
		return m_items[_index];
	}

	public bool IsItemLastAddition(itemScript _item)
	{
		if (_item.MultiItem())
		{
			List<itemScript> multiItems = _item.GetMultiItems();
			for (int i = 0; i < multiItems.Count; i++)
			{
				if (!m_items[m_items.Count - multiItems.Count + i].Equals(multiItems[i]))
				{
					return false;
				}
			}
			return true;
		}
		if (m_items[m_items.Count - 1] == _item)
		{
			return true;
		}
		return false;
	}

	public bool PlaybackUseStage(int _index, bool _animate)
	{
		for (int i = 0; i < m_drawers.Length; i++)
		{
			if (m_drawers[i].PlaybackUse(_index, _animate))
			{
				return true;
			}
		}
		for (int j = 0; j < m_doors.Length; j++)
		{
			if (m_doors[j].PlaybackUse(_index, _animate))
			{
				return false;
			}
		}
		for (int k = 0; k < m_doorsFolding.Length; k++)
		{
			if (m_doorsFolding[k].PlaybackUse(_index, _animate))
			{
				return false;
			}
		}
		for (int l = 0; l < m_doorsSliding.Length; l++)
		{
			if (m_doorsSliding[l].PlaybackUse(_index, _animate))
			{
				return false;
			}
		}
		for (int m = 0; m < m_lamps.Length; m++)
		{
			if (m_lamps[m].PlaybackUse(_index, _animate))
			{
				return false;
			}
		}
		return false;
	}

	public bool PlaybackMoving()
	{
		for (int i = 0; i < m_drawers.Length; i++)
		{
			if (m_drawers[i].PlaybackMoving())
			{
				return true;
			}
		}
		return false;
	}

	public bool BoxInZone(boxScript _box)
	{
		return m_boxes.Contains(_box);
	}

	public bool ItemInZone(itemScript _item)
	{
		return m_items.Contains(_item);
	}

	public void GetZonePackedItems(zoneScript _zone, ref List<itemScript> _result)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].GetBoxZone() == _zone)
			{
				_result.Add(m_items[i]);
			}
		}
	}

	public bool CheckOffscreenInvalid()
	{
		float orthographicSize = game.GetComponent<Camera>().orthographicSize;
		float num = (float)Screen.width / (float)Screen.height;
		Bounds bounds = new Bounds((Vector2)game.transform.position, new Vector2(orthographicSize * num - orthographicSize * 0.01f, orthographicSize - orthographicSize * 0.01f) * 2f);
		for (int i = 0; i < m_items.Count; i++)
		{
			if (!m_items[i].isValid)
			{
				m_items[i].GetScreenBounds();
				if (!bounds.Intersects(m_items[i].GetScreenBounds()))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool IsItemValid(itemScript _item, itemScript _baseItem, int _node, itemScript.nodeStyle _style)
	{
		if (_node != -1)
		{
			if (_style == itemScript.nodeStyle.flat && _item.oversize)
			{
				for (int i = 0; i < m_limitedHeightAreas.Length; i++)
				{
					if (m_limitedHeightAreas[i].Check(_node))
					{
						return false;
					}
				}
			}
			for (int j = 0; j < m_validAreas.Length; j++)
			{
				if (m_validAreas[j].Check(_node, _item))
				{
					return m_validAreas[j].m_forceValid;
				}
			}
			if (_item.Validate(GetType(_node), CheckType(_node, _baseItem.XValidate(_style), _baseItem.YValidate(_style))))
			{
				return true;
			}
		}
		return false;
	}

	public bool IsAllPlantsValid()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].m_plant && !m_items[i].isValid)
			{
				return false;
			}
		}
		return true;
	}

	public void ShelfOffset(int _value)
	{
		shelfStandScript[] shelves = m_shelves;
		for (int i = 0; i < shelves.Length; i++)
		{
			shelves[i].AdjustAllOffsets(_value);
		}
	}

	public void ShelfSetPoints(itemScript _item)
	{
		shelfStandScript[] shelves = m_shelves;
		for (int i = 0; i < shelves.Length; i++)
		{
			shelves[i].SetPolyPoints(_item);
		}
	}

	public void OffsetByStackID(itemScript.stackId _stackAllowed, bool _active)
	{
		Vector3 vector = Vector3.zero;
		if (_active)
		{
			vector = Vector3.up * 0.75f * -0.01f;
		}
		for (int i = 0; i < m_items.Count; i++)
		{
			if (!m_items[i].isNonFlatState && m_items[i].m_stackID != itemScript.stackId.none && (m_items[i].m_stackID & _stackAllowed) == m_items[i].m_stackID && (!_active || m_items[i].stackChild == null))
			{
				m_items[i].ShelfOffset(vector * m_items[i].stackPixelSize, _active);
			}
		}
	}

	public shelfStandScript FindShelf(int _index)
	{
		for (int i = 0; i < m_shelves.Length; i++)
		{
			if (m_shelves[i].index == _index)
			{
				return m_shelves[i];
			}
		}
		return null;
	}

	public itemScript FindTopStack(int _index)
	{
		int num = -1;
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Node() == _index && !m_items[i].isOnCombine && (num == -1 || m_items[num].stackCount < m_items[i].stackCount))
			{
				num = i;
			}
		}
		if (num > -1)
		{
			return m_items[num];
		}
		return null;
	}

	public itemScript FindHanger(int _index)
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].Node() == _index && m_items[i].isOnRack)
			{
				return m_items[i];
			}
		}
		return null;
	}

	public boxScript FindTopBoxStack(int _index)
	{
		int num = -1;
		for (int i = 0; i < m_boxes.Count; i++)
		{
			if (m_boxes[i].Node() == _index && (num == -1 || m_boxes[num].m_stackPosition < m_boxes[i].m_stackPosition))
			{
				num = i;
			}
		}
		if (num > -1)
		{
			return m_boxes[num];
		}
		return null;
	}

	public void ClearItems()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (m_items[i].isOnHook || m_items[i].isOnHolder)
			{
				m_items[i].Unhook();
			}
			if (m_items[i].transform.parent != null && m_items[i].transform.parent.CompareTag("drawer"))
			{
				m_items[i].transform.parent.GetComponent<drawerScript>().RemoveItem(m_items[i]);
			}
			m_items[i].DestroyItem();
		}
		m_items.Clear();
		m_itemsUnmovable.Clear();
		m_itemsMovable.Clear();
		m_computers.Clear();
		m_proximityItems.Clear();
		m_validItems = 0;
		for (int j = 0; j < m_itemsLimbo.Count; j++)
		{
			m_itemsLimbo[j].DestroyItem();
		}
		m_itemsLimbo.Clear();
		for (int k = 0; k < m_boxes.Count; k++)
		{
			m_boxes[k].DestroyBox(this);
		}
		RemoveMarkedNodes();
		m_boxes.Clear();
		m_keepAlive.RemoveAll((KeyValuePair<Transform, Transform> item) => item.Key == null);
		for (int num = 0; num < m_nodes.Length; num++)
		{
			m_nodes[num].m_used = false;
		}
		drawerManagerScript[] componentsInChildren = base.gameObject.GetComponentsInChildren<drawerManagerScript>(includeInactive: true);
		for (int num2 = 0; num2 < componentsInChildren.Length; num2++)
		{
			componentsInChildren[num2].ClearItems();
		}
	}

	public void FixBoxStates(bool _tops, bool _bottoms)
	{
		bool flag = false;
		for (int i = 0; i < m_boxes.Count; i++)
		{
			if (m_boxes[i].FixItemStates(0, _tops, _bottoms))
			{
				flag = true;
			}
		}
		if (flag)
		{
			SaveItems(_auto: true);
		}
	}

	private int GetPackState(itemScript _item)
	{
		if (m_itemsUnmovable.Contains(_item))
		{
			return -2;
		}
		if (m_itemsMovable.Contains(_item))
		{
			return -3;
		}
		if (_item.inBox && _item.GetBoxZone() != this)
		{
			return -4;
		}
		return GetBoxIndex(_item.GetBox());
	}

	private void ValidatePack()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			if (!m_items[i].stackBase)
			{
				continue;
			}
			int num = 2;
			itemScript itemScript2 = m_items[i];
			while (itemScript2 != null)
			{
				if (m_itemsUnmovable.Contains(itemScript2))
				{
					if (num < 2)
					{
						m_itemsUnmovable.Remove(itemScript2);
						if (game.state == gameScript.gameState.pack)
						{
							itemScript2.PackingMode(0);
							itemScript2.PackingModeShow(game.GetUnpackShow(gameScript.packShow.unboxed));
						}
						num = 0;
					}
				}
				else if (m_itemsMovable.Contains(itemScript2))
				{
					if (num < 1)
					{
						m_itemsMovable.Remove(itemScript2);
						if (game.state == gameScript.gameState.pack)
						{
							itemScript2.PackingMode(0);
							itemScript2.PackingModeShow(game.GetUnpackShow(gameScript.packShow.unboxed));
						}
						num = 0;
					}
					else
					{
						num = 1;
					}
				}
				else
				{
					num = 0;
				}
				itemScript2 = itemScript2.stackChild;
			}
		}
	}

	public void SetPackMovableItems(bool _value)
	{
		foreach (itemScript item in m_itemsMovable)
		{
			if (!item.packMovable)
			{
				continue;
			}
			item.PackMovableLine(_value);
			if (!_value)
			{
				continue;
			}
			Vector3 packMovablePosition = item.packMovablePosition;
			int num = GetClosestGridNoCheck(packMovablePosition, _boxCheck: true);
			if (num != -1 && Vector3.Distance(packMovablePosition, m_nodes[num].position) > 0.01f)
			{
				num = -1;
			}
			if (num != -1)
			{
				if (!m_nodes[num].m_used && !SetGrid(num, item.packMovableX, item.packMovableY, _used: true, item.packMovableSize))
				{
					Debug.LogWarning(item.name + " failed SetGrid in SetPackMovableItems");
				}
			}
			else
			{
				item.PackMovableRemove();
			}
		}
	}

	public void HideBoxPackingLines()
	{
		foreach (boxScript box in m_boxes)
		{
			box.RemoveLines();
		}
	}

	private string Vec32String(Vector3 _input)
	{
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		return _input.x.ToString("F3", invariantCulture) + "," + _input.y.ToString("F3", invariantCulture) + "," + _input.z.ToString("F3", invariantCulture);
	}

	private Vector3 String2Vec3(string _input)
	{
		string[] array = _input.Split(',');
		return new Vector3(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]));
	}

	public void SaveItems(bool _auto)
	{
		ValidatePack();
	}

	public bool BoxesRemain()
	{
		foreach (boxScript box in m_boxes)
		{
			if (box.isActive)
			{
				return true;
			}
		}
		return false;
	}

	public string PreloadStatus()
	{
		return m_loadedItemData.Count + " items and " + m_loadedBoxData.Count + " boxes loaded | node count : " + ((m_nodeDataHorizontal != null) ? m_nodeDataHorizontal.Length.ToString() : "n/a");
	}

	public void PreloadStatus(ref int loadedItemCount, ref int loadedBoxCount, ref int nodeCount)
	{
		loadedItemCount += m_loadedItemData.Count;
		loadedBoxCount += m_loadedBoxData.Count;
		nodeCount += ((m_nodeDataHorizontal != null) ? m_nodeDataHorizontal.Length : 0);
	}

	private itemScript ItemLimbo(itemScript _prefab, int _variant, int _state)
	{
		itemScript itemScript2 = UnityEngine.Object.Instantiate(_prefab);
		itemScript2.SetVariant(_variant);
		itemScript2.SetState(_state);
		m_itemsLimbo.Add(itemScript2);
		itemScript2.gameObject.SetActive(value: false);
		return itemScript2;
	}

	public int ItemLimboCount()
	{
		return m_itemsLimbo.Count;
	}

	public string[] ItemLimboList()
	{
		string[] array = new string[m_itemsLimbo.Count];
		for (int i = 0; i < m_itemsLimbo.Count; i++)
		{
			array[i] = m_itemsLimbo[i].gameObject.name.Replace("(Clone)", "") + m_itemsLimbo[i].GetVariantString();
		}
		return array;
	}

	public itemScript GetItemLimbo(int _index)
	{
		if (_index < 0 || _index >= m_itemsLimbo.Count)
		{
			return null;
		}
		itemScript result = m_itemsLimbo[_index];
		m_itemsLimbo.RemoveAt(_index);
		return result;
	}

	public void SetItemShow()
	{
		bool unpackShow = game.GetUnpackShow(gameScript.packShow.unboxed);
		for (int i = 0; i < m_items.Count; i++)
		{
			if (!m_items[i].inBox && !m_itemsMovable.Contains(m_items[i]) && !m_itemsUnmovable.Contains(m_items[i]))
			{
				m_items[i].PackingModeShow(unpackShow);
			}
		}
		unpackShow = game.GetUnpackShow(gameScript.packShow.boxed);
		for (int j = 0; j < m_items.Count; j++)
		{
			if (m_items[j].inBox)
			{
				m_items[j].PackingModeShow(unpackShow);
			}
		}
		unpackShow = game.GetUnpackShow(gameScript.packShow.unmovable);
		for (int k = 0; k < m_itemsUnmovable.Count; k++)
		{
			m_itemsUnmovable[k].PackingModeShow(unpackShow);
		}
		unpackShow = game.GetUnpackShow(gameScript.packShow.movable);
		for (int l = 0; l < m_itemsMovable.Count; l++)
		{
			m_itemsMovable[l].PackingModeShow(unpackShow);
		}
		unpackShow = game.GetUnpackShow(gameScript.packShow.boxes);
		for (int m = 0; m < m_boxes.Count; m++)
		{
			m_boxes[m].PackingModeShow(unpackShow);
		}
	}

	public int GetFullItemCount()
	{
		int num = 0;
		for (int i = 0; i < m_boxes.Count; i++)
		{
			num += m_boxes[i].GetFullItemCount();
		}
		return num;
	}

	public void LoadItems()
	{
		LoadItems(_auto: true, _saveLoad: false);
	}

	public int GetItemsVolume(int[] _itemIndexes)
	{
		return game.GetItemsVolume(_itemIndexes);
	}

	public void LoadItems(bool _auto, bool _saveLoad)
	{
		bool activeSelf = base.gameObject.activeSelf;
		Vector3 localPosition = (activeSelf ? Vector3.zero : base.transform.localPosition);
		if (!activeSelf)
		{
			base.transform.localPosition = Vector3.zero;
			base.gameObject.SetActive(value: true);
		}
		ClearItems();
		m_fileOpen = true;
		List<boxEntry> list = new List<boxEntry>();
		foreach (itemData loadedItemDatum in m_loadedItemData)
		{
			string[] array = loadedItemDatum.name.Split('|');
			itemScript itemType = game.GetItemType(array[0]);
			if (itemType != null)
			{
				int num = ((array.Length > 1) ? itemType.FindVariant(array[1]) : 0);
				int closestGrid = GetClosestGrid(new Vector2(loadedItemDatum.x, loadedItemDatum.y));
				int state = loadedItemDatum.state;
				if (closestGrid > -1)
				{
					itemScript itemScript2 = null;
					if (!_saveLoad && (game.state != gameScript.gameState.play || loadedItemDatum.packState == itemPackType.unmovable || loadedItemDatum.packState == itemPackType.movable))
					{
						Transform transform = GetParent(closestGrid);
						Vector3 vector = Vector3.zero;
						bool flag = true;
						if (transform != null && transform.CompareTag("drawer"))
						{
							vector = transform.GetComponent<drawerScript>().GetOffset();
							flag = transform.GetComponent<drawerScript>().isActive;
						}
						int stackCount = loadedItemDatum.stackCount;
						bool flag2 = state == 20 || state == 21;
						shelfStandScript shelfStandScript2 = ((loadedItemDatum.state == 5 || loadedItemDatum.state == 6) ? FindShelf(closestGrid) : null);
						itemScript itemScript3 = ((stackCount == 0 || shelfStandScript2 != null) ? null : FindTopStack(closestGrid));
						itemScript itemScript4 = ((loadedItemDatum.state == 16 || loadedItemDatum.state == 17) ? FindHanger(closestGrid) : null);
						bool flag3 = SingleNode(m_nodes[closestGrid].m_style);
						if ((stackCount == 0 || shelfStandScript2 != null || itemScript3 != null) && CanItemUseNode(closestGrid, itemType))
						{
							itemScript2 = UnityEngine.Object.Instantiate(itemType);
							itemScript2.SetVariant(num);
							itemScript2.SetState(state);
							int maskLevel = ((!flag3 && !(shelfStandScript2 != null) && GetIsFlatSurface(closestGrid)) ? ((itemScript3 != null) ? itemScript3.maskLevel : GetMaskLevel(closestGrid, itemScript2.xWidth, itemScript2.yWidth)) : 0);
							if (itemScript3 != null)
							{
								transform = itemScript3.m_artPivot;
							}
							else if (itemScript4 != null)
							{
								transform = itemScript4.m_artPivot;
							}
							itemScript.nodeStyle nodeStyle = (flag2 ? itemScript3.CombineStyle() : ((shelfStandScript2 != null) ? shelfStandScript2.NodeStyle() : ((itemScript4 != null) ? itemScript4.HangerStyle() : GetStyle(closestGrid))));
							Vector3 position = ((shelfStandScript2 != null) ? Vector3.zero : (flag2 ? itemScript3.CombinePosition(itemScript2.combineDepth) : ((itemScript4 != null) ? itemScript4.HangerPosition(itemScript2) : ((itemScript3 != null) ? itemScript3.StackPosition(itemScript2) : (GetGrid(closestGrid) + vector)))));
							itemScript.positionAction action = (IsItemValid(itemScript2, (itemScript3 == null) ? itemScript2 : itemScript3, closestGrid, nodeStyle) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid);
							int foreground = ((itemScript3 == null) ? GetGridForeground(closestGrid, itemScript2.xValidate, itemScript2.yValidate) : GetGridForeground(closestGrid, itemScript3.xValidate, itemScript3.yValidate));
							itemScript2.Position(position, action, _unboxed: false, itemScript3, closestGrid, maskLevel, foreground, transform, nodeStyle, GetBoxSize(closestGrid));
							if (flag3)
							{
								itemScript2.Hook(transform.GetComponent<hookScript>());
							}
							else if (itemScript3 != null)
							{
								if (flag2)
								{
									itemScript2.Combine(itemScript3);
								}
								else
								{
									itemScript2.Stack(itemScript3);
								}
							}
							else if (itemScript4 != null)
							{
								itemScript2.Hanger(itemScript4);
							}
							if (nodeStyle == itemScript.nodeStyle.wallLeft || nodeStyle == itemScript.nodeStyle.wallRight)
							{
								game.SetItemPins(GetPinState(closestGrid), itemScript2);
							}
							if (CheckGridSize(closestGrid, itemScript2.xValidate, itemScript2.yValidate))
							{
								AddItem(itemScript2);
								if (shelfStandScript2 != null)
								{
									if (itemScript2 == null)
									{
										Debug.LogWarning("Null Item being added to shelf " + shelfStandScript2.name);
									}
									shelfStandScript2.SimpleAddAtIndex(itemScript2, loadedItemDatum.stackCount);
								}
								else if (game.state != gameScript.gameState.pack && (game.state != gameScript.gameState.play || loadedItemDatum.moveState == -1 || !GetIsFlatSurface(closestGrid)) && !SetGrid(closestGrid, itemScript2.xValidate, itemScript2.yValidate, _used: true, itemScript2.sizeValidate))
								{
									Debug.LogWarning(itemScript2.name + " failed SetGrid on load");
								}
								if (!flag || !GetGridActive(closestGrid, itemScript2.xValidate, itemScript2.yValidate))
								{
									itemScript2.Activate(_active: false);
								}
							}
							else
							{
								Debug.LogWarning("item " + itemScript2.name + " failed checkGridSize with an xValidate " + itemScript2.xValidate + " and yValidate " + itemScript2.yValidate + " and is in state : " + ((itemScript.itemState)itemScript2.GetState()/*cast due to .constrained prefix*/).ToString());
								m_itemsLimbo.Add(itemScript2);
								itemScript2.gameObject.SetActive(value: false);
							}
						}
						else
						{
							Debug.LogWarning("no stack parent could be found");
							itemScript2 = ItemLimbo(itemType, num, state);
						}
					}
					if (loadedItemDatum.packState == itemPackType.box)
					{
						list.Add(new boxEntry(loadedItemDatum.boxIndex, game.GetItemIndex(array[0]), itemScript2, num, loadedItemDatum.boxState, loadedItemDatum.boxOrder, _zonePacked: false));
					}
					else if (loadedItemDatum.packState == itemPackType.unmovable)
					{
						if (!_saveLoad)
						{
							AddItemUnmovable(itemScript2);
							if (game.state == gameScript.gameState.pack && GetIsFlatSurface(closestGrid) && !itemScript2.Stacked())
							{
								SetGrid(closestGrid, itemScript2.xWidth, itemScript2.yWidth, _used: true, itemScript2.size);
							}
						}
					}
					else if (loadedItemDatum.packState == itemPackType.movable)
					{
						if (_saveLoad)
						{
							continue;
						}
						AddItemMovable(itemScript2);
						if (loadedItemDatum.moveState != -1)
						{
							itemScript2.PackMovableSet(loadedItemDatum.moveState, loadedItemDatum.move);
							if (game.state == gameScript.gameState.pack)
							{
								Vector3 move = loadedItemDatum.move;
								int num2 = GetClosestGridNoCheck(move, _boxCheck: true);
								if (num2 != -1 && Vector3.Distance(move, m_nodes[num2].position) > 0.01f)
								{
									num2 = -1;
								}
								itemScript2.PackMovablePlace(move, _valid: true, GetParent(num2));
								if (num2 != -1 && !SetGrid(num2, itemScript2.packMovableX, itemScript2.packMovableY, _used: true, itemScript2.packMovableSize))
								{
									Debug.LogWarning(base.name + " | " + itemScript2.name + " failed SetGrid (A)");
								}
							}
						}
						else if (game.state == gameScript.gameState.pack && GetIsFlatSurface(closestGrid) && !itemScript2.Stacked() && !itemScript2.Shelved() && !SetGrid(closestGrid, itemScript2.xWidth, itemScript2.yWidth, _used: true, itemScript2.size))
						{
							Debug.LogWarning(base.name + " | " + itemScript2.name + " failed SetGrid (B)");
						}
					}
					else if (game.state != gameScript.gameState.play && loadedItemDatum.packState == itemPackType.zone)
					{
						itemScript2.BoxAssign(game.GetZoneFromName(loadedItemDatum.zonePack), null);
					}
				}
				else
				{
					Debug.LogWarning("item position " + new Vector2(loadedItemDatum.x, loadedItemDatum.y).ToString() + " does not fit any grid nodes : " + array[0]);
					itemScript item = ItemLimbo(itemType, num, state);
					if (loadedItemDatum.boxIndex > -1)
					{
						list.Add(new boxEntry(loadedItemDatum.boxIndex, game.GetItemIndex(array[0]), item, num, loadedItemDatum.boxState, loadedItemDatum.boxOrder, _zonePacked: false));
					}
				}
			}
			else
			{
				Debug.LogWarning("item type '" + array[0] + "' could not be found");
			}
		}
		foreach (zonePackedData item2 in m_loadedZonePacked)
		{
			if (item2.boxIndex > -1)
			{
				string[] array2 = item2.name.Split('|');
				int itemVariant = 0;
				if (array2.Length > 1)
				{
					itemScript itemType2 = game.GetItemType(array2[0]);
					itemVariant = ((itemType2 != null) ? itemType2.FindVariant(array2[1]) : 0);
				}
				list.Add(new boxEntry(item2.boxIndex, game.GetItemIndex(array2[0]), null, itemVariant, item2.boxState, item2.boxOrder, _zonePacked: true));
			}
		}
		foreach (boxData loadedBoxDatum in m_loadedBoxData)
		{
			boxScript boxType = game.GetBoxType(loadedBoxDatum.name);
			if (boxType != null)
			{
				int closestGrid2 = GetClosestGrid(new Vector2(loadedBoxDatum.x, loadedBoxDatum.y));
				int state2 = loadedBoxDatum.state;
				if (closestGrid2 > -1)
				{
					if (loadedBoxDatum.stackPosition == 0)
					{
						boxScript boxScript2 = UnityEngine.Object.Instantiate(boxType);
						if (state2 == 1)
						{
							boxScript2.Turn();
						}
						boxScript2.Place(GetGrid(closestGrid2), closestGrid2, null, base.transform);
						if (game.state != gameScript.gameState.arrange)
						{
							SetGrid(closestGrid2, boxScript2.xWidth, boxScript2.yWidth, _used: true, boxScript2.size);
						}
						AddBox(boxScript2);
						continue;
					}
					boxScript boxScript3 = FindTopBoxStack(closestGrid2);
					if (boxScript3 != null)
					{
						boxScript boxScript4 = UnityEngine.Object.Instantiate(boxType);
						if (state2 == 1)
						{
							boxScript4.Turn();
						}
						Vector3 position2 = ((boxScript3 == null) ? GetGrid(closestGrid2) : boxScript3.GetStackPosition());
						boxScript4.Place(position2, closestGrid2, boxScript3, base.transform);
						AddBox(boxScript4);
					}
					else
					{
						Debug.LogWarning("no stack parent could be found for a box");
					}
				}
				else
				{
					Debug.LogWarning("box position " + new Vector2(loadedBoxDatum.x, loadedBoxDatum.y).ToString() + " does not fit any grid nodes");
				}
			}
			else
			{
				Debug.LogWarning("box type '" + loadedBoxDatum.name + "' could not be found");
			}
		}
		foreach (boxEntry item3 in list)
		{
			if (item3.boxID < 0 || item3.boxID >= m_boxes.Count)
			{
				Debug.LogWarning(game.m_itemTypes[item3.itemID].name + " cannot be packed in a " + base.name + " box because the box does not exist! (boxID : " + item3.boxID + " )");
			}
			else
			{
				m_boxes[item3.boxID].AddContents(this, item3.item, item3.itemID, item3.itemVariant, item3.itemState, item3.boxOrder, item3.zonePacked);
			}
		}
		foreach (boxScript box in m_boxes)
		{
			if (game.state == gameScript.gameState.arrange)
			{
				box.gameObject.SetActive(value: false);
			}
			else if (game.state == gameScript.gameState.play)
			{
				box.SettleContents();
				box.Init(this);
			}
		}
		shelfStandScript[] shelves;
		if (game.state == gameScript.gameState.play)
		{
			shelves = m_shelves;
			for (int i = 0; i < shelves.Length; i++)
			{
				shelves[i].RemoveGaps();
			}
			foreach (itemScript item4 in m_itemsMovable)
			{
				if (item4.packMovable)
				{
					Vector3 packMovablePosition = item4.packMovablePosition;
					int closestGridNoCheck = GetClosestGridNoCheck(packMovablePosition, _boxCheck: true);
					if (closestGridNoCheck != -1 && !GetGridUsed(closestGridNoCheck, item4.packMovableX, item4.packMovableY) && m_nodes[closestGridNoCheck].m_style == itemNode.nodeStyle.flat)
					{
						if (item4.Stacked())
						{
							Vector2 stackDimentions = item4.GetStackDimentions();
							int usedSize = (item4.isOnCombine ? item4.Uncombine() : item4.Unstack());
							SetGrid(item4.Node(), (int)stackDimentions.x, (int)stackDimentions.y, _used: true, usedSize);
						}
						else if (item4.isOnHanger)
						{
							SetGrid(item4.Node(), 1, 1, _used: true, item4.Unhanger());
						}
						else if (item4.isOnHook || item4.isOnHolder)
						{
							item4.Unhook();
							SetGrid(item4.Node(), 1, 1, _used: false, 0);
						}
						else if (item4.Shelved())
						{
							item4.Unshelf();
						}
						else if (GetWall(item4.Node()))
						{
							SetGrid(item4.Node(), item4.m_xWall, item4.m_yWall, _used: false, 0);
						}
						else if (GetStyle(item4.Node()) == itemScript.nodeStyle.bar)
						{
							SetGrid(item4.Node(), 1, item4.m_barWidth, _used: false, 0);
						}
						else if (GetStyle(item4.Node()) == itemScript.nodeStyle.barFlipped)
						{
							SetGrid(item4.Node(), item4.m_barWidth, 1, _used: false, 0);
						}
						else if (GetStyle(item4.Node()) == itemScript.nodeStyle.rack || GetStyle(item4.Node()) == itemScript.nodeStyle.rackFlipped)
						{
							SetGrid(item4.Node(), 1, 1, _used: false, 0);
						}
						if (item4.Parent() != null && item4.Parent().CompareTag("drawer"))
						{
							item4.Parent().GetComponent<drawerScript>().RemoveItem(item4);
						}
						Transform parent = GetParent(closestGridNoCheck);
						Vector3 vector2 = Vector3.zero;
						if (parent != null && parent.CompareTag("drawer"))
						{
							vector2 = parent.GetComponent<drawerScript>().GetOffset();
						}
						RemoveItem(item4);
						itemScript.nodeStyle style = GetStyle(closestGridNoCheck);
						itemScript.positionAction action2 = (item4.Validate(GetType(closestGridNoCheck), CheckType(closestGridNoCheck, item4.packMovableX, item4.packMovableY)) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid);
						item4.SetState(item4.packMovableState);
						item4.Position(GetGrid(closestGridNoCheck) + vector2, action2, _unboxed: false, null, closestGridNoCheck, GetMaskLevel(closestGridNoCheck, item4.packMovableX, item4.packMovableY), GetGridForeground(closestGridNoCheck, item4.packMovableX, item4.packMovableY), parent, style, GetBoxSize(closestGridNoCheck));
						SetGrid(closestGridNoCheck, item4.xWidth, item4.yWidth, _used: true, item4.size);
						AddItem(item4);
						item4.Activate(GetGridActive(closestGridNoCheck, item4.xValidate, item4.yValidate));
					}
					else
					{
						Debug.LogWarning(item4.name + " could not be set to its itemMovable position! (node : " + closestGridNoCheck + ")");
						if (GetIsFlatSurface(item4.Node()) && !item4.Stacked())
						{
							SetGrid(item4.Node(), item4.xWidth, item4.yWidth, _used: true, item4.size);
						}
					}
				}
				if (item4.isValid)
				{
					item4.StartValid();
				}
			}
			foreach (itemScript item5 in m_itemsUnmovable)
			{
				if (!item5.isValid)
				{
					m_validItems++;
				}
				else
				{
					item5.StartValid();
				}
				item5.unmovable = true;
			}
		}
		shelves = m_shelves;
		foreach (shelfStandScript shelfStandScript3 in shelves)
		{
			shelfStandScript3.RemoveGaps();
			if (game.state != gameScript.gameState.pack)
			{
				shelfStandScript3.SetGrid();
			}
			if (game.state == gameScript.gameState.play)
			{
				shelfStandScript3.SetCollisionIfUnmovable();
			}
			else if (game.state == gameScript.gameState.arrange)
			{
				shelfStandScript3.SetCollision(_value: true);
			}
			else if (game.state == gameScript.gameState.pack)
			{
				shelfStandScript3.SetCollision(_value: false);
			}
		}
		m_fileOpen = false;
		if (game.state == gameScript.gameState.pack)
		{
			SetItemShow();
		}
		if (!activeSelf)
		{
			base.transform.localPosition = localPosition;
			base.gameObject.SetActive(activeSelf);
		}
	}

	public void ConnectZonePackedItems()
	{
		List<itemScript> itemsFromOtherZones = game.GetItemsFromOtherZones(this);
		for (int i = 0; i < itemsFromOtherZones.Count; i++)
		{
			if (!(itemsFromOtherZones[i].GetBox() == null))
			{
				continue;
			}
			int itemIndex = game.GetItemIndex(itemsFromOtherZones[i].name.Replace("(Clone)", ""));
			int variant = itemsFromOtherZones[i].GetVariant();
			using (List<boxScript>.Enumerator enumerator = m_boxes.GetEnumerator())
			{
				while (enumerator.MoveNext() && !enumerator.Current.MatchOrphan(this, itemsFromOtherZones[i], itemIndex, variant))
				{
				}
			}
		}
		foreach (boxScript box in m_boxes)
		{
			box.SettleContents();
		}
	}

	public void ForceActivateBoxes()
	{
		foreach (boxScript box in m_boxes)
		{
			box.gameObject.SetActive(value: true);
			box.Init(this);
		}
	}

	public void ForceMovable()
	{
		foreach (itemScript item in m_itemsUnmovable)
		{
			item.unmovable = false;
		}
	}

	public saveData.saveDataZone GetSaveData()
	{
		saveData.saveDataItem[] array = new saveData.saveDataItem[m_items.Count];
		for (int i = 0; i < m_items.Count; i++)
		{
			array[i] = m_items[i].GetSaveData(!m_itemsUnmovable.Contains(m_items[i]));
		}
		saveData.saveDataBox[] array2 = new saveData.saveDataBox[m_boxes.Count];
		for (int j = 0; j < m_loadedBoxData.Count; j++)
		{
			array2[j] = m_boxes[j].GetSaveData();
		}
		bool[] array3 = new bool[m_doors.Length];
		for (int k = 0; k < m_doors.Length; k++)
		{
			array3[k] = m_doors[k].isOpen;
		}
		bool[] array4 = new bool[m_doorsSliding.Length];
		for (int l = 0; l < m_doorsSliding.Length; l++)
		{
			array4[l] = m_doorsSliding[l].isOpen;
		}
		bool[] array5 = new bool[m_doorsFolding.Length];
		for (int m = 0; m < m_doorsFolding.Length; m++)
		{
			array5[m] = m_doorsFolding[m].isOpen;
		}
		saveData.saveDataZone.saveDataDrawerManager[] array6 = new saveData.saveDataZone.saveDataDrawerManager[m_drawers.Length];
		for (int n = 0; n < m_drawers.Length; n++)
		{
			array6[n] = m_drawers[n].GetSaveData();
		}
		bool[] array7 = new bool[m_lamps.Length];
		for (int num = 0; num < m_lamps.Length; num++)
		{
			array7[num] = m_lamps[num].isOn;
		}
		return new saveData.saveDataZone(array, array2, array3, array4, array5, array6, array7);
	}

	public void SetSaveData(saveData.saveDataZone _saveDataZone)
	{
		base.transform.localPosition = Vector3.zero;
		LoadItems(_auto: true, _saveLoad: true);
		m_levelLoad = true;
		for (int num = Mathf.Min(_saveDataZone.boxes.Length, m_boxes.Count) - 1; num >= 0; num--)
		{
			m_boxes[num].SetSaveData(_saveDataZone.boxes[num], this);
		}
		List<attachmentStates> list = new List<attachmentStates>();
		for (int i = 0; i < _saveDataZone.items.Length; i++)
		{
			int grid = _saveDataZone.items[i].grid;
			if (grid >= m_nodes.Length)
			{
				Debug.LogWarning("item " + _saveDataZone.items[i].type + " has an invalid grid index");
				continue;
			}
			int stackOrder = _saveDataZone.items[i].stackOrder;
			int state = _saveDataZone.items[i].state;
			Transform transform = GetParent(grid);
			Vector3 vector = Vector3.zero;
			bool flag = true;
			if (transform != null && transform.CompareTag("drawer"))
			{
				vector = transform.GetComponent<drawerScript>().GetOffset();
				flag = transform.GetComponent<drawerScript>().isActive;
			}
			bool flag2 = state == 20 || state == 21;
			shelfStandScript shelfStandScript2 = ((state == 5 || state == 6) ? FindShelf(grid) : null);
			itemScript itemScript2 = ((stackOrder == 0 || shelfStandScript2 != null) ? null : FindTopStack(grid));
			itemScript itemScript3 = ((state == 16 || state == 17) ? FindHanger(grid) : null);
			if (stackOrder == 0 || shelfStandScript2 != null || itemScript2 != null)
			{
				itemScript itemType = game.GetItemType(_saveDataZone.items[i].type);
				if (itemType != null && CanItemUseNode(grid, itemType))
				{
					itemScript itemScript4 = UnityEngine.Object.Instantiate(itemType);
					itemScript4.SetVariant(_saveDataZone.items[i].variant);
					itemScript4.SetState(state, _saveDataZone.items[i].flatState);
					int maskLevel = ((!(shelfStandScript2 != null) && GetIsFlatSurface(grid)) ? ((itemScript2 != null) ? itemScript2.maskId : GetMaskLevel(grid, itemScript4.xWidth, itemScript4.yWidth)) : 0);
					if (itemScript2 != null)
					{
						transform = itemScript2.m_artPivot;
					}
					else if (itemScript3 != null)
					{
						transform = itemScript3.m_artPivot;
					}
					itemScript.nodeStyle style = (flag2 ? itemScript2.CombineStyle() : ((shelfStandScript2 != null) ? shelfStandScript2.NodeStyle() : ((itemScript3 != null) ? itemScript3.HangerStyle() : GetStyle(grid))));
					Vector3 position = ((shelfStandScript2 != null) ? Vector3.zero : (flag2 ? itemScript2.CombinePosition(itemScript4.combineDepth) : ((itemScript3 != null) ? itemScript3.HangerPosition(itemScript4) : ((itemScript2 != null) ? itemScript2.StackPosition(itemScript4) : (GetGrid(grid) + vector)))));
					itemScript.positionAction action = ((!(itemScript2 != null) || !itemScript4.m_stackInheritValid) ? (IsItemValid(itemScript4, (itemScript2 == null) ? itemScript4 : itemScript2, grid, style) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid) : (itemScript2.isValid ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid));
					if (_saveDataZone.items[i].pinTypes.Length != 0)
					{
						itemScript.pinState pinState = (itemScript.pinState)_saveDataZone.items[i].pinState;
						gameScript.pinType[] array = new gameScript.pinType[_saveDataZone.items[i].pinTypes.Length];
						for (int j = 0; j < array.Length; j++)
						{
							switch (pinState)
							{
							case itemScript.pinState.pinboard:
								array[j] = game.m_pinboardPins[_saveDataZone.items[i].pinTypes[j]];
								break;
							case itemScript.pinState.fridge:
								array[j] = game.m_fridgeMagnets[_saveDataZone.items[i].pinTypes[j]];
								break;
							}
						}
						itemScript4.AddPins(GetPinState(grid), _saveDataZone.items[i].pinTypes, array);
					}
					int foreground = ((itemScript2 == null) ? GetGridForeground(grid, itemScript4.xValidate, itemScript4.yValidate) : GetGridForeground(grid, itemScript2.xValidate, itemScript2.yValidate));
					itemScript4.Position(position, action, _unboxed: false, itemScript2, grid, maskLevel, foreground, transform, style, GetBoxSize(grid));
					if (SingleNode(m_nodes[grid].m_style))
					{
						itemScript4.Hook(transform.GetComponent<hookScript>());
					}
					else if (itemScript2 != null)
					{
						if (flag2)
						{
							itemScript4.Combine(itemScript2);
						}
						else
						{
							itemScript4.Stack(itemScript2);
						}
					}
					else if (itemScript3 != null)
					{
						itemScript4.Hanger(itemScript3);
					}
					if (CheckGridSize(grid, itemScript4.xValidate, itemScript4.yValidate))
					{
						AddItem(itemScript4);
						if (shelfStandScript2 != null)
						{
							shelfStandScript2.SimpleAddAtIndex(itemScript4, stackOrder);
						}
						else
						{
							SetGrid(grid, itemScript4.xValidate, itemScript4.yValidate, _used: true, itemScript4.sizeValidate);
						}
						if (!flag)
						{
							itemScript4.Activate(_active: false);
						}
						if (!_saveDataZone.items[i].movable)
						{
							m_itemsUnmovable.Add(itemScript4);
							if (!itemScript4.isValid)
							{
								m_validItems++;
							}
							itemScript4.unmovable = true;
						}
						if (_saveDataZone.items[i].attachmentStates.Length != 0)
						{
							list.Add(new attachmentStates(itemScript4, _saveDataZone.items[i].attachmentStates));
						}
					}
					else
					{
						Debug.LogWarning("item " + itemScript4.name + " failed checkGridSize with an xValidate " + itemScript4.xValidate + " and yValidate " + itemScript4.yValidate + " and is in state : " + ((itemScript.itemState)itemScript4.GetState()/*cast due to .constrained prefix*/).ToString());
					}
				}
				else
				{
					Debug.LogWarning("item " + _saveDataZone.items[i].type + " not found in stage item list");
				}
			}
			else
			{
				Debug.LogWarning("item " + _saveDataZone.items[i].type + " has no stack parent | stack order : " + _saveDataZone.items[i].stackOrder);
			}
		}
		foreach (attachmentStates item in list)
		{
			item.script.SetAttachmentStates(item.data);
		}
		shelfStandScript[] shelves = m_shelves;
		foreach (shelfStandScript obj in shelves)
		{
			obj.RemoveGaps();
			obj.SetGrid();
			obj.SetCollisionIfUnmovable();
		}
		for (int l = 0; l < Mathf.Min(_saveDataZone.doorHinge.Length, m_doors.Length); l++)
		{
			m_doors[l].SetSaveData(_saveDataZone.doorHinge[l]);
		}
		for (int m = 0; m < Mathf.Min(_saveDataZone.doorSlide.Length, m_doorsSliding.Length); m++)
		{
			m_doorsSliding[m].SetSaveData(_saveDataZone.doorSlide[m]);
		}
		for (int n = 0; n < Mathf.Min(_saveDataZone.doorFold.Length, m_doorsFolding.Length); n++)
		{
			m_doorsFolding[n].SetSaveData(_saveDataZone.doorFold[n]);
		}
		for (int num2 = 0; num2 < Mathf.Min(_saveDataZone.drawerManager.Length, m_drawers.Length); num2++)
		{
			m_drawers[num2].SetSaveData(_saveDataZone.drawerManager[num2].drawer);
		}
		if (_saveDataZone.environmentMisc != null)
		{
			for (int num3 = 0; num3 < Mathf.Min(_saveDataZone.environmentMisc.Length, m_lamps.Length); num3++)
			{
				m_lamps[num3].SetSaveData(_saveDataZone.environmentMisc[num3]);
			}
		}
		m_levelLoad = false;
	}

	public int GetBoxContentCount(int _index)
	{
		if (_index < m_boxes.Count)
		{
			return m_boxes[_index].GetFullItemCount();
		}
		return 0;
	}

	public void DisconnectItems(ref List<gameScript.matchItem> _matchList, string[] _ignoreList, int _zone)
	{
		if (GetComponent<zoneRemapScript>() == null)
		{
			return;
		}
		m_fileOpen = true;
		for (int num = m_items.Count - 1; num >= 0; num--)
		{
			int num2 = m_items[num].Node();
			if (GetStyle(num2) != itemScript.nodeStyle.box)
			{
				string value = m_items[num].name.Replace("(Clone)", "") + m_items[num].GetVariantString();
				bool flag = false;
				for (int i = 0; i < _ignoreList.Length; i++)
				{
					if (_ignoreList[i].Equals(value))
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					itemScript itemScript2 = m_items[num];
					if (itemScript2.Stacked())
					{
						Vector2 stackDimentions = itemScript2.GetStackDimentions();
						int usedSize = (itemScript2.isOnCombine ? itemScript2.Uncombine() : itemScript2.Unstack());
						SetGrid(num2, (int)stackDimentions.x, (int)stackDimentions.y, _used: true, usedSize);
					}
					else if (itemScript2.isOnHanger)
					{
						SetGrid(num2, 1, 1, _used: true, itemScript2.Unhanger());
					}
					else if (itemScript2.isOnHook || itemScript2.isOnHolder)
					{
						itemScript2.Unhook();
						SetGrid(num2, 1, 1, _used: false, itemScript2.size);
					}
					else if (itemScript2.Shelved())
					{
						itemScript2.Unshelf();
					}
					else if (GetWall(num2))
					{
						SetGrid(itemScript2.Node(), itemScript2.m_xWall, itemScript2.m_yWall, _used: false, 0);
					}
					else if (GetStyle(itemScript2.Node()) == itemScript.nodeStyle.bar)
					{
						SetGrid(num2, 1, itemScript2.m_barWidth, _used: false, 0);
					}
					else if (GetStyle(num2) == itemScript.nodeStyle.barFlipped)
					{
						SetGrid(num2, itemScript2.m_barWidth, 1, _used: false, 0);
					}
					else if (GetStyle(num2) == itemScript.nodeStyle.rack || GetStyle(num2) == itemScript.nodeStyle.rackFlipped)
					{
						SetGrid(num2, 1, 1, _used: false, itemScript2.size);
					}
					else
					{
						SetGrid(num2, itemScript2.xWidth, itemScript2.yWidth, _used: false, 0);
					}
					if (itemScript2.Parent() != null && itemScript2.Parent().CompareTag("drawer"))
					{
						itemScript2.Parent().GetComponent<drawerScript>().RemoveItem(itemScript2);
					}
					_matchList.Add(new gameScript.matchItem(itemScript2, _zone, GetGrid(num2), m_nodes[num2].m_style, m_nodes[num2].type));
					RemoveItem(itemScript2);
					itemScript2.gameObject.SetActive(value: false);
				}
			}
		}
		m_fileOpen = false;
	}

	private bool FitItem(itemScript _item, saveData.saveDataItem _saveItem, Vector2 _startingPos, itemNode.nodeType _type, itemNode.nodeStyle _style)
	{
		List<searchNode> list = new List<searchNode>();
		int xValidate = _item.xValidate;
		int yValidate = _item.yValidate;
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!m_nodes[i].m_boxTop && (m_nodes[i].type == _type || m_nodes[i].type == itemNode.nodeType.overflow) && m_nodes[i].m_style == _style && (!_item.isOnHanger || m_nodes[i].m_used) && (!_item.isOnCombine || m_nodes[i].m_used) && (_item.isOnCombine || m_nodes[i].type != itemNode.nodeType.overflow || (CheckGridSize(i, xValidate, yValidate) && CheckType(i, xValidate, yValidate) == _type)))
			{
				list.Add(new searchNode(i, ((Vector2)m_nodes[i].position - _startingPos).sqrMagnitude));
			}
		}
		list.Sort();
		for (int j = 0; j < list.Count; j++)
		{
			if (_item.isOnShelf)
			{
				shelfStandScript shelfStandScript2 = FindShelf(list[j].index);
				if (shelfStandScript2 != null && shelfStandScript2.CheckFit(_item, _checkActive: false))
				{
					int index = list[j].index;
					Transform parent = GetParent(index);
					itemScript.nodeStyle style = shelfStandScript2.NodeStyle();
					itemScript.positionAction action = (IsItemValid(_item, _item, index, style) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid);
					int gridForeground = GetGridForeground(index, _item.xValidate, _item.yValidate);
					_item.Position(Vector3.zero, action, _unboxed: false, null, index, 0, gridForeground, parent, style, GetBoxSize(index));
					AddItem(_item);
					shelfStandScript2.AddItem(_item);
					return true;
				}
			}
			else if (m_nodes[list[j].index].m_used)
			{
				itemScript itemScript2 = FindItem(list[j].index);
				if (itemScript2 != null)
				{
					itemScript2 = itemScript2.TopStack();
					if (itemScript2.StackCheck(_item, _checkActive: false) && itemScript2.StackValid(GetGridSize(itemScript2), _item))
					{
						int num = itemScript2.Node();
						GetParent(num);
						int maskId = itemScript2.maskId;
						itemScript.nodeStyle style2 = GetStyle(num);
						Vector3 position = itemScript2.StackPosition(_item);
						itemScript.positionAction action2 = ((!_item.m_stackInheritValid) ? (IsItemValid(_item, itemScript2, num, style2) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid) : (itemScript2.isValid ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid));
						int gridForeground2 = GetGridForeground(num, itemScript2.xValidate, itemScript2.yValidate);
						_item.Position(position, action2, _unboxed: false, itemScript2, num, maskId, gridForeground2, itemScript2.m_artPivot, style2, GetBoxSize(num));
						_item.Stack(itemScript2);
						AddItem(_item);
						SetGrid(num, _item.xValidate, _item.yValidate, _used: true, _item.sizeValidate);
						_item.Activate(GetGridActive(num, _item.xValidate, _item.yValidate));
						return true;
					}
					if (_item.isOnCombine && itemScript2.CombineCheck(_item) && GetGridSize(itemScript2) >= _item.m_sizeCombine)
					{
						int num2 = itemScript2.Node();
						GetParent(num2);
						itemScript.nodeStyle style3 = itemScript2.CombineStyle();
						itemScript.positionAction action3 = ((!_item.m_stackInheritValid) ? (IsItemValid(_item, itemScript2, itemScript2.Node(), style3) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid) : (itemScript2.isValid ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid));
						_item.Position(itemScript2.CombinePosition(_item.combineDepth), action3, _unboxed: false, itemScript2, num2, itemScript2.maskId, GetGridForeground(num2, itemScript2.xValidate, itemScript2.yValidate), itemScript2.m_artPivot, style3, GetBoxSize(num2));
						_item.Combine(itemScript2);
						AddItem(_item);
						SetGrid(num2, _item.xValidate, _item.yValidate, _used: true, _item.sizeValidate);
						_item.Activate(GetGridActive(num2, _item.xValidate, _item.yValidate));
						return true;
					}
				}
				else if (_item.isOnHanger)
				{
					itemScript2 = FindHanger(list[j].index);
					if (itemScript2 != null && itemScript2.HangerCheck() && itemScript2.isOnRack && itemScript2.m_hangerType == _item.m_hangerType && _item.hangerSize <= GetGridSize(itemScript2.Node()))
					{
						int num3 = itemScript2.Node();
						Transform artPivot = itemScript2.m_artPivot;
						itemScript.nodeStyle style4 = itemScript2.HangerStyle();
						Vector3 position2 = itemScript2.HangerPosition(_item);
						itemScript.positionAction action4 = (IsItemValid(_item, _item, num3, style4) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid);
						int gridForeground3 = GetGridForeground(num3, _item.xValidate, _item.yValidate);
						_item.Position(position2, action4, _unboxed: false, null, num3, 0, gridForeground3, artPivot, style4, GetBoxSize(num3));
						_item.Hanger(itemScript2);
						AddItem(_item);
						SetGrid(num3, _item.xValidate, _item.yValidate, _used: true, _item.sizeValidate);
						_item.Activate(GetGridActive(num3, _item.xValidate, _item.yValidate));
						return true;
					}
				}
			}
			else if (_item.isOnHanger)
			{
				Debug.LogWarning("item " + _item.name + " wants a hanger but there's no item here");
			}
			else
			{
				if (_item.isOnCombine || !CheckGridSize(list[j].index, _item.xValidate, _item.yValidate, _item.sizeValidate) || !CanItemUseNode(list[j].index, _item))
				{
					continue;
				}
				int index2 = list[j].index;
				Transform parent2 = GetParent(index2);
				Vector3 vector = Vector3.zero;
				if (parent2 != null && parent2.CompareTag("drawer"))
				{
					vector = parent2.GetComponent<drawerScript>().GetOffset();
				}
				int maskLevel = GetMaskLevel(index2, _item.xValidate, _item.yValidate);
				itemScript.nodeStyle style5 = GetStyle(index2);
				Vector3 position3 = GetGrid(index2) + vector;
				itemScript.positionAction action5 = (IsItemValid(_item, _item, index2, style5) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid);
				if (_saveItem.pinTypes != null && _saveItem.pinTypes.Length != 0)
				{
					itemScript.pinState pinState = (itemScript.pinState)_saveItem.pinState;
					gameScript.pinType[] array = new gameScript.pinType[_saveItem.pinTypes.Length];
					for (int k = 0; k < array.Length; k++)
					{
						switch (pinState)
						{
						case itemScript.pinState.pinboard:
							array[k] = game.m_pinboardPins[_saveItem.pinTypes[k]];
							break;
						case itemScript.pinState.fridge:
							array[k] = game.m_fridgeMagnets[_saveItem.pinTypes[k]];
							break;
						}
					}
					_item.AddPins(GetPinState(index2), _saveItem.pinTypes, array);
				}
				int gridForeground4 = GetGridForeground(index2, _item.xValidate, _item.yValidate);
				_item.Position(position3, action5, _unboxed: false, null, index2, maskLevel, gridForeground4, parent2, style5, GetBoxSize(index2));
				if (SingleNode(m_nodes[index2].m_style))
				{
					_item.Hook(parent2.GetComponent<hookScript>());
				}
				AddItem(_item);
				SetGrid(index2, _item.xValidate, _item.yValidate, _used: true, _item.sizeValidate);
				_item.Activate(GetGridActive(index2, _item.xValidate, _item.yValidate));
				return true;
			}
		}
		return false;
	}

	private bool FitItem(itemScript _item, Vector2 _startingPos, validType _valid)
	{
		_item.SetState(_item.GetPlaceableState());
		int num = _item.xValidate;
		int num2 = _item.yValidate;
		int sizeValidate = _item.sizeValidate;
		List<searchNode> list = new List<searchNode>();
		for (int i = 0; i < m_nodes.Length; i++)
		{
			if (!m_nodes[i].m_boxTop && !m_nodes[i].m_used && m_nodes[i].m_style == itemNode.nodeStyle.flat && m_nodes[i].size >= sizeValidate)
			{
				list.Add(new searchNode(i, ((Vector2)m_nodes[i].position - _startingPos).sqrMagnitude));
			}
		}
		list.Sort();
		for (int j = 0; j < list.Count; j++)
		{
			bool flag = false;
			int num3 = FitGrid(list[j].index, num, num2, sizeValidate);
			if (num3 == -1 && num != num2)
			{
				flag = true;
				num3 = FitGrid(list[j].index, num2, num, sizeValidate);
			}
			if (num3 <= -1)
			{
				continue;
			}
			bool flag2 = _item.Validate(m_type, CheckType(num3, flag ? num2 : num, flag ? num : num2));
			if (_valid == validType.any || (_valid == validType.valid && flag2) || (_valid == validType.invalid && !flag2))
			{
				if (flag)
				{
					_item.AdvanceState(1);
					num = _item.XValidate(itemScript.nodeStyle.flat);
					num2 = _item.YValidate(itemScript.nodeStyle.flat);
				}
				Transform parent = GetParent(num3);
				Vector3 vector = Vector3.zero;
				if (parent != null && parent.CompareTag("drawer"))
				{
					vector = parent.GetComponent<drawerScript>().GetOffset();
				}
				_item.Position(GetGrid(num3) + vector, flag2 ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid, _unboxed: false, null, num3, GetMaskLevel(num3, num, num2), GetGridForeground(num3, num, num2), parent, itemScript.nodeStyle.flat, GetBoxSize(num3));
				SetGrid(num3, num, num2, _used: true, sizeValidate);
				_item.Activate(GetGridActive(num3, num, num2));
				AddItem(_item);
				return true;
			}
		}
		return false;
	}

	public void MatchItems(ref List<gameScript.matchItem> _matchList, gameScript.MatchReplace[] _replaceArray, saveData.saveDataItem[] _saveItems, int _zone)
	{
		zoneRemapScript component = GetComponent<zoneRemapScript>();
		if (component == null)
		{
			return;
		}
		m_fileOpen = true;
		for (int i = 0; i < _saveItems.Length; i++)
		{
			string value = _saveItems[i].type;
			int num = _saveItems[i].variant;
			for (int j = 0; j < _replaceArray.Length; j++)
			{
				if (_replaceArray[j].m_sourceName.Equals(value) && _replaceArray[j].m_sourceVariant.Equals(num))
				{
					value = _replaceArray[j].m_replaceName;
					num = _replaceArray[j].m_replaceVariant;
					break;
				}
			}
			for (int k = 0; k < _matchList.Count; k++)
			{
				if (!_matchList[k].item.MatchItem(value, num))
				{
					continue;
				}
				_matchList[k].item.SetState(_saveItems[i].state, _saveItems[i].flatState);
				if (_matchList[k].item.m_usesHolder)
				{
					_matchList[k].item.SetVariant(num);
				}
				itemNode.nodeStyle _style;
				itemNode.nodeType _type;
				Vector2 node = component.GetNode(_saveItems[i].grid, out _style, out _type, _matchList[k].item.xValidate, _matchList[k].item.yValidate);
				if (FitItem(_matchList[k].item, _saveItems[i], node, _type, _style))
				{
					if (!_saveItems[i].movable)
					{
						m_itemsUnmovable.Add(_matchList[k].item);
						if (!_matchList[k].item.isValid)
						{
							m_validItems++;
						}
						_matchList[k].item.unmovable = true;
					}
					if (_saveItems[i].attachmentStates.Length != 0 && !_matchList[k].item.IsComputer())
					{
						_matchList[k].item.SetAttachmentStates(_saveItems[i].attachmentStates);
					}
					_matchList[k].item.gameObject.SetActive(value: true);
					_matchList.RemoveAt(k);
					k--;
					break;
				}
				bool flag = false;
				if (_matchList[k].item.isCombinable && (_saveItems[i].state == 20 || _saveItems[i].state == 21))
				{
					for (int l = 0; l < _matchList.Count; l++)
					{
						if (l != k && _matchList[l].item.m_combineType == _matchList[k].item.m_combineType && !_matchList[l].item.isCombinable)
						{
							_matchList[k].item.Position(_matchList[l].item.CombinePosition(_matchList[k].item.combineDepth), itemScript.positionAction.placedValid, _unboxed: false, _matchList[l].item, -1, 0, 0, _matchList[l].item.m_artPivot, _matchList[l].item.CombineStyle(), 0);
							_matchList[k].item.Combine(_matchList[l].item);
							_matchList[k].item.gameObject.SetActive(value: true);
							_matchList.RemoveAt(k);
							k--;
							break;
						}
					}
				}
				if (!flag)
				{
					_matchList[k] = new gameScript.matchItem(_matchList[k].item, _zone, node, _style, _type);
				}
				break;
			}
		}
		m_fileOpen = false;
	}

	public void MatchRemaining(ref List<gameScript.matchItem> _matchList, gameScript.MatchReplace[] _mimicArray, saveData.saveDataItem[] _saveItems, int _zone, bool _valid)
	{
		m_fileOpen = true;
		zoneRemapScript component = GetComponent<zoneRemapScript>();
		for (int i = 0; i < _matchList.Count; i++)
		{
			if (!_matchList[i].zone.Equals(_zone))
			{
				continue;
			}
			int num = -1;
			if (component != null)
			{
				string text = _matchList[i].item.name.Replace("(Clone)", "");
				for (int j = 0; j < _mimicArray.Length; j++)
				{
					if (!text.Equals(_mimicArray[j].m_replaceName) || !_matchList[i].item.GetVariant().Equals(_mimicArray[j].m_replaceVariant))
					{
						continue;
					}
					for (int k = 0; k < _saveItems.Length; k++)
					{
						if (_saveItems[k].type.Equals(_mimicArray[j].m_sourceName) && _saveItems[k].variant.Equals(_mimicArray[j].m_sourceVariant))
						{
							num = k;
							break;
						}
					}
					break;
				}
			}
			Vector2 startingPos = _matchList[i].position;
			itemNode.nodeType _type = _matchList[i].type;
			itemNode.nodeStyle _style = _matchList[i].style;
			if (num > -1)
			{
				_matchList[i].item.SetState(_saveItems[num].state, _saveItems[num].flatState);
				startingPos = component.GetNode(_saveItems[num].grid, out _style, out _type, _matchList[i].item.xValidate, _matchList[i].item.yValidate);
			}
			if (FitItem(_matchList[i].item, default(saveData.saveDataItem), startingPos, _type, _style))
			{
				_matchList[i].item.gameObject.SetActive(value: true);
				_matchList.RemoveAt(i);
				i--;
			}
		}
		for (int l = 0; l < _matchList.Count; l++)
		{
			if (_matchList[l].zone.Equals(_zone) && FitItem(_matchList[l].item, _matchList[l].position, _valid ? validType.valid : validType.invalid))
			{
				_matchList[l].item.gameObject.SetActive(value: true);
				_matchList.RemoveAt(l);
				l--;
			}
		}
		m_fileOpen = false;
	}

	public void MatchWildcard(ref List<gameScript.matchItem> _matchList)
	{
		m_fileOpen = true;
		for (int i = 0; i < _matchList.Count; i++)
		{
			if (FitItem(_matchList[i].item, Vector2.zero, validType.any))
			{
				_matchList[i].item.gameObject.SetActive(value: true);
				_matchList.RemoveAt(i);
				i--;
			}
		}
		shelfStandScript[] shelves = m_shelves;
		foreach (shelfStandScript obj in shelves)
		{
			obj.RemoveGaps();
			obj.SetGrid();
			obj.SetCollisionIfUnmovable();
		}
		m_fileOpen = false;
	}

	public void SetActive(bool _value)
	{
		for (int i = 0; i < m_keepAlive.Count; i++)
		{
			m_keepAlive[i].Key.SetParent(_value ? m_keepAlive[i].Value : game.keepAlive, worldPositionStays: false);
		}
		base.gameObject.SetActive(_value);
	}
}
