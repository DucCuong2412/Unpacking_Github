using System;
using UnityEngine;

public class touchScheme : ScriptableObject
{
	[NonSerialized]
	private bool _isActive;

	public bool IsActive => _isActive;

	public virtual int TouchCount => 0;

	public virtual Touch[] Touches => new Touch[0];

	public virtual void Init()
	{
	}

	public virtual void OnActivate()
	{
		_isActive = true;
	}

	public virtual void OnDeactivate()
	{
		_isActive = false;
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

	public virtual void Poll()
	{
	}

	public virtual void Update()
	{
	}

	public virtual bool IsTouchDown()
	{
		return false;
	}

	public virtual bool IsTouchDown(int index)
	{
		return false;
	}

	public virtual Touch GetTouch()
	{
		Touch touch = new Touch
		{
			fingerId = -1
		};
		return default(Touch);
	}

	public virtual Touch GetTouch(int index)
	{
		Touch touch = new Touch
		{
			fingerId = -1
		};
		return default(Touch);
	}
}
