using UnityEngine;
using UnityEngine.EventSystems;

public class uiStickerTabHover : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	private photoModeScript m_script;

	private bool m_checkForOutsideTouchDown;

	private void Start()
	{
		m_script = Object.FindObjectOfType<photoModeScript>();
	}

	private void Update()
	{
		if (m_checkForOutsideTouchDown)
		{
			if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch)
			{
				m_checkForOutsideTouchDown = false;
			}
			else if (inputHandler.IsPointerPressed())
			{
				m_checkForOutsideTouchDown = false;
				m_script.StickerTabHover(_enter: false);
			}
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		m_checkForOutsideTouchDown = false;
		m_script.StickerTabHover(_enter: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch && inputHandler.IsPointerReleased())
		{
			m_checkForOutsideTouchDown = true;
		}
		else
		{
			m_script.StickerTabHover(_enter: false);
		}
	}
}
