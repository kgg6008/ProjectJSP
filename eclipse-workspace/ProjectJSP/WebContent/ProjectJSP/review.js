/**
 * java script of review
 */
function isOk(){
	var finish = confirm('저장하시겠습니까?')
	if(!finish){
		return;
	}
	if(document.inputReview.users.value == "null"){
		alert("로그인 후 이용해 주세요.");
		document.location.href="login.jsp";
		return;
	}
	if(document.inputReview.text.value.length == 0){
		alert("내용을 입력해주세요.");
		inputReview.text.focus();
		return;
	}
	if(document.inputReview.text.value.length > 200){
		alert("200자 이내로 입력해주세요.");
		inputReview.text.focus();
		return;
	}
	document.inputReview.submit();
}
function checkModify(n){
	pwd = prompt('수정 하려면 비밀번호를 입력하세요.');
	document.location.href="controler.jsp?action=edit&id="+n+"&pw="+pwd;
}
function checkDelete(n){
	var finish = confirm('삭제하시겠습니까?')
	if(!finish){
		return;
	}
	pwd = prompt('삭제 하려면 비밀번호를 입력하세요.');
	document.location.href="controler.jsp?action=delete&id="+n+"&pw="+pwd;
}
function isOkUpdate(){
	var finish = confirm('저장하시겠습니까?')
	if(!finish){
		return;
	}
	if(document.inputReview.users.value == "null"){
		alert("로그인 후 이용해 주세요.");
		document.location.href="login.jsp";
		return;
	}
	if(document.inputReview.text.value.length == 0){
		alert("내용을 입력해주세요.");
		review.focus();
		return;
	}
	if(document.inputReview.text.value.length > 200){
		alert("200자 이내로 입력해주세요.");
		review.focus();
		return;
	}
	document.inputReview.submit();
}