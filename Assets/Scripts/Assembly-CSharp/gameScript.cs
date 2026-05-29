using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using uGIF;

public class gameScript : MonoBehaviour
{
	public enum musicPlayerId
	{
		player0 = 0,
		player1 = 1,
		player2 = 2
	}

	public enum gameState
	{
		play = 0,
		arrange = 1,
		pack = 2
	}

	public enum gamePhase
	{
		unpack = 0,
		validate = 1
	}

	public enum gameEndMode
	{
		unfinished = 0,
		allItemsValid = 1,
		noItemsValid = 2
	}

	private enum validationType
	{
		normal = 0,
		instant = 1,
		full = 2
	}

	[Serializable]
	public struct pinType
	{
		public Sprite sprite;

		public Color tint;
	}

	[Serializable]
	public struct floorplanData
	{
		public Sprite walls;

		public Sprite floor;

		public RectInt[] hitbox;

		public floorplanData(Sprite _walls, Sprite _floor)
		{
			walls = _walls;
			floor = _floor;
			hitbox = new RectInt[0];
		}
	}

	private enum selectionType
	{
		none = 0,
		occlusion = 1,
		occlusionDrawer = 2,
		box = 3,
		boxEmpty = 4,
		usableDrawer = 5,
		usableDoorHinge = 6,
		usableDoorSlide = 7,
		usableDoorFold = 8,
		usableGeneric = 9,
		gridFlat = 10,
		gridFlatFlipped = 11,
		gridLeft = 12,
		gridRight = 13,
		gridRack = 14,
		gridBar = 15,
		item = 16,
		itemStack = 17,
		itemStackFlipped = 18,
		itemHanger = 19,
		itemClothesOverHanger = 20,
		itemHangerOverClothes = 21,
		itemShelf = 22,
		itemCombine = 23,
		specialHook = 24,
		specialShelf = 25
	}

	private enum selectionState
	{
		none = 0,
		held = 1,
		raise = 2,
		chase = 3
	}

	public enum packShow
	{
		unboxed = 0,
		boxed = 1,
		unmovable = 2,
		movable = 3,
		boxes = 4
	}

	private enum tutorialState
	{
		none = 0,
		showing = 1,
		complete = 2
	}

	public enum ha
	{
		changeZone = 1,
		boxOpen = 2,
		boxTake = 3,
		boxClear = 4,
		itemRotate = 5,
		itemInteract = 6,
		itemPickUp = 7,
		itemPlace = 8,
		itemShelf = 9,
		stageUse = 10
	}

	[Serializable]
	public struct historyEvent
	{
		private byte action;

		private short value;

		public historyEvent(ha _action, int _value)
		{
			action = (byte)_action;
			value = (short)_value;
		}

		public ha Action()
		{
			return (ha)action;
		}

		public int Value()
		{
			return value;
		}
	}

	[Serializable]
	public struct MatchReplace
	{
		public string m_sourceName;

		public int m_sourceVariant;

		public string m_replaceName;

		public int m_replaceVariant;
	}

	private enum validationEffect
	{
		none = 0,
		show = 1,
		appear = 2,
		zoneChange = 3,
		quickFade = 4
	}

	public struct matchItem
	{
		public itemScript item;

		public int zone;

		public Vector2 position;

		public zoneScript.itemNode.nodeStyle style;

		public zoneScript.itemNode.nodeType type;

		public matchItem(itemScript _item, int _zone, Vector2 _position, zoneScript.itemNode.nodeStyle _style, zoneScript.itemNode.nodeType _type)
		{
			item = _item;
			zone = _zone;
			position = _position;
			style = _style;
			type = _type;
		}
	}

	public string m_fallbackAudioItem = "Mug";

	[HideInInspector]
	public itemScript.audioID m_fallbackAudioID;

	private radioToggleScript m_musicPlayer;

	private GameObject m_musicPlayerGO;

	private uint m_musicPlayerId;

	private bool m_gameActive = true;

	private bool m_gameTimeActive;

	private bool m_gamePanActive = true;

	private bool m_interfaceActive = true;

	private bool m_audioMusicShuffle;

	private float m_playtime;

	[Space(15f)]
	public gameUIScript m_uiScript;

	public RectTransform m_uiNode;

	public RectTransform m_uiNodePage;

	public float m_audioWheelSize = 35f;

	public float m_audioWheelSize2 = 35f;

	public float m_audioWheelHeight = 25f;

	public float m_audioWheelFloorOffset;

	private Transform m_audioWheel;

	private Vector3[] m_audioWheelPosition;

	private List<GameObject> m_audioRaised = new List<GameObject>();

	private Transform m_keepAlive;

	private itemScript m_audioLiftItem;

	private float m_audioLiftTimer;

	public float m_audioLiftTime = 1f;

	private bool m_audioLiftLifted;

	private List<itemScript> m_itemBounce = new List<itemScript>();

	private gameState m_state;

	private gamePhase m_phase;

	private bool m_endModeActive;

	private float m_endModeTimer;

	private gameEndMode m_endMode;

	[HideInInspector]
	public bool m_editorOverGUI;

	private bool m_useTempSave;

	private bool m_darkStarValid;

	private bool m_itemsValidAnywhere;

	private bool m_queueEvaulateStar;

	public RectTransform[] m_scaleNodes;

	private float m_zoomOrthoBase = 2.7f;

	private float m_aspectRatio = 1f;

	private float m_pixelSize = 1f;

	private float m_zoom = 1f;

	private float m_zoomTarget = 1f;

	private float m_photoZoom;

	private int m_zoomLevel;

	private int m_zoomLevelMin = -1;

	private int m_zoomLevelMax = 2;

	private float m_zoomTargetMin = 0.5f;

	public CanvasScaler m_canvas;

	private float m_unscaleSize = 1f;

	private uiCursor m_cursor;

	public Button[] m_zoneChangeDisable;

	public uiZoneChangeButtons m_zoneChangeButton;

	private bool m_photoModeAppear;

	public Gradient m_photoModeAppearEffect;

	private float m_photoModeAppearLerp;

	public Button m_photomodeButton;

	public Button m_floorplanButton;

	public uiCompleteScript m_completeButton;

	private bool m_completeTriggered;

	private bool m_completeLoadWindow;

	public RectTransform m_touchControls;

	public RectTransform[] m_touchControlsItems;

	public Button[] m_buttons;

	public Button[] m_buttonsBright;

	public Button[] m_buttonsZoom;

	public Graphic[] m_graphics;

	public UnityEngine.UI.Image m_zoomOut;

	private bool m_zoomOutOffscreenInvalid;

	private bool m_zoneHintCountdown;

	private float m_zoneHintTimer;

	public Button m_ValidateButton;

	public Sprite[] m_ValidateButtonArt;

	private bool m_zoomPinchApplied;

	private float m_zoomPinch;

	private Vector2 m_zoomPinchPos = Vector2.zero;

	private float m_zoomPinchDistance;

	private Vector2 m_zoomShift = Vector2.zero;

	private Vector2 m_zoomShiftOrigin = Vector2.zero;

	private Vector2 m_zoomShiftOrtho = Vector2.one;

	private bool m_zoomShiftActive;

	private bool m_inputIgnoreRelease;

	private bool m_inputIgnoreRestOfTouch;

	private float m_inputDragDistance;

	private float m_inputDragScrollDistance;

	[Tooltip("Ratio of screen height that an item must drag to allow place on release")]
	[Range(0f, 1f)]
	public float m_itemTapDragReleaseDistanceRatio = 0.1f;

	[Tooltip("If checked, will time how long touch is down before allowing place on release")]
	public bool m_itemTapLiftCancel = true;

	[Tooltip("On touch down on item, how long before allowing place on release")]
	[Range(0f, 3f)]
	public float m_itemTapLiftDuration = 0.1f;

	private float m_itemTapLiftTimer;

	private bool m_inputTapPrime;

	private bool m_inputRotate;

	private bool m_inputUI;

	private Vector2 m_inputTouchPosition = Vector2.zero;

	private int m_inputTouchNode = -1;

	[Header("Motion Controls")]
	public Button m_motionControlButton;

	public Button m_motionCenterButton;

	public UnityEngine.UI.Image m_motionCenterIcon;

	public Sprite[] m_motionCenterIcons;

	private string m_itemRefreshOld = "";

	private string m_itemRefreshNew = "";

	public int m_year;

	public float[] m_yearPos;

	public float m_yearRootPos;

	public statsScript.stickers m_stickerOnComplete;

	public floorplanData[] m_floorplanData;

	[Header("WWise Events")]
	public string m_audioLevelName;

	public string m_audioDateWrite;

	private uint m_audioDateWriteID;

	[Space(10f)]
	public string m_audioLevelAppear = "Play_intro_trans_gameplay_whoosh";

	private uint m_audioLevelAppearID;

	public string m_audioZoneChange;

	public string m_audioTurnItem;

	public string m_audioOpenBox = "Play_box_open";

	public string m_audioCloseBox = "Play_box_close";

	public string m_audioPinboard;

	public string m_audioPhotomodeUnlock;

	public string m_audioStickerUnlock;

	public string m_audioValidationAppear;

	public string m_audioTouchControlsShow;

	public string m_audioTouchControlsCancel;

	[Space(10f)]
	[Header("Complete")]
	public string m_audioCompleteAppear;

	public string m_audioCompleteCancel;

	public string m_audioCompleteAction;

	public string m_audioCompleteAppearSimple = "complete_sparkle";

	public string m_audioCompleteCancelSimple = "complete_sparkle_stop";

	[Space(10f)]
	[Header("Complete (Dark)")]
	public string m_audioDCompleteAppear;

	public string m_audioDCompleteCancel;

	public string m_audioDCompleteAction;

	public string m_audioDCompleteAppearSimple;

	public string m_audioDCompleteCancelSimple;

	public Sprite m_grid;

	public Sprite m_gridVertical;

	public Sprite m_join;

	public bool m_cameraTrack = true;

	private bool m_cameraTrackArmed;

	private Vector3 m_cameraOffset = Vector3.zero;

	private Transform m_checkerBackground;

	[Space(10f)]
	public pinType[] m_pinboardPins;

	public pinType[] m_fridgeMagnets;

	[Space(10f)]
	public itemScript[] m_itemTypes;

	[HideInInspector]
	public int[] m_itemTypesTime;

	public Transform m_selectLinePrefab;

	private bool m_selectRepeat = true;

	private int m_selectCurrent = -1;

	private int m_selectCurrentVariant;

	private itemScript m_selectCurrentItem;

	private selectionState m_selectCurrentState;

	private bool m_selectCurrentDelayedLift;

	private Transform m_selectCurrentCollider;

	private PolygonCollider2D m_selectCurrentColliderPoly;

	private CapsuleCollider2D m_selectCurrentColliderCapsule;

	private Vector2[] m_selectCurrentBezier;

	private boxScript m_selectCurrentBezierBox;

	private float m_selectCurrentBezierLerp;

	private float m_selectCurrentBezierSpeed = 3f;

	private float m_selectCurrentBezierPower = 1f;

	private itemScript m_editCurrentItem;

	private bool m_showValidGrid;

	private itemScript m_showValidGridPrevious;

	private bool m_showValidGridCreate;

	private zoneScript.zoneKitchen m_showValidGridKitchen;

	private zoneScript.zoneBedroom m_showValidGridBedroom;

	private zoneScript.zoneBathroom m_showValidGridBathroom;

	private zoneScript.zoneLivingRoom m_showValidGridLivingRoom;

	private zoneScript.zoneDiningRoom m_showValidGridDiningRoom;

	private zoneScript.zoneOffice m_showValidGridOffice;

	private zoneScript.zoneNursery m_showValidGridNursery;

	private zoneScript.zoneWall m_showValidGridWall;

	private int m_selectCurrentUnpackMode;

	private bool[] m_selectCurrentShow = new bool[5];

	public boxScript[] m_boxTypes;

	private int m_selectCurrentBoxIndex = -1;

	private boxScript m_selectCurrentBox;

	private boxScript m_editCurrentBox;

	private int m_editCurrentBoxItemIndex;

	private int m_lastNode = -1;

	private shelfStandScript m_lastShelf;

	public Transform m_boxParticles;

	public zoneScript[] m_zones;

	private int m_currentZone;

	private int m_currentStage;

	[Space(10f)]
	[Header("Reverb")]
	public string m_reverbKitchen;

	public string m_reverbBedroom;

	public string m_reverbLivingroom;

	public string m_reverbBathroom;

	public string m_reverbDiningroom;

	public string m_reverbOffice;

	public string m_reverbNursery;

	public string m_reverbCloset;

	public string m_reverbToilet;

	public string m_reverbFoyer;

	private Transform m_unboxed;

	private bool m_appearValid;

	private Vector3 m_appearValidPos = Vector3.zero;

	private Vector3 m_offset = Vector3.zero;

	private RaycastHit2D[] m_rayhits;

	private bool m_zoneChangeFade;

	private bool m_zoneChange;

	private int m_zoneChangePrevious;

	private int m_zoneChangeDirection;

	private bool m_zoneChangeHorizontal = true;

	private float m_zoneChangeLerp;

	private Color m_zoneChangeColorStart;

	private Color m_zoneChangeColorEnd;

	public AnimationCurve m_zoneChangeAnim;

	private Vector2 m_zoneChangePosStart;

	private Vector2 m_zoneChangePosEnd;

	public Material[] m_materials;

	public GameObject[] m_completeDisable;

	public GameObject[] m_completeEnable;

	public string m_nextStage;

	public Transform m_linePrefab;

	private tutorialState m_tutorialTurn;

	private float m_tutorialTurnLerp = -6f;

	private tutorialState m_tutorialZoneChange;

	public UnityEngine.UI.Image m_tutorialTurnArt;

	public GameObject[] m_tutorialTurnParts;

	private bool m_tutorialTurnFade;

	public AnimationCurve m_dateNodeCurve;

	private bool m_dateNodeActive;

	public Transform m_dateNodePrefab;

	private Transform m_dateNode;

	private float m_dateNodeTime;

	private timeOfDayScript m_todScript;

	private stickerUnlockScript m_stickerUnlock;

	private List<Sprite> m_stickerUnlockList = new List<Sprite>();

	private int m_stickerLastUnlock = -1;

	private float m_stickerUnlockDelay;

	private bool m_historyRecord = true;

	private List<historyEvent> m_history = new List<historyEvent>();

	private saveData.saveDataZone[] m_historyZones = new saveData.saveDataZone[0];

	private bool m_playbackMode;

	private bool m_playbackModeActive;

	private bool m_playbackAnimate;

	private bool m_playbackZoneChange;

	private bool m_playbackRapid;

	private historyEvent[] m_playbackArray;

	private int m_playbackStep;

	private bool m_playbackRepeat;

	private float m_playbackTimer;

	private int m_playbackTimerFrames;

	private int m_playbackHoverHold;

	private bool m_playbackUseWait;

	private float m_playbackLength;

	private float m_playbackTotalTime;

	private int m_playbackTOD;

	public Transform m_encodePrefab;

	private encodeScreenScript m_encodeScreen;

	private capture m_playbackCapture;

	private int m_playbackCaptureZone;

	private videoRecordScript m_playbackRecord;

	private int m_playbackLastPickup = -1;

	private int m_playbackLastShelfIndex = -2;

	private int m_maxHistory;

	private const int c_maxHistoryPerZone = 900;

	[Space(10f)]
	[Header("Stage Match")]
	public string[] m_stageMatchIgnoreItems;

	public MatchReplace[] m_stageMatchReplace;

	public MatchReplace[] m_stageMatchMimic;

	[Header("Validation Effect")]
	public AnimationCurve m_validationSizeCurve;

	public AnimationCurve m_validationPulse;

	public float m_validationPulseRate = 1f;

	private cameraOverlayScript m_validationOverlay;

	private validationEffect m_validation;

	private float m_validationValue;

	private float m_validationPhase;

	private int m_validationShaderColorId;

	private int m_validationShaderOutlineId;

	public Color[] m_validationColors;

	public bool musicPlayers => m_musicPlayer != null;

	public bool gameActive => m_gameActive;

	public Transform audioWheel => m_audioWheel;

	public List<GameObject> audioRaised => m_audioRaised;

	public Transform keepAlive => m_keepAlive;

	public bool showInvalid
	{
		get
		{
			if (m_phase == gamePhase.validate)
			{
				return m_endMode == gameEndMode.unfinished;
			}
			return false;
		}
	}

	public bool tempStage => m_useTempSave;

	public float zoomTargetMin => m_zoomTargetMin;

	public bool interfaceActive
	{
		get
		{
			return m_interfaceActive;
		}
		set
		{
			m_interfaceActive = value;
		}
	}

	public bool gamePan
	{
		set
		{
			m_gamePanActive = value;
		}
	}

	public gameState state
	{
		get
		{
			return m_state;
		}
		set
		{
			gameState num = m_state;
			m_state = value;
			if (num == m_state)
			{
				return;
			}
			if ((bool)m_selectCurrentItem)
			{
				m_selectCurrentItem.DestroyItem();
				m_selectCurrentItem = null;
				selectCollisionSet(null);
				m_selectCurrentState = selectionState.none;
			}
			if ((bool)m_selectCurrentBox)
			{
				m_selectCurrentBox.DestroyBox();
			}
			m_selectCurrent = -1;
			if (m_state != gameState.pack)
			{
				if (m_editCurrentBox != null)
				{
					m_editCurrentBox.SetEdit(_value: false);
				}
				m_editCurrentBox = null;
			}
			int currentZone = m_currentZone;
			switch (m_state)
			{
			case gameState.play:
			{
				for (int k = 0; k < m_zones.Length; k++)
				{
					m_currentZone = k;
					m_zones[k].LoadItems();
				}
				m_currentZone = currentZone;
				m_phase = gamePhase.unpack;
				SetValidation(validationEffect.none);
				m_validationOverlay.editor = false;
				ConfigureZoneButtons(_active: false);
				bool flag = true;
				for (int l = 0; l < m_zones.Length; l++)
				{
					if (m_zones[l].BoxesRemain())
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					phase = gamePhase.validate;
				}
				break;
			}
			case gameState.arrange:
			{
				for (int i = 0; i < m_zones.Length; i++)
				{
					m_currentZone = i;
					m_zones[i].LoadItems();
				}
				m_currentZone = currentZone;
				for (int j = 0; j < m_zones.Length; j++)
				{
					m_zones[j].ConnectZonePackedItems();
				}
				m_endMode = gameEndMode.unfinished;
				m_completeButton.Active(gameEndMode.unfinished);
				m_phase = gamePhase.unpack;
				SetValidation(validationEffect.none);
				m_validationOverlay.editor = true;
				ConfigureZoneButtons(_active: false);
				break;
			}
			}
		}
	}

	public gamePhase phase
	{
		get
		{
			return m_phase;
		}
		set
		{
			if (value == m_phase)
			{
				return;
			}
			m_phase = value;
			switch (m_phase)
			{
			case gamePhase.unpack:
				m_endMode = gameEndMode.unfinished;
				m_completeButton.Active(gameEndMode.unfinished);
				SetValidation(validationEffect.none);
				ConfigureZoneButtons(_active: false);
				m_endModeActive = false;
				break;
			case gamePhase.validate:
				if (m_state == gameState.play)
				{
					EvaluateStar();
				}
				else
				{
					SetValidation(validationEffect.show);
				}
				break;
			}
		}
	}

	public bool selectRepeat
	{
		get
		{
			return m_selectRepeat;
		}
		set
		{
			if (m_selectRepeat != value)
			{
				m_selectRepeat = value;
			}
		}
	}

	public bool itemHeld => m_selectCurrentState == selectionState.held;

