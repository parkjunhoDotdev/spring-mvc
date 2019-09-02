<%--
  Created by IntelliJ IDEA.
  User: parkjunho
  Date: 2019-02-14
  Time: 오후 5:51
  To change this template use File | Settings | File Templates.
--%>


<%--/**--%>
<%--* Copyright (c) Tiny Technologies, Inc. All rights reserved.--%>
<%--* Licensed under the LGPL or a commercial license.--%>
<%--* For LGPL see License.txt in the project root for license information.--%>
<%--* For commercial licenses see https://www.tiny.cloud/--%>
<%--*--%>
<%--* Version: 5.0.13 (2019-08-06)--%>
<%--*/--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        h1 strong {
            color: orange;
        }
    </style>
    <script src="/resources/jquery-3.4.1.js"></script>
    <script src="/resources/tinymce/tinymce.min.js"></script>
    <script src="/resources/tinymce/langs/ko_KR.js"></script>
<%--    <script src='https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js' referrerpolicy="origin"></script>--%>
    <script>

        var defaultConfig = {
          selector: 'textarea#editable',  // change this value according to your html
              language : 'ko_KR',
              // menubar : "insert", 메뉴바 세팅하지 않으면 디폴트 메뉴가 노출(파일, 수정, 보기 ,삽입, 포맷, 도구)
              height : 450,
              plugins: [
                    "code image template paste fullscreen preview print wordcount autolink save"  // html코드보기, 이미지, 템블릿, 이미지 붙여넣기 풀스크린, 프리뷰, 인쇄 기능(툴바), 워드카운트
              ],
              // 저장기능,단축키
              // 이미지 업로드시 확장자 제한, 용량제한

          paste_data_images: true, // 이미지 d&d true
          contextmenu: "", // 컨텍스트메뉴 삭제
          //contextmenu_never_use_native: true, // 컨텍스트메뉴 삭제 -> 이 설정으로는 이미지 컨텍스트 메뉴 삭제가 안됨.
          toolbar: "undo redo | alignleft aligncenter alignright |image code template fullscreen preview print wordcount | save cancel ",

          templates: [
            {title: 'Some title 1', description: 'Some desc 1', content: 'My content'},
            {title: 'Some title 2', description: 'Some desc 2', url: 'template1.do'}
          ],
          object_resizing : false, //이미지, 테이블 리사이징 차단 / Default Value: true / Possible Values: true, false, img
          // images_upload_url : 'test.do',

          save_onsavecallback: function () { alert('Saved'); },
          images_upload_handler: function (blobInfo, success, failure) {
            // d&d 이미지 업로드와 버튼 클릭해서 업로드 하는 부분 공통으로 이 함수를 타게됨
            // 이미지 사이즈 조정 막기, 이미지 좌우 정렬 기능 달기
            var xhr, formData;
            xhr = new XMLHttpRequest();
            xhr.withCredentials = false;
            xhr.open('POST', 'uploadImage.do');
            xhr.onload = function() {
              var json;
              if (xhr.status != 200) {
                failure('HTTP Error: ' + xhr.status);
                return;
              }
              json = JSON.parse(xhr.responseText);
              if (!json || typeof json.location != 'string') {
                failure('Invalid JSON: ' + xhr.responseText);
                return;
              }
              success(json.location);
            };
            formData = new FormData();
            formData.append('file', blobInfo.blob(), blobInfo.filename());
            xhr.send(formData);
          },
          formats: {
            alignleft: {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'left'},
            aligncenter: {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'center'},
            alignright: {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'right'},
            alignjustify: {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'full'},
            bold: {inline : 'span', 'classes' : 'bold'},
            italic: {inline : 'span', 'classes' : 'italic'},
            underline: {inline : 'span', 'classes' : 'underline', exact : true},
            strikethrough: {inline : 'del'},
            forecolor: {inline : 'span', classes : 'forecolor', styles : {color : '%value'}},
            hilitecolor: {selector : 'span,p', classes : 'hilitecolor'+ '%value', styles : {backgroundColor : '%value'}},
            custom_format: {block : 'h1', attributes : {title : 'Header'}, styles : {color : 'red'}}
            // fontsize : {selector : 'p,span', classes : 'fontsize', styles : {fontsize : '%value'}}
          }
        }

      tinymce.init(defaultConfig);
    </script>
</head>

<body>
<h1>TinyMCE Inline Editing Mode Guide</h1>
<form method="post">
    <textarea id = "editable">hello World</textarea>
    <button name="submitbtn"></button>
<%--    <div id="myeditablediv">Click here to edit!</div>--%>
</form>
</body>
</html>