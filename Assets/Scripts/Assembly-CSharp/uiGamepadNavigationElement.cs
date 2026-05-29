using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class uiGamepadNavigationElement : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, ISelectHandler, IDeselectHandler, ISubmitHandler, IPointerClickHandler
{
	public bool autoPressOnSelect;

	public bool denyAutoSelect;

	private Selectable selectable;

	private Button button;

	private uiSceneControllerInputHandler uiSceneControllerInputHandlerInstance;

	private bool pendingSelection;

	private bool pendingAutoPress;

	private bool interactibleThisFrame;

	public Selectable Selectable
	{
		get
		{
			if (selectable == null)
			{
				selectable = GetComponent<Selectable>();
				button = GetComponent<Button>();
			}
			return selectable;
		}
	}

	private void Awake()
	{
		uiSceneControllerInputHandlerInstance = Object.FindObjectOfType<uiSceneControllerInputHandler>();
	}

	private void OnEnable()
	{
		uiDebug.Log(base.gameObject, $"OnEnable (interactibleThisFrame={interactibleThisFrame}");
	}

	private void OnDisable()
	{
		uiDebug.Log(base.gameObject, $"OnDisable (interactibleThisFrame={interactibleThisFrame}");
		if (uiEventSystemExtension.enteredSelectable == selectable)
		{
			uiEventSystemExtension.enteredSelectable = null;
		}
	}

	private void Update()
	{
		if (pendingSelection)
		{
			EventSystem.current.SetSelectedGameObject(null);
			EventSystem.current.SetSelectedGameObject(Selectable.gameObject);
			pendingSelection = false;
		}
		interactibleThisFrame = Selectable != null && Selectable.IsInteractable();
	}

	private void LateUpdate()
	{
		if (pendingAutoPress)
		{
			if (button != null)
			{
				ExecuteEvents.Execute(button.gameObject, new BaseEventData(EventSystem.current), ExecuteEvents.submitHandler);
			}
			pendingAutoPress = false;
		}
	}

	public void Select()
	{
		if (Selectable == null)
		{
			Debug.LogError("No inputHandler instance!");
			return;
		}
		if (!Selectable.isActiveAndEnabled)
		{
			pendingSelection = true;
			return;
		}
		EventSystem.current.SetSelectedGameObject(null);
		EventSystem.current.SetSelectedGameObject(Selectable.gameObject);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		uiDebug.Log(base.gameObject, $"OnPointerEnter (interactibleThisFrame={interactibleThisFrame}");
		if (!(Selectable == null))
		{
			uiEventSystemExtension.enteredSelectable = Selectable;
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		uiDebug.Log(base.gameObject, $"OnPointerExit (interactibleThisFrame={interactibleThisFrame}");
		if (!(Selectable == null) && !(uiEventSystemExtension.enteredSelectable != Selectable) && (!(inputHandler.Instance != null) || inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard))
		{
			if (Selectable.gameObject == EventSystem.current.currentSelectedGameObject && !EventSystem.current.alreadySelecting)
			{
				EventSystem.current.SetSelectedGameObject(null);
			}
			uiEventSystemExtension.enteredSelectable = null;
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		uiDebug.Log(base.gameObject, $"OnSelect (interactibleThisFrame={interactibleThisFrame}");
		if (Selectable == null)
		{
			return;
		}
		if (uiSceneControllerInputHandlerInstance == null)
		{
			Debug.LogError("Missing uiSceneControllerInputHandler!");
			return;
		}
		uiSceneControllerInputHandlerInstance.OnSelectedUIElement(this);
		uiEventSystemExtension.enteredSelectable = Selectable;
		if (autoPressOnSelect)
		{
			pendingAutoPress = true;
		}
	}

	public void OnDeselect(BaseEventData eventData)
	{
		uiDebug.Log(base.gameObject, $"OnDeselect (interactibleThisFrame={interactibleThisFrame}");
		if (!(Selectable == null) && !(uiEventSystemExtension.enteredSelectable != Selectable))
		{
			if (Selectable.gameObject == EventSystem.current.currentSelectedGameObject && !EventSystem.current.alreadySelecting)
			{
				EventSystem.current.SetSelectedGameObject(null);
			}
			uiSceneControllerInputHandlerInstance.OnDeselectedUIElement(this);
			uiEventSystemExtension.enteredSelectable = null;
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		uiDebug.Log(base.gameObject, $"OnSubmit (interactibleThisFrame={interactibleThisFrame}");
		if (interactibleThisFrame)
		{
			inputHandler.OnUIElementPressed(this);
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			uiDebug.Log(base.gameObject, $"OnPointerClick (interactibleThisFrame={interactibleThisFrame}");
			if (interactibleThisFrame)
			{
				inputHandler.OnUIElementPressed(this);
			}
		}
	}
}
