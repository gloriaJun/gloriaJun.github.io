---
layout: post
title: "(Javascript) Map 연동하기(OSM)"
date: 2018-11-27 15:15:00
author: gloria
categories: language
tags: javascript map gis
---

지도 라이브러리를 이용하여 웹 화면에 지도를 출력해보기
많이 사용하는 라이브러리로는 **[Leaflet](https://openlayers.org/)**과 **[OpenLayers](https://openlayers.org/)**가 있는 듯.

두 라이브러리의 특징을 간단히 정리하면...
#### Leaflet
- 코드의 크기가 작고(38K), 간단한 지도 프로그램을 만드는 데 적합
- 사용법이 간단하여 사용하기 쉽고, 코드의 양이 적은편
- 추가 기능은 플러그인을 적용해 확장 가능 (3rd party)
- 모바일 친화적

#### OpenLayers
- 코어 라이브러리에 웹기반의 GIS 를 만들기 위한 필수적인 기능을 모두 가지고 있음
- 높은 유연성과 안정성
- 다양한 예제 제공
- 내장된 Proj4 를 사용한 on-the-fly 기능 제공 (다양한 좌표체계를 가진 레이어를 타일지도의 체계로 투영)





## Example
먼저 map 출력을 위해 스타일을 설정한다.
```css
html, body { height: 100%; }
.map { height: 80%; }
```

#### Leaflet
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.4/dist/leaflet.css">
</head>
<body>

<div id="leafMap" class="map"></div>

<script src="https://unpkg.com/leaflet@1.3.4/dist/leaflet.js"></script>
<script>
const zoom = {
  level: 15,
  maxLevel: 19,
}

// 현재의 위치 정보를 가져온다.
function getLocation() {
  return new Promise(resolve => {
    navigator.geolocation.watchPosition(function(position) {
      return resolve({
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
      });
    });
  });
}

getLocation().then(location => {
  const { latitude, longitude }= location;
  
  // 위도, 경도, zoom level을 설정하여 Map을 생성한다.
  let mymap = L.map('leafMap').setView([latitude, longitude], zoom.level);
  
  // map을 로딩한다
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: zoom.maxLevel,
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(mymap);
});
</script>
</body>
</html>
```

leaflet의 다큐먼트에 정의한 아래의 방법은 token이 필요해서 [Leaflet-providers preview - Leaflet Provider Demo](https://leaflet-extras.github.io/leaflet-providers/preview/)에 정의된 코드를 참고하여서 맵을 호출하였다
```javascript
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.streets',
    accessToken: 'your.mapbox.access.token'
}).addTo(mymap);
```

<p data-height="265" data-theme-id="0" data-slug-hash="NEEGEJ" data-default-tab="js,result" data-user="gloriaJun" data-pen-title="javascript-gis-leaflet" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/NEEGEJ/">javascript-gis-leaflet</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


#### OpenLayers
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.4/dist/leaflet.css">
</head>
<body>

<div id="myMap" class="map"></div>

<script src="https://unpkg.com/leaflet@1.3.4/dist/leaflet.js"></script>
<script>
const zoom = {
  level: 15,
  maxLevel: 19,
}

// 현재의 위치 정보를 가져온다.
function getLocation() {
  return new Promise(resolve => {
    navigator.geolocation.watchPosition(function(position) {
      return resolve({
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
      });
    });
  });
}

getLocation().then(location => {
  const { latitude, longitude }= location;
  
  new ol.Map({
    target: 'myMap',
    view: new ol.View({
      center: ol.proj.fromLonLat([longitude, latitude]),
      zoom: zoom.level,
    }),
    layers: [
      new ol.layer.Tile({
        source: new ol.source.OSM(),
      }),
    ],
  });
});
</script>
</body>
</html>
```

<p data-height="265" data-theme-id="0" data-slug-hash="Oaayqa" data-default-tab="js,result" data-user="gloriaJun" data-pen-title="javascript-gis-openLayers" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/Oaayqa/">javascript-gis-openLayers</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


## Reference
- [Leaflet vs OpenLayers 슬라이드 자료](http://ivansanchez.github.io/leaflet-vs-openlayers-slides/#/)
- [Leaflet-providers preview - Leaflet Provider Demo](https://leaflet-extras.github.io/leaflet-providers/preview/)
