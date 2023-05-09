<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAIK4TcGhAh9Q_AnoEmZuMyYfXOKGCJ0pg&callback=initMap"></script>
<script>
function showModal() {
	$('#myModal').modal('show');
}

window.initMap = function () {
	const map = new google.maps.Map(document.getElementById("map"), {
    	center: { lat: 37.569605308951, lng: 126.98424560554 },
    	zoom: 16,
  	});

  	const myLatLng = { lat: 37.569605308951, lng: 126.98424560554 };

  	const marker = new google.maps.Marker({
    	position: myLatLng,
    	map: map,
    	title: 'TJouen NoteBook'
  	});
};
</script>
<footer class="bg-dark text-white py-3 mt-auto">
  	<div class="container">
    	<div class="row">
      		<div class="col-md-4">
        		<h5>회사소개</h5>
        		<p>TJoeun NoteBook은 노트북 종합 판매 사이트 입니다.</p>
      		</div>
      		<div class="col-md-4">
        		<h5>연락처</h5>
        		<p>tel) 010-1234-5678</p>
      		</div>
      		<div class="col-md-4">
        		<h5>찾아오는길</h5>
        		<p><a href="#" onclick="showModal();">서울특별시 종로구 우정국로2길 21</a></p>
      		</div>
    	</div>
  	</div>
</footer>

<!-- 모달창 -->
<div id="myModal" class="modal">
  	<div class="modal-dialog">
    	<div class="modal-content">
      		<div class="modal-header">
      			더조은 노트북
        		<button type="button" class="close" data-dismiss="modal">&times;</button>
      		</div>
      		<div class="modal-body">
        		<div id="map" style="height: 600px;"></div>
      		</div>
    	</div>
  	</div>
</div>