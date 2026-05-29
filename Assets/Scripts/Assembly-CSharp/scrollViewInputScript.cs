using UnityEngine;
using UnityEngine.UI;

public class scrollViewInputScript : MonoBehaviour
{
	public float m_autoScrollRate = 0.01f;

	public float m_autoScrollDelay = 5f;

	private float m_autoScrollCooldown;

	private float m_autoScrollCurrent;

	public float m_timeoutReturn = 4f;

	private float m_timeoutTimer;

	private ScrollRect m_scrollView;

	private bool m_valueChanged;

	private void Awake()
	{
		m_scrollView = GetComponent<ScrollRect>();
	}

	private void OnEnable()
	{
		m_autoScrollCooldown = m_autoScrollDelay * 0.5f;
		m_timeoutTimer = 0f;
		m_scrollView.verticalNormalizedPosition = 1f;
	}

	private void Update()
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad)
		{
			float num = inputHandler.GetAxis2DRaw(InputAction.Gameplay_CursorMove).y + inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove).y;
			if (Mathf.Abs(num) > 0.1f)
			{
				num *= Mathf.Abs(num);
				m_scrollView.verticalNormalizedPosition += num * 0.25f * Time.deltaTime;
				m_autoScrollCooldown = 0f;
				m_timeoutTimer = 0f;
			}
		}
		else
		{
			if (inputHandler.IsPointerDown())
			{
				m_autoScrollCooldown = 0f;
				m_timeoutTimer = 0f;
			}
			float y = inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove).y;
			if (Mathf.Abs(y) > 0.1f)
			{
				y *= Mathf.Abs(y);
				m_scrollView.verticalNormalizedPosition += y * 1.25f * Time.deltaTime;
				m_autoScrollCooldown = 0f;
				m_timeoutTimer = 0f;
			}
		}
		if (m_autoScrollCooldown < m_autoScrollDelay)
		{
			m_autoScrollCooldown = Mathf.MoveTowards(m_autoScrollCooldown, m_autoScrollDelay, Time.deltaTime);
			m_autoScrollCurrent = m_scrollView.verticalNormalizedPosition;
			return;
		}
		m_scrollView.verticalNormalizedPosition -= m_autoScrollRate * Time.deltaTime;
		if (m_scrollView.verticalNormalizedPosition <= 0f)
		{
			m_timeoutTimer += Time.deltaTime;
			if (m_timeoutTimer >= m_timeoutReturn)
			{
				GetComponentInParent<frontendUIScript>().ReturnFromCredits();
				m_autoScrollCooldown = 0f;
				m_timeoutTimer = 0f;
			}
		}
	}
}