	public int selectItem
	{
		get
		{
			return m_selectCurrent;
		}
		set
		{
			if (m_selectCurrent == value)
			{
				return;
			}
			m_selectCurrent = value;
			m_selectCurrentVariant = 0;
			if (m_selectCurrent < -1)
			{
				m_selectCurrent = m_itemTypes.Length - 1;
			}
			else if (m_selectCurrent >= m_itemTypes.Length)
			{
				m_selectCurrent = -1;
			}
			if ((bool)m_selectCurrentItem)
			{
				m_selectCurrentItem.DestroyItem();
			}
			if (m_selectCurrent != -1)
			{
				m_selectCurrentItem = UnityEngine.Object.Instantiate(m_itemTypes[m_selectCurrent]);
				m_selectCurrentState = selectionState.held;
				m_selectCurrentItem.SetState(0);
				selectCollisionSet(m_selectCurrentItem);
				if (m_selectCurrentItem.isStandable)
				{
					ShelfOffset(m_selectCurrentItem);
				}
				if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
				{
					zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
				}
				m_offset = Vector3.zero;
			}
			else
			{
				if (m_selectCurrentItem != null)
				{
					zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: false);
				}
				m_selectCurrentItem = null;
				selectCollisionSet(null);
				m_selectCurrentState = selectionState.none;
				ShelfOffset(0);
				m_lastShelf = null;
			}
		}
	}

	public bool IsItemHeld => m_selectCurrentState == selectionState.held;

	public int currentStage => m_currentStage;

	public zoneScript zone => m_zones[m_currentZone];

	public int zoneIndex => m_currentZone;

	public uint reverbID => zone.reverbID;

	public bool zoneChangeFade
	{
		set
		{
			m_zoneChangeFade = value;
		}
	}

	public bool IsDateNodeActive => m_dateNodeActive;

	private bool audioLift => m_audioLiftItem != null;

	private void MusicPlayerCallback(object in_cookie, AkCallbackType in_type, object in_info)
	{
		if (in_type == AkCallbackType.AK_MusicSyncExit)
		{
			SetMusicState("gameplay");
			MusicPlayerStop();
		}
	}

	public void MusicPlayerStart(radioToggleScript _musicPlayer, musicPlayerId _playerId)
	{
		if (m_musicPlayer != null)
		{
			m_musicPlayer.Stop();
		}
		if (m_musicPlayerGO == null)
		{
			m_musicPlayerGO = new GameObject("musicPlayer");
			if (!m_playbackMode || m_playbackAnimate)
			{
				m_musicPlayerId = AkSoundEngine.PostEvent("MusicPlayer", m_musicPlayerGO, 2048u, MusicPlayerCallback, null);
			}
		}
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(m_musicPlayerGO, akAuxSendArray, 1u);
		m_musicPlayer = _musicPlayer;
		Transform obj = m_musicPlayerGO.transform;
		obj.parent = _musicPlayer.transform;
		obj.localPosition = Vector3.zero;
		obj.localRotation = Quaternion.identity;
		if (!m_playbackMode || m_playbackAnimate)
		{
			SetMusicState("radio");
			AkSoundEngine.SetSwitch("Music_Player_Switch", _playerId.ToString(), m_musicPlayerGO);
		}
		obj.parent = m_audioWheel;
	}

	public void MusicPlayerPlace(bool _value)
	{
		if (_value)
		{
			m_musicPlayerGO.transform.parent = m_audioWheel;
			if (audioRaised.Contains(m_musicPlayerGO))
			{
				audioRaised.Remove(m_musicPlayerGO);
			}
			return;
		}
		Transform obj = m_musicPlayerGO.transform;
		obj.parent = m_musicPlayer.transform;
		obj.localPosition = Vector3.zero;
		obj.localRotation = Quaternion.identity;
		if (!audioRaised.Contains(m_musicPlayerGO))
		{
			audioRaised.Add(m_musicPlayerGO);
		}
	}

	public void MusicPlayerStop()
	{
		SetMusicState("gameplay");
		if (m_musicPlayer != null)
		{
			m_musicPlayer.Stop(m_musicPlayerGO);
			m_musicPlayer = null;
		}
		else
		{
			Debug.LogWarning("MusicPlayerStop called with no musicplayer script");
		}
		if (m_musicPlayerGO != null)
		{
			m_musicPlayerGO.transform.parent = null;
		}
		else
		{
			Debug.LogWarning("MusicPlayerStop called with no musicplayer gameobject");
		}
	}

	public void MusicShuffle(bool _value)
	{
		m_audioMusicShuffle = _value;
		AkSoundEngine.GetState("Music_State", out var out_rState);
		if (_value)
		{
			if (out_rState.Equals(AkSoundEngine.GetIDFromString("gameplay")))
			{
				AkSoundEngine.SetState("Music_State", "gameplay_random");
			}
			else if (out_rState.Equals(AkSoundEngine.GetIDFromString("radio")))
			{
				AkSoundEngine.SetState("Music_State", "radio_random");
			}
		}
		else if (out_rState.Equals(AkSoundEngine.GetIDFromString("gameplay_random")))
		{
			AkSoundEngine.SetState("Music_State", "gameplay");
		}
		else if (out_rState.Equals(AkSoundEngine.GetIDFromString("radio_random")))
		{
			AkSoundEngine.SetState("Music_State", "radio");
		}
	}

	public void SetMusicState(string _state)
	{
		if (m_audioMusicShuffle)
		{
			if (_state == "gameplay")
			{
				_state = "gameplay_random";
			}
			else if (_state == "radio")
			{
				_state = "radio_random";
			}
		}
		AkSoundEngine.SetState("Music_State", _state);
	}

	public float GetPixelSize()
	{
		return m_pixelSize;
	}

	public float GetZoom()
	{
		return m_zoom;
	}

	public void GameActive(bool _value)
	{
		GameActive(_value, _value);
	}

	public void GameActive(bool _value, bool _timeActive)
	{
		m_gameActive = _value;
		m_gameTimeActive = _value || _timeActive;
		if (m_selectCurrentState == selectionState.chase || m_selectCurrentState == selectionState.held)
		{
			m_selectCurrentItem.gameObject.SetActive(m_gameActive);
		}
		if (m_todScript != null)
		{
			m_todScript.enabled = m_gameTimeActive;
		}
		if (m_gameActive && m_queueEvaulateStar)
		{
			m_queueEvaulateStar = false;
			CancelStar();
			EvaluateStar();
		}
		if (m_phase == gamePhase.validate && m_endMode == gameEndMode.unfinished)
		{
			SetValidation(m_gameActive ? validationEffect.show : validationEffect.none);
		}
		bool flag = m_endMode == gameEndMode.noItemsValid;
		AkSoundEngine.SetState("Game_State", (!m_gameTimeActive) ? "paused" : (flag ? "darkstar" : "gameplay"));
		RefreshCursorState();
	}

	public void ValidateToggle()
	{
		phase = ((phase == gamePhase.unpack) ? gamePhase.validate : gamePhase.unpack);
		m_ValidateButton.image.sprite = m_ValidateButtonArt[(phase != gamePhase.validate) ? 1 : 0];
		PlayAudio((phase == gamePhase.validate) ? m_uiScript.m_audioValidateOn : m_uiScript.m_audioValidateOff);
		bool flag = m_endMode == gameEndMode.noItemsValid;
		AkSoundEngine.SetState("Game_State", flag ? "darkstar" : "gameplay");
		AkSoundEngine.SetRTPCValue("music_pitch", flag ? 0.5f : 1f);
	}

	public bool photomodeActive()
	{
		return m_photomodeButton.gameObject.activeSelf;
	}

	public bool floorplanActive()
	{
		return m_floorplanButton.gameObject.activeSelf;
	}

	public void ReloadLevel()
	{
		saveData.DiscardTemp();
		m_completeButton.Active(gameEndMode.unfinished);
		AkSoundEngine.PostEvent("Stop_Ambience", base.gameObject);
		gameStateScript.LoadSceneFade(SceneManager.GetActiveScene().name, 0.25f);
	}

	public void Rotate()
	{
		if (m_selectCurrentItem != null)
		{
			if (m_selectCurrentDelayedLift)
			{
				m_selectCurrentDelayedLift = false;
				LiftItem();
				PositionTouchControls();
			}
			m_inputRotate = true;
			m_inputUI = true;
		}
	}

	public void Interact()
	{
		if (!(m_selectCurrentItem != null) || !m_selectCurrentDelayedLift)
		{
			return;
		}
		int num = m_selectCurrentItem.InteractFull();
		if (num > 0)
		{
			int itemIndex = zone.GetItemIndex(m_selectCurrentItem);
			for (int i = 0; i < num; i++)
			{
				HistoryRecord(ha.itemInteract, itemIndex);
			}
			FileSaveAction();
		}
		CancelDelayLift();
		HideTouchControls();
		m_inputUI = true;
	}

	public void InputUI()
	{
		m_inputUI = true;
	}

	private void EndModeStart()
	{
		m_endModeActive = true;
		m_endModeTimer = 1.25f;
		if (gameStateScript.GameClear())
		{
			m_ValidateButton.interactable = false;
			m_ValidateButton.gameObject.SetActive(value: true);
			PlayAudio(m_uiScript.m_audioValidateAppear);
		}
	}

	private void PlayAudio(string _audio)
	{
		if (!string.IsNullOrEmpty(_audio))
		{
			AkSoundEngine.PostEvent(_audio, base.gameObject);
		}
	}

	private bool EvaluatePlants()
	{
		for (int i = 0; i < m_zones.Length; i++)
		{
			if (!m_zones[i].IsAllPlantsValid())
			{
				return false;
			}
		}
		return true;
	}

	private void EvaluateStar()
	{
		if (m_selectCurrentItem == null)
		{
			bool flag = true;
			bool flag2 = true;
			for (int i = 0; i < m_zones.Length; i++)
			{
				flag &= m_zones[i].isZoneValid;
				flag2 &= m_zones[i].isZoneInvalid;
			}
			if (flag || m_itemsValidAnywhere)
			{
				if (m_completeLoadWindow)
				{
					SetCompleteTriggered();
				}
				m_endMode = gameEndMode.allItemsValid;
				m_completeButton.Active(m_endMode);
			}
			else if (m_darkStarValid && flag2)
			{
				if (m_completeLoadWindow)
				{
					SetCompleteTriggered();
				}
				m_endMode = gameEndMode.noItemsValid;
				m_completeButton.Active(m_endMode);
			}
		}
		else if (m_endMode != gameEndMode.unfinished)
		{
			m_endMode = gameEndMode.unfinished;
			m_completeButton.Active(m_endMode);
		}
		SetValidation((m_endMode == gameEndMode.unfinished) ? validationEffect.appear : validationEffect.none);
		bool flag3 = m_endMode == gameEndMode.noItemsValid;
		AkSoundEngine.SetState("Game_State", flag3 ? "darkstar" : "gameplay");
		AkSoundEngine.SetRTPCValue("music_pitch", flag3 ? 0.5f : 1f);
		if (m_zones.Length > 1)
		{
			ConfigureZoneButtons(m_endMode == gameEndMode.unfinished);
		}
	}

	private void CancelStar()
	{
		if (m_endMode != gameEndMode.unfinished)
		{
			m_endMode = gameEndMode.unfinished;
			m_completeButton.Active(m_endMode);
			AkSoundEngine.SetState("Game_State", "gameplay");
			AkSoundEngine.SetRTPCValue("music_pitch", 1f);
			SetValidation(validationEffect.show);
			if (m_zones.Length > 1)
			{
				ConfigureZoneButtons(_active: true);
			}
		}
	}

	private void SetValidation(validationEffect _effect)
	{
		if (m_itemsValidAnywhere || m_endMode != gameEndMode.unfinished)
		{
			_effect = validationEffect.none;
		}
		if (m_validation != _effect && (m_validation != validationEffect.show || _effect != validationEffect.appear) && (m_validation != validationEffect.zoneChange || _effect != validationEffect.show))
		{
			m_validation = _effect;
			m_validationValue = 0f;
			m_validationOverlay.enabled = m_validation != validationEffect.none;
			if (m_validation == validationEffect.appear)
			{
				AkSoundEngine.PostEvent(m_audioValidationAppear, base.gameObject);
				Vibration(vibrationScript.moment.validationActivate);
				m_validationPhase = 0f;
			}
			else
			{
				Shader.SetGlobalFloat(m_validationShaderOutlineId, 0.01f);
			}
		}
	}

	public bool GetUnpackShow(packShow _category)
	{
		return m_selectCurrentShow[(int)_category];
	}

	private bool IsGrid(selectionType _selection)
	{
		if (_selection != selectionType.gridFlat && _selection != selectionType.gridFlatFlipped && _selection != selectionType.gridLeft && _selection != selectionType.gridRight && _selection != selectionType.gridRack)
		{
			return _selection == selectionType.gridBar;
		}
		return true;
	}

	private bool IsStack(selectionType _selection)
	{
		if (_selection != selectionType.itemStack && _selection != selectionType.itemStackFlipped && _selection != selectionType.itemClothesOverHanger && _selection != selectionType.itemHangerOverClothes)
		{
			return _selection == selectionType.itemCombine;
		}
		return true;
	}

	private bool isItem(selectionType _selection)
	{
		if (_selection != selectionType.item && _selection != selectionType.itemStack && _selection != selectionType.itemStackFlipped && _selection != selectionType.itemHanger && _selection != selectionType.itemClothesOverHanger && _selection != selectionType.itemHangerOverClothes && _selection != selectionType.itemShelf)
		{
			return _selection == selectionType.itemCombine;
		}
		return true;
	}

	private bool IsUsable(selectionType _selection)
	{
		if (_selection != selectionType.usableDrawer && _selection != selectionType.usableDoorHinge && _selection != selectionType.usableDoorSlide && _selection != selectionType.usableDoorFold && _selection != selectionType.usableGeneric)
		{
			return _selection == selectionType.boxEmpty;
		}
		return true;
	}

	private bool IsPlacable(selectionType _selection)
	{
		if (!IsGrid(_selection) && !IsStack(_selection) && _selection != selectionType.itemHanger && _selection != selectionType.itemShelf && _selection != selectionType.specialHook)
		{
			return _selection == selectionType.specialShelf;
		}
		return true;
	}

	private bool IsNothing(selectionType _selection)
	{
		if (_selection != selectionType.none && _selection != selectionType.occlusion)
		{
			return _selection == selectionType.occlusionDrawer;
		}
		return true;
	}

	public uint GetReverb(zoneScript.zoneType _type)
	{
		uint result = 0u;
		switch (_type)
		{
		case zoneScript.zoneType.kitchen:
			result = AkSoundEngine.GetIDFromString(m_reverbKitchen);
			break;
		case zoneScript.zoneType.bedroom:
			result = AkSoundEngine.GetIDFromString(m_reverbBedroom);
			break;
		case zoneScript.zoneType.livingroom:
			result = AkSoundEngine.GetIDFromString(m_reverbLivingroom);
			break;
		case zoneScript.zoneType.bathroom:
			result = AkSoundEngine.GetIDFromString(m_reverbBathroom);
			break;
		case zoneScript.zoneType.diningroom:
			result = AkSoundEngine.GetIDFromString(m_reverbDiningroom);
			break;
		case zoneScript.zoneType.office:
			result = AkSoundEngine.GetIDFromString(m_reverbOffice);
			break;
		case zoneScript.zoneType.nursery:
			result = AkSoundEngine.GetIDFromString(m_reverbNursery);
			break;
		case zoneScript.zoneType.closet:
			result = AkSoundEngine.GetIDFromString(m_reverbCloset);
			break;
		case zoneScript.zoneType.toilet:
			result = AkSoundEngine.GetIDFromString(m_reverbToilet);
			break;
		case zoneScript.zoneType.foyer:
			result = AkSoundEngine.GetIDFromString(m_reverbFoyer);
			break;
		}
		return result;
	}

	public int GetLastStickerUnlock()
	{
		int stickerLastUnlock = m_stickerLastUnlock;
		m_stickerLastUnlock = -1;
		return stickerLastUnlock;
	}

	private void HistoryRecord(ha _action, int _value, int _node = -1)
	{
		if (m_history.Count >= m_maxHistory || !m_historyRecord)
		{
			return;
		}
		bool flag = true;
		switch (_action)
		{
		case ha.stageUse:
			if (m_history.Count > 0 && m_history[m_history.Count - 1].Action() == ha.stageUse && m_history[m_history.Count - 1].Value() == _value)
			{
				m_history.RemoveAt(m_history.Count - 1);
				flag = false;
			}
			break;
		case ha.changeZone:
			if (m_history.Count <= 0 || m_history[m_history.Count - 1].Action() != ha.changeZone)
			{
				break;
			}
			if (m_history[m_history.Count - 1].Value() + _value == 0)
			{
				m_history.RemoveAt(m_history.Count - 1);
				flag = false;
				break;
			}
			_value += m_history[m_history.Count - 1].Value();
			if (_value >= m_zones.Length)
			{
				_value -= m_zones.Length;
			}
			else if (_value <= -m_zones.Length)
			{
				_value += m_zones.Length;
			}
			m_history.RemoveAt(m_history.Count - 1);
			if (_value == 0)
			{
				flag = false;
			}
			break;
		case ha.itemRotate:
			if (m_selectCurrentItem.m_flipType != itemScript.flipType.none && m_history[m_history.Count - 1].Action() == ha.itemRotate)
			{
				_value += m_history[m_history.Count - 1].Value();
				m_history.RemoveAt(m_history.Count - 1);
			}
			break;
		case ha.itemPickUp:
			if (zone.IsItemLastAddition(m_selectCurrentItem))
			{
				m_playbackLastPickup = _node;
				m_playbackLastShelfIndex = (m_selectCurrentItem.isOnShelf ? (m_selectCurrentItem.stackCount - 1) : (-2));
			}
			else
			{
				m_playbackLastPickup = -1;
				m_playbackLastShelfIndex = -2;
			}
			break;
		case ha.itemPlace:
			if (m_playbackLastPickup > -1 && m_playbackLastShelfIndex == -2 && m_history[m_history.Count - 1].Action() == ha.itemPickUp && m_playbackLastPickup == _value)
			{
				m_playbackLastPickup = -1;
				m_playbackLastShelfIndex = -2;
				m_history.RemoveAt(m_history.Count - 1);
				flag = false;
			}
			else if (m_playbackLastPickup > -1 && m_history[m_history.Count - 1].Action() == ha.itemShelf && m_history[m_history.Count - 2].Action() == ha.itemPickUp && m_playbackLastPickup == _value && m_playbackLastShelfIndex == m_history[m_history.Count - 1].Value())
			{
				m_playbackLastPickup = -1;
				m_playbackLastShelfIndex = -2;
				m_history.RemoveAt(m_history.Count - 1);
				m_history.RemoveAt(m_history.Count - 1);
				flag = false;
			}
			m_playbackLastPickup = -1;
			break;
		}
		if (flag)
		{
			m_history.Add(new historyEvent(_action, _value));
		}
		gameStateScript.GameAction();
	}

	private void Vibration(vibrationScript.moment _moment, float _pan = 0.5f)
	{
		if (!m_playbackMode)
		{
			vibrationScript.Trigger(_moment, _pan);
		}
	}

	private void selectCollisionInit()
	{
		GameObject gameObject = new GameObject("selectCollision");
		m_selectCurrentCollider = gameObject.transform;
		m_selectCurrentColliderCapsule = gameObject.AddComponent<CapsuleCollider2D>();
		m_selectCurrentColliderPoly = gameObject.AddComponent<PolygonCollider2D>();
		m_selectCurrentColliderCapsule.enabled = false;
		m_selectCurrentColliderPoly.enabled = false;
	}

	private void selectCollisionSet(itemScript _item)
	{
		if (_item == null)
		{
			m_selectCurrentColliderCapsule.enabled = false;
			m_selectCurrentColliderPoly.enabled = false;
			return;
		}
		PolygonCollider2D component = _item.GetComponent<PolygonCollider2D>();
		if (component != null)
		{
			m_selectCurrentColliderPoly.points = component.points;
			m_selectCurrentColliderPoly.offset = component.offset;
			m_selectCurrentColliderCapsule.enabled = false;
			m_selectCurrentColliderPoly.enabled = true;
			return;
		}
		CapsuleCollider2D component2 = _item.GetComponent<CapsuleCollider2D>();
		if ((bool)component2)
		{
			m_selectCurrentColliderCapsule.size = component2.size;
			m_selectCurrentColliderCapsule.direction = component2.direction;
			m_selectCurrentColliderCapsule.offset = component2.offset;
			m_selectCurrentColliderCapsule.enabled = true;
			m_selectCurrentColliderPoly.enabled = false;
		}
		else
		{
			m_selectCurrentColliderCapsule.enabled = false;
			m_selectCurrentColliderPoly.enabled = false;
		}
	}

	public void SetResolution(int _width, int _height)
	{
		float num = (float)_height / 200f;
		int num2 = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num2 == 1 && _width >= 1280 && _height >= 720)
		{
			num2 = 2;
		}
		m_zoomOrthoBase = num / (float)num2;
		m_aspectRatio = (float)_width / (float)_height;
		m_pixelSize = num2;
		GetComponent<Camera>().orthographicSize = m_zoomOrthoBase / m_zoom;
		SetIconSize();
		m_zoomLevelMin = ((num2 > 1) ? (-1) : 0);
		if (m_zoomLevelMin == -1)
		{
			float num3 = 1f / (float)num2;
			for (m_zoomTargetMin = 0f; m_zoomTargetMin < 0.5f; m_zoomTargetMin += num3)
			{
			}
		}
		Zoom(0);
		float t = Mathf.InverseLerp(360f, 540f, _height / num2);
		Vector2 sizeDelta = m_uiNode.sizeDelta;
		sizeDelta.y = Mathf.Round(Mathf.Lerp(356f, 468f, t));
		m_uiNode.sizeDelta = sizeDelta;
		Vector2 sizeDelta2 = m_uiNodePage.sizeDelta;
		sizeDelta2.y = Mathf.Round(Mathf.Lerp(220f, 340f, t));
		m_uiNodePage.sizeDelta = sizeDelta2;
		photoBorderSizeScript componentInChildren = m_uiScript.m_screens[3].GetComponentInChildren<photoBorderSizeScript>();
		if (componentInChildren != null)
		{
			componentInChildren.SetSize();
		}
		m_uiScript.m_screens[1].GetComponent<uiGameMenuScript>().FixMouse();
	}

	public void SetIconSize()
	{
		int accessSetting = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.iconsize);
		m_canvas.scaleFactor = m_pixelSize + (float)accessSetting;
		m_unscaleSize = 1f - (float)accessSetting / (m_pixelSize + (float)accessSetting);
		for (int i = 0; i < m_scaleNodes.Length; i++)
		{
			m_scaleNodes[i].localScale = Vector3.one * m_unscaleSize;
		}
		if (m_zoomOrthoBase / (float)(accessSetting + 1) <= 0.6f)
		{
			m_zoneChangeButton.Shift(5f);
		}
		else
		{
			m_zoneChangeButton.Shift(0f);
		}
	}

	public void SetInvalidHighlight()
	{
		m_validationColors[1] = gameStateScript.GetValidationColor();
	}

	public void SetItemsValidAnywhere()
	{
		bool flag = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.itemsanywhere) > 0;
		if (flag == m_itemsValidAnywhere)
		{
			return;
		}
		m_itemsValidAnywhere = flag;
		if (m_phase == gamePhase.validate)
		{
			if (m_gameActive)
			{
				CancelStar();
				EvaluateStar();
			}
			else
			{
				m_queueEvaulateStar = true;
			}
		}
	}

	private void Start()
	{
		m_maxHistory = 900 * m_zones.Length;
		m_cursor = gameStateScript.GetCursor();
		m_validationOverlay = GetComponent<cameraOverlayScript>();
		m_validationShaderColorId = Shader.PropertyToID("_OutlineColor");
		m_validationShaderOutlineId = Shader.PropertyToID("_OutlineSize");
		m_audioMusicShuffle = gameStateScript.AudioShuffle;
		selectCollisionInit();
		SetIconSize();
		m_zoneChangeFade = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.zonefade) > 0;
		SetItemsValidAnywhere();
		SetInvalidHighlight();
		for (int i = 0; i < m_selectCurrentShow.Length; i++)
		{
			m_selectCurrentShow[i] = true;
		}
		m_checkerBackground = base.transform.Find("background");
		itemScript.InitMaterials(m_materials);
		SetResolution(Screen.width, Screen.height);
		if (string.IsNullOrEmpty(m_audioLevelName))
		{
			m_audioLevelName = SceneManager.GetActiveScene().name;
		}
		AkSoundEngine.SetState("Level_State", "_" + m_audioLevelName);
		GameActive(_value: true);
		if (int.TryParse(SceneManager.GetActiveScene().name.Substring(0, 1), out var result))
		{
			m_currentStage = Mathf.Clamp(result - 1, 0, 8);
		}
		m_darkStarValid = saveData.DarkStarValid(m_currentStage);
		m_itemsValidAnywhere = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.itemsanywhere) > 0;
		SetInvalidHighlight();
		GetComponent<Camera>().backgroundColor = zone.m_color;
		zone.SetOutlineColor(zone.m_color);
		if (m_zones.Length < 2)
		{
			m_zoneChangeButton.Disable();
		}
		else
		{
			m_zoneChangeButton.SetInitial(m_zones[m_zones.Length - 1].m_type, m_zones[1].m_type);
			m_zoneChangeButton.Hide();
		}
		SetButtonColor(zone.m_color);
		m_rayhits = new RaycastHit2D[10];
		if (!saveData.StickerUnlocked(0))
		{
			m_photomodeButton.gameObject.SetActive(value: false);
		}
		if (m_floorplanData == null || m_floorplanData.Length == 0)
		{
			m_floorplanButton.gameObject.SetActive(value: false);
		}
		else if (!gameStateScript.tutorialFloorplan)
		{
			m_zoneChangeButton.FloorplanTutorial();
		}
		m_audioWheel = new GameObject("audioWheel").transform;
		m_audioWheel.position = Vector3.forward * (base.transform.localPosition.z - m_audioWheelSize);
		int[] array = new int[2];
		for (int j = 0; j < m_zones.Length; j++)
		{
			array[m_zones[j].m_floorplanFloor]++;
		}
		m_audioWheelPosition = new Vector3[m_zones.Length];
		for (int k = 0; k < m_audioWheelPosition.Length; k++)
		{
			int floorplanFloor = m_zones[k].m_floorplanFloor;
			int num = -1;
			for (int l = 0; l < m_zones.Length; l++)
			{
				if (m_zones[l].m_floorplanFloor == floorplanFloor)
				{
					num++;
				}
				if (l == k)
				{
					break;
				}
			}
			float num2 = 360f / (float)array[floorplanFloor];
			m_audioWheelPosition[k] = new Vector3(Mathf.Repeat((float)num * (0f - num2) + ((floorplanFloor == 0) ? 0f : m_audioWheelFloorOffset), 360f), (float)floorplanFloor * (0f - m_audioWheelHeight), (floorplanFloor == 0) ? (0f - m_audioWheelSize) : (0f - m_audioWheelSize2));
		}
		m_keepAlive = new GameObject("keepalive").transform;
		m_keepAlive.position = Vector3.up * -100f;
		int num3 = 0;
		int currentZone = m_currentZone;
		for (int m = 0; m < m_zones.Length; m++)
		{
			m_currentZone = m;
			SetAudioWheel(m);
			GameObject obj = m_zones[m].gameObject;
			bool activeSelf = obj.activeSelf;
			obj.SetActive(value: true);
			m_zones[m].reverbID = GetReverb(m_zones[m].m_type);
			m_zones[m].Init(this);
			m_zones[m].LoadItems();
			num3 += m_zones[m].GetFullItemCount();
			obj.SetActive(activeSelf);
		}
		m_currentZone = currentZone;
		SetAudioWheel(0);
		m_todScript = UnityEngine.Object.FindObjectOfType<timeOfDayScript>();
		if ((bool)m_todScript)
		{
			m_todScript.SetItemFull(num3);
		}
		m_stickerUnlock = base.gameObject.GetComponentInChildren<stickerUnlockScript>(includeInactive: true);
		m_stickerUnlock.Init(this);
		TurnTutorialSetup();
		zone.SetAmbience(base.gameObject);
		int num4 = gameStateScript.IsPlaybackStage();
		if (num4 > 0)
		{
			if (m_zoomOrthoBase <= 2f)
			{
				m_zoom = (m_zoomTarget = m_zoomTargetMin);
				GetComponent<Camera>().orthographicSize = m_zoomOrthoBase / m_zoom;
			}
			switch (num4)
			{
			case 1:
				AkSoundEngine.SetState("Game_State", "replay_gif");
				break;
			case 2:
				AkSoundEngine.SetState("Game_State", "replay");
				break;
			case 3:
				AkSoundEngine.SetState("Game_State", "replay_mp4");
				break;
			}
			m_gameActive = false;
			m_playbackMode = true;
			m_playbackModeActive = true;
			m_playbackAnimate = num4 > 1;
			m_historyRecord = false;
			itemScript.s_touchMode = false;
			m_cursor.IsConfined = false;
			if (!gameStateScript.CompareChecksums(m_currentStage, _strict: true))
			{
				LoadAlbum();
				return;
			}
			SetMusicState("gameplay");
			AkSoundEngine.PostEvent("Play_Ambience", base.gameObject);
			m_uiScript.DisableInterface();
			m_cursor.ShowCursor(_value: false);
			HistoryLoadZones(saveData.GetStage(m_currentStage).historyZones);
			m_playbackArray = saveData.GetStage(m_currentStage).history;
			m_playbackLength = PlaybackLength();
			m_playbackTOD = saveData.GetStage(m_currentStage).tod;
			if (m_playbackAnimate)
			{
				if (num4 == 3)
				{
					m_playbackRecord = base.gameObject.AddComponent<videoRecordScript>();
					m_playbackRecord.StartRecording();
				}
				Time.timeScale = (new float[4] { 1f, 2f, 4f, 8f })[Mathf.Clamp(gameStateScript.playbackSpeed, 1, 4) - 1];
				AkSoundEngine.SetRTPCValue("replay_speed", Mathf.Clamp(gameStateScript.playbackSpeed, 1, 4));
			}
			else
			{
				m_playbackRapid = gameStateScript.playbackSpeed > 3;
				m_cameraOffset = zone.m_zoneBounds.center;
				Vector3 localPosition = m_cameraOffset + Vector3.forward * -35f;
				localPosition.x = Mathf.Round(localPosition.x * 100f) / 100f;
				localPosition.y = Mathf.Round(localPosition.y * 100f) / 100f;
				base.transform.localPosition = localPosition;
				m_playbackCaptureZone = saveData.GetStage(m_currentStage).zone;
				m_playbackCapture = base.gameObject.AddComponent<capture>();
				GameObject.Find("grad").SetActive(value: false);
				if (m_playbackCaptureZone == m_currentZone)
				{
					m_playbackCapture.CaptureNext();
				}
				AkSoundEngine.SetRTPCValue("replay_speed", 4f);
				m_todScript.HideSunbeams();
			}
		}
		else if (gameStateScript.IsLoadStage())
		{
			if (!gameStateScript.CompareChecksums(m_currentStage))
			{
				gameStateScript.albumPage = m_currentStage;
				gameStateScript.SetAlbumSaveError();
				gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
				return;
			}
			m_useTempSave = saveData.TempStageActive(m_currentStage);
			SetMusicState("gameplay");
			AkSoundEngine.PostEvent("Play_Ambience", base.gameObject);
			FileLoad();
			if (m_history.Count == 0)
			{
				m_historyZones = new saveData.saveDataZone[m_zones.Length];
				for (int n = 0; n < m_zones.Length; n++)
				{
					m_historyZones[n] = m_zones[n].GetSaveData();
				}
			}
			GetComponent<Animation>().Play("post_fadeupFast");
			m_zoneChangeButton.Show(_instant: true);
			RefreshCursorState(attemptForceCenter: true);
			if (m_phase == gamePhase.validate && gameStateScript.GameClear())
			{
				m_ValidateButton.gameObject.SetActive(value: true);
			}
		}
		else
		{
			if (m_currentStage == 6)
			{
				MatchItemsToStage(5);
			}
			if (m_year != 0)
			{
				DateNodeStart();
				m_cameraOffset = zone.m_zoneBounds.center;
				UpdateCamera();
			}
			else
			{
				SetMusicState("gameplay");
				AkSoundEngine.PostEvent("Play_Ambience", base.gameObject);
				m_zoneChangeButton.Show(_instant: true);
				FileSaveAction();
			}
		}
		if (num4 == 0)
		{
			saveData.SetResume(m_currentStage);
		}
		RefreshCursorState(attemptForceCenter: true);
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
	}

	private void OnDestroy()
	{
		AkSoundEngine.SetState("Game_State", "gameplay");
		AkSoundEngine.ResetRTPCValue("music_pitch");
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
		AkSoundEngine.StopPlayingID(m_musicPlayerId);
		itemScript.s_touchMode = false;
	}

	private void OnControllerInputTypeChanged()
	{
		if (inputHandler.Instance == null)
		{
			return;
		}
		if (m_tutorialTurn != tutorialState.complete)
		{
			ConfigureTurnTutorial();
		}
		RefreshCursorState();
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
		{
			m_zoneChangeButton.Fix();
		}
		if (m_selectCurrentItem != null)
		{
			if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
			{
				m_inputTouchPosition = Camera.main.WorldToScreenPoint(m_selectCurrentItem.transform.position + m_selectCurrentItem.VisualOffset() + m_offset);
			}
			else if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad)
			{
				inputHandler.CursorPosition = m_inputTouchPosition;
			}
		}
	}

	private void ConfigureTurnTutorial()
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
		{
			m_tutorialTurnParts[0].SetActive(value: true);
			m_tutorialTurnParts[1].SetActive(value: false);
			return;
		}
		m_tutorialTurnParts[0].SetActive(value: false);
		Sprite[] array = inputHandler.Instance.QueryInputActionIconTutorial(InputAction.Gameplay_TurnAndInteract);
		if (array != null && array.Length != 0 && array[0] != null)
		{
			m_tutorialTurnParts[1].GetComponent<UnityEngine.UI.Image>().sprite = array[0];
			m_tutorialTurnParts[1].SetActive(value: true);
		}
		else
		{
			m_tutorialTurnParts[1].SetActive(value: false);
		}
	}

	private void RefreshCursorState(bool attemptForceCenter = false)
	{
		if (m_playbackModeActive)
		{
			return;
		}
		m_cursor.Behaviour = ((m_gameActive || m_dateNodeActive) ? uiCursor.CursorBehaviour.Custom : uiCursor.CursorBehaviour.Default);
		switch (inputHandler.CurrentControllerInputType)
		{
		case inputHandler.ControllerInputType.Keyboard:
			m_cursor.ShowCursor(_value: true);
			break;
		case inputHandler.ControllerInputType.Gamepad:
			if (attemptForceCenter)
			{
				inputHandler.Instance?.CenterCursor();
			}
			m_cursor.ShowCursor(m_gameActive && !m_dateNodeActive);
			if (m_selectCurrentDelayedLift)
			{
				m_selectCurrentDelayedLift = false;
				LiftItem();
			}
			m_inputTouchNode = -1;
			m_inputIgnoreRelease = false;
			HideTouchControls();
			break;
		case inputHandler.ControllerInputType.Touch:
			m_cursor.ShowCursor(_value: false);
			TutorialTurnHide();
			break;
		}
		m_cursor.IsConfined = m_gameActive;
	}

	public void DateNodeStart()
	{
		if (m_dateNodePrefab == null)
		{
			SetMusicState("gameplay");
			return;
		}
		SetMusicState("intro");
		m_dateNodeActive = true;
		if (gameStateScript.IsFromStage())
		{
			GetComponent<Animation>().Play("post_fadeupFlash");
		}
		else
		{
			GetComponent<Animation>().Play();
		}
		m_dateNode = UnityEngine.Object.Instantiate(m_dateNodePrefab).Find("date");
		m_dateNode.GetComponent<dateAnimateScript>().SetDate(m_year, m_yearPos, m_yearRootPos);
		m_dateNode.parent.GetComponent<Camera>().orthographicSize = GetComponent<Camera>().orthographicSize;
		Vector3 localPosition = zone.transform.localPosition;
		localPosition.y -= 9f;
		zone.transform.localPosition = localPosition;
		RefreshCursorState();
	}

	private void TurnTutorialSetup()
	{
		if (gameStateScript.tutorialTurn)
		{
			m_tutorialTurn = tutorialState.complete;
		}
		else
		{
			ConfigureTurnTutorial();
		}
		if (gameStateScript.tutorialZoneChange)
		{
			m_tutorialZoneChange = tutorialState.complete;
		}
	}

	private void UpdateCamera()
	{
		Vector3 localPosition = m_cameraOffset + Vector3.forward * -35f;
		if (!m_zoomShiftActive)
		{
			localPosition.x = Mathf.Round(localPosition.x * 100f) / 100f;
			localPosition.y = Mathf.Round(localPosition.y * 100f) / 100f;
		}
		base.transform.localPosition = localPosition;
		float num = ((m_zoneChange && !m_zoneChangeFade) ? (m_zoneChangeAnim.Evaluate(m_zoneChangeLerp) * (float)m_zoneChangeDirection * 6.4f * 4f) : 0f);
		Vector2 vector = (m_zoneChangeHorizontal ? (Vector2.right * num) : (Vector2.up * num));
		m_checkerBackground.localPosition = new Vector3(Mathf.Repeat(Mathf.Round((m_cameraOffset.x + vector.x) * -0.1f * 100f) / 100f, 0.64f), Mathf.Repeat(Mathf.Round((m_cameraOffset.y + vector.y) * -0.1f * 100f) / 100f, 0.64f), 40f);
		if (m_validation != validationEffect.zoneChange || m_validationValue > 1f)
		{
			bool flag = false;
			if (m_validation != validationEffect.none && zone.CheckOffscreenInvalid())
			{
				flag = true;
			}
			if (m_zoomOutOffscreenInvalid != flag)
			{
				m_zoomOut.material = (flag ? m_zoneChangeButton.m_materials[1] : m_zoneChangeButton.m_materials[0]);
				m_zoomOutOffscreenInvalid = flag;
			}
		}
	}

	public Vector2 PanCamera(Vector2 _pan)
	{
		if (_pan.Equals(Vector2.zero))
		{
			UpdateCamera();
			return Vector2.zero;
		}
		Vector4 vector = ZoneBound();
		Vector2 vector2 = (Vector2)m_cameraOffset + _pan;
		vector2.x = Mathf.Clamp(vector2.x, vector.x, vector.z);
		vector2.y = Mathf.Clamp(vector2.y, vector.y, vector.w);
		Vector3 localPosition = (Vector3)vector2 + Vector3.forward * -35f;
		localPosition.x = Mathf.Round(localPosition.x * 100f) / 100f;
		localPosition.y = Mathf.Round(localPosition.y * 100f) / 100f;
		Vector2 result = vector2 - (Vector2)m_cameraOffset;
		base.transform.localPosition = localPosition;
		m_checkerBackground.localPosition = new Vector3(Mathf.Repeat(Mathf.Round(m_cameraOffset.x * -0.1f * 100f) / 100f - result.x, 0.64f), Mathf.Repeat(Mathf.Round(m_cameraOffset.y * -0.1f * 100f) / 100f - result.y, 0.64f), 40f);
		return result;
	}

	public void ZoomIn()
	{
		Zoom(1);
		m_inputUI = true;
	}

	public void ZoomOut()
	{
		Zoom(-1);
		m_inputUI = true;
	}

	private void Zoom(int _change)
	{
		if (!interfaceActive)
		{
			return;
		}
		m_zoomLevel = Mathf.Clamp(m_zoomLevel + _change, m_zoomLevelMin, m_zoomLevelMax);
		m_buttonsZoom[0].interactable = m_zoomLevel < m_zoomLevelMax;
		m_buttonsZoom[1].interactable = m_zoomLevel > m_zoomLevelMin;
		m_zoomTarget = ((m_zoomLevel >= 0) ? Mathf.Pow(2f, m_zoomLevel) : m_zoomTargetMin);
		if (m_validationOverlay != null)
		{
			m_validationOverlay.SetPixelSize(Mathf.RoundToInt(Mathf.Min(m_pixelSize, m_pixelSize * m_zoomTarget)));
			if (!Mathf.Approximately(m_zoom, m_zoomTarget))
			{
				m_validationOverlay.enabled = false;
			}
		}
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
		{
			Touch[] touches = inputHandler.Touches;
			if (touches.Length == 2)
			{
				SetZoomShift(Camera.main.ScreenToWorldPoint((touches[0].position + touches[1].position) * 0.5f), m_zoom, m_zoomTarget);
			}
			else if (m_selectCurrentState == selectionState.held)
			{
				Collider2D component = m_selectCurrentItem.GetComponent<Collider2D>();
				bool flag = component.enabled;
				component.enabled = true;
				Vector2 vector = component.bounds.min;
				Vector2 vector2 = component.bounds.max;
				Vector2 zero = Vector2.zero;
				component.enabled = flag;
				zero.x = ((Mathf.Abs(vector.x - m_cameraOffset.x) > Mathf.Abs(vector2.x - m_cameraOffset.x)) ? vector.x : vector2.x);
				zero.y = ((Mathf.Abs(vector.y - m_cameraOffset.y) > Mathf.Abs(vector2.y - m_cameraOffset.y)) ? vector.y : vector2.y);
				SetZoomShift(zero, m_zoom, m_zoomTarget);
				HideTouchControls();
			}
		}
		else if (!EventSystem.current.IsPointerOverGameObject())
		{
			SetZoomShift(Camera.main.ScreenToWorldPoint(inputHandler.CursorPosition), m_zoom, m_zoomTarget);
		}
		if (!Mathf.Approximately(m_photoZoom, 0f))
		{
			GetComponent<Camera>().orthographicSize = m_zoomOrthoBase / m_photoZoom;
		}
	}

	public void PhotoZoom(float _zoom)
	{
		m_photoZoom = _zoom;
		GetComponent<Camera>().orthographicSize = m_zoomOrthoBase / (Mathf.Approximately(m_photoZoom, 0f) ? m_zoom : m_photoZoom);
	}

	private void SetZoomShift(Vector2 _position, float _zoomCurrent, float _zoomTarget)
	{
		if (_zoomCurrent != _zoomTarget)
		{
			float num = _zoomCurrent / _zoomTarget;
			Debug.DrawRay(_position, Vector3.up * 0.15f, Color.red, 10f);
			Debug.DrawRay(m_cameraOffset, Vector3.up * 0.15f, Color.blue, 10f);
			Debug.DrawLine(_position, m_cameraOffset, Color.blue, 10f);
			Vector2 vector = (Vector2)m_cameraOffset - _position;
			vector *= num;
			m_zoomShift = _position + vector;
			float num2 = m_zoomOrthoBase / _zoomTarget;
			float num3 = num2 * m_aspectRatio;
			Vector4 vector2 = ZoneBound();
			if (zone.m_zoneBounds.extents.y < num2)
			{
				m_zoomShift.y = zone.m_zoneBounds.center.y;
			}
			else if (m_zoomShift.y < vector2.y + num2 - 0.001f)
			{
				m_zoomShift.y = vector2.y + num2;
			}
			else if (m_zoomShift.y > vector2.w - num2 + 0.001f)
			{
				m_zoomShift.y = vector2.w - num2;
			}
			if (zone.m_zoneBounds.extents.x < num3)
			{
				m_zoomShift.x = zone.m_zoneBounds.center.x;
			}
			else if (m_zoomShift.x < vector2.x + num3 - 0.001f)
			{
				m_zoomShift.x = vector2.x + num3;
			}
			else if (m_zoomShift.x > vector2.z - num3 + 0.001f)
			{
				m_zoomShift.x = vector2.z - num3;
			}
			Debug.DrawRay(m_zoomShift, Vector3.up * 0.15f, Color.magenta, 10f);
			Debug.DrawRay(m_zoomShift, Vector3.right * 0.15f, Color.magenta, 10f);
			Debug.DrawRay(m_zoomShift, Vector3.up * -0.15f, Color.magenta, 10f);
			Debug.DrawRay(m_zoomShift, Vector3.right * -0.15f, Color.magenta, 10f);
			Debug.DrawLine(_position, m_zoomShift, Color.magenta, 10f);
			m_zoomShiftOrigin = m_cameraOffset;
			m_zoomShiftOrtho.x = m_zoomOrthoBase / _zoomCurrent;
			m_zoomShiftOrtho.y = m_zoomOrthoBase / _zoomTarget;
			m_zoomShiftActive = true;
		}
	}

	public bool CompleteButtonSound()
	{
		return !m_completeTriggered;
	}

	public void SetCompleteTriggered()
	{
		m_completeTriggered = true;
	}

	private float PlaybackLength()
	{
		float num = 0f;
		for (int i = 0; i < m_playbackArray.Length; i++)
		{
			ha ha2 = m_playbackArray[i].Action();
			float num2 = PlaybackActionTime(ha2);
			if (ha2 == ha.boxTake || ha2 == ha.itemPickUp)
			{
				num2 = Mathf.Max(0f, 0.33333f - NextPlaybackItemTime(i));
			}
			num += num2;
			if (ha2 == ha.itemShelf)
			{
				i++;
			}
		}
		return num;
	}

	private float PlaybackActionTime(ha _action)
	{
		float result = 0.125f;
		switch (_action)
		{
		case ha.changeZone:
			result = 1f;
			break;
		case ha.boxOpen:
			result = 0.75f;
			break;
		case ha.boxTake:
			result = 0.33333f;
			break;
		case ha.boxClear:
			result = 0.9f;
			break;
		case ha.itemRotate:
			result = 0.25f;
			break;
		case ha.itemPickUp:
			result = 0.33333f;
			break;
		case ha.itemPlace:
			result = 0.0666f;
			break;
		case ha.itemShelf:
			result = 0.25f;
			break;
		case ha.stageUse:
			result = 0.4f;
			break;
		}
		return result;
	}

	public void EncodeFinish(string _url)
	{
		if (m_encodeScreen != null)
		{
			m_encodeScreen.Finish(m_playbackAnimate, _url);
		}
		m_playbackModeActive = false;
		RefreshCursorState(attemptForceCenter: true);
	}

	public void PlaybackReturn()
	{
		AkSoundEngine.PostEvent("Stop_Ambience", base.gameObject);
		gameStateScript.albumPage = m_currentStage;
		gameStateScript.SetAlbumLoadGame();
		gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
	}

	private void PlaybackUpdate()
	{
		m_playbackRepeat = false;
		if (m_playbackStep > m_playbackArray.Length)
		{
			return;
		}
		if (inputHandler.IsPressed(InputAction.Gameplay_Menu))
		{
			if ((bool)m_playbackRecord && m_playbackRecord.isActive)
			{
				m_playbackRecord.StopRecording();
			}
			Time.timeScale = 1f;
			AkSoundEngine.SetRTPCValue("replay_speed", 1f);
			PlaybackReturn();
			m_playbackStep = m_playbackArray.Length + 1;
			return;
		}
		bool flag = false;
		if (m_playbackAnimate)
		{
			m_playbackTotalTime += Time.deltaTime;
			if (m_playbackAnimate && m_todScript != null)
			{
				m_todScript.SetSaveData((int)(m_playbackTotalTime / m_playbackLength * (float)m_playbackTOD));
			}
			m_playbackTimer -= Time.deltaTime;
			if (m_playbackTimer <= 0f)
			{
				if (m_playbackUseWait && zone.PlaybackMoving())
				{
					m_playbackTimer = 0f;
				}
				else
				{
					m_playbackUseWait = false;
					flag = true;
				}
			}
			if (m_playbackHoverHold == 0)
			{
				m_playbackHoverHold = 1;
			}
		}
		else
		{
			m_playbackTimerFrames--;
			if (m_playbackTimerFrames <= 0)
			{
				flag = true;
			}
		}
		if (flag)
		{
			if (m_playbackStep == m_playbackArray.Length)
			{
				if ((bool)m_playbackRecord)
				{
					m_encodeScreen = UnityEngine.Object.Instantiate(m_encodePrefab, m_canvas.GetComponent<Transform>()).GetComponent<encodeScreenScript>();
					m_playbackRecord.StopRecording();
				}
				else
				{
					PlaybackReturn();
				}
				m_playbackStep++;
				return;
			}
			if (m_playbackZoneChange)
			{
				ChangeZoneEnd();
				ChangeZoneUpdate(1f);
				m_playbackZoneChange = false;
			}
			float num = 0.125f;
			int playbackTimerFrames = 1;
			int num2 = m_playbackArray[m_playbackStep].Value();
			bool flag2 = false;
			switch (m_playbackArray[m_playbackStep].Action())
			{
			case ha.changeZone:
			{
				ChangeZone(-num2);
				m_zoneChangePosEnd = zone.m_zoneBounds.center;
				if (m_playbackAnimate)
				{
					num = 1f;
					m_playbackZoneChange = true;
					break;
				}
				ChangeZoneEnd();
				ChangeZoneUpdate(1f);
				Vector3 localPosition = m_cameraOffset + Vector3.forward * -35f;
				localPosition.x = Mathf.Round(localPosition.x * 100f) / 100f;
				localPosition.y = Mathf.Round(localPosition.y * 100f) / 100f;
				base.transform.localPosition = localPosition;
				break;
			}
			case ha.boxOpen:
			{
				boxScript boxByIndex2 = zone.GetBoxByIndex(num2);
				boxByIndex2.PlaybackOpenOrClear(m_playbackAnimate);
				if (m_playbackAnimate)
				{
					num = 0.75f;
					AkAuxSendArray akAuxSendArray3 = new AkAuxSendArray();
					akAuxSendArray3.Add(reverbID, 1f);
					AkSoundEngine.SetGameObjectAuxSendValues(boxByIndex2.audioGO, akAuxSendArray3, 1u);
					AkSoundEngine.PostEvent(m_audioOpenBox, boxByIndex2.audioGO);
				}
				break;
			}
			case ha.boxTake:
			{
				boxScript boxByIndex3 = zone.GetBoxByIndex(num2);
				int _variant = 0;
				int _state = -1;
				m_selectCurrentItem = UnityEngine.Object.Instantiate(m_itemTypes[boxByIndex3.PlaybackTake(out _variant, out _state)]);
				m_selectCurrentItem.SetVariant(_variant);
				m_selectCurrentItem.SetState(_state);
				m_selectCurrentItem.GetRaiseArt(out var _main, out var _back, out var _flipped, out var _flippedBack, out var _offset);
				if (m_playbackAnimate)
				{
					num = 0.25f;
					AkAuxSendArray akAuxSendArray4 = new AkAuxSendArray();
					akAuxSendArray4.Add(reverbID, 1f);
					AkSoundEngine.SetGameObjectAuxSendValues(boxByIndex3.audioGO, akAuxSendArray4, 1u);
					AkSoundEngine.PostEvent("Play_paper_rustle", boxByIndex3.audioGO);
					m_selectCurrentBezier = boxByIndex3.RaiseItemStart(_main, _back, _flipped, _flippedBack, _offset, m_selectCurrentItem.m_xWidth * m_selectCurrentItem.m_yWidth * m_selectCurrentItem.m_size);
					if (m_selectCurrentBezier.Length != 0)
					{
						Vector2[] selectCurrentBezier = m_selectCurrentBezier;
						m_selectCurrentBezier = new Vector2[5];
						selectCurrentBezier.CopyTo(m_selectCurrentBezier, 0);
						m_selectCurrentBezierLerp = 0f;
						m_selectCurrentBezierBox = boxByIndex3;
						m_selectCurrentState = selectionState.raise;
						m_selectCurrentItem.gameObject.SetActive(value: false);
						m_selectCurrentBezier[2].y += 1f;
						m_selectCurrentBezier[4] = NextPlaybackItemPosition(m_playbackStep, out var _stacked2, out var _time2);
						m_selectCurrentBezier[3] = m_selectCurrentBezier[4] + Vector2.up * 0.5f;
						m_selectCurrentItem.SetHover(_stacked2);
						m_selectCurrentBezierSpeed = 3f;
						m_selectCurrentBezierPower = 1f;
						num = Mathf.Max(0f, 0.33333f - _time2);
						if (m_selectCurrentItem.isOnHanger || m_selectCurrentItem.isOnBar)
						{
							m_offset = Vector2.up * (m_selectCurrentItem.hangerSize - 2) * -0.17f;
						}
						else
						{
							m_offset = Vector2.zero;
						}
					}
					else
					{
						m_selectCurrentItem.Position(boxByIndex3.PlaybackContentSnap(_offset, m_selectCurrentItem.m_xWidth * m_selectCurrentItem.m_yWidth * m_selectCurrentItem.m_size), itemScript.positionAction.unplacable, _unboxed: true, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
					}
				}
				else
				{
					m_selectCurrentItem.Position(boxByIndex3.PlaybackContentSnap(_offset, m_selectCurrentItem.m_xWidth * m_selectCurrentItem.m_yWidth * m_selectCurrentItem.m_size), itemScript.positionAction.unplacable, _unboxed: true, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
					if (m_playbackRapid)
					{
						flag2 = true;
					}
				}
				break;
			}
			case ha.boxClear:
			{
				boxScript boxByIndex = zone.GetBoxByIndex(num2);
				boxByIndex.PlaybackOpenOrClear(m_playbackAnimate);
				if (m_playbackAnimate)
				{
					num = 0.9f;
					AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
					akAuxSendArray.Add(reverbID, 1f);
					AkSoundEngine.SetGameObjectAuxSendValues(boxByIndex.audioGO, akAuxSendArray, 1u);
					AkSoundEngine.PostEvent(m_audioCloseBox, boxByIndex.audioGO);
				}
				break;
			}
			case ha.itemRotate:
			{
				for (int i = 0; i < Mathf.Abs(num2); i++)
				{
					flag2 = !m_selectCurrentItem.AdvanceStateAutoRotate((num2 >= 0) ? 1 : (-1));
				}
				if (m_playbackAnimate)
				{
					num = 0.25f;
					string audioTurn = m_selectCurrentItem.GetAudioTurn(m_audioTurnItem);
					if (!string.IsNullOrEmpty(audioTurn))
					{
						AkAuxSendArray akAuxSendArray2 = new AkAuxSendArray();
						akAuxSendArray2.Add(reverbID, 1f);
						AkSoundEngine.SetGameObjectAuxSendValues(m_selectCurrentItem.audioGO, akAuxSendArray2, 1u);
						AkSoundEngine.PostEvent(audioTurn, m_selectCurrentItem.audioGO);
					}
				}
				else if (m_playbackRapid)
				{
					flag2 = true;
				}
				break;
			}
			case ha.itemInteract:
				zone.GetItemByIndex(num2).Interact(!m_playbackAnimate);
				break;
			case ha.itemPickUp:
			{
				itemScript itemByIndex = zone.GetItemByIndex(num2);
				if (itemByIndex == null)
				{
					Debug.LogWarning("in itemPickUp : no item found");
					m_playbackStep = m_playbackArray.Length - 1;
					break;
				}
				bool hover = false;
				if (itemByIndex.Stacked())
				{
					itemByIndex.Unstack();
					hover = true;
				}
				else if (itemByIndex.isOnHanger)
				{
					itemByIndex.Unhanger();
					hover = true;
				}
				else if (itemByIndex.isOnCombine)
				{
					itemByIndex.Uncombine();
					hover = true;
				}
				else if (itemByIndex.Shelved())
				{
					itemByIndex.Unshelf();
				}
				itemByIndex.RemoveItems(zone);
				itemByIndex.transform.parent = null;
				if (m_selectCurrentItem != null)
				{
					if (itemByIndex.isHangable)
					{
						Vector3 position = itemByIndex.StackPosition(m_selectCurrentItem);
						int maskId = itemByIndex.maskId;
						int gridForeground = zone.GetGridForeground(num2, itemByIndex.xValidate, itemByIndex.yValidate);
						itemByIndex.Position(position, itemScript.positionAction.hover, _unboxed: false, null, num2, maskId, gridForeground, m_selectCurrentItem.m_artPivot, zone.GetStyle(num2), zone.GetBoxSize(num2));
						itemByIndex.Hanger(m_selectCurrentItem);
						m_selectCurrentItem.AlignHangerChild();
						m_selectCurrentItem.Position(position, itemScript.positionAction.hover, _unboxed: false, null, num2, maskId, gridForeground, m_selectCurrentItem.m_artPivot, zone.GetStyle(num2), zone.GetBoxSize(num2));
					}
					else
					{
						Vector3 grid = zone.GetGrid(itemByIndex.Node());
						Vector3 vector2 = Vector3.forward * -0.002f;
						float num5 = (float)itemByIndex.xWidth / 2f;
						float num6 = (float)itemByIndex.yWidth / 2f;
						vector2.x = (num5 - num6) * 0.14f;
						vector2.y = (float)itemByIndex.stackPixelSize * 0.01f + Mathf.Ceil((num5 + num6) * 0.07f * 100f) * 0.01f + 0.18f;
						grid += vector2;
						m_selectCurrentItem.Hanger(itemByIndex);
						m_selectCurrentItem.Position(Vector3.zero, itemScript.positionAction.hover, _unboxed: false, null, -1, 0, 0, itemByIndex.m_artPivot, itemScript.nodeStyle.flat, 0);
						m_selectCurrentItem = itemByIndex;
						m_selectCurrentItem.Position(grid, itemScript.positionAction.hover, _unboxed: false, null, m_selectCurrentItem.Node(), 0, 0, null, itemScript.nodeStyle.flat, 0);
						m_selectCurrentItem.AlignHangerChild();
					}
				}
				else
				{
					m_selectCurrentItem = itemByIndex;
					m_selectCurrentItem.SetHover(hover);
				}
				if (m_playbackAnimate)
				{
					AudioPickup(itemByIndex);
					m_selectCurrentState = selectionState.chase;
					m_selectCurrentBezierLerp = 0f;
					m_selectCurrentBezier = new Vector2[5];
					m_selectCurrentBezier[0] = m_selectCurrentItem.transform.position;
					m_selectCurrentBezier[4] = NextPlaybackItemPosition(m_playbackStep, out var _stacked3, out var _time3);
					m_selectCurrentItem.SetHover(_stacked3);
					m_selectCurrentItem.SetShadow(_value: false);
					m_selectCurrentItem.SetOnTop();
					m_selectCurrentBezier[1] = m_selectCurrentBezier[0];
					m_selectCurrentBezier[2] = Vector2.Lerp(m_selectCurrentBezier[0], m_selectCurrentBezier[4], 0.5f) + Vector2.up * 0.5f;
					m_selectCurrentBezier[3] = m_selectCurrentBezier[4] + Vector2.up * 0.5f;
					m_selectCurrentBezierSpeed = 3f;
					m_selectCurrentBezierPower = 1f;
					num = Mathf.Max(0f, 0.33333f - _time3);
				}
				else if (m_playbackRapid)
				{
					flag2 = true;
				}
				break;
			}
			case ha.itemPlace:
			{
				if (m_selectCurrentItem == null)
				{
					Debug.LogWarning("in itemPlace : no item found");
					m_playbackStep = m_playbackArray.Length - 1;
					break;
				}
				itemScript itemOnGrid = zone.GetItemOnGrid(num2);
				Vector3 vector = Vector3.zero;
				int num3 = 0;
				itemScript.nodeStyle nodeStyle = zone.GetStyle(num2);
				itemScript itemScript2 = ((nodeStyle == itemScript.nodeStyle.rack || nodeStyle == itemScript.nodeStyle.rackFlipped) ? m_selectCurrentItem : m_selectCurrentItem.GetCompareItem());
				int num4 = 0;
				if (itemOnGrid != null)
				{
					if (itemOnGrid.StackCheck(itemScript2, _checkActive: false))
					{
						vector = itemOnGrid.StackPosition(itemScript2);
						num4 = 1;
					}
					else if (itemOnGrid.HangerCheck() && itemScript2.m_hangerType == itemOnGrid.m_hangerType)
					{
						vector = itemOnGrid.HangerPosition(itemScript2);
						nodeStyle = itemOnGrid.HangerStyle();
						num4 = 2;
						vector += Vector3.forward * -0.002f;
					}
					else if (itemOnGrid.CombineCheck(itemScript2))
					{
						vector = itemOnGrid.CombinePosition(itemScript2.combineDepth);
						nodeStyle = itemOnGrid.CombineStyle();
						num4 = 3;
					}
					else
					{
						Debug.LogWarning("INTERACTION FAILED | " + itemScript2.name + itemScript2.GetVariantName() + " could not fit on " + itemOnGrid.name + itemOnGrid.GetVariantName());
					}
					num3 = itemOnGrid.maskId;
				}
				else
				{
					vector = zone.GetGrid(num2);
					num3 = zone.GetMaskLevel(num2, itemScript2.xValidate, itemScript2.yValidate);
				}
				Transform parent = ((itemOnGrid != null) ? itemOnGrid.m_artPivot : zone.GetParent(num2));
				int foreground = ((itemOnGrid == null) ? zone.GetGridForeground(num2, itemScript2.xValidate, itemScript2.yValidate) : zone.GetGridForeground(num2, itemOnGrid.xValidate, itemOnGrid.yValidate));
				itemScript.positionAction action = itemScript.positionAction.hover;
				if (m_playbackHoverHold > 1)
				{
					action = ((!(itemOnGrid != null) || !itemScript2.m_stackInheritValid) ? (zone.IsItemValid(itemScript2, (itemOnGrid != null) ? itemOnGrid : itemScript2, num2, nodeStyle) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid) : (itemScript2.isValid ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid));
				}
				if (m_playbackHoverHold == 0)
				{
					m_selectCurrentItem.SetShadow(_value: false);
					m_selectCurrentItem.SetOnTop();
					vector = Vector2.Lerp(m_selectCurrentItem.transform.position, vector, 0.5f);
					vector.z = -9f;
					m_selectCurrentItem.SimplePosition(vector);
				}
				else
				{
					itemScript2.Position(vector, action, _unboxed: false, itemOnGrid, num2, num3, foreground, parent, nodeStyle, zone.GetBoxSize(num2));
				}
				SetItemPins(num2, itemScript2);
				if (m_playbackHoverHold > 1)
				{
					m_playbackHoverHold = 0;
					switch (num4)
					{
					case 1:
						itemScript2.Stack(itemOnGrid);
						break;
					case 2:
						itemScript2.Hanger(itemOnGrid);
						break;
					case 3:
						itemScript2.Combine(itemOnGrid);
						break;
					}
					itemScript2.AddItems(zone);
					if (m_selectCurrentItem == itemScript2)
					{
						m_selectCurrentItem = null;
						m_selectCurrentState = selectionState.none;
					}
					else
					{
						itemScript2.Unhanger();
					}
				}
				else
				{
					m_playbackHoverHold++;
					m_playbackStep--;
				}
				if (m_playbackAnimate)
				{
					num = 0.0333f;
					if (m_playbackHoverHold == 0)
					{
						AudioPlace(itemScript2);
						if (m_selectCurrentItem != null)
						{
							m_selectCurrentState = selectionState.chase;
							m_selectCurrentBezierLerp = 0f;
							m_selectCurrentBezier = new Vector2[5];
							m_selectCurrentBezier[0] = m_selectCurrentItem.transform.position;
							m_selectCurrentBezier[4] = NextPlaybackItemPosition(m_playbackStep, out var _stacked, out var _time);
							m_selectCurrentItem.SetHover(_stacked);
							m_selectCurrentItem.SetShadow(_value: false);
							m_selectCurrentItem.SetOnTop();
							m_selectCurrentBezier[1] = m_selectCurrentBezier[0];
							m_selectCurrentBezier[2] = Vector2.Lerp(m_selectCurrentBezier[0], m_selectCurrentBezier[4], 0.5f) + Vector2.up * 0.5f;
							m_selectCurrentBezier[3] = m_selectCurrentBezier[4] + Vector2.up * 0.5f;
							m_selectCurrentBezierSpeed = 3f;
							m_selectCurrentBezierPower = 1f;
							num = Mathf.Max(0f, 0.33333f - _time);
						}
					}
				}
				else if (m_playbackRapid && m_playbackHoverHold > 1)
				{
					flag2 = true;
				}
				break;
			}
			case ha.itemShelf:
			{
				m_playbackStep++;
				int index = num2;
				num2 = m_playbackArray[m_playbackStep].Value();
				shelfStandScript shelfStandScript2 = zone.FindShelf(num2);
				int maskLevel = zone.GetMaskLevel(num2, 1, 1);
				m_selectCurrentItem.Position(Vector3.zero, itemScript.positionAction.placedValid, _unboxed: false, null, num2, maskLevel, zone.GetGridForeground(num2, m_selectCurrentItem.xValidate, m_selectCurrentItem.yValidate), zone.GetParent(num2), shelfStandScript2.NodeStyle(), zone.GetBoxSize(num2));
				shelfStandScript2.AddItem(m_selectCurrentItem, index);
				shelfStandScript2.ResetPosition();
				m_selectCurrentItem.AddItems(zone);
				m_selectCurrentItem = null;
				m_selectCurrentState = selectionState.none;
				break;
			}
			case ha.stageUse:
				m_playbackUseWait = zone.PlaybackUseStage(num2, m_playbackAnimate);
				if (m_playbackAnimate)
				{
					num = 0.4f;
				}
				break;
			}
			m_playbackStep++;
			if (m_playbackAnimate)
			{
				m_playbackTimer += num;
			}
			else
			{
				m_playbackTimerFrames = playbackTimerFrames;
			}
			bool flag3 = m_playbackStep < m_playbackArray.Length && m_playbackArray[m_playbackStep].Action() == ha.changeZone;
			if ((bool)m_playbackCapture)
			{
				if (!flag2 && m_playbackCaptureZone == m_currentZone && !flag3)
				{
					m_playbackCapture.CaptureNext();
				}
				else
				{
					m_playbackRepeat = true;
				}
			}
			if (m_playbackStep == m_playbackArray.Length)
			{
				m_playbackTimer = ((m_playbackRecord == null) ? 4f : 1f);
				Time.timeScale = 1f;
				AkSoundEngine.SetRTPCValue("replay_speed", 1f);
				if (m_musicPlayer != null)
				{
					AkSoundEngine.PostEvent("MusicPlayer_Stop", m_musicPlayerGO);
				}
				if ((bool)m_playbackCapture)
				{
					m_encodeScreen = UnityEngine.Object.Instantiate(m_encodePrefab, m_canvas.GetComponent<Transform>()).GetComponent<encodeScreenScript>();
					m_playbackCapture.Encode((new float[3] { 15f, 30f, 50f })[Mathf.Clamp(gameStateScript.playbackSpeed, 1, 3) - 1]);
					m_playbackStep++;
				}
			}
		}
		if (m_selectCurrentState == selectionState.raise || m_selectCurrentState == selectionState.chase)
		{
			m_selectCurrentBezierLerp += Time.deltaTime * m_selectCurrentBezierSpeed;
			float num7 = Mathf.Pow(m_selectCurrentBezierLerp, m_selectCurrentBezierPower);
			Vector2 a = Vector2.Lerp(m_selectCurrentBezier[0], m_selectCurrentBezier[1], num7);
			Vector2 vector3 = Vector2.Lerp(m_selectCurrentBezier[1], m_selectCurrentBezier[2], num7);
			Vector2 vector4 = Vector2.Lerp(m_selectCurrentBezier[2], m_selectCurrentBezier[3], num7);
			Vector2 b = Vector2.Lerp(m_selectCurrentBezier[3], m_selectCurrentBezier[4], num7);
			Vector2 a2 = Vector2.Lerp(a, vector3, num7);
			Vector2 vector5 = Vector2.Lerp(vector3, vector4, num7);
			Vector2 b2 = Vector2.Lerp(vector4, b, num7);
			Vector2 a3 = Vector2.Lerp(a2, vector5, num7);
			Vector2 b3 = Vector2.Lerp(vector5, b2, num7);
			Vector3 vector6 = Vector2.Lerp(a3, b3, num7);
			if (m_selectCurrentState == selectionState.raise && num7 > 0.5f)
			{
				m_selectCurrentBezierBox.RaiseItemEnd();
				m_selectCurrentItem.gameObject.SetActive(value: true);
				m_selectCurrentItem.SetShadow(_value: false);
				m_selectCurrentItem.SetOnTop();
				m_selectCurrentState = selectionState.chase;
			}
			if (m_selectCurrentState == selectionState.raise)
			{
				m_selectCurrentBezierBox.RaiseItemMove(vector6);
			}
			else
			{
				vector6.z = -9f;
				m_selectCurrentItem.SimplePosition(vector6);
			}
			if (m_selectCurrentBezierBox != null)
			{
				m_selectCurrentBezierBox.RaiseItemContentsSlide(num7);
			}
			if (m_selectCurrentBezierLerp >= 1f)
			{
				m_selectCurrentState = selectionState.held;
				m_selectCurrentBezierBox = null;
			}
		}
		if (m_zoneChange)
		{
			m_zoneChangeLerp = Mathf.MoveTowards(m_zoneChangeLerp, 1f, Time.deltaTime * 1.5f);
			if (m_zoneChangeLerp == 1f)
			{
				ChangeZoneEnd();
			}
			float value = m_zoneChangeAnim.Evaluate(m_zoneChangeLerp);
			ChangeZoneUpdate(value);
			UpdateCamera();
		}
	}

	private float NextPlaybackItemTime(int _step)
	{
		float num = 0f;
		for (int i = _step + 1; i < m_playbackArray.Length; i++)
		{
			ha ha2 = m_playbackArray[i].Action();
			switch (ha2)
			{
			case ha.changeZone:
			case ha.itemRotate:
			case ha.itemInteract:
				num += PlaybackActionTime(ha2);
				break;
			case ha.itemPlace:
			case ha.itemShelf:
				return num;
			}
		}
		Debug.LogWarning("NextPlaybackItemTime | no itemPlace found!");
		return num;
	}

	private Vector3 NextPlaybackItemPosition(int _step, out bool _stacked, out float _time)
	{
		int num = m_currentZone;
		_time = 0f;
		_stacked = false;
		for (int i = _step + 1; i < m_playbackArray.Length; i++)
		{
			ha ha2 = m_playbackArray[i].Action();
			if (ha2 == ha.changeZone || ha2 == ha.itemRotate || ha2 == ha.itemInteract)
			{
				_time += PlaybackActionTime(ha2);
			}
			switch (ha2)
			{
			case ha.changeZone:
				num -= m_playbackArray[i].Value();
				if (num < 0)
				{
					num += m_zones.Length;
				}
				else if (num >= m_zones.Length)
				{
					num -= m_zones.Length;
				}
				break;
			case ha.itemPlace:
			{
				zoneScript zoneScript2 = m_zones[num];
				itemScript itemOnGrid = zoneScript2.GetItemOnGrid(m_playbackArray[i].Value());
				itemScript.nodeStyle style = zoneScript2.GetStyle(m_playbackArray[i].Value());
				itemScript itemScript2 = ((style == itemScript.nodeStyle.rack || style == itemScript.nodeStyle.rackFlipped) ? m_selectCurrentItem : m_selectCurrentItem.GetCompareItem());
				if (itemOnGrid != null)
				{
					if (itemOnGrid.StackCheckIncludeTurned(itemScript2, _checkActive: false))
					{
						_stacked = true;
						return itemOnGrid.StackPosition(itemScript2);
					}
					if (itemOnGrid.HangerCheck() && itemScript2.m_hangerType == itemOnGrid.m_hangerType)
					{
						return itemOnGrid.HangerPosition(itemScript2);
					}
					if (itemOnGrid.CombineCheck(itemScript2))
					{
						return itemOnGrid.CombinePosition(itemScript2.combineDepth);
					}
					Debug.LogWarning("Should not have reached this. | " + itemOnGrid.name + " | " + itemScript2.name + " | stackCheck : " + itemOnGrid.StackCheck(itemScript2, _checkActive: false));
					break;
				}
				return zoneScript2.GetGrid(m_playbackArray[i].Value());
			}
			case ha.itemPickUp:
			{
				itemScript itemByIndex = m_zones[num].GetItemByIndex(m_playbackArray[i].Value());
				if (itemByIndex != null)
				{
					return itemByIndex.StackPosition(m_selectCurrentItem);
				}
				Debug.LogWarning("Should not have reached this - item " + m_selectCurrentItem.name + " was attempting to pick up an item but nothing was there");
				break;
			}
			case ha.itemShelf:
				return m_zones[num].FindShelf(m_playbackArray[i + 1].Value()).GetPosition(m_selectCurrentItem, m_playbackArray[i].Value());
			}
		}
		Debug.LogWarning("NextPlaybackItemPosition | no item position found!");
		return Vector3.zero;
	}

	private bool ItemTap(itemScript _item, Vector2 _screenPos)
	{
		Collider2D component = _item.GetComponent<Collider2D>();
		bool flag = component.enabled;
		component.enabled = true;
		bool result = component.OverlapPoint(Camera.main.ScreenToWorldPoint(_screenPos));
		component.enabled = flag;
		return result;
	}

	private void Update()
	{
		if (m_playbackMode)
		{
			do
			{
				PlaybackUpdate();
			}
			while (m_playbackRepeat);
			return;
		}
		if (m_photoModeAppear)
		{
			m_photoModeAppearLerp += Time.deltaTime * 0.5f;
			m_photomodeButton.GetComponent<UnityEngine.UI.Image>().color = m_photoModeAppearEffect.Evaluate(m_photoModeAppearLerp);
			if (m_photoModeAppearLerp >= 1f)
			{
				m_photoModeAppear = false;
			}
		}
		if (m_stickerUnlockDelay > 0f)
		{
			m_stickerUnlockDelay = Mathf.MoveTowards(m_stickerUnlockDelay, 0f, Time.deltaTime);
		}
		if (m_photomodeButton.gameObject.activeSelf && m_stickerUnlockList.Count > 0 && m_stickerUnlockDelay == 0f && !m_stickerUnlock.sequenceActive)
		{
			AkSoundEngine.PostEvent(m_audioStickerUnlock, base.gameObject);
			m_stickerUnlock.UnlockSticker(m_stickerUnlockList[0]);
			m_stickerUnlockList.RemoveAt(0);
		}
		if (m_gameActive)
		{
			m_playtime += Time.deltaTime;
			if (audioLift)
			{
				m_audioLiftTimer -= Time.deltaTime;
				if (m_audioLiftTimer <= 0f)
				{
					m_audioLiftTimer = m_audioLiftTime;
					m_audioLiftLifted = !m_audioLiftLifted;
					m_audioLiftItem.AudioLift(m_audioLiftLifted);
					if (m_audioLiftLifted)
					{
						AudioPickup(m_audioLiftItem);
					}
					else
					{
						AudioPlace(m_audioLiftItem);
					}
				}
			}
			if (m_zoneHintCountdown)
			{
				m_zoneHintTimer -= Time.deltaTime;
				if (m_zoneHintTimer <= 0f)
				{
					m_zoneHintCountdown = false;
					ConfigureZoneButtons(_active: true);
				}
			}
			bool flag = (itemScript.s_touchMode = inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch);
			bool flag2 = false;
			Vector2 vector = Vector2.zero;
			Vector2 vector2 = Vector2.zero;
			bool flag3 = false;
			bool flag4 = false;
			bool flag5 = false;
			int num = 0;
			bool flag6 = false;
			float zoomPinch = 0f;
			bool flag7 = false;
			uiCursor.cursorState cursorState = uiCursor.cursorState.none;
			if (flag)
			{
				flag7 = m_inputUI || EventSystem.current.IsPointerOverGameObject(inputHandler.GetTouchAtIdx(0).fingerId);
				if (m_inputRotate)
				{
					m_inputRotate = false;
					num = 1;
					if (m_selectCurrentItem != null)
					{
						m_inputTouchPosition = Camera.main.WorldToScreenPoint(m_selectCurrentItem.transform.position);
						m_offset = m_selectCurrentItem.GetOffset(m_selectCurrentItem.transform.position);
					}
				}
				if (inputHandler.TouchCount == 2 && m_selectCurrentItem == null)
				{
					flag6 = true;
					Touch[] touches = inputHandler.Touches;
					if (touches[0].phase == TouchPhase.Began || touches[1].phase == TouchPhase.Began)
					{
						m_zoomPinchApplied = false;
						m_zoomPinchDistance = Vector2.Distance(touches[0].position, touches[1].position) / Display.DPI;
						HideTouchControls();
					}
					zoomPinch = Mathf.Clamp(m_zoomPinchDistance - Vector2.Distance(touches[0].position, touches[1].position) / Display.DPI, -0.3f, (m_zoomLevel > m_zoomLevelMin) ? 0.3f : 0.1f);
					vector2 = new Vector2(touches[0].deltaPosition.x + touches[1].deltaPosition.x, touches[0].deltaPosition.y + touches[1].deltaPosition.y) * 0.005f;
					vector2 *= m_pixelSize / m_zoom;
					if ((touches[0].phase == TouchPhase.Ended || touches[1].phase == TouchPhase.Ended) && m_selectCurrentState == selectionState.held)
					{
						PositionTouchControls();
					}
				}
				else if (inputHandler.TouchCount == 1 || (inputHandler.TouchCount > 0 && m_selectCurrentItem != null))
				{
					Touch[] touches2 = inputHandler.Touches;
					if (m_selectCurrentItem == null)
					{
						flag2 = true;
						vector = touches2[0].position;
						flag3 = touches2[0].phase == TouchPhase.Began && !flag7;
						if (m_inputDragScrollDistance > 3f)
						{
							vector2 = new Vector2(touches2[0].deltaPosition.x, touches2[0].deltaPosition.y) * 0.01f;
							vector2 *= m_pixelSize / m_zoom;
						}
						else
						{
							m_inputDragScrollDistance += touches2[0].deltaPosition.magnitude;
						}
					}
					else if (m_selectCurrentDelayedLift && touches2[0].phase == TouchPhase.Began && ItemTap(m_selectCurrentItem, touches2[0].position))
					{
						CancelDelayLift();
						HideTouchControls();
						if (!string.IsNullOrEmpty(m_audioTouchControlsCancel))
						{
							AkSoundEngine.PostEvent(m_audioTouchControlsCancel, base.gameObject);
						}
					}
					else if (!flag7 && !m_inputIgnoreRestOfTouch)
					{
						if (m_itemTapLiftCancel && m_itemTapLiftTimer > 0f)
						{
							m_itemTapLiftTimer -= Time.deltaTime;
						}
						if (touches2[0].phase == TouchPhase.Began || m_inputDragDistance > m_itemTapDragReleaseDistanceRatio * (float)Screen.height * 0.5f || (m_itemTapLiftCancel && m_itemTapLiftTimer <= 0f))
						{
							if (m_selectCurrentDelayedLift)
							{
								m_selectCurrentDelayedLift = false;
								LiftItem();
							}
							m_inputTouchNode = -1;
							m_inputIgnoreRelease = false;
						}
						m_inputDragDistance += touches2[0].deltaPosition.magnitude;
						flag2 = !m_selectCurrentDelayedLift && touches2[0].phase != TouchPhase.Began;
						vector = touches2[0].position;
						if (m_inputTapPrime)
						{
							flag3 = touches2[0].phase == TouchPhase.Stationary;
							flag4 = !flag3;
							if (m_selectCurrentItem != null && ItemTap(m_selectCurrentItem, vector))
							{
								m_offset = m_selectCurrentItem.GetOffset(Camera.main.ScreenToWorldPoint(vector));
							}
							else
							{
								m_offset = Vector3.zero;
							}
							HideTouchControls();
						}
						if (touches2[0].phase == TouchPhase.Ended && m_selectCurrentState == selectionState.held)
						{
							PositionTouchControls();
						}
						flag5 = !m_inputIgnoreRelease && touches2[0].phase == TouchPhase.Ended;
					}
				}
				else if (inputHandler.TouchCount == 0)
				{
					m_inputIgnoreRestOfTouch = false;
					m_inputDragScrollDistance = 0f;
				}
				m_inputTapPrime = inputHandler.TouchCount == 1 && inputHandler.GetTouchAtIdx(0).phase == TouchPhase.Began;
			}
			else
			{
				flag7 = EventSystem.current.IsPointerOverGameObject();
				if (flag7)
				{
					cursorState = uiCursor.cursorState.valid;
				}
				vector2 = -inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove) * Time.deltaTime * 60f * 0.25f;
				if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
				{
					vector2 -= inputHandler.Instance.mouseScrollDelta / (m_pixelSize * m_zoom * 2f);
				}
				if (inputHandler.IsDown(InputAction.Gameplay_ScreenPan))
				{
					if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
					{
						vector2 += inputHandler.GetAxis2DRaw(InputAction.Gameplay_CursorMove) / (m_pixelSize * m_zoom);
					}
					else
					{
						vector2 += inputHandler.CursorDelta / (m_pixelSize * m_zoom * 100f);
					}
				}
				flag2 = true;
				vector = inputHandler.CursorPosition;
				flag3 = inputHandler.IsPressed(InputAction.Gameplay_LiftAndPlace);
				num = (inputHandler.IsPressed(InputAction.Gameplay_TurnAndInteract) ? 1 : 0);
			}
			m_inputUI = false;
			if ((flag && flag2) || inputHandler.HasAnyAxisMoved)
			{
				gameStateScript.GameAction();
			}
			if (m_dateNodeActive)
			{
				float num2 = 4f;
				float num3 = 5f;
				if (!string.IsNullOrEmpty(m_audioDateWrite) && m_dateNodeTime < 1.1f && m_dateNodeTime + Time.deltaTime >= 1.1f)
				{
					m_audioDateWriteID = AkSoundEngine.PostEvent(m_audioDateWrite, base.gameObject);
				}
				if (!string.IsNullOrEmpty(m_audioLevelAppear) && m_dateNodeTime < 3.4f && m_dateNodeTime + Time.deltaTime >= 3.4f)
				{
					m_audioLevelAppearID = AkSoundEngine.PostEvent(m_audioLevelAppear, base.gameObject);
				}
				if (m_dateNodeTime < 4.25f && m_dateNodeTime + Time.deltaTime >= 4.25f)
				{
					AkSoundEngine.PostEvent("Play_Ambience", base.gameObject);
				}
				m_dateNodeTime += Time.deltaTime;
				if (m_dateNodeTime > num3)
				{
					zone.transform.position = Vector3.zero;
					m_dateNodeActive = false;
					m_dateNode.parent.gameObject.SetActive(value: false);
					m_zoneChangeButton.Show(_instant: false);
					SetMusicState("gameplay");
					bool flag8 = true;
					zoneScript[] zones = m_zones;
					for (int i = 0; i < zones.Length; i++)
					{
						if (zones[i].BoxesRemain())
						{
							flag8 = false;
							break;
						}
					}
					if (flag8)
					{
						EndModeStart();
					}
					else if (!zone.BoxesRemain())
					{
						m_zoneHintCountdown = true;
						m_zoneHintTimer = 2f;
					}
					RefreshCursorState(attemptForceCenter: true);
					FileSaveAction();
				}
				else if (m_dateNodeTime > num2)
				{
					float time = Mathf.InverseLerp(num2, num3, m_dateNodeTime);
					time = m_dateNodeCurve.Evaluate(time);
					float num4 = Mathf.Lerp(0f, 5f, time);
					num4 = Mathf.Round(num4 * 100f) / 100f;
					num4 += 0.005f;
					time = Mathf.Lerp(-9f, 0f, time);
					time = Mathf.Round(time * 100f) / 100f;
					zone.transform.localPosition = Vector3.up * time;
					Vector3 localPosition = m_dateNode.transform.localPosition;
					localPosition.y = num4;
					m_dateNode.transform.localPosition = localPosition;
				}
			}
			else if (m_zoneChange)
			{
				m_zoneChangeLerp = Mathf.MoveTowards(m_zoneChangeLerp, 1f, Time.deltaTime * 1.5f);
				if (m_zoneChangeLerp == 1f)
				{
					ChangeZoneEnd();
					if (flag)
					{
						PositionTouchControls();
					}
				}
				float value = m_zoneChangeAnim.Evaluate(m_zoneChangeLerp);
				ChangeZoneUpdate(value);
				if ((bool)m_selectCurrentItem)
				{
					if (flag)
					{
						Vector3 position = Camera.main.ScreenToWorldPoint(m_inputTouchPosition) - m_offset;
						m_selectCurrentItem.Position(position, itemScript.positionAction.unplacable, _unboxed: false, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
					}
					else
					{
						Vector3 position2 = Camera.main.ScreenToWorldPoint(vector) - m_offset;
						m_selectCurrentItem.Position(position2, itemScript.positionAction.unplacable, _unboxed: false, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
					}
				}
				UpdateCamera();
			}
			else
			{
				float zoomPinch2 = m_zoomPinch;
				if (flag6 && !m_zoomPinchApplied)
				{
					m_zoomPinch = zoomPinch;
					if (m_zoomPinch < -0.25f && m_zoomLevel < m_zoomLevelMax)
					{
						ZoomIn();
						m_zoomPinchApplied = true;
						m_zoom -= m_zoomPinch;
						m_zoomPinch = 0f;
					}
					else if (m_zoomPinch > 0.25f && m_zoomLevel > m_zoomLevelMin)
					{
						ZoomOut();
						m_zoomPinchApplied = true;
						m_zoom -= m_zoomPinch;
						m_zoomPinch = 0f;
					}
				}
				else
				{
					m_zoomPinch = Mathf.MoveTowards(m_zoomPinch, 0f, Time.deltaTime * 2f);
				}
				if (m_gamePanActive && (m_zoom != m_zoomTarget || m_zoomPinch != zoomPinch2))
				{
					m_zoom = Mathf.Lerp(m_zoom, m_zoomTarget, Time.deltaTime * 10f);
					if (Mathf.Abs(m_zoom - m_zoomTarget) < 0.01f)
					{
						m_zoom = m_zoomTarget;
						m_zoomShiftActive = false;
						m_validationOverlay.enabled = m_validation != validationEffect.none;
						if (flag)
						{
							PositionTouchControls();
						}
					}
					float num5 = m_zoomOrthoBase / (m_zoom - m_zoomPinch);
					GetComponent<Camera>().orthographicSize = num5;
					if (m_zoomShiftActive)
					{
						m_cameraOffset = Vector2.Lerp(m_zoomShiftOrigin, m_zoomShift, Mathf.InverseLerp(m_zoomShiftOrtho.x, m_zoomShiftOrtho.y, num5));
					}
				}
				if (m_gamePanActive && m_cameraTrack)
				{
					Vector2 vector3 = Vector2.zero;
					float num6 = (flag ? 0.25f : 0.05f);
					if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad && inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove).sqrMagnitude != 0f)
					{
						vector3 = inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove);
						vector3 *= vector3.magnitude * Time.deltaTime * 60f * 0.05f;
						vector2 = Vector2.zero;
					}
					else if (!flag7 && (!flag || (flag2 && m_selectCurrentItem != null)))
					{
						Vector2 vector4 = Camera.main.ScreenToViewportPoint(vector);
						if (Application.isFocused)
						{
							if (Mathf.Approximately(vector2.y, 0f))
							{
								if (vector4.y > 1f - num6)
								{
									vector3.y = Mathf.InverseLerp(1f - num6, 1f, vector4.y);
									vector3.y *= vector3.y;
								}
								else if (vector4.y < num6)
								{
									vector3.y = Mathf.InverseLerp(num6, 0f, vector4.y);
									vector3.y *= 0f - vector3.y;
								}
							}
							if (Mathf.Approximately(vector2.x, 0f))
							{
								if (vector4.x > 1f - num6)
								{
									vector3.x = Mathf.InverseLerp(1f - num6, 1f, vector4.x);
									vector3.x *= vector3.x;
								}
								else if (vector4.x < num6)
								{
									vector3.x = Mathf.InverseLerp(num6, 0f, vector4.x);
									vector3.x *= 0f - vector3.x;
								}
							}
						}
						vector3 *= Time.deltaTime * (flag ? 4f : 2f);
					}
					if (!m_cameraTrackArmed && vector3.sqrMagnitude == 0f)
					{
						m_cameraTrackArmed = true;
					}
					float orthographicSize = GetComponent<Camera>().orthographicSize;
					float num7 = orthographicSize * m_aspectRatio;
					Vector4 vector5 = ZoneBound();
					vector3 -= vector2;
					Vector2 vector6 = m_cameraOffset;
					if (zone.m_zoneBounds.extents.y < m_zoomOrthoBase / m_zoomTarget || zone.m_zoneBounds.extents.y < orthographicSize)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.y = Mathf.Lerp(m_cameraOffset.y, zone.m_zoneBounds.center.y, Time.deltaTime * 10f);
						}
					}
					else if (m_cameraOffset.y < vector5.y + orthographicSize - 0.001f)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.y = vector5.y + orthographicSize;
						}
					}
					else if (m_cameraOffset.y > vector5.w - orthographicSize + 0.001f)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.y = vector5.w - orthographicSize;
						}
					}
					else if (m_cameraTrackArmed && vector3.y < 0f)
					{
						m_cameraOffset.y = Mathf.MoveTowards(m_cameraOffset.y, vector5.y + orthographicSize, 0f - vector3.y);
					}
					else if (m_cameraTrackArmed && vector3.y > 0f)
					{
						m_cameraOffset.y = Mathf.MoveTowards(m_cameraOffset.y, vector5.w - orthographicSize, vector3.y);
					}
					if (zone.m_zoneBounds.extents.x < m_zoomOrthoBase * m_aspectRatio / m_zoomTarget || zone.m_zoneBounds.extents.x < num7)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.x = Mathf.Lerp(m_cameraOffset.x, zone.m_zoneBounds.center.x, Time.deltaTime * 10f);
						}
					}
					else if (m_cameraOffset.x < vector5.x + num7 - 0.001f)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.x = vector5.x + num7;
						}
					}
					else if (m_cameraOffset.x > vector5.z - num7 + 0.001f)
					{
						if (!m_zoomShiftActive)
						{
							m_cameraOffset.x = vector5.z - num7;
						}
					}
					else if (m_cameraTrackArmed && vector3.x < 0f)
					{
						m_cameraOffset.x = Mathf.MoveTowards(m_cameraOffset.x, vector5.x + num7, 0f - vector3.x);
					}
					else if (m_cameraTrackArmed && vector3.x > 0f)
					{
						m_cameraOffset.x = Mathf.MoveTowards(m_cameraOffset.x, vector5.z - num7, vector3.x);
					}
					if (m_zoomShiftActive)
					{
						m_zoomShift += (Vector2)m_cameraOffset - vector6;
						m_zoomShiftOrigin += (Vector2)m_cameraOffset - vector6;
					}
					UpdateCamera();
				}
				int num8 = -1;
				bool flag9 = false;
				if ((m_state == gameState.play || m_state == gameState.arrange) && (m_selectCurrentState == selectionState.held || m_selectCurrentState == selectionState.chase))
				{
					bool isNonFlatState = m_selectCurrentItem.isNonFlatState;
					if (num != 0 && m_selectCurrentItem.AdvanceState(num))
					{
						selectCollisionSet(m_selectCurrentItem.GetCompareItem());
						if (isNonFlatState)
						{
							m_offset = Vector3.zero;
						}
						flag9 = true;
						if (!flag)
						{
							TutorialTurnComplete();
						}
						HistoryRecord(ha.itemRotate, num);
						if (flag)
						{
							flag2 = true;
							vector = m_inputTouchPosition;
							flag7 = false;
						}
					}
				}
				if (m_selectCurrentState == selectionState.raise || m_selectCurrentState == selectionState.chase)
				{
					if (flag2)
					{
						m_selectCurrentBezier[3] = Camera.main.ScreenToWorldPoint(vector) - m_selectCurrentItem.VisualOffset() - m_offset;
						if (m_selectCurrentItem.isOnHanger)
						{
							m_selectCurrentBezier[3].y += 0.15f;
						}
					}
					m_selectCurrentBezier[2].y = Mathf.Max(m_selectCurrentBezier[1].y, m_selectCurrentBezier[3].y + 0.25f);
					m_selectCurrentBezierLerp += Time.deltaTime * m_selectCurrentBezierSpeed;
					Vector2 a = Vector2.Lerp(m_selectCurrentBezier[0], m_selectCurrentBezier[1], m_selectCurrentBezierLerp);
					Vector2 vector7 = Vector2.Lerp(m_selectCurrentBezier[1], m_selectCurrentBezier[2], m_selectCurrentBezierLerp);
					Vector2 b = Vector2.Lerp(m_selectCurrentBezier[2], m_selectCurrentBezier[3], m_selectCurrentBezierLerp);
					Vector2 a2 = Vector2.Lerp(a, vector7, m_selectCurrentBezierLerp);
					Vector2 b2 = Vector2.Lerp(vector7, b, m_selectCurrentBezierLerp);
					Vector3 vector8 = Vector2.Lerp(a2, b2, m_selectCurrentBezierLerp);
					if (m_selectCurrentState == selectionState.raise && m_selectCurrentBezierLerp > 0.5f)
					{
						m_selectCurrentBezierBox.RaiseItemEnd();
						m_selectCurrentItem.gameObject.SetActive(value: true);
						m_selectCurrentState = selectionState.chase;
					}
					if (m_selectCurrentState == selectionState.raise)
					{
						m_selectCurrentBezierBox.RaiseItemMove(vector8);
					}
					else
					{
						vector8.z = -9f;
						m_selectCurrentItem.SimplePosition(vector8);
					}
					m_selectCurrentBezierBox.RaiseItemContentsSlide(m_selectCurrentBezierLerp);
					if (m_selectCurrentBezierLerp >= 1f)
					{
						m_selectCurrentState = selectionState.held;
						if (flag && !flag2)
						{
							PositionTouchControls();
						}
					}
				}
				else if (flag2 && (m_selectCurrentState == selectionState.none || m_selectCurrentState == selectionState.held))
				{
					selectionType selectionType2 = selectionType.none;
					Vector3 vector9 = Camera.main.ScreenToWorldPoint(vector);
					Vector3 vector10 = vector9 - m_offset;
					if (itemHeld)
					{
						Vector3 start = vector10;
						start.z = 0f;
						Debug.DrawRay(start, Vector3.right * 0.1f, Color.yellow);
						Debug.DrawRay(start, Vector3.right * -0.1f, Color.yellow);
						Debug.DrawRay(start, Vector3.up * 0.1f, Color.yellow);
						Debug.DrawRay(start, Vector3.up * -0.1f, Color.yellow);
					}
					int num9 = -1;
					int num10 = -1;
					int _xWidth = 1;
					int _yWidth = 1;
					itemScript itemScript2 = null;
					hookScript hookScript2 = null;
					shelfStandScript shelfStandScript2 = null;
					int num11 = -1;
					Transform transform = null;
					float num12 = float.PositiveInfinity;
					int num13 = 0;
					bool flag10 = itemHeld && inputHandler.IsDown(InputAction.Gameplay_Focus);
					if (flag10)
					{
						cursorState = uiCursor.cursorState.hide;
					}
					if (!flag7 && !m_editorOverGUI && !flag10)
					{
						int num14 = Physics2D.RaycastNonAlloc(vector9, Vector2.zero, m_rayhits);
						for (int j = 0; j < num14; j++)
						{
							if (m_rayhits[j].transform.CompareTag("drawer"))
							{
								drawerScript component = m_rayhits[j].transform.GetComponent<drawerScript>();
								Vector3 vector11 = ((component == null) ? m_rayhits[j].transform.position : component.m_blocker.transform.position);
								switch (selectionType2)
								{
								case selectionType.item:
								{
									int sortingOrder = m_rayhits[j].transform.GetComponent<SpriteRenderer>().sortingOrder;
									if (sortingOrder > num13 || (sortingOrder == num13 && vector11.z < num12))
									{
										num12 = vector11.z;
										num13 = sortingOrder;
										selectionType2 = ((component != null) ? selectionType.usableDrawer : selectionType.occlusionDrawer);
										transform = m_rayhits[j].transform;
									}
									continue;
								}
								default:
									if (!(vector11.z < num12))
									{
										continue;
									}
									break;
								case selectionType.usableDoorSlide:
								case selectionType.usableDoorFold:
									break;
								}
								num12 = vector11.z;
								num13 = m_rayhits[j].transform.GetComponent<SpriteRenderer>().sortingOrder;
								selectionType2 = ((component != null) ? selectionType.usableDrawer : selectionType.occlusionDrawer);
								transform = m_rayhits[j].transform;
							}
							else if (m_rayhits[j].transform.CompareTag("door"))
							{
								bool flag11 = true;
								if (itemHeld)
								{
									int size = m_selectCurrentItem.size;
									if (size > 1)
									{
										int sizeHint = m_rayhits[j].transform.GetComponent<doorScript>().m_sizeHint;
										if (sizeHint != 0 && sizeHint < size)
										{
											flag11 = false;
										}
									}
								}
								if (flag11)
								{
									Vector3 position3 = m_rayhits[j].transform.position;
									if (position3.z < num12)
									{
										num12 = position3.z;
										num13 = 0;
										selectionType2 = selectionType.usableDoorHinge;
										transform = m_rayhits[j].transform;
									}
								}
							}
							else if (m_rayhits[j].transform.CompareTag("doorSlide"))
							{
								Vector3 position4 = m_rayhits[j].transform.position;
								if (selectionType2 != selectionType.usableDrawer && selectionType2 != selectionType.occlusionDrawer && position4.z < num12)
								{
									num12 = position4.z;
									num13 = 0;
									selectionType2 = selectionType.usableDoorSlide;
									transform = m_rayhits[j].transform;
								}
							}
							else if (m_rayhits[j].transform.CompareTag("doorFold"))
							{
								Vector3 position5 = m_rayhits[j].transform.position;
								if (selectionType2 != selectionType.usableDrawer && selectionType2 != selectionType.occlusionDrawer && position5.z < num12)
								{
									num12 = position5.z;
									num13 = 0;
									selectionType2 = selectionType.usableDoorFold;
									transform = m_rayhits[j].transform;
								}
							}
							else if (m_rayhits[j].transform.CompareTag("interact"))
							{
								Vector3 position6 = m_rayhits[j].transform.position;
								if (position6.z < num12)
								{
									num12 = position6.z;
									num13 = 0;
									selectionType2 = selectionType.usableGeneric;
									transform = m_rayhits[j].transform;
								}
							}
							else if (m_rayhits[j].transform.CompareTag("box"))
							{
								if (m_state != gameState.pack || GetUnpackShow(packShow.boxes))
								{
									Vector3 position7 = m_rayhits[j].transform.position;
									if (position7.z < num12 || selectionType2 == selectionType.usableDrawer || selectionType2 == selectionType.occlusionDrawer)
									{
										num12 = position7.z;
										num13 = 0;
										transform = m_rayhits[j].transform;
										boxScript component2 = transform.GetComponent<boxScript>();
										selectionType2 = ((m_state == gameState.play && component2.Empty()) ? selectionType.boxEmpty : (((m_state != gameState.pack || m_selectCurrentUnpackMode != 0) && (m_state == gameState.pack || (!(m_unboxed == transform) && (itemHeld || !component2.CanOpen(zone))))) ? selectionType.occlusion : selectionType.box));
									}
								}
							}
							else if (m_rayhits[j].transform.CompareTag("item"))
							{
								if (m_editCurrentItem != null)
								{
									continue;
								}
								Vector3 position8 = m_rayhits[j].transform.position;
								itemScript component3 = m_rayhits[j].transform.GetComponent<itemScript>();
								if (!itemHeld)
								{
									if (component3.unmovable)
									{
										continue;
									}
									if (selectionType2 == selectionType.usableDrawer || selectionType2 == selectionType.occlusionDrawer || selectionType2 == selectionType.occlusion || selectionType2 == selectionType.item)
									{
										int num15 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
										if (((selectionType2 != selectionType.item || !zone.CompareHeight(itemScript2.Node(), component3.Node())) && num15 > num13) || (num15 == num13 && position8.z < num12))
										{
											num12 = position8.z;
											itemScript2 = m_rayhits[j].transform.GetComponent<itemScript>();
											num13 = num15;
											selectionType2 = selectionType.item;
										}
									}
									else if (position8.z < num12)
									{
										num12 = position8.z;
										itemScript2 = m_rayhits[j].transform.GetComponent<itemScript>();
										num13 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
										selectionType2 = selectionType.item;
									}
								}
								else if (m_selectCurrentItem.isStandable && component3.Shelved())
								{
									if (component3.GetShelf().CheckFit(m_selectCurrentItem))
									{
										if (position8.z < num12)
										{
											num12 = position8.z;
											num13 = 0;
											selectionType2 = selectionType.itemShelf;
											itemScript2 = component3;
											num10 = component3.Node();
											shelfStandScript2 = component3.GetShelf();
											num11 = shelfStandScript2.GetIndex(component3);
										}
									}
									else
									{
										cursorState = uiCursor.cursorState.invalidHeight;
									}
								}
								else if (m_selectCurrentItem.HangerCheck() && component3.isHangable && component3.m_hangerType == m_selectCurrentItem.m_hangerType)
								{
									if (position8.z < num12)
									{
										num12 = position8.z;
										num13 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
										selectionType2 = selectionType.itemHangerOverClothes;
										itemScript2 = component3;
										num10 = component3.Node();
									}
								}
								else if (m_selectCurrentItem.isNonFlatState && component3.m_stackAllowed != itemScript.stackId.none)
								{
									if (component3.StackCheckIncludeTurned(m_selectCurrentItem) && component3.StackValid(zone.GetGridSize(component3), m_selectCurrentItem))
									{
										if (position8.z < num12)
										{
											num12 = position8.z;
											num13 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
											selectionType2 = (component3.StackCheck(m_selectCurrentItem) ? selectionType.itemStack : selectionType.itemStackFlipped);
											itemScript2 = component3;
											num10 = component3.Node();
										}
									}
									else
									{
										cursorState = uiCursor.cursorState.invalidSpace;
									}
								}
								else if (m_selectCurrentItem.isRackable && m_selectCurrentItem.hangerChild != null && m_selectCurrentItem.hangerChild.m_stackAllowed != itemScript.stackId.none)
								{
									itemScript hangerChild = m_selectCurrentItem.hangerChild;
									if (component3.StackCheckIncludeTurned(hangerChild) && component3.StackValid(zone.GetGridSize(component3), hangerChild))
									{
										if (position8.z < num12)
										{
											num12 = position8.z;
											num13 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
											selectionType2 = (component3.StackCheck(hangerChild) ? selectionType.itemStack : selectionType.itemStackFlipped);
											itemScript2 = component3;
											num10 = component3.Node();
										}
									}
									else
									{
										cursorState = uiCursor.cursorState.invalidSpace;
									}
								}
								else if (m_selectCurrentItem.isHangable && component3.HangerCheck() && (!m_selectCurrentItem.isOnHanger || !component3.isOnRack))
								{
									if (component3.m_hangerType == m_selectCurrentItem.m_hangerType && (!component3.isOnRack || m_selectCurrentItem.hangerSize <= zone.GetGridSize(component3.Node())))
									{
										if (position8.z < num12)
										{
											num12 = position8.z;
											num13 = 0;
											selectionType2 = (component3.isOnRack ? selectionType.itemHanger : selectionType.itemClothesOverHanger);
											itemScript2 = component3;
											num10 = component3.Node();
										}
									}
									else
									{
										cursorState = uiCursor.cursorState.invalidHeight;
									}
								}
								else
								{
									if (!m_selectCurrentItem.isCombinable || m_selectCurrentItem.isOnCombine || !component3.CombineCheck(m_selectCurrentItem))
									{
										continue;
									}
									if (zone.GetGridSize(component3) >= m_selectCurrentItem.m_sizeCombine)
									{
										if (position8.z < num12)
										{
											num12 = position8.z;
											num13 = Mathf.Max(component3.maskLevel, component3.sortingLayer);
											selectionType2 = selectionType.itemCombine;
											itemScript2 = component3;
											num10 = component3.Node();
										}
									}
									else
									{
										cursorState = uiCursor.cursorState.invalidSpace;
									}
								}
							}
							else if (itemHeld && m_selectCurrentItem.isStandable && m_rayhits[j].transform.CompareTag("shelfStand"))
							{
								shelfStandScript component4 = m_rayhits[j].transform.GetComponent<shelfStandScript>();
								if (component4.CheckFit(m_selectCurrentItem))
								{
									Vector3 position9 = m_rayhits[j].transform.position;
									if (position9.z < num12)
									{
										num12 = position9.z;
										num13 = 0;
										selectionType2 = selectionType.specialShelf;
										transform = m_rayhits[j].transform;
										shelfStandScript2 = component4;
										num10 = component4.index;
									}
								}
								else
								{
									cursorState = uiCursor.cursorState.invalidHeight;
								}
							}
							else if (itemHeld && m_selectCurrentItem.isHookable && !m_selectCurrentItem.isOnHook && m_rayhits[j].transform.CompareTag("hook"))
							{
								hookScript component5 = m_rayhits[j].transform.GetComponent<hookScript>();
								if (component5.m_hookType != hookScript.hookType.hook && component5.m_hookType != hookScript.hookType.hookFlipped)
								{
									continue;
								}
								if (m_selectCurrentItem.hookSize <= zone.GetGridSize(component5.index))
								{
									Vector3 position10 = m_rayhits[j].transform.position;
									if (position10.z < num12)
									{
										num12 = position10.z;
										num13 = 0;
										selectionType2 = selectionType.specialHook;
										transform = m_rayhits[j].transform;
										hookScript2 = component5;
										num10 = component5.index;
									}
								}
								else
								{
									cursorState = uiCursor.cursorState.invalidHeight;
								}
							}
							else if (itemHeld && m_selectCurrentItem.isHolderable && !m_selectCurrentItem.isOnHolder && m_rayhits[j].transform.CompareTag("hook"))
							{
								hookScript component6 = m_rayhits[j].transform.GetComponent<hookScript>();
								if (component6.m_hookType == hookScript.hookType.holder || component6.m_hookType == hookScript.hookType.holderFlipped)
								{
									Vector3 position11 = m_rayhits[j].transform.position;
									if (position11.z < num12)
									{
										num12 = position11.z;
										num13 = 0;
										selectionType2 = selectionType.specialHook;
										transform = m_rayhits[j].transform;
										hookScript2 = component6;
										num10 = component6.index;
									}
								}
							}
							else if (!itemHeld && !m_rayhits[j].transform.CompareTag("ui") && !m_rayhits[j].transform.CompareTag("hook") && !m_rayhits[j].transform.CompareTag("shelfStand"))
							{
								Vector3 position12 = m_rayhits[j].transform.position;
								if (position12.z < num12)
								{
									num12 = position12.z;
									num13 = 0;
									selectionType2 = selectionType.occlusion;
									transform = m_rayhits[j].transform;
								}
							}
						}
						if (itemHeld)
						{
							itemScript compareItem = m_selectCurrentItem.GetCompareItem();
							Transform transform2 = null;
							float num16 = float.PositiveInfinity;
							Collider2D[] array = new Collider2D[20];
							Vector2 vector12 = vector10 - compareItem.VisualOffset();
							m_selectCurrentCollider.localPosition = vector12;
							Physics2D.SyncTransforms();
							int num17 = 0;
							num17 = ((!m_selectCurrentColliderPoly.enabled) ? m_selectCurrentColliderCapsule.OverlapCollider(default(ContactFilter2D).NoFilter(), array) : m_selectCurrentColliderPoly.OverlapCollider(default(ContactFilter2D).NoFilter(), array));
							Vector2 vector13 = vector10;
							float num18 = (compareItem.isCombinable ? float.PositiveInfinity : 0.3f);
							num14 = Physics2D.RaycastNonAlloc(vector10, Vector2.zero, m_rayhits);
							for (int k = 0; k < num17; k++)
							{
								if (array[k].transform.CompareTag("item"))
								{
									Vector3 position13 = array[k].transform.position;
									itemScript component7 = array[k].transform.GetComponent<itemScript>();
									float sqrMagnitude = (vector13 - (Vector2)array[k].bounds.center).sqrMagnitude;
									bool flag12 = false;
									if (selectionType2 == selectionType.usableDrawer || selectionType2 == selectionType.occlusionDrawer || selectionType2 == selectionType.occlusion || selectionType2 == selectionType.item)
									{
										int num19 = Mathf.Max(component7.maskLevel, component7.sortingLayer);
										if (num19 > num13 || (num19 == num13 && position13.z < num12))
										{
											flag12 = true;
										}
									}
									else if (position13.z < num12)
									{
										flag12 = true;
									}
									if (!flag12 || !(sqrMagnitude < num18))
									{
										continue;
									}
									if (!compareItem.isNonFlatState && component7.StackCheckIncludeTurned(compareItem) && component7.StackValid(zone.GetGridSize(component7), compareItem))
									{
										if ((selectionType2 != selectionType.usableDrawer && selectionType2 != selectionType.occlusionDrawer) || Mathf.Max(component7.maskLevel, component7.sortingLayer) >= num13)
										{
											num13 = Mathf.Max(component7.maskLevel, component7.sortingLayer);
											selectionType2 = (component7.StackCheck(compareItem) ? selectionType.itemStack : selectionType.itemStackFlipped);
											itemScript2 = component7;
											num10 = component7.Node();
											num18 = sqrMagnitude;
										}
									}
									else if (m_selectCurrentItem.isOnHanger && component7.HangerCheck() && component7.m_hangerType == compareItem.m_hangerType && component7.isOnRack && compareItem.hangerSize <= zone.GetGridSize(component7.Node()))
									{
										num13 = 0;
										selectionType2 = selectionType.itemHanger;
										itemScript2 = component7;
										num10 = component7.Node();
										num18 = sqrMagnitude;
									}
									else if (compareItem.isHangable && !compareItem.isOnHanger && component7.HangerCheck() && component7.m_hangerType == compareItem.m_hangerType && !component7.isOnRack)
									{
										num13 = 0;
										selectionType2 = selectionType.itemClothesOverHanger;
										itemScript2 = component7;
										num10 = component7.Node();
										num18 = sqrMagnitude;
									}
									else if (compareItem.isOnRack && compareItem.HangerCheck() && component7.isHangable && component7.m_hangerType == compareItem.m_hangerType)
									{
										num13 = Mathf.Max(component7.maskLevel, component7.sortingLayer);
										selectionType2 = selectionType.itemHangerOverClothes;
										itemScript2 = component7;
										num10 = component7.Node();
										num18 = sqrMagnitude;
									}
									else if (compareItem.isOnCombine && component7.CombineCheck(m_selectCurrentItem) && zone.GetGridSize(component7) >= compareItem.m_sizeCombine)
									{
										num13 = Mathf.Max(component7.maskLevel, component7.sortingLayer);
										selectionType2 = selectionType.itemCombine;
										itemScript2 = component7;
										num10 = component7.Node();
										num18 = sqrMagnitude;
									}
								}
								else if ((compareItem.isOnHook || compareItem.isOnHolder) && array[k].transform.CompareTag("hook"))
								{
									hookScript component8 = array[k].transform.GetComponent<hookScript>();
									if (((compareItem.isOnHook && (component8.m_hookType == hookScript.hookType.hook || component8.m_hookType == hookScript.hookType.hookFlipped)) || (compareItem.isOnHolder && (component8.m_hookType == hookScript.hookType.holder || component8.m_hookType == hookScript.hookType.holderFlipped))) && compareItem.hookSize <= zone.GetGridSize(component8.index))
									{
										_ = array[k].transform.position;
										float sqrMagnitude2 = (vector13 - (Vector2)array[k].bounds.center).sqrMagnitude;
										if (sqrMagnitude2 < num18)
										{
											num13 = 0;
											selectionType2 = selectionType.specialHook;
											transform = array[k].transform;
											hookScript2 = component8;
											num10 = component8.index;
											num18 = sqrMagnitude2;
										}
									}
								}
								else if (array[k].transform.CompareTag("drawer") && !array[k].transform.GetComponent<drawerScript>())
								{
									Vector3 position14 = array[k].transform.position;
									if (position14.z < num12 && position14.z < num16)
									{
										num16 = position14.z;
										transform2 = array[k].transform;
									}
								}
							}
							if (isItem(selectionType2))
							{
								Debug.DrawLine(vector13, itemScript2.GetComponent<Collider2D>().bounds.center, Color.red);
							}
							else if (selectionType2 == selectionType.specialShelf)
							{
								Debug.DrawLine(vector13, transform.GetComponent<Collider2D>().bounds.center, Color.red);
							}
							if (selectionType2 == selectionType.itemCombine)
							{
								num18 = 0f;
							}
							if (selectionType2 == selectionType.none || selectionType2 == selectionType.occlusion || selectionType2 == selectionType.occlusionDrawer || selectionType2 == selectionType.usableDrawer || (isItem(selectionType2) && num18 > 0.03f))
							{
								if (selectionType2 != selectionType.itemShelf && selectionType2 != selectionType.specialShelf)
								{
									int closestGrid = zone.GetClosestGrid(compareItem.isNonFlatState ? vector9 : vector10, _flat: true, 0, compareItem.size, compareItem.xWidth * compareItem.yWidth, num12, (selectionType2 == selectionType.usableDrawer) ? (-1) : m_lastNode, selectionType2 == selectionType.usableDrawer || selectionType2 == selectionType.occlusionDrawer);
									bool flag13 = zone.GetParent(closestGrid).CompareTag("drawer");
									if (closestGrid > -1 && transform2 != null && flag13 && zone.GetGridDepth(closestGrid) > num16)
									{
										if (selectionType2 != selectionType.usableDrawer)
										{
											num12 = num16;
											selectionType2 = selectionType.occlusion;
											transform = transform2;
										}
									}
									else if (closestGrid > -1 && (!isItem(selectionType2) || (vector13 - (Vector2)zone.GetGrid(closestGrid)).sqrMagnitude < num18))
									{
										num9 = closestGrid;
										closestGrid = zone.FitGrid(closestGrid, compareItem.xWidth, compareItem.yWidth, compareItem.size);
										bool flag14 = false;
										if (closestGrid == -1 && compareItem.canTurn && zone.GetStyle(num9) != itemScript.nodeStyle.box)
										{
											closestGrid = zone.FitGrid(num9, compareItem.yWidth, compareItem.xWidth, compareItem.size);
											flag14 = true;
										}
										if (closestGrid > -1)
										{
											num12 = zone.GetGridDepth(closestGrid);
											selectionType2 = (flag14 ? selectionType.gridFlatFlipped : selectionType.gridFlat);
											num10 = closestGrid;
											if (flag14)
											{
												compareItem.GetStackDimentions(out _yWidth, out _xWidth);
											}
											else
											{
												compareItem.GetStackDimentions(out _xWidth, out _yWidth);
											}
										}
										else
										{
											cursorState = uiCursor.cursorState.invalidSpace;
										}
									}
								}
								if (m_selectCurrentItem.isWallable)
								{
									int closestGrid2 = zone.GetClosestGrid(m_selectCurrentItem.isOnWall ? vector10 : vector9, _flat: false, (int)m_selectCurrentItem.m_zonesWall, 0, m_selectCurrentItem.m_xWall * m_selectCurrentItem.m_yWall, num12, m_lastNode);
									if (closestGrid2 > -1)
									{
										num9 = closestGrid2;
										closestGrid2 = zone.FitGrid(closestGrid2, m_selectCurrentItem.m_xWall, m_selectCurrentItem.m_yWall, m_selectCurrentItem.size);
										if (closestGrid2 > -1)
										{
											num12 = zone.GetGridDepth(closestGrid2);
											selectionType2 = ((zone.GetStyle(closestGrid2) == itemScript.nodeStyle.wallLeft) ? selectionType.gridLeft : selectionType.gridRight);
											num10 = closestGrid2;
											_xWidth = m_selectCurrentItem.m_xWall;
											_yWidth = m_selectCurrentItem.m_yWall;
										}
										else
										{
											cursorState = uiCursor.cursorState.invalidSpace;
										}
									}
								}
								if (m_selectCurrentItem.isBarable)
								{
									int closestBar = zone.GetClosestBar(m_selectCurrentItem.isOnBar ? vector10 : vector9, m_selectCurrentItem.barSize, m_selectCurrentItem.m_barWidth, num12, m_lastNode);
									if (closestBar != -1)
									{
										num9 = closestBar;
										bool flag15 = zone.GetStyle(closestBar) == itemScript.nodeStyle.bar;
										closestBar = zone.FitGrid(closestBar, flag15 ? 1 : m_selectCurrentItem.m_barWidth, (!flag15) ? 1 : m_selectCurrentItem.m_barWidth, m_selectCurrentItem.barSize);
										if (closestBar > -1)
										{
											num12 = zone.GetGridDepth(closestBar);
											selectionType2 = selectionType.gridBar;
											num10 = closestBar;
											_xWidth = (flag15 ? 1 : m_selectCurrentItem.m_barWidth);
											_yWidth = ((!flag15) ? 1 : m_selectCurrentItem.m_barWidth);
										}
										else
										{
											cursorState = uiCursor.cursorState.invalidSpace;
										}
									}
								}
								if (m_selectCurrentItem.isRackable)
								{
									int closestRack = zone.GetClosestRack(m_selectCurrentItem.isOnRack ? vector10 : vector9, m_selectCurrentItem.size, num12, m_lastNode);
									if (closestRack > -1)
									{
										num12 = zone.GetGridDepth(closestRack);
										selectionType2 = selectionType.gridRack;
										num9 = closestRack;
										num10 = closestRack;
										_xWidth = 1;
										_yWidth = 1;
									}
								}
							}
							if (flag && IsUsable(selectionType2) && (flag3 || flag4) && ItemTap(m_selectCurrentItem, vector))
							{
								selectionType2 = selectionType.none;
							}
						}
						if (m_state == gameState.pack && (m_selectCurrentBox != null || m_editCurrentItem != null))
						{
							Vector3 vector14 = vector9 - m_offset;
							int num20 = ((m_selectCurrentBox != null) ? m_selectCurrentBox.xWidth : m_editCurrentItem.packMovableX);
							int num21 = ((m_selectCurrentBox != null) ? m_selectCurrentBox.yWidth : m_editCurrentItem.packMovableY);
							int size2 = ((m_selectCurrentBox != null) ? m_selectCurrentBox.size : m_editCurrentItem.m_size);
							int closestGrid3 = zone.GetClosestGrid(vector14, _flat: true, 0, size2, num20 * num21, num12, m_lastNode);
							if (closestGrid3 > -1)
							{
								num9 = closestGrid3;
								closestGrid3 = zone.FitGrid(closestGrid3, num20, num21, size2);
								if (closestGrid3 > -1)
								{
									num12 = zone.GetGridDepth(closestGrid3);
									selectionType2 = selectionType.gridFlat;
									num10 = closestGrid3;
									_xWidth = num20;
									_yWidth = num21;
								}
							}
						}
						if (selectionType2 == selectionType.gridFlatFlipped || selectionType2 == selectionType.itemStackFlipped)
						{
							int num22 = ((flag9 || (m_selectCurrentItem.m_rotateType == itemScript.RotateType.leftFacing && m_selectCurrentItem.flipped()) || (m_selectCurrentItem.m_rotateType == itemScript.RotateType.rightFacing && !m_selectCurrentItem.flipped())) ? 1 : (-1));
							if (flag9 && m_selectCurrentItem.m_flipType != itemScript.flipType.FourWay)
							{
								num22 = -1;
							}
							m_selectCurrentItem.AdvanceStateAutoRotate(num22);
							HistoryRecord(ha.itemRotate, num22);
							switch (selectionType2)
							{
							case selectionType.gridFlatFlipped:
								selectionType2 = selectionType.gridFlat;
								break;
							case selectionType.itemStackFlipped:
								selectionType2 = selectionType.itemStack;
								break;
							}
							if (flag9 && m_selectCurrentItem.m_flipType != itemScript.flipType.FourWay)
							{
								flag9 = false;
							}
						}
						if (selectionType2 == selectionType.gridFlat || selectionType2 == selectionType.gridLeft || selectionType2 == selectionType.gridRight || selectionType2 == selectionType.gridBar || selectionType2 == selectionType.gridRack)
						{
							num8 = num9;
						}
					}
					if (flag9)
					{
						string audioTurn = m_selectCurrentItem.GetAudioTurn(m_audioTurnItem);
						if (!string.IsNullOrEmpty(audioTurn))
						{
							AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
							akAuxSendArray.Add(reverbID, 1f);
							AkSoundEngine.SetGameObjectAuxSendValues(m_selectCurrentItem.audioGO, akAuxSendArray, 1u);
							AkSoundEngine.PostEvent(audioTurn, m_selectCurrentItem.audioGO);
						}
					}
					if (IsUsable(selectionType2) || (selectionType2 == selectionType.box && transform.GetComponent<boxScript>().ClosedOrEmpty()))
					{
						cursorState = uiCursor.cursorState.use;
					}
					else if (selectionType2 != selectionType.none && selectionType2 != selectionType.occlusion && selectionType2 != selectionType.occlusionDrawer && (!itemHeld || selectionType2 != selectionType.box))
					{
						cursorState = uiCursor.cursorState.valid;
					}
					if (m_state == gameState.play || m_state == gameState.arrange)
					{
						if (IsUsable(selectionType2) && (flag3 || (flag && itemHeld && flag4)))
						{
							switch (selectionType2)
							{
							case selectionType.usableDrawer:
							{
								if (!(transform.GetComponent<drawerScript>() != null))
								{
									break;
								}
								List<int> _useList = new List<int>();
								transform.GetComponent<drawerScript>().Use(ref _useList);
								foreach (int item in _useList)
								{
									HistoryRecord(ha.stageUse, item);
								}
								break;
							}
							case selectionType.usableDoorHinge:
							{
								List<int> _useList2 = new List<int>();
								transform.GetComponent<doorScript>().Use(ref _useList2);
								foreach (int item2 in _useList2)
								{
									HistoryRecord(ha.stageUse, item2);
								}
								break;
							}
							case selectionType.usableDoorSlide:
							{
								doorSlidingScript component10 = transform.GetComponent<doorSlidingScript>();
								if ((bool)component10)
								{
									int num24 = component10.Use();
									if (num24 > -1)
									{
										HistoryRecord(ha.stageUse, num24);
									}
								}
								else
								{
									int num25 = transform.GetComponent<doorSlidingProxyScript>().Use();
									if (num25 > -1)
									{
										HistoryRecord(ha.stageUse, num25);
									}
								}
								break;
							}
							case selectionType.usableDoorFold:
							{
								int num23 = transform.GetComponent<doorFoldingScript>().Use();
								if (num23 > -1)
								{
									HistoryRecord(ha.stageUse, num23);
								}
								break;
							}
							case selectionType.boxEmpty:
							{
								boxScript component9 = transform.GetComponent<boxScript>();
								int _variant = 0;
								int _state = -1;
								component9.Use(zone, out _variant, out _state);
								AkAuxSendArray akAuxSendArray2 = new AkAuxSendArray();
								akAuxSendArray2.Add(reverbID, 1f);
								AkSoundEngine.SetGameObjectAuxSendValues(component9.audioGO, akAuxSendArray2, 1u);
								AkSoundEngine.PostEvent(m_audioCloseBox, component9.audioGO);
								Vibration(vibrationScript.moment.boxClear, vector.x / (float)Screen.width);
								bool flag16 = true;
								zoneScript[] zones = m_zones;
								for (int i = 0; i < zones.Length; i++)
								{
									if (zones[i].BoxesRemain())
									{
										flag16 = false;
										break;
									}
								}
								if (flag16)
								{
									EndModeStart();
								}
								else if (!zone.BoxesRemain())
								{
									m_zoneHintCountdown = true;
									m_zoneHintTimer = 2f;
								}
								HistoryRecord(ha.boxClear, zone.GetBoxIndex(component9));
								FileSaveAction();
								break;
							}
							case selectionType.usableGeneric:
								transform.SendMessage("Use", null, SendMessageOptions.DontRequireReceiver);
								break;
							}
							if (flag && itemHeld)
							{
								m_inputIgnoreRestOfTouch = true;
								PositionTouchControls();
								if (m_lastNode > -1 && !zone.GetGridActive(m_lastNode))
								{
									m_selectCurrentItem.Position(m_selectCurrentItem.m_artPivot.position + m_selectCurrentItem.VisualOffset(), itemScript.positionAction.unplacable, _unboxed: false, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
									m_inputTouchNode = -1;
								}
							}
						}
						else if (!itemHeld && selectionType2 == selectionType.usableGeneric && num == 1)
						{
							transform.SendMessage("Use", null, SendMessageOptions.DontRequireReceiver);
						}
						else if (itemHeld)
						{
							itemScript itemScript3 = ((selectionType2 == selectionType.itemStack || selectionType2 == selectionType.itemStackFlipped || selectionType2 == selectionType.gridFlat || selectionType2 == selectionType.gridFlatFlipped) ? m_selectCurrentItem.GetCompareItem() : m_selectCurrentItem);
							if (m_lastShelf != shelfStandScript2)
							{
								if (m_lastShelf != null)
								{
									m_lastShelf.ResetPosition();
									m_lastShelf.AdjustAllOffsets(m_selectCurrentItem.standPixelSize);
								}
								m_lastShelf = shelfStandScript2;
							}
							if (m_unboxed != null && selectionType2 != selectionType.box && selectionType2 != selectionType.boxEmpty)
							{
								m_unboxed = null;
							}
							Vector3 vector15 = vector10;
							int maskLevel = 0;
							if (IsGrid(selectionType2))
							{
								vector15 = zone.GetGrid(num10);
								maskLevel = zone.GetMaskLevel(num10, itemScript3.xWidth, itemScript3.yWidth);
								switch (selectionType2)
								{
								case selectionType.gridFlat:
									if (itemScript3.isNonFlatState && m_selectCurrentItem.hangerChild == null)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.gridLeft:
								case selectionType.gridRight:
									if (!itemScript3.isOnWall)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.gridBar:
									if (!itemScript3.isOnBar)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.gridRack:
									if (!m_selectCurrentItem.isOnRack)
									{
										m_offset = Vector3.zero;
									}
									break;
								}
							}
							else
							{
								switch (selectionType2)
								{
								case selectionType.itemStack:
									vector15 = itemScript2.StackPosition(itemScript3);
									maskLevel = itemScript2.maskId;
									if (itemScript3.isNonFlatState && m_selectCurrentItem.hangerChild == null)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.specialHook:
									vector15 = hookScript2.position;
									if (itemScript3.isHookable && !itemScript3.isOnHook)
									{
										m_offset = Vector3.zero;
										m_offset = vector9 - vector15;
										m_offset.z = 0f;
									}
									break;
								case selectionType.itemHanger:
									vector15 = itemScript2.HangerPosition(itemScript3);
									maskLevel = itemScript2.maskId;
									if (itemScript2.isOnRack && !itemScript3.isOnHanger)
									{
										m_offset = vector9 - vector15;
										m_offset.x *= 0.5f;
										m_offset.z = 0f;
									}
									break;
								case selectionType.itemHangerOverClothes:
									vector15 = itemScript2.StackPosition(itemScript3);
									maskLevel = itemScript2.maskId;
									break;
								case selectionType.itemClothesOverHanger:
									vector15 = itemScript2.StackPosition(itemScript3);
									maskLevel = itemScript2.maskId;
									if (itemScript3.isNonFlatState)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.itemShelf:
								case selectionType.specialShelf:
									vector15 = shelfStandScript2.GetPosition(itemScript3, num11);
									maskLevel = zone.GetMaskLevel(num10, 1, 1);
									if (!itemScript3.isOnShelf)
									{
										m_offset = Vector3.zero;
									}
									break;
								case selectionType.itemCombine:
									vector15 = itemScript2.CombinePosition(itemScript3.combineDepth);
									maskLevel = itemScript2.maskId;
									if (!itemScript3.isOnCombine)
									{
										m_offset = Vector3.up * itemScript3.m_sizeCombine * 0.17f * 0.5f;
									}
									break;
								default:
									vector15.z = -1f;
									break;
								}
							}
							bool flag17 = IsPlacable(selectionType2);
							if (m_appearValid && (flag17 || Vector2.Distance(vector9, m_appearValidPos) > 0.25f))
							{
								m_appearValid = false;
							}
							if ((flag ? flag5 : flag3) && !m_editorOverGUI && flag17)
							{
								AudioLiftEnd();
								if (selectionType2 == selectionType.itemClothesOverHanger)
								{
									AudioPickup(itemScript2);
									HistoryRecord(ha.itemPickUp, zone.GetItemIndex(itemScript2), itemScript2.Node());
									zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: false, itemScript2.size);
									itemScript2.RemoveItems(zone);
									Vector3 vector16 = Vector3.forward * -0.002f;
									float num26 = (float)itemScript2.xWidth / 2f;
									float num27 = (float)itemScript2.yWidth / 2f;
									vector16.x = (num26 - num27) * 0.14f;
									vector16.y = (float)itemScript2.stackPixelSize * 0.01f + Mathf.Ceil((num26 + num27) * 0.07f * 100f) * 0.01f + 0.18f;
									vector15 += vector16;
									m_selectCurrentItem.Hanger(itemScript2);
									m_selectCurrentItem.Position(Vector3.zero, itemScript.positionAction.hover, _unboxed: false, null, -1, 0, 0, itemScript2.m_artPivot, itemScript.nodeStyle.flat, 0);
									m_selectCurrentItem = itemScript2;
									m_selectCurrentItem.Position(vector15, itemScript.positionAction.hover, _unboxed: false, null, m_selectCurrentItem.Node(), 0, 0, null, itemScript.nodeStyle.flat, 0);
									m_selectCurrentItem.AlignHangerChild();
									selectCollisionSet(m_selectCurrentItem.hangerChild);
								}
								else if (selectionType2 == selectionType.itemHangerOverClothes)
								{
									AudioPickup(itemScript2);
									HistoryRecord(ha.itemPickUp, zone.GetItemIndex(itemScript2), itemScript2.Node());
									itemScript itemScript4 = null;
									Vector3 position15;
									if (itemScript2.Stacked())
									{
										itemScript4 = itemScript2.StackParent();
										position15 = itemScript4.StackPosition(itemScript2);
										Vector2 stackDimentions = itemScript2.GetStackDimentions();
										int startIndex = itemScript2.Node();
										int usedSize = itemScript2.Unstack();
										zone.SetGrid(startIndex, (int)stackDimentions.x, (int)stackDimentions.y, _used: true, usedSize);
									}
									else
									{
										position15 = zone.GetGrid(itemScript2.Node());
										zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: false, itemScript2.size);
									}
									position15.z += 0.002f;
									int foreground = ((itemScript4 != null) ? zone.GetGridForeground(itemScript4.Node(), itemScript4.xWidth, itemScript4.yWidth) : zone.GetGridForeground(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth));
									itemScript2.RemoveItems(zone);
									itemScript2.Position(position15, itemScript.positionAction.hover, _unboxed: false, null, num10, maskLevel, foreground, itemScript3.m_artPivot, zone.GetStyle(num10), zone.GetBoxSize(num10));
									itemScript2.Hanger(itemScript3);
									itemScript3.AlignHangerChild();
									selectCollisionSet(itemScript2);
								}
								else
								{
									itemScript.nodeStyle num28;
									switch (selectionType2)
									{
									default:
										num28 = zone.GetStyle(num10);
										break;
									case selectionType.itemHanger:
										num28 = itemScript2.HangerStyle();
										break;
									case selectionType.itemShelf:
									case selectionType.specialShelf:
										num28 = shelfStandScript2.NodeStyle();
										break;
									case selectionType.itemCombine:
										num28 = itemScript2.CombineStyle();
										break;
									}
									itemScript.nodeStyle style = num28;
									Transform parent = ((selectionType2 == selectionType.itemStack || selectionType2 == selectionType.itemHanger || selectionType2 == selectionType.itemCombine) ? itemScript2.m_artPivot : zone.GetParent(num10));
									int foreground2 = ((selectionType2 != selectionType.itemStack && selectionType2 != selectionType.itemCombine) ? zone.GetGridForeground(num10, itemScript3.xValidate, itemScript3.yValidate) : zone.GetGridForeground(num10, itemScript2.xValidate, itemScript2.yValidate));
									itemScript.positionAction action = ((!IsStack(selectionType2) || !itemScript3.m_stackInheritValid) ? (zone.IsItemValid(itemScript3, IsStack(selectionType2) ? itemScript2 : itemScript3, num10, style) ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid) : (itemScript2.isValid ? itemScript.positionAction.placedValid : itemScript.positionAction.placedInvalid));
									itemScript3.Position(vector15, action, selectionType2 == selectionType.box, IsStack(selectionType2) ? itemScript2 : null, num10, maskLevel, foreground2, parent, style, zone.GetBoxSize(num10));
									SetItemPins(num10, itemScript3);
									switch (selectionType2)
									{
									case selectionType.itemStack:
									{
										int usedSize3 = itemScript3.Stack(itemScript2);
										Vector2 stackDimentions3 = itemScript2.GetStackDimentions();
										zone.SetGrid(num10, (int)stackDimentions3.x, (int)stackDimentions3.y, _used: true, usedSize3);
										break;
									}
									case selectionType.itemCombine:
									{
										int usedSize2 = itemScript3.Combine(itemScript2);
										Vector2 stackDimentions2 = itemScript2.GetStackDimentions();
										zone.SetGrid(num10, (int)stackDimentions2.x, (int)stackDimentions2.y, _used: true, usedSize2);
										break;
									}
									case selectionType.itemHanger:
										itemScript3.Hanger(itemScript2);
										zone.SetGrid(num10, 1, 1, _used: true, itemScript2.size);
										break;
									case selectionType.specialHook:
										itemScript3.Hook(hookScript2);
										zone.SetGrid(num10, 1, 1, _used: true, itemScript3.hookSize);
										break;
									case selectionType.itemShelf:
									case selectionType.specialShelf:
										shelfStandScript2.AddItem(itemScript3, num11);
										break;
									case selectionType.gridLeft:
									case selectionType.gridRight:
										zone.SetGrid(num10, itemScript3.m_xWall, itemScript3.m_yWall, _used: true, itemScript3.size);
										break;
									case selectionType.gridBar:
									{
										bool flag18 = zone.GetStyle(num10) == itemScript.nodeStyle.bar;
										zone.SetGrid(num10, flag18 ? 1 : itemScript3.m_barWidth, (!flag18) ? 1 : itemScript3.m_barWidth, _used: true, itemScript3.barSize);
										break;
									}
									case selectionType.gridRack:
										zone.SetGrid(num10, 1, 1, _used: true, itemScript3.size);
										break;
									default:
										zone.SetGrid(num10, itemScript3.xWidth, itemScript3.yWidth, _used: true, itemScript3.size);
										break;
									}
									TutorialTurnHide();
									TutorialZoneChangeHide();
									if (selectionType2 == selectionType.itemShelf || selectionType2 == selectionType.specialShelf)
									{
										HistoryRecord(ha.itemShelf, num11);
									}
									HistoryRecord(ha.itemPlace, num10);
									if (m_selectCurrentItem != itemScript3)
									{
										itemScript3.Unhanger();
										selectCollisionSet(m_selectCurrentItem);
									}
									else if (m_selectCurrent != -1 && m_selectRepeat)
									{
										m_selectCurrentItem = UnityEngine.Object.Instantiate(m_itemTypes[m_selectCurrent]);
										m_selectCurrentState = selectionState.held;
										m_selectCurrentItem.SetState(0);
										m_selectCurrentItem.SetVariant(m_selectCurrentVariant);
										m_selectCurrentItem.Position(vector15, itemScript.positionAction.unplacable, m_unboxed, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
										selectCollisionSet(m_selectCurrentItem);
									}
									else
									{
										m_selectCurrentItem = null;
										selectCollisionSet(null);
										m_selectCurrent = -1;
										m_selectCurrentState = selectionState.none;
										m_lastShelf = null;
									}
									AudioPlace(itemScript3);
									Vibration(itemScript3.m_heavy ? vibrationScript.moment.itemPlaceHeavy : vibrationScript.moment.itemPlace, vector.x / (float)Screen.width);
									itemScript3.AddItems(zone);
									if (itemScript3.m_plant && itemScript3.isValid && EvaluatePlants())
									{
										statsScript.AwardSticker(statsScript.stickers.sticker_plant);
									}
									if (m_selectCurrentItem == null)
									{
										ShelfOffset(0);
										zone.OffsetByStackID(itemScript3.m_stackAllowed, _active: false);
									}
									else
									{
										if (m_selectCurrentItem.isStandable)
										{
											ShelfOffset(m_selectCurrentItem);
										}
										if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
										{
											zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
										}
									}
									if (m_state == gameState.play && m_phase == gamePhase.validate && m_selectCurrentItem == null)
									{
										EvaluateStar();
									}
								}
								if (flag)
								{
									PositionTouchControls();
								}
								FileSaveAction();
							}
							else
							{
								if (selectionType2 != selectionType.gridRack && itemScript3 != m_selectCurrentItem)
								{
									Vector3 vector17 = Vector3.forward * -0.002f;
									float num29 = (float)itemScript3.xWidth / 2f;
									float num30 = (float)itemScript3.yWidth / 2f;
									vector17.x = (num29 - num30) * 0.14f;
									vector17.y = (float)itemScript3.stackPixelSize * 0.01f + Mathf.Ceil((num29 + num30) * 0.07f * 100f) * 0.01f + 0.18f;
									vector15 += vector17;
								}
								itemScript.nodeStyle num31;
								switch (selectionType2)
								{
								default:
									num31 = zone.GetStyle(num10);
									break;
								case selectionType.itemHanger:
									num31 = itemScript2.HangerStyle();
									break;
								case selectionType.itemShelf:
								case selectionType.specialShelf:
									num31 = shelfStandScript2.NodeStyle();
									break;
								case selectionType.itemCombine:
									num31 = itemScript2.CombineStyle();
									break;
								}
								itemScript.nodeStyle style2 = num31;
								int foreground3 = (IsStack(selectionType2) ? zone.GetGridForeground(num10, itemScript2.xWidth, itemScript2.yWidth) : zone.GetGridForeground(num10, itemScript3.xWidth, itemScript3.yWidth));
								int num32 = m_selectCurrentItem.GetCompareItem().GetState();
								m_selectCurrentItem.Position(vector15, flag17 ? itemScript.positionAction.hover : itemScript.positionAction.unplacable, m_unboxed != null || m_appearValid || flag10, IsStack(selectionType2) ? itemScript2 : null, -1, maskLevel, foreground3, zone.GetParent(num10), style2, zone.GetBoxSize(num10));
								m_selectCurrentItem.CursorPosition(vector9 + m_offset);
								if (num32 != m_selectCurrentItem.GetCompareItem().GetState())
								{
									selectCollisionSet(itemScript3);
								}
								SetItemPins(num10, itemScript3);
							}
						}
						else if (selectionType2 != selectionType.none && !m_editorOverGUI)
						{
							if (flag3)
							{
								switch (selectionType2)
								{
								case selectionType.item:
									AudioLiftEnd();
									m_inputIgnoreRelease = true;
									m_inputDragDistance = 0f;
									m_selectCurrentItem = itemScript2;
									OnItemPicked(m_selectCurrentItem);
									selectCollisionSet(m_selectCurrentItem.GetCompareItem());
									m_selectCurrentState = selectionState.held;
									m_selectCurrentVariant = m_selectCurrentItem.GetVariant();
									m_offset = m_selectCurrentItem.GetOffset(vector9);
									if (m_state == gameState.play)
									{
										if (!flag)
										{
											TutorialTurnCheck();
										}
										TutorialZoneChangeCheck();
									}
									num8 = m_selectCurrentItem.Node();
									if (flag)
									{
										m_inputTouchNode = num8;
									}
									if (!flag || !m_selectCurrentItem.CanInteract())
									{
										LiftItem();
									}
									else
									{
										DelayLiftItem();
									}
									break;
								case selectionType.box:
								{
									boxScript component11 = transform.GetComponent<boxScript>();
									int _variant2 = 0;
									int _state2 = -1;
									int num33 = component11.Use(zone, out _variant2, out _state2);
									if (num33 > -1)
									{
										m_selectCurrentItem = UnityEngine.Object.Instantiate(m_itemTypes[num33]);
										OnItemPicked(m_selectCurrentItem);
										if (m_selectCurrentItem.isStandable)
										{
											ShelfOffset(m_selectCurrentItem);
										}
										if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
										{
											zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
										}
										m_selectCurrentItem.SetVariant(_variant2);
										m_selectCurrentItem.SetState(_state2);
										selectCollisionSet(m_selectCurrentItem);
										if (!flag)
										{
											TutorialTurnCheck();
										}
										TutorialZoneChangeCheck();
										m_unboxed = transform;
										m_offset = Vector3.zero;
										m_selectCurrentItem.Position(vector9, itemScript.positionAction.unplacable, _unboxed: true, null, -1, 0, 0, null, itemScript.nodeStyle.flat, 0);
										m_selectCurrentItem.GetRaiseArt(out var _main, out var _back, out var _flipped, out var _flippedBack, out var _offset);
										m_selectCurrentBezier = component11.RaiseItemStart(_main, _back, _flipped, _flippedBack, _offset, m_selectCurrentItem.m_xWidth * m_selectCurrentItem.m_yWidth * m_selectCurrentItem.m_size);
										if (m_selectCurrentBezier.Length != 0)
										{
											m_selectCurrentBezierLerp = 0f;
											m_selectCurrentBezierBox = component11;
											m_selectCurrentState = selectionState.raise;
											m_selectCurrentItem.gameObject.SetActive(value: false);
											if (m_selectCurrentItem.isOnHanger || m_selectCurrentItem.isOnBar)
											{
												m_offset = Vector2.up * Mathf.Min(3, m_selectCurrentItem.hangerSize - 2) * -0.17f;
												m_selectCurrentBezierSpeed = Mathf.Lerp(2f, 3f, Mathf.InverseLerp(9f, 5f, m_selectCurrentItem.hangerSize));
											}
											else
											{
												m_offset = Vector2.zero;
												m_selectCurrentBezierSpeed = 3f;
											}
										}
										else
										{
											m_selectCurrentState = selectionState.held;
										}
										AkAuxSendArray akAuxSendArray3 = new AkAuxSendArray();
										akAuxSendArray3.Add(reverbID, 1f);
										AkSoundEngine.SetGameObjectAuxSendValues(component11.audioGO, akAuxSendArray3, 1u);
										AkSoundEngine.PostEvent("Play_paper_rustle", component11.audioGO);
										if ((bool)m_todScript)
										{
											m_todScript.IncreaseItem();
										}
										HistoryRecord(ha.boxTake, zone.GetBoxIndex(component11));
									}
									else if (num33 == -2)
									{
										AkAuxSendArray akAuxSendArray4 = new AkAuxSendArray();
										akAuxSendArray4.Add(reverbID, 1f);
										AkSoundEngine.SetGameObjectAuxSendValues(component11.audioGO, akAuxSendArray4, 1u);
										AkSoundEngine.PostEvent(m_audioOpenBox, component11.audioGO);
										HistoryRecord(ha.boxOpen, zone.GetBoxIndex(component11));
										FileSaveAction();
										Vibration(vibrationScript.moment.boxOpen, vector.x / (float)Screen.width);
									}
									break;
								}
								}
							}
							else if (selectionType2 == selectionType.item && inputHandler.IsPressed(InputAction.Gameplay_TurnAndInteract, ignoreInputHandled: true) && itemScript2.Interact())
							{
								HistoryRecord(ha.itemInteract, zone.GetItemIndex(itemScript2));
								FileSaveAction();
							}
						}
					}
					else if (m_state == gameState.pack)
					{
						if (m_selectCurrentBox != null)
						{
							if (Input.GetMouseButtonDown(1))
							{
								m_selectCurrentBox.Turn();
							}
							Vector3 position16 = vector9 - m_offset;
							position16.z = -1f;
							boxScript boxScript2 = null;
							bool flag19 = false;
							switch (selectionType2)
							{
							case selectionType.box:
								boxScript2 = transform.GetComponent<boxScript>().GetBox();
								position16 = boxScript2.GetStackPosition();
								num10 = boxScript2.Node();
								flag19 = true;
								break;
							case selectionType.gridFlat:
								position16 = zone.GetGrid(num10);
								flag19 = true;
								break;
							default:
							{
								int num34 = Mathf.CeilToInt((float)(m_selectCurrentBox.xWidth - 1) / 2f);
								int num35 = Mathf.CeilToInt((float)(m_selectCurrentBox.yWidth - 1) / 2f);
								position16 -= new Vector3(0.14f, 0.07f) * num34 + new Vector3(-0.14f, 0.07f) * num35;
								break;
							}
							}
							if (Input.GetMouseButtonDown(0) && !m_editorOverGUI && flag19)
							{
								if (flag19)
								{
									m_selectCurrentBox.Place(position16, num10, boxScript2, zone.transform);
									if (!(boxScript2 != null))
									{
										zone.SetGrid(num10, m_selectCurrentBox.xWidth, m_selectCurrentBox.yWidth, _used: true, m_selectCurrentBox.size);
									}
									zone.AddBox(m_selectCurrentBox);
									m_selectCurrentBoxIndex = -1;
									m_selectCurrentBox = null;
								}
							}
							else
							{
								m_selectCurrentBox.Hover(position16, boxScript2, flag19);
							}
						}
						else if (m_editCurrentItem != null)
						{
							if (Input.GetMouseButtonDown(1))
							{
								m_editCurrentItem.PackMovableAdvanceState();
							}
							if (selectionType2 == selectionType.gridFlat)
							{
								m_editCurrentItem.PackMovablePlace(zone.GetGrid(num10), _valid: true, zone.GetParent(num10));
								m_editCurrentItem.PackMovableBright(!Input.GetMouseButtonDown(0));
								if (Input.GetMouseButtonDown(0))
								{
									if (m_editCurrentItem.Node() != num10)
									{
										zone.SetGrid(num10, m_editCurrentItem.packMovableX, m_editCurrentItem.packMovableY, _used: true, m_editCurrentItem.packMovableSize);
										zone.SaveItems(_auto: true);
									}
									else
									{
										m_editCurrentItem.PackMovableRemove();
										if (zone.GetIsFlatSurface(m_editCurrentItem.Node()) && !m_editCurrentItem.Stacked())
										{
											zone.SetGrid(m_editCurrentItem.Node(), m_editCurrentItem.xWidth, m_editCurrentItem.yWidth, _used: true, m_editCurrentItem.size);
										}
									}
									m_editCurrentItem = null;
								}
							}
							else
							{
								m_editCurrentItem.PackMovablePlace(vector9, _valid: false, null);
								if (Input.GetMouseButtonDown(0))
								{
									m_editCurrentItem.PackMovableRemove();
									if (zone.GetIsFlatSurface(m_editCurrentItem.Node()) && !m_editCurrentItem.Stacked())
									{
										zone.SetGrid(m_editCurrentItem.Node(), m_editCurrentItem.xWidth, m_editCurrentItem.yWidth, _used: true, m_editCurrentItem.size);
									}
									m_editCurrentItem = null;
								}
							}
						}
						else if (!m_editorOverGUI && (Input.GetMouseButtonDown(0) || Input.GetMouseButtonDown(1)))
						{
							if (IsUsable(selectionType2) && Input.GetMouseButtonDown(0))
							{
								switch (selectionType2)
								{
								case selectionType.usableDrawer:
									if (transform.GetComponent<drawerScript>() != null)
									{
										List<int> _useList4 = new List<int>();
										transform.GetComponent<drawerScript>().Use(ref _useList4);
									}
									break;
								case selectionType.usableDoorHinge:
								{
									List<int> _useList3 = new List<int>();
									transform.GetComponent<doorScript>().Use(ref _useList3);
									break;
								}
								case selectionType.usableDoorSlide:
								{
									doorSlidingScript component12 = transform.GetComponent<doorSlidingScript>();
									if ((bool)component12)
									{
										component12.Use();
									}
									else
									{
										transform.GetComponent<doorSlidingProxyScript>().Use();
									}
									break;
								}
								case selectionType.usableDoorFold:
									transform.GetComponent<doorFoldingScript>().Use();
									break;
								case selectionType.usableGeneric:
									transform.SendMessage("Use", null, SendMessageOptions.DontRequireReceiver);
									break;
								}
							}
							else if (selectionType2 == selectionType.box && m_selectCurrentUnpackMode == 0)
							{
								if (m_editCurrentBox != null)
								{
									m_editCurrentBox.SetEdit(_value: false);
									m_editCurrentBox = null;
								}
								if (Input.GetMouseButtonDown(0))
								{
									m_selectCurrentBox = transform.GetComponent<boxScript>().GetBox();
									if (m_selectCurrentBox.m_stackPosition == 0)
									{
										zone.SetGrid(m_selectCurrentBox.Node(), m_selectCurrentBox.xWidth, m_selectCurrentBox.yWidth, _used: false, m_selectCurrentBox.size);
									}
									Vector3 vector18 = vector9 - m_offset;
									vector18.z = -1f;
									boxScript boxScript3 = m_selectCurrentBox.UnStack();
									if ((bool)boxScript3)
									{
										vector18 = boxScript3.GetStackPosition();
									}
									else
									{
										vector18 = m_selectCurrentBox.transform.position;
										vector18.z -= ((float)Mathf.Min(m_selectCurrentBox.xWidth, m_selectCurrentBox.yWidth) - 1f) * 0.08f;
									}
									m_selectCurrentBox.Hover(vector18, boxScript3, _valid: true);
									zone.RemoveBox(m_selectCurrentBox);
								}
								else if (Input.GetMouseButtonDown(1))
								{
									m_editCurrentBox = transform.GetComponent<boxScript>();
									m_editCurrentBox.SetEdit(zone);
								}
							}
							else if (selectionType2 == selectionType.item)
							{
								if (m_selectCurrentUnpackMode == 0)
								{
									if ((bool)m_editCurrentBox)
									{
										if (Input.GetMouseButtonDown(0))
										{
											zoneScript boxZone = GetBoxZone(m_editCurrentBox);
											bool flag20 = boxZone != zone;
											if (m_editCurrentBox.AddContents(boxZone, itemScript2, flag20))
											{
												zone.SaveItems(_auto: true);
												if (flag20)
												{
													boxZone.SaveItems(_auto: true);
												}
												if (!GetUnpackShow(packShow.boxed))
												{
													itemScript2.gameObject.SetActive(value: false);
												}
											}
											else
											{
												m_editCurrentBoxItemIndex = m_editCurrentBox.SelectItem(itemScript2);
											}
										}
										else if (Input.GetMouseButtonDown(1) && m_editCurrentBox.RemoveContents(itemScript2))
										{
											zone.SaveItems(_auto: true);
											if (GetBoxZone(m_editCurrentBox) != zone)
											{
												GetBoxZone(m_editCurrentBox).SaveItems(_auto: true);
											}
										}
									}
								}
								else if (m_selectCurrentUnpackMode == 1)
								{
									if (Input.GetMouseButtonDown(0))
									{
										if (zone.AddItemUnmovable(itemScript2))
										{
											if (zone.GetIsFlatSurface(itemScript2.Node()) && !itemScript2.Stacked())
											{
												zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: true, itemScript2.size);
											}
											zone.SaveItems(_auto: true);
										}
									}
									else if (Input.GetMouseButtonDown(1) && zone.RemoveItemUnmovable(itemScript2))
									{
										if (zone.GetIsFlatSurface(itemScript2.Node()) && !itemScript2.Stacked())
										{
											zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: false, 0);
										}
										zone.SaveItems(_auto: true);
									}
								}
								else if (m_selectCurrentUnpackMode == 2)
								{
									if (Input.GetMouseButtonDown(0))
									{
										if (zone.AddItemMovable(itemScript2))
										{
											if (zone.GetIsFlatSurface(itemScript2.Node()) && !itemScript2.Stacked())
											{
												zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: true, itemScript2.size);
											}
											zone.SaveItems(_auto: true);
										}
										else if (itemScript2.stackChild == null)
										{
											m_editCurrentItem = itemScript2;
											m_offset = itemScript2.GetOffset(vector9);
											if (m_editCurrentItem.packMovable)
											{
												zone.SetGrid(zone.FindClosestGrid(m_editCurrentItem.packMovablePosition, _flat: true), m_editCurrentItem.packMovableX, m_editCurrentItem.packMovableY, _used: false, 0);
												m_editCurrentItem.PackMovablePlace(vector9 + m_offset, _valid: false, null);
												zone.SaveItems(_auto: true);
											}
											else if (zone.GetIsFlatSurface(m_editCurrentItem.Node()) && !m_editCurrentItem.Stacked())
											{
												zone.SetGrid(m_editCurrentItem.Node(), m_editCurrentItem.xWidth, m_editCurrentItem.yWidth, _used: false, 0);
											}
										}
									}
									else if (Input.GetMouseButtonDown(1))
									{
										if (itemScript2.packMovable)
										{
											zone.SetGrid(zone.FindClosestGrid(itemScript2.packMovablePosition, _flat: true), itemScript2.packMovableX, itemScript2.packMovableY, _used: false, 0);
											itemScript2.PackMovableRemove();
											if (zone.GetIsFlatSurface(itemScript2.Node()) && !itemScript2.Stacked())
											{
												zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: true, itemScript2.size);
											}
											zone.SaveItems(_auto: true);
										}
										else if (zone.RemoveItemMovable(itemScript2))
										{
											if (zone.GetIsFlatSurface(itemScript2.Node()) && !itemScript2.Stacked())
											{
												zone.SetGrid(itemScript2.Node(), itemScript2.xWidth, itemScript2.yWidth, _used: false, 0);
											}
											zone.SaveItems(_auto: true);
										}
									}
								}
							}
							else if (m_editCurrentBox != null && Input.GetMouseButtonDown(1) && GetUnpackShow(packShow.boxes))
							{
								m_editCurrentBox.SetEdit(_value: false);
								m_editCurrentBox = null;
							}
						}
						zone.UpdatePackMovableLines();
					}
				}
				if (flag2 && !m_inputIgnoreRestOfTouch)
				{
					m_lastNode = num8;
				}
				if (flag && flag2 && !m_inputIgnoreRestOfTouch)
				{
					m_inputTouchPosition = vector;
				}
			}
			if (m_cursor != null)
			{
				m_cursor.SetCursorPosition(vector);
				m_cursor.SetCursorState(cursorState);
				if (cursorState == uiCursor.cursorState.use && flag3)
				{
					m_cursor.Click();
				}
				m_tutorialTurnArt.transform.localPosition = m_cursor.transform.localPosition * m_unscaleSize;
			}
			if (m_tutorialTurnLerp > 0f || m_tutorialTurn == tutorialState.showing)
			{
				if (m_tutorialTurn == tutorialState.showing)
				{
					float tutorialTurnLerp = m_tutorialTurnLerp;
					m_tutorialTurnLerp = Mathf.MoveTowards(m_tutorialTurnLerp, 1f, Time.deltaTime * 4f);
					if (tutorialTurnLerp < 1f && m_tutorialTurnLerp == 1f)
					{
						m_tutorialTurnArt.GetComponent<Animator>().speed = 1f;
					}
					m_tutorialTurnFade = tutorialTurnLerp < 1f;
				}
				else if (m_tutorialTurnLerp > 0f)
				{
					m_tutorialTurnLerp = Mathf.MoveTowards(m_tutorialTurnLerp, 0f, Time.deltaTime * ((m_tutorialTurn == tutorialState.none) ? 6f : 1.5f));
					if (Mathf.Approximately(m_tutorialTurnLerp, 0f))
					{
						m_tutorialTurnArt.gameObject.SetActive(value: false);
					}
					m_tutorialTurnFade = true;
				}
			}
			if (m_showValidGrid && m_selectCurrentItem != m_showValidGridPrevious)
			{
				zone.ShowGridValid(m_selectCurrentItem);
				m_showValidGridPrevious = m_selectCurrentItem;
			}
			if (m_phase == gamePhase.unpack && m_endModeActive)
			{
				m_endModeTimer -= Time.deltaTime;
				if (m_ValidateButton.gameObject.activeSelf)
				{
					m_ValidateButton.GetComponent<RectTransform>().anchoredPosition = new Vector2(-84f, -12f + Mathf.Round(Mathf.Pow(m_endModeTimer * 3f, 3f) * 40f));
					if (m_endModeTimer <= 0f)
					{
						m_ValidateButton.interactable = true;
					}
				}
				if (m_endModeTimer <= 0f)
				{
					phase = gamePhase.validate;
				}
			}
			if (m_itemBounce.Count > 0)
			{
				for (int l = 0; l < m_itemBounce.Count; l++)
				{
					m_itemBounce[l].bounceValue = Mathf.MoveTowards(m_itemBounce[l].bounceValue, 0f, Time.deltaTime * 8f);
					m_itemBounce[l].Bounce(Mathf.RoundToInt(m_itemBounce[l].bounceValue * 2f));
					if (m_itemBounce[l].bounceValue.Equals(0f))
					{
						m_itemBounce.RemoveAt(l);
						l--;
					}
				}
			}
		}
		else if (m_cursor != null && inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Gamepad)
		{
			m_cursor.SetCursorPosition(inputHandler.CursorPosition);
			m_cursor.SetCursorState(EventSystem.current.IsPointerOverGameObject() ? uiCursor.cursorState.valid : uiCursor.cursorState.none);
		}
		if (m_phase == gamePhase.validate)
		{
			if (m_validation == validationEffect.appear)
			{
				if (m_gameActive)
				{
					m_validationValue += Time.deltaTime * 1f;
				}
				float num36 = Mathf.Round(m_validationSizeCurve.Evaluate(m_validationValue) * 10f) + 1f;
				Color value2 = m_validationColors[0];
				value2.a = Mathf.Pow(Mathf.InverseLerp(10f, 1f, num36), 2f);
				Shader.SetGlobalColor(m_validationShaderColorId, value2);
				Shader.SetGlobalFloat(m_validationShaderOutlineId, num36 * 0.01f);
				if (m_validationValue >= 1f)
				{
					SetValidation(validationEffect.show);
				}
			}
			else
			{
				m_validationPhase = Mathf.Repeat(m_validationPhase + Time.deltaTime * m_validationPulseRate, 1f);
				Color value3 = Color.Lerp(m_validationColors[0], m_validationColors[1], m_validationPulse.Evaluate(m_validationPhase));
				if (m_validation == validationEffect.zoneChange)
				{
					m_validationValue += Time.deltaTime * 2f;
					value3.a = Mathf.InverseLerp(0.5f, 0f, m_validationValue);
					if (m_validationValue >= 1f)
					{
						ConfigureZoneButtons(_active: true);
						SetValidation(zone.isZoneValid ? validationEffect.quickFade : validationEffect.appear);
					}
				}
				else if (m_validation == validationEffect.quickFade)
				{
					m_validationValue += Time.deltaTime * 4f;
					value3.a = Mathf.InverseLerp(0f, 1f, m_validationValue);
					if (m_validationValue >= 1f)
					{
						SetValidation(validationEffect.show);
					}
				}
				Shader.SetGlobalColor(m_validationShaderColorId, value3);
			}
		}
		m_editorOverGUI = false;
	}

	private void LiftItem()
	{
		AudioPickup(m_selectCurrentItem);
		HistoryRecord(ha.itemPickUp, zone.GetItemIndex(m_selectCurrentItem), m_selectCurrentItem.Node());
		if (m_selectCurrentItem.Stacked())
		{
			Vector2 stackDimentions = m_selectCurrentItem.GetStackDimentions();
			int startIndex = m_selectCurrentItem.Node();
			int usedSize = (m_selectCurrentItem.isOnCombine ? m_selectCurrentItem.Uncombine() : m_selectCurrentItem.Unstack());
			zone.SetGrid(startIndex, (int)stackDimentions.x, (int)stackDimentions.y, _used: true, usedSize);
		}
		else if (m_selectCurrentItem.isOnHanger)
		{
			zone.SetGrid(m_selectCurrentItem.Node(), 1, 1, _used: true, m_selectCurrentItem.Unhanger());
		}
		else if (m_selectCurrentItem.isOnHook || m_selectCurrentItem.isOnHolder)
		{
			m_selectCurrentItem.Unhook();
			zone.SetGrid(m_selectCurrentItem.Node(), 1, 1, _used: false, 0);
		}
		else if (m_selectCurrentItem.Shelved())
		{
			m_selectCurrentItem.Unshelf();
		}
		else if (zone.GetWall(m_selectCurrentItem.Node()))
		{
			zone.SetGrid(m_selectCurrentItem.Node(), m_selectCurrentItem.m_xWall, m_selectCurrentItem.m_yWall, _used: false, 0);
		}
		else if (zone.GetStyle(m_selectCurrentItem.Node()) == itemScript.nodeStyle.bar)
		{
			zone.SetGrid(m_selectCurrentItem.Node(), 1, m_selectCurrentItem.m_barWidth, _used: false, 0);
		}
		else if (zone.GetStyle(m_selectCurrentItem.Node()) == itemScript.nodeStyle.barFlipped)
		{
			zone.SetGrid(m_selectCurrentItem.Node(), m_selectCurrentItem.m_barWidth, 1, _used: false, 0);
		}
		else if (zone.GetStyle(m_selectCurrentItem.Node()) == itemScript.nodeStyle.rack || zone.GetStyle(m_selectCurrentItem.Node()) == itemScript.nodeStyle.rackFlipped)
		{
			zone.SetGrid(m_selectCurrentItem.Node(), 1, 1, _used: false, 0);
		}
		else
		{
			zone.SetGrid(m_selectCurrentItem.Node(), m_selectCurrentItem.xWidth, m_selectCurrentItem.yWidth, _used: false, 0);
		}
		m_selectCurrentItem.RemoveItems(zone);
		if (m_selectCurrentItem.isStandable)
		{
			ShelfOffset(m_selectCurrentItem);
		}
		if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
		{
			zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
		}
		CancelStar();
		m_selectCurrentItem.ChangeCollision(_value: false);
	}

	private void DelayLiftItem()
	{
		m_selectCurrentDelayedLift = true;
		m_selectCurrentItem.SetTouchDisplay(_active: true);
		CancelStar();
	}

	private void CancelDelayLift()
	{
		m_selectCurrentDelayedLift = false;
		m_selectCurrentItem.SetTouchDisplay(_active: false);
		m_selectCurrentItem = null;
		selectCollisionSet(null);
		m_selectCurrentState = selectionState.none;
		if (m_state == gameState.play && m_phase == gamePhase.validate)
		{
			EvaluateStar();
		}
	}

	private void LateUpdate()
	{
		if (m_tutorialTurnFade)
		{
			Color color = ((m_tutorialTurn == tutorialState.complete) ? new Color(1f, 0.75f, 0.75f, Mathf.Clamp01(m_tutorialTurnLerp)) : new Color(0.5f, 0.5f, 0.5f, Mathf.Clamp01(m_tutorialTurnLerp)));
			m_tutorialTurnArt.color = color;
			for (int i = 0; i < m_tutorialTurnParts.Length; i++)
			{
				m_tutorialTurnParts[i].GetComponent<UnityEngine.UI.Image>().color = color;
			}
			m_tutorialTurnFade = false;
		}
	}

	public void BounceStart(itemScript _item)
	{
		if (!m_itemBounce.Contains(_item))
		{
			m_itemBounce.Add(_item);
		}
		_item.bounceValue = 1f;
		_item.Bounce(2);
	}

	private void OnItemPicked(itemScript item)
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch && m_itemTapLiftCancel)
		{
			m_itemTapLiftTimer = m_itemTapLiftDuration;
		}
	}

	private void TutorialTurnCheck()
	{
		if (m_tutorialTurn == tutorialState.none && !m_selectCurrentItem.isNonFlatState && m_selectCurrentItem.m_flipType != itemScript.flipType.none && m_selectCurrentItem.xWidth != m_selectCurrentItem.yWidth)
		{
			m_tutorialTurn = tutorialState.showing;
			m_tutorialTurnArt.color = new Color(0.5f, 0.5f, 0.5f, m_tutorialTurnLerp);
			m_tutorialTurnArt.GetComponent<Animator>().speed = 0f;
			m_tutorialTurnArt.gameObject.SetActive(value: true);
		}
	}

	private void TutorialTurnHide()
	{
		if (m_tutorialTurn == tutorialState.showing)
		{
			m_tutorialTurn = tutorialState.none;
			m_tutorialTurnArt.GetComponent<Animator>().speed = 0f;
			if (m_tutorialTurnLerp < 0f)
			{
				m_tutorialTurnArt.gameObject.SetActive(value: false);
			}
		}
	}

	private void TutorialTurnComplete()
	{
		if (m_tutorialTurn != tutorialState.complete)
		{
			gameStateScript.tutorialTurn = true;
			m_tutorialTurn = tutorialState.complete;
			if (m_tutorialTurnLerp > 0f)
			{
				m_tutorialTurnArt.GetComponent<Animator>().speed = 0f;
				return;
			}
			m_tutorialTurnLerp = 0f;
			m_tutorialTurnArt.gameObject.SetActive(value: false);
		}
	}

	private void TutorialZoneChangeCheck()
	{
		if (m_zones.Length > 1 && m_tutorialZoneChange == tutorialState.none && !m_selectCurrentItem.ZoneCheck(zone.m_type) && zone.BoxesRemain())
		{
			bool flag = m_selectCurrentItem.ZoneCheck(m_zones[m_zones.Length - 1].m_type);
			bool flag2 = m_selectCurrentItem.ZoneCheck(m_zones[1].m_type);
			if (flag || flag2)
			{
				m_tutorialZoneChange = tutorialState.showing;
				m_zoneChangeButton.SetPulse(flag, flag, flag2, flag2, _floorplan: false);
			}
		}
	}

	private void TutorialZoneChangeHide()
	{
		if (m_tutorialZoneChange == tutorialState.showing)
		{
			m_tutorialZoneChange = tutorialState.none;
			m_zoneChangeButton.SetPulseOff();
			ConfigureZoneButtons(_active: true);
		}
	}

	private void TutorialZoneChangeComplete()
	{
		if (m_tutorialZoneChange != tutorialState.complete)
		{
			gameStateScript.tutorialZoneChange = true;
			m_tutorialZoneChange = tutorialState.complete;
		}
	}

	public string[] GetZoneNames()
	{
		string[] array = new string[m_zones.Length];
		for (int i = 0; i < m_zones.Length; i++)
		{
			array[i] = m_zones[i].gameObject.name;
		}
		return array;
	}

	public string[] GetVariantNames()
	{
		if (m_selectCurrentItem != null && m_selectCurrentItem.m_variants.Length > 1)
		{
			string[] array = new string[m_selectCurrentItem.m_variants.Length];
			for (int i = 0; i < m_selectCurrentItem.m_variants.Length; i++)
			{
				array[i] = m_selectCurrentItem.m_variants[i].name;
			}
			return array;
		}
		return new string[0];
	}

	public string[] GetItemNamesFiltered(int _time, bool _timeInclusive, zoneScript.itemNode.nodeType _type, int _zone, string _search, out List<int> _indexs)
	{
		List<string> list = new List<string>();
		_indexs = new List<int>();
		bool flag = _zone == -1;
		zoneScript.zoneType zoneType = ((!flag) ? ((zoneScript.zoneType)_zone) : zoneScript.zoneType.kitchen);
		bool flag2 = !string.IsNullOrEmpty(_search);
		string search = _search.ToLowerInvariant();
		for (int i = 0; i < m_itemTypes.Length; i++)
		{
			bool flag3 = false;
			if (m_itemTypes[i] == null)
			{
				continue;
			}
			string item = m_itemTypes[i].name.Remove(0, 4);
			if ((flag2 && !m_itemTypes[i].MatchName(search)) || (_timeInclusive && m_itemTypesTime[i] > _time) || (!_timeInclusive && m_itemTypesTime[i] != _time))
			{
				continue;
			}
			if (flag)
			{
				flag3 = true;
			}
			else
			{
				switch (zoneType)
				{
				case zoneScript.zoneType.kitchen:
					if (m_itemTypes[i].m_zonesKitchen != zoneScript.zoneKitchen.nothing && ((uint)m_itemTypes[i].m_zonesKitchen & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.bedroom:
				case zoneScript.zoneType.closet:
					if (m_itemTypes[i].m_zonesBedroom != zoneScript.zoneBedroom.nothing && ((uint)m_itemTypes[i].m_zonesBedroom & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.bathroom:
				case zoneScript.zoneType.toilet:
					if (m_itemTypes[i].m_zonesBathroom != zoneScript.zoneBathroom.nothing && ((uint)m_itemTypes[i].m_zonesBathroom & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.livingroom:
				case zoneScript.zoneType.foyer:
					if (m_itemTypes[i].m_zonesLivingRoom != zoneScript.zoneLivingRoom.nothing && ((uint)m_itemTypes[i].m_zonesLivingRoom & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.diningroom:
					if (m_itemTypes[i].m_zonesDiningRoom != zoneScript.zoneDiningRoom.nothing && ((uint)m_itemTypes[i].m_zonesDiningRoom & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.office:
					if (m_itemTypes[i].m_zonesOffice != zoneScript.zoneOffice.nothing && ((uint)m_itemTypes[i].m_zonesOffice & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.nursery:
					if (m_itemTypes[i].m_zonesNursery != zoneScript.zoneNursery.nothing && ((uint)m_itemTypes[i].m_zonesNursery & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				case zoneScript.zoneType.wall:
					if (m_itemTypes[i].m_zonesWall != zoneScript.zoneWall.nothing && ((uint)m_itemTypes[i].m_zonesWall & (uint)_type) == (uint)_type)
					{
						flag3 = true;
					}
					break;
				}
			}
			if (flag3)
			{
				list.Add(item);
				_indexs.Add(i);
			}
		}
		string[] array = new string[list.Count];
		for (int j = 0; j < list.Count; j++)
		{
			array[j] = list[j];
		}
		return array;
	}

	public int GetItemsVolume(int[] _itemIndexes)
	{
		int num = 0;
		for (int i = 0; i < _itemIndexes.Length; i++)
		{
			num += m_itemTypes[_itemIndexes[i]].m_xWidth * m_itemTypes[_itemIndexes[i]].m_yWidth * m_itemTypes[_itemIndexes[i]].m_size;
		}
		return num;
	}

	public itemScript GetItemType(string _name)
	{
		for (int i = 0; i < m_itemTypes.Length; i++)
		{
			if (!(m_itemTypes[i] == null))
			{
				string text = _name;
				if (!string.IsNullOrEmpty(m_itemRefreshOld) && text == m_itemRefreshOld)
				{
					text = m_itemRefreshNew;
				}
				if (m_itemTypes[i].gameObject.name == text)
				{
					return m_itemTypes[i];
				}
			}
		}
		for (int j = 0; j < m_itemTypes.Length; j++)
		{
			if (m_itemTypes[j] != null && m_itemTypes[j].m_oldNames != null && m_itemTypes[j].m_oldNames.Contains(_name))
			{
				return m_itemTypes[j];
			}
		}
		return null;
	}

	public int GetItemIndex(string _name)
	{
		for (int i = 0; i < m_itemTypes.Length; i++)
		{
			if (m_itemTypes[i] != null && m_itemTypes[i].gameObject.name == _name)
			{
				return i;
			}
		}
		return -1;
	}

	public boxScript GetBoxType(string _name)
	{
		for (int i = 0; i < m_boxTypes.Length; i++)
		{
			if (m_boxTypes[i].gameObject.name == _name)
			{
				return m_boxTypes[i];
			}
		}
		if (_name.Equals("Box"))
		{
			return m_boxTypes[0];
		}
		return null;
	}

	public int GetBoxIndex(string _name)
	{
		for (int i = 0; i < m_boxTypes.Length; i++)
		{
			if (m_boxTypes[i].gameObject.name == _name)
			{
				return i;
			}
		}
		return -1;
	}

	public zoneScript GetItemZone(itemScript _item)
	{
		zoneScript[] zones = m_zones;
		foreach (zoneScript zoneScript2 in zones)
		{
			if (zoneScript2.ItemInZone(_item))
			{
				return zoneScript2;
			}
		}
		return null;
	}

	public zoneScript GetBoxZone(boxScript _box)
	{
		zoneScript[] zones = m_zones;
		foreach (zoneScript zoneScript2 in zones)
		{
			if (zoneScript2.BoxInZone(_box))
			{
				return zoneScript2;
			}
		}
		return null;
	}

	public zoneScript GetZoneFromName(string _name)
	{
		for (int i = 0; i < m_zones.Length; i++)
		{
			if (m_zones[i].gameObject.name == _name)
			{
				return m_zones[i];
			}
		}
		return null;
	}

	public void FixBoxStates(bool _tops, bool _bottoms)
	{
		for (int i = 0; i < m_zones.Length; i++)
		{
			m_zones[i].FixBoxStates(_tops, _bottoms);
		}
	}

	public List<itemScript> GetItemsFromOtherZones(zoneScript _zone)
	{
		List<itemScript> _result = new List<itemScript>();
		zoneScript[] zones = m_zones;
		foreach (zoneScript zoneScript2 in zones)
		{
			if (zoneScript2 != _zone)
			{
				zoneScript2.GetZonePackedItems(_zone, ref _result);
			}
		}
		return _result;
	}

	private void SetItemPins(int _node, itemScript _item)
	{
		if (_node == -1)
		{
			return;
		}
		itemScript.pinState pinState = zone.GetPinState(_node);
		int num = _item.CheckPinCount(pinState);
		if (num <= -1)
		{
			return;
		}
		int[] array = new int[num];
		pinType[] array2 = new pinType[num];
		if (pinState == itemScript.pinState.pinboard)
		{
			for (int i = 0; i < num; i++)
			{
				array[i] = UnityEngine.Random.Range(0, m_pinboardPins.Length);
				array2[i] = m_pinboardPins[array[i]];
			}
		}
		else
		{
			for (int j = 0; j < num; j++)
			{
				array[j] = UnityEngine.Random.Range(0, m_fridgeMagnets.Length);
				array2[j] = m_fridgeMagnets[array[j]];
			}
		}
		_item.AddPins(pinState, array, array2);
	}

	public void SetItemPins(itemScript.pinState _pinState, itemScript _item)
	{
		int num = _item.CheckPinCount(_pinState);
		if (num <= -1)
		{
			return;
		}
		int[] array = new int[num];
		pinType[] array2 = new pinType[num];
		if (_pinState == itemScript.pinState.pinboard)
		{
			for (int i = 0; i < num; i++)
			{
				array[i] = UnityEngine.Random.Range(0, m_pinboardPins.Length);
				array2[i] = m_pinboardPins[array[i]];
			}
		}
		else
		{
			for (int j = 0; j < num; j++)
			{
				array[j] = UnityEngine.Random.Range(0, m_fridgeMagnets.Length);
				array2[j] = m_fridgeMagnets[array[j]];
			}
		}
		_item.AddPins(_pinState, array, array2);
	}

	public int ChangeZoneTo(int _newZone)
	{
		if (_newZone == m_currentZone)
		{
			return 0;
		}
		if (!m_interfaceActive)
		{
			return 0;
		}
		int num = 0;
		float x = m_zones[m_currentZone].m_floorplanPosition.x;
		float x2 = m_zones[_newZone].m_floorplanPosition.x;
		num = ((!(Mathf.Abs(x - x2) > 0.5f)) ? ((m_zones[_newZone].m_floorplanPosition.y > m_zones[m_currentZone].m_floorplanPosition.y) ? 1 : (-1)) : ((x2 > x) ? 1 : (-1)));
		int result = ((m_zones[m_currentZone].m_floorplanFloor == m_zones[_newZone].m_floorplanFloor) ? num : ((m_zones[m_currentZone].m_floorplanFloor < m_zones[_newZone].m_floorplanFloor) ? (-2) : 2));
		ChangeZone(_newZone, num);
		m_zoneChangeButton.EndChange();
		return result;
	}

	public void ChangeZone(int _direction)
	{
		int num = m_currentZone + _direction;
		if (num > m_zones.Length - 1)
		{
			num -= m_zones.Length;
		}
		else if (num < 0)
		{
			num += m_zones.Length;
		}
		ChangeZone(num, _direction);
		m_inputUI = true;
	}

	private void ChangeZone(int _newZone, int _direction)
	{
		if (m_zones.Length < 2 || m_zoneChange || m_dateNodeActive || _newZone == m_currentZone)
		{
			return;
		}
		int num = m_currentZone - _newZone;
		if (num < 0 && _direction < 0)
		{
			num += m_zones.Length;
		}
		else if (num > 0 && _direction > 0)
		{
			num -= m_zones.Length;
		}
		HistoryRecord(ha.changeZone, num);
		TutorialZoneChangeComplete();
		AudioLiftEnd();
		if (m_selectCurrentDelayedLift)
		{
			m_selectCurrentDelayedLift = false;
			LiftItem();
		}
		if (m_lastShelf != null)
		{
			m_lastShelf.ResetPosition();
			m_lastShelf.AdjustAllOffsets(m_selectCurrentItem.standPixelSize);
			m_lastShelf = null;
		}
		m_inputTouchNode = -1;
		m_inputIgnoreRelease = false;
		HideTouchControls();
		if (m_selectCurrentItem != null)
		{
			zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: false);
		}
		if (m_editCurrentItem != null)
		{
			m_editCurrentItem.PackMovableRemove();
			m_editCurrentItem = null;
		}
		m_zoneChange = true;
		m_zoneChangeLerp = 0f;
		if (m_zones[_newZone].m_floorplanFloor == m_zones[m_currentZone].m_floorplanFloor)
		{
			m_zoneChangeHorizontal = true;
			m_zoneChangeDirection = _direction;
		}
		else
		{
			m_zoneChangeHorizontal = false;
			m_zoneChangeDirection = ((m_zones[_newZone].m_floorplanFloor > m_zones[m_currentZone].m_floorplanFloor) ? 1 : (-1));
		}
		Vibration((!m_zoneChangeHorizontal) ? vibrationScript.moment.zoneChangeVertical : ((m_zoneChangeDirection <= 0) ? vibrationScript.moment.zoneChangeLeft : vibrationScript.moment.zoneChangeRight));
		m_zoneChangePosStart = m_cameraOffset;
		float num2 = m_zoomOrthoBase / m_zoom;
		float num3 = num2 * m_aspectRatio;
		float t = Mathf.InverseLerp(zone.m_zoneBounds.min.x + num3, zone.m_zoneBounds.max.x - num3, m_zoneChangePosStart.x);
		float t2 = Mathf.InverseLerp(zone.m_zoneBounds.min.y + num2, zone.m_zoneBounds.max.y - num2, m_zoneChangePosStart.y);
		zone.HideGrid();
		if (m_showValidGrid || m_showValidGridCreate)
		{
			zone.ClearGridValid();
		}
		m_zoneChangePrevious = m_currentZone;
		m_zoneChangeColorStart = zone.m_color;
		for (int i = 0; i < m_zones.Length; i++)
		{
			if (m_state == gameState.pack && m_selectCurrentUnpackMode == 2)
			{
				m_zones[i].SetPackMovableItems(_value: false);
			}
		}
		m_currentZone = _newZone;
		if (m_zoneChangeFade)
		{
			GetComponent<Animation>().Play("post_fadedip");
		}
		else
		{
			zone.SetActive(_value: true);
		}
		m_zoneChangePosEnd = new Vector2((zone.m_zoneBounds.extents.x < num3) ? zone.m_zoneBounds.center.x : Mathf.Lerp(zone.m_zoneBounds.min.x + num3, zone.m_zoneBounds.max.x - num3, t), (zone.m_zoneBounds.extents.y < num2) ? zone.m_zoneBounds.center.y : Mathf.Lerp(zone.m_zoneBounds.min.y + num2, zone.m_zoneBounds.max.y - num2, t2));
		if (m_selectCurrentItem != null)
		{
			m_lastNode = -1;
			if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
			{
				zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
			}
		}
		zone.SetAmbience(base.gameObject);
		if ((!m_playbackMode || m_playbackAnimate) && !string.IsNullOrEmpty(m_audioZoneChange))
		{
			AkSoundEngine.PostEvent(m_audioZoneChange, zone.gameObject);
		}
		m_zoneChangeColorEnd = zone.m_color;
		ChangeZoneUpdate(0f);
		int num4 = m_currentZone - 1;
		if (num4 < 0)
		{
			num4 = m_zones.Length - 1;
		}
		int num5 = m_currentZone + 1;
		if (num5 > m_zones.Length - 1)
		{
			num5 = 0;
		}
		m_zoneChangeButton.ChangeZone(m_zones[num4].m_type, m_zones[num5].m_type);
		for (int j = 0; j < m_zoneChangeDisable.Length; j++)
		{
			m_zoneChangeDisable[j].interactable = false;
		}
		FileSaveAction();
		if (m_phase == gamePhase.validate)
		{
			SetValidation(validationEffect.zoneChange);
		}
		else
		{
			ConfigureZoneButtons(_active: false);
		}
	}

	private void SetButtonColor(Color _color)
	{
		Color color = _color + new Color(0.25f, 0.25f, 0.25f);
		Color.RGBToHSV(_color, out var H, out var S, out var V);
		Color disabledColor = Color.HSVToRGB(H, S, V - 0.125f);
		for (int i = 0; i < m_buttons.Length; i++)
		{
			ColorBlock colors = m_buttons[i].colors;
			colors.normalColor = color;
			colors.disabledColor = color;
			m_buttons[i].colors = colors;
		}
		for (int j = 0; j < m_buttonsBright.Length; j++)
		{
			ColorBlock colors2 = m_buttonsBright[j].colors;
			colors2.normalColor = color;
			colors2.disabledColor = color;
			m_buttonsBright[j].colors = colors2;
		}
		Button[] buttonsZoom = m_buttonsZoom;
		foreach (Button obj in buttonsZoom)
		{
			ColorBlock colors3 = obj.colors;
			colors3.normalColor = color;
			colors3.disabledColor = disabledColor;
			obj.colors = colors3;
		}
		Graphic[] graphics = m_graphics;
		for (int k = 0; k < graphics.Length; k++)
		{
			graphics[k].color = color;
		}
		m_completeButton.m_starSpawner.m_colors[2] = color;
	}

	private void ChangeZoneUpdate(float _value)
	{
		Color.RGBToHSV(m_zoneChangeColorStart, out var H, out var S, out var V);
		Color.RGBToHSV(m_zoneChangeColorEnd, out var H2, out var S2, out var V2);
		if (H > H2 + 0.5f)
		{
			H2 += 1f;
		}
		else if (H < H2 - 0.5f)
		{
			H += 1f;
		}
		Color color = Color.HSVToRGB(Mathf.Repeat(Mathf.Lerp(H, H2, _value), 1f), Mathf.Lerp(S, S2, _value), Mathf.Lerp(V, V2, _value));
		SetButtonColor(color);
		if (m_zoneChangeFade)
		{
			if (!zone.gameObject.activeSelf && _value > 0.5f)
			{
				m_zones[m_zoneChangePrevious].SetActive(_value: false);
				zone.transform.position = Vector3.zero;
				zone.SetActive(_value: true);
				GetComponent<Camera>().backgroundColor = m_zoneChangeColorEnd;
				zone.SetOutlineColor(m_zoneChangeColorEnd);
				m_cameraOffset.x = m_zoneChangePosEnd.x;
				m_cameraOffset.y = m_zoneChangePosEnd.y;
			}
		}
		else
		{
			float num = Mathf.Max(11f, m_zoomOrthoBase / m_zoom * m_aspectRatio * 1.75f);
			float num2 = Mathf.Round(_value * num * (0f - Mathf.Sign(m_zoneChangeDirection)) * 100f) / 100f;
			Vector3 vector = (m_zoneChangeHorizontal ? Vector3.right : Vector3.up);
			m_zones[m_zoneChangePrevious].transform.position = vector * num2;
			zone.transform.position = vector * (num2 + num * Mathf.Sign(m_zoneChangeDirection));
			GetComponent<Camera>().backgroundColor = color;
			m_zones[m_zoneChangePrevious].SetOutlineColor(color);
			zone.SetOutlineColor(color);
			m_cameraOffset.x = Mathf.Lerp(m_zoneChangePosStart.x, m_zoneChangePosEnd.x, _value);
			m_cameraOffset.y = Mathf.Lerp(m_zoneChangePosStart.y, m_zoneChangePosEnd.y, _value);
		}
		SetAudioWheel(m_zoneChangePrevious, m_currentZone, _value);
		if (m_audioRaised.Count <= 0 && !(m_selectCurrentItem != null))
		{
			return;
		}
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(zone.reverbID, _value);
		akAuxSendArray.Add(m_zones[m_zoneChangePrevious].reverbID, 1f - _value);
		foreach (GameObject item in m_audioRaised)
		{
			AkSoundEngine.SetGameObjectAuxSendValues(item, akAuxSendArray, 2u);
		}
		if (m_selectCurrentItem != null)
		{
			AkSoundEngine.SetGameObjectAuxSendValues(m_selectCurrentItem.audioGO, akAuxSendArray, 2u);
		}
	}

	private void ConfigureZoneButtons(bool _active)
	{
		if (m_zones.Length < 2)
		{
			return;
		}
		if (_active)
		{
			if (m_endMode != gameEndMode.unfinished)
			{
				return;
			}
			bool flag = true;
			int num = m_zones.Length;
			int num2 = m_zones.Length;
			bool floorplan = false;
			int num3 = m_zones.Length;
			int num4 = m_zones.Length;
			bool floorplan2 = false;
			int num5 = Mathf.CeilToInt((float)m_zones.Length / 2f);
			for (int i = 0; i < m_zones.Length; i++)
			{
				if (m_zones[i].BoxesRemain())
				{
					flag = false;
				}
				if (i == m_currentZone)
				{
					continue;
				}
				if (!m_zones[i].isZoneValid)
				{
					int num6 = m_currentZone - i;
					if (num6 < 0)
					{
						num6 += m_zones.Length;
					}
					num = Mathf.Min(num, num6);
					if (num6 > 1 && num6 <= num5)
					{
						floorplan = true;
					}
					num6 = i - m_currentZone;
					if (num6 < 0)
					{
						num6 += m_zones.Length;
					}
					num2 = Mathf.Min(num2, num6);
					if (num6 > 1 && num6 <= num5)
					{
						floorplan = true;
					}
				}
				if (m_zones[i].BoxesRemain())
				{
					int num7 = m_currentZone - i;
					if (num7 < 0)
					{
						num7 += m_zones.Length;
					}
					num3 = Mathf.Min(num3, num7);
					if (num7 > 1 && num7 <= num5)
					{
						floorplan2 = true;
					}
					num7 = i - m_currentZone;
					if (num7 < 0)
					{
						num7 += m_zones.Length;
					}
					num4 = Mathf.Min(num4, num7);
					if (num7 > 1 && num7 <= num5)
					{
						floorplan2 = true;
					}
				}
			}
			if (flag)
			{
				if (m_itemsValidAnywhere || m_phase == gamePhase.unpack)
				{
					m_zoneChangeButton.SetInvalidOff();
				}
				else
				{
					m_zoneChangeButton.SetInvalid(num == 1, num < m_zones.Length && num <= num5, num2 == 1, num2 < m_zones.Length && num2 <= num5, floorplan);
				}
				m_zoneChangeButton.SetPulseOff();
			}
			else if (!zone.BoxesRemain())
			{
				m_zoneChangeButton.SetPulse(num3 == 1, num3 < m_zones.Length && num3 <= num5, num4 == 1, num4 < m_zones.Length && num4 <= num5, floorplan2);
			}
		}
		else
		{
			m_zoneHintCountdown = false;
			m_zoneChangeButton.SetInvalidOff();
			m_zoneChangeButton.SetPulseOff();
		}
	}

	private void ChangeZoneEnd()
	{
		m_zoneChange = false;
		m_zones[m_zoneChangePrevious].SetActive(_value: false);
		if (m_audioRaised.Count > 0 || m_selectCurrentItem != null)
		{
			AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
			akAuxSendArray.Add(zone.reverbID, 1f);
			foreach (GameObject item in m_audioRaised)
			{
				AkSoundEngine.SetGameObjectAuxSendValues(item, akAuxSendArray, 1u);
			}
			if (m_selectCurrentItem != null)
			{
				AkSoundEngine.SetGameObjectAuxSendValues(m_selectCurrentItem.audioGO, akAuxSendArray, 1u);
			}
		}
		if (m_state == gameState.play && m_phase == gamePhase.unpack)
		{
			ConfigureZoneButtons(_active: true);
		}
		if (m_showValidGrid)
		{
			zone.ShowGridValid(m_selectCurrentItem);
		}
		else if (m_showValidGridCreate)
		{
			zone.ShowGridValid(m_showValidGridKitchen, m_showValidGridBedroom, m_showValidGridBathroom, m_showValidGridLivingRoom, m_showValidGridDiningRoom, m_showValidGridOffice, m_showValidGridNursery, m_showValidGridWall);
		}
		if (m_state == gameState.pack && m_selectCurrentUnpackMode == 0)
		{
			m_zones[m_zoneChangePrevious].HideBoxPackingLines();
		}
		if (m_state == gameState.pack && m_selectCurrentUnpackMode == 2)
		{
			zone.SetPackMovableItems(_value: true);
		}
		for (int i = 0; i < m_zoneChangeDisable.Length; i++)
		{
			m_zoneChangeDisable[i].interactable = true;
		}
	}

	public void ShowValidGridItemCreate(zoneScript.zoneKitchen _showValidGridKitchen, zoneScript.zoneBedroom _showValidGridBedroom, zoneScript.zoneBathroom _showValidGridBathroom, zoneScript.zoneLivingRoom _showValidGridLivingRoom, zoneScript.zoneDiningRoom _showValidGridDiningRoom, zoneScript.zoneOffice _showValidGridOffice, zoneScript.zoneNursery _showValidGridNursery, zoneScript.zoneWall _showValidGridWall)
	{
		m_showValidGrid = false;
		m_showValidGridCreate = true;
		m_showValidGridKitchen = _showValidGridKitchen;
		m_showValidGridBedroom = _showValidGridBedroom;
		m_showValidGridBathroom = _showValidGridBathroom;
		m_showValidGridLivingRoom = _showValidGridLivingRoom;
		m_showValidGridDiningRoom = _showValidGridDiningRoom;
		m_showValidGridOffice = _showValidGridOffice;
		m_showValidGridNursery = _showValidGridNursery;
		m_showValidGridWall = _showValidGridWall;
		zone.ShowGridValid(m_showValidGridKitchen, m_showValidGridBedroom, m_showValidGridBathroom, m_showValidGridLivingRoom, m_showValidGridDiningRoom, m_showValidGridOffice, m_showValidGridNursery, m_showValidGridWall);
	}

	public void ClearValidGridItemCreate()
	{
		if (m_showValidGridCreate)
		{
			m_showValidGridCreate = false;
			zone.ClearGridValid();
		}
	}

	private Vector4 ZoneBound()
	{
		return new Vector4(zone.m_zoneBounds.center.x - zone.m_zoneBounds.extents.x, zone.m_zoneBounds.center.y - zone.m_zoneBounds.extents.y, zone.m_zoneBounds.center.x + zone.m_zoneBounds.extents.x, zone.m_zoneBounds.center.y + zone.m_zoneBounds.extents.y);
	}

	private void ShelfOffset(itemScript _item)
	{
		int standPixelSize = _item.standPixelSize;
		for (int i = 0; i < m_zones.Length; i++)
		{
			m_zones[i].ShelfOffset(standPixelSize);
			m_zones[i].ShelfSetPoints(_item);
		}
	}

	private void ShelfOffset(int _value)
	{
		for (int i = 0; i < m_zones.Length; i++)
		{
			m_zones[i].ShelfOffset(_value);
		}
	}

	public void Complete()
	{
		if (interfaceActive)
		{
			m_cursor.IsConfined = false;
			m_cursor.Behaviour = uiCursor.CursorBehaviour.Default;
			AkSoundEngine.PostEvent("Stop_Ambience", base.gameObject);
			string text = ((m_endMode == gameEndMode.noItemsValid) ? m_audioDCompleteAction : m_audioCompleteAction);
			if (!string.IsNullOrEmpty(text))
			{
				AkSoundEngine.PostEvent(text, base.gameObject);
			}
			vibrationScript.Trigger(vibrationScript.moment.stageClearAction);
			m_gameActive = false;
			m_completeButton.silent = true;
			m_completeButton.Active(gameEndMode.unfinished);
			if (m_stickerOnComplete != statsScript.stickers.none)
			{
				statsScript.StickerAwardEffectAll();
				statsScript.AwardSticker(m_stickerOnComplete, _albumUnlock: true);
			}
			saveData.ClearResume();
			FileSave(m_endMode);
			gameStateScript.albumPage = m_currentStage;
			gameStateScript.SetAlbumLoadComplete();
			gameStateScript.LoadScene("album", _black: false);
		}
	}

	public void FileSaveReplace()
	{
		FileSave(m_endMode);
	}

	private void FileSaveAction(bool _onExit = false)
	{
		if (!(m_selectCurrentItem == null))
		{
			return;
		}
		if (m_useTempSave)
		{
			if (!_onExit)
			{
				FileSaveTemp();
			}
		}
		else
		{
			FileSave(gameEndMode.unfinished);
		}
	}

	public void HistorySave(int _usableIndex)
	{
		HistoryRecord(ha.stageUse, _usableIndex);
		FileSaveAction();
	}

	public void LoadAlbum()
	{
		FileSaveAction(_onExit: true);
		m_gameActive = false;
		m_completeButton.Active(gameEndMode.unfinished);
		AkSoundEngine.PostEvent("Stop_Ambience", base.gameObject);
		gameStateScript.albumPage = m_currentStage;
		gameStateScript.SetAlbumLoadGame();
		gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
	}

	private IEnumerator DelayLoad(string _scene)
	{
		gameStateScript.LoadSceneStart(_scene);
		yield return new WaitForSeconds(2f);
		gameStateScript.LoadSceneAdvance();
	}

	public void LoadTitle()
	{
		FileSaveAction(_onExit: true);
		m_gameActive = false;
		m_completeButton.Active(gameEndMode.unfinished);
		AkSoundEngine.PostEvent("Stop_Ambience", base.gameObject);
		if (m_dateNode != null)
		{
			m_dateNode.parent.gameObject.SetActive(value: false);
		}
		gameStateScript.SetQuickTitleReturn();
		gameStateScript.LoadSceneFade("title", 0.25f);
	}

	public void EnablePhotomode()
	{
		AkSoundEngine.PostEvent(m_audioPhotomodeUnlock, base.gameObject);
		PulsePhotomode();
		statsScript.StickerAwardEffect();
	}

	public void PulsePhotomode()
	{
		m_photoModeAppear = true;
		m_photoModeAppearLerp = 0f;
		m_photomodeButton.GetComponent<UnityEngine.UI.Image>().color = Color.clear;
		m_photomodeButton.gameObject.SetActive(value: true);
		m_completeButton.m_starSpawner.Burst(m_photomodeButton.GetComponent<RectTransform>().localPosition - m_completeButton.m_starSpawner.GetComponent<RectTransform>().localPosition + new Vector3(19f, -17.5f));
	}

	public void HidePhotoMode()
	{
		m_photomodeButton.gameObject.SetActive(value: false);
	}

	public void UnlockSticker(Sprite _sticker, int _page)
	{
		m_stickerUnlockList.Add(_sticker);
		m_stickerLastUnlock = _page;
		m_stickerUnlockDelay = 0.5f;
	}

	public void playAudio(string _event, GameObject _target)
	{
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(_target, akAuxSendArray, 1u);
		AkSoundEngine.PostEvent(_event, _target);
	}

	public void playAudio(string _event, string _itemID, GameObject _target)
	{
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(reverbID, 1f);
		AkSoundEngine.SetGameObjectAuxSendValues(_target, akAuxSendArray, 1u);
		AkSoundEngine.SetSwitch("item", _itemID, _target);
		AkSoundEngine.PostEvent(_event, _target);
	}

	public void AudioPlace(itemScript _item, bool _collision = false)
	{
		string _surface = (_collision ? zoneScript.itemNode.audioSurface.shelf.ToString() : _item.Surface(zone));
		string text = _item.GetAudioID(ref _surface);
		if (_item.isOnRack)
		{
			text = (_item.HangerCheck() ? "Hanger_Hang_Place" : "Hanger_Shirt_Hang_Place");
		}
		else if (_item.isOnHanger)
		{
			text = "Hanger_Shirt_On";
		}
		else if (_item.Pinboard())
		{
			text = m_audioPinboard;
		}
		if (string.IsNullOrEmpty(text))
		{
			text = m_fallbackAudioID.GetID(ref _surface);
		}
		if (!string.IsNullOrEmpty(text))
		{
			AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
			akAuxSendArray.Add(reverbID, 1f);
			AkSoundEngine.SetGameObjectAuxSendValues(_item.audioGO, akAuxSendArray, 1u);
			AkSoundEngine.SetSwitch("surface", _surface, _item.audioGO);
			AkSoundEngine.SetSwitch("action", "place", _item.audioGO);
			AkSoundEngine.PostEvent(text, _item.audioGO);
		}
		if (!_surface.Equals("hang"))
		{
			string audioSweetener = _item.GetAudioSweetener();
			if (!string.IsNullOrEmpty(audioSweetener))
			{
				AkAuxSendArray akAuxSendArray2 = new AkAuxSendArray();
				akAuxSendArray2.Add(reverbID, 1f);
				AkSoundEngine.SetGameObjectAuxSendValues(_item.audioGO, akAuxSendArray2, 1u);
				AkSoundEngine.PostEvent(audioSweetener, _item.audioGO);
			}
		}
	}

	private void AudioPickup(itemScript _item)
	{
		string _surface = _item.Surface(zone);
		string text = _item.GetAudioID(ref _surface);
		if (_item.isOnRack)
		{
			text = (_item.HangerCheck() ? "Hanger_Hang_Pickup" : "Hanger_Shirt_Hang_Pickup");
		}
		else if (_item.isOnHanger)
		{
			text = "Hanger_Shirt_Off";
		}
		else if (_item.Pinboard())
		{
			text = m_audioPinboard;
		}
		if (string.IsNullOrEmpty(text))
		{
			text = m_fallbackAudioID.GetID(ref _surface);
		}
		if (!string.IsNullOrEmpty(text))
		{
			AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
			akAuxSendArray.Add(reverbID, 1f);
			AkSoundEngine.SetGameObjectAuxSendValues(_item.audioGO, akAuxSendArray, 1u);
			AkSoundEngine.SetSwitch("surface", _surface, _item.audioGO);
			AkSoundEngine.SetSwitch("action", "pickup", _item.audioGO);
			AkSoundEngine.PostEvent(text, _item.audioGO);
		}
		if (!_surface.Equals("hang"))
		{
			string audioSweetener = _item.GetAudioSweetener();
			if (!string.IsNullOrEmpty(audioSweetener))
			{
				AkAuxSendArray akAuxSendArray2 = new AkAuxSendArray();
				akAuxSendArray2.Add(reverbID, 1f);
				AkSoundEngine.SetGameObjectAuxSendValues(_item.audioGO, akAuxSendArray2, 1u);
				AkSoundEngine.PostEvent(audioSweetener, _item.audioGO);
			}
		}
	}

	private void AudioLiftStart(itemScript _item)
	{
		AudioLiftEnd();
		m_audioLiftItem = _item;
		m_audioLiftTimer = 0f;
		m_audioLiftLifted = false;
	}

	private void AudioLiftStartDelay(itemScript _item)
	{
		AudioLiftStart(_item);
		m_audioLiftTimer = m_audioLiftTime;
	}

	private void AudioLiftEnd()
	{
		if (m_audioLiftItem != null)
		{
			m_audioLiftItem.AudioLift(_lift: false);
			m_audioLiftItem = null;
		}
	}

	public saveData.saveDataSnapshot GetSaveData()
	{
		saveData.saveDataZone[] array = new saveData.saveDataZone[m_zones.Length];
		for (int i = 0; i < m_zones.Length; i++)
		{
			array[i] = m_zones[i].GetSaveData();
		}
		List<saveData.saveDataItem> list = new List<saveData.saveDataItem>();
		if (m_selectCurrentItem != null)
		{
			itemScript itemScript2 = m_selectCurrentItem;
			list.Add(itemScript2.GetSaveData(_movable: true));
			if ((bool)itemScript2.hangerChild)
			{
				list.Add(itemScript2.hangerChild.GetSaveData(_movable: true));
			}
			else
			{
				while (itemScript2.stackChild != null)
				{
					itemScript2 = itemScript2.stackChild;
					list.Add(itemScript2.GetSaveData(_movable: true));
				}
			}
		}
		return new saveData.saveDataSnapshot(array, m_currentZone, Mathf.RoundToInt(m_cameraOffset.x * 100f), Mathf.RoundToInt(m_cameraOffset.y * 100f), (!(m_todScript == null)) ? m_todScript.GetSaveData() : 0, list.ToArray(), m_offset);
	}

	public void SetSaveData(saveData.saveDataSnapshot _saveData)
	{
		FileLoadStage(_saveData.stage);
		if (_saveData.items.Length != 0)
		{
			itemScript itemScript2 = UnityEngine.Object.Instantiate(GetItemType(_saveData.items[0].type));
			itemScript2.SetVariant(_saveData.items[0].variant);
			itemScript2.SetState(_saveData.items[0].state);
			Vector3 position = Vector3.up * 100f;
			if (_saveData.items[0].pinTypes.Length != 0)
			{
				itemScript.pinState pinState = (itemScript.pinState)_saveData.items[0].pinState;
				pinType[] array = new pinType[_saveData.items[0].pinTypes.Length];
				for (int i = 0; i < array.Length; i++)
				{
					switch (pinState)
					{
					case itemScript.pinState.pinboard:
						array[i] = m_pinboardPins[_saveData.items[0].pinTypes[i]];
						break;
					case itemScript.pinState.fridge:
						array[i] = m_fridgeMagnets[_saveData.items[0].pinTypes[i]];
						break;
					}
				}
				itemScript2.AddPins(pinState, _saveData.items[0].pinTypes, array);
			}
			itemScript2.Position(position, itemScript.positionAction.placedValid, _unboxed: false, null, -1, 0, 0, null, StateToStyle((itemScript.itemState)_saveData.items[0].state), 0);
			if (_saveData.items[0].attachmentStates.Length != 0)
			{
				itemScript2.SetAttachmentStates(_saveData.items[0].attachmentStates);
			}
			m_selectCurrentItem = itemScript2;
			selectCollisionSet(m_selectCurrentItem);
			m_selectCurrentState = selectionState.held;
			m_offset = _saveData.itemOffset;
			if (m_selectCurrentItem.isStandable)
			{
				ShelfOffset(m_selectCurrentItem);
			}
			if (m_selectCurrentItem.m_stackAllowed != itemScript.stackId.none)
			{
				zone.OffsetByStackID(m_selectCurrentItem.m_stackAllowed, _active: true);
			}
			for (int j = 1; j < _saveData.items.Length; j++)
			{
				itemScript itemScript3 = UnityEngine.Object.Instantiate(GetItemType(_saveData.items[j].type));
				itemScript3.SetVariant(_saveData.items[j].variant);
				itemScript3.SetState(_saveData.items[j].state);
				if (_saveData.items[j].state == 16 || _saveData.items[j].state == 17)
				{
					itemScript3.Position(itemScript2.HangerPosition(null), itemScript.positionAction.placedValid, _unboxed: false, null, -1, 0, 0, itemScript2.m_artPivot, itemScript2.HangerStyle(), 0);
					itemScript3.Hanger(itemScript2);
				}
				else if (_saveData.items[j].stackOrder == 0)
				{
					Vector3 vector = Vector3.forward * -0.002f;
					float num = (float)(itemScript3.xWidth - itemScript2.xWidth) / 2f;
					float num2 = (float)(itemScript3.yWidth - itemScript2.yWidth) / 2f;
					vector.x = (num - num2) * 0.14f;
					vector.y = (float)itemScript3.stackPixelSize * 0.01f + Mathf.Ceil(num + num2) * 0.07f;
					itemScript3.Position(itemScript2.m_artPivot.position - vector, itemScript.positionAction.placedValid, _unboxed: false, null, -1, 0, 0, itemScript2.m_artPivot, itemScript.nodeStyle.flat, 0);
					itemScript3.Hanger(itemScript2);
					itemScript3.m_artPivot.localPosition = Vector3.up * 0.04f;
				}
				else
				{
					itemScript3.Position(itemScript2.StackPosition(itemScript3), itemScript.positionAction.placedValid, _unboxed: false, itemScript2, -1, 0, 0, itemScript2.m_artPivot, itemScript.nodeStyle.flat, 0);
					itemScript3.Stack(itemScript2);
					itemScript2 = itemScript3;
				}
			}
		}
		bool flag = true;
		zoneScript[] zones = m_zones;
		for (int k = 0; k < zones.Length; k++)
		{
			if (zones[k].BoxesRemain())
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			if (phase == gamePhase.unpack)
			{
				phase = gamePhase.validate;
			}
		}
		else
		{
			phase = gamePhase.unpack;
		}
	}

	private itemScript.nodeStyle StateToStyle(itemScript.itemState _state)
	{
		switch (_state)
		{
		case itemScript.itemState.rack:
			return itemScript.nodeStyle.rack;
		case itemScript.itemState.rackFlipped:
			return itemScript.nodeStyle.rackFlipped;
		default:
			return itemScript.nodeStyle.flat;
		}
	}

	public void FileSave(gameEndMode _endMode)
	{
		if (!m_playbackMode)
		{
			saveData.saveDataZone[] array = new saveData.saveDataZone[m_zones.Length];
			for (int i = 0; i < m_zones.Length; i++)
			{
				array[i] = m_zones[i].GetSaveData();
			}
			int num = 1;
			switch (_endMode)
			{
			case gameEndMode.allItemsValid:
				num = 2;
				break;
			case gameEndMode.noItemsValid:
				num = 3;
				break;
			}
			saveData.Save(new saveData.saveDataStage(num, m_currentZone, Mathf.RoundToInt(m_cameraOffset.x * 100f), Mathf.RoundToInt(m_cameraOffset.y * 100f), (!(m_todScript == null)) ? m_todScript.GetSaveData() : 0, array, m_history.ToArray(), m_historyZones, ZoneScreenshot(), gameStateScript.GetChecksumZone(m_currentStage), gameStateScript.GetChecksumItem(m_currentStage)), m_currentStage, _endMode != gameEndMode.unfinished);
		}
	}

	public void FileSaveTemp()
	{
		saveData.saveDataZone[] array = new saveData.saveDataZone[m_zones.Length];
		for (int i = 0; i < m_zones.Length; i++)
		{
			array[i] = m_zones[i].GetSaveData();
		}
		saveData.SaveTemp(new saveData.saveDataStage(m_currentStage + 1, m_currentZone, Mathf.RoundToInt(m_cameraOffset.x * 100f), Mathf.RoundToInt(m_cameraOffset.y * 100f), (!(m_todScript == null)) ? m_todScript.GetSaveData() : 0, array, m_history.ToArray(), m_historyZones, new byte[0], gameStateScript.GetChecksumZone(m_currentStage), gameStateScript.GetChecksumItem(m_currentStage)));
	}

	public bool CheckUnsavedChanges()
	{
		return saveData.UnsavedChanges(m_currentStage);
	}

	private void HistoryLoadZones(saveData.saveDataZone[] _zones)
	{
		if (_zones != null && _zones.Length != 0)
		{
			_ = 360f / (float)m_zones.Length;
			int currentZone = m_currentZone;
			for (int i = 0; i < m_zones.Length; i++)
			{
				m_currentZone = i;
				SetAudioWheel(i);
				m_zones[i].SetSaveData(_zones[i]);
			}
			m_currentZone = currentZone;
			for (int j = 0; j < m_zones.Length; j++)
			{
				m_zones[j].SetActive(m_currentZone == j);
			}
			SetAudioWheel(0);
		}
	}

	private bool FileLoadStage(saveData.saveDataStage _stage)
	{
		if (_stage.zones == null || _stage.zones.Length == 0)
		{
			Debug.LogWarning("no data found for stage " + m_currentStage);
			return false;
		}
		m_cameraOffset = new Vector2((float)_stage.x / 100f, (float)_stage.y / 100f);
		UpdateCamera();
		int num = 0;
		_ = 360f / (float)m_zones.Length;
		int currentZone = m_currentZone;
		for (int i = 0; i < m_zones.Length; i++)
		{
			m_currentZone = i;
			zone.SetActive(_value: true);
			SetAudioWheel(i);
			m_zones[i].SetSaveData(_stage.zones[i]);
			for (int j = 0; j < _stage.zones[i].boxes.Length; j++)
			{
				num += Mathf.Max(m_zones[i].GetBoxContentCount(j) - Mathf.Max(_stage.zones[i].boxes[j].next, 0), 0);
			}
		}
		m_currentZone = currentZone;
		for (int k = 0; k < m_zones.Length; k++)
		{
			m_zones[k].SetActive(m_currentZone == k);
		}
		if (m_todScript != null)
		{
			m_todScript.SetItemCurrent(num);
			m_todScript.SetSaveData(_stage.tod);
		}
		if (_stage.zone != m_currentZone)
		{
			zone.SetActive(_value: false);
			m_currentZone = _stage.zone;
			zone.SetActive(_value: true);
			zone.SetAmbience(base.gameObject);
			GetComponent<Camera>().backgroundColor = zone.m_color;
			zone.SetOutlineColor(zone.m_color);
			if (m_zones.Length > 1)
			{
				int num2 = m_currentZone - 1;
				if (num2 < 0)
				{
					num2 = m_zones.Length - 1;
				}
				int num3 = m_currentZone + 1;
				if (num3 >= m_zones.Length)
				{
					num3 = 0;
				}
				m_zoneChangeButton.SetInitial(m_zones[num2].m_type, m_zones[num3].m_type);
			}
			SetButtonColor(zone.m_color);
			ConfigureZoneButtons(_active: true);
		}
		SetAudioWheel(m_currentZone);
		if (_stage.history != null)
		{
			m_history.AddRange(_stage.history);
		}
		if (_stage.historyZones != null)
		{
			m_historyZones = _stage.historyZones;
		}
		if (m_selectCurrentItem != null)
		{
			m_selectCurrentItem.DestroyItem();
			m_selectCurrentItem = null;
			selectCollisionSet(null);
			m_selectCurrentState = selectionState.none;
		}
		m_lastNode = -1;
		m_lastShelf = null;
		return true;
	}

	private void SetAudioWheel(int _zone)
	{
		m_audioWheel.rotation = Quaternion.AngleAxis(m_audioWheelPosition[_zone].x, Vector3.up);
		m_audioWheel.position = new Vector3(0f, m_audioWheelPosition[_zone].y, m_audioWheelPosition[_zone].z + base.transform.localPosition.z);
	}

	private void SetAudioWheel(int _zoneStart, int _zoneFinish, float _lerp)
	{
		Vector3 vector = new Vector3(Mathf.LerpAngle(m_audioWheelPosition[_zoneStart].x, m_audioWheelPosition[_zoneFinish].x, _lerp), Mathf.Lerp(m_audioWheelPosition[_zoneStart].y, m_audioWheelPosition[_zoneFinish].y, _lerp), Mathf.Lerp(m_audioWheelPosition[_zoneStart].z, m_audioWheelPosition[_zoneFinish].z, _lerp));
		m_audioWheel.rotation = Quaternion.AngleAxis(vector.x, Vector3.up);
		m_audioWheel.position = new Vector3(0f, vector.y, vector.z + base.transform.localPosition.z);
	}

	private void PositionTouchControls()
	{
		if (m_selectCurrentItem == null)
		{
			HideTouchControls();
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if ((!m_selectCurrentItem.isNonFlatState && m_selectCurrentItem.CanAdvanceState()) || m_selectCurrentItem.isOnHolder)
		{
			itemScript _item2;
			if (m_selectCurrentItem.isOnHolder)
			{
				flag = true;
			}
			else if (m_inputTouchNode == -1 || m_selectCurrentItem.m_flipType == itemScript.flipType.FourWay || m_selectCurrentItem.m_xWidth == m_selectCurrentItem.m_yWidth)
			{
				if (m_selectCurrentItem.m_flipType != itemScript.flipType.twoWay || !m_selectCurrentItem.m_stackStateMatch || !zone.FindStackTop(m_inputTouchNode, out var _))
				{
					flag = true;
				}
			}
			else if (!m_selectCurrentDelayedLift && zone.FindStackTop(m_inputTouchNode, out _item2))
			{
				if (_item2 == m_selectCurrentItem)
				{
					_item2 = _item2.StackParent();
				}
				flag = m_selectCurrentItem.CanStackTurn(_item2);
			}
			else
			{
				int num = zone.FindClosestGrid(Camera.main.ScreenToWorldPoint(m_inputTouchPosition) - m_offset, _flat: true);
				if (num > -1)
				{
					flag = ((!m_selectCurrentDelayedLift) ? (zone.FitGrid(num, m_selectCurrentItem.yWidth, m_selectCurrentItem.xWidth, m_selectCurrentItem.size) > -1) : (zone.FitGridSpecial(num, m_selectCurrentItem.yWidth, m_selectCurrentItem.xWidth, m_selectCurrentItem.size, m_selectCurrentItem) > -1));
				}
			}
		}
		flag2 = m_selectCurrentDelayedLift;
		if (flag && flag2)
		{
			m_touchControlsItems[0].gameObject.SetActive(value: true);
			m_touchControlsItems[1].gameObject.SetActive(value: true);
			m_touchControlsItems[1].anchoredPosition = new Vector2(0f, -50f);
			m_touchControls.sizeDelta = new Vector2(40f, 90f);
		}
		else if (flag)
		{
			m_touchControlsItems[0].gameObject.SetActive(value: true);
			m_touchControlsItems[1].gameObject.SetActive(value: false);
			m_touchControls.sizeDelta = new Vector2(40f, 40f);
		}
		else
		{
			if (!flag2)
			{
				HideTouchControls();
				return;
			}
			m_touchControlsItems[0].gameObject.SetActive(value: false);
			m_touchControlsItems[1].gameObject.SetActive(value: true);
			m_touchControlsItems[1].anchoredPosition = new Vector2(0f, 0f);
			m_touchControls.sizeDelta = new Vector2(40f, 40f);
		}
		if (flag2 && !string.IsNullOrEmpty(m_audioTouchControlsShow))
		{
			AkSoundEngine.PostEvent(m_audioTouchControlsShow, base.gameObject);
		}
		m_touchControls.gameObject.SetActive(value: true);
		Collider2D component = m_selectCurrentItem.GetComponent<Collider2D>();
		bool num2 = component.enabled;
		if (!num2)
		{
			component.enabled = true;
		}
		Vector2 vector = component.bounds.center;
		Vector2 vector2 = Vector2.right * component.bounds.extents.x;
		if (!num2)
		{
			component.enabled = false;
		}
		RectTransform component2 = m_canvas.GetComponent<RectTransform>();
		Vector2 screenPoint = GetComponent<Camera>().WorldToScreenPoint(vector + vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(component2, screenPoint, null, out var localPoint);
		if (localPoint.x + 46f < component2.sizeDelta.x * 0.5f)
		{
			m_touchControls.pivot = new Vector2(0f, 0.5f);
			localPoint.x += 6f;
		}
		else
		{
			screenPoint = GetComponent<Camera>().WorldToScreenPoint(vector - vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(component2, screenPoint, null, out localPoint);
			m_touchControls.pivot = new Vector2(1f, 0.5f);
			localPoint.x -= 6f;
		}
		float num3 = (component2.sizeDelta.y - m_touchControls.sizeDelta.y) * 0.5f - 2f;
		localPoint.y = Mathf.Clamp(localPoint.y, 0f - num3, num3);
		m_touchControls.anchoredPosition = localPoint;
	}

	private void HideTouchControls()
	{
		m_touchControls.gameObject.SetActive(value: false);
	}

	public bool FileLoad()
	{
		saveData.saveDataStage stage = (saveData.TempStageExists(m_currentStage) ? saveData.GetTempStage() : saveData.GetStage(m_currentStage));
		if (!FileLoadStage(stage))
		{
			return false;
		}
		bool flag = true;
		zoneScript[] zones = m_zones;
		for (int i = 0; i < zones.Length; i++)
		{
			if (zones[i].BoxesRemain())
			{
				flag = false;
				break;
			}
		}
		m_completeTriggered = false;
		m_completeLoadWindow = true;
		if (flag)
		{
			phase = gamePhase.validate;
		}
		m_completeLoadWindow = false;
		return true;
	}

	private void MatchItemsToStage(int _stage)
	{
		if (!saveData.CheckStageComplete(_stage))
		{
			Debug.LogWarning("save file not found or stage " + _stage + " not complete");
			return;
		}
		if (!gameStateScript.CompareChecksums(_stage))
		{
			Debug.LogWarning("stage " + _stage + " has a bad zone checksum");
			return;
		}
		saveData.saveDataStage stage = saveData.GetStage(_stage);
		List<matchItem> _matchList = new List<matchItem>();
		for (int i = 0; i < m_zones.Length; i++)
		{
			m_zones[i].DisconnectItems(ref _matchList, (stage.state == 2) ? m_stageMatchIgnoreItems : new string[0], i);
		}
		for (int j = 0; j < m_zones.Length; j++)
		{
			m_currentZone = j;
			m_zones[j].MatchItems(ref _matchList, m_stageMatchReplace, stage.zones[j].items, j);
		}
		for (int k = 0; k < m_zones.Length; k++)
		{
			m_currentZone = k;
			m_zones[k].MatchRemaining(ref _matchList, m_stageMatchMimic, stage.zones[k].items, k, stage.state == 2);
		}
		if (_matchList.Count > 0)
		{
			Debug.LogWarning("MatchItemsToStage has not matched " + _matchList.Count + " items! Will try to match anywhere");
			foreach (matchItem item in _matchList)
			{
				Debug.Log(item.item.name.ToString());
			}
		}
		for (int l = 0; l < m_zones.Length; l++)
		{
			m_currentZone = l;
			m_zones[l].MatchWildcard(ref _matchList);
		}
		m_currentZone = 0;
		for (int m = 0; m < m_zones.Length; m++)
		{
			m_zones[m].SetActive(m_currentZone == m);
		}
		if (_matchList.Count > 0)
		{
			Debug.LogError("MatchItemsToStage could not match " + _matchList.Count + " items!");
			foreach (matchItem item2 in _matchList)
			{
				Debug.Log(item2.item.name.ToString());
			}
		}
		m_historyZones = new saveData.saveDataZone[m_zones.Length];
		for (int n = 0; n < m_zones.Length; n++)
		{
			m_historyZones[n] = m_zones[n].GetSaveData();
		}
	}

	private byte[] ZoneScreenshot()
	{
		int num = 584;
		int num2 = 330;
		RenderTexture temporary = RenderTexture.GetTemporary(1024, 512, 24, RenderTextureFormat.Default);
		GameObject gameObject = new GameObject("captureCamera");
		Camera camera = gameObject.AddComponent<Camera>();
		camera.enabled = false;
		camera.CopyFrom(GetComponent<Camera>());
		camera.orthographicSize = 2.56f;
		camera.targetTexture = temporary;
		camera.Render();
		RenderTexture.active = temporary;
		Texture2D texture2D = new Texture2D(num, num2, TextureFormat.RGB24, mipChain: false);
		texture2D.ReadPixels(new Rect(512 - num / 2, 256 - num2 / 2, 512 + num / 2, 256 + num2 / 2), 0, 0);
		texture2D.Apply();
		byte[] result = texture2D.EncodeToPNG();
		RenderTexture.active = null;
		RenderTexture.ReleaseTemporary(temporary);
		UnityEngine.Object.Destroy(gameObject);
		return result;
	}
}
