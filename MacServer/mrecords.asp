<%
'***************************************************************
'author��liuwt123
'E-mail:liuwt123@gmail.com  liuweitao@haier.com
'http://blog.iscsky.net
'http://weibo.com/liuwt123
'***************************************************************
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="config.asp"-->
<!--#include file="conn.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<base target="main">
<STYLE type="text/css">
a:link       {text-decoration: none; font-family: AdobeSm; color: #000000 }
a:visited    {text-decoration: none; color: #000000 }
A:hover      {COLOR: green; FONT-FAMILY: "����,MingLiU"; TEXT-DECORATION: underline}
body         {font-size: 9pt; font-family: ����,MingLiU, Arial;color: #000000}
TD           {FONT-SIZE: 9pt; FONT-FAMILY: "����,MingLiU, Arial";color: #000000;table-layout:fixed;word-break:break-all}
p            {FONT-SIZE: 9pt; FONT-FAMILY: "����,MingLiU, Arial";color: #000000}
input        {FONT-SIZE: 9pt; FONT-FAMILY: "����,MingLiU, Arial";color: #000000}
body         {
	margin-top: 10px;
	margin-bottom: 0;
	margin-left:0;
	margin-right:0;
	color: #000000;
	background-color: #FFFFFF;
}
select       {FONT-SIZE: 9PT;}
option       {FONT-SIZE: 9pt;}
textarea     {FONT-SIZE: 9pt;}
</STYLE>
<script type='text/javascript'>
	var gatedata = {<%
sql = "select * from mtypes order by ID desc"
Set rs = Server.CreateObject("ADODB.RecordSet")
rs.Open sql,conn,1,1
if rs.recordcount<>0 then
	for i=0 to rs.recordcount
		response.write "'"&rs("ID")&"':{'mtype':'"&rs("mtype")&"','mdes':'"&rs("mdes")&"'},"
		rs.movenext
	next
end if
%>
};
</script>
</head>
<body>
<%
action=trim(request("job"))
dealid=trim(request("ID"))

if action="del" then
	conn.Execute "delete from [mrecords] where ID="&dealid
end if
%>
<div align="center">
<table width="98%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" id="table2" style="border-collapse: collapse;margin-top:4px;">
  <tr>
    <td width="8%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">ID</font></strong></td>
    <td width="18%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">��������</font></strong></td>
    <td width="12%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">MAC</font></strong></td>
    <td width="16%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">��Ȩʹ��</font></strong></td>
    <td width="18%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">��������</font></strong></td>
    <td width="18%" align="center" background="images/bj5.jpg"><strong><font color="#FFFFFF">ɨ��ʱ��</font></strong></td>
    <td width="10%" align="center" background="images/bj5.jpg"><font color="#FFFFFF"><strong>����</strong></font></td>
  </tr>
 <%
sql = "select * from mrecords"
Set rs = Server.CreateObject("ADODB.RecordSet")

dids = "s"
rs.pagesize=100
rs.Open sql,conn,3
page = trim(Request.QueryString("page"))

if len(page) = 0 then
	intpage = 1
	pre = false
else
	if cint(page) =< 1 then
		intpage = 1
		pre = false
	else
		if cint(page) >= rs.PageCount then
			intpage = rs.PageCount
			last = false
		else
			intpage = cint(page)
		end if
	end if
end if
if not rs.eof then
rs.AbsolutePage = intpage
end if
rs.absolutepage=epage

for i=1 to rs.pagesize
	if i mod 2 = 0 then
		tbgcolor = "#EFEFEF"
	else
		tbgcolor = "#FFFFFF"
	end if
	dids = dids & "|" & rs("ID")
%>
<tr bgcolor="<%=tbgcolor%>">
    <td align="center"><%=rs("ID")%></td>
    <td align="center" id="SERN_<%=rs("ID")%>"><%=rs("sern")%></td>
    <td align="center"><%=rs("mac")%></td>
    <td align="center"><%=MacTypes(tmtype)%></td>
    <td align="center"><%=rs("pline")%></td>
    <td align="center"><%=rs("addtime")%></td>
    <td align="center"><a onclick='return confirm(&quot;��ȷ��ɾ����?&quot;)' href="?id=<%=rs("ID")%>&amp;job=del">ɾ��</a></td>
</tr>
<%
	rs.movenext
	if rs.eof then exit for
next
%>
</table>
<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" id="table" style="border-collapse: collapse;margin-top:10px;">
  <tr>
    <td align="right">
ÿҳ <%=rs.PageSize%> ��
<%if rs.pagecount > 0 then%>
	��ǰҳ <%=intpage%>/<%=rs.PageCount%>
<%else%>
	��ǰҳ  0/0
<%end if%>
<a href="?page=1">��ҳ</a>| 
<%if pre then%>
    <a href="?page=<%=intpage -1%>"> ��ҳ </a>| 
<%end if%>
<%if last then%>
    <a href="?page=<%=intpage +1%>"> ��ҳ </a> |
<%end if%>
<a href="?page=<%=rs.PageCount%>">βҳ</a>
ת���� <select name="sel_page" onchange="javascript:location=this.options[this.selectedIndex].value;">
<%
for i = 1 to rs.PageCount
	if i = intpage then%>
        <option value="?page=<%=i%>" selected><%=i%></option>
        <%else%>
        <option value="?page=<%=i%>"><%=i%></option>
        <%
	end if
next
%>
</select> ҳ</td>
  </tr>
</table>
  <%
rs.close
set rs=nothing
conn.close
set conn=nothing
%>
</p>
</body>
</html>