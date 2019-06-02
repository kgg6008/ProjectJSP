/**
 * This is java script when add comments.
 */
function inputComment(){
	if(document.newComment.text.value.length == 0){
		alert("댓글을 입력해 주세요.");
		newComment.text.focus();
		return;
	}
	if(document.newComment.nickName.value.length == 0){
		alert("사용할 닉네임을 입력해 주세요.");
		newComment.nickname.focus();
		return;
	}
	if(document.newComment.pw.value.length == 0){
		alert("사용할 비밀번호를 입력해 주세요.");
		newComment.pw.focus();
		return;
	}
	if(document.newComment.text.value.length > 200){
		alert("200자 이내로 입력해 주세요.");
		newComment.value.focus();
		return;
	}
	document.newComment.submit();
}

function removeComment(id, boardId){
	var finish = confirm('삭제하시겠습니까?')
	if(!finish){
		return;
	}
	pwd = prompt('삭제 하려면 비밀번호를 입력하세요.');
	document.location.href = "removeComment.jsp?id=" + id+"&pw="+pwd + "&boardid=" + boardId;
}