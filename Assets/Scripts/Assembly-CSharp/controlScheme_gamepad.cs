using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Runtime.Serialization.Formatters.Binary;
using Rewired;
using UnityEngine;

[CreateAssetMenu(fileName = "ControlScheme_Gamepad", menuName = "ScriptableObjects/controlScheme_gamepad", order = 11)]
public class controlScheme_gamepad : controlScheme
{
	[Serializable]
	public enum GamepadInput
	{
		None = 0,
		LeftStick = 1,
		RightStick = 2,
		ActionBottomRow1 = 3,
		ActionBottomRow2 = 4,
		ActionBottomRow3 = 5,
		ActionTopRow1 = 6,
		ActionTopRow2 = 7,
		ActionTopRow3 = 8,
		LeftShoulder1 = 9,
		LeftShoulder2 = 10,
		RightShoulder1 = 11,
		RightShoulder2 = 12,
		Center1 = 13,
		Center2 = 14,
		Center3 = 15,
		LeftStickButton = 16,
		RightStickButton = 17,
		DPadUp = 18,
		DPadRight = 19,
		DPadDown = 20,
		DPadLeft = 21,
		LeftStickUp = 22,
		LeftStickRight = 23,
		LeftStickDown = 24,
		LeftStickLeft = 25,
		RightStickUp = 26,
		RightStickRight = 27,
		RightStickDown = 28,
		RightStickLeft = 29,
		MAX = 30
	}

	[Serializable]
	public class InputInfo
	{
		[NonSerialized]
		public string m_name = "";

		public Sprite m_icon;

		public Sprite m_iconTutorial;
	}

	[Serializable]
	public class MappedInput
	{
		public GamepadInput p1;

		public GamepadInput p2;

		public GamepadInput s1;

		public GamepadInput s2;
	}

	[Serializable]
	public class DeviceProfile
	{
		public string m_name;

		public List<string> m_idTags = new List<string>();

		public List<InputInfo> m_inputManifest = new List<InputInfo>();

		[NonSerialized]
		public bool m_idTagsDropDown;

		[NonSerialized]
		public bool m_inputManifestDropDown;

		public DeviceProfile()
		{
			m_name = "New Device Profile";
			int count = m_inputManifest.Count;
			for (int i = 0; i < 30; i++)
			{
				if (i >= count)
				{
					m_inputManifest.Add(new InputInfo());
				}
			}
		}

		public DeviceProfile(DeviceProfile other)
		{
			m_name = other.m_name + " (Clone)";
			m_idTags.AddRange(other.m_idTags);
			m_inputManifest.AddRange(other.m_inputManifest);
		}

		public bool CompareWithIdTags(string deviceName)
		{
			foreach (string idTag in m_idTags)
			{
				if (deviceName.Contains(idTag))
				{
					return true;
				}
			}
			return false;
		}
	}

	public List<DeviceProfile> m_deviceProfiles = new List<DeviceProfile>();

	public string m_defaultFallbackName = "";

	[NonSerialized]
	private DeviceProfile m_defaultFallback;

	private DeviceProfile m_currentDeviceProfile;

	public List<SerializedBinding> m_defaultBindings = new List<SerializedBinding>();

	[NonSerialized]
	public Dictionary<InputAction, MappedInput> m_currentBindings = new Dictionary<InputAction, MappedInput>();

	[NonSerialized]
	private int[] m_gamepadInputActionIds;

	[NonSerialized]
	private int m_actionIdLeftStickX;

	[NonSerialized]
	private int m_actionIdLeftStickY;

	[NonSerialized]
	private int m_actionIdRightStickX;

	[NonSerialized]
	private int m_actionIdRightStickY;

	[NonSerialized]
	private bool[] m_curGamepadButtonState;

	[NonSerialized]
	private bool[] m_prevGamepadButtonState;

	private Vector2 m_leftJoystick;

	private Vector2 m_leftJoystickRaw;

	private Vector2 m_rightJoystick;

	private Vector2 m_rightJoystickRaw;

	[NonSerialized]
	private int m_currentActiveGamepadSlot;

	public bool m_startWithXInputOn;

	public bool m_allowXInputToggling;

	[NonSerialized]
	private bool m_menuAcceptLock;

	private Player Player => ReInput.players.GetPlayer(0);

