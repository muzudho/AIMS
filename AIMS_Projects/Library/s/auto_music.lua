--Sorry, Encoding of this file is Shift-JIS.

--�y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�w�S�{�剤��AIMS/Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-14 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-14 �S�{�剤

--[[
	�g�����B

	�i�P�jboot.lua�́u���L�֐��Ăяo���v���ŁALua�t�@�C����ǂݍ���ł����܂��B
		prequire("s/csv.lua");
		prequire("s/auto_music.lua");
		--���̑��A���y�f�ރt�@�C���͗p�ӂ���Ă�����̂Ƃ��܂��B

	�i�Q�j���yCSV���쐬���܂��B

		data/auto_music.csv

		�i��j
		NO,ID,INTRO,LOOP,NO_REPEAT,END
		int,string,string,string,string,END
		-1,���ʎq,�C���g�������i�܂��͊ۂ��Ɓj�̃t�@�C����,���[�v�����̃t�@�C�����i����΁j,�uYes�v�c���[�v���Ȃ��B�u�i�󔒁j�v�c���[�v����B,END
		0,,,,,END
		1,game_OnStart,mus/stage_lp.ogg,,,END
		2,title_OnStart,mus/title_in.ogg,mus/title_lp.ogg,,END
		EOF,,,,,

	�i�R�j���y��؂�ւ������^�C�~���O�ŁA���̊֐����Ăяo���܂��B

		auto_MusicAt("game_OnStart");	--�����̓e�[�u���́uID�v��l�B������Ăяo���Ă���֐��̖��O������ƕ֗��B

	����ŁA�O���t�@�C���ŉ��y�̑�����w��ł��܂��B
	�ȏ�B
]]


--�O���t�@�C���ƏƂ炵���킹�āA�V�[���ړ����܂��B
--id:���̊֐���u���Ă���֐��̖��O������ƕ֗��ł��B�󔒂܂��́u-1�v�͓���Ȃ��ł��������B
function auto_MusicAt(id)


	--�f�[�^�x�[�X�E�e�[�u��
	local table = csv_FromFile("data/auto_music.csv")

	--���R�[�h
	local hitsRecord
	local numberRow = 1
	for numberRowB,record in pairs(table) do
		if 4<=numberRow then					--�ŏ��̂R�s�̓t�B�[���h��`�Ȃ̂œǂݔ�΂��܂��B
			if record["ID"]==id then
				hitsRecord = record
				break
			end
		end
		
		numberRow = numberRow + 1
	end

	local fieldIntro
	fieldIntro = hitsRecord["INTRO"];
	if("-1"==fieldIntro)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		fieldIntro = ""
	end

	local fieldLoop
	fieldLoop = hitsRecord["LOOP"];
	if("-1"==fieldLoop)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		fieldLoop = ""
	end

	local fieldNorepeat
	fieldNorepeat = hitsRecord["NO_REPEAT"];
	if("-1"==fieldNorepeat)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		fieldNorepeat = ""
	end

	local fieldFadeout
	fieldFadeout = hitsRecord["FADEOUT"];
	if("-1"==fieldFadeout)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		fieldFadeout = ""
	end

	local fieldWaitwithfadeout
	fieldWaitwithfadeout = hitsRecord["WAIT_WITH_FADEOUT"];
	if("-1"==fieldWaitwithfadeout)then
		--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
		fieldWaitwithfadeout = ""
	end


	if(""==fieldIntro)then
		--���y��؂�ւ��܂���B
	elseif("Yes"==fieldNorepeat)then
		--�Đ��i���[�v�Ȃ��j
		playMusic( fieldIntro )
	else
		if(""~=fieldLoop)then
			--�Đ��i���[�v�������[�v�j
			playMusicLoop( fieldIntro, fieldLoop )
		else
			--�Đ��i�ۂ��ƃ��[�v�j
			playMusicLoop( fieldIntro )
		end
	end

	if(""~=fieldFadeout)then
		fadeMusic( tonumber(fieldFadeout) )

		if(""~=fieldWaitwithfadeout)then
			wait( tonumber(fieldWaitwithfadeout) )
		end
	end

end

--�y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
