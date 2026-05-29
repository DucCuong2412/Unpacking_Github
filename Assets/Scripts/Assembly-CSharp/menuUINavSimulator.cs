using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class menuUINavSimulator : MonoBehaviour
{
	public UnityEvent m_onMoveLeft;

	public UnityEvent m_onMoveRight;

	public UnityEvent m_onMoveUp;

	public UnityEvent m_onMoveDown;

	private float m_prevActionTime;

	private int m_consecutiveMoveCount;

	private Vector2 m_lastMoveVector = Vector2.zero;

	private float m_repeatDelay = 1f;

	private float m_inputActionsPerSecond = 10f;

	private Vector2 m_lastAxis2d = Vector2.zero;

	private void Start()
	{
		StandaloneInputModule standaloneInputModule = Object.FindObjectOfType<StandaloneInputModule>();
		if (standaloneInputModule != null)
		{
			m_repeatDelay = standaloneInputModule.repeatDelay;
			m_inputActionsPerSecond = standaloneInputModule.inputActionsPerSecond;
		}
	}

	private void Update()
	{
		if (inputHandler.Instance == null)
		{
			return;
		}
		float unscaledTime = Time.unscaledTime;
		Vector2 vector = new Vector2(inputHandler.Instance.GetAxisRaw("Horizontal"), inputHandler.Instance.GetAxisRaw("Vertical"));
		if (Mathf.Approximately(vector.x, 0f) && Mathf.Approximately(vector.y, 0f))
		{
			m_consecutiveMoveCount = 0;
			m_lastAxis2d = vector;
			return;
		}
		bool flag = IsPressed(vector);
		bool flag2 = Vector2.Dot(vector, m_lastMoveVector) > 0f;
		if (!flag)
		{
			flag = ((!flag2 || m_consecutiveMoveCount != 1) ? (unscaledTime > m_prevActionTime + 1f / m_inputActionsPerSecond) : (unscaledTime > m_prevActionTime + m_repeatDelay));
		}
		if (!flag)
		{
			m_lastAxis2d = vector;
			return;
		}
		switch (DetermineMoveDirection(vector.x, vector.y, 0.6f))
		{
		case MoveDirection.Left:
			m_onMoveLeft?.Invoke();
			goto default;
		case MoveDirection.Up:
			m_onMoveUp?.Invoke();
			goto default;
		case MoveDirection.Right:
			m_onMoveRight?.Invoke();
			goto default;
		case MoveDirection.Down:
			m_onMoveDown?.Invoke();
			goto default;
		default:
			if (!flag2)
			{
				m_consecutiveMoveCount = 0;
			}
			m_consecutiveMoveCount++;
			m_prevActionTime = unscaledTime;
			m_lastMoveVector = vector;
			break;
		case MoveDirection.None:
			m_consecutiveMoveCount = 0;
			break;
		}
		m_lastAxis2d = vector;
	}

	private bool IsPressed(Vector2 axis2d)
	{
		if (!(Mathf.Abs(axis2d.x) >= 0.6f) || !(Mathf.Abs(m_lastAxis2d.x) < 0.6f))
		{
			if (Mathf.Abs(axis2d.y) >= 0.6f)
			{
				return Mathf.Abs(m_lastAxis2d.y) < 0.6f;
			}
			return false;
		}
		return true;
	}

	private static MoveDirection DetermineMoveDirection(float x, float y, float deadZone)
	{
		if (new Vector2(x, y).sqrMagnitude < deadZone * deadZone)
		{
			return MoveDirection.None;
		}
		if (Mathf.Abs(x) > Mathf.Abs(y))
		{
			if (x > 0f)
			{
				return MoveDirection.Right;
			}
			return MoveDirection.Left;
		}
		if (y > 0f)
		{
			return MoveDirection.Up;
		}
		return MoveDirection.Down;
	}
}
