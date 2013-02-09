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

-- �N�������boot�V�[�����Ă΂�܂��B
function boot_OnStart()
	cls(); 
	clearLayerSettings();

	-- 1.�܂��摜��ǂݍ���
	G.numbersBase = loadGraphic("gfx/NumbersBase.png");
	G.numbers = {}
	for i=0,14 do
		G.numbers[i] = cutGraphic(G.numbersBase,i*50,0,50,50);
	end
	G.frame = loadGraphic("gfx/Frame.png");

	-- 2.�A�N�^�[��\������B
	-- createActor(�O���t�B�b�N�n���h��, X���W, Y���W, ���C���[�ԍ�);
	-- ���C���[�ԍ���0����11�܂ł�12���ŁA�������傫���قǏ�ɂȂ�܂��B
	A.numbers = {}
	for i=0,14 do
		row = math.floor(i / 3)
		col = i % 3
		A.numbers[i] = createActor(G.numbers[i], col*50+100, row*50+100, 10);
	end
	--�g�B������1�h�b�g����Ă���̂� x-1 ���Ē����B
	A.frame = createActor(G.frame, 1*50+100-1, 2*50+100, 11);
	
	-- �A�N�^�[�ɁA���[�o�[��ǉ�����B60�t���[���Ԃ�u���ăX�^�[�g�B
	for i=0,14 do
		addMover(A.numbers[i], 59, 1, MOVER_SETANGLE, 90, 0, 0);
		addMover(A.numbers[i], 59, 1, MOVER_SETSPEED,  5, 0, 0);
	end
	
	-- �A�N�^�[�ɁA���[�o�[��ǉ�����B10�t���[����A���x�� 0 �ɁB
	for i=0,14 do
		addMover(A.numbers[i], 59+10, 1, MOVER_SETSPEED,   0, 0, 0);
	end

end

-------------------------------------------
-- OnStep
-------------------------------------------
opening = 1
frame = 0
scroll=0
function boot_OnStep()


	--�T�v
	--�y���P�z�ŏ��̂P���10�t���[���҂B
	--�y���Q�z�Q��ڈȍ~�́A130�t���[���Ԋu�ŃX�N���[���̍�蒼�����s���B
	--�@�@�@�E�@�@ 0frame �F�y���R�z�ŉ��i�̃A�N�^�[���폜�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���S�z�A�N�^�[�n���h�����P�i���̋��ɂ��炷�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���T�z�ŏ�i�̃A�N�^�[��V�K�쐬�B
	--�@�@�@�@�@�@�@�@�@�@�F�y���U�z���[�o�[��ݒ�B
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
		--�y���R�z���12,13,14�̃A�N�^�[���폜���܂��B
		for i=12,14 do
			vanish(A.numbers[i]);
		end
		
		--�y���S�z���̃A�N�^�[�n���h�����A���炵�܂��B
		--		���11�̃A�N�^�[�n���h�����A���14�ɓ���܂��B
		--		���10�̃A�N�^�[�n���h�����A���13�ɓ���܂��B
		--		�@�c
		--		���0�̃A�N�^�[�n���h�����A���3�ɓ���܂��B
		for i=11,0,-1 do
			A.numbers[i+3] = A.numbers[i]
		end
		
		--�y���T�z���0,1,2�̃A�N�^�[��V�K�쐬���܂��B
		--		�i�X�N���[���̉񐔁@��]�@5�s�j�~�R�@���@�O��ڂɍ��A�N�^�[
		actorNumber = 12 - scroll%5*3
		for i=0,2 do
			row = 0
			col = i % 3
			A.numbers[i] = createActor(G.numbers[actorNumber], col*50+100, row*50+100, 10);
			actorNumber = actorNumber + 1
		end
		
		--�y���U�z�A�N�^�[�ɁA���[�o�[��ǉ�����B
		--		�E60�t���[����ɃX�^�[�g�B���������i90���j�A���x��5�ɂ���B
		--		�E70�t���[����ɒ�~�B���x��0�ɂ���B
		for i=0,14 do
			addMover(A.numbers[i], 60-1, 1, MOVER_SETANGLE, 90, 0, 0);--�y���V�z�y���W�z
			addMover(A.numbers[i], 60-1, 1, MOVER_SETSPEED,  5, 0, 0);
			addMover(A.numbers[i], (60-1)+10, 1, MOVER_SETSPEED,   0, 0, 0);--�y���X�z
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
	vanish(A.numbers);
	
	-- 4.�摜���J������
	deleteGraphic(G.numbersBase);
	deleteGraphic(G.numbers);

	cls();
end

-------------------------------------------
-- OnVanish �A�v���I�����O�ɌĂ΂��
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- �O���t�B�b�N�폜
	deleteAllSound(S);	-- �T�E���h�폜
end
