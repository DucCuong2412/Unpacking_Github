using UnityEngine;

public class computerScript : attachmentBaseScript
{
	[Header("WWise Events")]
	public string m_audioStart;

	public string m_audioStop;

	public string m_audioStopOverride;

	public string m_audioContinue;

	[Space(20f)]
	protected bool m_init;

	protected bool m_active;

	public computerDisplayScript m_displayScript;

	protected uint m_audioID;

	protected Transform m_originalParent;

	protected Transform m_audioWheel;

	public override bool computer => true;

	public override int attachmentValues => 1;

	public override bool canPlacedInteract => CanStart();

	public virtual bool usesTelevision => false;

	public override int[] GetAttachmentValues()
	{
		return new int[1] { m_active ? 1 : 0 };
	}

	public override void SetAttachmentValues(int[] _values)
	{
		if (_values[0] > 0)
		{
			SetAll(1);
		}
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		if (m_displayScript != null)
		{
			m_displayScript.ChangeState(_state);
		}
	}

	public override bool PlacedInteract(bool _instant = false)
	{
		if (m_active)
		{
			SetAll(-1);
			return true;
		}
		if (CanStart())
		{
			statsScript.SpecialEvent(statsScript.specialEvents.computerBoot);
			SetAll(_instant ? 1 : 0);
			return true;
		}
		return false;
	}

	protected virtual void Init()
	{
	}

	public virtual void PickedUp()
	{
	}

	public virtual void SetTelevision(televisionDisplayScript _television)
	{
	}

	public virtual void AddItem(itemScript _item)
	{
	}

	public virtual void RemoveItem(itemScript _item)
	{
	}

	protected virtual bool CanStart()
	{
		return false;
	}

	protected virtual void SetAll(int _value)
	{
	}

	private void OnDestroy()
	{
		if (m_active && m_audioID != 0)
		{
			AkSoundEngine.StopPlayingID(m_audioID);
		}
	}
}
