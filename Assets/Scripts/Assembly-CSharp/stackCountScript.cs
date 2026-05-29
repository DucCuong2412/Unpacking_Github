public class stackCountScript : attachmentBaseScript
{
	public int m_stackThreshold = 4;

	public statsScript.stickers m_stickerUnlock = statsScript.stickers.sticker_blocks;

	public override void Stack(int _stack)
	{
		if (_stack >= m_stackThreshold)
		{
			statsScript.AwardSticker(m_stickerUnlock);
		}
	}
}
