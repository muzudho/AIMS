--Sorry, Encoding of this file is Shift-JIS.

-- �y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�w�S�{�剤��AIMS/Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-28 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-28 �S�{�剤


--[[
	[�g����]

	�i�P�j�Q�̗p�r������܂��B
		�p�r�P�F�u�ǂ݁v�Bkeyconfig.csv��ǂݍ���ŁA�{�^���萔���㏑�ύX����B
		�p�r�Q�F�u�����v�B�L�[�R���t�B�O��ʂ��o���Akeyconfig.csv���쐬����B
		
		�����ł́A�p�r�P�ɂ��Đ������܂��B
		�p�r�Q�̃L�[�R���t�B�O��ʂ́AGitHub ������肵�Ă��������B
	
	�i�Q�j���̂R�̃t�@�C�����AGitHub �����ɓ���܂��B
		�E�`/s/csv.lua
		�E�`/s/auto_keyconfig.lua �i���̃t�@�C���j
		�E�`/keyconfig.csv �i�T���v���Ƃ��Ď����Ă����j
	
	�i�R�jAIMSd.lua�i�A�v���P�[�V������.lua�j�t�@�C���́A���L�̉ӏ���ύX���܂��B
	
			-- �v���C���[�l���@�L���f�o�C�X���ɒ������܂��B
			MAXIMUM_PLAYERS = 1;
			MAXIMUM_TRIGGERS = 8; -- �y����/�z2��8
			USE_MOUSE = 0;

			-- 1p �Q�[���p�b�h
			BIND_PAD_1P_TRIG1 = 0;
			BIND_PAD_1P_TRIG2 = 1;
			-- �y���ρz�ǉ������B��������B
			BIND_PAD_1P_TRIG3 = 2; --X
			BIND_PAD_1P_TRIG4 = 3; --Y
			BIND_PAD_1P_TRIG5 = 4; --L
			BIND_PAD_1P_TRIG6 = 5; --R
			BIND_PAD_1P_TRIG7 = 6; --S
			BIND_PAD_1P_TRIG8 = 7; --P
			setJoyBind(0,BUTTON_TRIG3,BIND_PAD_1P_TRIG3);
			setJoyBind(0,BUTTON_TRIG4,BIND_PAD_1P_TRIG4);
			setJoyBind(0,BUTTON_TRIG5,BIND_PAD_1P_TRIG5);
			setJoyBind(0,BUTTON_TRIG6,BIND_PAD_1P_TRIG6);
			setJoyBind(0,BUTTON_TRIG7,BIND_PAD_1P_TRIG7);
			setJoyBind(0,BUTTON_TRIG8,BIND_PAD_1P_TRIG8);
			-- �y/���ρz�ǉ������B�����܂ŁB

		����ŁA�L���ȃ{�^���̐��� 8�ɂȂ�̂ŁAA,B,X,Y,L,R,S,P �܂�
		�Ή��ł��܂��B
		�����ł̕ύX�� user.cfg �ɃL���b�V������Ă���̂�������܂���B
		AIMSd.lua�̓��e��ύX�����̂ɃQ�[���ɉe�����Ȃ��ꍇ�́A
		user.cfg �t�@�C���������Ă݂Ă��������B
	
	�i�S�jcommon.lua �t�@�C���́A���L�̉ӏ��i�قڈ�ԉ��j��ύX���܂��B
	
			-- �����ꂽ�{�^����ID�ɑΉ������������Ԃ��B
			_TRIG = {
					{ BUTTON_UP,	"up"	};
					{ BUTTON_DOWN,	"down"	};
					{ BUTTON_LEFT,	"left"	};
					{ BUTTON_RIGHT,	"right"	};
					{ BUTTON_TRIG1,	"trig1"	};
					{ BUTTON_TRIG2,	"trig2"	};
					{ BUTTON_TRIG3,	"trig3"	};
			-- �y���ρz�ǉ��B��������B
					{ BUTTON_TRIG4,	"trig4"	}; --Y
					{ BUTTON_TRIG5,	"trig5"	}; --L
					{ BUTTON_TRIG6,	"trig6"	}; --R
					{ BUTTON_TRIG7,	"trig7"	}; --S
					{ BUTTON_TRIG8,	"trig8"	}; --P
			-- �y/���ρz�ǉ��B�����܂ŁB
			}

		���Ɏg���̂�������܂��񂪁A�ύX���Ă����Ɩ���ł��傤�B
	
	�i�T�jboot.lua�t�@�C���̒��ɁAprequire����ǉ����܂��B
		-------------------------------------------
		-- common�Ăяo��
		-------------------------------------------
		prequire("common.lua");
		--�y�ǉ��z��������--
		prequire("s/csv.lua");
		prequire("s/auto_keyconfig.lua");
		--�y/�ǉ��z�����܂�--
	
	�i�U�j�L�[�R���t�B�O��ݒ肵��CSV���쐬���܂��B
		  �T���v���������Ă����ĉ������邩�A
		  �L�[�R���t�B�O��ʂ��g���č쐬���Ă��������B

		�`/keyconfig.csv

		NO,Expl,PLAYER,A,B,X,Y,L,R,S,P,END
		int,string,int,int,int,int,int,int,int,int,int,END
		-1,���,�v���C���[�ԍ�1�`,A�{�^�������ԍ�,B�{�^�������ԍ�,X�{�^�������ԍ�,Y�{�^�������ԍ�,L�{�^�������ԍ�,R�{�^�������ԍ�,Select�{�^�������ԍ�,Pause�{�^�������ԍ�,END
		-1,"Sorry, Encoding of this csv file is Shift-JIS.�i����CSV�t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j",,,,,,,,,,END
		0,"1�v���C���[",1,0,1,2,3,4,5,6,7,END
		EOF

	�i�V�j�L�[�R���t�B�O�𔽉f���������^�C�~���O�ŁA���̊֐����Ăяo���Ă��������B

		auto_KeyconfigRead()

		�Ⴆ�΁Aboot.lua �̒��� boot_OnStart �ŌĂяo���܂��B

		����ŁA�L�[�R���t�B�O�����f����܂��B


	[�g���u���V���[�e�B���O]

		�E�L�[�R���t�B�O�������Ȃ��Ȃ�����A
		  AIMSd.lua�i�A�v���P�[�V������.lua�j�t�@�C�����X�V���Ă�����Ȃ������Ƃ��́A
		  user.cfg ���폜����ƒ��邱�Ƃ�����܂����B
		  user.cfg�t�@�C���́AAIMSd.lua�̃L���b�V����������܂���B

		�ȏ�B
]]


KEYCONFIG_state = 0 --���0�u�`�����߂Ă��������v����X�^�[�g�B
KEYCONFIG_physicalButtons = {
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
} --�{�^���ԍ��B
KEYCONFIG_filename = "keyconfig.csv" --�ǂݏ��������t�@�C�����B


function sceneKeyconfig_OnStart()
	-- �܂��摜��ǂݍ���
	G.bg     =     loadGraphic("gfx/sceneKeyconfig.png"); -- �V�[���w�i�摜�Ǎ��݁B
	G.font   = createAsciiFont("gfx/font16.png", 16, 16);

	-- �A�N�^�[��\������B
	-- createActor(�O���t�B�b�N�n���h��, X���W, Y���W, ���C���[�ԍ�);
	A.buttons  = { }
	A.messages = { }
	A.bg = createActor(G.bg, 320, 240,0);

end


function sceneKeyconfig_OnStep()

	--���0�u�`�����߂Ă��������v
	--���1�u�a�����߂Ă��������v
	--���2�u�w�����߂Ă��������v
	--���3�u�x�����߂Ă��������v
	--���4�u�k�����߂Ă��������v
	--���5�u�q�����߂Ă��������v
	--���6�u�r�����߂Ă��������v
	--���7�u�o�����߂Ă��������v
	if( KEYCONFIG_state<=7 )then
		auto_KeyconfigPleasePushButton()

	elseif( 8==KEYCONFIG_state )then
	--���8�u�ݒ��ۑ����܂��v
		auto_KeyconfigWrite();

	elseif( 9==KEYCONFIG_state )then
	--���9�u�E�B���h�E����Ă��������v
	
		local messages = {
			"��ò ��خ�!";
			KEYCONFIG_filename.." � ο�� �ϼ��";
			"�ƶ ���ݦ ��Ĥ ����޳� ļ�Ͻ�";
		}
		
		for i=1,#messages do
			--���W�ʒu�͉�ʂ����Ȃ���C���B
			A.messages[i] = createTextActor(G.font, messages[i], 320-string.len(messages[i])*16/2, (i-1)*32+336, 10 );
		end

		KEYCONFIG_state = KEYCONFIG_state + 1

	elseif( 10==KEYCONFIG_state )then
	--���10�u�����{�^���������ƃE�B���h�E����܂��v

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
		--�{�^��1�`12�B
		local hits = false
		for btnNum=1,12 do

			if( 1==getJoyPressCount( 0, button_trig[btnNum]) )then
				-- �Q�[���p�b�h�̃{�^��N���A�������񗣂��ꂽ��ɉ����ꂽ���B
				hits = true
				break
			end
		end

		if( hits )then
			quit()
		end
	end

	auto_SceneAt("sceneKeyconfig_OnStep");
end


function sceneKeyconfig_OnClose()
	-- �\�������摜����������
	vanish(A.buttons);
	vanish(A.messages);
	vanish(A.bg);

	-- �摜���J������
	deleteGraphic(G.bg);
	deleteGraphic(G.font);

	cls(); -- �V�[�����̑S�A�N�^�[���������܂��B
end


--�ݒ��ۑ����܂��B
function auto_KeyconfigWrite()
	
	out = io.open( KEYCONFIG_filename, "w")

	out:write( "NO,Expl,PLAYER,A,B,X,Y,L,R,S,P,END\n" )
	out:write( "int,string,int,int,int,int,int,int,int,int,int,END\n" )
	out:write( "-1,���,�v���C���[�ԍ�1�`,A�{�^�������ԍ�,B�{�^�������ԍ�,X�{�^�������ԍ�,Y�{�^�������ԍ�,L�{�^�������ԍ�,R�{�^�������ԍ�,Select�{�^�������ԍ�,Pause�{�^�������ԍ�,END\n" )
	out:write( "-1,\"Sorry, Encoding of this csv file is Shift-JIS.�i����CSV�t�@�C����Shift-JIS�G���R�[�f�B���O�ł��B�j\",,,,,,,,,,END\n" )
	out:write( "0,\"1�v���C���[\",1,".. KEYCONFIG_physicalButtons[1] ..",".. KEYCONFIG_physicalButtons[2] ..",".. KEYCONFIG_physicalButtons[3] ..",".. KEYCONFIG_physicalButtons[4] ..",".. KEYCONFIG_physicalButtons[5] ..",".. KEYCONFIG_physicalButtons[6] ..",".. KEYCONFIG_physicalButtons[7] ..",".. KEYCONFIG_physicalButtons[8] ..",END\n" )
	out:write( "EOF" )

	out:close()
	
	KEYCONFIG_state = KEYCONFIG_state + 1
end


--�ݒ��ǂݍ��݂܂��B
function auto_KeyconfigRead()

	local csvTable = csv_FromFile( KEYCONFIG_filename );

	local hitsRecord
	hitsRecord = csv_SelectRecord( csvTable, "PLAYER", "1" )

	if( nil~=hitsRecord )then

		--�f�t�H���g�̃{�^���萔�� common.lua �ɋL�q����Ă��܂��B
		--0�`3�́A�E������B

		local physicalButton
		
		--�_���{�^��1��A�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["A"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG1, physicalButton );
			--debugOut( "A�{�^��(".. BUTTON_TRIG1 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��2��B�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["B"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG2, physicalButton );
			--debugOut( "B�{�^��(".. BUTTON_TRIG2 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��3��X�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["X"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG3, physicalButton );
			--debugOut( "X�{�^��(".. BUTTON_TRIG3 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��4��Y�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["Y"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG4, physicalButton );
			--debugOut( "Y�{�^��(".. BUTTON_TRIG4 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��5��L�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["L"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG5, physicalButton );
			--debugOut( "L�{�^��(".. BUTTON_TRIG5 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��6��R�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["R"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG6, physicalButton );
			--debugOut( "R�{�^��(".. BUTTON_TRIG6 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��7��S�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["S"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG7, physicalButton );
			--debugOut( "S�{�^��(".. BUTTON_TRIG7 ..") = [".. physicalButton .."]" )
		end

		--�_���{�^��8��P�{�^���ƌĂԂƂ��܂��B
		physicalButton = tonumber( hitsRecord["P"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG8, physicalButton );
			--debugOut( "P�{�^��(".. BUTTON_TRIG8 ..") = [".. physicalButton .."]" )
		end

	else
		debugOut( "�L�[�R���t�B�O�ݒ�t�@�C������́A�P�v���C���[�̐ݒ��ǂݍ��߂܂���ł����B" )

	end
end


function auto_KeyconfigPleasePushButton()

	local hitsPhysicalButton = -1 --�����{�^���ԍ��B������Ă��Ȃ���Ε����B

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

	local btnNum=1
	--�{�^��1�`12�B
	for btnNum=1,12 do

		if( 1==getJoyPressCount( 0, button_trig[btnNum]) )then
			-- �Q�[���p�b�h�̃{�^��N���A�������񗣂��ꂽ��ɉ����ꂽ���B
			
			-- ���݉�����Ă���{�^���̕����ԍ����擾����B�����ɉ�����Ă���ꍇ�́A��ԎႢ�ԍ��B
			hitsPhysicalButton = getJoyPhysicalButton()
			break
		end
	end


	
	if( 0 <= hitsPhysicalButton )then
		--���܂����B
		KEYCONFIG_physicalButtons[KEYCONFIG_state+1] = hitsPhysicalButton
		--16x16�T�C�Y�E�t�H���g�̈ʒu�� -8 ��������B
		A.buttons[KEYCONFIG_state+1] = createTextActor(G.font, tostring(hitsPhysicalButton), KEYCONFIG_state*64+103-8, 239-8, 10 );
		KEYCONFIG_state = KEYCONFIG_state + 1
	end
end


-- �y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
