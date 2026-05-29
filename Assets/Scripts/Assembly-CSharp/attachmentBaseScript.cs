using UnityEngine;

public class attachmentBaseScript : MonoBehaviour
{
	public virtual int attachmentValues => 0;

	public virtual bool shakable => false;

	public virtual bool computer => false;

	public virtual bool proximity => false;

	public virtual bool canPlacedInteract => false;

	public virtual int[] GetAttachmentValues()
	{
		return new int[0];
	}

	public virtual void SetAttachmentValues(int[] _values)
	{
	}

	public virtual void ChangeValidity(bool _value)
	{
	}

	public virtual void ChangePlaced(bool _value)
	{
	}

	public virtual void ChangeState(itemScript.itemState _state)
	{
	}

	public virtual void NewPosition(Vector2 _position)
	{
	}

	public virtual void Stack(int _value)
	{
	}

	public virtual bool PlacedInteract(bool _instant = false)
	{
		return false;
	}

	public virtual int PlacedInteractFull()
	{
		if (!PlacedInteract())
		{
			return 0;
		}
		return 1;
	}

	public virtual bool HoverInteract()
	{
		return false;
	}

	public virtual void ComputerDisplay(int _function, float _time = 0f)
	{
	}

	public virtual void StartValid()
	{
	}

	public virtual float GetAnimTime()
	{
		return 1f;
	}

	public virtual void DestroyItem()
	{
	}
}
