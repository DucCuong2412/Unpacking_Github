using UnityEngine;

public class puzzleScript : attachmentBaseScript
{
	private itemScript m_target;

	public Sprite[] m_frames;

	private int m_frameCurrent;

	private bool m_increasing = true;

	public string m_audio = "Play_turn";

	public override int attachmentValues => 1;

	public override bool HoverInteract()
	{
		if (m_target == null)
		{
			m_target = base.transform.parent.GetComponent<itemScript>();
		}
		if (m_increasing)
		{
			m_frameCurrent++;
			if (m_frameCurrent == m_frames.Length - 1)
			{
				statsScript.SpecialEvent(statsScript.specialEvents.puzzleCube);
				statsScript.AwardSticker(statsScript.stickers.sticker_brain);
				m_increasing = false;
			}
		}
		else
		{
			m_frameCurrent--;
			if (m_frameCurrent == 0)
			{
				m_increasing = true;
			}
		}
		m_target.SetArt(m_frames[m_frameCurrent]);
		return true;
	}

	public override int[] GetAttachmentValues()
	{
		return new int[1] { m_increasing ? m_frameCurrent : (m_frames.Length * 2 - m_frameCurrent - 1) };
	}

	public override void SetAttachmentValues(int[] _values)
	{
		if (_values[0] < m_frames.Length)
		{
			m_frameCurrent = _values[0];
			m_increasing = true;
		}
		else
		{
			m_frameCurrent = m_frames.Length * 2 - _values[0] - 1;
			m_increasing = false;
		}
		base.transform.parent.GetComponent<itemScript>().m_renderer.sprite = m_frames[m_frameCurrent];
	}
}
