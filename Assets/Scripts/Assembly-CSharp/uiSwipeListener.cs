using UnityEngine;
using UnityEngine.Events;

public class uiSwipeListener : MonoBehaviour
{
	private enum Phase
	{
		Ready = 0,
		Swiping = 1,
		Completed = 2,
		Cancelled = 3
	}

	[Range(0.01f, 0.5f)]
	public float m_radius = 0.1f;

	[Range(0f, 45f)]
	public float m_angleVariance = 10f;

	[Range(0f, 3f)]
	public float m_cancelDuration = 0.5f;

	private float m_cancelTimer;

	public UnityEvent m_onSwipeUp;

	public UnityEvent m_onSwipeDown;

	public UnityEvent m_onSwipeLeft;

	public UnityEvent m_onSwipeRight;

	private Phase m_phase;

	private Vector2 m_swipeBegin;

	private Vector2 m_swipeEnd;

	private RectTransform m_rectTransform;

	private Canvas m_parentCanvas;

	private void Awake()
	{
		m_rectTransform = GetComponent<RectTransform>();
		m_parentCanvas = GetComponentInParent<Canvas>();
	}

	private void OnEnable()
	{
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
	}

	private void OnDisable()
	{
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
	}

	private void OnControllerInputTypeChanged()
	{
		if (m_phase != Phase.Ready)
		{
			m_phase = Phase.Cancelled;
		}
	}

	private void Update()
	{
		if (m_rectTransform == null)
		{
			return;
		}
		int touchCount = GetTouchCount();
		switch (m_phase)
		{
		case Phase.Ready:
			if (touchCount == 1)
			{
				Vector2 touchPos = GetTouchPos();
				Camera cam = ((m_parentCanvas != null) ? m_parentCanvas.worldCamera : null);
				if (RectTransformUtility.RectangleContainsScreenPoint(m_rectTransform, touchPos, cam))
				{
					m_swipeBegin = (m_swipeEnd = touchPos);
					m_phase = Phase.Swiping;
				}
				else
				{
					m_phase = Phase.Cancelled;
				}
				m_cancelTimer = m_cancelDuration;
			}
			else if (touchCount > 1)
			{
				m_phase = Phase.Cancelled;
			}
			break;
		case Phase.Swiping:
			if ((m_swipeBegin - m_swipeEnd).magnitude >= m_radius * (float)Screen.width)
			{
				OnSwipe(m_swipeBegin, m_swipeEnd);
				m_phase = Phase.Completed;
			}
			else if (touchCount != 1)
			{
				m_phase = Phase.Cancelled;
			}
			else
			{
				m_swipeEnd = GetTouchPos();
			}
			if (m_cancelDuration > 0f)
			{
				m_cancelTimer -= Time.deltaTime;
				if (m_cancelTimer <= 0f)
				{
					m_phase = Phase.Cancelled;
				}
			}
			break;
		case Phase.Completed:
		case Phase.Cancelled:
			if (touchCount != 1)
			{
				m_phase = Phase.Ready;
			}
			break;
		}
	}

	private void OnSwipe(Vector3 start, Vector3 end)
	{
		Vector3 vector = end - start;
		float num = Vector3.Angle(vector.normalized, Vector3.up);
		if (vector.x < 0f)
		{
			num = 360f - num;
		}
		if (num >= 90f - m_angleVariance && num < 90f + m_angleVariance)
		{
			m_onSwipeRight?.Invoke();
		}
		else if (num >= 18f - m_angleVariance && num < 18f + m_angleVariance)
		{
			m_onSwipeDown?.Invoke();
		}
		else if (num >= 270f - m_angleVariance && num < 270f + m_angleVariance)
		{
			m_onSwipeLeft?.Invoke();
		}
		else if (num >= 360f - m_angleVariance || num < m_angleVariance)
		{
			m_onSwipeUp?.Invoke();
		}
	}

	private int GetTouchCount()
	{
		return inputHandler.TouchCount;
	}

	private Vector2 GetTouchPos()
	{
		if (inputHandler.TouchCount <= 0)
		{
			return Vector2.zero;
		}
		return inputHandler.Touches[0].position;
	}
}
