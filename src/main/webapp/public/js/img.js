function changeImage (id){
    imgPath = document.getElementById(id).getAttribute('src');
    document.getElementById('img_main').setAttribute('src',imgPath);
}