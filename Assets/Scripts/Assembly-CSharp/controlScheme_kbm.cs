using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;

[CreateAssetMenu(fileName = "ControlScheme_KBM", menuName = "ScriptableObjects/controlScheme_kbm", order = 10)]
public class controlScheme_kbm : controlScheme
{
	public class MappedInput
	{
		public KeyCode p1;

		public KeyCode p2;

		public KeyCode s1;

		public KeyCode s2;
	}

	[Serializable]
	public class KeyNamePair
	{
		public string key;

		public string name;
	}

	public List<SerializedBinding> defaultBindings = new List<SerializedBinding>();

	[NonSerialized]
	public Dictionary<InputAction, MappedInput> currentBindings = new Dictionary<InputAction, MappedInput>();

	private Vector2 m_mouse;

	private Vector2 m_mouseRaw;

	private Vector2 m_mouseScroll;

	private Vector2 m_screenPan;

	[Range(0.01f, 1f)]
	public float panSpeed = 0.2f;

	public List<KeyNamePair> m_keyNamePairs = new List<KeyNamePair>();

	private Dictionary<KeyCode, string> m_keyDisplayNames = new Dictionary<KeyCode, string>();

	public static string BindingsFilePath => Application.persistentDataPath + "/bindings_kbm.sav";

	public override void Init()
	{
		m_deviceName = "KBM";
		foreach (KeyNamePair keyNamePair in m_keyNamePairs)
		{
			KeyCode result = KeyCode.None;
			if (Enum.TryParse<KeyCode>(keyNamePair.key, out result))
			{
				m_keyDisplayNames[result] = keyNamePair.name;
			}
		}
	}

	public override void OnActivate()
	{
		base.OnActivate();
		Load();
	}

