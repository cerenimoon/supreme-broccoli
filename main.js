var circlegazi = L.circle([39.938346, 32.819751], {
    color: 'blue',
    fillcolor: '#f03',
    fillOpacity: 0.5,
    radius: 200
}).addTo(map); 

var polygongazi = L.polygon([
    [39.943232, 32.813014],
    [39.944483, 32.825571],
    [39.938396, 32.819864]
]).addTo(map);

var pointgazi = new L.LatLng(39.938396, 32.819864)
var pointcom = new L.LatLng(39.936421, 32.823629)
var pointList = [pointgazi, pointcom]

var polylinegazi = new L.Polyline(pointList, {
    color: 'red',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});

var distancegazi = pointgazi.distanceTo(pointcom);
polygongazi.bindPopup("Important commuter areas near Gazi University central campus");
polylinegazi.addTo(map)
L.marker(pointcom).addTo(map).bindPopup("Distance between D200 and Gazi University Central Campus " + distancegazi + "m");
L.marker([39.943232, 32.813014]).addTo(map).bindPopup("Gazi Mahallesi commuter");
L.marker([39.944483, 32.825571]).addTo(map).bindPopup("Hipodrom station");             
//polylinegazi.bindPopup("Distance between D200 and Gazi University central campus " + distance + "m");

function locations(){
    L.marker([39.933947, 32.824203]).addTo(map).bindPopup("Gazi Medicine Sciences Department is an important part of Gazi University complex" + 
    "</br>" + "Gazi Medicine Sciences Department is one of the nearby departments near the Gazi central campus");
    L.marker([39.924627, 32.836803]).addTo(map).bindPopup("Memorial Tomb of Mustafa Kemal Atatürk" +"<br/>" + 
    "Gazi University students visits Memorial Tomb of Mustafa Kemal Atatürk each year"); 
    L.marker([39.935233, 32.824026]).addTo(map).bindPopup("Gazi Art and Design Faculty is a important cornerstone of Gazi University complex" +
    "</br>" + "Gazi Art and Design Faculty is near Gazi Medicine Sciences Department");
}

function gazi(){
    L.marker([39.939485, 32.822109]).addTo(map).bindPopup("Gazi Central Municipality has a rich history" + "</br>" +
    "Gazi Central Municipality is built by famous architect Kemaleddin");
    L.marker([39.938364, 32.822684]).addTo(map).bindPopup("Gazi Concert Hall has included many art activities" + "</br>" +
    "Gazi theatre community has had plays in this place");
    L.marker([39.940041, 32.795828]).addTo(map).bindPopup("Gazi station is one of the important commuter places near the Gazi Central Campus" +
    "</br>" + "Gazi station passes through direction of ATG main train station direction");
}

function about(){
    document.getElementById("about").innerHTML = "<p>Gazi University plugin is an extensive city map</p>" + "<p> application that gives geographic information of clicked points on map canvas like distance and latitude-longitude coordinates</p>"
    + "<p>creates popups at specific locations over map canvas with Locations and Gazi links and informs the users.</p>"
    + "<p>Click over the map and harvest the coordinate points and learn about Gazi central campus</p>";
}


