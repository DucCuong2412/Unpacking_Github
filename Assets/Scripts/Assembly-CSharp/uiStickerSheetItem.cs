using UnityEngine;
using UnityEngine.EventSystems;

public class uiStickerSheetItem : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, ISelectHandler, IDeselectHandler, IPointerUpHandler
{
	private stickerSceneScript m_script;

	private int m_id;

	private int m_position;

	public void Register(stickerSceneScript _script, int _id)
	{
		m_script = _script;
		m_id = _id;
		Vector2 vector = GetComponent<RectTransform>().position * _script.GetComponent<RectTransform>().sizeDelta.x * 0.1f;
		Vector2 sizeDelta = GetComponent<RectTransform>().sizeDelta;
		m_position = Mathf.RoundToInt((vector + sizeDelta * 0.5f).x);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch)
		{
			m_script.ShowText(m_id, m_position);
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch)
		{
			m_script.HideText();
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch)
		{
			m_script.ShowText(m_id, m_position);
		}
	}

	public void OnDeselect(BaseEventData data)
	{
		m_script.HideText();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
		{
			m_script.ShowText(m_id, m_position);
		}
	}
}