	public int CurrentActiveGamepadSlot => m_currentActiveGamepadSlot;

	public static string BindingsFilePath => Application.persistentDataPath + "/bindings_gamepad.sav";

	public controlScheme_gamepad()
	{
		List<SerializedBinding> list = new List<SerializedBinding>();
		for (int i = 0; i < 48; i++)
		{
			InputAction inputAction = (InputAction)i;
			string inputActionStr = inputAction.ToString();
			SerializedBinding serializedBinding = list.Find((SerializedBinding binding) => binding.ia == inputActionStr);
			if (serializedBinding == null)
			{
				serializedBinding = new SerializedBinding
				{
					ia = inputActionStr
				};
			}
			list.Add(serializedBinding);
		}
		m_defaultBindings = list;
		m_gamepadInputActionIds = new int[30];
		m_curGamepadButtonState = new bool[30];
		m_prevGamepadButtonState = new bool[30];
	}

	public override void Init()
	{
		foreach (DeviceProfile deviceProfile in m_deviceProfiles)
		{
			List<InputInfo> list = new List<InputInfo>();
			for (int i = 0; i < 30; i++)
			{
				InputInfo inputInfo = null;
				if (deviceProfile.m_inputManifest.Count > 0 && i < deviceProfile.m_inputManifest.Count)
				{
					inputInfo = deviceProfile.m_inputManifest[i];
				}
				if (inputInfo == null)
				{
					inputInfo = new InputInfo();
				}
				InputInfo inputInfo2 = inputInfo;
				GamepadInput gamepadInput = (GamepadInput)i;
				inputInfo2.m_name = gamepadInput.ToString();
				list.Add(inputInfo);
			}
			deviceProfile.m_inputManifest = list;
			if (m_defaultFallbackName == deviceProfile.m_name)
			{
				m_defaultFallback = deviceProfile;
			}
		}
		if (m_defaultFallback == null)
		{
			Debug.LogErrorFormat("No default fallback device profile has been set! Unable to find '{0}' profile.", m_defaultFallbackName);
		}
		ReInput.ControllerConnectedEvent += OnControllerConnected;
		ReInput.ControllerDisconnectedEvent += OnControllerDisconnected;
		ReInput.ControllerPreDisconnectEvent += ControllerPreDisconnect;
		foreach (Controller controller in ReInput.controllers.Controllers)
		{
			if (controller.type != ControllerType.Keyboard && controller.type != ControllerType.Mouse)
			{
				OnControllerConnected(new ControllerStatusChangedEventArgs(controller.name, controller.id, controller.type));
			}
		}
		m_actionIdLeftStickX = ReInput.mapping.GetActionId("LeftStickX");
		m_actionIdLeftStickY = ReInput.mapping.GetActionId("LeftStickY");
		m_actionIdRightStickX = ReInput.mapping.GetActionId("RightStickX");
		m_actionIdRightStickY = ReInput.mapping.GetActionId("RightStickY");
		for (int j = 0; j < 30; j++)
		{
			int[] gamepadInputActionIds = m_gamepadInputActionIds;
			int num = j;
			ReInput.MappingHelper mapping = ReInput.mapping;
			GamepadInput gamepadInput = (GamepadInput)j;
			gamepadInputActionIds[num] = mapping.GetActionId(gamepadInput.ToString());
		}
		if (m_startWithXInputOn)
		{
			ReInput.configuration.useXInput = true;
		}
	}

	private void OnDestroy()
	{
		ReInput.ControllerConnectedEvent -= OnControllerConnected;
		ReInput.ControllerDisconnectedEvent -= OnControllerDisconnected;
		ReInput.ControllerPreDisconnectEvent -= ControllerPreDisconnect;
	}

	public override void OnActivate()
	{
		base.OnActivate();
		Load();
	}

	private void OnControllerConnected(ControllerStatusChangedEventArgs args)
	{
		Debug.LogFormat("OnControllerConnected: {0}, {1}, {2}, {3}", args.name, args.controllerId, args.controllerType, args.controller.hardwareTypeGuid);
	}

	private void OnControllerDisconnected(ControllerStatusChangedEventArgs args)
	{
		Debug.LogFormat("OnControllerDisconnected: {0}, {1}, {2}", args.name, args.controllerId, args.controllerType);
	}

