using System;
using UnityEngine;

public class controlScheme : ScriptableObject
{
	[Serializable]
	public class SerializedBinding
	{
		public string ia;

		public string p1 = "Empty";

		public string p2 = "Empty";

		public string s1 = "Empty";

		public string s2 = "Empty";
	}

	public class InputActionIcon
	{
		public InputAction inputAction;

		public Sprite icon;
	}

	protected string m_deviceName = "";

	protected InputAction m_rebindInputAction;

	protected int m_rebindLayoutSlot = -1;

	protected InputAction[] m_conflictResolutionList;

	[NonSerialized]
	private bool m_isActive;

	public bool IsActive => m_isActive;

	public controlScheme()
	{
		m_isActive = false;
	}

	public virtual void Init()
	{
	}

	public virtual void OnActivate()
	{
		m_isActive = true;
	}

	public virtual void OnDeactivate()
	{
		m_isActive = false;
	}

	public virtual void Load()
	{
	}

	public virtual void Save()
	{
	}

	public virtual void RevertToDefault()
	{
	}

	public virtual void BeginRebind(InputAction inputAction, int layoutSlot, InputAction[] conflictResolutionList)
	{
		m_rebindInputAction = inputAction;
		m_rebindLayoutSlot = layoutSlot;
		m_conflictResolutionList = conflictResolutionList;
	}

	public virtual void UpdateRebind()
	{
	}

	public virtual void CancelRebind()
	{
		m_rebindLayoutSlot = -1;
	}

	public virtual void RefreshAnalogSticks()
	{
	}

	public virtual void Poll()
	{
	}

	public virtual void ControllerApplet(bool _vertical = false)
	{
	}

	public virtual void Update()
	{
	}

	public virtual bool IsInputActionDown(InputAction inputAction)
	{
		return false;
	}

	public virtual bool IsInputActionPressed(InputAction inputAction)
	{
		return false;
	}

	public virtual bool IsInputActionReleased(InputAction inputAction)
	{
		return false;
	}

	public virtual Vector2 GetAxis2D(InputAction inputAction)
	{
		return Vector2.zero;
	}

	public virtual Vector2 GetAxis2DRaw(InputAction inputAction)
	{
		return Vector2.zero;
	}

	public virtual Vector2 GetAxisTilt(inputHandler.tiltMode axis)
	{
		return Vector2.zero;
	}

	public virtual float GetHorizontalAxis()
	{
		return 0f;
	}

	public virtual float GetVerticalAxis()
	{
		return 0f;
	}

	public virtual bool IsSubmitButtonPressed()
	{
		return false;
	}

	public virtual bool IsCancelButtonPressed()
	{
		return false;
	}

	public virtual bool AnyKeyOrButtonDown()
	{
		return false;
	}

	public virtual bool AnyKeyOrButtonPressed()
	{
		return false;
	}

	public virtual bool AnyAxisMoved()
	{
		return false;
	}

	public virtual Sprite[] GetIcons(InputAction inputAction, int layoutSlot, bool tutorial = false)
	{
		return null;
	}

	public virtual string GetBindingString(InputAction inputAction, int layoutSlot)
	{
		return "<null>";
	}

	public virtual void SendVibration(int motorIndex, float motorLevel, float duration)
	{
	}

	public virtual void SetVibration(Vector4 _left, Vector4 _right)
	{
	}

	public virtual void StopVibration()
	{
	}
}
