using System;
using UnityEngine;

[CreateAssetMenu(fileName = "vibrations", menuName = "ScriptableObjects/vibrationData")]
public class vibrationData : ScriptableObject
{
	public enum vibrationType
	{
		simple = 0,
		fade = 1,
		curve = 2,
		dualCurve = 3
	}

	public enum HDvibrationType
	{
		mono = 0,
		stereo = 1,
		ping = 2
	}

	[Serializable]
	public struct vibration
	{
		public string desc;

		public vibrationScript.moment[] moments;

		public Vector2 strength;

		public float length;

		public vibrationType type;

		public AnimationCurve curve;

		public AnimationCurve curveHigh;

		public bool Match(vibrationScript.moment _moment)
		{
			for (int i = 0; i < moments.Length; i++)
			{
				if (_moment == moments[i])
				{
					return true;
				}
			}
			return false;
		}

		public Vector2 Evaulate(float _value)
		{
			if (type == vibrationType.fade)
			{
				return (1f - _value) * strength;
			}
			if (type == vibrationType.curve)
			{
				return curve.Evaluate(_value) * strength;
			}
			if (type == vibrationType.dualCurve)
			{
				return new Vector2(curve.Evaluate(_value) * strength.x, curveHigh.Evaluate(_value) * strength.y);
			}
			return strength;
		}
	}

	[Serializable]
	public struct HDvibration
	{
		public string desc;

		public vibrationScript.moment[] moments;

		public Vector2 strength;

		public float length;

		public HDvibrationType type;

		public AnimationCurve leftLow;

		public AnimationCurve leftHigh;

		public AnimationCurve rightLow;

		public AnimationCurve rightHigh;

		public bool Match(vibrationScript.moment _moment)
		{
			for (int i = 0; i < moments.Length; i++)
			{
				if (_moment == moments[i])
				{
					return true;
				}
			}
			return false;
		}

		public Vector4 Evaulate(float _value, float _pan)
		{
			if (type == HDvibrationType.mono)
			{
				float num = leftLow.Evaluate(_value) * strength.x * 2f;
				float num2 = leftHigh.Evaluate(_value) * strength.y * 2f;
				return new Vector4(num * (1f - _pan), num2 * (1f - _pan), num * _pan, num2 * _pan);
			}
			if (type == HDvibrationType.stereo)
			{
				return new Vector4(leftLow.Evaluate(_value) * strength.x, leftHigh.Evaluate(_value) * strength.y, rightLow.Evaluate(_value) * strength.x, rightHigh.Evaluate(_value) * strength.y);
			}
			if (type == HDvibrationType.ping && _value >= 1f)
			{
				return new Vector4(strength.x * 2f * (1f - _pan), strength.y * 2f * (1f - _pan), strength.x * 2f * _pan, strength.y * 2f * _pan);
			}
			return Vector4.zero;
		}
	}

	public vibration[] vibrations;

	public HDvibration[] HDvibrations;
}
