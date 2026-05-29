using System.Collections.Generic;
using Rewired;
using UnityEngine;

public class vibrationScript : MonoBehaviour
{
	public enum moment
	{
		none = 0,
		zoneChangeLeft = 1,
		zoneChangeRight = 2,
		zoneChangeVertical = 3,
		boxOpen = 4,
		boxClear = 5,
		stageClear = 6,
		validationActivate = 7,
		itemPlace = 8,
		itemPlaceHeavy = 9,
		slidingDoor = 10,
		collision = 11,
		testRumble = 12,
		photoPlace = 13,
		albumOpen = 14,
		albumClose = 15,
		albumPageLeft = 16,
		albumPageRight = 17,
		albumStackLift = 18,
		albumStackReturn = 19,
		stageClearAction = 20,
		stageBeginAction = 21
	}

	private class vibrationEvent
	{
		public int dataId;

		public float lerp;

		public float pan;

		private float rate;

		public vibrationEvent(int _dataId, float _length, float _pan = 0.5f)
		{
			dataId = _dataId;
			lerp = 0f;
			rate = 1f / _length;
			pan = _pan;
		}

		public void Update(float _delta)
		{
			lerp += _delta * rate;
		}
	}

	private static vibrationScript s_instance;

	private Joystick m_joystick;

	public vibrationData m_data;

	private List<vibrationEvent> m_events = new List<vibrationEvent>();

	public static void SetJoystick(Joystick _joystick)
	{
		Stop();
		if (_joystick == null || !_joystick.supportsVibration)
		{
			s_instance.m_joystick = null;
		}
		else
		{
			s_instance.m_joystick = _joystick;
		}
	}

	public static void Trigger(moment _moment, float _pan = 0.5f)
	{
		s_instance.TriggerVibration(_moment, _pan);
	}

	private void TriggerVibration(moment _moment, float _pan)
	{
		if (!inputHandler.IsVibrationEnabled || inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Gamepad || m_joystick == null)
		{
			return;
		}
		for (int i = 0; i < m_data.vibrations.Length; i++)
		{
			if (m_data.vibrations[i].Match(_moment))
			{
				m_events.Add(new vibrationEvent(i, m_data.vibrations[i].length));
				EvaulateVibration();
			}
		}
	}

	private void Start()
	{
		s_instance = this;
	}

	private void Update()
	{
		EvaulateVibration();
	}

	private void EvaulateVibration()
	{
		if (m_joystick == null || m_events.Count == 0)
		{
			return;
		}
		float num = 0f;
		float num2 = 0f;
		for (int i = 0; i < m_events.Count; i++)
		{
			if (m_events[i].lerp >= 1f)
			{
				m_events.RemoveAt(i);
				i--;
				continue;
			}
			Vector2 vector = m_data.vibrations[m_events[i].dataId].Evaulate(m_events[i].lerp);
			num = Mathf.Max(num, vector.x);
			num2 = Mathf.Max(num2, vector.y);
			m_events[i].Update(Time.deltaTime);
		}
		m_joystick.SetVibration(num, num2);
	}

	public static void Stop()
	{
		if (ReInput.isReady)
		{
			ReInput.players.GetPlayer(0).StopVibration();
		}
	}

	private void OnDisable()
	{
		Stop();
	}
}
