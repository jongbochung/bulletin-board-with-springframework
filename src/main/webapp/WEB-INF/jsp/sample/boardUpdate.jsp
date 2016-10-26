<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
    <form id="frm" name="frm" enctype="multipart/form-data">
        <table class="board_view">
            <colgroup>
                <col width="15%"/>
                <col width="35%"/>
                <col width="15%"/>
                <col width="35%"/>
            </colgroup>
            <caption>FORM</caption>
            <tbody>
                <tr>
                    <th scope="row">SEQ</th>
                    <td>
                        ${map.IDX }
                        <input type="hidden" id="IDX" name="IDX" value="${map.IDX }">
                    </td>
                    <th scope="row">HITS</th>
                    <td>${map.HIT_CNT }</td>
                </tr>
                <tr>
                    <th scope="row">WRITER</th>
                    <td>${map.CREA_ID }</td>
                    <th scope="row">DATE</th>
                    <td>${map.CREA_DTM }</td>
                </tr>
                <tr>
                    <th scope="row">TITLE</th>
                    <td colspan="3">
                        <input type="text" id="TITLE" name="TITLE" class="wdp_90" value="${map.TITLE }"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="view_text">
                        <textarea rows="20" cols="100" title="content" id="CONTENTS" name="CONTENTS">${map.CONTENTS }</textarea>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Attached File</th>
                    <td colspan="3">
                        <div id="fileDiv">                
                            <c:forEach var="row" items="${list }" varStatus="var">
                                <p>
                                    <input type="hidden" id="IDX" name="IDX_${var.index }" value="${row.IDX }">
                                    <a href="#this" id="name_${var.index }" name="name_${var.index }">${row.ORIGINAL_FILE_NAME }</a>
                                    <input type="file" id="file_${var.index }" name="file_${var.index }"> 
                                    (${row.FILE_SIZE }kb)
                                    <a href="#this" class="btn" id="delete_${var.index }" name="delete_${var.index }">DELETE</a>
                                </p>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
     
    <a href="#this" class="btn" id="addFile">FILE ADD</a>
    <a href="#this" class="btn" id="list">LIST</a>
    <a href="#this" class="btn" id="update">SAVE</a>
    <a href="#this" class="btn" id="delete">DELETE</a>
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        var gfv_count = '${fn:length(list)+1}';
        $(document).ready(function(){
            $("#list").on("click", function(e){ 
                e.preventDefault();
                fn_openBoardList();
            });
             
            $("#update").on("click", function(e){
                e.preventDefault();
                fn_updateBoard();
            });
             
            $("#delete").on("click", function(e){ 
                e.preventDefault();
                fn_deleteBoard();
            });
             
            $("#addFile").on("click", function(e){ 
                e.preventDefault();
                fn_addFile();
            });
             
            $("a[name^='delete']").on("click", function(e){ 
                e.preventDefault();
                fn_deleteFile($(this));
            });
        });
         
        function fn_openBoardList(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
            comSubmit.submit();
        }
         
        function fn_updateBoard(){
            var comSubmit = new ComSubmit("frm");
            comSubmit.setUrl("<c:url value='/sample/updateBoard.do' />");
            comSubmit.submit();
        }
         
        function fn_deleteBoard(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/deleteBoard.do' />");
            comSubmit.addParam("IDX", $("#IDX").val());
            comSubmit.submit();
             
        }
         
        function fn_addFile(){
            var str = "<p>" +
                    "<input type='file' id='file_"+(gfv_count)+"' name='file_"+(gfv_count)+"'>"+
                    "<a href='#this' class='btn' id='delete_"+(gfv_count)+"' name='delete_"+(gfv_count)+"'>DELTE</a>" +
                "</p>";
            $("#fileDiv").append(str);
            $("#delete_"+(gfv_count++)).on("click", function(e){ 
                e.preventDefault();
                fn_deleteFile($(this));
            });
        }
         
        function fn_deleteFile(obj){
            obj.parent().remove();
        }
    </script>
</body>
</html>