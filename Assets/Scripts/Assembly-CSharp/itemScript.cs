using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class itemScript : MonoBehaviour
{
	[Serializable]
	public class audioID
	{
		public string m_bed;

		public string m_benchtop;

		public string m_box;

		public string m_carpet;

		public string m_ceramic;

		public string m_glass;

		public string m_linoleum;

		public string m_plastic;

		public string m_shelf;

		public string m_sink;

		public string m_stove;

		public string m_tile;

		public string m_woodfloor;

		public string m_stacked;

		public string m_hang;

		public string m_sweetener;

		public audioID()
		{
			m_bed = "";
			m_benchtop = "";
			m_box = "";
			m_carpet = "";
			m_ceramic = "";
			m_glass = "";
			m_linoleum = "";
			m_plastic = "";
			m_shelf = "";
			m_sink = "";
			m_stove = "";
			m_tile = "";
			m_woodfloor = "";
			m_stacked = "";
			m_hang = "";
			m_sweetener = "";
		}

		public string GetSweetener()
		{
			return m_sweetener;
		}

		public string GetID(ref string _surface)
		{
			string id = "";
			switch (_surface)
			{
			case "bed":
				id = m_bed;
				break;
			case "benchtop":
				id = m_benchtop;
				break;
			case "box":
				id = m_box;
				break;
			case "carpet":
				id = m_carpet;
				break;
			case "ceramic":
				id = m_ceramic;
				break;
			case "glass":
				id = m_glass;
				break;
			case "linoleum":
				id = m_linoleum;
				break;
			case "plastic":
				id = m_plastic;
				break;
			case "shelf":
				id = m_shelf;
				break;
			case "sink":
				id = m_sink;
				break;
			case "stove":
				id = m_stove;
				break;
			case "tile":
				id = m_tile;
				break;
			case "woodfloor":
				id = m_woodfloor;
				break;
			case "stacked":
				id = m_stacked;
				break;
			case "hang":
				id = m_hang;
				break;
			}
			return EvaulateSurface(id, ref _surface);
		}

		private string EvaulateSurface(string _id, ref string _surface)
		{
			string[] array = new string[15]
			{
				"_bed", "_benchtop", "_box", "_carpet", "_ceramic", "_glass", "_linoleum", "_plastic", "_shelf", "_sink",
				"_stove", "_tile", "_woodfloor", "_stacked", "_hang"
			};
			for (int i = 0; i < array.Length; i++)
			{
				if (_id.EndsWith(array[i]))
				{
					_surface = array[i].Substring(1);
					return _id.Replace(array[i], "").Trim();
				}
			}
			return _id;
		}
	}

	[Serializable]
	public struct artVariant
	{
		public string name;

		public string[] oldNames;

		public Sprite main;

		public Sprite mainShadow;

		public Sprite flipped;

		public Sprite flippedShadow;

		public Sprite reverse;

		public Sprite reverseShadow;

		public Sprite reverseFlipped;

		public Sprite reverseFlippedShadow;

		public Sprite stacked;

		public Sprite stackedOn;

		public Sprite stackedOnShadow;

		public Sprite combined;

		public Sprite combineMask;

		public Vector2[] combineMaskOffsets;

		public int combineDepth;

		public Sprite wall;

		public Sprite wallShadow;

		public Sprite wallFlipped;

		public Sprite wallFlippedShadow;

		public Sprite hook;

		public Sprite hookBack;

		public Sprite hookFlipped;

		public Sprite hookFlippedBack;

		public Sprite hanger;

		public Sprite hangerBack;

		public Sprite hangerFlipped;

		public Sprite hangerFlippedBack;

		public Sprite standing;

		public Sprite standingShadow;

		public Sprite standingFlipped;

		public Sprite standingFlippedShadow;

		public Sprite bar;

		public Sprite barBack;

		public Sprite barFlipped;

		public Sprite barFlippedBack;

		public Sprite rack;

		public Sprite rackFlipped;

		public Sprite holder;

		public Sprite holderFlipped;

		public int m_stackPixelSize;

		public int m_standPixelSize;

		public string m_sweetener;

		public artVariant(string _name, string[] _oldnames, Sprite _main, Sprite _mainShadow, Sprite _flipped, Sprite _flippedShadow, Sprite _reverse, Sprite _reverseShadow, Sprite _reverseFlipped, Sprite _reverseFlippedShadow, Sprite _stacked, Sprite _stackedOn, Sprite _stackedOnShadow, Sprite _combined, Sprite _combineMask, Vector2[] _combineMaskOffsets, int _combineDepth, Sprite _wall, Sprite _wallShadow, Sprite _wallFlipped, Sprite _wallFlippedShadow, Sprite _hook, Sprite _hookBack, Sprite _hookFlipped, Sprite _hookFlippedBack, Sprite _hanger, Sprite _hangerBack, Sprite _hangerFlipped, Sprite _hangerFlippedBack, Sprite _standing, Sprite _standingShadow, Sprite _standingFlipped, Sprite _standingFlippedShadow, Sprite _bar, Sprite _barBack, Sprite _barFlipped, Sprite _barFlippedBack, Sprite _rack, Sprite _rackFlipped, Sprite _holder, Sprite _holderFlipped, int _stackPixel, int _standPixel, string _sweetener)
		{
			name = _name;
			oldNames = _oldnames;
			main = _main;
			mainShadow = _mainShadow;
			flipped = _flipped;
			flippedShadow = _flippedShadow;
			reverse = _reverse;
			reverseShadow = _reverseShadow;
			reverseFlipped = _reverseFlipped;
			reverseFlippedShadow = _reverseFlippedShadow;
			stacked = _stacked;
			stackedOn = _stackedOn;
			stackedOnShadow = _stackedOnShadow;
			combined = _combined;
			combineMask = _combineMask;
			combineMaskOffsets = _combineMaskOffsets;
			combineDepth = _combineDepth;
			wall = _wall;
			wallShadow = _wallShadow;
			wallFlipped = _wallFlipped;
			wallFlippedShadow = _wallFlippedShadow;
			hook = _hook;
			hookBack = _hookBack;
			hookFlipped = _hookFlipped;
			hookFlippedBack = _hookFlippedBack;
			hanger = _hanger;
			hangerBack = _hangerBack;
			hangerFlipped = _hangerFlipped;
			hangerFlippedBack = _hangerFlippedBack;
			standing = _standing;
			standingShadow = _standingShadow;
			standingFlipped = _standingFlipped;
			standingFlippedShadow = _standingFlippedShadow;
			bar = _bar;
			barBack = _barBack;
			barFlipped = _barFlipped;
			barFlippedBack = _barFlippedBack;
			rack = _rack;
			rackFlipped = _rackFlipped;
			holder = _holder;
			holderFlipped = _holderFlipped;
			m_stackPixelSize = _stackPixel;
			m_standPixelSize = _standPixel;
			m_sweetener = _sweetener;
		}

		public artVariant(string _name)
		{
			name = _name;
			oldNames = new string[0];
			main = null;
			mainShadow = null;
			flipped = null;
			flippedShadow = null;
			reverse = null;
			reverseShadow = null;
			reverseFlipped = null;
			reverseFlippedShadow = null;
			stacked = null;
			stackedOn = null;
			stackedOnShadow = null;
			combined = null;
			combineMask = null;
			combineMaskOffsets = new Vector2[0];
			combineDepth = 0;
			wall = null;
			wallShadow = null;
			wallFlipped = null;
			wallFlippedShadow = null;
			hook = null;
			hookBack = null;
			hookFlipped = null;
			hookFlippedBack = null;
			hanger = null;
			hangerBack = null;
			hangerFlipped = null;
			hangerFlippedBack = null;
			standing = null;
			standingShadow = null;
			standingFlipped = null;
			standingFlippedShadow = null;
			bar = null;
			barBack = null;
			barFlipped = null;
			barFlippedBack = null;
			rack = null;
			rackFlipped = null;
			holder = null;
			holderFlipped = null;
			m_stackPixelSize = 0;
			m_standPixelSize = 0;
			m_sweetener = "";
		}
	}

	[Serializable]
	public struct pinPositions
	{
		public int xPixel;

		public int yPixel;

		public Vector3 position => new Vector3((float)xPixel * 0.01f, (float)yPixel * 0.01f, -0.01f);

		public pinPositions(int _x, int _y)
		{
			xPixel = _x;
			yPixel = _y;
		}
	}

	public enum stackId
	{
		none = 0,
		plateSmall = 2,
		plateLarge = 4,
		bowl = 8,
		tray = 0x10,
		teaTowel = 0x20,
		boardgame = 0x40,
		book = 0x80,
		dvd = 0x100,
		mousepad = 0x200,
		clothing = 0x400,
		toiletPaper = 0x800,
		towel = 0x1000,
		paper = 0x2000,
		choppingBoard = 0x4000,
		markers = 0x8000,
		coasters = 0x10000,
		teaCandles = 0x20000,
		bambooSteamer = 0x40000,
		medication = 0x80000,
		babyBlocks = 0x100000,
		saucer = 0x200000,
		foamHead = 0x400000,
		plantPot = 0x800000,
		miniDrawers = 0x1000000,
		placemat = 0x2000000,
		laptop = 0x4000000,
		tampons = 0x8000000
	}

	public enum combineType
	{
		none = 0,
		mug = 1,
		umbrellaStand = 2,
		ukulele = 3,
		oilBurner = 4
	}

	public enum flipType
	{
		none = 0,
		twoWay = 1,
		FourWay = 2
	}

	public enum RotateType
	{
		rightFacing = 0,
		leftFacing = 1
	}

	public enum hangerType
	{
		top = 0,
		bottom = 1
	}

	public enum itemState
	{
		normal = 0,
		flipped = 1,
		reverse = 3,
		reverseFlipped = 4,
		wallRight = 7,
		wallLeft = 8,
		hooked = 2,
		hookedFlipped = 9,
		standing = 5,
		standingFlipped = 6,
		holder = 10,
		holderFlipped = 11,
		bar = 12,
		barFlipped = 13,
		rack = 14,
		rackFlipped = 15,
		hanger = 16,
		hangerFlipped = 17,
		stacked = 18,
		stackedFlipped = 19,
		combined = 20,
		combinedFlipped = 21
	}

	public enum nodeStyle
	{
		flat = 0,
		box = 1,
		foreground = 2,
		hooked = 3,
		hookedFlipped = 4,
		standing = 5,
		standingFlipped = 6,
		wallRight = 7,
		wallLeft = 8,
		holder = 9,
		holderFlipped = 10,
		bar = 11,
		barFlipped = 12,
		rack = 13,
		rackFlipped = 14,
		hanger = 15,
		hangerFlipped = 16,
		combined = 17,
		combinedFlipped = 18
	}

	public enum positionAction
	{
		unplacable = 0,
		hover = 1,
		placedValid = 2,
		placedInvalid = 3
	}

	private enum displayType
	{
		none = 0,
		hover = 1,
		unplacable = 2,
		invalid = 3,
		unpacked = 4,
		packed = 5,
		packedMovable = 6,
		packedUnmovable = 7,
		touchSelect = 8,
		touchSelectUnplacable = 9
	}

	public enum pinState
	{
		none = 0,
		pinboard = 1,
		fridge = 2
	}

	public List<string> m_oldNames = new List<string>();

	private bool m_init;

	public audioID m_audioID;

	public string m_audioTurnOverride;

	public string m_audioStackSurfaceOverride;

	private GameObject m_audioGO;

	private static bool s_drawGrid;

	private static int s_drawText;

	public static bool s_touchMode;

	private bool m_touchShader;

	private static Material[] s_materials;

	private Material m_mat;

	private Material m_matBack;

	private Material m_matGrid;

	private Dictionary<itemState, Vector2[]> m_physicShapes = new Dictionary<itemState, Vector2[]>();

	private bool m_inDrawer;

	private hookScript m_hook;

	private shelfStandScript m_shelf;

	private itemState m_lastFlatState;

	private bool m_positionValid;

	public Color m_drawColor = Color.white;

	[EnumFlag]
	public zoneScript.zoneKitchen m_zonesKitchen;

	[EnumFlag]
	public zoneScript.zoneBedroom m_zonesBedroom;

	[EnumFlag]
	public zoneScript.zoneBathroom m_zonesBathroom;

	[EnumFlag]
	public zoneScript.zoneLivingRoom m_zonesLivingRoom;

	[EnumFlag]
	public zoneScript.zoneDiningRoom m_zonesDiningRoom;

	[EnumFlag]
	public zoneScript.zoneOffice m_zonesOffice;

	[EnumFlag]
	public zoneScript.zoneNursery m_zonesNursery;

	[EnumFlag]
	public zoneScript.zoneWall m_zonesWall;

	public stackId m_stackID;

	[EnumFlag]
	public stackId m_stackAllowed;

	public combineType m_combineType;

	public bool m_stackStateMatch;

	public bool m_stackAllowLarger;

	public bool m_stackOneOnly;

	public bool m_stackShadow;

	public bool m_stackInheritValid;

	public Vector2[] m_stackOffsets;

	public bool m_usesWall;

	public bool m_usesHook;

	public bool m_usesHanger;

	public bool m_usesStanding;

	public bool m_usesBar;

	public bool m_usesRack;

	public bool m_usesHolder;

	public bool m_usesCombine;

	public flipType m_flipType;

	public RotateType m_rotateType;

	public int m_stackPixelSize;

	public int m_standPixelSize;

	public hangerType m_hangerType;

	private itemScript m_stackParent;

	private itemScript m_stackChild;

	private int m_stackCount;

	private itemScript m_hangerParent;

	private itemScript m_hangerChild;

	private bool m_hangerOverRack;

	private bool m_combined;

	private List<itemScript> m_combineChild = new List<itemScript>();

	public int m_xWidth = 1;

	public int m_yWidth = 1;

	public int m_size = 1;

	public int m_xStanding = 1;

	public int m_yStanding = 1;

	public int m_sizeStanding = 1;

	public int m_xWall = 1;

	public int m_yWall = 1;

	public int m_barWidth = 1;

	public int m_sizeHanger = 1;

	public int m_sizeHook = 3;

	public int m_sizeCombine = 2;

	public float m_boxOffset;

	private bool m_canStackOn = true;

	private float m_totalSize;

	private float m_flippableOffsetCol;

	private itemState m_state;

	public Transform m_artPivot;

	public SpriteRenderer m_renderer;

	public SpriteRenderer m_rendererShadow;

	private float m_shadowDepth;

	private bool m_showShadow = true;

	private bool m_packModeCollision = true;

	private SpriteRenderer[] m_renderersBack;

	private SpriteRenderer[] m_renderers;

	private bool m_noSplit;

	public artVariant[] m_variants;

	private int m_currentVariant;

	public pinPositions[] m_pinPositions;

	private pinState m_pinState;

	private int[] m_pinTypes;

	private Transform[] m_pinTransforms;

	private PolygonCollider2D m_polyCollision;

	private CapsuleCollider2D m_defaultCollision;

	private bool m_environmentEnabled = true;

	private bool m_visibleEnabled = true;

	private bool m_offsetEnabled;

	private bool m_unmovable;

	public Transform[] m_attachments;

	private float m_artOffset;

	private int m_node = -1;

	private Transform m_gridPivot;

	private Transform m_gridShadowPivot;

	private Transform m_gridTextPivot;

	private int m_sortingLayer;

	private int m_maskId;

	private int m_maskFrontSortingOrder;

	private int m_foreground;

	private SpriteMask[] m_mask;

	private SortingGroup m_combineGroup;

	private SpriteRenderer[] m_combineMask;

	private boxScript m_box;

	private zoneScript m_boxZone;

	private bool m_packMovable;

	private Transform m_packMovableVisual;

	private Material m_packMovableMat;

	private LineRenderer m_packMovableLine;

	private itemState m_packMovableState;

	private Vector3 m_packMovablePosition = Vector3.zero;

	private displayType m_display;

	private bool m_invalid;

	public bool m_eletrical;

	public bool m_plant;

	public bool m_magnet;

	public bool m_heavy;

	private float m_bounceValue;

	public GameObject audioGO => m_audioGO;

	public bool isStandable
	{
		get
		{
			if (m_usesStanding)
			{
				return m_stackChild == null;
			}
			return false;
		}
	}

	public bool isWallable
	{
		get
		{
			if (m_usesWall)
			{
				return m_stackChild == null;
			}
			return false;
		}
	}

	public bool isBarable
	{
		get
		{
			if (m_usesBar)
			{
				return m_stackChild == null;
			}
			return false;
		}
	}

	public bool isRackable => m_usesRack;

	public bool isHangable
	{
		get
		{
			if (m_usesHanger && m_stackChild == null)
			{
				return m_hangerParent == null;
			}
			return false;
		}
	}

	public bool isHookable
	{
		get
		{
			if (m_stackChild == null)
			{
				return m_usesHook;
			}
			return false;
		}
	}

	public bool isHolderable
	{
		get
		{
			if (m_stackChild == null)
			{
				return m_usesHolder;
			}
			return false;
		}
	}

	public bool isCombinable => m_usesCombine;

	public bool isNonFlatState
	{
		get
		{
			if (m_state != itemState.normal && m_state != itemState.flipped && m_state != itemState.reverse)
			{
				return m_state != itemState.reverseFlipped;
			}
			return false;
		}
	}

	public bool isOnWall
	{
		get
		{
			if (m_state != itemState.wallLeft)
			{
				return m_state == itemState.wallRight;
			}
			return true;
		}
	}

	public bool isOnHook
	{
		get
		{
			if (m_state != itemState.hooked)
			{
				return m_state == itemState.hookedFlipped;
			}
			return true;
		}
	}

	public bool isOnHolder
	{
		get
		{
			if (m_state != itemState.holder)
			{
				return m_state == itemState.holderFlipped;
			}
			return true;
		}
	}

	public bool isOnBar
	{
		get
		{
			if (m_state != itemState.bar)
			{
				return m_state == itemState.barFlipped;
			}
			return true;
		}
	}

	public bool isOnRack
	{
		get
		{
			if (m_state != itemState.rack)
			{
				return m_state == itemState.rackFlipped;
			}
			return true;
		}
	}

	public bool isOnHanger
	{
		get
		{
			if (m_state != itemState.hanger)
			{
				return m_state == itemState.hangerFlipped;
			}
			return true;
		}
	}

	public bool isOnShelf
	{
		get
		{
			if (m_state != itemState.standing)
			{
				return m_state == itemState.standingFlipped;
			}
			return true;
		}
	}

	public bool isOnCombine
	{
		get
		{
			if (m_state != itemState.combined)
			{
				return m_state == itemState.combinedFlipped;
			}
			return true;
		}
	}

	public bool isValid => !m_invalid;

	public bool canTurn
	{
		get
		{
			if (m_flipType != flipType.none)
			{
				return m_xWidth != m_yWidth;
			}
			return false;
		}
	}

	public int xWidth
	{
		get
		{
			if (!flipped())
			{
				return m_xWidth;
			}
			return m_yWidth;
		}
	}

	public int yWidth
	{
		get
		{
			if (!flipped())
			{
				return m_yWidth;
			}
			return m_xWidth;
		}
	}

	public int size => GetStackSize(null);

	public int standingSize => m_sizeStanding;

	public int standingDepth => m_xStanding;

	public int hangerSize => m_sizeHanger;

	public int barSize => m_sizeHanger - 1;

	public int hookSize => m_sizeHook;

	public int combineDepth => Mathf.Max(1, art.combineDepth);

	public itemScript hangerChild => m_hangerChild;

	public int xValidate
	{
		get
		{
			if (isOnHook || isOnHolder || isOnRack || isOnHanger)
			{
				return 1;
			}
			if (m_state == itemState.bar)
			{
				return 1;
			}
			if (m_state == itemState.barFlipped)
			{
				return m_barWidth;
			}
			if (isOnWall)
			{
				return m_xWall;
			}
			if (m_state == itemState.standing)
			{
				return m_xStanding;
			}
			if (m_state == itemState.standingFlipped)
			{
				return m_yStanding;
			}
			if (m_stackParent != null)
			{
				return m_stackParent.xValidate;
			}
			return xWidth;
		}
	}

	public int yValidate
	{
		get
		{
			if (isOnHook || isOnHolder || isOnRack || isOnHanger)
			{
				return 1;
			}
			if (m_state == itemState.barFlipped)
			{
				return 1;
			}
			if (m_state == itemState.bar)
			{
				return m_barWidth;
			}
			if (isOnWall)
			{
				return m_yWall;
			}
			if (m_state == itemState.standing)
			{
				return m_yStanding;
			}
			if (m_state == itemState.standingFlipped)
			{
				return m_xStanding;
			}
			if (m_stackParent != null)
			{
				return m_stackParent.yValidate;
			}
			return yWidth;
		}
	}

	public int sizeValidate
	{
		get
		{
			if (isOnHook || isOnHolder)
			{
				return m_sizeHook;
			}
			if (isOnRack || isOnHanger)
			{
				return m_sizeHanger;
			}
			if (isOnBar)
			{
				return m_sizeHanger - 1;
			}
			if (isOnWall)
			{
				return 1;
			}
			if (m_state == itemState.standing || m_state == itemState.standingFlipped)
			{
				return m_sizeStanding;
			}
			return size;
		}
	}

	public int stackPixelSize
	{
		get
		{
			if (m_variants != null && m_variants.Length != 0 && m_variants[m_currentVariant].m_stackPixelSize != 0)
			{
				return m_variants[m_currentVariant].m_stackPixelSize;
			}
			return m_stackPixelSize;
		}
	}

	public int standPixelSize
	{
		get
		{
			if (m_variants != null && m_variants.Length != 0 && m_variants[m_currentVariant].m_standPixelSize != 0)
			{
				return m_variants[m_currentVariant].m_standPixelSize;
			}
			if (m_standPixelSize != 0)
			{
				return m_standPixelSize;
			}
			return stackPixelSize;
		}
	}

	protected bool noSplit => m_noSplit;

	private artVariant artBase
	{
		get
		{
			if (m_variants == null || m_variants.Length == 0)
			{
				return default(artVariant);
			}
			return m_variants[0];
		}
	}

	private artVariant art
	{
		get
		{
			if (m_variants == null || m_variants.Length <= m_currentVariant)
			{
				return default(artVariant);
			}
			return m_variants[m_currentVariant];
		}
	}

	public bool unmovable
	{
		get
		{
			return m_unmovable;
		}
		set
		{
			m_unmovable = value;
			EvaluateEnabled();
			if (m_unmovable)
			{
				SetDisplay(displayType.none, _propagate: false);
			}
		}
	}

	protected float artOffset => m_artOffset;

	public int sortingLayer => m_sortingLayer;

	public int maskLevel => m_maskFrontSortingOrder;

	public int maskId => m_maskId;

	public itemScript stackChild => m_stackChild;

	public bool stackBase
	{
		get
		{
			if (m_stackCount == 0)
			{
				return m_stackChild != null;
			}
			return false;
		}
	}

	public int stackCount => m_stackCount;

	public int fullStackCount
	{
		get
		{
			if (m_stackChild != null)
			{
				return m_stackChild.fullStackCount;
			}
			return m_stackCount;
		}
	}

	public bool oversize => m_totalSize > 1f;

	public bool packMovable => m_packMovable;

	public int packMovableState => (int)m_packMovableState;

	public Vector3 packMovablePosition => m_packMovablePosition;

	public int packMovableX
	{
		get
		{
			if (m_packMovableState != itemState.flipped && m_packMovableState != itemState.reverseFlipped)
			{
				return m_xWidth;
			}
			return m_yWidth;
		}
	}

	public int packMovableY
	{
		get
		{
			if (m_packMovableState != itemState.flipped && m_packMovableState != itemState.reverseFlipped)
			{
				return m_yWidth;
			}
			return m_xWidth;
		}
	}

	public int packMovableSize => size;

	public bool inBox => m_box != null;

	public float bounceValue
	{
		get
		{
			return m_bounceValue;
		}
		set
		{
			m_bounceValue = value;
		}
	}

	public void OldName(string _name)
	{
		if (m_oldNames == null)
		{
			m_oldNames = new List<string>();
		}
		if (!m_oldNames.Contains(_name))
		{
			m_oldNames.Add(_name);
		}
	}

	public string GetAudioID(ref string _surface)
	{
		if (m_audioID == null)
		{
			return new audioID().GetID(ref _surface);
		}
		return m_audioID.GetID(ref _surface);
	}

	public string GetAudioSweetener()
	{
		if (m_audioID == null)
		{
			return new audioID().GetSweetener();
		}
		return m_audioID.GetSweetener();
	}

	public string GetAudioTurn(string _turn)
	{
		if (!string.IsNullOrEmpty(m_audioTurnOverride))
		{
			return m_audioTurnOverride;
		}
		return _turn;
	}

	public bool MatchName(string _search)
	{
		if (base.gameObject.name.Remove(0, 4).ToLowerInvariant().Contains(_search))
		{
			return true;
		}
		if (m_variants != null && m_variants.Length > 1)
		{
			artVariant[] variants = m_variants;
			for (int i = 0; i < variants.Length; i++)
			{
				if (variants[i].name.ToLowerInvariant().Contains(_search))
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool ToggleGrid()
	{
		s_drawGrid = !s_drawGrid;
		return s_drawGrid;
	}

	public static int ToggleText()
	{
		s_drawText++;
		if (s_drawText > 2)
		{
			s_drawText = 0;
		}
		return s_drawText;
	}

	private void StorePhysics()
	{
		m_physicShapes.Clear();
		if ((0u | (TryAddPhysics(art.main, artBase.main, itemState.normal) ? 1u : 0u) | (TryAddPhysics(art.flipped, artBase.flipped, itemState.flipped) ? 1u : 0u) | (TryAddPhysics(art.reverse, artBase.reverse, itemState.reverse) ? 1u : 0u) | (TryAddPhysics(art.reverseFlipped, artBase.reverseFlipped, itemState.reverseFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(m_xWidth, m_yWidth, m_size, 0f, itemState.normal);
		}
		TryAddPhysics(art.stacked, artBase.stacked, itemState.stacked);
		if (m_usesHook && (0u | (TryAddPhysics(art.hook, artBase.hook, itemState.hooked) ? 1u : 0u) | (TryAddPhysics(art.hookFlipped, artBase.hookFlipped, itemState.hookedFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(1, 1, 3, 0f, itemState.hooked);
		}
		if (m_usesHolder)
		{
			_ = 0u | (TryAddPhysics(art.holder, artBase.holder, itemState.holder) ? 1u : 0u);
			TryAddPhysics(art.holderFlipped, artBase.holderFlipped, itemState.holderFlipped);
		}
		if (m_usesBar && (0u | (TryAddPhysics(art.bar, artBase.bar, itemState.bar) ? 1u : 0u) | (TryAddPhysics(art.barFlipped, artBase.barFlipped, itemState.barFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(1, m_yWidth, m_sizeHanger, (float)(m_sizeHanger - 1) * -0.17f - 0.07f, itemState.bar);
		}
		if (m_usesRack && (0u | (TryAddPhysics(art.rack, artBase.rack, itemState.rack) ? 1u : 0u) | (TryAddPhysics(art.rackFlipped, artBase.rackFlipped, itemState.rackFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(1, 3, m_sizeHanger, -0.24f, itemState.rack);
		}
		if (m_usesHanger && (0u | (TryAddPhysics(art.hanger, artBase.hanger, itemState.hanger) ? 1u : 0u) | (TryAddPhysics(art.hangerFlipped, artBase.hangerFlipped, itemState.hangerFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(1, 3, m_sizeHanger, (float)m_sizeHanger * -0.17f - 0.07f, itemState.hanger);
		}
		if (m_usesStanding && (0u | (TryAddPhysics(art.standing, artBase.standing, itemState.standing) ? 1u : 0u) | (TryAddPhysics(art.standingFlipped, artBase.standingFlipped, itemState.standingFlipped) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxy(m_xStanding, m_yStanding, m_sizeStanding, 0f, itemState.standing);
		}
		if (m_usesWall && (0u | (TryAddPhysics(art.wall, artBase.wall, itemState.wallLeft) ? 1u : 0u) | (TryAddPhysics(art.wallFlipped, artBase.wallFlipped, itemState.wallRight) ? 1u : 0u)) == 0)
		{
			AddPhysicsProxyFlat(m_xWall, m_yWall, itemState.wallLeft);
		}
		if (m_usesCombine && !TryAddPhysics(art.combined, artBase.combined, itemState.combined))
		{
			AddPhysicsProxy(1, 1, 1, 0.5f, itemState.combined);
		}
	}

	private bool TryAddPhysics(Sprite _sprite, Sprite _fallback, itemState _state)
	{
		if ((_sprite == null || _sprite.GetPhysicsShapeCount() == 0) && (_fallback == null || _fallback.GetPhysicsShapeCount() == 0))
		{
			return false;
		}
		List<Vector2> list = new List<Vector2>();
		if (_sprite == null || _sprite.GetPhysicsShapeCount() == 0)
		{
			_fallback.GetPhysicsShape(0, list);
		}
		else
		{
			_sprite.GetPhysicsShape(0, list);
		}
		if (m_physicShapes.ContainsKey(_state))
		{
			m_physicShapes[_state] = list.ToArray();
		}
		else
		{
			m_physicShapes.Add(_state, list.ToArray());
		}
		return true;
	}

	private void AddPhysicsProxy(int _x, int _y, int _size, float _verticalOffset, itemState _state)
	{
		Vector2 vector = new Vector3(0.14f, 0.07f);
		Vector2 vector2 = new Vector3(-0.14f, 0.07f);
		Vector2[] array = new Vector2[6];
		array[0] = new Vector2(0f, -0.07f + _verticalOffset);
		array[1] = array[0] + vector2 * _y;
		array[2] = array[1] + Vector2.up * 0.17f * _size;
		array[3] = array[2] + vector * _x;
		array[4] = array[3] - vector2 * _y;
		array[5] = array[4] - Vector2.up * 0.17f * _size;
		if (m_physicShapes.ContainsKey(_state))
		{
			m_physicShapes[_state] = array;
		}
		else
		{
			m_physicShapes.Add(_state, array);
		}
	}

	private void AddPhysicsProxyFlat(int _x, int _y, itemState _state)
	{
		Vector2 vector = new Vector3(-0.14f, 0.07f);
		Vector2[] array = new Vector2[4];
		array[0] = new Vector2(0.07f, -0.11f);
		array[1] = array[0] + vector * _x;
		array[2] = array[1] + Vector2.up * 0.17f * _y;
		array[3] = array[2] - vector * _x;
		if (m_physicShapes.ContainsKey(_state))
		{
			m_physicShapes[_state] = array;
		}
		else
		{
			m_physicShapes.Add(_state, array);
		}
	}

	public int XValidate(nodeStyle _style)
	{
		switch (_style)
		{
		case nodeStyle.hooked:
		case nodeStyle.hookedFlipped:
		case nodeStyle.holder:
		case nodeStyle.holderFlipped:
		case nodeStyle.rack:
		case nodeStyle.rackFlipped:
		case nodeStyle.hanger:
		case nodeStyle.hangerFlipped:
			return 1;
		case nodeStyle.bar:
			return 1;
		case nodeStyle.barFlipped:
			return m_barWidth;
		case nodeStyle.wallRight:
		case nodeStyle.wallLeft:
			return m_xWall;
		case nodeStyle.standing:
			return m_xStanding;
		case nodeStyle.standingFlipped:
			return m_yStanding;
		default:
			if (m_stackParent != null)
			{
				return m_stackParent.XValidate(_style);
			}
			return xWidth;
		}
	}

	public int YValidate(nodeStyle _style)
	{
		switch (_style)
		{
		case nodeStyle.hooked:
		case nodeStyle.hookedFlipped:
		case nodeStyle.holder:
		case nodeStyle.holderFlipped:
		case nodeStyle.rack:
		case nodeStyle.rackFlipped:
		case nodeStyle.hanger:
		case nodeStyle.hangerFlipped:
			return 1;
		case nodeStyle.bar:
			return m_barWidth;
		case nodeStyle.barFlipped:
			return 1;
		case nodeStyle.wallRight:
		case nodeStyle.wallLeft:
			return m_yWall;
		case nodeStyle.standing:
			return m_yStanding;
		case nodeStyle.standingFlipped:
			return m_xStanding;
		default:
			if (m_stackParent != null)
			{
				return m_stackParent.YValidate(_style);
			}
			return yWidth;
		}
	}

	public bool flipped()
	{
		if (m_lastFlatState != itemState.flipped)
		{
			return m_lastFlatState == itemState.reverseFlipped;
		}
		return true;
	}

	public bool turnedState()
	{
		return m_lastFlatState != m_state;
	}

	private void EvaluateEnabled()
	{
		GetComponent<Collider2D>().enabled = m_environmentEnabled && (!m_unmovable || m_offsetEnabled || (!m_usesCombine && m_combineType != combineType.none)) && m_packModeCollision && m_visibleEnabled;
	}

	public Color GetSpriteColor()
	{
		SpriteRenderer[] renderers = m_renderers;
		int num = 0;
		if (num < renderers.Length)
		{
			return renderers[num].color;
		}
		return Color.white;
	}

	public static void InitMaterials(Material[] _materials)
	{
		s_materials = _materials;
	}

	public void RemoveItems(zoneScript _zone)
	{
		_zone.RemoveItem(this);
		itemScript itemScript2 = m_stackChild;
		while (itemScript2 != null)
		{
			_zone.RemoveItem(itemScript2);
			itemScript2 = itemScript2.m_stackChild;
		}
		if (m_hangerChild != null)
		{
			_zone.RemoveItem(m_hangerChild);
		}
		for (int i = 0; i < m_combineChild.Count; i++)
		{
			_zone.RemoveItem(m_combineChild[i]);
		}
	}

	public void AddItems(zoneScript _zone)
	{
		_zone.AddItem(this);
		itemScript itemScript2 = m_stackChild;
		while (itemScript2 != null)
		{
			_zone.AddItem(itemScript2);
			itemScript2 = itemScript2.m_stackChild;
		}
		if (m_hangerChild != null)
		{
			_zone.AddItem(m_hangerChild);
		}
		for (int i = 0; i < m_combineChild.Count; i++)
		{
			_zone.AddItem(m_combineChild[i]);
		}
	}

	public bool MultiItem()
	{
		if (m_stackChild != null || m_hangerChild != null || m_combineChild.Count > 0)
		{
			return true;
		}
		return false;
	}

	public List<itemScript> GetMultiItems()
	{
		List<itemScript> list = new List<itemScript>();
		list.Add(this);
		itemScript itemScript2 = m_stackChild;
		while (itemScript2 != null)
		{
			list.Add(itemScript2);
			itemScript2 = itemScript2.m_stackChild;
		}
		if (m_hangerChild != null)
		{
			list.Add(m_hangerChild);
		}
		for (int i = 0; i < m_combineChild.Count; i++)
		{
			list.Add(m_combineChild[i]);
		}
		return list;
	}

	public void Activate(bool _active)
	{
		m_environmentEnabled = _active;
		EvaluateEnabled();
		m_canStackOn = m_environmentEnabled && m_stackID != stackId.none;
	}

	public void ActivateStack(bool _active)
	{
		m_environmentEnabled = _active;
		EvaluateEnabled();
		if (m_stackChild != null)
		{
			m_canStackOn = false;
			m_stackChild.ActivateStack(_active);
		}
		else
		{
			m_canStackOn = m_environmentEnabled && m_stackID != stackId.none;
		}
	}

	private void PropagateMaskInteraction(SpriteMaskInteraction _maskInteraction)
	{
		PropagateMaskInteraction(_maskInteraction, _shadow: true);
	}

	private void PropagateMaskInteraction(SpriteMaskInteraction _maskInteraction, bool _shadow)
	{
		SetMaskInteraction(_maskInteraction, _shadow);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateMaskInteraction(_maskInteraction, _shadow);
		}
		if (m_combineChild.Count > 0)
		{
			for (int i = 0; i < m_combineChild.Count; i++)
			{
				m_combineChild[i].PropagateMaskInteraction(_maskInteraction, _shadow);
			}
		}
	}

	private void SetMaskInteraction(SpriteMaskInteraction _maskInteraction, bool _shadow)
	{
		SpriteRenderer[] renderers = m_renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].maskInteraction = _maskInteraction;
		}
		renderers = m_renderersBack;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].maskInteraction = _maskInteraction;
		}
		if (_shadow && m_rendererShadow != null)
		{
			m_rendererShadow.maskInteraction = _maskInteraction;
		}
		if (m_gridPivot != null)
		{
			foreach (Transform item in m_gridPivot)
			{
				SpriteRenderer component = item.GetComponent<SpriteRenderer>();
				if (component != null)
				{
					component.maskInteraction = _maskInteraction;
				}
			}
		}
		if (!(m_gridShadowPivot != null))
		{
			return;
		}
		foreach (Transform item2 in m_gridShadowPivot)
		{
			SpriteRenderer component2 = item2.GetComponent<SpriteRenderer>();
			if (component2 != null)
			{
				component2.maskInteraction = _maskInteraction;
			}
		}
	}

	public int Node()
	{
		if (m_stackParent != null)
		{
			return m_stackParent.Node();
		}
		if (m_hangerParent != null)
		{
			return m_hangerParent.Node();
		}
		return m_node;
	}

	public itemScript StackParent()
	{
		return m_stackParent;
	}

	public itemScript TopStack()
	{
		if (!(m_stackChild != null))
		{
			return this;
		}
		return m_stackChild.TopStack();
	}

	public Transform Parent()
	{
		if (m_stackParent != null)
		{
			return m_stackParent.Parent();
		}
		return base.transform.parent;
	}

	public bool Stacked()
	{
		return m_stackParent != null;
	}

	public string Surface(zoneScript _zone)
	{
		if (m_stackParent != null)
		{
			if (!string.IsNullOrEmpty(m_stackParent.m_audioStackSurfaceOverride))
			{
				return m_stackParent.m_audioStackSurfaceOverride;
			}
			return "stacked";
		}
		if (isOnWall || isOnHook || isOnHolder || isOnBar)
		{
			return "hang";
		}
		return _zone.GetSurfaceName(Node());
	}

	public bool Pinboard()
	{
		if (isOnWall)
		{
			return m_pinState == pinState.pinboard;
		}
		return false;
	}

	public bool Shelved()
	{
		return m_shelf != null;
	}

	public itemScript GetCompareItem()
	{
		if (m_hangerChild != null)
		{
			return m_hangerChild;
		}
		return this;
	}

	public bool CanStackTurn(itemScript _item)
	{
		if (!m_stackAllowLarger && (xWidth > _item.yWidth || yWidth > _item.xWidth))
		{
			return false;
		}
		return true;
	}

	public bool StackCheck(itemScript _item, bool _checkActive = true)
	{
		if ((_checkActive && !m_canStackOn) || isNonFlatState)
		{
			return false;
		}
		if (m_stackID == stackId.none || (_item.m_stackAllowed & m_stackID) != m_stackID)
		{
			return false;
		}
		if (m_stackStateMatch && GetState() != _item.GetPlaceableState())
		{
			return false;
		}
		if (!m_stackAllowLarger && (_item.xWidth > xWidth || _item.yWidth > yWidth))
		{
			return false;
		}
		if (m_stackCount > 0 && _item.m_stackOneOnly)
		{
			return false;
		}
		if (_item.m_stackChild != null && _item.m_stackChild.m_stackOneOnly)
		{
			return false;
		}
		return true;
	}

	public bool StackCheckIncludeTurned(itemScript _item, bool _checkActive = true)
	{
		if ((_checkActive && !m_canStackOn) || isNonFlatState)
		{
			return false;
		}
		if (m_stackID == stackId.none || (_item.m_stackAllowed & m_stackID) != m_stackID)
		{
			return false;
		}
		if (!m_stackAllowLarger && (_item.xWidth > xWidth || _item.yWidth > yWidth) && (!canTurn || _item.yWidth > xWidth || _item.xWidth > yWidth))
		{
			return false;
		}
		if (m_stackCount > 0 && _item.m_stackOneOnly)
		{
			return false;
		}
		if (_item.m_stackChild != null && _item.m_stackChild.m_stackOneOnly)
		{
			return false;
		}
		return true;
	}

	public bool CombineCheck(itemScript _item)
	{
		if (m_combineType == combineType.none || m_usesCombine || _item.m_combineType != m_combineType)
		{
			return false;
		}
		if (_item.stackChild != null)
		{
			return false;
		}
		for (int i = 0; i < m_combineChild.Count; i++)
		{
			if (m_combineChild[i].combineDepth == _item.combineDepth)
			{
				return false;
			}
		}
		return true;
	}

	public void GetRaiseArt(out Sprite _main, out Sprite _back, out bool _flipped, out bool _flippedBack, out Vector2 _offset)
	{
		_main = ((m_renderer != null) ? m_renderer.sprite : null);
		_back = ((m_renderersBack.Length != 0 && m_renderersBack[0].enabled) ? m_renderersBack[0].sprite : null);
		_flipped = m_renderer != null && m_renderer.flipX;
		_flippedBack = m_renderersBack.Length != 0 && m_renderersBack[0].enabled && m_renderersBack[0].flipX;
		_offset = Vector2.zero;
		if (!isOnRack && !isOnHolder)
		{
			if (isOnHook)
			{
				_offset.y -= 0.25f;
			}
			else if (isOnShelf)
			{
				_offset.x -= ((m_state == itemState.standing) ? (-0.06f) : 0.06f);
				_offset.y -= 0.15f;
			}
			else if (isOnHanger)
			{
				_offset.y += (float)hangerSize * 0.17f;
			}
			else if (isOnBar)
			{
				_offset.y += (float)(hangerSize - 1) * 0.17f;
			}
			else if (m_state == itemState.wallLeft)
			{
				int num = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
				int num2 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
				_offset -= new Vector2(-0.14f, 0.07f) * num + new Vector2(0f, 0.17f) * num2;
			}
			else if (m_state == itemState.wallRight)
			{
				int num3 = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
				int num4 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
				_offset -= new Vector2(0.14f, 0.07f) * num3 + new Vector2(0f, 0.17f) * num4;
			}
			else
			{
				_offset.x -= (float)(xValidate - yValidate) * 0.07f;
				_offset.y -= (float)Mathf.Max(xValidate, yValidate) * 0.085f;
			}
		}
		if (m_boxOffset != 0f)
		{
			_offset.y = m_boxOffset;
		}
	}

	public Vector2 GetStackDimentions()
	{
		if (m_stackParent != null)
		{
			return m_stackParent.GetStackDimentions();
		}
		return new Vector2(xWidth, yWidth);
	}

	public void GetStackDimentions(out int _xWidth, out int _yWidth)
	{
		if (m_stackParent != null)
		{
			m_stackParent.GetStackDimentions(out _xWidth, out _yWidth);
			return;
		}
		_xWidth = xWidth;
		_yWidth = yWidth;
	}

	protected float StackAddition()
	{
		float num = m_size;
		if (m_stackID == stackId.plateSmall || m_stackID == stackId.plateLarge || m_stackID == stackId.teaTowel)
		{
			return 0.3333f;
		}
		if (m_stackID == stackId.bowl || m_stackID == stackId.tray)
		{
			return 0.5f;
		}
		return (float)stackPixelSize / 17f;
	}

	private void SumTotalSize(itemScript _stack)
	{
		m_totalSize = ((m_stackID == stackId.none) ? ((float)m_size) : StackAddition());
		itemScript itemScript2 = _stack;
		while (itemScript2 != null)
		{
			m_totalSize += itemScript2.StackAddition();
			itemScript2 = itemScript2.m_stackParent;
		}
		if (m_stackChild != null)
		{
			m_stackChild.PropagateTotalSize(m_totalSize);
		}
	}

	protected void PropagateTotalSize(float _size)
	{
		m_totalSize = _size + StackAddition();
		if (m_stackChild != null)
		{
			m_stackChild.PropagateTotalSize(m_totalSize);
		}
	}

	protected int GetStackSize(itemScript _newItem)
	{
		if (m_hangerChild != null)
		{
			return m_hangerChild.m_sizeHanger;
		}
		if (m_stackParent != null)
		{
			return m_stackParent.GetStackSize(_newItem);
		}
		if (m_combineType != combineType.none && (m_combineChild.Count > 0 || (_newItem != null && _newItem.isCombinable)))
		{
			int num = m_size;
			for (int i = 0; i < m_combineChild.Count; i++)
			{
				num = Mathf.Max(num, m_combineChild[i].m_sizeCombine);
			}
			if (_newItem != null)
			{
				num = Mathf.Max(num, _newItem.m_sizeCombine);
			}
			return num;
		}
		if (m_stackID == stackId.none || (m_stackChild == null && _newItem == null))
		{
			return m_size;
		}
		float num2 = ((m_stackID == stackId.bowl) ? ((float)m_size) : StackAddition());
		bool flag = _newItem != null;
		itemScript itemScript2 = stackChild;
		if (itemScript2 == null && flag)
		{
			itemScript2 = _newItem;
			flag = false;
		}
		while (itemScript2 != null)
		{
			num2 += itemScript2.StackAddition();
			itemScript2 = itemScript2.stackChild;
			if (itemScript2 == null && flag)
			{
				itemScript2 = _newItem;
				flag = false;
			}
		}
		return Mathf.CeilToInt(num2);
	}

	public bool StackValid(int _size, itemScript _stackItem)
	{
		if (m_stackChild != null || isNonFlatState)
		{
			return false;
		}
		if (m_stackID == stackId.plateSmall || m_stackID == stackId.plateLarge || m_stackID == stackId.teaTowel)
		{
			if (stackCount + _stackItem.fullStackCount >= 12)
			{
				return false;
			}
		}
		else if ((m_stackID == stackId.bowl || m_stackID == stackId.tray || m_stackID == stackId.teaTowel || m_stackID == stackId.clothing) && stackCount + _stackItem.fullStackCount >= 8)
		{
			return false;
		}
		int b = 4;
		switch (m_stackID)
		{
		case stackId.toiletPaper:
		case stackId.towel:
			b = 6;
			break;
		case stackId.babyBlocks:
			b = 5;
			break;
		case stackId.clothing:
			b = 3;
			break;
		}
		return GetStackSize(_stackItem) <= Mathf.Min(_size, b);
	}

	public void Hook(hookScript _hook)
	{
		m_hook = _hook;
		m_hook.Collision(_value: false);
	}

	public void Shelf(shelfStandScript _shelf)
	{
		m_shelf = _shelf;
		m_stackCount = m_shelf.GetIndex(this);
	}

	public void ShelfShuffle(int _index)
	{
		m_stackCount = _index;
	}

	public void ShelfOffset(Vector2 _offset, bool _enableUnmovable)
	{
		if (m_unmovable)
		{
			m_offsetEnabled = _enableUnmovable;
			EvaluateEnabled();
		}
		if ((bool)m_polyCollision)
		{
			m_polyCollision.offset = _offset * -1f;
			return;
		}
		CapsuleCollider2D component = GetComponent<CapsuleCollider2D>();
		if (component != null)
		{
			component.offset = m_defaultCollision.offset + _offset * -1f;
		}
	}

	public void Unshelf()
	{
		m_shelf.RemoveItem(this);
		m_shelf = null;
		m_stackCount = 0;
		if ((bool)m_polyCollision)
		{
			m_polyCollision.offset = Vector3.zero;
			return;
		}
		CapsuleCollider2D component = GetComponent<CapsuleCollider2D>();
		if (component != null)
		{
			component.offset = m_defaultCollision.offset;
		}
	}

	public shelfStandScript GetShelf()
	{
		return m_shelf;
	}

	public void Unhook()
	{
		m_hook.Collision(_value: true);
		m_hook = null;
	}

	public nodeStyle HangerStyle()
	{
		if (m_state == itemState.rack)
		{
			return nodeStyle.hanger;
		}
		if (m_state == itemState.rackFlipped)
		{
			return nodeStyle.hangerFlipped;
		}
		return nodeStyle.flat;
	}

	public bool HangerCheck()
	{
		if (!isRackable || m_hangerChild != null)
		{
			return false;
		}
		return true;
	}

	public Vector3 HangerPosition(itemScript _item)
	{
		Vector3 result = m_artPivot.position - Vector3.forward * 0.01f;
		if (!isOnRack)
		{
			float num = _item.xWidth - xWidth;
			float num2 = _item.yWidth - yWidth;
			result -= new Vector3(0.14f, 0.07f) * num * 0.5f + new Vector3(-0.14f, 0.07f) * num2 * 0.5f;
		}
		return result;
	}

	public void Hanger(itemScript _hangerParent)
	{
		if (m_stackParent != null)
		{
			m_stackCount = 0;
			m_stackParent.StackOn(null);
			m_stackParent = null;
		}
		base.transform.localScale = Vector3.one;
		m_hangerParent = _hangerParent;
		m_hangerParent.HangerOn(this);
	}

	public void HangerOn(itemScript _hangerChild)
	{
		m_hangerChild = _hangerChild;
	}

	public int Unhanger()
	{
		if ((bool)m_hangerParent)
		{
			m_hangerParent.HangerOn(null);
		}
		int result = m_hangerParent.size;
		m_hangerParent = null;
		return result;
	}

	public int Combine(itemScript _combineParent)
	{
		m_stackParent = _combineParent;
		m_combined = true;
		base.transform.localScale = Vector3.one;
		m_stackParent.CombineWith(this);
		m_stackCount = m_stackParent.stackCount + 1;
		return size;
	}

	public int Uncombine()
	{
		m_stackParent.UncombineWith(this);
		m_combined = false;
		int result = m_stackParent.size;
		m_stackParent = null;
		m_stackCount = 0;
		return result;
	}

	public void CombineWith(itemScript _combineChild)
	{
		m_combineChild.Add(_combineChild);
		SetMaskLevel(m_maskId);
	}

	public void UncombineWith(itemScript _combineChild)
	{
		m_combineChild.Remove(_combineChild);
		SetMaskLevel(m_maskId);
	}

	public void PropagateStackCountUp()
	{
		m_stackCount = m_stackParent.stackCount + 1;
		if (m_stackChild != null)
		{
			m_stackChild.PropagateStackCountUp();
		}
	}

	public int Stack(itemScript _stackParent)
	{
		m_stackParent = _stackParent;
		PropagateStackCountUp();
		if (art.stacked != null)
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sprite = art.stacked;
			}
			SetPolyCollision((m_state == itemState.normal || m_state == itemState.reverse) ? itemState.stacked : itemState.stackedFlipped);
		}
		if (m_stackID == stackId.bowl || m_stackID == stackId.plateLarge || m_stackID == stackId.plateSmall)
		{
			CapsuleCollider2D component = GetComponent<CapsuleCollider2D>();
			if (component != null)
			{
				Vector2 vector = component.size;
				vector.y -= 0.1f;
				component.size = vector;
				vector = component.offset;
				vector.y += 0.05f;
				component.offset = vector;
			}
		}
		base.transform.localScale = Vector3.one;
		m_stackParent.StackOn(this);
		Transform[] attachments = m_attachments;
		for (int i = 0; i < attachments.Length; i++)
		{
			attachments[i].GetComponent<attachmentBaseScript>().Stack(fullStackCount);
		}
		return size;
	}

	public void StackOn(itemScript _stackChild)
	{
		m_stackChild = _stackChild;
		m_canStackOn = _stackChild == null && m_stackID != stackId.none;
		if (art.stackedOn != null)
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sprite = ((_stackChild != null) ? art.stackedOn : art.main);
			}
		}
		PropagateMaskDown(m_maskId, m_maskFrontSortingOrder);
		if (m_stackID == stackId.foamHead)
		{
			statsScript.AwardSticker(statsScript.stickers.sticker_fashion);
		}
	}

	public int Unstack()
	{
		m_stackCount = 0;
		if (art.stacked != null)
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sprite = art.main;
			}
			SetPolyCollision();
		}
		Vector3 localPosition = m_artPivot.localPosition;
		if (m_stackID == stackId.bowl)
		{
			localPosition.y = 0.09f;
		}
		else if (m_stackID == stackId.plantPot)
		{
			localPosition.y = 0.21f;
		}
		else
		{
			localPosition.y = 0.04f;
		}
		m_artPivot.localPosition = localPosition;
		if (m_stackID == stackId.bowl || m_stackID == stackId.plateLarge || m_stackID == stackId.plateSmall)
		{
			CapsuleCollider2D component = GetComponent<CapsuleCollider2D>();
			if (component != null)
			{
				component.size = m_defaultCollision.size;
				Vector3 vector = component.offset;
				vector.y = m_defaultCollision.offset.y;
				component.offset = vector;
			}
		}
		int num = size;
		m_stackParent.StackOn(null);
		int num2 = m_stackParent.size;
		int num3 = m_maskFrontSortingOrder;
		if (num3 > 0)
		{
			num3 -= num - num2;
		}
		m_stackParent.PropagateMaskDown(m_maskId, num3);
		m_stackParent = null;
		if (m_stackChild != null)
		{
			m_stackChild.PropagateStackCountUp();
		}
		return num2;
	}

	public Vector3 StackPosition(itemScript _item)
	{
		Vector3 vector = Vector3.forward * -0.002f;
		if (m_stackID == stackId.plateSmall)
		{
			vector.y = 0.04f;
		}
		else if (m_stackID == stackId.plateLarge)
		{
			vector.y = 0.04f;
		}
		else if (m_stackID == stackId.tray)
		{
			vector.y = 0.05f;
		}
		else if (m_stackID == stackId.teaTowel)
		{
			vector.y = 0.06f;
		}
		else if (m_stackAllowLarger)
		{
			float num = xWidth - _item.xWidth;
			float num2 = yWidth - _item.yWidth;
			if (_item.GetState() == 3 || _item.GetState() == 4)
			{
				num = 0f;
				num2 = 0f;
			}
			vector.x = (num - num2) * 0.14f;
			vector.y = (float)stackPixelSize * 0.01f + (num + num2) * 0.07f;
		}
		else if (_item.isRackable)
		{
			float num3 = (float)xWidth / 2f;
			float num4 = (float)yWidth / 2f;
			vector.x = (num3 - num4) * 0.14f;
			vector.y = (float)stackPixelSize * 0.01f + Mathf.Ceil((num3 + num4) * 0.07f * 100f) * 0.01f + 0.18f;
		}
		else
		{
			float num5 = (float)(xWidth - _item.xWidth) / 2f;
			float num6 = (float)(yWidth - _item.yWidth) / 2f;
			vector.x = (num5 - num6) * 0.14f;
			vector.y = (float)stackPixelSize * 0.01f + (num5 + num6) * 0.07f;
		}
		return base.transform.position + vector;
	}

	public void SetArt(Sprite _sprite)
	{
		if (!(_sprite == null))
		{
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sprite = _sprite;
			}
		}
	}

	public void SetArt(Sprite _spriteLeft, Sprite _spriteRight)
	{
		SpriteRenderer[] renderers = m_renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].sprite = ((m_state == itemState.wallLeft) ? _spriteLeft : _spriteRight);
		}
	}

	public void SetArt()
	{
		Sprite sprite = art.main;
		if (m_state == itemState.flipped && art.flipped != null)
		{
			sprite = art.flipped;
		}
		else if (m_state == itemState.wallLeft || (m_state == itemState.wallRight && art.wallFlipped == null))
		{
			sprite = art.wall;
		}
		else if (m_state == itemState.wallRight)
		{
			sprite = art.wallFlipped;
		}
		SpriteRenderer[] renderers = m_renderers;
		foreach (SpriteRenderer spriteRenderer in renderers)
		{
			if (spriteRenderer != null)
			{
				spriteRenderer.sprite = sprite;
			}
		}
	}

	public void RingConfigure(out Vector3 _position, out float _size)
	{
		Collider2D component = GetComponent<Collider2D>();
		bool num = component.enabled;
		if (!num)
		{
			component.enabled = true;
		}
		Bounds bounds = component.bounds;
		_position = bounds.center;
		_size = Mathf.Max(bounds.extents.x, bounds.extents.y);
		if (!num)
		{
			component.enabled = false;
		}
	}

	private Vector3 CombineLocalPosition(int _combineDepth)
	{
		Vector3 vector = Vector3.zero;
		if (m_state == itemState.normal)
		{
			if (art.combineMaskOffsets.Length != 0)
			{
				vector = art.combineMaskOffsets[0];
			}
		}
		else if (m_state == itemState.flipped)
		{
			if (art.combineMaskOffsets.Length > 1)
			{
				vector = art.combineMaskOffsets[1];
			}
		}
		else if (m_state == itemState.reverse)
		{
			if (art.combineMaskOffsets.Length > 2)
			{
				vector = art.combineMaskOffsets[2];
			}
		}
		else if (m_state == itemState.reverseFlipped && art.combineMaskOffsets.Length > 3)
		{
			vector = art.combineMaskOffsets[3];
		}
		return vector - Vector3.forward * 0.01f * _combineDepth;
	}

	public Vector3 CombinePosition(int _combineDepth)
	{
		return base.transform.position + CombineLocalPosition(_combineDepth);
	}

	public nodeStyle CombineStyle()
	{
		if (m_state != itemState.flipped && m_state != itemState.reverseFlipped)
		{
			return nodeStyle.combined;
		}
		return nodeStyle.combinedFlipped;
	}

	private void PropagateDisplay(displayType _display)
	{
		SetDisplay(_display);
		if (!(m_stackChild != null) && !(m_hangerChild != null) && m_combineChild.Count <= 0)
		{
			return;
		}
		zoneScript zoneScript2 = null;
		if (_display == displayType.invalid || _display == displayType.none)
		{
			zoneScript2 = base.transform.GetComponentInParent<zoneScript>();
		}
		if (m_stackChild != null)
		{
			if (!m_stackChild.m_stackInheritValid && zoneScript2 != null)
			{
				m_stackChild.PropagateDisplay((!zoneScript2.IsItemValid(m_stackChild, this, Node(), zoneScript2.GetStyle(Node()))) ? displayType.invalid : displayType.none);
			}
			else
			{
				m_stackChild.PropagateDisplay(_display);
			}
		}
		if (m_hangerChild != null)
		{
			if (!m_hangerChild.m_stackInheritValid && zoneScript2 != null)
			{
				m_hangerChild.PropagateDisplay((!zoneScript2.IsItemValid(m_hangerChild, this, Node(), zoneScript2.GetStyle(Node()))) ? displayType.invalid : displayType.none);
			}
			else
			{
				m_hangerChild.SetDisplay(_display);
			}
		}
		if (m_combineChild.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < m_combineChild.Count; i++)
		{
			if (!m_combineChild[i].m_stackInheritValid && zoneScript2 != null)
			{
				m_combineChild[i].PropagateDisplay((!zoneScript2.IsItemValid(m_combineChild[i], this, Node(), zoneScript2.GetStyle(Node()))) ? displayType.invalid : displayType.none);
			}
			else
			{
				m_combineChild[i].SetDisplay(_display);
			}
		}
	}

	private void PropagateDisplay(zoneScript.zoneType _zoneType, zoneScript.itemNode.nodeType _nodeType)
	{
		SetDisplay((!Validate(_zoneType, _nodeType)) ? displayType.invalid : displayType.none);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateDisplay(_zoneType, _nodeType);
		}
	}

	public bool CanInteract()
	{
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				if (attachments[i].GetComponent<attachmentBaseScript>().canPlacedInteract)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool Interact(bool _instant = false)
	{
		if (m_attachments != null)
		{
			bool flag = false;
			Transform[] attachments = m_attachments;
			foreach (Transform transform in attachments)
			{
				flag |= transform.GetComponent<attachmentBaseScript>().PlacedInteract(_instant);
			}
			return flag;
		}
		return false;
	}

	public int InteractFull()
	{
		if (m_attachments != null)
		{
			int num = 0;
			Transform[] attachments = m_attachments;
			foreach (Transform transform in attachments)
			{
				num = Mathf.Max(num, transform.GetComponent<attachmentBaseScript>().PlacedInteractFull());
			}
			return num;
		}
		return 0;
	}

	public void StartValid()
	{
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				attachments[i].GetComponent<attachmentBaseScript>().StartValid();
			}
		}
	}

	public void ComputerDisplay(int _function)
	{
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				attachments[i].GetComponent<attachmentBaseScript>().ComputerDisplay(_function);
			}
		}
	}

	public void ComputerDisplay(int _function, float _time)
	{
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				attachments[i].GetComponent<attachmentBaseScript>().ComputerDisplay(_function, _time);
			}
		}
	}

	public float GetComputerDisplayTime()
	{
		float num = 1f;
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			foreach (Transform transform in attachments)
			{
				num = Mathf.Min(num, transform.GetComponent<attachmentBaseScript>().GetAnimTime());
			}
		}
		return num;
	}

	public bool CanAdvanceState()
	{
		if (m_state == itemState.hooked || m_state == itemState.hookedFlipped || m_state == itemState.standing || m_state == itemState.standingFlipped || m_state == itemState.wallLeft || m_state == itemState.wallRight || m_hangerOverRack)
		{
			return false;
		}
		if (m_flipType == flipType.none && (m_attachments == null || m_attachments.Length == 0))
		{
			return false;
		}
		return true;
	}

	public bool AdvanceStateAutoRotate(int _direction)
	{
		if (isNonFlatState)
		{
			if (m_flipType == flipType.twoWay)
			{
				_ = m_rotateType;
				if (m_lastFlatState == itemState.normal)
				{
					m_lastFlatState = itemState.flipped;
				}
				else
				{
					m_lastFlatState = itemState.normal;
				}
			}
			else if (m_flipType == flipType.FourWay)
			{
				bool flag = ((m_rotateType == RotateType.rightFacing) ? (_direction == 1) : (_direction == -1));
				if (m_lastFlatState == itemState.normal)
				{
					m_lastFlatState = (flag ? itemState.flipped : itemState.reverseFlipped);
				}
				else if (m_lastFlatState == itemState.flipped)
				{
					m_lastFlatState = (flag ? itemState.reverse : itemState.normal);
				}
				else if (m_lastFlatState == itemState.reverse)
				{
					m_lastFlatState = ((!flag) ? itemState.flipped : itemState.reverseFlipped);
				}
				else
				{
					m_lastFlatState = ((!flag) ? itemState.reverse : itemState.normal);
				}
			}
		}
		else if (m_usesHolder)
		{
			if (m_currentVariant % 2 == 0)
			{
				m_currentVariant++;
			}
			else
			{
				m_currentVariant--;
			}
		}
		return AdvanceState(_direction);
	}

	public bool AdvanceState(int _direction)
	{
		if (m_state == itemState.holder || m_state == itemState.holderFlipped)
		{
			if (m_currentVariant % 2 == 0)
			{
				m_currentVariant++;
			}
			else
			{
				m_currentVariant--;
			}
			TryAddPhysics(art.holder, artBase.holder, itemState.holder);
			TryAddPhysics(art.holderFlipped, artBase.holderFlipped, itemState.holderFlipped);
			SetState(m_state);
			return true;
		}
		bool flag = false;
		if (m_state == itemState.rack || m_state == itemState.rackFlipped)
		{
			if (m_hangerOverRack)
			{
				return false;
			}
			flag = true;
			m_state = m_lastFlatState;
		}
		else if (isNonFlatState)
		{
			if (m_hangerParent == null)
			{
				return false;
			}
			m_state = m_lastFlatState;
		}
		bool flag2 = false;
		if (m_flipType == flipType.none)
		{
			bool flag3 = false;
			if (m_attachments != null)
			{
				Transform[] attachments = m_attachments;
				foreach (Transform transform in attachments)
				{
					flag3 |= transform.GetComponent<attachmentBaseScript>().HoverInteract();
				}
			}
			return flag3;
		}
		if (m_flipType == flipType.twoWay)
		{
			bool flag4 = ((m_rotateType == RotateType.rightFacing) ? (_direction == 1) : (_direction == -1));
			if (m_state == itemState.normal)
			{
				m_state = itemState.flipped;
				flag2 = !flag4;
			}
			else
			{
				m_state = itemState.normal;
				flag2 = flag4;
			}
		}
		else if (m_flipType == flipType.FourWay)
		{
			bool flag5 = ((m_rotateType == RotateType.rightFacing) ? (_direction == 1) : (_direction == -1));
			if (m_state == itemState.normal)
			{
				m_state = (flag5 ? itemState.flipped : itemState.reverseFlipped);
			}
			else if (m_state == itemState.flipped)
			{
				m_state = (flag5 ? itemState.reverse : itemState.normal);
			}
			else if (m_state == itemState.reverse)
			{
				m_state = ((!flag5) ? itemState.flipped : itemState.reverseFlipped);
			}
			else
			{
				m_state = ((!flag5) ? itemState.reverse : itemState.normal);
			}
			if (m_state == itemState.reverseFlipped && base.name.Contains("itemMannequin"))
			{
				statsScript.SpecialEvent(statsScript.specialEvents.mannequinDab);
				statsScript.AwardSticker(statsScript.stickers.sticker_dab);
			}
		}
		if (flag)
		{
			m_lastFlatState = m_state;
			m_state = (flipped() ? itemState.rackFlipped : itemState.rack);
		}
		SetState(m_state);
		if (m_stackChild != null)
		{
			if (m_stackChild.AdvanceState(_direction) && flag2 && m_stackChild.m_flipType == flipType.FourWay)
			{
				m_stackChild.AdvanceState(_direction);
				m_stackChild.AdvanceState(_direction);
			}
			m_stackChild.transform.position = StackPosition(m_stackChild) + m_artPivot.localPosition;
		}
		if (m_hangerChild != null && m_hangerChild.AdvanceState(_direction))
		{
			AlignHangerChild();
		}
		if (m_combineChild.Count > 0)
		{
			for (int j = 0; j < m_combineChild.Count; j++)
			{
				m_combineChild[j].SetState(flipped() ? itemState.combinedFlipped : itemState.combined);
				m_combineChild[j].transform.localPosition = CombineLocalPosition(m_combineChild[j].combineDepth);
			}
		}
		ShowGrid();
		return true;
	}

	public void AlignHangerChild()
	{
		Vector3 vector = Vector3.forward * -0.002f;
		float num = (float)m_hangerChild.xWidth / 2f;
		float num2 = (float)m_hangerChild.yWidth / 2f;
		vector.x = (num - num2) * 0.14f;
		vector.y = (float)m_hangerChild.stackPixelSize * 0.01f + Mathf.Ceil((num + num2) * 0.07f * 100f) * 0.01f + 0.18f + 0.04f;
		m_hangerChild.transform.localPosition = -vector;
		m_hangerChild.m_artPivot.localPosition = Vector3.up * 0.04f;
	}

	public int GetState()
	{
		return (int)m_state;
	}

	public int GetPlaceableState()
	{
		if (!isNonFlatState)
		{
			return (int)m_state;
		}
		return (int)m_lastFlatState;
	}

	private List<int> GetValidStates(bool _limited)
	{
		List<int> list = new List<int>();
		list.Add(0);
		if (m_flipType == flipType.twoWay)
		{
			list.Add(1);
		}
		else if (m_flipType == flipType.FourWay)
		{
			list.Add(1);
			list.Add(3);
			list.Add(4);
		}
		if (!_limited)
		{
			if (m_usesWall)
			{
				list.Add(8);
				list.Add(7);
			}
			if (m_usesHook)
			{
				list.Add(2);
				list.Add(9);
			}
			if (m_usesHanger)
			{
				list.Add(16);
				list.Add(17);
			}
			if (m_usesStanding)
			{
				list.Add(5);
				list.Add(6);
			}
			if (m_usesBar)
			{
				list.Add(12);
				list.Add(13);
			}
			if (m_usesRack)
			{
				list.Add(14);
				list.Add(15);
			}
			if (m_usesHolder)
			{
				list.Add(10);
				list.Add(11);
			}
			if (m_usesCombine)
			{
				list.Add(20);
				list.Add(21);
			}
		}
		return list;
	}

	public int GetRandomState()
	{
		List<int> validStates = GetValidStates(_limited: true);
		int index = UnityEngine.Random.Range(0, validStates.Count);
		return validStates[index];
	}

	public int GetNextState(int _state)
	{
		List<int> validStates = GetValidStates(_limited: false);
		int num = 0;
		for (int i = 0; i < validStates.Count; i++)
		{
			if (validStates[i] == _state)
			{
				num = i;
				break;
			}
		}
		return validStates[(num + 1) % validStates.Count];
	}

	public int FixBoxState(int _state, int _hangPref, bool _tops, bool _bottoms)
	{
		if (m_usesHanger && ((_tops && m_hangerType == hangerType.top) || (_bottoms && m_hangerType == hangerType.bottom)))
		{
			if (_hangPref != 1)
			{
				return 17;
			}
			return 16;
		}
		if (_state == 0 || _state == 1 || _state == 3 || _state == 4)
		{
			return _state;
		}
		return GetRandomState();
	}

	private Vector2[] FlipPoints(Vector2[] _points)
	{
		Vector2[] array = new Vector2[_points.Length];
		for (int i = 0; i < _points.Length; i++)
		{
			array[i] = new Vector2(_points[i].x * -1f, _points[i].y);
		}
		return array;
	}

	public Vector2[] GetPolyCollision(nodeStyle _style)
	{
		if (!m_init)
		{
			Init();
		}
		switch (_style)
		{
		case nodeStyle.standing:
			if (m_physicShapes.ContainsKey(itemState.standing))
			{
				return m_physicShapes[itemState.standing];
			}
			if (m_physicShapes.ContainsKey(itemState.standingFlipped))
			{
				return FlipPoints(m_physicShapes[itemState.standingFlipped]);
			}
			break;
		case nodeStyle.standingFlipped:
			if (m_physicShapes.ContainsKey(itemState.standingFlipped))
			{
				return m_physicShapes[itemState.standingFlipped];
			}
			if (m_physicShapes.ContainsKey(itemState.standing))
			{
				return FlipPoints(m_physicShapes[itemState.standing]);
			}
			break;
		}
		return new Vector2[0];
	}

	private void SetPolyCollision(itemState _state)
	{
		if (m_physicShapes.ContainsKey(_state))
		{
			m_polyCollision.points = m_physicShapes[_state];
		}
		else if (_state == itemState.stackedFlipped && m_physicShapes.ContainsKey(itemState.stacked))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.stacked]);
		}
	}

	private void SetPolyCollision()
	{
		if (m_physicShapes.ContainsKey(m_state))
		{
			m_polyCollision.points = m_physicShapes[m_state];
		}
		else if (m_state == itemState.reverseFlipped && m_physicShapes.ContainsKey(itemState.reverse))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.reverse]);
		}
		else if ((m_state == itemState.flipped || m_state == itemState.reverseFlipped) && m_physicShapes.ContainsKey(itemState.normal))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.normal]);
		}
		else if (m_state == itemState.standingFlipped && m_physicShapes.ContainsKey(itemState.standing))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.standing]);
		}
		else if (m_state == itemState.standing && m_physicShapes.ContainsKey(itemState.standingFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.standingFlipped]);
		}
		else if (m_state == itemState.wallLeft && m_physicShapes.ContainsKey(itemState.wallRight))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.wallRight]);
		}
		else if (m_state == itemState.wallRight && m_physicShapes.ContainsKey(itemState.wallLeft))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.wallLeft]);
		}
		else if (m_state == itemState.hookedFlipped && m_physicShapes.ContainsKey(itemState.hooked))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.hooked]);
		}
		else if (m_state == itemState.hooked && m_physicShapes.ContainsKey(itemState.hookedFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.hookedFlipped]);
		}
		else if (m_state == itemState.holderFlipped && m_physicShapes.ContainsKey(itemState.holder))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.holder]);
		}
		else if (m_state == itemState.holder && m_physicShapes.ContainsKey(itemState.holderFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.holderFlipped]);
		}
		else if (m_state == itemState.barFlipped && m_physicShapes.ContainsKey(itemState.bar))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.bar]);
		}
		else if (m_state == itemState.bar && m_physicShapes.ContainsKey(itemState.barFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.barFlipped]);
		}
		else if (m_state == itemState.rackFlipped && m_physicShapes.ContainsKey(itemState.rack))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.rack]);
		}
		else if (m_state == itemState.rack && m_physicShapes.ContainsKey(itemState.rackFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.rackFlipped]);
		}
		else if (m_state == itemState.hangerFlipped && m_physicShapes.ContainsKey(itemState.hanger))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.hanger]);
		}
		else if (m_state == itemState.hanger && m_physicShapes.ContainsKey(itemState.hangerFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.hangerFlipped]);
		}
		else if (m_state == itemState.combinedFlipped && m_physicShapes.ContainsKey(itemState.combined))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.combined]);
		}
		else if (m_state == itemState.combined && m_physicShapes.ContainsKey(itemState.combinedFlipped))
		{
			m_polyCollision.points = FlipPoints(m_physicShapes[itemState.combinedFlipped]);
		}
		else if (m_physicShapes.ContainsKey(itemState.normal))
		{
			m_polyCollision.points = m_physicShapes[itemState.normal];
		}
		else if (m_physicShapes.ContainsKey(itemState.flipped))
		{
			m_polyCollision.points = m_physicShapes[itemState.flipped];
		}
		else if (m_physicShapes.ContainsKey(itemState.reverse))
		{
			m_polyCollision.points = m_physicShapes[itemState.reverse];
		}
		else if (m_physicShapes.ContainsKey(itemState.reverseFlipped))
		{
			m_polyCollision.points = m_physicShapes[itemState.reverseFlipped];
		}
	}

	public void SetState(int _state, int _lastFlatState)
	{
		m_lastFlatState = (itemState)_lastFlatState;
		SetState((itemState)_state);
	}

	public void SetState(int _state)
	{
		SetState((itemState)_state);
	}

	private void SetState(itemState _state)
	{
		if (!m_init)
		{
			Init();
		}
		if (m_flipType == flipType.twoWay && (_state == itemState.reverse || _state == itemState.reverseFlipped))
		{
			Debug.LogWarning("item " + base.name + " wanted state " + _state.ToString() + " but is flip type " + m_flipType);
			_state = ((_state != itemState.reverse) ? itemState.flipped : itemState.normal);
		}
		else if (m_flipType == flipType.none && (_state == itemState.flipped || _state == itemState.reverse || _state == itemState.reverseFlipped))
		{
			Debug.LogWarning("item " + base.name + " wanted state " + _state.ToString() + " but is flip type " + m_flipType);
			_state = itemState.normal;
		}
		if (m_usesHanger || m_usesBar || m_usesHook)
		{
			switch (_state)
			{
			case itemState.hanger:
			case itemState.hangerFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderersBack;
				for (int i = 0; i < renderersBack.Length; i++)
				{
					renderersBack[i].gameObject.SetActive(value: true);
				}
				break;
			}
			case itemState.hooked:
			case itemState.hookedFlipped:
			case itemState.bar:
			case itemState.barFlipped:
			{
				for (int j = 0; j < m_renderersBack.Length; j++)
				{
					m_renderersBack[j].gameObject.SetActive(j == 0);
				}
				break;
			}
			default:
			{
				SpriteRenderer[] renderersBack = m_renderersBack;
				for (int i = 0; i < renderersBack.Length; i++)
				{
					renderersBack[i].gameObject.SetActive(value: false);
				}
				break;
			}
			}
		}
		bool flag = false;
		if (m_stackParent != null && art.stacked != null)
		{
			SpriteRenderer[] renderersBack = m_renderers;
			foreach (SpriteRenderer obj in renderersBack)
			{
				obj.sprite = art.stacked;
				obj.flipX = _state == itemState.flipped || _state == itemState.reverseFlipped;
			}
			flag = true;
		}
		else
		{
			switch (_state)
			{
			case itemState.normal:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer3 in renderersBack)
				{
					if (art.main != null)
					{
						spriteRenderer3.sprite = art.main;
						spriteRenderer3.flipX = false;
					}
					else
					{
						spriteRenderer3.sprite = art.flipped;
						spriteRenderer3.flipX = true;
					}
				}
				if (m_rendererShadow != null)
				{
					if (art.mainShadow != null)
					{
						m_rendererShadow.sprite = art.mainShadow;
						m_rendererShadow.flipX = false;
					}
					else
					{
						m_rendererShadow.sprite = art.flippedShadow;
						m_rendererShadow.flipX = true;
					}
				}
				Vector2 offset2 = GetComponent<Collider2D>().offset;
				offset2.x = m_flippableOffsetCol;
				GetComponent<Collider2D>().offset = offset2;
				break;
			}
			case itemState.flipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer7 in renderersBack)
				{
					if (art.flipped != null)
					{
						spriteRenderer7.sprite = art.flipped;
						spriteRenderer7.flipX = false;
					}
					else
					{
						spriteRenderer7.sprite = art.main;
						spriteRenderer7.flipX = true;
					}
				}
				if (m_rendererShadow != null)
				{
					if (art.flippedShadow != null)
					{
						m_rendererShadow.sprite = art.flippedShadow;
						m_rendererShadow.flipX = false;
					}
					else
					{
						m_rendererShadow.sprite = art.mainShadow;
						m_rendererShadow.flipX = true;
					}
				}
				Vector2 offset3 = GetComponent<Collider2D>().offset;
				offset3.x = 0f - m_flippableOffsetCol;
				GetComponent<Collider2D>().offset = offset3;
				break;
			}
			case itemState.reverse:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj3 in renderersBack)
				{
					obj3.sprite = art.reverse;
					obj3.flipX = false;
				}
				if (m_rendererShadow != null)
				{
					if (art.reverseShadow != null)
					{
						m_rendererShadow.sprite = art.reverseShadow;
					}
					else
					{
						m_rendererShadow.sprite = art.mainShadow;
					}
					m_rendererShadow.flipX = false;
				}
				Vector2 offset = GetComponent<Collider2D>().offset;
				offset.x = m_flippableOffsetCol;
				GetComponent<Collider2D>().offset = offset;
				break;
			}
			case itemState.reverseFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer13 in renderersBack)
				{
					if (art.reverseFlipped != null)
					{
						spriteRenderer13.sprite = art.reverseFlipped;
						spriteRenderer13.flipX = false;
					}
					else
					{
						spriteRenderer13.sprite = art.reverse;
						spriteRenderer13.flipX = true;
					}
				}
				if (m_rendererShadow != null)
				{
					if (art.reverseFlippedShadow != null)
					{
						m_rendererShadow.sprite = art.reverseFlippedShadow;
						m_rendererShadow.flipX = false;
					}
					else
					{
						if (art.reverseShadow != null)
						{
							m_rendererShadow.sprite = art.reverseShadow;
						}
						else
						{
							m_rendererShadow.sprite = art.mainShadow;
						}
						m_rendererShadow.flipX = true;
					}
				}
				Vector2 offset4 = GetComponent<Collider2D>().offset;
				offset4.x = 0f - m_flippableOffsetCol;
				GetComponent<Collider2D>().offset = offset4;
				break;
			}
			case itemState.hooked:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer10 in renderersBack)
				{
					if (art.hook != null)
					{
						spriteRenderer10.sprite = art.hook;
						spriteRenderer10.flipX = false;
					}
					else
					{
						spriteRenderer10.sprite = art.hookFlipped;
						spriteRenderer10.flipX = true;
					}
				}
				if (art.hookBack != null)
				{
					m_renderersBack[0].sprite = art.hookBack;
					m_renderersBack[0].flipX = false;
				}
				else
				{
					m_renderersBack[0].sprite = art.hookFlippedBack;
					m_renderersBack[0].flipX = true;
				}
				break;
			}
			case itemState.hookedFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer6 in renderersBack)
				{
					if (art.hookFlipped != null)
					{
						spriteRenderer6.sprite = art.hookFlipped;
						spriteRenderer6.flipX = false;
					}
					else
					{
						spriteRenderer6.sprite = art.hook;
						spriteRenderer6.flipX = true;
					}
				}
				if (art.hookFlippedBack != null)
				{
					m_renderersBack[0].sprite = art.hookFlippedBack;
					m_renderersBack[0].flipX = false;
				}
				else
				{
					m_renderersBack[0].sprite = art.hookBack;
					m_renderersBack[0].flipX = true;
				}
				break;
			}
			case itemState.holder:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer2 in renderersBack)
				{
					if (art.holder != null)
					{
						spriteRenderer2.sprite = art.holder;
						spriteRenderer2.flipX = false;
					}
					else
					{
						spriteRenderer2.sprite = art.holderFlipped;
						spriteRenderer2.flipX = true;
					}
				}
				break;
			}
			case itemState.holderFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer in renderersBack)
				{
					if (art.holderFlipped != null)
					{
						spriteRenderer.sprite = art.holderFlipped;
						spriteRenderer.flipX = false;
					}
					else
					{
						spriteRenderer.sprite = art.holder;
						spriteRenderer.flipX = true;
					}
				}
				break;
			}
			case itemState.bar:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer9 in renderersBack)
				{
					if (art.bar != null)
					{
						spriteRenderer9.sprite = art.bar;
						spriteRenderer9.flipX = false;
					}
					else
					{
						spriteRenderer9.sprite = art.barFlipped;
						spriteRenderer9.flipX = true;
					}
				}
				if (art.barBack != null)
				{
					m_renderersBack[0].sprite = art.barBack;
					m_renderersBack[0].flipX = false;
				}
				else
				{
					m_renderersBack[0].sprite = art.barFlippedBack;
					m_renderersBack[0].flipX = true;
				}
				break;
			}
			case itemState.barFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer8 in renderersBack)
				{
					if (art.barFlipped != null)
					{
						spriteRenderer8.sprite = art.barFlipped;
						spriteRenderer8.flipX = false;
					}
					else
					{
						spriteRenderer8.sprite = art.bar;
						spriteRenderer8.flipX = true;
					}
				}
				if (art.barFlippedBack != null)
				{
					m_renderersBack[0].sprite = art.barFlippedBack;
					m_renderersBack[0].flipX = false;
				}
				else
				{
					m_renderersBack[0].sprite = art.barBack;
					m_renderersBack[0].flipX = true;
				}
				break;
			}
			case itemState.rack:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer5 in renderersBack)
				{
					if (art.rack != null)
					{
						spriteRenderer5.sprite = art.rack;
						spriteRenderer5.flipX = false;
					}
					else
					{
						spriteRenderer5.sprite = art.rackFlipped;
						spriteRenderer5.flipX = true;
					}
				}
				if (m_hangerChild != null)
				{
					int state = m_hangerChild.GetState();
					bool flag2 = state == 16 || state == 17;
					if (m_hangerOverRack && !flag2)
					{
						m_hangerChild.transform.localPosition = Vector3.forward * -0.02f;
						m_hangerChild.m_artPivot.localPosition = ((m_hangerType == hangerType.bottom) ? (Vector3.forward * 0.025f) : Vector3.zero);
						m_hangerChild.SetState(itemState.hanger);
						m_hangerChild.ShowGrid();
					}
					else if (!m_hangerOverRack && flag2)
					{
						m_hangerChild.SetState(m_hangerChild.GetPlaceableState());
						AlignHangerChild();
					}
				}
				break;
			}
			case itemState.rackFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer12 in renderersBack)
				{
					if (art.rackFlipped != null)
					{
						spriteRenderer12.sprite = art.rackFlipped;
						spriteRenderer12.flipX = false;
					}
					else
					{
						spriteRenderer12.sprite = art.rack;
						spriteRenderer12.flipX = true;
					}
				}
				if (m_hangerChild != null)
				{
					int state2 = m_hangerChild.GetState();
					bool flag3 = state2 == 16 || state2 == 17;
					if (m_hangerOverRack && !flag3)
					{
						m_hangerChild.transform.localPosition = Vector3.forward * -0.02f;
						m_hangerChild.m_artPivot.localPosition = ((m_hangerType == hangerType.bottom) ? (Vector3.forward * 0.025f) : Vector3.zero);
						m_hangerChild.SetState(itemState.hangerFlipped);
						m_hangerChild.ShowGrid();
					}
					else if (!m_hangerOverRack && flag3)
					{
						m_hangerChild.SetState(m_hangerChild.GetPlaceableState());
						AlignHangerChild();
					}
				}
				break;
			}
			case itemState.hanger:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer4 in renderersBack)
				{
					if (art.hanger != null)
					{
						spriteRenderer4.sprite = art.hanger;
						spriteRenderer4.flipX = false;
					}
					else
					{
						spriteRenderer4.sprite = art.hangerFlipped;
						spriteRenderer4.flipX = true;
					}
				}
				if (art.hangerBack != null)
				{
					renderersBack = m_renderersBack;
					foreach (SpriteRenderer obj5 in renderersBack)
					{
						obj5.sprite = art.hangerBack;
						obj5.flipX = false;
					}
				}
				else
				{
					renderersBack = m_renderersBack;
					foreach (SpriteRenderer obj6 in renderersBack)
					{
						obj6.sprite = art.hangerFlippedBack;
						obj6.flipX = true;
					}
				}
				break;
			}
			case itemState.hangerFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer spriteRenderer11 in renderersBack)
				{
					if (art.hangerFlipped != null)
					{
						spriteRenderer11.sprite = art.hangerFlipped;
						spriteRenderer11.flipX = false;
					}
					else
					{
						spriteRenderer11.sprite = art.hanger;
						spriteRenderer11.flipX = true;
					}
				}
				if (art.hangerFlippedBack != null)
				{
					renderersBack = m_renderersBack;
					foreach (SpriteRenderer obj9 in renderersBack)
					{
						obj9.sprite = art.hangerFlippedBack;
						obj9.flipX = false;
					}
				}
				else
				{
					renderersBack = m_renderersBack;
					foreach (SpriteRenderer obj10 in renderersBack)
					{
						obj10.sprite = art.hangerBack;
						obj10.flipX = true;
					}
				}
				break;
			}
			case itemState.standing:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj7 in renderersBack)
				{
					obj7.sprite = ((art.standing == null) ? art.standingFlipped : art.standing);
					obj7.flipX = art.standing == null;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.sprite = ((art.standingShadow == null) ? art.standingFlippedShadow : art.standingShadow);
					m_rendererShadow.flipX = art.standingShadow == null;
				}
				break;
			}
			case itemState.standingFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj11 in renderersBack)
				{
					obj11.sprite = ((art.standingFlipped == null) ? art.standing : art.standingFlipped);
					obj11.flipX = art.standingFlipped == null;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.sprite = ((art.standingFlippedShadow == null) ? art.standingShadow : art.standingFlippedShadow);
					m_rendererShadow.flipX = art.standingFlippedShadow == null;
				}
				break;
			}
			case itemState.wallLeft:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj8 in renderersBack)
				{
					obj8.sprite = ((art.wall == null) ? art.wallFlipped : art.wall);
					obj8.flipX = art.wall == null;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.sprite = ((art.wallShadow == null) ? art.wallFlippedShadow : art.wallShadow);
					m_rendererShadow.flipX = art.wallShadow == null;
				}
				break;
			}
			case itemState.wallRight:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj4 in renderersBack)
				{
					obj4.sprite = ((art.wallFlipped == null) ? art.wall : art.wallFlipped);
					obj4.flipX = art.wallFlipped == null;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.sprite = ((art.wallFlippedShadow == null) ? art.wallShadow : art.wallFlippedShadow);
					m_rendererShadow.flipX = art.wallFlippedShadow == null;
				}
				break;
			}
			case itemState.combined:
			case itemState.combinedFlipped:
			{
				SpriteRenderer[] renderersBack = m_renderers;
				foreach (SpriteRenderer obj2 in renderersBack)
				{
					obj2.sprite = art.combined;
					obj2.flipX = _state == itemState.combinedFlipped;
				}
				for (int k = 0; k < m_combineMask.Length; k++)
				{
					m_combineMask[k].transform.localScale = ((_state == itemState.combined) ? Vector3.one : new Vector3(-1f, 1f, 1f));
				}
				break;
			}
			}
		}
		if (m_pinState != pinState.none)
		{
			if (m_state == itemState.wallLeft && _state == itemState.wallRight)
			{
				for (int l = 0; l < m_pinPositions.Length; l++)
				{
					SpriteRenderer component = m_pinTransforms[l].GetComponent<SpriteRenderer>();
					component.flipX = !component.flipX;
					Vector3 position = m_pinPositions[l].position;
					position.y += position.x - (float)(1 - m_xWall) * 0.07f;
					position.x += (float)(m_xWall - 1) * 0.14f;
					m_pinTransforms[l].localPosition = position;
				}
			}
			else if (m_state == itemState.wallRight && _state == itemState.wallLeft)
			{
				for (int m = 0; m < m_pinPositions.Length; m++)
				{
					SpriteRenderer component2 = m_pinTransforms[m].GetComponent<SpriteRenderer>();
					component2.flipX = !component2.flipX;
					Vector3 position2 = m_pinPositions[m].position;
					m_pinTransforms[m].localPosition = position2;
				}
			}
			else if (_state != itemState.wallLeft && _state != itemState.wallRight)
			{
				ClearPins();
			}
		}
		m_state = _state;
		if (!isNonFlatState)
		{
			m_lastFlatState = m_state;
		}
		if ((bool)m_polyCollision)
		{
			SetPolyCollision();
			if (flag)
			{
				SetPolyCollision((m_state == itemState.normal || m_state == itemState.reverse) ? itemState.stacked : itemState.stackedFlipped);
			}
		}
		int num = xWidth;
		int num2 = yWidth;
		float num3 = 0f;
		float num4 = 0.07f;
		if (m_state == itemState.wallLeft)
		{
			num = 1;
			num2 = m_xWall;
			num3 = 0.07f;
			num4 = 0.042f;
		}
		else if (m_state == itemState.wallRight)
		{
			num = m_xWall;
			num2 = 1;
			num3 = -0.07f;
			num4 = 0.042f;
		}
		else if (m_state == itemState.standing)
		{
			num = m_xStanding;
			num2 = m_yStanding;
		}
		else if (m_state == itemState.standingFlipped)
		{
			num = m_yStanding;
			num2 = m_xStanding;
		}
		else if (isOnRack && m_hangerChild != null && !m_hangerChild.isNonFlatState)
		{
			num = m_hangerChild.xWidth;
			num2 = m_hangerChild.yWidth;
		}
		else if (m_state == itemState.hanger || m_state == itemState.rack)
		{
			num = 2;
			num2 = 1;
			num3 = -0.08f;
			num4 = -0.07f;
		}
		else if (m_state == itemState.hangerFlipped || m_state == itemState.rackFlipped)
		{
			num = 1;
			num2 = 2;
			num3 = 0.08f;
			num4 = -0.07f;
		}
		else if (isOnHook || isOnHolder || isOnCombine || m_hangerChild != null)
		{
			num = 1;
			num2 = 1;
		}
		if (num == num2 || m_noSplit)
		{
			if (m_renderer != null && m_renderers.Length > 1)
			{
				MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
				m_renderers[0].GetPropertyBlock(materialPropertyBlock);
				materialPropertyBlock.SetFloat("_SplitStart", -10f);
				materialPropertyBlock.SetFloat("_SplitEnd", 10f);
				m_renderers[0].SetPropertyBlock(materialPropertyBlock);
				for (int n = 1; n < m_renderers.Length; n++)
				{
					m_renderers[n].enabled = false;
				}
				if (m_renderersBack.Length != 0)
				{
					m_renderersBack[0].GetPropertyBlock(materialPropertyBlock);
					materialPropertyBlock.SetFloat("_SplitStart", -10f);
					materialPropertyBlock.SetFloat("_SplitEnd", 10f);
					m_renderersBack[0].SetPropertyBlock(materialPropertyBlock);
					for (int num5 = 1; num5 < m_renderersBack.Length; num5++)
					{
						m_renderersBack[num5].enabled = false;
					}
				}
				m_shadowDepth = 0f;
				if (m_stackParent != null && m_stackShadow)
				{
					m_shadowDepth = -0.003f;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.transform.localPosition = Vector3.forward * m_shadowDepth;
				}
				else
				{
					Debug.LogWarning(base.name + " has art but no shadow art");
				}
			}
			m_artOffset = ((float)num - 1f + ((float)num - 1f) * 0.15f) * 0.07f;
		}
		else
		{
			int num6 = Mathf.Min(num, num2);
			int num7 = Mathf.Max(num, num2);
			int num8 = Mathf.CeilToInt((float)num7 / (float)num6);
			if (m_renderer != null && m_renderers.Length > 1)
			{
				MaterialPropertyBlock materialPropertyBlock2 = new MaterialPropertyBlock();
				m_renderers[0].GetPropertyBlock(materialPropertyBlock2);
				materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)num6 * -0.14f - ((num > num2) ? 0.5f : 0f));
				materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)num6 * 0.14f + ((num < num2) ? 0.5f : 0f));
				m_renderers[0].SetPropertyBlock(materialPropertyBlock2);
				for (int num9 = 1; num9 < m_renderers.Length; num9++)
				{
					if (num9 < num8)
					{
						m_renderers[num9].enabled = true;
						m_renderers[num9].GetPropertyBlock(materialPropertyBlock2);
						if (num > num2)
						{
							materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)(num6 * num9) * 0.14f);
							materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)(num6 * (num9 + 1)) * 0.14f + ((num9 == num8 - 1) ? 0.5f : 0f));
						}
						else
						{
							materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)(num6 * (num9 + 1)) * -0.14f - ((num9 == num8 - 1) ? 0.5f : 0f));
							materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)(num6 * num9) * -0.14f);
						}
						m_renderers[num9].SetPropertyBlock(materialPropertyBlock2);
						m_renderers[num9].transform.localPosition = Vector3.forward * Mathf.Min(num6 * num9, num7 - num6) * num4;
						m_shadowDepth = m_renderers[num9].transform.localPosition.z;
					}
					else
					{
						m_renderers[num9].enabled = false;
					}
				}
				if (m_state == itemState.hanger || m_state == itemState.hangerFlipped)
				{
					m_renderersBack[0].GetPropertyBlock(materialPropertyBlock2);
					materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)num6 * -0.14f - ((num > num2) ? 0.5f : 0f));
					materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)num6 * 0.14f + ((num < num2) ? 0.5f : 0f));
					m_renderersBack[0].SetPropertyBlock(materialPropertyBlock2);
					for (int num10 = 1; num10 < m_renderersBack.Length; num10++)
					{
						m_renderersBack[num10].enabled = true;
						m_renderersBack[num10].GetPropertyBlock(materialPropertyBlock2);
						if (num > num2)
						{
							materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)(num6 * num10) * 0.14f);
							materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)(num6 * (num10 + 1)) * 0.14f + ((num10 == num8 - 1) ? 0.5f : 0f));
						}
						else
						{
							materialPropertyBlock2.SetFloat("_SplitStart", num3 + (float)(num6 * (num10 + 1)) * -0.14f - ((num10 == num8 - 1) ? 0.5f : 0f));
							materialPropertyBlock2.SetFloat("_SplitEnd", num3 + (float)(num6 * num10) * -0.14f);
						}
						m_renderersBack[num10].SetPropertyBlock(materialPropertyBlock2);
						m_renderersBack[num10].transform.localPosition = Vector3.forward * ((float)Mathf.Min(num6 * num10, num7 - num6) * num4 + 0.04f);
					}
				}
				if (m_stackParent != null && m_stackShadow)
				{
					m_shadowDepth = -0.003f;
				}
				if (m_rendererShadow != null)
				{
					m_rendererShadow.transform.localPosition = Vector3.forward * m_shadowDepth;
				}
				else
				{
					Debug.LogWarning(base.name + " has art but no shadow art");
				}
			}
			m_artOffset = ((float)num6 - 1f + ((float)num6 - 1f) * 0.15f) * 0.07f;
		}
		ConfigureMaskArt();
		if (m_attachments != null)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				attachments[i].GetComponent<attachmentBaseScript>().ChangeState(m_state);
			}
		}
	}

	public bool PackMovableAdvanceState()
	{
		if (m_flipType == flipType.twoWay)
		{
			if (m_packMovableState == itemState.normal)
			{
				m_packMovableState = itemState.flipped;
			}
			else
			{
				m_packMovableState = itemState.normal;
			}
			PackMovableSetSprite();
			return true;
		}
		if (m_flipType == flipType.FourWay)
		{
			bool flag = m_rotateType == RotateType.rightFacing;
			if (m_packMovableState == itemState.normal)
			{
				m_packMovableState = (flag ? itemState.flipped : itemState.reverseFlipped);
			}
			else if (m_packMovableState == itemState.flipped)
			{
				m_packMovableState = (flag ? itemState.reverse : itemState.normal);
			}
			else if (m_packMovableState == itemState.reverse)
			{
				m_packMovableState = ((!flag) ? itemState.flipped : itemState.reverseFlipped);
			}
			else
			{
				m_packMovableState = ((!flag) ? itemState.reverse : itemState.normal);
			}
			PackMovableSetSprite();
			return true;
		}
		return false;
	}

	private void PackMovableSetSprite()
	{
		if (m_packMovableVisual == null)
		{
			return;
		}
		if (m_packMovableState != itemState.normal && m_packMovableState != itemState.flipped && m_packMovableState != itemState.reverse && m_packMovableState != itemState.reverseFlipped)
		{
			m_packMovableState = itemState.normal;
		}
		SpriteRenderer component = m_packMovableVisual.GetComponent<SpriteRenderer>();
		switch (m_packMovableState)
		{
		case itemState.normal:
			component.sprite = art.main;
			component.flipX = false;
			break;
		case itemState.flipped:
			if ((bool)art.flipped)
			{
				component.sprite = art.flipped;
				component.flipX = false;
			}
			else
			{
				component.sprite = art.main;
				component.flipX = true;
			}
			break;
		case itemState.reverse:
			component.sprite = art.reverse;
			component.flipX = false;
			break;
		case itemState.reverseFlipped:
			if ((bool)art.reverseFlipped)
			{
				component.sprite = art.reverseFlipped;
				component.flipX = false;
			}
			else
			{
				component.sprite = art.reverse;
				component.flipX = true;
			}
			break;
		case itemState.hooked:
			break;
		}
	}

	public void PackMovableLine(bool _value)
	{
		m_packMovableLine.enabled = _value;
		m_packMovableMat.SetOverrideTag("Outline", _value ? "Outline" : "");
	}

	public void PackMovableSet(int _state, Vector3 _position)
	{
		m_packMovable = true;
		m_packMovableState = (itemState)_state;
		m_packMovablePosition = _position;
	}

	public void PackMovablePlace(Vector3 _position, bool _valid, Transform _parent)
	{
		m_packMovable = _valid;
		if (m_packMovableVisual == null)
		{
			GameObject gameObject = new GameObject("m_packMovableVisual");
			m_packMovableMat = gameObject.AddComponent<SpriteRenderer>().material;
			m_packMovableVisual = gameObject.transform;
			m_packMovableMat.SetOverrideTag("Outline", "Outline");
			m_packMovableMat.SetColor("_OutlineColor1", new Color(0f, 0.5f, 0f));
			m_packMovableMat.SetColor("_OutlineColor2", new Color(0.1f, 0.6f, 0.1f));
			PackMovableSetSprite();
			m_packMovableLine = UnityEngine.Object.Instantiate(Camera.main.GetComponent<gameScript>().m_linePrefab).GetComponent<LineRenderer>();
			m_packMovableLine.SetPosition(0, (Vector2)base.transform.position);
			m_packMovableLine.startColor = new Color32(55, byte.MaxValue, byte.MaxValue, 96);
			m_packMovableLine.endColor = new Color32(55, byte.MaxValue, 55, 96);
			m_packMovableLine.widthMultiplier = 0.025f;
			SetDisplay(displayType.packedMovable, _propagate: false, _force: true);
		}
		Vector3 vector = Vector3.zero;
		if ((bool)_parent && _parent.CompareTag("drawer"))
		{
			vector = _parent.GetComponent<drawerScript>().GetOffset();
			m_packMovableVisual.GetComponent<SpriteRenderer>().maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
		}
		else
		{
			m_packMovableVisual.GetComponent<SpriteRenderer>().maskInteraction = SpriteMaskInteraction.None;
		}
		m_packMovablePosition = _position;
		Vector3 vector2 = _position + vector;
		if (!_valid)
		{
			vector2.z = -9f;
		}
		m_packMovableVisual.position = vector2;
		m_packMovableLine.SetPosition(1, (Vector2)vector2);
		m_packMovableVisual.GetComponent<SpriteRenderer>().color = (_valid ? new Color(1f, 1f, 1f, 0.75f) : new Color(1f, 1f, 1f, 0.25f));
		int sortingOrder = ((!_valid) ? 20 : 0);
		if (_parent != null && (bool)_parent.GetComponent<SpriteRenderer>())
		{
			sortingOrder = _parent.GetComponent<SpriteRenderer>().sortingOrder;
		}
		m_packMovableVisual.GetComponent<SpriteRenderer>().sortingOrder = sortingOrder;
		m_packMovableVisual.parent = _parent;
	}

	public void PackMovableBright(bool _value)
	{
		m_packMovableLine.endColor = (_value ? new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue) : new Color32(55, byte.MaxValue, 55, 96));
	}

	public void PackMovableUpdate()
	{
		if (!(m_packMovableVisual == null) && (!(m_packMovableVisual.parent == null) || m_inDrawer))
		{
			if (m_inDrawer)
			{
				m_packMovableLine.SetPosition(0, (Vector2)base.transform.position);
			}
			if (m_packMovableVisual.parent != null)
			{
				m_packMovableLine.SetPosition(1, (Vector2)m_packMovableVisual.position);
			}
		}
	}

	public void PackMovableRemove()
	{
		if (!(m_packMovableVisual == null))
		{
			UnityEngine.Object.Destroy(m_packMovableVisual.gameObject);
			m_packMovableVisual = null;
			UnityEngine.Object.Destroy(m_packMovableLine.gameObject);
			m_packMovableLine = null;
			m_packMovable = false;
			SetDisplay(displayType.packedMovable, _propagate: false, _force: true);
		}
	}

	public boxScript GetBox()
	{
		return m_box;
	}

	public zoneScript GetBoxZone()
	{
		return m_boxZone;
	}

	public int GetBoxState()
	{
		if (m_box != null)
		{
			return m_box.GetItemState(this);
		}
		return 0;
	}

	public int GetBoxIndex()
	{
		if (m_box == null)
		{
			return -1;
		}
		return m_box.FindItem(this);
	}

	public void BoxAssign(zoneScript _boxZone, boxScript _box)
	{
		m_box = _box;
		m_boxZone = _boxZone;
	}

	public void BoxMode(bool _active)
	{
		if (m_inDrawer)
		{
			PropagateMaskInteraction(SpriteMaskInteraction.VisibleOutsideMask, _shadow: false);
		}
		if (m_box != null)
		{
			if (_active)
			{
				SetDisplay(displayType.packed, _propagate: false);
				m_packModeCollision = true;
			}
			else
			{
				SetDisplay(displayType.none, _propagate: false);
				m_packModeCollision = false;
			}
		}
		else
		{
			SetDisplay(displayType.unpacked, _propagate: false);
			m_packModeCollision = true;
		}
		EvaluateEnabled();
	}

	public void PackingMode(int _mode)
	{
		if (m_inDrawer)
		{
			PropagateMaskInteraction(SpriteMaskInteraction.VisibleOutsideMask, _shadow: false);
		}
		switch (_mode)
		{
		case 0:
			SetDisplay(displayType.unpacked, _propagate: false);
			m_packModeCollision = true;
			break;
		case 1:
			SetDisplay(displayType.packed, _propagate: false);
			m_packModeCollision = true;
			break;
		case 2:
			SetDisplay(displayType.packedUnmovable, _propagate: false);
			m_packModeCollision = true;
			break;
		case 3:
			SetDisplay(displayType.packedMovable, _propagate: false);
			m_packModeCollision = true;
			break;
		case 4:
			SetDisplay(displayType.none, _propagate: false);
			m_packModeCollision = false;
			break;
		}
		EvaluateEnabled();
	}

	public void PackingModeShow(bool _value)
	{
		if (m_stackChild != null)
		{
			Transform transform = m_stackChild.transform;
			for (int i = 0; i < m_artPivot.childCount; i++)
			{
				Transform child = m_artPivot.GetChild(i);
				if (child != transform)
				{
					child.gameObject.SetActive(_value);
				}
			}
			if (m_rendererShadow != null)
			{
				m_rendererShadow.gameObject.SetActive(_value && m_showShadow);
			}
			if (m_gridShadowPivot != null)
			{
				m_gridShadowPivot.gameObject.SetActive(_value && m_showShadow);
			}
			m_visibleEnabled = _value;
			EvaluateEnabled();
		}
		else
		{
			base.gameObject.SetActive(_value);
		}
		if (m_packMovable)
		{
			m_packMovableLine.gameObject.SetActive(_value);
			m_packMovableVisual.gameObject.SetActive(_value);
		}
	}

	private void SetDisplay(displayType _display)
	{
		SetDisplay(_display, _propagate: true);
	}

	private void SetDisplayColor(Color _color)
	{
		SpriteRenderer[] renderers = m_renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].color = _color;
		}
		renderers = m_renderersBack;
		for (int i = 0; i < renderers.Length; i++)
		{
			renderers[i].color = _color;
		}
	}

	private void SetDisplay(displayType _display, bool _propagate)
	{
		SetDisplay(_display, _propagate, _force: false);
	}

	public void SetTouchDisplay(bool _active)
	{
		SetDisplay(_active ? displayType.touchSelect : (m_invalid ? displayType.invalid : displayType.none));
	}

	private void SetDisplay(displayType _display, bool _propagate, bool _force)
	{
		if (!_force && _display == m_display)
		{
			return;
		}
		m_display = _display;
		if (m_display != displayType.touchSelect)
		{
			m_invalid = m_display == displayType.invalid;
		}
		if (m_display == displayType.unplacable)
		{
			SetDisplayColor(new Color(1f, 1f, 1f, 0.5f));
		}
		else if (m_display == displayType.touchSelectUnplacable)
		{
			SetDisplayColor(new Color(0.6f, 0.6f, 0.6f, 1f));
		}
		else
		{
			SetDisplayColor(Color.white);
		}
		if (m_pinState != pinState.none)
		{
			for (int i = 0; i < m_pinTransforms.Length; i++)
			{
				m_pinTransforms[i].gameObject.SetActive(m_display != displayType.unplacable);
			}
		}
		if (m_display == displayType.touchSelect || m_display == displayType.touchSelectUnplacable)
		{
			if (!m_touchShader)
			{
				m_mat.shader = Shader.Find(m_combined ? "Sprites/Default Touch Combine" : ((m_renderers.Length == 1) ? "Sprites/Default Touch Select" : "Sprites/Default Split Touch Select"));
				if (m_matBack != null)
				{
					m_matBack.shader = Shader.Find((m_renderersBack.Length == 1) ? "Sprites/Default Touch Select" : "Sprites/Default Split Touch Select");
				}
				m_touchShader = true;
			}
		}
		else if (m_touchShader)
		{
			m_mat.shader = (m_combined ? s_materials[7].shader : ((m_renderers.Length == 1) ? s_materials[2].shader : s_materials[3].shader));
			if (m_matBack != null)
			{
				m_matBack.shader = ((m_renderersBack.Length == 1) ? s_materials[2].shader : s_materials[3].shader);
			}
			m_touchShader = false;
		}
		if (m_display == displayType.invalid)
		{
			SetOverrideTag("Outline", "SplitOutline", "GridOutline");
		}
		else if (m_display == displayType.hover)
		{
			SetOverrideTag("Hover", "SplitHover", "Hover");
		}
		else if (m_display == displayType.unpacked)
		{
			SetOutlineColors(new Color(1f, 0f, 0f), new Color(1.25f, 0.25f, 0.25f));
			SetOverrideTag("Outline", "SplitOutline", "GridOutline");
		}
		else if (m_display == displayType.packed)
		{
			SetOutlineColors(new Color(0f, 0f, 1f), new Color(0.25f, 0.25f, 1.25f));
			SetOverrideTag("Outline", "SplitOutline", "GridOutline");
		}
		else if (m_display == displayType.packedUnmovable)
		{
			SetOutlineColors(new Color(1f, 1f, 0f), new Color(1.25f, 1.25f, 0.25f));
			SetOverrideTag("Outline", "SplitOutline", "GridOutline");
		}
		else if (m_display == displayType.packedMovable)
		{
			if (m_packMovableVisual == null)
			{
				SetOutlineColors(new Color(0f, 1f, 0f), new Color(0.25f, 1.25f, 0.25f));
			}
			else
			{
				SetOutlineColors(new Color(0f, 1f, 1f), new Color(0.25f, 1.25f, 1.25f));
			}
			SetOverrideTag("Outline", "SplitOutline", "GridOutline");
		}
		else
		{
			SetOverrideTag("", "", "");
		}
		ShowGrid();
		if (_propagate)
		{
			PropagateDisplay(m_display);
		}
	}

	private void SetOutlineColors(Color _color1, Color _color2)
	{
		if (m_renderer != null)
		{
			m_mat.SetColor("_OutlineColor1", _color1);
			m_mat.SetColor("_OutlineColor2", _color2);
		}
		if (m_renderersBack.Length != 0)
		{
			m_matBack.SetColor("_OutlineColor1", _color1);
			m_matBack.SetColor("_OutlineColor2", _color2);
		}
		if (m_matGrid != null)
		{
			m_matGrid.SetColor("_OutlineColor1", _color1);
			m_matGrid.SetColor("_OutlineColor2", _color2);
		}
	}

	private void SetOverrideTag(string _single, string _split, string _grid)
	{
		if (m_renderers.Length == 1)
		{
			m_mat.SetOverrideTag("Outline", _single);
		}
		else if (m_renderers.Length > 1)
		{
			m_mat.SetOverrideTag("Outline", _split);
		}
		if (m_renderersBack.Length != 0)
		{
			m_matBack.SetOverrideTag("Outline", _single);
		}
		if (m_matGrid != null)
		{
			m_matGrid.SetOverrideTag("Outline", _grid);
		}
	}

	public bool ZoneCheck(zoneScript.zoneType _zoneType)
	{
		switch (_zoneType)
		{
		case zoneScript.zoneType.kitchen:
			return m_zonesKitchen != zoneScript.zoneKitchen.nothing;
		case zoneScript.zoneType.bedroom:
		case zoneScript.zoneType.closet:
			return m_zonesBedroom != zoneScript.zoneBedroom.nothing;
		case zoneScript.zoneType.bathroom:
		case zoneScript.zoneType.toilet:
			return m_zonesBathroom != zoneScript.zoneBathroom.nothing;
		case zoneScript.zoneType.livingroom:
		case zoneScript.zoneType.foyer:
			return m_zonesLivingRoom != zoneScript.zoneLivingRoom.nothing;
		case zoneScript.zoneType.diningroom:
			return m_zonesDiningRoom != zoneScript.zoneDiningRoom.nothing;
		case zoneScript.zoneType.office:
			return m_zonesOffice != zoneScript.zoneOffice.nothing;
		case zoneScript.zoneType.nursery:
			return m_zonesNursery != zoneScript.zoneNursery.nothing;
		default:
			return false;
		}
	}

	private bool EvaulateValid(zoneScript.zoneType _zoneType, zoneScript.itemNode.nodeType _type)
	{
		if (m_unmovable)
		{
			return true;
		}
		zoneScript.itemNode.nodeType nodeType = zoneScript.itemNode.nodeType.none;
		switch (_zoneType)
		{
		case zoneScript.zoneType.kitchen:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesKitchen;
			break;
		case zoneScript.zoneType.bedroom:
		case zoneScript.zoneType.closet:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesBedroom;
			break;
		case zoneScript.zoneType.bathroom:
		case zoneScript.zoneType.toilet:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesBathroom;
			break;
		case zoneScript.zoneType.livingroom:
		case zoneScript.zoneType.foyer:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesLivingRoom;
			break;
		case zoneScript.zoneType.diningroom:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesDiningRoom;
			break;
		case zoneScript.zoneType.office:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesOffice;
			break;
		case zoneScript.zoneType.nursery:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesNursery;
			break;
		case zoneScript.zoneType.wall:
			nodeType = (zoneScript.itemNode.nodeType)m_zonesWall;
			break;
		}
		if (_type != zoneScript.itemNode.nodeType.none)
		{
			return (nodeType & _type) == _type;
		}
		return false;
	}

	public bool Validate(zoneScript.zoneType _zoneType, zoneScript.itemNode.nodeType _type)
	{
		return EvaulateValid(_zoneType, _type);
	}

	public string GetVariantString()
	{
		if (m_currentVariant == 0 && string.IsNullOrEmpty(m_variants[0].name))
		{
			return "";
		}
		return "|" + art.name;
	}

	public string GetVariantName()
	{
		string text = art.name;
		if (!string.IsNullOrEmpty(text))
		{
			return " " + text;
		}
		return "";
	}

	public string GetVariantNameSimple()
	{
		return m_variants[m_currentVariant].name;
	}

	public int FindVariant(string _name)
	{
		if (m_variants != null)
		{
			for (int i = 0; i < m_variants.Length; i++)
			{
				if (m_variants[i].name == _name)
				{
					return i;
				}
			}
			for (int j = 0; j < m_variants.Length; j++)
			{
				for (int k = 0; k < m_variants[j].oldNames.Length; k++)
				{
					if (m_variants[j].oldNames[k] == _name)
					{
						return j;
					}
				}
			}
		}
		return 0;
	}

	public int GetVariant()
	{
		return m_currentVariant;
	}

	public bool MatchVariant(string _name)
	{
		return m_variants[m_currentVariant].name.Equals(_name);
	}

	public void SetVariant(int _variant)
	{
		if (m_variants != null)
		{
			if (base.name.StartsWith("itemPhotoAlbum"))
			{
				_variant = saveData.GetAlbumColor();
			}
			m_currentVariant = Mathf.Clamp(_variant, 0, m_variants.Length - 1);
			if (!string.IsNullOrEmpty(m_variants[m_currentVariant].m_sweetener))
			{
				m_audioID.m_sweetener = m_variants[m_currentVariant].m_sweetener;
			}
			if (GetComponent<PolygonCollider2D>() != null)
			{
				StorePhysics();
			}
			SetState(m_state);
			ShowGrid();
		}
	}

	private void Init()
	{
		int num = Mathf.CeilToInt((float)Mathf.Max(m_xWidth, m_yWidth) / (float)Mathf.Min(m_xWidth, m_yWidth));
		if (m_usesStanding)
		{
			num = Mathf.Max(num, Mathf.CeilToInt((float)Mathf.Max(m_xStanding, m_yStanding) / (float)Mathf.Min(m_xStanding, m_yStanding)));
		}
		if (m_usesWall)
		{
			num = Mathf.Max(num, m_xWall);
		}
		if (m_usesHanger || m_usesRack)
		{
			num = Mathf.Max(num, 2);
		}
		m_matGrid = new Material(s_materials[2]);
		if (num == 1)
		{
			if (m_renderer != null)
			{
				m_mat = new Material(s_materials[2]);
				m_renderer.sharedMaterial = m_mat;
				m_renderers = new SpriteRenderer[1];
				m_renderers[0] = m_renderer;
			}
			else
			{
				m_renderers = new SpriteRenderer[0];
			}
			m_artOffset = ((float)(xWidth - 1) + (float)(xWidth - 1) * 0.15f) * 0.07f;
		}
		else if (m_renderer != null)
		{
			m_mat = new Material(s_materials[3]);
			m_renderer.sharedMaterial = m_mat;
			m_renderers = new SpriteRenderer[num];
			m_renderers[0] = m_renderer;
			for (int i = 1; i < num; i++)
			{
				m_renderers[i] = UnityEngine.Object.Instantiate(m_renderer.gameObject, m_renderer.transform.parent).GetComponent<SpriteRenderer>();
			}
		}
		else
		{
			m_renderers = new SpriteRenderer[0];
		}
		if (m_usesCombine)
		{
			m_combineGroup = m_renderers[0].gameObject.AddComponent<SortingGroup>();
			m_combineGroup.enabled = false;
			m_combineMask = new SpriteRenderer[2];
			for (int j = 0; j < m_combineMask.Length; j++)
			{
				GameObject gameObject = new GameObject("combineMask" + j);
				gameObject.transform.parent = m_renderers[0].transform;
				m_combineMask[j] = gameObject.AddComponent<SpriteRenderer>();
				m_combineMask[j].enabled = false;
				m_combineMask[j].sharedMaterial = s_materials[(j == 0) ? 8 : 9];
				m_combineMask[j].sortingOrder = ((j != 0) ? 1 : (-1));
			}
		}
		if (m_usesHanger || m_usesBar || m_usesHook)
		{
			m_renderersBack = new SpriteRenderer[(!m_usesHanger) ? 1 : 2];
			m_matBack = new Material(s_materials[m_usesHanger ? 1 : 2]);
			for (int k = 0; k < m_renderersBack.Length; k++)
			{
				GameObject gameObject2 = new GameObject("back");
				gameObject2.transform.parent = m_artPivot;
				gameObject2.transform.localPosition = Vector3.forward * 0.04f;
				m_renderersBack[k] = gameObject2.AddComponent<SpriteRenderer>();
				m_renderersBack[k].sharedMaterial = m_matBack;
				m_renderersBack[k].gameObject.SetActive(value: false);
			}
		}
		else
		{
			m_renderersBack = new SpriteRenderer[0];
		}
		m_polyCollision = GetComponent<PolygonCollider2D>();
		if ((bool)m_polyCollision)
		{
			StorePhysics();
		}
		m_flippableOffsetCol = GetComponent<Collider2D>().offset.x;
		if (m_stackID != stackId.none)
		{
			CapsuleCollider2D component = GetComponent<CapsuleCollider2D>();
			if (component != null)
			{
				GameObject gameObject3 = new GameObject("defaultCollision");
				gameObject3.transform.parent = base.transform;
				gameObject3.SetActive(value: false);
				m_defaultCollision = gameObject3.AddComponent<CapsuleCollider2D>();
				m_defaultCollision.size = component.size;
				m_defaultCollision.offset = component.offset;
				m_defaultCollision.direction = component.direction;
			}
		}
		if (m_renderer != null)
		{
			m_mask = new SpriteMask[1];
			for (int l = 0; l < m_mask.Length; l++)
			{
				GameObject gameObject4 = new GameObject("Mask");
				gameObject4.transform.parent = m_artPivot;
				gameObject4.transform.localPosition = Vector3.forward * -0.005f;
				m_mask[l] = gameObject4.AddComponent<SpriteMask>();
				m_mask[l].isCustomRangeActive = true;
				gameObject4.SetActive(value: false);
			}
		}
		else
		{
			m_mask = new SpriteMask[0];
		}
		m_audioGO = new GameObject("audio");
		m_audioGO.transform.parent = base.transform;
		if (m_pinPositions == null || m_pinPositions.Length == 0)
		{
			m_pinTypes = new int[0];
			m_pinTransforms = new Transform[0];
		}
		else
		{
			m_pinTypes = new int[m_pinPositions.Length];
			m_pinTransforms = new Transform[m_pinPositions.Length];
			for (int m = 0; m < m_pinTypes.Length; m++)
			{
				m_pinTypes[m] = -1;
				GameObject gameObject5 = new GameObject("pin");
				gameObject5.transform.parent = m_artPivot;
				gameObject5.AddComponent<SpriteRenderer>();
				gameObject5.SetActive(value: false);
				m_pinTransforms[m] = gameObject5.transform;
			}
		}
		m_init = true;
	}

	private void Start()
	{
		ShowGrid();
	}

	public Vector3 VisualOffset()
	{
		Vector3 result = Vector3.zero;
		if (!isOnRack && !isOnHanger && !isOnHolder && !isOnCombine)
		{
			if (isOnHook)
			{
				result.y += 0.25f;
			}
			else if (isOnShelf)
			{
				result.x += ((m_state == itemState.standing) ? (-0.06f) : 0.06f);
				result.y += 0.15f;
			}
			else if (m_state == itemState.wallLeft)
			{
				int num = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
				int num2 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
				result = new Vector3(-0.14f, 0.07f) * num + new Vector3(0f, 0.17f) * num2;
			}
			else if (m_state == itemState.wallRight)
			{
				int num3 = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
				int num4 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
				result = new Vector3(0.14f, 0.07f) * num3 + new Vector3(0f, 0.17f) * num4;
			}
			else
			{
				int num5 = Mathf.CeilToInt((float)(xValidate - 1) / 2f);
				int num6 = Mathf.CeilToInt((float)(yValidate - 1) / 2f);
				result = new Vector3(0.14f, 0.07f) * num5 + new Vector3(-0.14f, 0.07f) * num6;
			}
		}
		return result;
	}

	public Vector3 GetOffset(Vector3 _position)
	{
		Vector3 result = _position - base.transform.position;
		result.z = 0f;
		if (!isOnRack && !isOnHolder && !isOnCombine)
		{
			if (isOnHook)
			{
				result.y -= 0.25f;
			}
			else if (isOnShelf)
			{
				result.x -= ((m_state == itemState.standing) ? (-0.06f) : 0.06f);
				result.y -= 0.15f;
			}
			else if (!isOnHanger)
			{
				if (m_state == itemState.bar)
				{
					int num = Mathf.CeilToInt((float)(m_yWidth - 1) / 2f);
					result -= new Vector3(-0.14f, 0.07f) * num;
				}
				else if (m_state == itemState.barFlipped)
				{
					int num2 = Mathf.CeilToInt((float)(m_yWidth - 1) / 2f);
					result -= new Vector3(0.14f, 0.07f) * num2;
				}
				else if (m_state == itemState.wallLeft)
				{
					int num3 = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
					int num4 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
					result -= new Vector3(-0.14f, 0.07f) * num3 + new Vector3(0f, 0.17f) * num4;
				}
				else if (m_state == itemState.wallRight)
				{
					int num5 = Mathf.CeilToInt((float)(m_xWall - 1) / 2f);
					int num6 = Mathf.CeilToInt((float)(m_yWall - 1) / 2f);
					result -= new Vector3(0.14f, 0.07f) * num5 + new Vector3(0f, 0.17f) * num6;
				}
				else if (m_stackParent != null)
				{
					result = _position - GetComponent<Collider2D>().bounds.center;
				}
				else
				{
					int num7 = xWidth;
					int num8 = yWidth;
					if (m_state == itemState.standing)
					{
						num7 = m_xStanding;
						num8 = m_yStanding;
					}
					else if (m_state == itemState.standingFlipped)
					{
						num7 = m_yStanding;
						num8 = m_xStanding;
					}
					int num9 = Mathf.CeilToInt((float)(num7 - 1) / 2f);
					int num10 = Mathf.CeilToInt((float)(num8 - 1) / 2f);
					result -= new Vector3(0.14f, 0.07f) * num9 + new Vector3(-0.14f, 0.07f) * num10;
				}
			}
		}
		return result;
	}

	private void PropagateSortingLayer(int _sortingLayer)
	{
		SetSortingLayer(_sortingLayer);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateSortingLayer(_sortingLayer);
		}
		if (m_hangerChild != null)
		{
			m_hangerChild.SetSortingLayer(_sortingLayer);
		}
		if (m_combineChild.Count > 0)
		{
			for (int i = 0; i < m_combineChild.Count; i++)
			{
				m_combineChild[i].SetSortingLayer(_sortingLayer);
			}
		}
	}

	private void SetSortingLayer(int _sortingLayer)
	{
		if (_sortingLayer != m_sortingLayer)
		{
			m_sortingLayer = _sortingLayer;
			SpriteRenderer[] renderers = m_renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sortingOrder = m_sortingLayer;
			}
			if (m_usesCombine && m_combineGroup.enabled)
			{
				m_renderers[0].sortingOrder = 0;
				m_combineGroup.sortingOrder = m_sortingLayer;
			}
			renderers = m_renderersBack;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].sortingOrder = m_sortingLayer;
			}
			if (m_rendererShadow != null)
			{
				m_rendererShadow.sortingOrder = m_sortingLayer;
			}
			ShowGrid();
		}
	}

	private void PropagateDepth(int _foreground)
	{
		ConfigureDepth(_foreground);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateDepth(_foreground);
		}
	}

	private void ConfigureDepth(int _foreground)
	{
		if (m_xWidth == m_yWidth || m_foreground == _foreground)
		{
			return;
		}
		m_foreground = _foreground;
		int num = Mathf.Min(m_xWidth, m_yWidth);
		int num2 = Mathf.Max(m_xWidth, m_yWidth);
		int num3 = Mathf.CeilToInt((float)num2 / (float)num);
		int num4 = ((m_foreground == 0) ? 99 : (m_foreground - 1));
		if (m_renderer != null)
		{
			for (int i = 1; i < num3; i++)
			{
				m_renderers[i].transform.localPosition = Vector3.forward * ((float)Mathf.Min(num * i, num2 - num) * 0.07f + (float)((i * num >= num4) ? 100 : 0) * 0.06f);
				m_shadowDepth = m_renderers[i].transform.localPosition.z;
			}
		}
		if (m_stackParent != null && m_stackShadow)
		{
			m_shadowDepth = -0.003f;
		}
		if (m_rendererShadow != null)
		{
			m_rendererShadow.transform.localPosition = Vector3.forward * m_shadowDepth;
		}
		ShowGrid();
	}

	protected void PropagateMaskDown(int _maskId, int _maskFrontSortingOrder)
	{
		m_maskFrontSortingOrder = _maskFrontSortingOrder;
		m_maskId = _maskId;
		UpdateMask();
		if ((bool)m_stackParent)
		{
			m_stackParent.PropagateMaskDown(_maskId, _maskFrontSortingOrder);
		}
	}

	protected void PropagateMaskLevel(int _maskLevel, int _size)
	{
		SetMaskLevel(_maskLevel, _size);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateMaskLevel(_maskLevel, _size);
		}
		if (m_hangerChild != null)
		{
			m_hangerChild.PropagateMaskLevel(_maskLevel, _size);
		}
		if (m_combineChild.Count > 0)
		{
			for (int i = 0; i < m_combineChild.Count; i++)
			{
				m_combineChild[i].PropagateMaskLevel(_maskLevel, _size);
			}
		}
	}

	public void SetMaskLevel(int _maskId)
	{
		SetMaskLevel(_maskId, size);
	}

	private void SetMaskLevel(int _maskId, int _size)
	{
		int maskFrontSortingOrder = ((_maskId != 0 && _maskId != -2) ? (_size + Mathf.Max(1, _maskId)) : 0);
		m_maskFrontSortingOrder = maskFrontSortingOrder;
		m_maskId = _maskId;
		UpdateMask();
	}

	private void UpdateMask()
	{
		if (m_maskId == 0 || m_maskId == -2)
		{
			for (int i = 0; i < m_mask.Length; i++)
			{
				m_mask[i].gameObject.SetActive(value: false);
			}
			return;
		}
		for (int j = 0; j < m_mask.Length; j++)
		{
			m_mask[j].gameObject.SetActive(value: true);
			m_mask[j].frontSortingOrder = m_maskFrontSortingOrder;
			m_mask[j].backSortingOrder = ((m_maskId != -1) ? 1 : ((m_foreground != 0) ? (-1) : 0));
		}
		ConfigureMaskArt();
	}

	private void ConfigureMaskArt()
	{
		if (StateHasArt() && m_maskId != 0 && m_mask != null && m_mask.Length != 0)
		{
			m_mask[0].transform.localScale = new Vector3(m_renderer.flipX ? (-1f) : 1f, 1f, 1f);
			m_mask[0].sprite = m_renderer.sprite;
		}
	}

	protected Sprite GetCombineMask()
	{
		return art.combineMask;
	}

	private void SetCombineMask(Sprite _mask)
	{
		if (_mask == null)
		{
			if (m_combineGroup.enabled)
			{
				for (int i = 0; i < m_combineMask.Length; i++)
				{
					m_combineMask[i].enabled = false;
				}
				m_combineGroup.enabled = false;
				m_renderers[0].sortingOrder = m_sortingLayer;
				m_mat.shader = s_materials[(m_renderers.Length > 1) ? 3 : 2].shader;
			}
			return;
		}
		for (int j = 0; j < m_combineMask.Length; j++)
		{
			m_combineMask[j].sprite = _mask;
			m_combineMask[j].transform.localPosition = -m_artPivot.localPosition;
			m_combineMask[j].enabled = true;
		}
		m_combineGroup.sortingOrder = m_sortingLayer;
		m_combineGroup.enabled = true;
		m_renderers[0].sortingOrder = 0;
		m_mat.shader = s_materials[7].shader;
	}

	public void ChangeCollision(bool _value)
	{
		GetComponent<Collider2D>().enabled = _value;
		m_canStackOn = _value && m_stackID != stackId.none;
		if (m_stackChild != null)
		{
			m_stackChild.ActivateStack(_value);
		}
		if (m_hangerChild != null)
		{
			m_hangerChild.ChangeCollision(_value);
		}
	}

	public void SimplePosition(Vector3 _position)
	{
		_position.z += m_artOffset * base.transform.localScale.z;
		_position.x = Mathf.Round(_position.x * 100f) / 100f;
		_position.y = Mathf.Round((_position.y - 0.005f) * 100f) / 100f + 0.005f;
		base.transform.position = _position;
		m_audioGO.transform.localPosition = Vector3.forward * (0f - _position.z);
	}

	public void SetShadow(bool _value)
	{
		m_showShadow = _value;
		if (m_rendererShadow != null)
		{
			m_rendererShadow.gameObject.SetActive(_value);
		}
		if (m_gridShadowPivot != null)
		{
			m_gridShadowPivot.gameObject.SetActive(_value);
		}
		if (m_hangerChild != null)
		{
			m_hangerChild.SetShadow(_value);
		}
	}

	public void SetOnTop()
	{
		PropagateMaskInteraction(SpriteMaskInteraction.None);
		PropagateSortingLayer(20);
	}

	public int CheckPinCount(pinState _state)
	{
		if (m_pinState == _state || m_pinPositions == null || m_pinPositions.Length == 0)
		{
			return -1;
		}
		if (m_pinState != pinState.none)
		{
			ClearPins();
		}
		if (_state != pinState.none)
		{
			return m_pinPositions.Length;
		}
		return -1;
	}

	public void AddPins(pinState _state, int[] _pinTypes, gameScript.pinType[] _pinData)
	{
		for (int i = 0; i < m_pinPositions.Length; i++)
		{
			m_pinTypes[i] = _pinTypes[i];
			SpriteRenderer component = m_pinTransforms[i].GetComponent<SpriteRenderer>();
			component.sprite = _pinData[i].sprite;
			component.color = _pinData[i].tint;
			component.flipX = m_state == itemState.wallRight;
			Vector3 position = m_pinPositions[i].position;
			if (m_state == itemState.wallRight)
			{
				position.y += position.x - (float)(1 - m_xWall) * 0.07f;
				position.x += (float)(m_xWall - 1) * 0.14f;
			}
			m_pinTransforms[i].localPosition = position;
			m_pinTransforms[i].gameObject.SetActive(value: true);
		}
		m_pinState = _state;
	}

	private void ClearPins()
	{
		for (int i = 0; i < m_pinPositions.Length; i++)
		{
			m_pinTypes[i] = -1;
			m_pinTransforms[i].gameObject.SetActive(value: false);
		}
		m_pinState = pinState.none;
	}

	public void PropagateNoSplit(bool _noSplit)
	{
		m_noSplit = _noSplit;
		SetState(m_state);
		if (m_stackChild != null)
		{
			m_stackChild.PropagateNoSplit(_noSplit);
		}
		if (m_hangerChild != null)
		{
			m_hangerChild.PropagateNoSplit(_noSplit);
		}
	}

	public void Position(Vector3 _position, positionAction _action, bool _unboxed, itemScript _stacked, int _node, int _maskLevel, int _foreground, Transform _parent, nodeStyle _style, int _sizeBoost)
	{
		if ((_style == nodeStyle.holder || _style == nodeStyle.holderFlipped) && _action == positionAction.placedValid && m_currentVariant % 2 == 1)
		{
			statsScript.SpecialEvent(statsScript.specialEvents.toiletRollReverse);
		}
		m_positionValid = _action != positionAction.unplacable;
		m_inDrawer = (_parent != null && _parent.CompareTag("drawer")) || (_stacked != null && _stacked.Parent() != null && _stacked.Parent().CompareTag("drawer"));
		bool flag = _action == positionAction.placedValid || _action == positionAction.placedInvalid;
		if (flag && m_inDrawer && _stacked == null)
		{
			_parent.GetComponent<drawerScript>().AddItem(this);
		}
		else if (!flag && Parent() != null && Parent().CompareTag("drawer"))
		{
			Parent().GetComponent<drawerScript>().RemoveItem(this);
		}
		int num = 0;
		num = ((_action == positionAction.unplacable) ? 20 : (m_inDrawer ? ((!_parent.CompareTag("drawer")) ? _stacked.Parent().GetComponent<SpriteRenderer>().sortingOrder : _parent.GetComponent<SpriteRenderer>().sortingOrder) : 0));
		PropagateMaskInteraction((m_inDrawer || _maskLevel == -2) ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
		PropagateSortingLayer(num);
		PropagateMaskLevel(_maskLevel, ((_stacked == null) ? size : _stacked.GetStackSize(this)) + _sizeBoost);
		if (_foreground != 0 && _foreground < Mathf.Min(m_xWidth, m_yWidth))
		{
			if (_stacked == null)
			{
				_position.z += 6f;
			}
			_foreground = 0;
		}
		PropagateDepth(_foreground);
		base.transform.parent = _parent;
		if ((_stacked != null && (_stacked.noSplit || ((_style == nodeStyle.flat || _style == nodeStyle.box) && (xWidth != _stacked.xWidth || yWidth != _stacked.yWidth)))) || (m_hangerChild != null && !isOnRack && (xWidth != m_hangerChild.xWidth || yWidth != m_hangerChild.yWidth)))
		{
			if (!m_noSplit)
			{
				PropagateNoSplit(_noSplit: true);
			}
		}
		else if (m_noSplit)
		{
			PropagateNoSplit(_noSplit: false);
		}
		if (_style == nodeStyle.box)
		{
			base.transform.localScale = new Vector3(1f, 1f, 0.5f);
		}
		else
		{
			base.transform.localScale = Vector3.one;
		}
		m_node = _node;
		if (_action != positionAction.unplacable)
		{
			SumTotalSize(_stacked);
			if (s_touchMode && _action == positionAction.hover)
			{
				SetDisplay(displayType.touchSelect);
			}
			else
			{
				switch (_action)
				{
				case positionAction.hover:
					SetDisplay(displayType.hover);
					break;
				case positionAction.placedInvalid:
					SetDisplay(displayType.invalid);
					break;
				default:
					SetDisplay(displayType.none);
					break;
				}
			}
			bool flag2 = (isRackable && (bool)_stacked) || m_hangerChild != null;
			m_hangerOverRack = _style == nodeStyle.rack || _style == nodeStyle.rackFlipped;
			if (_style == nodeStyle.hooked)
			{
				SetState(itemState.hooked);
				ShowGrid();
			}
			else if (_style == nodeStyle.hookedFlipped)
			{
				SetState(itemState.hookedFlipped);
				ShowGrid();
			}
			else if (_style == nodeStyle.holder)
			{
				SetState(itemState.holder);
				ShowGrid();
			}
			else if (_style == nodeStyle.holderFlipped)
			{
				SetState(itemState.holderFlipped);
				ShowGrid();
			}
			else if (_style == nodeStyle.bar)
			{
				SetState(itemState.bar);
				ShowGrid();
			}
			else if (_style == nodeStyle.barFlipped)
			{
				SetState(itemState.barFlipped);
				ShowGrid();
			}
			else if (_style == nodeStyle.rack || ((_style == nodeStyle.flat || _style == nodeStyle.box) && flag2 && !flipped()))
			{
				SetState(itemState.rack);
				ShowGrid();
			}
			else if (_style == nodeStyle.rackFlipped || ((_style == nodeStyle.flat || _style == nodeStyle.box) && flag2 && flipped()))
			{
				SetState(itemState.rackFlipped);
				ShowGrid();
			}
			else
			{
				switch (_style)
				{
				case nodeStyle.hanger:
					SetState(itemState.hanger);
					ShowGrid();
					break;
				case nodeStyle.hangerFlipped:
					SetState(itemState.hangerFlipped);
					ShowGrid();
					break;
				case nodeStyle.standing:
					SetState(itemState.standing);
					ShowGrid();
					break;
				case nodeStyle.standingFlipped:
					SetState(itemState.standingFlipped);
					ShowGrid();
					break;
				case nodeStyle.wallLeft:
					SetState(itemState.wallLeft);
					ShowGrid();
					break;
				case nodeStyle.wallRight:
					SetState(itemState.wallRight);
					ShowGrid();
					break;
				case nodeStyle.combined:
					SetState(itemState.combined);
					ShowGrid();
					break;
				case nodeStyle.combinedFlipped:
					SetState(itemState.combinedFlipped);
					ShowGrid();
					break;
				default:
					if (isNonFlatState)
					{
						SetState(m_lastFlatState);
						ShowGrid();
					}
					break;
				}
			}
			if (!_stacked && !isNonFlatState && !isOnWall)
			{
				_position.z += m_artOffset * base.transform.localScale.z;
			}
			if (!_stacked && m_hangerChild != null && !m_hangerChild.isNonFlatState)
			{
				_position.z += m_hangerChild.artOffset;
			}
		}
		else
		{
			_position -= VisualOffset();
			_position.z = -9f;
			if (s_touchMode)
			{
				SetDisplay(_unboxed ? displayType.touchSelect : displayType.touchSelectUnplacable);
			}
			else
			{
				SetDisplay(_unboxed ? displayType.hover : displayType.unplacable);
			}
		}
		_position.x = Mathf.Round(_position.x * 100f) / 100f;
		_position.y = Mathf.Round((_position.y - 0.005f) * 100f) / 100f + 0.005f;
		base.transform.position = _position;
		m_audioGO.transform.localPosition = Vector3.forward * (0f - _position.z);
		SetShadow(_action != positionAction.unplacable && (!_stacked || m_stackShadow) && !isOnHook && !isOnHolder && !isOnBar && !isOnRack && !isOnHanger);
		if (isRackable && m_hangerChild != null)
		{
			m_hangerChild.SetShadow(!m_hangerOverRack && _action != positionAction.unplacable && !_stacked);
		}
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		if (_action == positionAction.hover)
		{
			switch (_style)
			{
			case nodeStyle.wallLeft:
				zero.x = -0.04f;
				zero2.y = -0.04f;
				break;
			case nodeStyle.wallRight:
				zero.x = 0.04f;
				zero2.y = -0.04f;
				break;
			default:
				if (m_hangerOverRack && _style == nodeStyle.rack)
				{
					zero.x = 0.01f;
					zero.y = 0.03f;
				}
				else if (m_hangerOverRack && _style == nodeStyle.rackFlipped)
				{
					zero.x = -0.01f;
					zero.y = 0.03f;
				}
				else if ((_style == nodeStyle.hanger || _style == nodeStyle.hangerFlipped) && m_hangerType == hangerType.bottom)
				{
					zero.y = -0.04f;
				}
				else if (m_stackID == stackId.bowl && _stacked != null)
				{
					zero.y = 0.09f;
				}
				else if (m_stackID == stackId.plantPot && _stacked != null)
				{
					zero.y = 0.21f;
				}
				else
				{
					zero.y = 0.04f;
				}
				break;
			}
		}
		if ((_style == nodeStyle.hanger || _style == nodeStyle.hangerFlipped) && m_hangerType == hangerType.bottom)
		{
			zero.z = 0.025f;
		}
		m_artPivot.localPosition = zero;
		if (isCombinable)
		{
			SetCombineMask((_stacked == null) ? null : _stacked.GetCombineMask());
		}
		if (m_rendererShadow != null)
		{
			if (_stacked != null && m_stackShadow)
			{
				zero2.z -= 0.003f;
			}
			else
			{
				zero2.z += m_shadowDepth;
			}
			m_rendererShadow.transform.localPosition = zero2;
		}
		ChangeCollision(flag);
		if (m_attachments != null && m_attachments.Length != 0)
		{
			Transform[] attachments = m_attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				attachmentBaseScript component = attachments[i].GetComponent<attachmentBaseScript>();
				component.ChangeValidity(_action == positionAction.placedValid);
				component.ChangePlaced(_action == positionAction.placedValid || _action == positionAction.placedInvalid);
			}
		}
	}

	public void Bounce(int _pixels)
	{
		Vector3 zero = Vector3.zero;
		zero.y = (float)_pixels * 0.01f;
		m_artPivot.localPosition = zero;
	}

	public void SetHover(bool _stacked)
	{
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		if (m_state == itemState.wallLeft)
		{
			zero.x = -0.04f;
			zero2.y = -0.04f;
		}
		else if (m_state == itemState.wallRight)
		{
			zero.x = 0.04f;
			zero2.y = -0.04f;
		}
		else if (m_state == itemState.rack)
		{
			zero.x = 0.01f;
			zero.y = 0.03f;
		}
		else if (m_state == itemState.rackFlipped)
		{
			zero.x = -0.01f;
			zero.y = 0.03f;
		}
		else if ((m_state == itemState.hanger || m_state == itemState.hangerFlipped) && m_hangerType == hangerType.bottom)
		{
			zero.y = -0.04f;
		}
		else if (m_stackID == stackId.bowl && _stacked)
		{
			zero.y = 0.09f;
		}
		else if (m_stackID == stackId.plantPot && _stacked)
		{
			zero.y = 0.21f;
		}
		else
		{
			zero.y = 0.04f;
		}
		if ((m_state == itemState.hanger || m_state == itemState.hangerFlipped) && m_hangerType == hangerType.bottom)
		{
			zero.z = 0.025f;
		}
		m_artPivot.localPosition = zero;
		if (m_rendererShadow != null)
		{
			if (_stacked && m_stackShadow)
			{
				zero2.z -= 0.003f;
			}
			else
			{
				zero2.z += m_shadowDepth;
			}
			m_rendererShadow.transform.localPosition = zero2;
		}
	}

	public void CursorPosition(Vector2 _position)
	{
		Transform[] attachments = m_attachments;
		for (int i = 0; i < attachments.Length; i++)
		{
			attachments[i].GetComponent<attachmentBaseScript>().NewPosition(_position);
		}
	}

	public bool IsComputer()
	{
		Transform[] attachments = m_attachments;
		for (int i = 0; i < attachments.Length; i++)
		{
			if (attachments[i].GetComponent<attachmentBaseScript>().computer)
			{
				return true;
			}
		}
		return false;
	}

	public computerScript GetComputer()
	{
		Transform[] attachments = m_attachments;
		for (int i = 0; i < attachments.Length; i++)
		{
			computerScript component = attachments[i].GetComponent<computerScript>();
			if (component != null)
			{
				return component;
			}
		}
		return null;
	}

	public bool IsProximity()
	{
		Transform[] attachments = m_attachments;
		for (int i = 0; i < attachments.Length; i++)
		{
			if (attachments[i].GetComponent<attachmentBaseScript>().proximity)
			{
				return true;
			}
		}
		return false;
	}

	public void DestroyItem()
	{
		if (m_shelf != null)
		{
			m_shelf.RemoveItem(this);
			m_shelf = null;
		}
		Transform transform = Parent();
		if (transform != null && transform.CompareTag("drawer"))
		{
			transform.GetComponent<drawerScript>().RemoveItem(this);
		}
		if (m_box != null)
		{
			m_box.RemoveContents(this);
		}
		PackMovableRemove();
		for (int i = 0; i < m_attachments.Length; i++)
		{
			attachmentBaseScript component = m_attachments[i].GetComponent<attachmentBaseScript>();
			if ((bool)component)
			{
				component.DestroyItem();
			}
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private bool StateHasArt()
	{
		bool result = false;
		switch (m_state)
		{
		case itemState.normal:
		case itemState.flipped:
			result = (bool)art.main || (bool)art.flipped;
			break;
		case itemState.reverse:
		case itemState.reverseFlipped:
			result = (bool)art.reverse || (bool)art.reverseFlipped;
			break;
		case itemState.wallRight:
		case itemState.wallLeft:
			result = (bool)art.wall || (bool)art.wallFlipped;
			break;
		case itemState.hooked:
		case itemState.hookedFlipped:
			result = (bool)art.hook || (bool)art.hookFlipped;
			break;
		case itemState.standing:
		case itemState.standingFlipped:
			result = (bool)art.standing || (bool)art.standingFlipped;
			break;
		case itemState.holder:
		case itemState.holderFlipped:
			result = (bool)art.holder || (bool)art.holderFlipped;
			break;
		case itemState.bar:
		case itemState.barFlipped:
			result = (bool)art.bar || (bool)art.barFlipped;
			break;
		case itemState.rack:
		case itemState.rackFlipped:
			result = (bool)art.rack || (bool)art.rackFlipped;
			break;
		case itemState.hanger:
		case itemState.hangerFlipped:
			result = (bool)art.hanger || (bool)art.hangerFlipped;
			break;
		case itemState.combined:
		case itemState.combinedFlipped:
			result = art.combined;
			break;
		}
		return result;
	}

	private bool StateHasShadow()
	{
		bool result = false;
		switch (m_state)
		{
		case itemState.normal:
		case itemState.flipped:
		case itemState.reverse:
		case itemState.reverseFlipped:
			result = (bool)art.mainShadow || (bool)art.flippedShadow || (bool)art.reverseShadow || (bool)art.reverseFlippedShadow;
			break;
		case itemState.wallRight:
		case itemState.wallLeft:
			result = (bool)art.wallShadow || (bool)art.wallFlippedShadow;
			break;
		case itemState.standing:
		case itemState.standingFlipped:
			result = (bool)art.standingShadow || (bool)art.standingFlippedShadow;
			break;
		case itemState.hooked:
		case itemState.hookedFlipped:
		case itemState.holder:
		case itemState.holderFlipped:
		case itemState.bar:
		case itemState.barFlipped:
		case itemState.rack:
		case itemState.rackFlipped:
		case itemState.hanger:
		case itemState.hangerFlipped:
			result = true;
			break;
		}
		return result;
	}

	private void GridValues(out int _xSize, out int _ySize, out int _size, out float _depthStep, out float _gridOffsetX, out float _gridOffsetY)
	{
		_depthStep = 0.07f;
		_gridOffsetX = 0f;
		_gridOffsetY = 0f;
		if (m_state == itemState.standing)
		{
			_xSize = m_xStanding;
			_ySize = m_yStanding;
			_size = m_sizeStanding;
		}
		else if (m_state == itemState.standingFlipped)
		{
			_xSize = m_yStanding;
			_ySize = m_xStanding;
			_size = m_sizeStanding;
		}
		else if (m_state == itemState.wallLeft)
		{
			_xSize = 1;
			_ySize = m_xWall;
			_size = m_yWall;
			_gridOffsetX = 0.07f;
			_gridOffsetY = -0.04f;
			_depthStep = 0.042f;
		}
		else if (m_state == itemState.wallRight)
		{
			_xSize = m_xWall;
			_ySize = 1;
			_size = m_yWall;
			_gridOffsetX = -0.07f;
			_gridOffsetY = -0.04f;
			_depthStep = 0.042f;
		}
		else if (m_state == itemState.hooked || m_state == itemState.hookedFlipped)
		{
			_xSize = 1;
			_ySize = 1;
			_size = m_sizeHook;
			_gridOffsetY = (float)(m_sizeHook - 3) * -0.17f;
		}
		else if (m_state == itemState.bar)
		{
			_xSize = 1;
			_ySize = m_barWidth;
			_size = m_sizeHanger;
			_gridOffsetY = (float)(m_sizeHanger - 1) * -0.17f - 0.07f;
		}
		else if (m_state == itemState.barFlipped)
		{
			_xSize = m_barWidth;
			_ySize = 1;
			_size = m_sizeHanger;
			_gridOffsetY = (float)(m_sizeHanger - 1) * -0.17f - 0.07f;
		}
		else if (m_state == itemState.rack || m_state == itemState.hanger)
		{
			_xSize = 1;
			_ySize = 3;
			_size = m_sizeHanger;
			_gridOffsetX = 0.14f;
			_gridOffsetY = (float)((m_state != itemState.hanger) ? 1 : m_sizeHanger) * -0.17f - 0.07f;
		}
		else if (m_state == itemState.rackFlipped || m_state == itemState.hangerFlipped)
		{
			_xSize = 3;
			_ySize = 1;
			_size = m_sizeHanger;
			_gridOffsetX = -0.14f;
			_gridOffsetY = (float)((m_state != itemState.hangerFlipped) ? 1 : m_sizeHanger) * -0.17f - 0.07f;
		}
		else
		{
			bool flag = m_state == itemState.flipped || m_state == itemState.reverseFlipped;
			_xSize = (flag ? m_yWidth : m_xWidth);
			_ySize = (flag ? m_xWidth : m_yWidth);
			_size = m_size;
		}
	}

	public void ShowGrid()
	{
		if ((bool)m_gridPivot)
		{
			UnityEngine.Object.Destroy(m_gridPivot.gameObject);
		}
		if ((bool)m_gridShadowPivot)
		{
			UnityEngine.Object.Destroy(m_gridShadowPivot.gameObject);
		}
		if ((bool)m_gridTextPivot)
		{
			UnityEngine.Object.Destroy(m_gridTextPivot.gameObject);
		}
		float num = 0f;
		bool flag = !StateHasArt();
		if (s_drawGrid || flag)
		{
			bool flag2 = (base.transform.parent != null && base.transform.parent.CompareTag("drawer")) || (m_stackParent != null && m_stackParent.Parent() != null && m_stackParent.Parent().CompareTag("drawer"));
			Color color = Color.white;
			if (m_display == displayType.unplacable)
			{
				color = new Color(1f, 1f, 1f, 0.5f);
			}
			Vector3 vector = new Vector3(0.14f, 0.07f);
			Vector3 vector2 = new Vector3(-0.14f, 0.07f);
			GridValues(out var _xSize, out var _ySize, out var _size, out var _depthStep, out var _gridOffsetX, out var _gridOffsetY);
			int num2 = Mathf.Max(_xSize, _ySize);
			int num3 = Mathf.Min(_xSize, _ySize);
			m_gridPivot = new GameObject("grid").transform;
			m_gridPivot.parent = m_artPivot;
			m_gridPivot.localScale = Vector3.one;
			m_gridPivot.localPosition = new Vector3(_gridOffsetX, _gridOffsetY, -0.001f);
			if (!Application.isPlaying)
			{
				m_gridPivot.gameObject.hideFlags = HideFlags.HideAndDontSave;
			}
			int num4 = ((m_foreground == 0) ? 99 : (m_foreground - 1));
			Transform original = (Transform)Resources.Load("gridtile_flat", typeof(Transform));
			Color color2 = m_drawColor * color;
			color2.a *= (flag ? 1f : 0.25f);
			if (m_state != itemState.wallLeft && m_state != itemState.wallRight)
			{
				for (int i = 0; i < _xSize; i++)
				{
					for (int j = 0; j < _ySize; j++)
					{
						int num5 = Mathf.Max(i, j) / num3 * num3;
						float num6 = (float)(num5 - (num3 - Mathf.Min(num3, num2 - num5))) * _depthStep;
						if (num5 >= num4)
						{
							num6 += 6f;
						}
						Transform obj = UnityEngine.Object.Instantiate(original, m_gridPivot, worldPositionStays: false);
						obj.localPosition = vector * i + vector2 * j + Vector3.up * _size * 0.17f + Vector3.forward * num6;
						SpriteRenderer component = obj.GetComponent<SpriteRenderer>();
						component.sharedMaterial = m_matGrid;
						component.color = color2;
						component.sortingOrder = m_sortingLayer;
						component.maskInteraction = (flag2 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
					}
				}
			}
			original = (Transform)Resources.Load("gridtile_vertical", typeof(Transform));
			if (m_state != itemState.wallLeft)
			{
				color2 = m_drawColor * new Color(0.5f, 0.5f, 0.5f) * color;
				color2.a *= (flag ? 1f : 0.25f);
				for (int k = 0; k < _xSize; k++)
				{
					int num7 = k / num3 * num3;
					float num8 = (float)(num7 - (num3 - Mathf.Min(num3, num2 - num7))) * _depthStep;
					if (num7 >= num4)
					{
						num8 += 6f;
					}
					num = Mathf.Max(num, num8);
					for (int l = 0; l < _size; l++)
					{
						Transform obj2 = UnityEngine.Object.Instantiate(original, m_gridPivot, worldPositionStays: false);
						obj2.localPosition = vector * k + Vector3.up * l * 0.17f + Vector3.forward * num8;
						SpriteRenderer component2 = obj2.GetComponent<SpriteRenderer>();
						component2.sharedMaterial = m_matGrid;
						component2.color = color2;
						component2.sortingOrder = m_sortingLayer;
						component2.maskInteraction = (flag2 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
					}
				}
			}
			if (m_state != itemState.wallRight)
			{
				color2 = m_drawColor * new Color(0.75f, 0.75f, 0.75f) * color;
				color2.a *= (flag ? 1f : 0.25f);
				for (int m = 0; m < _ySize; m++)
				{
					int num9 = m / num3 * num3;
					float num10 = (float)(num9 - (num3 - Mathf.Min(num3, num2 - num9))) * _depthStep;
					if (num9 >= num4)
					{
						num10 += 6f;
					}
					num = Mathf.Max(num, num10);
					for (int n = 0; n < _size; n++)
					{
						Transform obj3 = UnityEngine.Object.Instantiate(original, m_gridPivot, worldPositionStays: false);
						obj3.localPosition = vector2 * m + Vector3.up * n * 0.17f + Vector3.forward * num10;
						SpriteRenderer component3 = obj3.GetComponent<SpriteRenderer>();
						component3.sharedMaterial = m_matGrid;
						component3.color = color2;
						component3.flipX = true;
						component3.sortingOrder = m_sortingLayer;
						component3.maskInteraction = (flag2 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
					}
				}
			}
			if (flag)
			{
				SpriteMask[] mask = m_mask;
				for (int num11 = 0; num11 < mask.Length; num11++)
				{
					UnityEngine.Object.Destroy(mask[num11].gameObject);
				}
				m_mask = new SpriteMask[m_gridPivot.childCount];
				for (int num12 = 0; num12 < m_gridPivot.childCount; num12++)
				{
					GameObject gameObject = new GameObject("Mask");
					gameObject.transform.parent = m_artPivot;
					gameObject.transform.localPosition = m_gridPivot.GetChild(num12).localPosition + Vector3.forward * -0.005f;
					m_mask[num12] = gameObject.AddComponent<SpriteMask>();
					m_mask[num12].sprite = m_gridPivot.GetChild(num12).GetComponent<SpriteRenderer>().sprite;
					m_mask[num12].transform.localScale = new Vector3(m_gridPivot.GetChild(num12).GetComponent<SpriteRenderer>().flipX ? (-1f) : 1f, 1f, 1f);
					m_mask[num12].isCustomRangeActive = true;
					m_mask[num12].backSortingOrder = ((m_maskId != -1) ? 1 : 0);
					m_mask[num12].frontSortingOrder = m_maskFrontSortingOrder;
					gameObject.SetActive(m_maskId != 0);
				}
			}
		}
		else if (m_renderers.Length < 1)
		{
			Debug.LogWarning(base.name + " has art but no renderers!");
			num = 0f;
		}
		else
		{
			num = m_renderers[m_renderers.Length - 1].transform.localPosition.z;
		}
		if (!flag && m_mask.Length > 1)
		{
			for (int num13 = 0; num13 < m_mask.Length; num13++)
			{
				UnityEngine.Object.Destroy(m_mask[num13].gameObject);
			}
			m_mask = new SpriteMask[1];
			GameObject gameObject2 = new GameObject("Mask");
			gameObject2.transform.parent = m_artPivot;
			gameObject2.transform.localPosition = Vector3.forward * -0.005f;
			m_mask[0] = gameObject2.AddComponent<SpriteMask>();
			m_mask[0].isCustomRangeActive = true;
			m_mask[0].backSortingOrder = ((m_maskId != -1) ? 1 : 0);
			m_mask[0].frontSortingOrder = m_maskFrontSortingOrder;
			gameObject2.SetActive(m_maskId != 0);
		}
		if (s_drawText == 1 || (s_drawText == 0 && flag))
		{
			Color color3 = Color.white;
			if (m_display == displayType.unplacable)
			{
				color3 = new Color(1f, 1f, 1f, 0.5f);
			}
			m_gridTextPivot = new GameObject("text").transform;
			m_gridTextPivot.transform.parent = m_artPivot;
			m_gridTextPivot.localScale = Vector3.one;
			m_gridTextPivot.transform.localPosition = Vector3.up * ((float)(xWidth + yWidth) * 0.035f + (float)size * 0.08f - 0.07f);
			TextMesh textMesh = m_gridTextPivot.gameObject.AddComponent<TextMesh>();
			textMesh.color = color3;
			textMesh.anchor = TextAnchor.MiddleCenter;
			textMesh.alignment = TextAlignment.Center;
			textMesh.fontSize = 32;
			textMesh.characterSize = 0.03f;
			textMesh.offsetZ = -0.006f;
			textMesh.text = base.gameObject.name.Remove(0, 4).Replace("(Clone)", "") + (string.IsNullOrEmpty(art.name) ? "" : ("|" + art.name));
			textMesh.GetComponent<Renderer>().sortingOrder = m_sortingLayer;
		}
		if (StateHasShadow())
		{
			return;
		}
		bool flag3 = (base.transform.parent != null && base.transform.parent.CompareTag("drawer")) || (m_stackParent != null && m_stackParent.Parent() != null && m_stackParent.Parent().CompareTag("drawer"));
		GridValues(out var _xSize2, out var _ySize2, out var _size2, out var _, out var _gridOffsetX2, out var _gridOffsetY2);
		m_gridShadowPivot = new GameObject("grid").transform;
		m_gridShadowPivot.parent = base.transform;
		m_gridShadowPivot.localPosition = new Vector3(_gridOffsetX2, _gridOffsetY2, num + 0.005f);
		if (!Application.isPlaying)
		{
			m_gridShadowPivot.gameObject.hideFlags = HideFlags.HideAndDontSave;
		}
		if (m_state == itemState.wallLeft)
		{
			Transform original2 = (Transform)Resources.Load("gridtile_vertical", typeof(Transform));
			Vector3 vector3 = new Vector3(-0.14f, 0.07f);
			Vector3 vector4 = new Vector3(0f, 0.17f);
			Color color4 = new Color(0f, 0f, 0f, 0.25f);
			for (int num14 = 0; num14 < _ySize2; num14++)
			{
				for (int num15 = 0; num15 < _size2; num15++)
				{
					Transform obj4 = UnityEngine.Object.Instantiate(original2, m_gridShadowPivot, worldPositionStays: false);
					obj4.localPosition = vector3 * num14 + vector4 * num15;
					SpriteRenderer component4 = obj4.GetComponent<SpriteRenderer>();
					component4.color = color4;
					component4.flipX = true;
					component4.sortingOrder = m_sortingLayer;
					component4.maskInteraction = (flag3 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
				}
			}
		}
		else if (m_state == itemState.wallRight)
		{
			Transform original3 = (Transform)Resources.Load("gridtile_vertical", typeof(Transform));
			Vector3 vector5 = new Vector3(0.14f, 0.07f);
			Vector3 vector6 = new Vector3(0f, 0.17f);
			Color color5 = new Color(0f, 0f, 0f, 0.25f);
			for (int num16 = 0; num16 < _xSize2; num16++)
			{
				for (int num17 = 0; num17 < _size2; num17++)
				{
					Transform obj5 = UnityEngine.Object.Instantiate(original3, m_gridShadowPivot, worldPositionStays: false);
					obj5.localPosition = vector5 * num16 + vector6 * num17;
					SpriteRenderer component5 = obj5.GetComponent<SpriteRenderer>();
					component5.color = color5;
					component5.sortingOrder = m_sortingLayer;
					component5.maskInteraction = (flag3 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
				}
			}
		}
		else
		{
			Transform original4 = (Transform)Resources.Load("gridtile_flat", typeof(Transform));
			Vector3 vector7 = new Vector3(0.14f, 0.07f);
			Vector3 vector8 = new Vector3(-0.14f, 0.07f);
			Color color6 = new Color(0f, 0f, 0f, 0.25f);
			for (int num18 = 0; num18 < _xSize2; num18++)
			{
				for (int num19 = 0; num19 < _ySize2; num19++)
				{
					Transform obj6 = UnityEngine.Object.Instantiate(original4, m_gridShadowPivot, worldPositionStays: false);
					obj6.localPosition = vector7 * num18 + vector8 * num19;
					SpriteRenderer component6 = obj6.GetComponent<SpriteRenderer>();
					component6.color = color6;
					component6.sortingOrder = m_sortingLayer;
					component6.maskInteraction = (flag3 ? SpriteMaskInteraction.VisibleOutsideMask : SpriteMaskInteraction.None);
				}
			}
		}
		m_gridShadowPivot.gameObject.SetActive(m_showShadow);
	}

	public Bounds GetScreenBounds()
	{
		Collider2D component = GetComponent<Collider2D>();
		bool num = component.enabled;
		if (!num)
		{
			component.enabled = true;
		}
		Bounds bounds = component.bounds;
		if (!num)
		{
			component.enabled = false;
		}
		bounds.center = (Vector2)bounds.center;
		return bounds;
	}

	public void AudioLift(bool _lift)
	{
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		if (_lift)
		{
			if (m_state == itemState.wallLeft)
			{
				zero.x = -0.04f;
				zero2.y = -0.04f;
			}
			else if (m_state == itemState.wallRight)
			{
				zero.x = 0.04f;
				zero2.y = -0.04f;
			}
			else if (m_state == itemState.rack)
			{
				zero.x = 0.01f;
				zero.y = 0.03f;
			}
			else if (m_state == itemState.rackFlipped)
			{
				zero.x = -0.01f;
				zero.y = 0.03f;
			}
			else if (m_stackID == stackId.bowl && m_stackCount > 0)
			{
				zero.y = 0.09f;
			}
			else
			{
				zero.y = 0.04f;
			}
		}
		m_artPivot.localPosition = zero;
		if (m_rendererShadow != null)
		{
			m_rendererShadow.transform.localPosition = m_renderers[m_renderers.Length - 1].transform.localPosition + zero2;
		}
	}

	public bool MatchItem(string _name, int _variant)
	{
		if (base.name.Replace("(Clone)", "").Equals(_name) && (m_usesHolder || base.name.StartsWith("itemPhotoAlbum") || m_currentVariant.Equals(_variant)))
		{
			return true;
		}
		return false;
	}

	public saveData.saveDataItem GetSaveData(bool _movable)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_attachments.Length; i++)
		{
			attachmentBaseScript component = m_attachments[i].GetComponent<attachmentBaseScript>();
			if (component != null)
			{
				int[] attachmentValues = component.GetAttachmentValues();
				for (int j = 0; j < attachmentValues.Length; j++)
				{
					list.Add(attachmentValues[j]);
				}
			}
		}
		return new saveData.saveDataItem(Node(), m_stackCount, base.name.Replace("(Clone)", ""), m_currentVariant, _movable, (int)m_state, (int)m_lastFlatState, (int)m_pinState, (int[])m_pinTypes.Clone(), list.ToArray());
	}

	public void SetAttachmentStates(int[] _attachmentStates)
	{
		int num = 0;
		for (int i = 0; i < m_attachments.Length; i++)
		{
			attachmentBaseScript component = m_attachments[i].GetComponent<attachmentBaseScript>();
			if (component != null && component.attachmentValues > 0)
			{
				if (num + component.attachmentValues > _attachmentStates.Length)
				{
					Debug.LogWarning(base.name + " does not have enough attachments!");
					break;
				}
				int[] array = new int[component.attachmentValues];
				for (int j = 0; j < array.Length; j++)
				{
					array[j] = _attachmentStates[num];
					num++;
				}
				component.SetAttachmentValues(array);
			}
		}
	}
}
