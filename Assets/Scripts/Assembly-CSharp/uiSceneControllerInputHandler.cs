using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class uiSceneControllerInputHandler : MonoBehaviour
{
	private frontendUIScript m_uiFrontend;

	private gameUIScript m_uiGame;

	public List<GameObject> mouseUpForGamepadSimulationExclusionList;

	public uiGamepadNavigationElement currentGamepadSelectedUIElement;

	public uiGamepadNavigationElement prevGamepadSelectedUIElement;

	public bool canSimulateMouseUpForGamepad { get; private set; } = true;

	private void Start()
	{
		m_uiFrontend = Object.FindObjectOfType<frontendUIScript>();
		m_uiGame = Object.FindObjectOfType<gameUIScript>();
	}

	private void Update()
	{
		GameObject pointerEnter = inputHandler.CachedPointerEvenData.pointerEnter;
		canSimulateMouseUpForGamepad = !EventSystem.current.IsPointerOverGameObject() || !(pointerEnter != null) || !mouseUpForGamepadSimulationExclusionList.Contains(pointerEnter);
	}

	public void RefreshUISelection()
	{
		if (EventSystem.current.currentSelectedGameObject != null)
		{
			EventSystem.current.SetSelectedGameObject(null);
		}
		if (uiEventSystemExtension.enteredSelectable != null)
		{
			ExecuteEvents.Execute(uiEventSystemExtension.enteredSelectable.gameObject, new PointerEventData(EventSystem.current), ExecuteEvents.pointerExitHandler);
			uiEventSystemExtension.enteredSelectable = null;
		}
		uiGamepadNavigationGroup uiGamepadNavigationGroup2 = null;
		uiGamepadNavigationGroup[] array = Object.FindObjectsOfType<uiGamepadNavigationGroup>();
		foreach (uiGamepadNavigationGroup uiGamepadNavigationGroup3 in array)
		{
			if (uiGamepadNavigationGroup3.enabled && (uiGamepadNavigationGroup2 == null || uiGamepadNavigationGroup3.m_priority > uiGamepadNavigationGroup2.m_priority))
			{
				uiGamepadNavigationGroup2 = uiGamepadNavigationGroup3;
			}
		}
		if (!(uiGamepadNavigationGroup2 == null))
		{
			uiGamepadNavigationGroup2.Refresh();
		}
	}

	public void OnSelectedUIElement(uiGamepadNavigationElement element)
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad && prevGamepadSelectedUIElement != null && prevGamepadSelectedUIElement != element)
		{
			if (m_uiFrontend != null)
			{
				m_uiFrontend.MenuSelectionChange();
			}
			else if (m_uiGame != null)
			{
				m_uiGame.MenuSelectionChange();
			}
		}
		prevGamepadSelectedUIElement = currentGamepadSelectedUIElement;
		currentGamepadSelectedUIElement = element;
	}

	public void OnDeselectedUIElement(uiGamepadNavigationElement element)
	{
		prevGamepadSelectedUIElement = currentGamepadSelectedUIElement;
		currentGamepadSelectedUIElement = null;
	}

	public void SelectPreviousUIElement()
	{
		if (!(prevGamepadSelectedUIElement == null))
		{
			prevGamepadSelectedUIElement.Select();
		}
	}
}
