using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class uiItemDragHoldButtonInvoker : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[Range(0.01f, 5f)]
	public float m_holdDuration = 1f;

	private float m_holdTimer;

	private bool m_isOverUI;

	public bool m_repeatable = true;

	[Range(0.01f, 3f)]
	public float m_repeatDelay = 0.5f;

	private float m_repeatDelayTimer;

	public bool m_touchOnly = true;

	private Button m_button;

	private gameScript m_gameScript;

	private bool m_isItemHeld;

	private void Start()
	{
		m_button = GetComponent<Button>();
		m_gameScript = Object.FindObjectOfType<gameScript>();
	}

	private void Update()
	{
		if (m_gameScript == null)
		{
			return;
		}
		bool isItemHeld = m_gameScript.IsItemHeld;
		if (m_isItemHeld != isItemHeld)
		{
			m_isItemHeld = isItemHeld;
			if (!m_isItemHeld && m_isOverUI && m_holdTimer > 0f)
			{
				OnCancel();
			}
		}
		if (!m_isItemHeld || !m_isOverUI)
		{
			return;
		}
		if (m_repeatable && m_repeatDelayTimer > 0f)
		{
			m_repeatDelayTimer -= Time.deltaTime;
			if (m_repeatDelayTimer <= 0f)
			{
				OnBeginHold();
			}
		}
		else if (m_holdTimer > 0f)
		{
			m_holdTimer -= Time.deltaTime;
			if (m_holdTimer <= 0f)
			{
				OnFinishHold();
			}
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		m_isOverUI = true;
		if (m_isItemHeld && (!m_touchOnly || inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch))
		{
			OnBeginHold();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		m_isOverUI = false;
		if (m_isItemHeld && (m_holdTimer > 0f || m_repeatDelayTimer > 0f))
		{
			OnCancel();
		}
	}

	public void OnBeginHold()
	{
		m_holdTimer = m_holdDuration;
	}

	public void OnFinishHold()
	{
		ExecuteEvents.Execute(m_button.gameObject, new BaseEventData(EventSystem.current), ExecuteEvents.submitHandler);
		m_holdTimer = 0f;
		if (m_repeatable)
		{
			m_repeatDelayTimer = m_repeatDelay;
		}
	}

	public void OnCancel()
	{
		m_holdTimer = 0f;
		m_repeatDelayTimer = 0f;
	}
}
