--[[

  prototype boot.lua
  �����AIMS�ŐV�K�ɃQ�[�����쐬����ۂ�
  �v���g�^�C�v�ƂȂ�t�@�C���ł��B
  �K���ɏ��������Ă����p���������B

]]

-------------------------------------------
-- common�Ăяo��
-------------------------------------------

-- AIMS�̃t�@�C���͑S��prequire�֐��œǂݍ���ł��������B
-- �r���g�C����require���g���܂����A
-- require�ł̓p�b�P�[�W�t�@�C���̒����X�L�������Ă���܂���B
prequire("common.lua");

-------------------------------------------
-- �萔������
-------------------------------------------

G = {}; -- �O���t�B�b�N�n���h���͂��̉��ɂԂ牺����
S = {}; -- �T�E���h�n���h���͂��̉��ɗ�
A = {}; -- �S�̂��爵�������A�N�^�[�̃n���h���͂��̉���

-- ��������ăe�[�u���̉��ɕ����Ă����ƐF�X�y�ł�

-------------------------------------------
-- ���L�֐��Ăяo��
-------------------------------------------
--�Q�[�����ŋ��L����֐���prequire���܂��B
prequire("s/blank.lua");

-------------------------------------------
-- �Q�[���V�[���Ăяo��
-------------------------------------------
--�Q�[���̃V�[���X�N���v�g��prequire���܂��B

-------------------------------------------
-- OnLoad�@�N������ɌĂ΂��
-------------------------------------------
function OnLoad()

end

-------------------------------------------
-- OnStart
-------------------------------------------
cellHeight = 80 --�P���̏c��

-- �N�������boot�V�[�����Ă΂�܂��B
function boot_OnStart()
	cls(); 
	clearLayerSettings();

	-- 1.�܂��摜��ǂݍ���
	--�g
	G.frame = loadGraphic("gfx/Frame.png");
	--��
	G.face = loadGraphic("gfx/Face.png");
	--�t�H���g
	G.font = createAsciiFont("gfx/font16.png", 16, 16);
	--�A�C�R��
	G.iconsBase = loadGraphic("gfx/IconsBase.png");
	G.icons = {}
	for i=0,7 do
		G.icons[i] = cutGraphic(G.iconsBase,i*20,0,20,20);
	end
	--����
	G.numbersBase = loadGraphic("gfx/NumbersBase.png");
	G.numbers = {}
	for i=0,14 do
		G.numbers[i] = cutGraphic(G.numbersBase,i*20,0,20,20);
	end

	-- 2.�A�N�^�[��\������B
	A.items = {}
	--�g�B������1�h�b�g����Ă���̂� x-1 ���Ē����B
	-- createActor(�O���t�B�b�N�n���h��, X���W, Y���W, ���C���[�ԍ�);
	-- ���C���[�ԍ���0����11�܂ł�12���ŁA�������傫���قǏ�ɂȂ�܂��B
	A.frame = createActor(G.frame, 300-1, 250, 11);
end

-------------------------------------------
-- OnStep
-------------------------------------------
opening = 1
frame = 0
scroll=0
ox=50 --���_x
oy=50
function boot_OnStep()


	--�T�v
	--�y���P�z�ŏ��̂P���10�t���[���҂B
	--�y���Q�z�Q��ڈȍ~�́A130�t���[���Ԋu�ŃX�N���[���̍�蒼�����s���B
	--�@�@�@�E�@�@ 0frame �F�y���R�z�ŉ��i�̃A�N�^�[���폜�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���S�z�A�N�^�[�n���h�����P�i���̋��ɂ��炷�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���T�z�ŏ�i�̃A�N�^�[���i�[����ϐ����N���A�[�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���U�z�ŏ�i�̃A�N�^�[��V�K�쐬�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���V�z���[�o�[��ݒ�B
	--�@�@�@�E 1�` 60frame�F�y���V�z���[�o�[�̐ݒ�ʂ�ɁA�x�~���B
	--�@�@�@�E61�` 70frame�F�y���W�z���[�o�[�̐ݒ�ʂ�ɁA�A�N�^�[���P�i���Ɍ������ăX�N���[�����B
	--�@�@�@�E71�`130frame�F�y���Q�z���[�o�[�̐ݒ�ʂ�ɁA�x�~���B


	remake = 0
	if(opening == 1)then
		if(frame==10)then--�y���P�z
			opening = 0
			remake = 1
		end
	elseif(0==(frame-10)%130)then--�y���Q�z
		remake=1
	end

	if(remake==1)then
		--�y���R�z���60�`74�̃A�N�^�[���폜���܂��B
		for i=60,74 do
			hActor = A.items[i]
			if(isAlive(hActor))then
				vanish(hActor);
			end
			A.items[i] = 0
		end

		--�y���S�z���̃A�N�^�[�n���h�����A���炵�܂��B
		for i=59,0,-1 do
			A.items[i+15] = A.items[i]
		end

		--�y���T�z���炵����ŁA���0�`14����ɂ��܂��B
		--�A�N�^�[��V�K�쐬����O�Ɏ��s���Ȃ��ƁA��ʏ�Ɋ��ɏo�Ă���A�N�^�[�������邱�Ƃ�����܂��B
		for i=14,0,-1 do
			A.items[i] = 0
		end

		--�y���U�z���0�`14�̃A�N�^�[��V�K�쐬���܂��B
		if(2==scroll%5)then
			--��
			i=0
			A.items[i] = createActor( G.face, 90, 90, 10 );
			--���O
			i = i + 1
			A.items[i] = createTextActor( G.font, "��ذ", 180+ox, 18+oy, 10 );
			--�E�ƃA�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[2], 120+ox, 54+oy, 10 );
			--�E�Ɩ�
			i = i + 1
			A.items[i] = createTextActor( G.font, "�γ¶�", 180+ox, 46+oy, 10 );
			--HP
			i = i + 1
			A.items[i] = createActor( G.icons[0], 350+ox, 26+oy, 10 );
			--HP�S�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 390+ox, 26+oy, 10 );
			--HP�\�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[0], 430+ox, 26+oy, 10 );
			--HP��̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[0], 470+ox, 26+oy, 10 );
			--MP
			i = i + 1
			A.items[i] = createActor( G.icons[1], 350+ox, 54+oy, 10 );
			--MP�S�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 390+ox, 54+oy, 10 );
			--MP�\�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 430+ox, 54+oy, 10 );
			--MP��̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[9], 470+ox, 54+oy, 10 );
			--�c��͍폜
			for i=12,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		elseif(1==scroll%5)then
			--����A�C�R��
			i = 0
			A.items[i] = createActor( G.icons[3], 120+ox, 26+oy, 10 );
			--���햼
			i = i + 1
			A.items[i] = createTextActor( G.font, "Խ���ۯ��", 180+ox, 18+oy, 10 );
			--�h��A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[4], 120+ox, 54+oy, 10 );
			--�h�
			i = i + 1
			A.items[i] = createTextActor( G.font, "Խ���۰��", 180+ox, 46+oy, 10 );
			--�c��͍폜
			for i=4,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		elseif(0==scroll%5)then
			--�X�L��1�A�C�R��
			i = 0
			A.items[i] = createActor( G.icons[5], 120+ox, 20+oy, 10 );
			--�X�L��1��
			i = i + 1
			A.items[i] = createTextActor( G.font,"̧���", 180+ox, 12+oy, 10 );
			--MP�A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 20+oy, 10 );
			--MP�\�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 430+ox, 20+oy, 10 );
			--MP��̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[3], 470+ox, 20+oy, 10 );

			--�X�L��2�A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[6], 120+ox, 40+oy, 10 );
			--�X�L��1��
			i = i + 1
			A.items[i] = createTextActor( G.font, "ײ��ݸ�", 180+ox, 32+oy, 10 );
			--MP�A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 40+oy, 10 );
			--MP�\�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 430+ox, 40+oy, 10 );
			--MP��̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[7], 470+ox, 40+oy, 10 );

			--�X�L��3�A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[6], 120+ox, 60+oy, 10 );
			--�X�L��1��
			i = i + 1
			A.items[i] = createTextActor( G.font, "ײ��ݸ�", 180+ox, 52+oy, 10 );
			--MP�A�C�R��
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 60+oy, 10 );
			--MP�\�̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 430+ox, 60+oy, 10 );
			--MP��̈�
			i = i + 1
			A.items[i] = createActor( G.numbers[5], 470+ox, 60+oy, 10 );

		else
			--�S���폜
			for i=0,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		end
		
		--�y���V�z�A�N�^�[�ɁA���[�o�[��ǉ�����B
		--		�E60�t���[����ɃX�^�[�g�B���������i90���j�A���x��8�ɂ���B
		--		�E70�t���[����ɒ�~�B���x��0�ɂ���B
		for i=0,74 do
			hActor = A.items[i]
			if(isAlive(hActor))then
				addMover(hActor, 60-1, 1, MOVER_SETANGLE, 90, 0, 0);--�y���V�z�y���W�z
				addMover(hActor, 60-1, 1, MOVER_SETSPEED,  8, 0, 0);
				addMover(hActor, (60-1)+10, 1, MOVER_SETSPEED,   0, 0, 0);--�y���X�z
			end
		end
		
		scroll = scroll + 1
	end

	frame = frame + 1
end
-------------------------------------------
-- OnClose
-------------------------------------------
function boot_OnClose()
	-- 3.�\�������摜����������
	vanish(A.items);
	
	-- 4.�摜���J������
	deleteGraphic(G.numbersBase);
	deleteGraphic(G.numbers);
	deleteGraphic(G.face);
	deleteGraphic(G.font);
	deleteGraphic(G.iconsBase);
	deleteGraphic(G.icons);

	cls();
end

-------------------------------------------
-- OnVanish �A�v���I�����O�ɌĂ΂��
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- �O���t�B�b�N�폜
	deleteAllSound(S);	-- �T�E���h�폜
end
