Title = (irandom(10) >= 9) ? "biboOtale" : "bijOutale";
ShowIntruction = 0;

view_enabled = true;
view_visible[0] = true;

global.mcam = new cam_ctrl(0, 640, 480);
global.mcam.X[0] = room_width / 2;
global.mcam.Y[0] = room_height / 2;

//BGM Setup
audio_play_sound(bgm_battle_custom, 1000, true);
audio_sound_loop_start(bgm_battle_custom, 182.45);
audio_sound_loop_end(bgm_battle_custom, 397.19);
audio_stop_sound(bgm_battle_custom);

//Tako = new monster_takodachi();