	public override void Load()
	{
		currentBindings.Clear();
		for (int i = 0; i < 48; i++)
		{
			MappedInput mappedInput = new MappedInput();
			InputAction inputAction = (InputAction)i;
			string inputActionStr = inputAction.ToString();
			SerializedBinding serializedBinding = defaultBindings.Find((SerializedBinding binding) => binding.ia == inputActionStr);
			if (serializedBinding != null && !Enum.TryParse<KeyCode>(serializedBinding.p1, out mappedInput.p1))
			{
				mappedInput.p1 = KeyCode.None;
			}
			if (serializedBinding != null && !Enum.TryParse<KeyCode>(serializedBinding.p2, out mappedInput.p2))
			{
				mappedInput.p2 = KeyCode.None;
			}
			if (serializedBinding != null && !Enum.TryParse<KeyCode>(serializedBinding.s1, out mappedInput.s1))
			{
				mappedInput.s1 = KeyCode.None;
			}
			if (serializedBinding != null && !Enum.TryParse<KeyCode>(serializedBinding.s2, out mappedInput.s2))
			{
				mappedInput.s2 = KeyCode.None;
			}
			currentBindings[(InputAction)i] = mappedInput;
		}
		if (File.Exists(BindingsFilePath))
		{
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			FileStream fileStream = new FileStream(BindingsFilePath, FileMode.Open);
			GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Decompress);
			try
			{
				List<SerializedBinding> list = binaryFormatter.Deserialize(gZipStream) as List<SerializedBinding>;
				gZipStream.Close();
				fileStream.Close();
				for (int num = 0; num < 48; num++)
				{
					MappedInput mappedInput2 = new MappedInput();
					InputAction inputAction = (InputAction)num;
					string inputActionStr2 = inputAction.ToString();
					SerializedBinding serializedBinding2 = list.Find((SerializedBinding binding) => binding.ia == inputActionStr2);
					if (serializedBinding2 != null && !Enum.TryParse<KeyCode>(serializedBinding2.p1, out mappedInput2.p1))
					{
						mappedInput2.p1 = KeyCode.None;
					}
					if (serializedBinding2 != null && !Enum.TryParse<KeyCode>(serializedBinding2.p2, out mappedInput2.p2))
					{
						mappedInput2.p2 = KeyCode.None;
					}
					if (serializedBinding2 != null && !Enum.TryParse<KeyCode>(serializedBinding2.s1, out mappedInput2.s1))
					{
						mappedInput2.s1 = KeyCode.None;
					}
					if (serializedBinding2 != null && !Enum.TryParse<KeyCode>(serializedBinding2.s2, out mappedInput2.s2))
					{
						mappedInput2.s2 = KeyCode.None;
					}
					currentBindings[(InputAction)num] = mappedInput2;
				}
				Debug.Log(BindingsFilePath + " loaded successfully");
			}
			catch (Exception ex)
			{
				gZipStream.Close();
				fileStream.Close();
				Debug.LogError("Load : " + ex.Message);
			}
		}
		if (currentBindings[InputAction.Gameplay_LiftAndPlace].p1 == currentBindings[InputAction.Menu_Back].p1)
		{
			RevertToDefault();
		}
	}

	public override void Save()
	{
		List<SerializedBinding> list = new List<SerializedBinding>();
		foreach (KeyValuePair<InputAction, MappedInput> currentBinding in currentBindings)
		{
			SerializedBinding serializedBinding = new SerializedBinding();
			serializedBinding.ia = currentBinding.Key.ToString();
			serializedBinding.p1 = currentBinding.Value.p1.ToString();
			serializedBinding.p2 = currentBinding.Value.p2.ToString();
			serializedBinding.s1 = currentBinding.Value.s1.ToString();
			serializedBinding.s2 = currentBinding.Value.s2.ToString();
			list.Add(serializedBinding);
		}
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		FileStream fileStream = new FileStream(BindingsFilePath, FileMode.Create);
		GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Compress);
		try
		{
			binaryFormatter.Serialize(gZipStream, list);
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

	public override void Poll()
	{
		m_mouse.x = Input.GetAxis("Mouse X");
		m_mouse.y = Input.GetAxis("Mouse Y");
		m_mouseRaw.x = Input.GetAxisRaw("Mouse X");
		m_mouseRaw.y = Input.GetAxisRaw("Mouse Y");
	}

	public override void Update()
	{
		m_screenPan.x = (IsInputActionDown(InputAction.Gameplay_SPMove_Left) ? (0f - panSpeed) : 0f) + (IsInputActionDown(InputAction.Gameplay_SPMove_Right) ? panSpeed : 0f);
		m_screenPan.y = (IsInputActionDown(InputAction.Gameplay_SPMove_Down) ? (0f - panSpeed) : 0f) + (IsInputActionDown(InputAction.Gameplay_SPMove_Up) ? panSpeed : 0f);
	}

	public override void UpdateRebind()
	{
		base.UpdateRebind();
		KeyCode keyCode = KeyCode.None;
		for (int i = 0; i <= 329; i++)
		{
			if (Input.GetKeyUp((KeyCode)i))
			{
				keyCode = (KeyCode)i;
				inputHandler.OnInputRebindCaptured.Invoke();
				break;
			}
		}
		if (keyCode == KeyCode.None || (m_rebindInputAction == InputAction.Gameplay_LiftAndPlace && keyCode == currentBindings[InputAction.Menu_Back].p1) || (m_rebindInputAction == InputAction.Menu_Back && keyCode == currentBindings[InputAction.Gameplay_LiftAndPlace].p1))
		{
			return;
		}
		MappedInput value = null;
		if (!currentBindings.TryGetValue(m_rebindInputAction, out value))
		{
			value = new MappedInput();
		}
		if (m_conflictResolutionList != null)
		{
			InputAction[] conflictResolutionList = m_conflictResolutionList;
			foreach (InputAction key in conflictResolutionList)
			{
				MappedInput value2 = null;
				if (currentBindings.TryGetValue(key, out value2))
				{
					if (m_rebindLayoutSlot == 0 && value2.p1 == keyCode)
					{
						currentBindings[key].p1 = value.p1;
					}
					else if (m_rebindLayoutSlot == 1 && value2.s1 == keyCode)
					{
						currentBindings[key].s1 = value.s1;
					}
				}
			}
		}
		if (m_rebindLayoutSlot == 0)
		{
			value.p1 = keyCode;
		}
		else if (m_rebindLayoutSlot == 1)
		{
			value.s1 = keyCode;
		}
		currentBindings[m_rebindInputAction] = value;
		m_rebindLayoutSlot = -1;
		Save();
		inputHandler.Instance.EndRebind();
	}

	private bool IsKeyDown(KeyCode keyCode)
	{
		return Input.GetKey(keyCode);
	}

	public override bool IsInputActionDown(InputAction inputAction)
	{
		MappedInput value = null;
		if (currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != KeyCode.None && IsKeyDown(value.p1) && (value.p2 == KeyCode.None || IsKeyDown(value.p2)))
			{
				return true;
			}
			if (value.s1 != KeyCode.None && IsKeyDown(value.s1) && (value.s2 == KeyCode.None || IsKeyDown(value.s2)))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsKeyPressed(KeyCode keyCode)
	{
		return Input.GetKeyDown(keyCode);
	}

	private bool IsKeyReleased(KeyCode keyCode)
	{
		return Input.GetKeyUp(keyCode);
	}

	public override bool IsInputActionPressed(InputAction inputAction)
	{
		MappedInput value = null;
		if (currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != KeyCode.None)
			{
				if (value.p2 == KeyCode.None)
				{
					if (IsKeyPressed(value.p1))
					{
						return true;
					}
				}
				else if ((IsKeyPressed(value.p1) && IsKeyDown(value.p2)) || (IsKeyDown(value.p1) && IsKeyPressed(value.p2)))
				{
					return true;
				}
			}
			if (value.s1 != KeyCode.None)
			{
				if (value.s2 == KeyCode.None)
				{
					if (IsKeyPressed(value.s1))
					{
						return true;
					}
				}
				else if ((IsKeyPressed(value.s1) && IsKeyDown(value.s2)) || (IsKeyDown(value.s1) && IsKeyPressed(value.s2)))
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
		if (currentBindings.TryGetValue(inputAction, out value))
		{
			if (value.p1 != KeyCode.None)
			{
				if (value.p2 == KeyCode.None)
				{
					if (IsKeyReleased(value.p1))
					{
						return true;
					}
				}
				else if ((IsKeyReleased(value.p1) && IsKeyDown(value.p2)) || (IsKeyDown(value.p1) && IsKeyReleased(value.p2)))
				{
					return true;
				}
			}
			if (value.s1 != KeyCode.None)
			{
				if (value.s2 == KeyCode.None)
				{
					if (IsKeyReleased(value.s1))
					{
						return true;
					}
				}
				else if ((IsKeyReleased(value.s1) && IsKeyDown(value.s2)) || (IsKeyDown(value.s1) && IsKeyReleased(value.s2)))
				{
					return true;
				}
			}
		}
		return false;
	}

	public override Vector2 GetAxis2D(InputAction inputAction)
	{
		Vector2 zero = Vector2.zero;
		if (inputAction == InputAction.Gameplay_CursorMove)
		{
			return m_mouse;
		}
		return zero;
	}

	public override Vector2 GetAxis2DRaw(InputAction inputAction)
	{
		Vector2 zero = Vector2.zero;
		switch (inputAction)
		{
		case InputAction.Gameplay_CursorMove:
			return m_mouseRaw;
		case InputAction.Gameplay_ScreenPanMove:
			return m_screenPan;
		default:
			return zero;
		}
	}

	public override float GetHorizontalAxis()
	{
		return Input.GetAxisRaw("Horizontal");
	}

	public override float GetVerticalAxis()
	{
		return Input.GetAxisRaw("Vertical");
	}

	public override bool IsSubmitButtonPressed()
	{
		return Input.GetButtonDown("Submit");
	}

	public override bool IsCancelButtonPressed()
	{
		return Input.GetButtonDown("Cancel");
	}

	public override bool AnyKeyOrButtonDown()
	{
		for (int i = 0; i <= 329; i++)
		{
			if (Input.GetKey((KeyCode)i))
			{
				return true;
			}
		}
		return false;
	}

	public override bool AnyKeyOrButtonPressed()
	{
		for (int i = 0; i <= 329; i++)
		{
			if (Input.GetKeyDown((KeyCode)i))
			{
				return true;
			}
		}
		return false;
	}

	public override bool AnyAxisMoved()
	{
		if (m_mouseRaw.sqrMagnitude > 0f)
		{
			return true;
		}
		return false;
	}

	private string GetKeyName(KeyCode keyCode)
	{
		if (m_keyDisplayNames.ContainsKey(keyCode))
		{
			return m_keyDisplayNames[keyCode];
		}
		return keyCode.ToString();
	}

	public override string GetBindingString(InputAction inputAction, int layoutSlot)
	{
		if (currentBindings.Count == 0)
		{
			Load();
			if (currentBindings.Count == 0)
			{
				Debug.LogWarning("No bindings loaded.");
				return "";
			}
		}
		string text = "";
		MappedInput value = null;
		if (currentBindings.TryGetValue(inputAction, out value))
		{
			switch (layoutSlot)
			{
			case 0:
				text += GetKeyName(value.p1);
				if (value.p2 != KeyCode.None)
				{
					text = text + " + " + GetKeyName(value.p2);
				}
				break;
			case 1:
				text += GetKeyName(value.s1);
				if (value.s2 != KeyCode.None)
				{
					text = text + " + " + GetKeyName(value.s2);
				}
				break;
			}
		}
		return text;
	}
}
