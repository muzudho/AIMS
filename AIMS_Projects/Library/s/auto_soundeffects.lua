--Sorry, Encoding of this file is Shift-JIS.

-- �y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�w�S�{�剤��AIMS/Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-28 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-28 �S�{�剤

--[[
	[�g����]
	
	�i�P�j���̂R�̃t�@�C�����AGitHub �����ɓ���܂��B
		�E�`/s/csv.lua
		�E�`/s/auto_soundeffects.lua �i���̃t�@�C���j
		�E�`/auto_soundeffects.csv �i�T���v���Ƃ��Ď����Ă����j

	�i�Q�jboot.lua�t�@�C���̒��ŁAprequire����ǉ��E�폜���܂��B
		-------------------------------------------
		-- common�Ăяo��
		-------------------------------------------
		�y�`�����`�z
		--�y�ǉ��z��������--
		prequire("s/csv.lua");
		prequire("s/auto_soundeffects.lua");
		--�y/�ǉ��z�����܂�--
		�y�`�����`�z
		--prequire("s/se.lua"); --������폜�B
		�y�`�㗪�`�z

	�i�R�js/se.lua ���폜���܂��B

	�i�S�j�T�E���h�t�@�C����o�^����CSV���쐬���܂��B
		  �T���v���������Ă����ĉ������邩�A�ꂩ����͂��Ă��������B

		�`/auto_soundeffects.csv

		�i��j
		NO,Expl,VARIABLE,FILE,END
		int,string,string,string,END
		-1,���,.lua�Ŏg���Ƃ��̌��ʉ��n���h�������ϐ�,.exe����̃t�@�C���p�X�B,END
		-1,"Sorry, Encoding of this csv file is Shift-JIS.�i����CSV�t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j",,,END
		0,�v���C���[�V���b�g��,S.pshot,se/pshot.wav,END
		�y�`�����`�z
		EOF,,,,

	�i�T�j�wsuica32�x�̏ꍇ�ł��ƁAs/game_common.lua �̒��� initializer() ��
		���L��ǉ����Ă��������B

		-- �e�평�������[�`������ĂɌĂяo��
		function initializer()
			for index,func in pairs(INITIALIZER_LIST) do
				func();
			end

			--�y���ρz�ǉ��ƍ폜�B��������B
			--�T�E���h�G�t�F�N�g�����[�h���A���̃n���h�����O���[�o���ϐ��uS�v�ɃZ�b�g���܂��B
			auto_SoundeffectsLoad()
			--�y/���ρz�ǉ��ƍ폜�B�����܂ŁB
		end	

	����ŁA�T�E���h�t�@�C���͓Ǎ���������A�O���[�o���ϐ��uS�v��
	�T�E���h�t�@�C���̃n���h�����Z�b�g����Ă��܂��B
	�ȏ�B
]]


function auto_SoundeffectsLoad()

	local csvTable = csv_FromFile( "data/auto_soundeffects.csv" );

	--�S�Ẵf�[�^�����R�[�h�𒲍��E���f�E���s���܂��B
	local hitsRecord
	local rowNum=1
	for number_Row,record in pairs(csvTable) do
		if 4<=rowNum then

			local variable = record["VARIABLE"]
			local file     = record["FILE"]
			
			if ""~=variable and ""~=file then
				--�L���������
				
				local handleSound
				handleSound = loadSound( file );
				auto_GlobalSTableSet( variable, handleSound )
			end
		end
		
		rowNum = rowNum + 1
	end
end

--�O���[�o���ϐ��uS�v�ɒl���Z�b�g���܂��B
function auto_GlobalSTableSet( fieldNamenewtable, valueNew )
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^S%."))then
			error("�֐�auto_GlobalSTableSet�̑������̓��e�́A�擪���uS.�v�łȂ���΂Ȃ�܂���BfieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--���́uS.�v�����B
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--������"ballets"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă��Ȃ��B
			S[fieldNamenewtable] = valueNew
		else
			--������"ballets.base"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă���B
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --�u.�v�ŃX�v���b�g�������ꍇ�́u[.]�v�Ə����B
			
			local tableLastparent --�������Ԗڂ̃e�[�u��
			tableLastparent = S[arrayNode[1]]
			
			local lastParent
			lastParent = #arrayNode - 1

			--�z��̌`�ua[b]�v�ɂ��Ή�����B
			local nameNodeA, nameNodeB, indexB

			--�������㏑���i�w�肳�ꂽ�������Ԗڂ̃e�[�u���Ɉړ����Ă���j�B#arrayNode �́A�Ō�̓Y�����ԍ��Ɠ����B
			for indexNode=2,lastParent,1 do
				nameNodeA = arrayNode[indexNode]
				nameNodeB, indexB = string.match( nameNodeA, "(.+)%s*%[%s*(%d+)%s*%]" )
				if( nil~=nameNodeB and nil~=indexB )then
					tableLastparent[nameNodeB][tonumber(indexB)] = valueNew
				else
					tableLastparent = tableLastparent[nameNodeA]
				end
			end
			
			--�ua[b]�v�Ƃ������z��̌`�����Ă����ꍇ�A�����𕪂���B
			nameNodeA = arrayNode[#arrayNode]
			nameNodeB, indexB = string.match( nameNodeA, "(.+)%s*%[%s*(%d+)%s*%]" )
			if( nil~=nameNodeB and nil~=indexB )then
				tableLastparent[nameNodeB][tonumber(indexB)] = valueNew
			else
				tableLastparent[nameNodeA] = valueNew
			end
			
		end
	else
		--���������w�肳�ꂽ�̂Ŗ����B
	end
end


-- �y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
