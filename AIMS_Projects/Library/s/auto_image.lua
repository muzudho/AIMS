--Sorry, Encoding of this file is Shift-JIS.

--�y���ρz���̃t�@�C���͐V�K�ɒǉ��B

--�w�S�{�剤��AIMS/Lua���C�u�����[�x
--Copyright (c) 2012, �S�{�剤
--All rights reserved.
--�t�@�C���쐬    �F2012-10-14 �S�{�剤
--�t�@�C���ҏW�ŏI�F2012-10-15 �S�{�剤

--[[
	�g�����B

	�i�P�jboot.lua�́u���L�֐��Ăяo���v���ŁALua�t�@�C����ǂݍ���ł����܂��B
		prequire("s/csv.lua");
		prequire("s/auto_image.lua");
		--���̑��A�摜�f�ރt�@�C���͗p�ӂ���Ă�����̂Ƃ��܂��B

	�i�Q�j�摜CSV���쐬���܂��B

		data/auto_image.csv

		�i��j
		NO,ID,Expl,LOAD_TO_SOURCE,R_TRANSPARENT,G_TRANSPARENT,B_TRANSPARENT,HANDLE_CHIP_SOURCE,HANDLE_CHIP_DESTINATION,STARTINDEX_CHIP_DESTINATION,LEFT_CELL,TOP_CELL,WIDTH_CELL,HEIGHT_CELL,COLUMNS,ROWS,DELAY_ANIME,LOOPPOINT_ANIME,X_SETCENTER,Y_SETCENTER,R_FILL,G_FILL,B_FILL,A_FILL,LEFT_HIT,TOP_HIT,WIDTH_HIT,HEIGHT_HIT,END
		int,string,string,string,int,int,int,string,string,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,END
		-1,auto_ImageAt(...)�̈����ɓn����܂��B���ʂł���Ή��ł��\��Ȃ��B�󔒂܂��́u-1�v������Ɩ�������܂��B�uImg:�v�u;�v�ŋ���ł����ƑS��������u�����₷���B����ID���A�����Ă���ꍇ�A�����Ď��s�����B,�R�����g,�i�������j�摜�t�@�C���p�X�BHANDLE_CHIP_SOURCE�Ŏw�肵���ϐ��ɉ摜�n���h�����������BLOAD_TO_SOURCE�̎w�肪�Ȃ��Ƃ��́AHANDLE_CHIP_SOURCE�͊��ɃZ�b�g����Ă�����̂Ƃ��ė��p�����B,�i�������j���[�h���ɓ����ɂ���F���q�f�a0�`255�Ŏw��ł���B�u�i�󗓁j�v�܂��́u-1�v�Ŗ����B,�i�������j,�i�������j,�i�������E�ҏW���j�摜�n���h���̖��O�B�i���̉摜����؂蔲���j�B�uG.�v�Ŏn�܂邱�ƁB��F�uG.bullets.base�v�ƋL�q�B,�i�������j�؂蔲���ꂽ�摜�̃n���h��������ϐ����B �uG.�v�Ŏn�܂邱�ƁB��F�uG.efx.blast�v�ƋL�q�B,�i�������jHANDLE_CHIP_DESTINATION�Ŏw�肵���ϐ����e�[�u�����������́A���̊J�n�C���f�b�N�X�B,�؂蔲�������̍���x�B,�؂蔲�������̏��y�B,�؂蔲�������̉����B,�؂蔲�������̏c���B,�؂蔲���R�}���E�ɘA������񐔁B�u�i�󗓁j�v�܂��́u-1�v�Ȃ�1�B,�؂蔲���R�}�����ɘA������s���B�u�i�󗓁j�v�܂��́u-1�v�Ȃ�1�B,�A�j���[�V����������ꍇ�A�P�R�}��wait�Ԋu�B�~���b�B�u�i�󗓁j�v�܂��́u-1�v�Ȃ�A�j���[�V�������Ȃ��B,�I�[�̎��͉��R�}�ڂɖ߂邩�B�擪��1�B�u�i�󗓁j�v�܂��́u-1�v�Ȃ烋�[�v���Ȃ��B,��]�A�g�k�̒��S�_��ݒ�B��������_�Ƃ�����W�B�u�i�󗓁j�v�܂��́u-1�v�Ŗ����B�S�Ă̐؂蔲���摜�ɓK������B,,�S�̈���q�f�a�`0�`255�œh��Ԃ��܂��BRGBA�̂S�Ƃ��w�肷��ƗL���ł��B�P�ł��u�i�󗓁j�v�܂��́u-1�v���Ɩ�������܂��B�摜���[�h�̂Ƃ��ɗL���ł��B,,,,�����蔻���ݒ肵�܂��B�S�ݒ肵�Ă���ƗL���ł��B�u�i�󗓁j�v�܂��́u-1�v���w�肷��Ɩ����B,,,,END

		�`�f�[�^�����͑傫���̂ŏЉ���������܂��B

	�i�R�j�摜��؂蔲�������^�C�~���O�ŁA���̊֐����Ăяo���܂��B

		auto_ImageAt( "Img:player_init;" );	--�����̓e�[�u���́uID�v��l�B

	�i�S�j�K�v�ɉ����� auto_ImageAt�֐�����
		local table = csv_FromFile( �` )
		�̕�����\�ߍς܂��� CSV�e�[�u�����O���[�o���ϐ��Ŏ����Ă����� �����̖��ʂ��Ȃ��܂��B

	����ŁA�O���t�@�C���ŉ摜�Ǎ��ݓ��̑�����w��ł��܂��B
	�ȏ�B
]]

--�O���t�@�C���ɐݒ肳��Ă���ʂ�ɁA�摜��p�ӂ��܂��B
--id:���̊֐���u���Ă���֐��̖��O������ƕ֗��ł��B�󔒂܂��́u-1�v�͓���Ȃ��ł��������B
function auto_ImageAt( id )

	--�f�[�^�x�[�X�E�e�[�u���B�\�ߓǂݍ���ŃO���[�o���ϐ��ɓ���Ă������@������B
	local table = csv_FromFile("data/auto_image.csv")

	--���R�[�h
	local hitsRecord
	local continueHits = 0 --�A�����ăq�b�g�������R�[�h��
	local isFinish = false --���[�v��S�������邽�߂̃t���O
	local numberRow = 1
	for numberRowB,record in pairs(table) do
		if 4<=numberRow then					--�ŏ��̂R�s�̓t�B�[���h��`�Ȃ̂œǂݔ�΂��܂��B
			if record["ID"]==id then
				hitsRecord = record
				continueHits = continueHits + 1
				----------------------------------------------------------------
				--���̃��R�[�h�̏����J�n


				local fieldLoadtosource
				fieldLoadtosource = hitsRecord["LOAD_TO_SOURCE"];
				if("-1"==fieldLoadtosource)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldLoadtosource = ""
				end

				local fieldRtransparent
				fieldRtransparent = hitsRecord["R_TRANSPARENT"];
				if("-1"==fieldRtransparent)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldRtransparent = ""
				end

				local fieldGtransparent
				fieldGtransparent = hitsRecord["G_TRANSPARENT"];
				if("-1"==fieldGtransparent)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldGtransparent = ""
				end

				local fieldBtransparent
				fieldBtransparent = hitsRecord["B_TRANSPARENT"];
				if("-1"==fieldBtransparent)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldBtransparent = ""
				end

				local fieldXsetcenter
				fieldXsetcenter = hitsRecord["X_SETCENTER"];
				if(""==fieldXsetcenter)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldXsetcenter = -1
				else
					fieldXsetcenter = tonumber( fieldXsetcenter )
				end

				local fieldYsetcenter
				fieldYsetcenter = hitsRecord["Y_SETCENTER"];
				if(""==fieldYsetcenter)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldYsetcenter = -1
				else
					fieldYsetcenter = tonumber( fieldYsetcenter )
				end

				local fieldRfill
				fieldRfill = hitsRecord["R_FILL"];
				if(""==fieldRfill)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldRfill = -1
				else
					fieldRfill = tonumber( fieldRfill )
				end

				local fieldGfill
				fieldGfill = hitsRecord["G_FILL"];
				if(""==fieldGfill)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldGfill = -1
				else
					fieldGfill = tonumber( fieldGfill )
				end

				local fieldBfill
				fieldBfill = hitsRecord["B_FILL"];
				if(""==fieldBfill)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldBfill = -1
				else
					fieldBfill = tonumber( fieldBfill )
				end

				local fieldAfill
				fieldAfill = hitsRecord["A_FILL"];
				if(""==fieldAfill)then
					--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
					fieldAfill = -1
				else
					fieldAfill = tonumber( fieldAfill )
				end

				local fieldHandlechipsource
				fieldHandlechipsource = hitsRecord["HANDLE_CHIP_SOURCE"];
				if("-1"==fieldHandlechipsource)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldHandlechipsource = ""
				end

				local fieldLeftcell
				fieldLeftcell = hitsRecord["LEFT_CELL"];
				if("-1"==fieldLeftcell)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldLeftcell = ""
				end

				local fieldTopcell
				fieldTopcell = hitsRecord["TOP_CELL"];
				if("-1"==fieldTopcell)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldTopcell = ""
				end

				local fieldWidthcell
				fieldWidthcell = hitsRecord["WIDTH_CELL"];
				if("-1"==fieldWidthcell)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldWidthcell = ""
				end

				local fieldHeightcell
				fieldHeightcell = hitsRecord["HEIGHT_CELL"];
				if("-1"==fieldHeightcell)then
					--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
					fieldHeightcell = ""
				end


				local handleImage
				handleImage = nil

				if(""~=fieldLoadtosource)then
					--���[�h����摜�̃t�@�C���p�X���w�肳��Ă���΁A���[�h���܂��B
					if(
						""~=fieldRtransparent and
						""~=fieldGtransparent and
						""~=fieldBtransparent
					)then
						handleImage = loadGraphic( fieldLoadtosource, tonumber(fieldRtransparent), tonumber(fieldGtransparent), tonumber(fieldBtransparent) )
					else
						handleImage = loadGraphic( fieldLoadtosource )
					end

					if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
						setGraphicCenter( handleImage, fieldXsetcenter, fieldYsetcenter );
					end
				elseif(
					""==fieldLeftcell and
					""==fieldTopcell and
					""~=fieldWidthcell and
					""~=fieldHeightcell
				)then
					--�t�@�C���p�X�̎w�肪�Ȃ��A
					--���W�w����Ȃ��A
					--�T�C�Y�w�肪����΁A�u�����N�摜���쐬���܂��B
					handleImage = createBlankGraphic( tonumber(fieldWidthcell), tonumber(fieldHeightcell) );
				else
					
				end

				if(
					fieldRfill~=-1 and
					fieldGfill~=-1 and
					fieldBfill~=-1 and
					fieldAfill~=-1
				)then
					--�h��Ԃ��̎w�肪����΁A�h��Ԃ��܂��B
					fillGraphic( handleImage, fieldRfill, fieldGfill, fieldBfill, fieldAfill );
				end


				if(nil~=handleImage and ""~=fieldHandlechipsource)then
					--�摜�����[�h���Ă��āA�摜�`�b�v�̕ϐ������w�肳��Ă���ꍇ�A������܂��B
					--�Ⴆ�΁uG.ballets.base = handleImage�v�Ƃ�����������܂��B
					auto_GlobalTableSet( fieldHandlechipsource, handleImage )
				end





				--�����ő傫���������e���ς��܂��B
				if(nil==handleImage)then
					--�摜��ǂݎ���Ă��Ȃ��ꍇ�B

					local fieldHandlechipdestination
					fieldHandlechipdestination = hitsRecord["HANDLE_CHIP_DESTINATION"];
					if("-1"==fieldHandlechipdestination)then
						--�󔒂���сu-1�v�͋󔒈����i���͂𖳂��������ƂɁj�B
						fieldHandlechipdestination = ""
					end

					local fieldStartindexchipdestination
					fieldStartindexchipdestination = hitsRecord["STARTINDEX_CHIP_DESTINATION"];
					if(""==fieldStartindexchipdestination)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldStartindexchipdestination = -1
					else
						fieldStartindexchipdestination = tonumber( fieldStartindexchipdestination )
					end

					--�Ǎ��ݍς� local fieldHandlechipsource

					--�Ǎ��ݍς� local fieldWidthcell

					--�Ǎ��ݍς� local fieldHeightcell

					local fieldColumns
					fieldColumns = hitsRecord["COLUMNS"];
					if("-1"==fieldColumns or ""==fieldColumns)then
						--�󔒂���сu-1�v�� 1 �����B
						fieldColumns = 1
					else
						fieldColumns = tonumber(fieldColumns)
					end

					local fieldRows
					fieldRows = hitsRecord["ROWS"];
					if("-1"==fieldRows or ""==fieldRows)then
						--�󔒂���сu-1�v�� 1 �����B
						fieldRows = 1
					else
						fieldRows = tonumber(fieldRows)
					end

					local fieldDelayanime
					fieldDelayanime = hitsRecord["DELAY_ANIME"];
					if(""==fieldDelayanime)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldDelayanime = -1
					else
						fieldDelayanime = tonumber( fieldDelayanime )
					end

					local fieldLooppointanime
					fieldLooppointanime = hitsRecord["LOOPPOINT_ANIME"];
					if(""==fieldLooppointanime)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldLooppointanime = -1
					else
						fieldLooppointanime = tonumber( fieldLooppointanime )
					end

					local fieldXsetcenter
					fieldXsetcenter = hitsRecord["X_SETCENTER"];
					if(""==fieldXsetcenter)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldXsetcenter = -1
					else
						fieldXsetcenter = tonumber( fieldXsetcenter )
					end

					local fieldYsetcenter
					fieldYsetcenter = hitsRecord["Y_SETCENTER"];
					if(""==fieldYsetcenter)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldYsetcenter = -1
					else
						fieldYsetcenter = tonumber( fieldYsetcenter )
					end

					local fieldLefthit
					fieldLefthit = hitsRecord["LEFT_HIT"];
					if(""==fieldLefthit)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldLefthit = -1
					else
						fieldLefthit = tonumber( fieldLefthit )
					end

					local fieldTophit
					fieldTophit = hitsRecord["TOP_HIT"];
					if(""==fieldTophit)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldTophit = -1
					else
						fieldTophit = tonumber( fieldTophit )
					end

					local fieldWidthhit
					fieldWidthhit = hitsRecord["WIDTH_HIT"];
					if(""==fieldWidthhit)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldWidthhit = -1
					else
						fieldWidthhit = tonumber( fieldWidthhit )
					end

					local fieldHeighthit
					fieldHeighthit = hitsRecord["HEIGHT_HIT"];
					if(""==fieldHeighthit)then
						--�󔒂� -1 �����i���͂𖳂��������ƂɁj�B
						fieldHeighthit = -1
					else
						fieldHeighthit = tonumber( fieldHeighthit )
					end


					--�؂�������̉摜�̃n���h���ɗ��ꂪ�ς��܂��B
					if(""~=fieldHandlechipsource)then
						local handleExists
						handleExists = auto_GlobalTable( fieldHandlechipsource )
						
						if(nil~=handleExists)then
							--�������㏑��
							handleImage = handleExists
						else
							--�������O�̕ϐ����w�肵���ꍇ�B
							--�Ⴆ�΁uG.bullets�v�Ə����Ă��邪�A�k���̏ꍇ�B

							--�e�[�u�����쐬���܂��B
							auto_GlobalTableSet( fieldHandlechipsource, {} )
						end
					end


					local handleImagecrop --�؂����̉摜�̃n���h��
					handleImagecrop = nil

					local indexStart
					indexStart = nil
					
					if(-1~=fieldStartindexchipdestination)then
						--�������㏑��
						indexStart = fieldStartindexchipdestination
					end

					if(
						2 <= fieldColumns or
						2 <= fieldRows
					)then
						--�c�����A�܂��͗����ɕ���ł���ꍇ

						local tableTarget
						tableTarget = auto_GlobalTable( fieldHandlechipdestination )

						if(
							""==fieldLeftcell or
							""==fieldTopcell or
							""==fieldWidthcell or
							""==fieldHeightcell
						)then
							--�L���ɕs��������΁A�������܂��B
						else
							local numberWidth, numberHeight, numberColumns
							numberWidth  = tonumber(fieldWidthcell)
							numberHeight = tonumber(fieldHeightcell)
							numberColumns = fieldColumns
							numberRows = fieldRows

							local last
							last = numberColumns * numberRows

							local index
							index = indexStart
							for current=1,last,1 do
								handleImagecrop = cutGraphic(
									handleImage,
									numberWidth *math.mod  ( current-1               ,numberColumns)+fieldLeftcell,
									numberHeight*math.floor((current-1)/numberColumns              )+fieldTopcell,
									numberWidth,
									numberHeight
									);
								
								if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
									setGraphicCenter( handleImagecrop, fieldXsetcenter, fieldYsetcenter );
								end

								if(-1~=fieldLefthit and -1~=fieldTophit and -1~=fieldWidthhit and -1~=fieldHeighthit)then
									setGraphicHit( handleImagecrop, fieldLefthit, fieldTophit, fieldWidthhit, fieldHeighthit )
								end
								
								tableTarget[index] = handleImagecrop
								index = index + 1
							end
							
							--�A�j���ݒ�
							if( -1~=fieldDelayanime )then
								if( -1~=fieldLooppointanime )then
									setGraphicAnimeLoop( tableTarget, fieldDelayanime, fieldLooppointanime )
								else
									setGraphicAnimeSequence( tableTarget, fieldDelayanime );
								end
							end
						end
					else
						if(
							""==fieldLeftcell or
							""==fieldTopcell or
							""==fieldWidthcell or
							""==fieldHeightcell
						)then
							--�L���ɕs��������΁A�������܂��B
						else
							handleImagecrop = cutGraphic( handleImage, tonumber(fieldLeftcell), tonumber(fieldTopcell), tonumber(fieldWidthcell), tonumber(fieldHeightcell) )
							
							if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
								setGraphicCenter( handleImagecrop, fieldXsetcenter, fieldYsetcenter );
							end
							
							if(-1~=fieldLefthit and -1~=fieldTophit and -1~=fieldWidthhit and -1~=fieldHeighthit)then
								setGraphicHit( handleImagecrop, fieldLefthit, fieldTophit, fieldWidthhit, fieldHeighthit )
							end
						end
						
						if(""~=fieldHandlechipdestination)then
							--�w��̃e�[�u���ɁA�V�����e�[�u����ǉ����܂��B
							--�Ⴆ�Α������̓��e���uballets.base�v�Ȃ�A�uG.ballets.base = handleImage�v�Ƃ�����������܂��B
							auto_GlobalTableSet( fieldHandlechipdestination, handleImagecrop )
						end
					end
				end
				----------------------------------------------------------------
				--���̃��R�[�h��
			elseif(0<continueHits)then
				--�q�b�g���r�؂ꂽ��
				--�����I��
				isFinish = true
				break
			end
		end
		
		numberRow = numberRow + 1
		if(isFinish)then
			--���[�v�E�o
			break
		end
	end
end

--fieldNamenewtable:�uG.efx.blast.base�v�Ƃ������ϐ����B
function auto_GlobalTable( fieldNamenewtable )
	local tableTarget
	
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^G%."))then
			error("�֐�auto_GlobalTable�̑������̓��e�́A�擪���uG.�v�łȂ���΂Ȃ�܂���BfieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--���́uG.�v�����B
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--������"ballets"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă��Ȃ��B
			tableTarget = G[fieldNamenewtable]
		else
			--������"ballets.base"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă���B
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --�u.�v�ŃX�v���b�g�������ꍇ�́u[.]�v�Ə����B
			
			tableTarget = G[arrayNode[1]]
			
			--�������㏑���i�w�肳�ꂽ��ԉ��̃e�[�u���Ɉړ����Ă���j�B#arrayNode �́A�Ō�̓Y�����ԍ��Ɠ����B
			for indexNode=2,#arrayNode,1 do
				tableTarget = tableTarget[arrayNode[indexNode]]
			end
		end
	end

	return tableTarget
end

function auto_GlobalTableSet( fieldNamenewtable, valueNew )
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^G%."))then
			error("�֐�auto_GlobalTable�̑������̓��e�́A�擪���uG.�v�łȂ���΂Ȃ�܂���BfieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--���́uG.�v�����B
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--������"ballets"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă��Ȃ��B
			G[fieldNamenewtable] = valueNew
		else
			--������"ballets.base"�Ƃ������悤�Ȍ`�B�u.�v�ŋ�؂��Ă���B
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --�u.�v�ŃX�v���b�g�������ꍇ�́u[.]�v�Ə����B
			
			local tableLastparent --�������Ԗڂ̃e�[�u��
			tableLastparent = G[arrayNode[1]]
			
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

--�y/���ρz���̃t�@�C���͐V�K�ɒǉ��B
