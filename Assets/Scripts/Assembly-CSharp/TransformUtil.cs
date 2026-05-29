using UnityEngine;

public class TransformUtil
{
	public static bool IsInHierarchy(Transform a, Transform b)
	{
		if (a == null || b == null)
		{
			return false;
		}
		Transform transform = a;
		while (transform != null)
		{
			if (transform == b)
			{
				return true;
			}
			transform = transform.transform.parent;
		}
		return false;
	}
}
