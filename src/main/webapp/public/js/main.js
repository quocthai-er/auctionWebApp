// Preloader
let loader = document.getElementById('preloader');
window.addEventListener("load", function () {
    loader.classList.add('d-none');
});

function Found (url){
     find = $('#search').val();
    if(find==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = url+"/Search?search="+find;
    }
}

function SortDec (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(c==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortDec?search="+c;
    }
}
function SortDecPrice (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(c==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortDecPrice?search="+c;
    }
}
function SortInc (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(find==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortInc?search="+c;
    }
}
function SortIncTime (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(find==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortIncTime?search="+c;
    }
}




