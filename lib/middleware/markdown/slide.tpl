<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<title><#=$title#></title>
<style>
html,body{margin:0;padding:0;height:100%;background: #000;}
body {opacity: 0;color:#fff;font-family: "Verdana", "monaco", "Microsoft YaHei";}
#page {width: 100%;height:100%;position:relative;overflow:hidden;}
.page{color:white;width:100%;height:100%;overflow:hidden;text-align:left;position:absolute;opacity:0;transition:transform
.8s ease;background:black;}
.prev {opacity:0.2;transform: translate(-100%, 0);}
.current {opacity:1;z-index:999;}
.next {opacity:0.2;transform: translate(100%, 0);}
.inner {margin: 40px 100px;}
.inner a {text-decoration: none;color: #D1C556;}
.inner h1 {font-size:50px;padding-bottom: 30px;}
.inner h2 {font-size:40px;padding-bottom: 20px;}
.inner h3 {font-size:30px;padding-bottom: 10px;}
.inner h4 {font-size:25px;padding-bottom: 5px;}
.inner p,
.inner blockquote,
.inner pre {margin: 0;font-size: 25px;line-height: 1.4em;margin-top:30px;}
.inner blockquote,
.inner pre,
.inner code {background: #2f3129;border-radius: 4px;padding: 2px
4px;margin-right:10px;margin-top:30px;}
.inner pre
.inner ul,
.inner ol{font-size: 25px;line-height:1.4em;background:rgb(47, 47, 47);border-radius: 10px;padding: 10px 50px;}
.inner li {padding: 4px;}
.inner hr {display:none;margin-top:10px;}
.inner p img {}
.inner table { table-layout:fixed; empty-cells:show; border-collapse:
collapse;margin:0 auto; border:2px solid #666; }
.inner table th,
.inner table td{text-align: left; border:1px solid #666; padding: 0.8em 1em;}
.inner table th { background: rgba(244, 253, 255, 0.24);font-weight: bold;padding: 1em;}
.switcher {background-color: rgba(123, 123, 123, 0.1);border: none;top:
0;font-size: 40px;margin: 0;max-width: 150px;min-width: 80px;outline:
none;padding: 0;position: absolute;top: 0;z-index: 9999;color: rgba(158, 158,
158, 0.5);height:100%;}
.switcher:hover, .switcher:focus {cursor: pointer;background-color: rgba(123, 123, 123, 0.2);}
.right-top {transition:all .5s ease;position: absolute;top: 20px;right:
20px;z-index: 99999;opacity: 0.4;}
.right-top:hover {opacity: 0.8;}
.thumbnail {background: #000;}
.thumbnail .page {position: static;display: inline-block;overflow:
hidden;cursor: pointer;width: 20%;height: 20%;background: rgba(128, 128, 128,
0.35);margin-left: 30px;margin-top: 20px; transform: none; border-radius:
10px;opacity:1;}
.thumbnail .page .inner {padding: 4px 10px; margin: 0;text-align: center;}
.thumbnail .page .inner h1,
.thumbnail .page .inner h2 {font-size: 18px; text-align: center;}
.thumbnail .page .inner ul,
.thumbnail .page .inner li,
.thumbnail .page .inner ol,
.thumbnail .page .inner pre,
.thumbnail .page .inner img,
.thumbnail .page .inner p,
.thumbnail .page .inner code,
.thumbnail .page .inner h3,
.thumbnail .page .inner h4,
.thumbnail .page .inner table,
.thumbnail .page .inner i,
.thumbnail .page .inner strong,
.thumbnail .page .inner b,
.thumbnail .page .inner hr,
.thumbnail .page .inner blockquote{display: none;}
#copyright { position: absolute; bottom: 20px; left: 50%; margin-left: -192px;
display: none;width: 384px;}
#copyright a {text-decoration: none;color: #D1C556;}
.thumbnail #copyright {display: block;}
.thumbnail .switcher {display: none!important;}
</style>
</head>
<body>
<div id="page">
<#=$content#>
</div>
<div class="right-top" id="radios">
  <label>normal</label>
  <input type="radio" name="slide" value="true" />
  <label>slide</label>
  <input id="slide" type="radio" name="slide" checked value="false"/>
</div>
<button id="left" class="switcher" style="left: 0px;">&lsaquo;</button>
<button id="right"   class="switcher" style="right: 0px;">&rsaquo;</button>
<div id="copyright">Thank you for enjoy. &copy; <a href="https://github.com/xudafeng/startserver"
target="_blank">Startserver</a> <iframe
src="http://ghbtns.com/github-btn.html?user=xudafeng&repo=startserver&type=watch&count=true"
allowtransparency="true" frameborder="0" scrolling="0" width="80px" height="20px"></iframe></div>
<script>
(function(global, undefined) {
  var isSlide = document.getElementById("slide").checked;
  var index = location.hash.split("=")[1] || 1;
  var left = document.getElementById("left");
  var right = document.getElementById("right");
  var page = document.getElementById("page");
  var isthumbnail = false;
  page.contentEditable = "true";
  page.designMode = "on";
  var pages = page.children;
  var radios = document.getElementById("radios");

  function setCookie(name, value, expiresHours) {
    var cookieString = name + "=" + escape(value);

    if (expiresHours > 0) {
      var date = new Date();
      date.setTime( date.getTime + expiresHours * 3600 * 1000);
      cookieString = cookieString + ";expires=" + date.toGMTString();
    }
    document.cookie = cookieString;
  }

  function addClass(index, name) {

    if (!pages[index]) return;
    pages[index].className += " " + name;
  }

  function removeClass() {
    for (var i = 0; i < pages.length; i++) {
      pages[i].className = "page";
    }
  }

  function direct(target) {
    left.style.display = "block";
    right.style.display = "block";
    if (index == 1) left.style.display = "none";
    if (index == pages.length) right.style.display = "none";
    location.href = target || "";
  }

  function prev() {
    if (index == 1) return;
    index --;
    direct("#page=" + index);
  }

  function next() {
    if (index == pages.length) return;
    index ++;
    direct("#page=" + index);
  }

  function thumbnail() {
    page.contentEditable = isthumbnail ? "true" : "false";
    document.body.className = isthumbnail ? "" : "thumbnail";
    isthumbnail = !isthumbnail;
  }

  function slider() {
    if (index == 0) return thumbnail();
    removeClass();
    addClass(index - 1, "current");
    setTimeout(function() {
      addClass(index, "next");
      addClass(index - 2, "prev");
    }, 16);
  }

  var temp = "";

  for (var i = 0;i < pages.length;i++) {
    var current = pages[i];
    var tagName = current.tagName;
    var nextTag = pages[i + 1];
    var nextTagName = nextTag ? nextTag.tagName : null;

    if (i === 0 || tagName === "H1" || tagName === "H2") {
      temp += "<article class=\"page\"><div class=\"inner\">";
    }
    temp += current.outerHTML;

    if (nextTagName === "H1" || nextTagName === "H2") {
      temp += "<\/div><\/article>";
    }
  }

  page.innerHTML = temp + "<\/div><\/article>";
  pages = page.querySelectorAll(".page");

  function delegate(target) {
    return target.nodeName.toLowerCase() === "article" ? target : delegate(target.parentElement);
  }

  function getIndex(e) {
    var p = e.parentNode;
    var c = p.children;
    for (var i=0; i < c.length; i++) {
      if (c[i] == e) return i;
    }
  }

  radios.addEventListener("click", function(e) {

    if (e.target.nodeName === "INPUT" && e.target.value === "true") {
      setCookie("startserver-slide", false, 240);
      direct();
    }
  });
  page.addEventListener("click", function(e) {
    if (!isthumbnail) return;
    var target = delegate(e.target);
    var index = getIndex(target) + 1;
    thumbnail();
    direct("#page=" + index);
  });
  global.addEventListener("hashchange", function() {
    index = location.hash.split("=")[1] || 1;
    slider();
  });
  global.addEventListener("mousewheel", function(e) {
    var target = pages[index - 1];
    var delta = e.wheelDelta / 120;
    target.scrollTop += delta > 0 ? 10 : -10;
  });
  left.addEventListener("click", function() {
    prev();
  });
  right.addEventListener("click", function() {
    next();
  });
  document.addEventListener("keydown", function(e) {
    switch (e.keyCode) {
      case 39:
      case 40:
        e.preventDefault();
        next();
        break;
      case 37:
      case 38:
        e.preventDefault();
        prev();
        break;
      case 27:
        e.preventDefault();
        direct("#page=" + 0);
        break;
    }
  });
  setTimeout(function() {
    slider();
    direct("#page=" + index);
    document.body.style.opacity = 1;
  }, 16);
})(this);
</script>
</body>
</html>
