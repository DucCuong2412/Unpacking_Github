using UnityEngine;

[CreateAssetMenu(fileName = "TouchScheme_Unity", menuName = "ScriptableObjects/touchScheme_unity", order = 12)]
public class touchScheme_unity : touchScheme
{
	public override int TouchCount => Input.touchCount;

	public override Touch[] Touches => Input.touches;

	public override bool IsTouchDown()
	{
		return IsTouchDown(0);
	}

	public override bool IsTouchDown(int index)
	{
		if (TouchCount > index)
		{
			return index >= 0;
		}
		return false;
	}

	public override Touch GetTouch()
	{
		return GetTouch(0);
	}

	public override Touch GetTouch(int index)
	{
		if (TouchCount <= index || index < 0)
		{
			return new Touch
			{
				fingerId = -1
			};
		}
		return Input.GetTouch(index);
	}
}
