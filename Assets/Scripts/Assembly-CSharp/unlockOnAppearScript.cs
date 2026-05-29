public class unlockOnAppearScript : attachmentBaseScript
{
	public statsScript.stickers m_stickerUnlock = statsScript.stickers.initial;

	public override void ChangePlaced(bool _value)
	{
		if (_value)
		{
			statsScript.AwardSticker(m_stickerUnlock);
		}
	}
}
