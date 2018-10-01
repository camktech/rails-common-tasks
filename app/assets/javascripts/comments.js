document.addEventListener('click', (event) => {
  if(event.target.className.includes('edit-comment-button') ||
    event.target.parentElement.className.includes('edit-comment-button')){
    event.target.closest('.comment').getElementsByClassName('edit-comment')[0].style.display = 'block';
  }
  else if(event.target.className == 'cancel-edit-comment'){
    event.target.closest('.comment').getElementsByClassName('edit-comment')[0].style.display = 'none';
  }
});