	private void ControllerPreDisconnect(ControllerStatusChangedEventArgs args)
	{
		Debug.LogFormat("ControllerPreDisconnect: {0}, {1}, {2}", args.name, args.controllerId, args.controllerType);
	}

	public override void Load()
	{
		m_currentDeviceProfile = null;
		if (m_deviceName.Length > 0)
		{
			foreach (DeviceProfile deviceProfile in m_deviceProfiles)
			{
				if (deviceProfile.CompareWithIdTags(m_deviceName))
				{
					m_currentDeviceProfile = deviceProfile;
					break;
				}
			}
		}
		if (m_currentDeviceProfile == null)
		{
			if (m_defaultFallback == null)
			{
				Debug.LogErrorFormat("No default fallback device profile has been set! Unable to find '{0}' profile.", m_defaultFallbackName);
				return;
			}
			Debug.LogFormat("No Device Profile found with device name '{0}'. Using default device profile '{1}'.", m_deviceName, m_defaultFallbackName);
			m_currentDeviceProfile = m_defaultFallback;
		}
		for (int i = 0; i < 48; i++)
		{
			MappedInput mappedInput = new MappedInput();
			InputAction inputAction = (InputAction)i;
			string inputActionStr = inputAction.ToString();
			SerializedBinding serializedBinding = m_defaultBindings.Find((SerializedBinding binding) => binding.ia == inputActionStr);
			if (serializedBinding != null && !Enum.TryParse<GamepadInput>(serializedBinding.p1, out mappedInput.p1))
			{
				mappedInput.p1 = GamepadInput.None;
			}
			if (serializedBinding != null && !Enum.TryParse<GamepadInput>(serializedBinding.p2, out mappedInput.p2))
			{
				mappedInput.p2 = GamepadInput.None;
			}
			if (serializedBinding != null && !Enum.TryParse<GamepadInput>(serializedBinding.s1, out mappedInput.s1))
			{
				mappedInput.s1 = GamepadInput.None;
			}
			if (serializedBinding != null && !Enum.TryParse<GamepadInput>(serializedBinding.s2, out mappedInput.s2))
			{
				mappedInput.s2 = GamepadInput.None;
			}
			m_currentBindings[(InputAction)i] = mappedInput;
		}
		if (File.Exists(BindingsFilePath))
		{
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			FileStream fileStream = new FileStream(BindingsFilePath, FileMode.Open);
			GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Decompress);
			try
			{
				int? num = binaryFormatter.Deserialize(gZipStream) as int?;
				if (num.HasValue)
				{
					for (int num2 = 0; num2 < num; num2++)
					{
						string text = binaryFormatter.Deserialize(gZipStream) as string;
						List<SerializedBinding> list = binaryFormatter.Deserialize(gZipStream) as List<SerializedBinding>;
						bool flag = false;
						foreach (DeviceProfile deviceProfile2 in m_deviceProfiles)
						{
							if (!(deviceProfile2.m_name == text))
							{
								continue;
							}
							flag = true;
							for (int num3 = 0; num3 < 48; num3++)
							{
								MappedInput mappedInput2 = new MappedInput();
								InputAction inputAction = (InputAction)num3;
								string inputActionStr2 = inputAction.ToString();
								SerializedBinding serializedBinding2 = list.Find((SerializedBinding binding) => binding.ia == inputActionStr2);
								if (serializedBinding2 != null && !Enum.TryParse<GamepadInput>(serializedBinding2.p1, out mappedInput2.p1))
								{
									mappedInput2.p1 = GamepadInput.None;
								}
								if (serializedBinding2 != null && !Enum.TryParse<GamepadInput>(serializedBinding2.p2, out mappedInput2.p2))
								{
									mappedInput2.p2 = GamepadInput.None;
								}
								if (serializedBinding2 != null && !Enum.TryParse<GamepadInput>(serializedBinding2.s1, out mappedInput2.s1))
								{
									mappedInput2.s1 = GamepadInput.None;
								}
								if (serializedBinding2 != null && !Enum.TryParse<GamepadInput>(serializedBinding2.s2, out mappedInput2.s2))
								{
									mappedInput2.s2 = GamepadInput.None;
								}
								m_currentBindings[(InputAction)num3] = mappedInput2;
							}
							break;
						}
						if (!flag)
						{
							Debug.LogWarningFormat("Could not find DeviceProfile '{0}'", text);
						}
					}
				}
				gZipStream.Close();
				fileStream.Close();
				Debug.Log(BindingsFilePath + " loaded successfully");
			}
			catch (Exception ex)
			{
				gZipStream.Close();
				fileStream.Close();
				Debug.LogError("Load : " + ex.Message);
			}
		}
		RefreshAnalogSticks();
	}

	public override void Save()
	{
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		FileStream fileStream = new FileStream(BindingsFilePath, FileMode.Create);
		GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Compress);
		try
		{
			binaryFormatter.Serialize(gZipStream, m_deviceProfiles.Count);
			foreach (DeviceProfile deviceProfile in m_deviceProfiles)
			{
				List<SerializedBinding> list = new List<SerializedBinding>();
				foreach (KeyValuePair<InputAction, MappedInput> currentBinding in m_currentBindings)
				{
					SerializedBinding serializedBinding = new SerializedBinding();
					serializedBinding.ia = currentBinding.Key.ToString();
					serializedBinding.p1 = currentBinding.Value.p1.ToString();
					serializedBinding.p2 = currentBinding.Value.p2.ToString();
					serializedBinding.s1 = currentBinding.Value.s1.ToString();
					serializedBinding.s2 = currentBinding.Value.s2.ToString();
					list.Add(serializedBinding);
				}
				binaryFormatter.Serialize(gZipStream, deviceProfile.m_name);
				binaryFormatter.Serialize(gZipStream, list);
			}
			gZipStream.Close();
			fileStream.Close();
			Debug.Log(BindingsFilePath + " saved successfully");
		}
		catch (Exception ex)
		{
			fileStream.Close();
			Debug.LogError(BindingsFilePath + "Exception: " + ex.Message);
		}
	}

	public override void RevertToDefault()
	{
		if (File.Exists(BindingsFilePath))
		{
			File.Delete(BindingsFilePath);
		}
		Load();
	}

	public override void BeginRebind(InputAction inputAction, int layoutSlot, InputAction[] conflictResolutionList)
	{
		base.BeginRebind(inputAction, layoutSlot, conflictResolutionList);
		m_menuAcceptLock = true;
	}

	public override void UpdateRebind()
	{
		base.UpdateRebind();
		GamepadInput gamepadInput = GamepadInput.None;
		for (GamepadInput gamepadInput2 = GamepadInput.ActionBottomRow1; gamepadInput2 <= GamepadInput.DPadLeft; gamepadInput2++)
		{
			if (IsGamepadButtonReleased(gamepadInput2))
			{
				gamepadInput = gamepadInput2;
				inputHandler.OnInputRebindCaptured.Invoke();
				break;
			}
		}
		if (gamepadInput == GamepadInput.None)
		{
			return;
		}
		MappedInput value = null;
		if (!m_currentBindings.TryGetValue(m_rebindInputAction, out value))
		{
			value = new MappedInput();
		}
		if (m_conflictResolutionList != null)
		{
			InputAction[] conflictResolutionList = m_conflictResolutionList;
			foreach (InputAction key in conflictResolutionList)
			{
				MappedInput value2 = null;
				if (m_currentBindings.TryGetValue(key, out value2))
				{
					if (m_rebindLayoutSlot == 0 && value2.p1 == gamepadInput)
					{
						m_currentBindings[key].p1 = value.p1;
					}
					else if (m_rebindLayoutSlot == 1 && value2.s1 == gamepadInput)
					{
						m_currentBindings[key].s1 = value.s1;
					}
				}
			}
		}
		if (m_rebindLayoutSlot == 0)
		{
			value.p1 = gamepadInput;
		}
		else if (m_rebindLayoutSlot == 1)
		{
			value.s1 = gamepadInput;
		}
		m_currentBindings[m_rebindInputAction] = value;
		RefreshSecretShoulderAndTriggerBindings();
		m_rebindLayoutSlot = -1;
		Save();
		inputHandler.Instance.EndRebind();
	}

	private bool HasGameplayBinding(GamepadInput input)
	{
		foreach (KeyValuePair<InputAction, MappedInput> currentBinding in m_currentBindings)
		{
			if (currentBinding.Key >= InputAction.Gameplay_CursorMove && currentBinding.Key <= InputAction.Gameplay_ChangeZoneRight && currentBinding.Value.p1 == input)
			{
				return true;
			}
		}
		return false;
	}

	private void RefreshSecretShoulderAndTriggerBindings()
	{
		if (m_currentBindings.TryGetValue(InputAction.Gameplay_ChangeZoneLeft, out var value))
		{
			if (value.p1 == GamepadInput.LeftShoulder1)
			{
				value.s1 = ((!HasGameplayBinding(GamepadInput.LeftShoulder2)) ? GamepadInput.LeftShoulder2 : GamepadInput.None);
			}
			else if (value.p1 == GamepadInput.RightShoulder1)
			{
				value.s1 = ((!HasGameplayBinding(GamepadInput.RightShoulder2)) ? GamepadInput.RightShoulder2 : GamepadInput.None);
			}
			else
			{
				value.s1 = GamepadInput.None;
			}
			m_currentBindings[InputAction.Gameplay_ChangeZoneLeft] = value;
		}
		if (m_currentBindings.TryGetValue(InputAction.Gameplay_ChangeZoneRight, out var value2))
		{
			if (value2.p1 == GamepadInput.LeftShoulder1)
			{
				value2.s1 = ((!HasGameplayBinding(GamepadInput.LeftShoulder2)) ? GamepadInput.LeftShoulder2 : GamepadInput.None);
			}
			else if (value2.p1 == GamepadInput.RightShoulder1)
			{
				value2.s1 = ((!HasGameplayBinding(GamepadInput.RightShoulder2)) ? GamepadInput.RightShoulder2 : GamepadInput.None);
			}
			else
			{
				value2.s1 = GamepadInput.None;
			}
			m_currentBindings[InputAction.Gameplay_ChangeZoneRight] = value2;
		}
	}

	public override void RefreshAnalogSticks()
	{
		bool areAnalogSticksReversed = inputHandler.AreAnalogSticksReversed;
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(InputAction.Menu_Navigate, out value))
		{
			m_currentBindings[InputAction.Menu_Navigate].p1 = ((!areAnalogSticksReversed) ? GamepadInput.LeftStick : GamepadInput.RightStick);
		}
		if (m_currentBindings.TryGetValue(InputAction.Gameplay_CursorMove, out value))
		{
			m_currentBindings[InputAction.Gameplay_CursorMove].p1 = ((!areAnalogSticksReversed) ? GamepadInput.LeftStick : GamepadInput.RightStick);
		}
		if (m_currentBindings.TryGetValue(InputAction.Gameplay_ScreenPanMove, out value))
		{
			m_currentBindings[InputAction.Gameplay_ScreenPanMove].p1 = (areAnalogSticksReversed ? GamepadInput.LeftStick : GamepadInput.RightStick);
		}
		if (m_currentBindings.TryGetValue(InputAction.Floorplan_Up, out value))
		{
			m_currentBindings[InputAction.Floorplan_Up].p1 = (areAnalogSticksReversed ? GamepadInput.LeftStickUp : GamepadInput.RightStickUp);
		}
		if (m_currentBindings.TryGetValue(InputAction.Floorplan_Down, out value))
		{
			m_currentBindings[InputAction.Floorplan_Down].p1 = (areAnalogSticksReversed ? GamepadInput.LeftStickDown : GamepadInput.RightStickDown);
		}
	}

	public override void Update()
	{
		if (m_menuAcceptLock && !IsInputActionDown(InputAction.Menu_Accept))
		{
			m_menuAcceptLock = false;
		}
	}

	public override void Poll()
	{
		if (!ReInput.isReady)
		{
			return;
		}
		Controller lastActiveController = Player.controllers.GetLastActiveController();
		if (lastActiveController == null)
		{
			return;
		}
		Array.Copy(m_curGamepadButtonState, m_prevGamepadButtonState, m_prevGamepadButtonState.Length);
		m_leftJoystick = Player.GetAxis2D(m_actionIdLeftStickX, m_actionIdLeftStickY);
		m_leftJoystickRaw = Player.GetAxis2DRaw(m_actionIdLeftStickX, m_actionIdLeftStickY);
		m_rightJoystick = Player.GetAxis2D(m_actionIdRightStickX, m_actionIdRightStickY);
		m_rightJoystickRaw = Player.GetAxis2DRaw(m_actionIdRightStickX, m_actionIdRightStickY);
		for (GamepadInput gamepadInput = GamepadInput.LeftStick; gamepadInput < GamepadInput.MAX; gamepadInput++)
		{
			int num = (int)gamepadInput;
			switch (gamepadInput)
			{
			case GamepadInput.LeftStick:
				m_curGamepadButtonState[num] = m_leftJoystickRaw.sqrMagnitude != 0f;
				break;
			case GamepadInput.RightStick:
				m_curGamepadButtonState[num] = m_rightJoystickRaw.sqrMagnitude != 0f;
				break;
			case GamepadInput.LeftStickUp:
				m_curGamepadButtonState[num] = m_leftJoystick.y > 0f;
				break;
			case GamepadInput.LeftStickRight:
				m_curGamepadButtonState[num] = m_leftJoystick.x > 0f;
				break;
			case GamepadInput.LeftStickDown:
				m_curGamepadButtonState[num] = m_leftJoystick.y < 0f;
				break;
			case GamepadInput.LeftStickLeft:
				m_curGamepadButtonState[num] = m_leftJoystick.x < 0f;
				break;
			case GamepadInput.RightStickUp:
				m_curGamepadButtonState[num] = m_rightJoystick.y > 0f;
				break;
			case GamepadInput.RightStickRight:
				m_curGamepadButtonState[num] = m_rightJoystick.x > 0f;
				break;
			case GamepadInput.RightStickDown:
				m_curGamepadButtonState[num] = m_rightJoystick.y < 0f;
				break;
			case GamepadInput.RightStickLeft:
				m_curGamepadButtonState[num] = m_rightJoystick.x < 0f;
				break;
			default:
				m_curGamepadButtonState[num] = Player.GetButton(m_gamepadInputActionIds[num]);
				break;
			}
		}
		if (m_currentActiveGamepadSlot == lastActiveController.id + 1)
		{
			return;
		}
		m_currentActiveGamepadSlot = lastActiveController.id + 1;
		vibrationScript.SetJoystick((Joystick)lastActiveController);
		if (m_allowXInputToggling && m_startWithXInputOn)
		{
			ReInput.configuration.useXInput = false;
			lastActiveController = null;
			foreach (Controller controller in Player.controllers.Controllers)
			{
				if (controller.type == ControllerType.Joystick && controller.id == m_currentActiveGamepadSlot - 1)
				{
					lastActiveController = controller;
					break;
				}
			}
			m_deviceName = ((lastActiveController != null) ? lastActiveController.name : "<Unknown>");
			ReInput.configuration.useXInput = true;
		}
		else
		{
			m_deviceName = lastActiveController.name;
		}
	}

	private bool IsGamepadButtonDown(GamepadInput gamepadInput)
	{
		if (gamepadInput == GamepadInput.None || CurrentActiveGamepadSlot <= 0)
		{
			return false;
		}
		return m_curGamepadButtonState[(int)gamepadInput];
	}

	public override bool IsInputActionDown(InputAction inputAction)
	{
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != GamepadInput.None && IsGamepadButtonDown(value.p1) && (value.p2 == GamepadInput.None || IsGamepadButtonDown(value.p2)))
			{
				return true;
			}
			if (value.s1 != GamepadInput.None && IsGamepadButtonDown(value.s1) && (value.s2 == GamepadInput.None || IsGamepadButtonDown(value.s2)))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsGamepadButtonPressed(GamepadInput gamepadInput)
	{
		if (gamepadInput == GamepadInput.None || CurrentActiveGamepadSlot <= 0)
		{
			return false;
		}
		if (m_curGamepadButtonState[(int)gamepadInput])
		{
			return !m_prevGamepadButtonState[(int)gamepadInput];
		}
		return false;
	}

	private bool IsGamepadButtonReleased(GamepadInput gamepadInput)
	{
		if (gamepadInput == GamepadInput.None || CurrentActiveGamepadSlot <= 0)
		{
			return false;
		}
		if (!m_curGamepadButtonState[(int)gamepadInput])
		{
			return m_prevGamepadButtonState[(int)gamepadInput];
		}
		return false;
	}

	public override bool IsInputActionPressed(InputAction inputAction)
	{
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != GamepadInput.None)
			{
				if (value.p2 == GamepadInput.None)
				{
					if (IsGamepadButtonPressed(value.p1))
					{
						return true;
					}
				}
				else if ((IsGamepadButtonPressed(value.p1) && IsGamepadButtonDown(value.p2)) || (IsGamepadButtonDown(value.p1) && IsGamepadButtonPressed(value.p2)))
				{
					return true;
				}
			}
			if (value.s1 != GamepadInput.None)
			{
				if (value.s2 == GamepadInput.None)
				{
					if (IsGamepadButtonPressed(value.s1))
					{
						return true;
					}
				}
				else if ((IsGamepadButtonPressed(value.s1) && IsGamepadButtonDown(value.s2)) || (IsGamepadButtonDown(value.s1) && IsGamepadButtonPressed(value.s2)))
				{
					return true;
				}
			}
		}
		return false;
	}

	public override bool IsInputActionReleased(InputAction inputAction)
	{
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != GamepadInput.None)
			{
				if (value.p2 == GamepadInput.None)
				{
					if (IsGamepadButtonReleased(value.p1))
					{
						return true;
					}
				}
				else if ((IsGamepadButtonReleased(value.p1) && IsGamepadButtonDown(value.p2)) || (IsGamepadButtonDown(value.p1) && IsGamepadButtonReleased(value.p2)))
				{
					return true;
				}
			}
			if (value.s1 != GamepadInput.None)
			{
				if (value.s2 == GamepadInput.None)
				{
					if (IsGamepadButtonReleased(value.s1))
					{
						return true;
					}
				}
				else if ((IsGamepadButtonReleased(value.s1) && IsGamepadButtonDown(value.s2)) || (IsGamepadButtonDown(value.s1) && IsGamepadButtonReleased(value.s2)))
				{
					return true;
				}
			}
		}
		return false;
	}

	private Vector2 GetGamepadAxis2D(GamepadInput gamepadInput)
	{
		if (CurrentActiveGamepadSlot <= 0)
		{
			return Vector2.zero;
		}
		switch (gamepadInput)
		{
		case GamepadInput.LeftStick:
			return m_leftJoystick;
		case GamepadInput.RightStick:
			return m_rightJoystick;
		default:
			return Vector2.zero;
		}
	}

	public override Vector2 GetAxis2D(InputAction inputAction)
	{
		Vector2 vector = Vector2.zero;
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			vector = GetGamepadAxis2D(value.p1);
			if (vector == Vector2.zero)
			{
				vector = GetGamepadAxis2D(value.s1);
			}
		}
		return vector;
	}

	private Vector2 GetGamepadAxis2DRaw(GamepadInput gamepadInput)
	{
		if (CurrentActiveGamepadSlot <= 0)
		{
			return Vector2.zero;
		}
		switch (gamepadInput)
		{
		case GamepadInput.LeftStick:
			return m_leftJoystickRaw;
		case GamepadInput.RightStick:
			return m_rightJoystickRaw;
		default:
			return Vector2.zero;
		}
	}

	public override Vector2 GetAxis2DRaw(InputAction inputAction)
	{
		Vector2 vector = Vector2.zero;
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			vector = GetGamepadAxis2DRaw(value.p1);
			if (vector == Vector2.zero)
			{
				vector = GetGamepadAxis2DRaw(value.s1);
			}
		}
		return vector;
	}

	public override float GetHorizontalAxis()
	{
		return Mathf.Clamp(GetAxis2D(InputAction.Menu_Navigate).x + (IsInputActionDown(InputAction.Menu_NavigateLeft) ? (-1f) : 0f) + (IsInputActionDown(InputAction.Menu_NavigateRight) ? 1f : 0f), -1f, 1f);
	}

	public override float GetVerticalAxis()
	{
		return Mathf.Clamp(GetAxis2D(InputAction.Menu_Navigate).y + (IsInputActionDown(InputAction.Menu_NavigateUp) ? 1f : 0f) + (IsInputActionDown(InputAction.Menu_NavigateDown) ? (-1f) : 0f), -1f, 1f);
	}

	public override bool IsSubmitButtonPressed()
	{
		if (m_menuAcceptLock)
		{
			return false;
		}
		return IsInputActionPressed(InputAction.Menu_Accept);
	}

	public override bool IsCancelButtonPressed()
	{
		return IsInputActionPressed(InputAction.Menu_Back);
	}

	public override bool AnyKeyOrButtonDown()
	{
		for (GamepadInput gamepadInput = GamepadInput.ActionBottomRow1; gamepadInput < GamepadInput.LeftStickUp; gamepadInput++)
		{
			if (m_curGamepadButtonState[(int)gamepadInput])
			{
				return true;
			}
		}
		return false;
	}

	public override bool AnyKeyOrButtonPressed()
	{
		for (GamepadInput gamepadInput = GamepadInput.ActionBottomRow1; gamepadInput < GamepadInput.LeftStickUp; gamepadInput++)
		{
			if (m_curGamepadButtonState[(int)gamepadInput] && !m_prevGamepadButtonState[(int)gamepadInput])
			{
				return true;
			}
		}
		return false;
	}

	public override bool AnyAxisMoved()
	{
		if (m_leftJoystick.sqrMagnitude != 0f || m_rightJoystick.sqrMagnitude != 0f)
		{
			return true;
		}
		return false;
	}

	public override Sprite[] GetIcons(InputAction inputAction, int layoutSlot, bool tutorial = false)
	{
		if (m_currentDeviceProfile == null || m_currentBindings.Count == 0)
		{
			Load();
			if (m_currentDeviceProfile == null || m_currentBindings.Count == 0)
			{
				Debug.LogWarning("No current device or fallback profile.");
				return null;
			}
		}
		Sprite[] array = null;
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			switch (layoutSlot)
			{
			case 0:
			{
				if (value.p2 != GamepadInput.None)
				{
					array = new Sprite[2];
					int p = (int)value.p2;
					if (m_currentDeviceProfile.m_inputManifest.Count > 0 && p < m_currentDeviceProfile.m_inputManifest.Count)
					{
						array[1] = m_currentDeviceProfile.m_inputManifest[p].m_icon;
					}
				}
				else
				{
					array = new Sprite[1];
				}
				int p2 = (int)value.p1;
				if (m_currentDeviceProfile.m_inputManifest.Count > 0 && p2 < m_currentDeviceProfile.m_inputManifest.Count)
				{
					array[0] = (tutorial ? m_currentDeviceProfile.m_inputManifest[p2].m_iconTutorial : m_currentDeviceProfile.m_inputManifest[p2].m_icon);
				}
				break;
			}
			case 1:
			{
				if (value.s2 != GamepadInput.None)
				{
					array = new Sprite[2];
					int s = (int)value.s2;
					if (m_currentDeviceProfile.m_inputManifest.Count > 0 && s < m_currentDeviceProfile.m_inputManifest.Count)
					{
						array[1] = m_currentDeviceProfile.m_inputManifest[s].m_icon;
					}
				}
				else
				{
					array = new Sprite[1];
				}
				int s2 = (int)value.s1;
				if (m_currentDeviceProfile.m_inputManifest.Count > 0 && s2 < m_currentDeviceProfile.m_inputManifest.Count)
				{
					array[0] = m_currentDeviceProfile.m_inputManifest[s2].m_icon;
				}
				break;
			}
			}
		}
		return array;
	}

	public override string GetBindingString(InputAction inputAction, int layoutSlot)
	{
		if (m_currentDeviceProfile == null || m_currentBindings.Count == 0)
		{
			Load();
			if (m_currentDeviceProfile == null || m_currentBindings.Count == 0)
			{
				Debug.LogWarning("No current device or fallback profile.");
				return "";
			}
		}
		string text = "";
		MappedInput value = null;
		if (m_currentBindings.TryGetValue(inputAction, out value))
		{
			switch (layoutSlot)
			{
			case 0:
				text += value.p1;
				if (value.p2 != GamepadInput.None)
				{
					text = text + " + " + value.p2;
				}
				break;
			case 1:
				text += value.s1;
				if (value.s2 != GamepadInput.None)
				{
					text = text + " + " + value.s2;
				}
				break;
			}
		}
		return text;
	}

	public override void SendVibration(int motorIndex, float motorLevel, float duration)
	{
		if (ReInput.isReady)
		{
			Player.SetVibration(motorIndex, motorLevel, duration);
		}
	}
}
