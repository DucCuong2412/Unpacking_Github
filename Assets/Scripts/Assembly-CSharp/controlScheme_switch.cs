using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "ControlScheme_Switch", menuName = "ScriptableObjects/controlScheme_switch", order = 12)]
public class controlScheme_switch : controlScheme
{
	public enum GamepadInput
	{
		Empty = 0,
		A = 1,
		B = 2,
		X = 3,
		Y = 4,
		StickL = 5,
		StickR = 6,
		L = 7,
		R = 8,
		ZL = 9,
		ZR = 10,
		Plus = 11,
		Minus = 12,
		Left = 13,
		Up = 14,
		Right = 15,
		Down = 16,
		StickLLeft = 17,
		StickLUp = 18,
		StickLRight = 19,
		StickLDown = 20,
		StickRLeft = 21,
		StickRUp = 22,
		StickRRight = 23,
		StickRDown = 24,
		LeftSL = 25,
		LeftSR = 26,
		RightSL = 27,
		RightSR = 28,
		Axis_LeftJoystick = 29,
		Axis_RightJoystick = 30,
		MAX = 31
	}

	[Serializable]
	public class InputInfo
	{
		[NonSerialized]
		public GamepadInput button;

		public Sprite icon;

		public Sprite iconTutorial;
	}

	public List<InputInfo> inputManifest = new List<InputInfo>();

	public List<SerializedBinding> defaultBindings = new List<SerializedBinding>();
}
