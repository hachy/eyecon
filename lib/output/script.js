const inputElement = document.getElementById('inputimg');
const applist = document.getElementById('applist');
const imgs = applist.getElementsByTagName('img');

inputElement.addEventListener('change', handleFiles, false);

function handleFiles() {
  const file = this.files[0];
  const reader = new FileReader();
  const num = Math.floor(Math.random() * (imgs.length - 10)) + 5;
  const img = imgs[num];
  reader.onload = (function (aImg) {
    return function (e) {
      aImg.src = e.target.result;
    };
  })(img);
  reader.readAsDataURL(file);
}
