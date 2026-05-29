using UnityEngine;

public class rebindTestingScript : MonoBehaviour
{
	private void Start()
	{
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
	}

	private void OnControllerInputTypeChanged()
	{
		switch (inputHandler.CurrentControllerInputType)
		{
		case inputHandler.ControllerInputType.Keyboard:
			Cursor.lockState = CursorLockMode.None;
			break;
		case inputHandler.ControllerInputType.Gamepad:
			Cursor.lockState = CursorLockMode.Locked;
			break;
		case inputHandler.ControllerInputType.Unknown:
		case inputHandler.ControllerInputType.Touch:
			break;
		}
	}
}
