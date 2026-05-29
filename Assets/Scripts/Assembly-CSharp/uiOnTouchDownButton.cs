using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class uiOnTouchDownButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	private Button button;

	private void Start()
	{
		button = GetComponent<Button>();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		uiDebug.Log(base.gameObject, "OnPointerDown");
		Trigger();
	}

	private void Trigger()
	{
		if (base.gameObject.activeInHierarchy && !(button == null) && inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
		{
			ExecuteEvents.Execute(button.gameObject, new BaseEventData(EventSystem.current), ExecuteEvents.submitHandler);
		}
	}
}
