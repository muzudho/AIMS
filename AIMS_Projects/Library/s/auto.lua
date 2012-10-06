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
		-1,�V�[�����B�uscene�v�̌��ɘA������镶����B�󔒂܂��́u-1�v������Ɩ�������܂��B,���,�{�^��1���������Ƃ��̈ړ���V�[�����B�uscene�v�̌��ɘA������镶����B�󔒂܂��́u-1�v������Ɩ�������܂��B,�{�^��2,�{�^��3,�{�^��4,�{�^��5,�{�^��6,�{�^��7,�{�^��8,�{�^��9,�{�^��10,�{�^��11,�{�^��12,END
		-1,-1,"Sorry, Encoding of this file is Shift-JIS.�i���̃t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j",,,,,,,,,,,,,END
		0,1,,-1,2,3,4,5,6,7,8,9,10,11,12,END
		1,2,,1,-1,3,4,5,6,7,8,9,10,11,12,END
		2,3,,1,2,-1,4,5,6,7,8,9,10,11,12,END
		3,4,,1,2,3,-1,5,6,7,8,9,10,11,12,END
		4,5,,1,2,3,4,-1,6,7,8,9,10,11,12,END
		5,6,,1,2,3,4,5,-1,7,8,9,10,11,12,END
		6,7,,1,2,3,4,5,6,-1,8,9,10,11,12,END
		7,8,,1,2,3,4,5,6,7,-1,9,10,11,12,END
		8,9,,1,2,3,4,5,6,7,8,-1,10,11,12,END
		9,10,,1,2,3,4,5,6,7,8,9,-1,11,12,END
		10,11,,1,2,3,4,5,6,7,8,9,10,-1,12,END
		11,12,,1,2,3,4,5,6,7,8,9,10,11,-1,END
		EOF,,,,,,,,,,,,,,,

	�i�R�j�V�[���� _OnStep �̍Ō�ŁA���̊֐����Ăяo���܂��B

		auto_ForwardScene(1);	--�����͎��V�[���ԍ��B

	����ŁA�������{�^���ɉ����� changeScene ���܂��B
	�i�V�[�����͐����Ƃ��܂��j
	�ȏ�B
]]


--�O���t�@�C���ƏƂ炵���킹�āA�V�[���ړ����܂��B
--currentScenePartsName:���V�[�����́uscene�v�̌��ɘA������Ă��镶����B�󔒂܂��́u-1�v�͓���Ȃ��ł��������B
function auto_ForwardScene(currentScenePartsName)


	--�f�[�^�x�[�X�E�e�[�u��
	local t = csv_FromFile("data/sceneChanges.csv")

	--���R�[�h
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if tonumber(record["SCENE"])==currentScenePartsName then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- �Q�[���p�b�h�́A�\���L�[�ȊO�̃{�^�����󂯕t���܂��B
	local nextScenePartsName = ""
	if(isJoyPressed(BUTTON_TRIG1))then
		-- �Q�[���p�b�h�̃{�^��1����������Ă���
		nextScenePartsName = hitsRecord["BTN1"];
	end

	if(isJoyPressed(BUTTON_TRIG2))then
		-- �Q�[���p�b�h�̃{�^��2����������Ă���
		nextScenePartsName = hitsRecord["BTN2"];
	end

	if(isJoyPressed(BUTTON_TRIG3))then
		-- �Q�[���p�b�h�̃{�^��3����������Ă���
		nextScenePartsName = hitsRecord["BTN3"];
	end

	if(isJoyPressed(BUTTON_TRIG4))then
		-- �Q�[���p�b�h�̃{�^��4����������Ă���
		nextScenePartsName = hitsRecord["BTN4"];
	end

	if(isJoyPressed(BUTTON_TRIG5))then
		-- �Q�[���p�b�h�̃{�^��5����������Ă���
		nextScenePartsName = hitsRecord["BTN5"];
	end

	if(isJoyPressed(BUTTON_TRIG6))then
		-- �Q�[���p�b�h�̃{�^��6����������Ă���
		nextScenePartsName = hitsRecord["BTN6"];
	end

	if(isJoyPressed(BUTTON_TRIG7))then
		-- �Q�[���p�b�h�̃{�^��7����������Ă���
		nextScenePartsName = hitsRecord["BTN7"];
	end

	if(isJoyPressed(BUTTON_TRIG8))then
		-- �Q�[���p�b�h�̃{�^��8����������Ă���
		nextScenePartsName = hitsRecord["BTN8"];
	end

	if(isJoyPressed(BUTTON_TRIG9))then
		-- �Q�[���p�b�h�̃{�^��9����������Ă���
		nextScenePartsName = hitsRecord["BTN9"];
	end

	if(isJoyPressed(BUTTON_TRIG10))then
		-- �Q�[���p�b�h�̃{�^��10����������Ă���
		nextScenePartsName = hitsRecord["BTN10"];
	end

	if(isJoyPressed(BUTTON_TRIG11))then
		-- �Q�[���p�b�h�̃{�^��11����������Ă���
		nextScenePartsName = hitsRecord["BTN11"];
	end

	if(isJoyPressed(BUTTON_TRIG12))then
		-- �Q�[���p�b�h�̃{�^��12����������Ă���
		nextScenePartsName = hitsRecord["BTN12"];
	end

	--�Q�[���p�b�h�̃{�^���̒萔�� BUTTON_TRIG1�`BUTTON_TRIG12 �i�P�Q�j�܂ł������݂��Ȃ��B


	--CSV����ǂݎ�����l�́A�����ł����Ă��A������^�ɂȂ��Ă��܂��B

	--�V�[���ԍ��́A�󔒁A�܂��́u-1�v�𖳎����܂��B
	if( "" ~= nextScenePartsName and "-1" ~= nextScenePartsName )then
		--������A�����ăV�[�������쐬���܂��B
		changeScene("scene" .. nextScenePartsName) -- �V�[���ؑցB
	end

end

--�y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
