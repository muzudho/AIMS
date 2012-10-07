--Sorry, Encoding of this file is Shift-JIS.

--�y���ρz���̃t�@�C���͐V�K�ɒǉ��BA.I.M.S�T���v���wsuica32�x��
--�us/chr/enemy_gen.lua�v�����ɉ��ς����B

--�w�S�{�剤��Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-08 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-08 �S�{�剤


--------------------------------------------------------------------------------
-- ��`�萔�ꗗ�i�T���v���j

-- �Q�[���萔

	--[[
		����
			��ʃT�C�Y���c�i640x480 pixel�j
			��ʂ̉����̒��� 320px
			�Q�[���\���̈�̉����i���[�̍��������ɋ��܂ꂽ�Ƃ���j 360px
			�Q�[���\���̈�̍��ӂƉE��X 140,500
			�Q�[����ʏ���̃U�R�G�o�����C��Y�i�T���v���j 32
			�Q�[����ʏ���̃{�X�G�o�����C��Y�i�T���v���j 1
			�U�R�G��������o�Ă���Ƃ��̏o�����C��Y�i�T���v���j 0�`450
	]]

--[[common.lua�ɃJ�b�g���y�[�X�g���Ă��������B
GAME_LEFT  = 140				-- �Q�[����ʂ̍���x

SCOREBASE_ZAKO = 150		-- �ʏ�U�R�̊�b�_��
SCOREBASE_ZAKOHOMING = 100	-- ���@�ǔ��U�R�̊�b�_��
SCOREBASE_LAZER = 700		-- ���[�U�[�U�R�̊�b�_��
SCOREBASE_BOSS = 5000		-- �{�X�̊�b�_��
]]
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- �G�����X���b�h 
--------------------------------------------------------------------------------

--[[
	�g�����B
	
	�i�P�j
		�Es/chr/enemy.lua����
			prequire("s/chr/enemy_gen.lua"); -- �G�����X���b�h
		���폜���܂��B
		
		�Es/chr/enemy_gen.lua �t�@�C�����̂��폜���܂��B
		
		�Eboot.lua��
			prequire("s/scene/game_sub.lua");
		��ǉ����܂��B���̃t�@�C���ł��B
		
		�E���̃t�@�C���� s/scene/game_sub.lua �Ƃ��Ĕz�u���܂��B

	�i�Q�jcommon.lua�ɁA
		���̃t�@�C���̏㕔�ŃR�����g�A�E�g���Ă���Q�[���萔��؂����āA
		�\��t���Ă��������B
	
	�i�R�jgame_init()�̒���
			G.csvTable_EnemyAppear = csv_FromFile("data/enemyAppear.csv");
		�������Ă��������B

	�i�S�jdata/enemyAppear.csv ���쐬���Ă��������B
	
		�i���g�̗�j
		NO,ID,Expl,REPEAT_CONTROL,REPEAT_LABEL,REPEAT_TIME,MOD_LEVEL,PROGRAM,WAIT,INTERVAL_BASE,INTERVAL_MAXHANDYCAP,NAME_FUNC,LIFE,X_MIN,X_MAX,Y_MIN,Y_MAX,SCORE_BASE,END
		int,string,string,string,,int,int,string,int,int,int,string,int,string,string,string,string,string,END
		-1,���ʎq,�R�����g,�J��Ԃ��̐���,�J��Ԃ��̖��O,�J��Ԃ��񐔁B�󔒂܂���-1�͖����B,���x��5���ɏo��Ȃ�u5�v,�uBoss�v�Ȃ�{�X�o��B,frame��,�Ԋuframe�iINTERVAL_BASE��INTERVAL_MAXHANDYCAP�͗����ݒ肷��ƗL���j,�Ԋuframe,�֐��i�V�[���j��,���C�t,�o���ʒux�ō��i�Q�[���̈�360px���A���ӂ�0�Ƃ���j,�o���ʒux�ŉE�i�Q�[���̈�360px���A���ӂ�0�Ƃ���j,�o���ʒuy�ŏ�,�o���ʒuy�ŉ�,�X�R�A��b�_,END
		-1,,NO��́A1����̘A�Ԃ�r�؂�Ȃ��悤�ɂ��Ă��������B,,,,,,,,,,,,,,,,END
		0,,NO��0�̍s�͌��ԁB,,,,,,,,,,,,,,,,END
		1,,�ʏ�U�R3�Z�b�g�i1�Z�b�g4�C�j,Begin,zako1,3,,,,,,,,,,,,,END
		2,,�ォ��2�C�B,,,,,,,,,zako,1,0,360,32,,SCOREBASE_ZAKO,END
		3,,,,,,,,,,,zako,1,0,360,32,,SCOREBASE_ZAKO,END
		4,,�Ԋu,,,,,,,80,70,,,,,,,,END
		5,,������,,,,,,,,,zako,1,0,,0,450,SCOREBASE_ZAKO,END
		6,,�E����,,,,,,,,,zako,1,360,,0,450,SCOREBASE_ZAKO,END
		7,,�Ԋu,,,,,,,80,70,,,,,,,,END
		8,,,End,zako1,,,,,,,,,,,,,,END
		9,,���@�ǔ��͉�����2�C�����B2�Z�b�g�B,Begin,zako_homing1,2,,,,,,,,,,,,,END
		10,,������,,,,,,,,,zako_homing,1,0,,0,360,SCOREBASE_ZAKOHOMING,END
		11,,,,,,,,,80,75,,,,,,,,END
		12,,�E����,,,,,,,,,zako_homing,1,360,,0,360,SCOREBASE_ZAKOHOMING,END
		13,,,,,,,,,80,75,,,,,,,,END
		14,,,End,zako_homing1,,,,,,,,,,,,,,END
		15,,�ォ�烌�[�U�[1�C�B3�Z�b�g�B,Begin,zako_laser1,3,,,,,,,,,,,,,END
		16,,,,,,,,,,,zako_laser,40,0,360,32,,SCOREBASE_LAZER,END
		17,,�Ԋu,,,,,,,120,115,,,,,,,,END
		18,,,End,zako_laser1,,,,,,,,,,,,,,END
		19,,Lv5���Ƀ{�X�o��,,,,5,Boss,,,,boss,800,180,,1,,SCOREBASE_BOSS,END
		20,,,Finish,,,,,,,,,,,,,,,END
		EOF,,,,,,,,,,,,,,,,,,

	�ȏ�B


	�������Bdata/enemyAppear.csv

	�i�P�j�T�v

		����CSV�t�@�C���ɂ́A�G�̏o���p�^�[���̂P�Z�b�g��ݒ肵�܂��B
		�Q�[���́A���̂P�Z�b�g�̌J��Ԃ��ł��B
		�P�Z�b�g�I���ƃ��x�����P�����܂��B

	�i�Q�j���[�v�̊J�n�ƏI��

		REPEAT_CONTROL  |  REPEAT_LABEL  |  REPEAT_TIME
		----------------+----------------+-------------
		Begin           |  zako1         |  3
		----------------+----------------+-------------
		    �`�����Ƀ��[�v�̓��e�������`
		----------------+----------------+-------------
		End             |  zako1         |

		Begin�̓��[�v�̎n�[�s�B���O�iREPEAT_LABEL�j��t����End�ƑΉ�������B
		End�̓��[�v�̏I�[�s�B
		REPEAT_TIME�͌J��Ԃ��񐔁B

	�i�R�j���x������]
		MOD_LEVEL  |  PROGRAM
		-----------+-----------
		5          |  Boss

		���݃��x�����T�Ŋ���؂�鎞�Ƀ{�X���o�Ă���Ƃ����ݒ�ɂȂ�܂��B

	�i�S�j�E�F�C�g
		WAIT  |
		------+--
		60    |

		60�t���[���̊Ԋu���󂯂܂��B

	�i�T�j�C���^�[�o��
		INTERVAL_BASE  |  INTERVAL_MAXHANDYCAP
		---------------+------------------------
		80             |  70

		if ���݃��x��*3 < INTERVAL_MAXHANDYCAP then
			wait( INTERVAL_BASE - math.floor(���݃��x��*3) )
		else
			wait( INTERVAL_BASE - INTERVAL_MAXHANDYCAP )
		end
		�Ƃ������ɂȂ��Ă��܂��B

	�i�U�j�G�o��
		NAME_FUNC  |  LIFE  |  X_MIN  |  X_MAX  |  Y_MIN  |  Y_MAX  |  SCORE_BASE
		-----------+--------+---------+---------+---------+---------+------------------
		zako       |  1     |  0      |  360    |  32     |         |  SCOREBASE_ZAKO

		�ENAME_FUNC�� .lua �ŗp�ӂ����֐����i�V�[�����j�ł��B
		�ELIFE �͓G�̑ϋv�͂ł��B
		�EX_MIN�AX_MAX�� x���W�ł��B�Q�[���̈�́A�f���\���̈�̍��ӂ�0�Ƃ��āA 0�`360�B
			X_MAX�͏ȗ��ł��܂��B�i�󔒂܂���-1�ŏȗ������j
			X_MAX���L�q����ƁAX_MIN�`X_MAX�̒��ł̃����_���l�ɂȂ�܂��B
		�EY_MIN�AY_MAX�� y���W�ł��B�Q�[���̈�́A�f���\���̈�̏�ӂ�0�Ƃ��āA 0�`480�B
			Y_MAX�͏ȗ��ł��܂��B�i�󔒂܂���-1�ŏȗ������j
			Y_MAX���L�q����ƁAY_MIN�`Y_MAX�̒��ł̃����_���l�ɂȂ�܂��B
		�ESCORE_BASE�́A�X�R�A�v�Z�̊�b�l�B
			SCORE_BASE * ( ���݃��x�� + 1 )
			�萔�͂S�B
				�ESCOREBASE_ZAKO		 150
				�ESCOREBASE_ZAKOHOMING	 100
				�ESCOREBASE_LAZER		 700
				�ESCOREBASE_BOSS		5000
			���l�̒��ړ��͂��ł��܂��B

	�i�V�jNO
		NO    |  ID
		------+------
		1     |

		NO��l�� 1 ���� +1 �����łȂ����Ă��镔�����L���ł��B
		�r�؂�Ă���ƏI�����܂��B
		ID��͎g���܂���B

	�ȏ�B

]]

--
function thread_enemy()
	
	wait( calc_intervalframe( 50, 25 ) )
	
	-- ���x���́A���A���^�C���ɍŐV�l���擾���邽�߂ɁA����A�֐���p���܂��B

	-- ���Z�b�g
	local number_EnemyAppear_CurrentNo = 1
	local numberTable_EnemyAppear_LoopCounts = {}
	local numberTable_EnemyAppear_LoopLimits = {}

	local hitsRecord
	hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )

	while(nil~=hitsRecord)do
		local repeatControl = hitsRecord["REPEAT_CONTROL"]
		local repeatLabel = hitsRecord["REPEAT_LABEL"]
		local repeatTime = hitsRecord["REPEAT_TIME"]
		
		if("Begin"==repeatControl)then
			numberTable_EnemyAppear_LoopCounts[repeatLabel] = 0
			numberTable_EnemyAppear_LoopLimits[repeatLabel] = tonumber(repeatTime)
			
			--NO��i�߁A���̃��R�[�h��ǂݎ��܂��B
			number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
			hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
		elseif("End"==repeatControl)then
			--���[�v�J�E���g��1���₷�B
			numberTable_EnemyAppear_LoopCounts[repeatLabel] = numberTable_EnemyAppear_LoopCounts[repeatLabel] + 1
			if( numberTable_EnemyAppear_LoopCounts[repeatLabel] < numberTable_EnemyAppear_LoopLimits[repeatLabel] )then
				--�J�[�\���������߂��ă��R�[�h��ǂݎ��A�����NO��i�߁A���̃��R�[�h��ǂݎ��܂��B
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "REPEAT_LABEL", repeatLabel )
				number_EnemyAppear_CurrentNo = tonumber(hitsRecord["NO"]) + 1
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
			else
				--�J��Ԃ��𔲂��܂��B
				--NO��i�߁A���̃��R�[�h��ǂݎ��܂��B
				number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
			end
		else
			local modLevel = hitsRecord["MOD_LEVEL"]
			local executable = false
			if ( ""~=modLevel and "-1"~=modLevel ) then
				--MOD_LEVEL�ɓ��͂�����ꍇ�B
				if( mod(getLevel(),tonumber(modLevel))==0 )then
					--����؂��ꍇ�̂ݏ��������s�B
					executable = true
				end
			else
				--MOD_LEVEL���󗓂܂��́u-1�v�̏ꍇ�B
				executable = true
			end

			if( executable )then
				local waitframe = hitsRecord["WAIT"]
				if( ""~=waitframe and "-1"~=waitframe )then
					--���͂������
					wait( tonumber(waitframe) )
				end

				local intervalBase  = hitsRecord["INTERVAL_BASE"]
				local intervalMaxhandycap = hitsRecord["INTERVAL_MAXHANDYCAP"]
				if( ""~=intervalBase and "-1"~=intervalBase and ""~=intervalMaxhandycap and "-1"~=intervalMaxhandycap )then
					wait( calc_intervalframe( tonumber(intervalBase), tonumber(intervalMaxhandycap) ) )
				end
				
				local name_Func  = hitsRecord["NAME_FUNC"]
				if( ""~=name_Func and "-1"~=name_Func )then
					--�G�o��
					local life  	= hitsRecord["LIFE"]
					local xMin  	= hitsRecord["X_MIN"]
					local xMax  	= hitsRecord["X_MAX"]
					local yMin  	= hitsRecord["Y_MIN"]
					local yMax  	= hitsRecord["Y_MAX"]
					local scoreBase = hitsRecord["SCORE_BASE"]
					
					local x, y
					if( ""~=xMax and "-1"~=xMax )then
						--�ő�l�̓��͂������
						x = GAME_LEFT + randMT( tonumber(xMin), tonumber(xMax) )
					else
						x = GAME_LEFT + tonumber(xMin)
					end

					if( ""~=yMax and "-1"~=yMax )then
						--�ő�l�̓��͂������
						y = randMT( tonumber(yMin), tonumber(yMax) )
					else
						y = tonumber(yMin)
					end
					
					if( "SCOREBASE_ZAKO" == scoreBase)then
						scoreBase = SCOREBASE_ZAKO
					elseif( "SCOREBASE_ZAKOHOMING" == scoreBase)then
						scoreBase = SCOREBASE_ZAKOHOMING
					elseif( "SCOREBASE_LAZER" == scoreBase)then
						scoreBase = SCOREBASE_LAZER
					elseif( "SCOREBASE_BOSS" == scoreBase)then
						scoreBase = SCOREBASE_BOSS
					else
						scoreBase = tonumber(scoreBase)
					end
					
					createEnemy( G.suika_walkdown[1], x, y, life, scoreBase*(getLevel()+1), name_Func )
				end
			
				local program = hitsRecord["PROGRAM"]
				if( "Boss"==program )then
					--�{�X�̏���������B
					wait(1)
					for i = 1,calc_intervalframe( 30, 25 ),1 do -- �{�X�ׂ̈ɍő剽�b�X���b�h��҂����邩�B�{�X�����j���ꂽ�玟�Ɉڂ�B
						if isAlive(A.boss) then
							wait(60)
						end
					end
					BOSS_PATTERN = BOSS_PATTERN + 1 -- �{�X�p�^�[������
				end
			end
			
			--NO��i�߁A���̃��R�[�h��ǂݎ��܂��B
			number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
			hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
		end
	end


	-- �G�X���b�h1���[�v���̏���
	setgv(0,1,getLevel()+1) -- LEVEL����
	SCORE_SHOTHIT = 10*getLevel() -- �����x���̑ł����ݓ_����
	if( mod(getLevel(),10)==1 )then
		local idx = 1 + mod(math.floor(getLevel()/10),3);
		addMover( A.bg,  0, 16, MOVER_ADDALPHA, -16 );
		addMover( A.bg, 16,  1, MOVER_SETFACE,  G.game.bg[idx] );
		addMover( A.bg, 16, 16, MOVER_ADDALPHA,  16 );
	end
end

--[[
	�G�̏o���Ԋu(frame)�B
	level: ���݃��x��������B
	limit: �����̌��E�l�B
]]
function calc_intervalframe( frame_base, limit)
	local rank_inc = 3
	local level = getLevel()
	if level*rank_inc < limit then
		return frame_base - math.floor(level*rank_inc)
	else
		return frame_base - limit
	end
end

--�y/���ρz���̃t�@�C���͐V�K�ɒǉ��BA.I.M.S�T���v���wsuica32�x��
--�us/chr/enemy_gen.lua�v�����ɉ��ς����B
