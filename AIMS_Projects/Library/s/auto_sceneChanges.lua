--Sorry, Encoding of this file is Shift-JIS.

--�y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�w�S�{�剤��AIMS/Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-07 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-14 �S�{�剤

--[[
	�g�����B

	�i�P�jLua�t�@�C����ǂݍ���ł����܂��B
		prequire("s/csv.lua");
		prequire("s/auto_sceneChanges.lua");
		--���̑��A�V�[���t�@�C���B

	�i�Q�j�V�[���J��CSV���쐬���܂��B

		data/auto_sceneChanges.csv

		�i��j
		NO,ID,Expl,ALWAYS,DISABLED_AT_LOADING,THREAD_NOT_RUNNING,BTN1,BTN1_PARAM,BTN2,BTN2_PARAM,BTN3,BTN3_PARAM,BTN4,BTN4_PARAM,BTN5,BTN5_PARAM,BTN6,BTN6_PARAM,BTN7,BTN7_PARAM,BTN8,BTN8_PARAM,BTN9,BTN_PARAM,BTN10,BTN10_PARAM,BTN11,BTN11_PARAM,BTN12,BTN12_PARAM,END
		int,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,END
		-1,auto_SceneAt(...)���u����Ă���֐���������ƕ֗��ł��B���ʂł���Ή��ł��\��Ȃ��B�󔒂܂��́u-1�v������Ɩ�������܂��B,���,���̗�ɐݒ肳��Ă���ƁA�K�����ꂪ�I�΂�܂��B,�uYes�v�cisLoaderRunning=true �i�f�[�^���[�h���j�̏ꍇ�A�{�^�����͂ɂ��V�[���J�ڂ𖳌��ɂ��܂��B�uNo�A-1�A(��)�v�c�Ȃɂ����܂���B,isThreadRunning()==false�i�X���b�h���I�����Ă���j�̏ꍇ�A�{�^�������D��I�ɂ��ꂪ�I�΂�܂��B�i�󔒁A�܂���-1�ȊO���ݒ肳��Ă���ꍇ�j,�{�^��1���������Ƃ��̈ړ���V�[�����B�󔒂܂��́u-1�v������Ɩ�������܂��B,�uPush�v�c��x�{�^���𗣂��Ă��牟���Ȃ��Ɣ������܂���B�u(��)�܂���-1�v�c�����Ă���Δ������܂��B,�{�^��2,�{�^��2,�{�^��3,�{�^��3,�{�^��4,�{�^��4,�{�^��5,�{�^��5,�{�^��6,�{�^��6,�{�^��7,�{�^��7,�{�^��8,�{�^��8,�{�^��9,�{�^��9,�{�^��10,�{�^��10,�{�^��11,�{�^��11,�{�^��12,�{�^��12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.�i����CSV�t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j",,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		0,boot_OnStart,,logo,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		1,logo_OnStep(DONT_USE),CSV�t�@�C�����Ǎ��݊������Ă��Ȃ����Ƃ�����̂ŁA���̃��R�[�h�͎g���Ȃ��B,,Yes,title,title,,,,,,,,,,,,,,,,,,,,,,,,END
		2,title_OnStep,,,,,game,Push,,,,,,,,,,,,,,,,,,,,,,,END
		3,thread_gameover,,gameover,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		4,gameover_OnStep,,,,,title,,,,,,,,,,,,,,,,,,,,,,,,END
		EOF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

	�i�R�j�V�[����؂�ւ������^�C�~���O�ŁA���̊֐����Ăяo���܂��B

		auto_SceneAt("scene1_OnStep");	--�����́A������Ăяo���Ă���֐��̖��O������ƕ֗��B

	����ŁA�������{�^���ɉ����� changeScene ���܂��B
	�ȏ�B
]]


--�O���t�@�C���ƏƂ炵���킹�āA�V�[���ړ����܂��B
--id:���̊֐���u���Ă���֐��̖��O������ƕ֗��ł��B�󔒂܂��́u-1�v�͓���Ȃ��ł��������B
function auto_SceneAt(id)


	--�f�[�^�x�[�X�E�e�[�u��
	local t = csv_FromFile("data/auto_sceneChanges.csv")

	--���R�[�h
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if record["ID"]==id then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- �Q�[���p�b�h�́A�\���L�[�ȊO�̃{�^�����󂯕t���܂��B
	local next_NameScene
	next_NameScene = hitsRecord["ALWAYS"];
	if("-1"==next_NameScene)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		next_NameScene = ""
	end

	if(""==next_NameScene and isLoaderRunning())then
		--�f�[�^���[�h���̂Ƃ��B
		next_NameScene = hitsRecord["DISABLED_AT_LOADING"];
		if("Yes"==next_NameScene)then
			--�{�^�������ɂ���ʑJ�ڂ𖳎����܂��B
			next_NameScene = "-1"
		end
	end

	if(""==next_NameScene and isThreadRunning()==false)then
		--�X���b�h�������Ă��Ȃ��Ƃ��B
		next_NameScene = hitsRecord["THREAD_NOT_RUNNING"];
		if("-1"==next_NameScene)then
			--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
			next_NameScene = ""
		end
	end

	local button_trig = {
		BUTTON_TRIG1,
		BUTTON_TRIG2,
		BUTTON_TRIG3,
		BUTTON_TRIG4,
		BUTTON_TRIG5,
		BUTTON_TRIG6,
		BUTTON_TRIG7,
		BUTTON_TRIG8,
		BUTTON_TRIG9,
		BUTTON_TRIG10,
		BUTTON_TRIG11,
		BUTTON_TRIG12
	}
	local btnParam, hits
	local btnNum=1
	--�{�^��1�`12�B
	while(""==next_NameScene and btnNum<=12)do

		-- BTN1_PARAM �` BTN12_PARAM
		btnParam = hitsRecord[ "BTN" .. btnNum .. "_PARAM" ];
		if( btnParam=="Push" )then
			if( 1==getJoyPressCount(0,button_trig[btnNum]) )then
				-- �Q�[���p�b�h�̃{�^��N���A�������񗣂��ꂽ��ɉ����ꂽ���B
				hits = true
			end
		elseif( 0<getJoyPressCount(0,button_trig[btnNum]) )then
			-- �Q�[���p�b�h�̃{�^��N�́A��������Ă���B
			hits = true
		end
		if( hits )then
			-- BTN1 �` BTN12
			next_NameScene = hitsRecord[ "BTN" .. btnNum ];
			break;
		end

		btnNum = btnNum + 1
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
