using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class uiPressButton : MonoBehaviour
{
	private Button button;

	private void Start()
	{
		button = GetComponent<Button>();
	}

	public void Trigger()
	{
		if (base.gameObject.activeInHierarchy && !(button == null))
		{
			ExecuteEvents.Execute(button.gameObject, new BaseEventData(EventSystem.current), ExecuteEvents.submitHandler);
		}
	}
}
