--Sorry, Encoding of this file is Shift-JIS.

-- 【改変】このファイルは新規に追加。「http://lua-users.org/wiki/CsvUtils」
--「http://symfoware.blog68.fc2.com/blog-entry-455.html」からコードを
-- 丸ごとコピーして何箇所か改変した。

-- ファイル作成    ：2012-09-16 鬼畜大王
-- ファイル編集最終：2012-10-07 鬼畜大王


--[[
	CSVのパーサーです。
	下の２例だけテストして動きました。

	-- 実行例１：

	local csvTable = csv_FromText(
		"NO,ID,Expl,NAME,END\n" ..
		"int,int,string,string,END\n" ..
		"-1,識別子,解説,名前,END\n" ..
		"0,1001,\"テストデータ\",\"ああああ\",END\n" ..
		"EOF,,,,"
	);

	-- 実行例２： ※実行例１の内容を持つCSVファイル「data/sample1.csv」があるとします。

	local csvTable = csv_FromFile("data/sample1.csv");

	-- 実行例１・２共通：

	debugOut("テーブル・テキストの最終=[".. #csvTable .. "]行"); --デバッグ出力するものとします。
	local number_Textlines = #csvTable
	for number_Textline = 1, number_Textlines do
		debugOut("テキスト(".. number_Textline .. ")行目");
		for key,value in pairs(csvTable[number_Textline]) do
			debugOut("　　[".. key .. "]=[" .. value .. "]");
		end
	end


	-- 結果：

	テーブル・テキストの最終=[5]行
	テキスト(1)行目
	　　[END]=[END]
	　　[NAME]=[NAME]
	　　[NO]=[NO]
	　　[Expl]=[Expl]
	　　[ID]=[ID]
	テキスト(2)行目
	　　[END]=[END]
	　　[NAME]=[string]
	　　[NO]=[int]
	　　[Expl]=[string]
	　　[ID]=[int]
	テキスト(3)行目
	　　[END]=[END]
	　　[NAME]=[名前]
	　　[NO]=[-1]
	　　[Expl]=[解説]
	　　[ID]=[識別子]
	テキスト(4)行目
	　　[END]=[END]
	　　[NAME]=[ああああ]
	　　[NO]=[0]
	　　[Expl]=[テストデータ]
	　　[ID]=[1001]
	テキスト(5)行目
	　　[END]=[]
	　　[NAME]=[]
	　　[NO]=[EOF]
	　　[Expl]=[]
	　　[ID]=[]
]]


--http://symfoware.blog68.fc2.com/blog-entry-455.html
--サンプルコードをいただきました。
--Lua用のsplitが標準に無かったとのことで http://lua-users.org/wiki/SplitJoin を
--参考に自作した関数を忘れないように書いたメモとのことです。
--ブログのコメント欄にて利用・再配布の主旨を伝えまして、許可をいただきました。
-- split関数
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
--"share code/ideas/links, and collaborate with other users."とのことで
--いただきました。
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
--"share code/ideas/links, and collaborate with other users."とのことで
--いただきました。
-- 引数s…１行になっているCSVとする。
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
--を元に改変。
--連想配列の添え字に、フィールド名を入れます。
--"share code/ideas/links, and collaborate with other users."とのことで
--いただきました。
-- 引数fieldnames…フィールド名の配列
-- 引数s…１行になっているCSVとする。
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
--"share code/ideas/links, and collaborate with other users."とのことで
--いただきました。
-- 引数tt…１行分のテーブルとする。
-- Convert from table to CSV string
function csv_ToCsvLine (tt)
  local s = ""
  for _,p in pairs(tt) do
    s = s .. "," .. csv_EscapeCSV(p)
  end
  return string.sub(s, 2)      -- remove first comma
end


--自作
function csv_CreateTable(csvRows)
	local t = {}
	local rowNum = 1

	--先頭行はフィールド名。
	local fieldnames = csv_FromLine( csvRows[1] )
--	debugOut("★fieldnames=[".. fieldnames .."]")
--	for key,value in pairs(fieldnames) do
--		debugOut("fieldnames=[".. key .."][" .. value .. "]")
--	end

	for key,value in pairs(csvRows) do
		t[rowNum] = csv_FromDataline(fieldnames, value)
		rowNum = rowNum + 1
		--debugOut("[".. key .."]=[".. value .. "]  テーブルのサイズ=[".. #t .. "]行")
	end

	return t
end


--自作
function csv_FromText (s)

	local t = {}
	local csvRows = csv_Split(s,"\n")

	t = csv_CreateTable(csvRows);

	return t;
end


--自作
function csv_FromFile (filename)

	local t = {}
	local csvRows = {}
	local rowNum = 1
	
	--CSVファイルを開きます。
	f = io.open(filename, "r")
	--一行ずつテキストファイルを読み込みます。
	for line in f:lines() do
--		debugOut("ファイル読取line=[".. line .. "]")
	    csvRows[rowNum] = line
		rowNum = rowNum + 1
	end
	--使い終わったらファイルを閉じます。
	f:close()

	t = csv_CreateTable(csvRows);

	return t
end


-- 【/改変】このファイルは新規に追加。「http://lua-users.org/wiki/CsvUtils」
--「http://symfoware.blog68.fc2.com/blog-entry-455.html」からコードを
-- 丸ごとコピーして何箇所か改変した。
