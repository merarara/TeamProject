<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<style>
/*최상단 최하단*/
.btns {
  display: flex;
  position: fixed;
  right: .4rem;
  bottom: .4rem;
}

.btns > div {
  padding: .6rem 1.5rem;
  background: #111;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  border-radius: 5px;
  transition: .2s;
  color: #fff;
  margin-right: .4rem;
}

.moveTopBtn:hover {
  color: #000;
  background: #febf00;
}
/* ------ */
* {
  font-family: Pretendard;
  user-select: none;
}

.list > div {
  margin-bottom: 1rem;
  margin-left: .4rem;
  font-size: 1.4rem;
}
/* 로딩 */
#waiting {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: flex;
    align-items: center; /* 중앙 정렬 */
    justify-content: center; /* 가운데 정렬 */
    background: white;
    z-index: 999;
    opacity: 0.9;
}
#waiting > img {
    width: fit-content;
    height: fit-content;
    margin: auto;
}

</style>
<script>
document.addEventListener("DOMContentLoaded", () => {
	  const $topBtn = document.querySelector(".moveTopBtn");

	  // Top
	  $topBtn.addEventListener("click", () => {
	    window.scrollTo({ top: 0, behavior: "smooth" });
	  });

	  const $bottomBtn = document.querySelector(".moveBottomBtn");

	  // Bottom
	  $bottomBtn.addEventListener("click", () => {
	    window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
	  });
	});

$(window).on('load', function() {
    setTimeout(function(){
        $("#waiting").fadeOut();
    }, 500);
});
</script>
</head>
<body>
<%@ include file="./header.jsp" %>	
<div id="content">
<div id="waiting">
	<img src="/userimages/welcome.jpeg">
</div>
<div class="list">
  <div>페이지 상단</div>
  <div>1</div>
  <div>2</div>
  <div>3</div>
  <div>4</div>
  <div>5</div>
  <div>6</div>
  <div>7</div>
  <div>8</div>
  <div>9</div>
  <div>10</div>
  <div>11</div>
  <div>12</div>
  <div>13</div>
  <div>14</div>
  <div>15</div>
  <div>16</div>
  <div>17</div>
  <div>18</div>
  <div>19</div>
  <div>20</div>
  <div>21</div>
  <div>22</div>
  <div>23</div>
  <div>24</div>
  <div>25</div>
  <div>26</div>
  <div>27</div>
  <div>28</div>
  <div>29</div>
  <div>30</div>
  <div>31</div>
  <div>32</div>
  <div>33</div>
  <div>34</div>
  <div>35</div>
  <div>36</div>
  <div>37</div>
  <div>38</div>
  <div>39</div>
  <div>40</div>
  <div>페이지 하단</div>
</div>
<div class="btns">
  <div class="moveTopBtn">위로가기</div>
  <div class="moveBottomBtn">아래로가기</div>
</div>
</div>
<%@ include file="./footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
