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
F = {}; -- �t�H���g�n���h���͂��̉��ɂԂ牺����
S = {}; -- �T�E���h�n���h���͂��̉��ɗ�
A = {}; -- �S�̂��爵�������A�N�^�[�̃n���h���͂��̉���

-- ��������ăe�[�u���̉��ɕ����Ă����ƐF�X�y�ł�

-------------------------------------------
-- ���L�֐��Ăяo��
-------------------------------------------
--�Q�[�����ŋ��L����֐���prequire���܂��B

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
	-- 1.�܂��摜��ǂݍ���
	G.bkground = loadGraphic("gfx/�w�i_�����ᎆ�g�t��.png");
	G.yumemi1   = loadGraphic("gfx/����1.png");
	G.frame1   = loadGraphic("gfx/�gB_400x176.png");
	
	F.font1 = createTextureFont("font/font.lfd", ".png", false);
	
	-- 2.�A�N�^�[��\������B
	-- createActor(�O���t�B�b�N�n���h��, X���W, Y���W, ���C���[�ԍ�);
	-- ���C���[�ԍ���0����11�܂ł�12���ŁA�������傫���قǏ�ɂȂ�܂��B
	A.bkground = createActor(G.bkground, 320,   240,  0);
	A.yumemi1  = createActor(G.yumemi1 , 17*32, 9*32, 10);
	A.frame1   = createActor(G.frame1  ,  7*32, 6*32,  9);
	
	A.msg1 = createTextActor( F.font1, "���ꂪ���b�Z�[�W�E�B���h�E�ˁB", 1.5*32, 4*32, 11 );
end

-------------------------------------------
-- OnStep
-------------------------------------------
function boot_OnStep()
end
-------------------------------------------
-- OnClose
-------------------------------------------
function boot_OnClose()
	-- 3.�\�������摜����������
	vanish(A.bkground);
	vanish(A.yumemi1);
	vanish(A.frame1);
	vanish(A.msg1);
	
	-- 4.�摜���J������
	deleteGraphic(G.yumemi1);
	deleteTextureFont(F.msg1);	-- �t�H���g�폜
	
	cls();
end

-------------------------------------------
-- OnVanish �A�v���I�����O�ɌĂ΂��
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- �O���t�B�b�N�폜
	deleteAllSound(S);	-- �T�E���h�폜
end