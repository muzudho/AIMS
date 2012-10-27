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
-- �y���ρz�ǉ��B��������B
prequire("s/csv.lua");
prequire("s/auto_sceneChanges.lua");
-- �y/���ρz�ǉ��B�����܂ŁB

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

-------------------------------------------
-- �Q�[���V�[���Ăяo��
-------------------------------------------
--�Q�[���̃V�[���X�N���v�g��prequire���܂��B
-- �y���ρz�ǉ��B��������B
prequire("s/auto_keyconfig.lua");
-- �y/���ρz�ǉ��B�����܂ŁB

-------------------------------------------
-- OnLoad�@�N������ɌĂ΂��
-------------------------------------------
function OnLoad()

end

-------------------------------------------
-- OnStart
-------------------------------------------

-- �y���ρz�ǉ��B��������B
function boot_Nowloading1()
	--�������Ă܂���B
end
-- �y/���ρz�ǉ��B�����܂ŁB

-- �N�������boot�V�[�����Ă΂�܂��B
function boot_OnStart()
	-- �y���ρz�폜�ƒǉ��B��������B
	
	-- ���[�f�B���O�E�X���b�h�́A�P��ȏ�N�����Ă��Ȃ��� isLoaderRunning()��
	-- �����I�����邱�Ƃ�����̂ŁA�_�~�[�ł��N�����Ă������Ƃ��֗��B
	startLoaderThread( "boot_Nowloading1" )

	auto_SceneAt("boot_OnStart");
	-- �y/���ρz�폜�ƒǉ��B�����܂ŁB
end

-------------------------------------------
-- OnStep
-------------------------------------------
function boot_OnStep()
	-- �y����/�z���e���폜�����B
end
-------------------------------------------
-- OnClose
-------------------------------------------
function boot_OnClose()
	-- �y����/�z���e���������폜�����B
	
	cls();
end

-------------------------------------------
-- OnVanish �A�v���I�����O�ɌĂ΂��
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- �O���t�B�b�N�폜
	deleteAllSound(S);	-- �T�E���h�폜
end