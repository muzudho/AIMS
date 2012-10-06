--Sorry, Encoding of this file is Shift-JIS.

-- �y���ρz���̃t�@�C���͐V�K�ɒǉ��B�uhttp://lua-users.org/wiki/CsvUtils�v
--�uhttp://symfoware.blog68.fc2.com/blog-entry-455.html�v����R�[�h��
-- �ۂ��ƃR�s�[���ĉ��ӏ������ς����B

-- �t�@�C���쐬    �F2012-09-16 �S�{�剤
-- �t�@�C���ҏW�ŏI�F2012-10-07 �S�{�剤


--[[
	CSV�̃p�[�T�[�ł��B
	���̂Q�Ⴞ���e�X�g���ē����܂����B

	-- ���s��P�F

	local csvTable = csv_FromText(
		"NO,ID,Expl,NAME,END\n" ..
		"int,int,string,string,END\n" ..
		"-1,���ʎq,���,���O,END\n" ..
		"0,1001,\"�e�X�g�f�[�^\",\"��������\",END\n" ..
		"EOF,,,,"
	);

	-- ���s��Q�F �����s��P�̓��e������CSV�t�@�C���udata/sample1.csv�v������Ƃ��܂��B

	local csvTable = csv_FromFile("data/sample1.csv");

	-- ���s��P�E�Q���ʁF

	debugOut("�e�[�u���E�e�L�X�g�̍ŏI=[".. #csvTable .. "]�s"); --�f�o�b�O�o�͂�����̂Ƃ��܂��B
	local number_Textlines = #csvTable
	for number_Textline = 1, number_Textlines do
		debugOut("�e�L�X�g(".. number_Textline .. ")�s��");
		for key,value in pairs(csvTable[number_Textline]) do
			debugOut("�@�@[".. key .. "]=[" .. value .. "]");
		end
	end


	-- ���ʁF

	�e�[�u���E�e�L�X�g�̍ŏI=[5]�s
	�e�L�X�g(1)�s��
	�@�@[END]=[END]
	�@�@[NAME]=[NAME]
	�@�@[NO]=[NO]
	�@�@[Expl]=[Expl]
	�@�@[ID]=[ID]
	�e�L�X�g(2)�s��
	�@�@[END]=[END]
	�@�@[NAME]=[string]
	�@�@[NO]=[int]
	�@�@[Expl]=[string]
	�@�@[ID]=[int]
	�e�L�X�g(3)�s��
	�@�@[END]=[END]
	�@�@[NAME]=[���O]
	�@�@[NO]=[-1]
	�@�@[Expl]=[���]
	�@�@[ID]=[���ʎq]
	�e�L�X�g(4)�s��
	�@�@[END]=[END]
	�@�@[NAME]=[��������]
	�@�@[NO]=[0]
	�@�@[Expl]=[�e�X�g�f�[�^]
	�@�@[ID]=[1001]
	�e�L�X�g(5)�s��
	�@�@[END]=[]
	�@�@[NAME]=[]
	�@�@[NO]=[EOF]
	�@�@[Expl]=[]
	�@�@[ID]=[]
]]


--http://symfoware.blog68.fc2.com/blog-entry-455.html
--�T���v���R�[�h�����������܂����B
--Lua�p��split���W���ɖ��������Ƃ̂��Ƃ� http://lua-users.org/wiki/SplitJoin ��
--�Q�l�Ɏ��삵���֐���Y��Ȃ��悤�ɏ����������Ƃ̂��Ƃł��B
--�u���O�̃R�����g���ɂė��p�E�Ĕz�z�̎�|��`���܂��āA�������������܂����B
-- split�֐�
function csv_Split(str, delim)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end

    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local lastPos
    for part, pos in string.gfind(str, pat) do
        table.insert(result, part)
        lastPos = pos
    end
    table.insert(result, string.sub(str, lastPos))
    return result
end



--http://lua-users.org/wiki/CsvUtils
--"share code/ideas/links, and collaborate with other users."�Ƃ̂��Ƃ�
--���������܂����B
-- Escape CSV quotes
-- Used to escape "'s by csv_toCSV
function csv_EscapeCSV (s)
  if string.find(s, '[,"]') then
    s = '"' .. string.gsub(s, '"', '""') .. '"'
  end
  return s
end


-- Convert from CSV string to table

--http://lua-users.org/wiki/CsvUtils
--"share code/ideas/links, and collaborate with other users."�Ƃ̂��Ƃ�
--���������܂����B
-- ����s�c�P�s�ɂȂ��Ă���CSV�Ƃ���B
-- Convert from CSV string to table (converts a single line of a CSV file)
function csv_FromLine (s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      table.insert(t, (string.gsub(f, '""', '"')))
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti-1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end


--http://lua-users.org/wiki/CsvUtils
--�����ɉ��ρB
--�A�z�z��̓Y�����ɁA�t�B�[���h�������܂��B
--"share code/ideas/links, and collaborate with other users."�Ƃ̂��Ƃ�
--���������܂����B
-- ����fieldnames�c�t�B�[���h���̔z��
-- ����s�c�P�s�ɂȂ��Ă���CSV�Ƃ���B
-- Convert from CSV string to table (converts a single line of a CSV file)
function csv_FromDataline (fieldnames, s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  local fieldname
  local column = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      fieldname = fieldnames[column]
      if fieldname ~= nil then
	      t[fieldname] = string.gsub(f, '""', '"')
      else
	      table.insert(t, (string.gsub(f, '""', '"')))
      end
      column = column + 1
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      fieldname = fieldnames[column]
      if fieldname ~= nil then
	      t[fieldname] = string.sub(s, fieldstart, nexti-1)
      else
	      table.insert(t, string.sub(s, fieldstart, nexti-1))
      end
      column = column + 1
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end

-- Convert from table to CSV string

--http://lua-users.org/wiki/CsvUtils
--"share code/ideas/links, and collaborate with other users."�Ƃ̂��Ƃ�
--���������܂����B
-- ����tt�c�P�s���̃e�[�u���Ƃ���B
-- Convert from table to CSV string
function csv_ToCsvLine (tt)
  local s = ""
  for _,p in pairs(tt) do
    s = s .. "," .. csv_EscapeCSV(p)
  end
  return string.sub(s, 2)      -- remove first comma
end


--����
function csv_CreateTable(csvRows)
	local t = {}
	local rowNum = 1

	--�擪�s�̓t�B�[���h���B
	local fieldnames = csv_FromLine( csvRows[1] )
--	debugOut("��fieldnames=[".. fieldnames .."]")
--	for key,value in pairs(fieldnames) do
--		debugOut("fieldnames=[".. key .."][" .. value .. "]")
--	end

	for key,value in pairs(csvRows) do
		t[rowNum] = csv_FromDataline(fieldnames, value)
		rowNum = rowNum + 1
		--debugOut("[".. key .."]=[".. value .. "]  �e�[�u���̃T�C�Y=[".. #t .. "]�s")
	end

	return t
end


--����
function csv_FromText (s)

	local t = {}
	local csvRows = csv_Split(s,"\n")

	t = csv_CreateTable(csvRows);

	return t;
end


--����
function csv_FromFile (filename)

	local t = {}
	local csvRows = {}
	local rowNum = 1
	
	--CSV�t�@�C�����J���܂��B
	f = io.open(filename, "r")
	--��s���e�L�X�g�t�@�C����ǂݍ��݂܂��B
	for line in f:lines() do
--		debugOut("�t�@�C���ǎ�line=[".. line .. "]")
	    csvRows[rowNum] = line
		rowNum = rowNum + 1
	end
	--�g���I�������t�@�C������܂��B
	f:close()

	t = csv_CreateTable(csvRows);

	return t
end


-- �y/���ρz���̃t�@�C���͐V�K�ɒǉ��B�uhttp://lua-users.org/wiki/CsvUtils�v
--�uhttp://symfoware.blog68.fc2.com/blog-entry-455.html�v����R�[�h��
-- �ۂ��ƃR�s�[���ĉ��ӏ������ς����B
