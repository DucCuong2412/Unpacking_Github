using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class uiCursor : MonoBehaviour
{
	public enum cursorState
	{
		none = 0,
		use = 1,
		valid = 2,
		invalidSpace = 3,
		invalidHeight = 4,
		invalidStackSpace = 5,
		invalidStackHeight = 6,
		hide = 7
	}

	public enum CursorBehaviour
	{
		Default = 0,
		ManualCursorState = 1,
		Custom = 2
	}

	private RectTransform m_cursorTransform;

	private Image m_cursor;

	public Image m_cursorFill;

	public Sprite[] m_cursorFrames;

	public Color m_normal = new Color(0.7f, 0.7f, 0.7f);

	public Color m_bright = new Color(1f, 1f, 1f);

	public Color m_invalid = new Color(1f, 0.7f, 0.5f);

	private cursorState m_lastState;

	private Color m_lastColor = Color.white;

	private Color m_nextColor = Color.white;

	private bool m_fillChange;

	private float m_fillLerp;

	private int m_frame;

	private float m_frameTimer;

	private bool m_click;

	private float m_pixelSize = 2f;

	private float m_pixelDivision = 0.5f;

	private bool m_cursorInUse;

	private bool m_confineInGame = true;

	private CursorBehaviour behaviour;

	private bool isConfined;

	private bool m_nextFrameLock;

	public bool cursorInUse => m_cursorInUse;

	public bool confineInGame
	{
		set
		{
			m_confineInGame = value;
		}
	}

	public int pixelSize
	{
		set
		{
			m_pixelSize = value;
			m_pixelDivision = 1f / m_pixelSize;
		}
	}

	public CursorBehaviour Behaviour
	{
		get
		{
			return behaviour;
		}
		set
		{
			if (behaviour != value)
			{
				behaviour = value;
				OnBehaviourChanged();
			}
		}
	}

	public bool IsConfined
	{
		get
		{
			return isConfined;
		}
		set
		{
			isConfined = value;
			if (m_cursorTransform != null && m_cursorTransform.gameObject.activeInHierarchy)
			{
				if (isConfined && m_confineInGame)
				{
					Cursor.lockState = CursorLockMode.None;
					Cursor.lockState = CursorLockMode.Confined;
				}
				else
				{
					Cursor.lockState = CursorLockMode.None;
				}
			}
		}
	}

	public bool AreMouseEventsActive
	{
		get
		{
			if (base.gameObject.activeInHierarchy)
			{
				return !m_nextFrameLock;
			}
			return false;
		}
	}

	private void Awake()
	{
		m_cursorTransform = GetComponent<RectTransform>();
		m_cursor = GetComponent<Image>();
		m_lastColor = m_normal;
		m_cursorFill.color = m_lastColor;
		inputHandler.OnControllerInputTypeChanged.AddListener(OnInputDeviceTypeChanged);
		OnInputDeviceTypeChanged();
	}

	private void OnEnable()
	{
		m_nextFrameLock = true;
	}

	private void OnDestroy()
	{
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnInputDeviceTypeChanged);
	}

	private void OnInputDeviceTypeChanged()
	{
		RefreshCursorVisibility();
	}

	private void OnBehaviourChanged()
	{
		RefreshCursorVisibility();
	}

	private void RefreshCursorVisibility()
	{
		if (behaviour != CursorBehaviour.Custom && !(inputHandler.Instance == null))
		{
			switch (inputHandler.CurrentControllerInputType)
			{
			case inputHandler.ControllerInputType.Keyboard:
				ShowCursor(_value: true);
				break;
			case inputHandler.ControllerInputType.Gamepad:
			case inputHandler.ControllerInputType.Touch:
				ShowCursor(_value: false);
				break;
			case inputHandler.ControllerInputType.Unknown:
				break;
			}
		}
	}

	public void SetCursorPosition(Vector2 _position)
	{
		_position.x = Mathf.Round((_position.x - (float)Screen.width * 0.5f) * m_pixelDivision);
		_position.y = Mathf.Round((_position.y - (float)Screen.height * 0.5f) * m_pixelDivision);
		m_cursorTransform.localPosition = _position;
	}

	public void SetCursorState(cursorState _state)
	{
		Cursor.visible = false;
		if (_state != m_lastState)
		{
			if (m_lastState == cursorState.hide)
			{
				m_cursor.enabled = true;
				m_cursorFill.enabled = true;
			}
			m_fillChange = true;
			m_fillLerp = 0f;
			m_lastState = _state;
			m_lastColor = m_cursorFill.color;
			if (m_lastState == cursorState.valid || m_lastState == cursorState.use)
			{
				m_nextColor = m_bright;
			}
			else
			{
				m_nextColor = m_normal;
			}
			if (m_lastState == cursorState.hide)
			{
				m_cursor.enabled = false;
				m_cursorFill.enabled = false;
			}
		}
	}

	public void ShowCursor(bool _value)
	{
		m_cursorTransform.gameObject.SetActive(_value);
		m_cursorInUse = _value;
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad)
		{
			if (_value)
			{
				Cursor.lockState = ((isConfined && m_confineInGame) ? CursorLockMode.Confined : CursorLockMode.None);
			}
			else
			{
				Cursor.lockState = CursorLockMode.Locked;
			}
		}
		else
		{
			Cursor.lockState = ((isConfined && m_confineInGame) ? CursorLockMode.Confined : CursorLockMode.None);
		}
	}

	public void Click()
	{
		m_click = true;
	}

	private void Update()
	{
		if (behaviour < CursorBehaviour.Custom && inputHandler.Instance != null)
		{
			SetCursorPosition(inputHandler.CursorPosition);
		}
		if (behaviour < CursorBehaviour.ManualCursorState)
		{
			SetCursorState(EventSystem.current.IsPointerOverGameObject() ? cursorState.valid : cursorState.none);
		}
		if (m_fillChange)
		{
			m_fillLerp += Time.deltaTime * 10f;
			m_cursorFill.color = Color.Lerp(m_lastColor, m_nextColor, m_fillLerp);
			if (m_fillLerp >= 1f)
			{
				m_fillChange = false;
			}
		}
		if ((m_lastState != cursorState.use || m_frame >= 3) && (m_lastState == cursorState.use || m_frame <= 0) && !m_click)
		{
			return;
		}
		m_frameTimer -= Time.deltaTime;
		if (!(m_frameTimer <= 0f))
		{
			return;
		}
		m_frameTimer = 0.0666f;
		if (m_lastState == cursorState.use || m_click)
		{
			m_frame++;
			if (m_frame >= m_cursorFrames.Length)
			{
				m_frame = 0;
				m_click = false;
			}
		}
		else
		{
			m_frame--;
		}
		m_cursor.sprite = m_cursorFrames[m_frame];
	}

	private void LateUpdate()
	{
		m_nextFrameLock = false;
	}
}
