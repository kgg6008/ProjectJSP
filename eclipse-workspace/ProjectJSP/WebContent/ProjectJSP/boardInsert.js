/**
 * This is java script when add board.
 */
function addBoard(){
	var finish = confirm('저장하시겠습니까?')
	if(!finish){
		return;
	}
	if(document.inputBoard.writer.value.length == 0){
		alert('아이디를 입력하세요.');
		inputBoard.writer.focus();
		return;
	}
	if(document.inputBoard.title.value.length == 0){
		alert('제목을 입력하세요.');
		inputBoard.title.focus();
		return;
	}
	if(document.inputBoard.title.value.length > 20){
		alert('제목을 20자 이내로 입력해주세요.');
		inputBoard.title.focus();
		return;
	}
	if(document.inputBoard.text.value.length == 0){
		alert('내용을 입력해 주세요.');
		inputBoard.text.focus();
		return;
	}
	if(document.inputBoard.text.value.length > 200){
		alert('내용을 200자 이내로 입력해주세요.');
		inputBoard.text.focus();
		return;
	}
	if(document.inputBoard.pw.value.length == 0){
		alert('비밀번호를 입력하세요.');
		inputBoard.pw.focus();
		return;
	}
	document.inputBoard.submit();	
}