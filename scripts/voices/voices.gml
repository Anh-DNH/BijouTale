function voice_data(audio, len, /*pitch_min, pitch_max,*/ spd) constructor
{
	Audio = audio;
	Length = len;
	//Pitch = [pitch_min, pitch_max];
	Speed = spd;
}

global.CharaVoice = {
	SILENT : undefined,
	TXT1 : new voice_data(sfx_voice_txt1, 0.01, 0.01),
	TXT2 : new voice_data(sfx_voice_txt2, 0.01, 0.01),
}