--Sorry, Encoding of this file is Shift-JIS.

--�y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�t�@�C���쐬    �F2012-10-07 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-07 �S�{�剤

--[[
	�g�����B

	�i�P�jLua�t�@�C����ǂݍ���ł����܂��B
		prequire("s/csv.lua");
		prequire("s/auto.lua");
		--���̑��A�V�[���t�@�C���B

	�i�Q�j�V�[���J��CSV���쐬���܂��B

		data/sceneChanges.csv

		�i��j
		NO,SCENE,Expl,BTN1,BTN2,BTN3,BTN4,BTN5,BTN6,BTN7,BTN8,BTN9,BTN10,BTN11,BTN12,END
		int,int,string,int,int,int,int,int,int,int,int,int,int,int,int,END
		-1,�V�[�����B�󔒂܂��́u-1�v������Ɩ�������܂��B,���,�{�^��1���������Ƃ��̈ړ���V�[�����B�󔒂܂��́u-1�v������Ɩ�������܂��B,�{�^��2,�{�^��3,�{�^��4,�{�^��5,�{�^��6,�{�^��7,�{�^��8,�{�^��9,�{�^��10,�{�^��11,�{�^��12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.�i����CSV�t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j",,,,,,,,,,,,,END
		0,scene1,,,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		1,scene2,,scene1,,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		2,scene3,,scene1,scene2,,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		3,scene4,,scene1,scene2,scene3,,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		4,scene5,,scene1,scene2,scene3,scene4,,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		5,scene6,,scene1,scene2,scene3,scene4,scene5,,scene7,scene8,scene9,scene10,scene11,scene12,END
		6,scene7,,scene1,scene2,scene3,scene4,scene5,scene6,,scene8,scene9,scene10,scene11,scene12,END
		7,scene8,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,,scene9,scene10,scene11,scene12,END
		8,scene9,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,,scene10,scene11,scene12,END
		9,scene10,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,,scene11,scene12,END
		10,scene11,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,,scene12,END
		11,scene12,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,,END
		EOF,,,,,,,,,,,,,,,

	�i�R�j�V�[���� _OnStep �̍Ō�ŁA���̊֐����Ăяo���܂��B

		auto_ForwardScene("scene1");	--�����͎��V�[�����B

	����ŁA�������{�^���ɉ����� changeScene ���܂��B
	�ȏ�B
]]


--�O���t�@�C���ƏƂ炵���킹�āA�V�[���ړ����܂��B
--current_NameScene:���V�[�����B�󔒂܂��́u-1�v�͓���Ȃ��ł��������B
function auto_ForwardScene(current_NameScene)


	--�f�[�^�x�[�X�E�e�[�u��
	local t = csv_FromFile("data/sceneChanges.csv")

	--���R�[�h
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if record["SCENE"]==current_NameScene then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- �Q�[���p�b�h�́A�\���L�[�ȊO�̃{�^�����󂯕t���܂��B
	local next_NameScene = ""
	if(isJoyPressed(BUTTON_TRIG1))then
		-- �Q�[���p�b�h�̃{�^��1����������Ă���
		next_NameScene = hitsRecord["BTN1"];
	end

	if(isJoyPressed(BUTTON_TRIG2))then
		-- �Q�[���p�b�h�̃{�^��2����������Ă���
		next_NameScene = hitsRecord["BTN2"];
	end

	if(isJoyPressed(BUTTON_TRIG3))then
		-- �Q�[���p�b�h�̃{�^��3����������Ă���
		next_NameScene = hitsRecord["BTN3"];
	end

	if(isJoyPressed(BUTTON_TRIG4))then
		-- �Q�[���p�b�h�̃{�^��4����������Ă���
		next_NameScene = hitsRecord["BTN4"];
	end

	if(isJoyPressed(BUTTON_TRIG5))then
		-- �Q�[���p�b�h�̃{�^��5����������Ă���
		next_NameScene = hitsRecord["BTN5"];
	end

	if(isJoyPressed(BUTTON_TRIG6))then
		-- �Q�[���p�b�h�̃{�^��6����������Ă���
		next_NameScene = hitsRecord["BTN6"];
	end

	if(isJoyPressed(BUTTON_TRIG7))then
		-- �Q�[���p�b�h�̃{�^��7����������Ă���
		next_NameScene = hitsRecord["BTN7"];
	end

	if(isJoyPressed(BUTTON_TRIG8))then
		-- �Q�[���p�b�h�̃{�^��8����������Ă���
		next_NameScene = hitsRecord["BTN8"];
	end

	if(isJoyPressed(BUTTON_TRIG9))then
		-- �Q�[���p�b�h�̃{�^��9����������Ă���
		next_NameScene = hitsRecord["BTN9"];
	end

	if(isJoyPressed(BUTTON_TRIG10))then
		-- �Q�[���p�b�h�̃{�^��10����������Ă���
		next_NameScene = hitsRecord["BTN10"];
	end

	if(isJoyPressed(BUTTON_TRIG11))then
		-- �Q�[���p�b�h�̃{�^��11����������Ă���
		next_NameScene = hitsRecord["BTN11"];
	end

	if(isJoyPressed(BUTTON_TRIG12))then
		-- �Q�[���p�b�h�̃{�^��12����������Ă���
		next_NameScene = hitsRecord["BTN12"];
	end

	--�Q�[���p�b�h�̃{�^���̒萔�� BUTTON_TRIG1�`BUTTON_TRIG12 �i�P�Q�j�܂ł������݂��Ȃ��B


	--CSV����ǂݎ�����l�́A�����ł����Ă��A������^�ɂȂ��Ă��܂��B

	--�V�[���ԍ��́A�󔒁A�܂��́u-1�v�𖳎����܂��B
	if( "" ~= next_NameScene and "-1" ~= next_NameScene )then
		--������A�����ăV�[�������쐬���܂��B
		changeScene(next_NameScene) -- �V�[���ؑցB
	end

end

--�y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
