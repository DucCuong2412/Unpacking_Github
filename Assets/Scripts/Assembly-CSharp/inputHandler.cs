using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class inputHandler : BaseInput
{
	public enum ControllerInputType
	{
		Unknown = 0,
		Keyboard = 1,
		Gamepad = 2,
		Touch = 3
	}

	public enum tiltMode
	{
		none = 0,
		left = 1,
		right = 2
	}

	private static inputHandler m_instance;

	private static bool m_isApplicationQuitting = false;

	private ControllerInputType m_currentControllerInputType;

	private int m_curActiveGamepadSlot;

	private uiSceneControllerInputHandler m_cachedUiSceneControllerInputHandler;

	private uiCursor m_cursor;

	private bool m_simulateMouseUpForGamepad;

	private bool m_isCursorDown;

	private bool m_wasCursorDown;

	private bool m_gamepadButtonCursorDownFlag;

	private PointerEventData m_cachedPointerEventData;

	private List<RaycastResult> m_raycastResultCache = new List<RaycastResult>();

	private TouchPhase m_touchAsMenuCursorPhase = TouchPhase.Canceled;

	private int m_touchAsMenuCursorFingerId = -1;

	public static UnityEvent OnControllerInputTypeChanged = new UnityEvent();

	private bool m_listeningForRebind;

	private bool m_rebindFrameIgnore;

	private bool m_menuAcceptLock;

	private bool m_postRebindMouseLock;

	public static UnityEvent OnInputRebindCaptured = new UnityEvent();

	public static UnityEvent OnInputRebindComplete = new UnityEvent();

	private TMP_InputField m_activatedInputField;

	private static bool m_inputHandledFlag = false;

	private bool m_inputFieldSubmitFlag;

	public uiInputHandlerDebug m_debugUI;

	public float m_rebindHoldCancelDuration = 1.5f;

	private float m_rebindHoldCancelTimer;

	public controlScheme_kbm m_keyboardControlScheme;

	public controlScheme_gamepad m_gamepadControlScheme;

	public controlScheme_switch m_switchControlScheme;

	private controlScheme m_currentControlScheme;

	public touchScheme_unity m_standaloneTouchScreen;

	public touchScheme_unity m_switchTouchScreen;

	public touchScheme_unity m_mobileTouchScreen;

	private touchScheme m_currentTouchScheme;

	public uiInputActionIcon InputActionIconPrefab;

	private float m_joystickSpeed = 7.5f;

	private float m_resolutionWidthRatio = 1f;

	public float m_minJoystickSpeed = 3f;

	public float m_maxJoystickSpeed = 20f;

	public int m_joystickSensitivityTickLength = 10;

	public int m_defaultJoystickSensitivity = 8;

	private int m_currentJoystickSensitivity = -1;

	public AnimationCurve m_joystickCurve;

	public float m_uiJoystickAxialDeadZone = 0.1f;

	private Vector2 m_uiNavAxis = Vector2.zero;

	private bool m_areAnalogSticksReversed;

	private bool m_isVibrationEnabled;

	public static inputHandler Instance
	{
		get
		{
			ResolveInstance();
			return m_instance;
		}
	}

	public static ControllerInputType CurrentControllerInputType
	{
		get
		{
			if (!(Instance != null))
			{
				return ControllerInputType.Unknown;
			}
			return Instance.m_currentControllerInputType;
		}
	}

	public static bool MouseEventsActive
	{
		get
		{
			if (Instance == null || Instance.m_cursor == null)
			{
				return true;
			}
			return Instance.m_cursor.AreMouseEventsActive;
		}
	}

	public static PointerEventData CachedPointerEvenData => Instance.m_cachedPointerEventData;

	public static TouchPhase TouchAsMenuCursorPhase => Instance.m_touchAsMenuCursorPhase;

	public static bool IsListeningForRebind
	{
		get
		{
			if (Instance == null)
			{
				return false;
			}
			if (!Instance.m_listeningForRebind)
			{
				return Instance.m_rebindFrameIgnore;
			}
			return true;
		}
	}

	public static TMP_InputField ActiveInputField => Instance.m_activatedInputField;

	public static bool m_debugLoggingEnabled { get; private set; } = false;

	public static Vector2 CursorPosition { get; set; } = Vector2.zero;

	public static Vector2 CursorDelta { get; set; } = Vector2.zero;

	public static tiltMode TiltControl { get; set; } = tiltMode.none;

	public static bool IsAnyKeyOrButtonDown
	{
		get
		{
			if (IsListeningForRebind)
			{
				return false;
			}
			return Instance.m_currentControlScheme.AnyKeyOrButtonDown();
		}
	}

	public static bool IsAnyKeyOrButtonPressed
	{
		get
		{
			if (IsListeningForRebind)
			{
				return false;
			}
			return Instance.m_currentControlScheme.AnyKeyOrButtonPressed();
		}
	}

	public static bool HasAnyAxisMoved
	{
		get
		{
			if (IsListeningForRebind || Instance.m_currentControlScheme == null)
			{
				return false;
			}
			return Instance.m_currentControlScheme.AnyAxisMoved();
		}
	}

	public static int TouchCount
	{
		get
		{
			if (m_instance == null)
			{
				return 0;
			}
			return m_instance.touchCount;
		}
	}

	public static Touch[] Touches
	{
		get
		{
			if (m_instance == null || m_instance.m_currentTouchScheme == null)
			{
				return new Touch[0];
			}
			return m_instance.m_currentTouchScheme.Touches;
		}
	}

	public static float CurrentJoystickSpeed
	{
		get
		{
			if (Instance == null)
			{
				return 1f;
			}
			return Instance.m_joystickSpeed * Instance.m_resolutionWidthRatio;
		}
	}

	public static int JoystickSensitivityTickLength => Instance.m_joystickSensitivityTickLength;

	public static int CurrentJoystickSensitivity
	{
		get
		{
			return Instance.m_currentJoystickSensitivity;
		}
		set
		{
			if (Instance.m_currentJoystickSensitivity != value)
			{
				if (value < 0 || value >= Instance.m_joystickSensitivityTickLength)
				{
					Debug.LogError("Trying to set currentJoystickSensitivityTick outside or range!");
					return;
				}
				Instance.m_currentJoystickSensitivity = value;
				PlayerPrefs.SetInt("inputHandler.js", value);
				gameStateScript.PrefSaveDirty();
				Instance.OnJoystickSensitivityChanged();
			}
		}
	}

	public static int DefaultJoystickSensitivity => Instance.m_defaultJoystickSensitivity;

	public static float CurrentUIJoystickAxialDeadZone
	{
		get
		{
			if (Instance == null)
			{
				return 0f;
			}
			return Instance.m_uiJoystickAxialDeadZone;
		}
	}

	public static bool AreAnalogSticksReversed
	{
		get
		{
			return Instance.m_areAnalogSticksReversed;
		}
		set
		{
			if (Instance.m_areAnalogSticksReversed != value)
			{
				Instance.m_areAnalogSticksReversed = value;
				if (m_instance.m_currentControlScheme != null)
				{
					m_instance.m_currentControlScheme.RefreshAnalogSticks();
				}
				PlayerPrefs.SetInt("inputHandler.asr", value ? 1 : 0);
				gameStateScript.PrefSaveDirty();
			}
		}
	}

	public static bool IsVibrationEnabled
	{
		get
		{
			return Instance.m_isVibrationEnabled;
		}
		set
		{
			if (Instance.m_isVibrationEnabled != value)
			{
				Instance.m_isVibrationEnabled = value;
				PlayerPrefs.SetInt("inputHandler.vi", value ? 1 : 0);
				gameStateScript.PrefSaveDirty();
				if (!value)
				{
					vibrationScript.Stop();
				}
			}
		}
	}

	public override string compositionString => Input.compositionString;

	public override IMECompositionMode imeCompositionMode
	{
		get
		{
			return Input.imeCompositionMode;
		}
		set
		{
			Input.imeCompositionMode = value;
		}
	}

	public override Vector2 compositionCursorPos
	{
		get
		{
			return Input.compositionCursorPos;
		}
		set
		{
			Input.compositionCursorPos = value;
		}
	}

	public override bool mousePresent => CurrentControllerInputType != ControllerInputType.Touch;

	public override Vector2 mousePosition => CursorPosition;

	public override Vector2 mouseScrollDelta
	{
		get
		{
			Vector2 result = Input.mouseScrollDelta;
			result.x *= -1f;
			return result;
		}
	}

	public override bool touchSupported => Input.touchSupported;

	public override int touchCount
	{
		get
		{
			if (m_currentTouchScheme != null)
			{
				return m_currentTouchScheme.TouchCount;
			}
			return Input.touchCount;
		}
	}

	private static void ResolveInstance()
	{
		if (m_instance == null && !m_isApplicationQuitting)
		{
			m_instance = Object.FindObjectOfType<inputHandler>();
			if (m_instance == null)
			{
				Debug.LogError("Could not find inputHandler instance!");
			}
		}
	}

	public static void SetMotionControl()
	{
		if (TiltControl == tiltMode.none)
		{
			TiltControl = tiltMode.right;
		}
		else
		{
			Instance.CenterCursor();
		}
	}

	public static bool IsDown(InputAction inputAction)
	{
		if (IsListeningForRebind || Instance.m_currentControlScheme == null)
		{
			return false;
		}
		if (Instance.m_activatedInputField != null && inputAction <= InputAction.Menu_NavigateRight)
		{
			return false;
		}
		return Instance.m_currentControlScheme.IsInputActionDown(inputAction);
	}

	public static bool IsPressed(InputAction inputAction, bool ignoreInputHandled = false)
	{
		if (IsListeningForRebind || Instance.m_currentControlScheme == null)
		{
			return false;
		}
		if (Instance.m_activatedInputField != null && inputAction <= InputAction.Menu_NavigateRight)
		{
			return false;
		}
		bool flag = Instance.m_currentControlScheme.IsInputActionPressed(inputAction);
		if (ignoreInputHandled)
		{
			return flag;
		}
		if (m_inputHandledFlag)
		{
			return false;
		}
		m_inputHandledFlag = flag;
		return flag;
	}

	public static bool IsReleased(InputAction inputAction)
	{
		if (IsListeningForRebind || Instance.m_currentControlScheme == null)
		{
			return false;
		}
		if (Instance.m_activatedInputField != null && inputAction <= InputAction.Menu_NavigateRight)
		{
			return false;
		}
		return Instance.m_currentControlScheme.IsInputActionReleased(inputAction);
	}

	public static Vector2 GetAxis2D(InputAction inputAction)
	{
		if (IsListeningForRebind || Instance.m_currentControlScheme == null)
		{
			return Vector2.zero;
		}
		return Instance.m_currentControlScheme.GetAxis2D(inputAction);
	}

	public static Vector2 GetAxis2DRaw(InputAction inputAction)
	{
		if (IsListeningForRebind || Instance.m_currentControlScheme == null)
		{
			return Vector2.zero;
		}
		return Instance.m_currentControlScheme.GetAxis2DRaw(inputAction);
	}

	public static Touch GetTouchAtIdx(int index)
	{
		if (m_instance == null)
		{
			return new Touch
			{
				fingerId = -1
			};
		}
		return m_instance.GetTouch(index);
	}

	public static bool IsTouchDown(int index)
	{
		if (m_instance == null || m_instance.m_currentTouchScheme == null)
		{
			return false;
		}
		return m_instance.m_currentTouchScheme.IsTouchDown(index);
	}

	public static bool IsPointerDown()
	{
		if (m_instance == null)
		{
			return false;
		}
		if (m_instance.m_touchAsMenuCursorFingerId == -1)
		{
			return IsDown(InputAction.Gameplay_LiftAndPlace);
		}
		return true;
	}

	public static bool IsPointerPressed()
	{
		if (m_instance == null)
		{
			return false;
		}
		if (m_instance.m_touchAsMenuCursorPhase != TouchPhase.Began)
		{
			return IsPressed(InputAction.Gameplay_LiftAndPlace, ignoreInputHandled: true);
		}
		return true;
	}

	public static bool IsPointerReleased()
	{
		if (m_instance == null)
		{
			return false;
		}
		if (m_instance.m_touchAsMenuCursorPhase != TouchPhase.Ended)
		{
			return IsReleased(InputAction.Gameplay_LiftAndPlace);
		}
		return true;
	}

	public static bool IsPointerOverGameObject()
	{
		ControllerInputType currentControllerInputType = CurrentControllerInputType;
		if (currentControllerInputType == ControllerInputType.Touch)
		{
			if (EventSystem.current.IsPointerOverGameObject(0))
			{
				return true;
			}
			if (CachedPointerEvenData == null)
			{
				return false;
			}
			return CachedPointerEvenData.pointerEnter != null;
		}
		return EventSystem.current.IsPointerOverGameObject();
	}

	private void OnJoystickSensitivityChanged()
	{
		if (m_joystickSensitivityTickLength <= 1)
		{
			Debug.LogError("joystickSensitivityTickLength invalid!");
			return;
		}
		m_joystickSpeed = Mathf.Lerp(m_minJoystickSpeed, m_maxJoystickSpeed, (float)m_currentJoystickSensitivity / (float)(m_joystickSensitivityTickLength - 1));
		Debug.Log("m_joystickSpeed set to " + m_joystickSpeed);
	}

	protected override void Awake()
	{
		Object.DontDestroyOnLoad(base.gameObject);
	}

	protected override void Start()
	{
		Input.simulateMouseWithTouches = false;
		CurrentJoystickSensitivity = PlayerPrefs.GetInt("inputHandler.js", m_defaultJoystickSensitivity);
		AreAnalogSticksReversed = PlayerPrefs.GetInt("inputHandler.asr", 0) != 0;
		IsVibrationEnabled = PlayerPrefs.GetInt("inputHandler.vi", 1) != 0;
		m_keyboardControlScheme.Init();
		m_gamepadControlScheme.Init();
		m_standaloneTouchScreen.Init();
		SetResolution(Screen.width, Screen.height);
		CenterCursor();
		m_cachedUiSceneControllerInputHandler = Object.FindObjectOfType<uiSceneControllerInputHandler>();
		RefreshInputOverride();
		RefreshControllerInput();
	}

	private void OnApplicationQuit()
	{
		m_isApplicationQuitting = true;
	}

	private void OnLevelWasLoaded(int level)
	{
		m_cachedUiSceneControllerInputHandler = Object.FindObjectOfType<uiSceneControllerInputHandler>();
		RefreshInputOverride();
	}

	private void RefreshInputOverride()
	{
		StandaloneInputModule standaloneInputModule = Object.FindObjectOfType<StandaloneInputModule>();
		if ((bool)standaloneInputModule)
		{
			standaloneInputModule.inputOverride = this;
		}
	}

	private void Update()
	{
		m_inputHandledFlag = false;
		PollInputDevices();
		RefreshControllerInput();
		if (m_listeningForRebind)
		{
			if (m_rebindFrameIgnore)
			{
				m_rebindFrameIgnore = false;
				return;
			}
			if (m_menuAcceptLock)
			{
				if (!m_currentControlScheme.IsInputActionDown(InputAction.Menu_Accept))
				{
					m_menuAcceptLock = false;
				}
				return;
			}
			bool flag = false;
			if (m_gamepadControlScheme != null)
			{
				m_gamepadControlScheme.UpdateRebind();
				flag = m_gamepadControlScheme.IsInputActionDown(InputAction.Menu_Back);
			}
			if (m_keyboardControlScheme != null)
			{
				m_keyboardControlScheme.UpdateRebind();
				flag |= m_keyboardControlScheme.IsInputActionDown(InputAction.Menu_Back);
			}
			if (flag)
			{
				m_rebindHoldCancelTimer += Time.deltaTime;
				if (m_rebindHoldCancelTimer > m_rebindHoldCancelDuration)
				{
					EndRebind();
					return;
				}
			}
			else
			{
				m_rebindHoldCancelTimer = 0f;
			}
			if (CurrentControllerInputType != ControllerInputType.Gamepad)
			{
				CursorPosition = Input.mousePosition;
			}
			return;
		}
		if (m_currentTouchScheme != null)
		{
			m_currentTouchScheme.Update();
			if (TouchCount > 0)
			{
				Touch touch = Touches[0];
				if (m_touchAsMenuCursorFingerId == -1)
				{
					m_touchAsMenuCursorFingerId = touch.fingerId;
				}
				m_touchAsMenuCursorPhase = touch.phase;
			}
			else
			{
				m_touchAsMenuCursorPhase = TouchPhase.Canceled;
				m_touchAsMenuCursorFingerId = -1;
			}
		}
		if (m_currentControlScheme != null)
		{
			m_currentControlScheme.Update();
			if (m_activatedInputField != null && IsPressed(InputAction.Menu_Accept, ignoreInputHandled: true))
			{
				EventSystem.current.SetSelectedGameObject(null);
			}
			if (CurrentControllerInputType != ControllerInputType.Gamepad)
			{
				CursorPosition = Input.mousePosition;
				CursorDelta = Vector2.zero;
			}
			else if (MouseEventsActive)
			{
				CursorDelta = ((TiltControl == tiltMode.none) ? m_currentControlScheme.GetAxis2DRaw(InputAction.Gameplay_CursorMove) : m_currentControlScheme.GetAxisTilt(TiltControl));
				if (CursorDelta.sqrMagnitude > 0f)
				{
					if (TiltControl == tiltMode.none)
					{
						float num = Mathf.Pow(Mathf.Clamp01(CursorDelta.magnitude), 2f);
						CursorDelta = CursorDelta.normalized * num;
					}
					CursorDelta *= CurrentJoystickSpeed * Time.deltaTime * 60f;
					CursorPosition = new Vector2(Mathf.Clamp(CursorPosition.x + CursorDelta.x, 0f, Screen.width), Mathf.Clamp(CursorPosition.y + CursorDelta.y, 0f, Screen.height));
				}
			}
			m_simulateMouseUpForGamepad = true;
			if (m_cachedUiSceneControllerInputHandler != null)
			{
				m_simulateMouseUpForGamepad = m_cachedUiSceneControllerInputHandler.canSimulateMouseUpForGamepad;
			}
			if (m_simulateMouseUpForGamepad && m_currentControllerInputType == ControllerInputType.Gamepad)
			{
				m_wasCursorDown = m_isCursorDown;
				bool flag2 = IsDown(InputAction.Gameplay_LiftAndPlace);
				if (m_gamepadButtonCursorDownFlag && flag2)
				{
					m_isCursorDown = false;
				}
				else
				{
					m_gamepadButtonCursorDownFlag = (m_isCursorDown = flag2);
				}
			}
			else
			{
				m_wasCursorDown = m_isCursorDown;
				m_isCursorDown = IsDown(InputAction.Gameplay_LiftAndPlace);
				m_gamepadButtonCursorDownFlag = false;
			}
			m_uiNavAxis.x = m_currentControlScheme.GetHorizontalAxis();
			m_uiNavAxis.y = m_currentControlScheme.GetVerticalAxis();
			if (m_uiNavAxis.sqrMagnitude <= m_uiJoystickAxialDeadZone * m_uiJoystickAxialDeadZone)
			{
				m_uiNavAxis = Vector2.zero;
			}
		}
		UpdatePointerEventData();
		if (m_postRebindMouseLock && !Input.GetMouseButton(0))
		{
			uiDebug.Log(base.gameObject, "Update: Mouse lock flag reset.");
			m_postRebindMouseLock = false;
		}
	}

	private static RaycastResult FindFirstRaycast(List<RaycastResult> candidates)
	{
		for (int i = 0; i < candidates.Count; i++)
		{
			if (!(candidates[i].gameObject == null))
			{
				return candidates[i];
			}
		}
		return default(RaycastResult);
	}

	private void UpdatePointerEventData()
	{
		if (m_cachedPointerEventData == null)
		{
			m_cachedPointerEventData = new PointerEventData(EventSystem.current);
		}
		if (m_currentControllerInputType == ControllerInputType.Touch)
		{
			if (TouchCount > 0)
			{
				m_cachedPointerEventData.position = Touches[0].position;
			}
		}
		else
		{
			m_cachedPointerEventData.position = CursorPosition;
		}
		EventSystem.current.RaycastAll(m_cachedPointerEventData, m_raycastResultCache);
		RaycastResult raycastResult = FindFirstRaycast(m_raycastResultCache);
		m_cachedPointerEventData.pointerEnter = raycastResult.gameObject;
		m_raycastResultCache.Clear();
	}

	private void PollInputDevices()
	{
		if (m_keyboardControlScheme != null)
		{
			m_keyboardControlScheme.Poll();
		}
		if (m_gamepadControlScheme != null)
		{
			m_gamepadControlScheme.Poll();
		}
		if (m_standaloneTouchScreen != null)
		{
			m_standaloneTouchScreen.Poll();
		}
	}

	public override float GetAxisRaw(string axisName)
	{
		if (axisName == "Horizontal")
		{
			return m_uiNavAxis.x;
		}
		if (axisName == "Vertical")
		{
			return m_uiNavAxis.y;
		}
		return Input.GetAxisRaw(axisName);
	}

	public override bool GetButtonDown(string buttonName)
	{
		if (IsListeningForRebind)
		{
			return false;
		}
		if (m_inputHandledFlag)
		{
			return false;
		}
		if (m_currentControlScheme != null)
		{
			if (buttonName == "Submit")
			{
				return m_currentControlScheme.IsSubmitButtonPressed();
			}
			if (buttonName == "Cancel")
			{
				return m_currentControlScheme.IsCancelButtonPressed();
			}
		}
		return Input.GetButtonDown(buttonName);
	}

	public override bool GetMouseButton(int button)
	{
		if (IsListeningForRebind || m_postRebindMouseLock)
		{
			return false;
		}
		if (m_currentControlScheme != null && button == 0)
		{
			if (m_isCursorDown)
			{
				return MouseEventsActive;
			}
			return false;
		}
		return Input.GetMouseButton(button);
	}

	public override bool GetMouseButtonDown(int button)
	{
		if (IsListeningForRebind || m_postRebindMouseLock)
		{
			return false;
		}
		if (m_currentControlScheme != null && button == 0)
		{
			if (m_isCursorDown && !m_wasCursorDown)
			{
				return MouseEventsActive;
			}
			return false;
		}
		return Input.GetMouseButtonDown(button);
	}

	public override bool GetMouseButtonUp(int button)
	{
		if (IsListeningForRebind || m_postRebindMouseLock)
		{
			return false;
		}
		if (m_currentControlScheme != null && button == 0)
		{
			if (!m_isCursorDown && m_wasCursorDown)
			{
				return MouseEventsActive;
			}
			return false;
		}
		return Input.GetMouseButtonUp(button);
	}

	public override Touch GetTouch(int index)
	{
		if (m_currentTouchScheme != null)
		{
			return m_currentTouchScheme.GetTouch(index);
		}
		return Input.GetTouch(index);
	}

	private void OnControlInputChanged()
	{
		m_cachedUiSceneControllerInputHandler?.RefreshUISelection();
		OnControllerInputTypeChanged?.Invoke();
		if (m_currentControllerInputType == ControllerInputType.Gamepad && (CursorPosition.x < 0f || CursorPosition.x > (float)Screen.width || CursorPosition.y < 0f || CursorPosition.y > (float)Screen.height))
		{
			CenterCursor();
		}
	}

	public void RegisterCursor(uiCursor cursor)
	{
		m_cursor = cursor;
	}

	public void CenterCursor()
	{
		CursorPosition = new Vector2((float)Screen.width * 0.5f, (float)Screen.height * 0.5f);
		if (m_cursor != null)
		{
			m_cursor.SetCursorPosition(CursorPosition);
		}
	}

	public void OnInputFieldEntered(TMP_InputField inputField)
	{
		if (m_activatedInputField != null && m_activatedInputField != inputField)
		{
			EventSystem.current.SetSelectedGameObject(null);
		}
		m_activatedInputField = inputField;
		if (m_activatedInputField != null && EventSystem.current.currentSelectedGameObject != m_activatedInputField.gameObject)
		{
			m_activatedInputField.Select();
		}
	}

	public void OnInputFieldExited(TMP_InputField inputField)
	{
		if (!(m_activatedInputField == null) && !(m_activatedInputField != inputField))
		{
			m_activatedInputField = null;
			if (!EventSystem.current.alreadySelecting)
			{
				EventSystem.current.SetSelectedGameObject(null);
			}
			m_inputFieldSubmitFlag = true;
		}
	}

	public static void OnUIElementPressed(uiGamepadNavigationElement element)
	{
		m_inputHandledFlag = true;
	}

	public static void SetResolution(int _width, int _height)
	{
		if (!(Instance == null))
		{
			Instance.m_resolutionWidthRatio = (float)_width / 1920f;
		}
	}

	public bool ForceShowInputActionIcons()
	{
		return false;
	}

	public bool IsControllerInputTypeAvailable(ControllerInputType controllerInputType)
	{
		return controllerInputType != ControllerInputType.Unknown;
	}

	public Sprite[] QueryInputActionIconTutorial(InputAction inputAction)
	{
		if (m_currentControlScheme == null)
		{
			return null;
		}
		return m_currentControlScheme.GetIcons(inputAction, 0, tutorial: true);
	}

	public Sprite[] QueryInputActionIcons(InputAction inputAction, int layoutSlot)
	{
		if (m_currentControlScheme == null)
		{
			return null;
		}
		return m_currentControlScheme.GetIcons(inputAction, layoutSlot);
	}

	public Sprite[] QueryInputActionIconsForDeviceType(ControllerInputType deviceType, InputAction inputAction, int layoutSlot)
	{
		switch (deviceType)
		{
		case ControllerInputType.Keyboard:
			if (m_keyboardControlScheme != null)
			{
				return m_keyboardControlScheme.GetIcons(inputAction, layoutSlot);
			}
			break;
		case ControllerInputType.Gamepad:
			if (m_gamepadControlScheme != null)
			{
				return m_gamepadControlScheme.GetIcons(inputAction, layoutSlot);
			}
			break;
		}
		return null;
	}

	public string QueryInputActionString(InputAction inputAction, int layoutSlot)
	{
		if (m_currentControlScheme == null)
		{
			return "<null>";
		}
		return m_currentControlScheme.GetBindingString(inputAction, layoutSlot);
	}

	public string QueryInputActionStringForDeviceType(ControllerInputType deviceType, InputAction inputAction, int layoutSlot)
	{
		switch (deviceType)
		{
		case ControllerInputType.Keyboard:
			if (m_keyboardControlScheme != null)
			{
				return m_keyboardControlScheme.GetBindingString(inputAction, layoutSlot);
			}
			break;
		case ControllerInputType.Gamepad:
			if (m_gamepadControlScheme != null)
			{
				return m_gamepadControlScheme.GetBindingString(inputAction, layoutSlot);
			}
			break;
		}
		return null;
	}

	private void RefreshControllerInput()
	{
		if (m_activatedInputField != null)
		{
			return;
		}
		if (m_inputFieldSubmitFlag)
		{
			m_inputFieldSubmitFlag = false;
			return;
		}
		ControllerInputType controllerInputType = m_currentControllerInputType;
		controlScheme controlScheme2 = m_currentControlScheme;
		touchScheme touchScheme2 = m_currentTouchScheme;
		if (controlScheme2 == null && touchScheme2 == null)
		{
			controllerInputType = ControllerInputType.Keyboard;
			controlScheme2 = m_keyboardControlScheme;
		}
		bool flag = m_keyboardControlScheme.AnyKeyOrButtonPressed() || m_keyboardControlScheme.AnyAxisMoved();
		bool flag2 = m_gamepadControlScheme.AnyKeyOrButtonPressed() || m_gamepadControlScheme.AnyAxisMoved();
		bool num = m_standaloneTouchScreen.IsTouchDown();
		bool flag3 = m_curActiveGamepadSlot != m_gamepadControlScheme.CurrentActiveGamepadSlot;
		if (flag3)
		{
			m_curActiveGamepadSlot = m_gamepadControlScheme.CurrentActiveGamepadSlot;
		}
		if (num)
		{
			controllerInputType = ControllerInputType.Touch;
			touchScheme2 = m_standaloneTouchScreen;
		}
		else if (flag)
		{
			controllerInputType = ControllerInputType.Keyboard;
			controlScheme2 = m_keyboardControlScheme;
		}
		else if (flag2)
		{
			controllerInputType = ControllerInputType.Gamepad;
			controlScheme2 = m_gamepadControlScheme;
		}
		if (m_currentControllerInputType != controllerInputType || flag3)
		{
			uiDebug.Log(base.gameObject, $"Switched from {m_currentControllerInputType} to {controllerInputType}");
			m_currentControllerInputType = controllerInputType;
			if (m_currentControlScheme != null && m_currentControlScheme.IsActive)
			{
				m_currentControlScheme.OnDeactivate();
			}
			if (m_currentTouchScheme != null && m_currentTouchScheme.IsActive)
			{
				m_currentTouchScheme.OnDeactivate();
			}
			switch (controllerInputType)
			{
			case ControllerInputType.Unknown:
				m_currentControlScheme = null;
				m_currentTouchScheme = null;
				break;
			case ControllerInputType.Keyboard:
			case ControllerInputType.Gamepad:
				m_currentControlScheme = controlScheme2;
				m_currentControlScheme.OnActivate();
				OnControlInputChanged();
				break;
			case ControllerInputType.Touch:
				m_currentTouchScheme = touchScheme2;
				m_currentTouchScheme.OnActivate();
				OnControlInputChanged();
				break;
			}
		}
	}

	[ContextMenu("Toggle Debug Logging")]
	private void ToggleDebugLogging()
	{
		m_debugLoggingEnabled = !m_debugLoggingEnabled;
	}

	public void RevertCurrentBindings()
	{
		if (m_currentControlScheme != null)
		{
			m_currentControlScheme.Load();
		}
	}

	[ContextMenu("Save Current Bindings")]
	public void SaveCurrentBindings()
	{
		if (m_currentControlScheme != null)
		{
			m_currentControlScheme.Save();
		}
	}

	[ContextMenu("Revert To Default Bindings")]
	public void RevertToDefaultBindings(bool currentSchemeOnly = true)
	{
		if (currentSchemeOnly)
		{
			if (m_currentControlScheme != null)
			{
				m_currentControlScheme.RevertToDefault();
			}
			return;
		}
		if (m_keyboardControlScheme != null)
		{
			m_keyboardControlScheme.RevertToDefault();
		}
		if (m_gamepadControlScheme != null)
		{
			m_gamepadControlScheme.RevertToDefault();
		}
	}

	public void BeginRebind(InputAction inputAction, int layoutSlot, InputAction[] conflictResolutionList)
	{
		if (m_listeningForRebind)
		{
			Debug.LogWarning("Already listening for a rebind.");
			return;
		}
		m_listeningForRebind = true;
		m_rebindFrameIgnore = true;
		m_menuAcceptLock = true;
		m_rebindHoldCancelTimer = 0f;
		if (m_gamepadControlScheme != null)
		{
			m_gamepadControlScheme.BeginRebind(inputAction, layoutSlot, conflictResolutionList);
		}
		if (m_keyboardControlScheme != null)
		{
			m_keyboardControlScheme.BeginRebind(inputAction, layoutSlot, conflictResolutionList);
		}
	}

	public void EndRebind()
	{
		if (m_listeningForRebind)
		{
			uiDebug.Log(base.gameObject, "EndRebind");
			m_listeningForRebind = false;
			m_menuAcceptLock = false;
			if (Input.GetMouseButton(0))
			{
				uiDebug.Log(base.gameObject, "EndRebind: Detected LMB down, setting mouse lock flag.");
				m_postRebindMouseLock = true;
			}
			if (m_gamepadControlScheme != null)
			{
				m_gamepadControlScheme.CancelRebind();
			}
			if (m_keyboardControlScheme != null)
			{
				m_keyboardControlScheme.CancelRebind();
			}
			OnInputRebindComplete.Invoke();
		}
	}

	public static void SendVibration(int motorIndex, float motorLevel, float duration)
	{
		if (!(m_instance == null) && !(m_instance.m_currentControlScheme == null) && IsVibrationEnabled)
		{
			m_instance.m_currentControlScheme.SendVibration(motorIndex, motorLevel, duration);
		}
	}

	public static void ShowControllerApplet(bool _vertical = false)
	{
	}

	public static bool JoyconLeft()
	{
		return false;
	}

	public static void SetVibration(Vector4 _left, Vector4 _right)
	{
		if (!(m_instance == null) && !(m_instance.m_currentControlScheme == null) && IsVibrationEnabled)
		{
			m_instance.m_switchControlScheme.SetVibration(_left, _right);
		}
	}

	public static void StopVibration()
	{
		if (!(m_instance == null) && !(m_instance.m_currentControlScheme == null))
		{
			m_instance.m_switchControlScheme.StopVibration();
		}
	}

	public static void ReinitialiseGamepad()
	{
		m_instance.m_gamepadControlScheme.Init();
		m_instance.m_gamepadControlScheme.OnActivate();
	}
}
