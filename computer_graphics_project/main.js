import * as THREE from 'https://unpkg.com/three@0.126.1/build/three.module.js'
import { OrbitControls } from 'https://unpkg.com/three@0.126.1/examples/jsm/controls/OrbitControls.js'
import { GUI } from './three.js-master/examples/jsm/libs/lil-gui.module.min'
//import { DragControls } from './three.js-master/examples/jsm/controls/DragControls'
//import Stats from './three.js-master/examples/jsm/libs/stats.module'
//import { TransformControls } from './three.js-master/examples/jsm/controls/TransformControls'
//import Stats from './three.js-master/examples/jsm/libs/stats.module'

const API = {
  ambientLightIntensity: 0.50,
  spotLightIntensity: 3.5,
  pointLightIntensity: 6 
};

const loader = new THREE.CubeTextureLoader(); //load the cube texture
loader.setPath('images/') //images directory 
const textureCube = loader.load(['labut12.jpg', 'labut15.jpg', 'labut3.jpg', 'labut10.jpg', 'labut11.jpg', 'lobut16.jpg']);
const scene = new THREE.Scene() //set the scene
scene.background = textureCube //texture cube
const camera = new THREE.PerspectiveCamera(75, innerWidth / innerHeight, 0.1, 1000);
camera.position.set(0, 15, 3)
const listener = new THREE.AudioListener() //listen the audio
camera.add(listener) //add sound the camera
const sound = new THREE.Audio(listener) //sound 
const audioLoader = new THREE.AudioLoader() //audio load
audioLoader.load('sounds/BowlingAlleyAmbien-PE309201.ogg', function(buffer){
  sound.setBuffer(buffer) //buffer
  sound.setLoop(true)  //loop true
  sound.setVolume(1.5) //set volume
  sound.play() //play
})
const renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
renderer.setPixelRatio(devicePixelRatio)
document.body.appendChild(renderer.domElement);

//control window resizing
window.addEventListener('resize', function() {
  var width = window.innerWidth;
  var height = window.innerHeight;
  renderer.setSize(width, height);
  camera.aspect = width / height;
  camera.updateProjectionMatrix( );
});

//controls
var controls = new OrbitControls(camera, renderer.domElement)
controls.keys = {
    LEFT: 'KeyA',
    UP: 'KeyW',
    RIGHT: 'KeyD',
    BOTTOM: 'KeyS'
}
controls.update()

//draw shapes
var geometry = new THREE.BoxGeometry(1, 1, 1);
var cubeMaterials = [
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut1.jpg'), side: THREE.DoubleSide }), //right
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut2.jpg'), side: THREE.DoubleSide }), //left
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut3.jpg'), side: THREE.DoubleSide }), //top 
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut7.jpg'), side: THREE.DoubleSide }), //bottom
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut8.jpg'), side: THREE.DoubleSide }), //front
  new THREE.MeshLambertMaterial({ map: new THREE.TextureLoader().load('images/labut9.jpg'), side: THREE.DoubleSide }) //back
];
//create a material
var material = new THREE.MeshFaceMaterial(cubeMaterials)
var cube = new THREE.Mesh(geometry, material)
scene.add(cube)

camera.position.z = 3; //camera

var floorMattBowling = new THREE.MeshStandardMaterial({roughness: 1.8, color: 0xffffff, metalness: 0.2, bumpScale: 0.0005}); //floor 

const textureLoader = new THREE.TextureLoader(); //Texture loader for floor 

textureLoader.load("images/Grainy_Wood_001_COLOR.jpg", function(map) {
  map.wrapS = THREE.RepeatWrapping;
  map.wrapT = THREE.RepeatWrapping;
  map.anisotropy = 4;
  map.repeat.set(10, 24)
  map.encoding = THREE.sRGBEncoding;
  floorMattBowling.map = map;
  floorMattBowling.needsUpdate = true;
});
textureLoader.load("images/Grainy_Wood_001_ROUGH.jpg", function(map){
  map.wrapS = THREE.RepeatWrapping;
  map.wrapT = THREE.RepeatWrapping;
  map.anisotropy = 4;
  map.repeat.set(10, 24)
  floorMattBowling.roughnessMap = map;
  floorMattBowling.needsUpdate = true;
});
textureLoader.load("images/Grainy_Wood_001_NORM.jpg", function(map){
  map.wrapS = THREE.RepeatWrapping;
  map.wrapT = THREE.RepeatWrapping;
  map.anisotropy = 4;
  map.repeat.set(10, 24)
  floorMattBowling.bumpMap = map;
  floorMattBowling.needsUpdate = true;
})
var floorGeometry = new THREE.PlaneGeometry(50, 50) //floor geometry
var floorMesh = new THREE.Mesh(floorGeometry, floorMattBowling) //floor Mesh 
floorMesh.receiveShadow = true; //floor Shadow  
floorMesh.rotation.x = - Math.PI / 2.0; //floor rotation
floorMesh.position.y = -0.5 //floor position
scene.add(floorMesh) //add scene floor 
//bowling sphere 
var bowlingGeometry = new THREE.SphereGeometry(0.5, 32, 32);
var bowlingMaterial = new THREE.MeshPhongMaterial({map: new THREE.TextureLoader().load('images/marble_coloured_001_NRM.png'), side: THREE.DoubleSide})
var bowlingSphere = new THREE.Mesh(bowlingGeometry, bowlingMaterial)
bowlingSphere.position.set(-2, 0, 0) 
scene.add(bowlingSphere)
//bowling sphere 2
var bowlingGeometry2 = new THREE.SphereGeometry(0.5, 32, 32);
var bowlingMaterial2 = new THREE.MeshPhongMaterial({map: new THREE.TextureLoader().load('images/labut6.jpg'), side: THREE.DoubleSide})
var bowlingSphere2 = new THREE.Mesh(bowlingGeometry2, bowlingMaterial2)
bowlingSphere2.position.set(-6, 0, 0)
scene.add(bowlingSphere2)
//bowling sphere 3 
var bowlingGeometry3 = new THREE.SphereGeometry(0.5, 32, 32);
var bowlingMaterial3 = new THREE.MeshPhongMaterial({map: new THREE.TextureLoader().load('images/labut14.jpg'), side: THREE.DoubleSide})
var bowlingSphere3 = new THREE.Mesh(bowlingGeometry3, bowlingMaterial3)
bowlingSphere3.position.set(-9, 0, 2.70)
scene.add(bowlingSphere3)
//bowling pin
var bowlingPinGeometry = new THREE.CylinderGeometry(0.25, 0.25, 3, 32)
var bowlingPinMaterial = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut4.jpg'), side: THREE.DoubleSide})
var bowlingPin = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial)
bowlingPin.position.x = -8
scene.add(bowlingPin)
//bowling pin 2
var bowlingPinMaterial2 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut6.jpg'), side: THREE.DoubleSide})
var bowlingPin2 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial2)
bowlingPin2.position.x = -9
scene.add(bowlingPin2)
//bowling pin 3
var bowlingPinMaterial3 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut8.jpg'), side: THREE.DoubleSide})
var bowlingPin3 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial3)
bowlingPin3.position.x = -10
scene.add(bowlingPin3) 
//bowling pin 4
var bowlingPinMaterial4 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut9.jpg'), side: THREE.DoubleSide})
var bowlingPin4 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial4)
bowlingPin4.position.x = -11
scene.add(bowlingPin4)
//bowling pin 5
var bowlingPinMaterial5 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut10.jpg'), side: THREE.DoubleSide})
var bowlingPin5 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial5)
bowlingPin5.position.x = -9.4
bowlingPin5.position.z = 0.50
scene.add(bowlingPin5)

//bowling pin 6 
var bowlingPinMaterial6 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut12.jpg'), side: THREE.DoubleSide})
var bowlingPin6 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial6)
bowlingPin6.position.x = -8.5
bowlingPin6.position.z = 0.50
scene.add(bowlingPin6)

//bowling pin 7 
var bowlingPinMaterial7 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut13.jpg'), side: THREE.DoubleSide})
var bowlingPin7 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial7)
bowlingPin7.position.x = -10.5
bowlingPin7.position.z = 0.50
scene.add(bowlingPin7) 

//bowling pin 8
var bowlingPinMaterial8 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut2.jpg'), side: THREE.DoubleSide})
var bowlingPin8 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial8)
bowlingPin8.position.x = -8.9
bowlingPin8.position.z = 0.90
scene.add(bowlingPin8)

//bowling pin 9
var bowlingPinMaterial9 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut3.jpg'), side: THREE.DoubleSide})
var bowlingPin9 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial9)
bowlingPin9.position.x = -10.0005
bowlingPin9.position.z = 0.90
scene.add(bowlingPin9)

//bowling pin 10
var bowlingPinMaterial10 = new THREE.MeshStandardMaterial({map: new THREE.TextureLoader().load('images/labut11.jpg'), side: THREE.DoubleSide})
var bowlingPin10 = new THREE.Mesh(bowlingPinGeometry, bowlingPinMaterial10)
bowlingPin10.position.x = -9.4
bowlingPin10.position.z = 1.25
scene.add(bowlingPin10)

var ambientLight = new THREE.AmbientLight(0xDAF7A6, API.ambientLightIntensity) //ambient light intensity
scene.add(ambientLight) //add the light scene
var spotLight = new THREE.SpotLight(0xffd700, API.spotLightIntensity) //spot light intensity
spotLight.position.set(10, 10, 10) //position of spotLight
spotLight.castShadow = true //cast the shadow
scene.add(spotLight) //scene spotLight
var light = new THREE.PointLight(0x3F00FF, API.pointLightIntensity, 50) //point light intensity
light.position.set(15, 15, 15) //position of point light
light.castShadow = true //cast the shadow
scene.add(light) //scene pointLight

var gui = new GUI({ width: 300, autoPlace: false}) //GUI Interface for Lights and Objects
var guiMenu = gui.addFolder('Bowling Light Intensity')
guiMenu.add(API, 'ambientLightIntensity', 0, 1, 0.02)
       .name('ambient light')
       .onChange(function() {
            ambientLight.intensity = API.ambientLightIntensity; render();
       });
guiMenu.add(API, 'spotLightIntensity', 0, 1, 0.02) 
       .name('spot light')
       .onChange(function() {
            spotLight.intensity = API.spotLightIntensity; render();
       });
guiMenu.add(API, 'pointLightIntensity', 0, 1, 0.02)
       .name('point light')
       .onChange(function() {
            light.intensity = API.pointLightIntensity; render();
       });
var con = document.getElementById('gui-container') //use the gui controller for moving the gui
con.append(gui.domElement) //append to container
var guiLight = gui.addFolder('Move the Bowling Light') //move the Light position
guiLight.add(spotLight.position, 'x', 0, Math.PI*2)
guiLight.add(spotLight.position, 'y', 0, Math.PI*2)
guiLight.add(spotLight.position, 'z', 0, Math.PI*2)
guiLight.open()
var guiMove = gui.addFolder('Bowling Cube Rotation') //rotate the cube
guiMove.add(cube.rotation, 'x', 0, Math.PI*2)
guiMove.add(cube.rotation, 'y', 0, Math.PI*2)
guiMove.add(cube.rotation, 'z', 0, Math.PI*2)
guiMove.open()
var guiMoveX = gui.addFolder('Bowling Cube Position') //change cube position
guiMoveX.add(cube.position, 'x', 0, Math.PI*20)
guiMoveX.add(cube.position, 'y', 0, Math.PI*10)
guiMoveX.add(cube.position, 'z', 0, Math.PI*2)
guiMoveX.open()
var guiMove2 = gui.addFolder('Bowling Ball Rotation')
guiMove2.add(bowlingSphere3.rotation, 'x', 0, Math.PI*2) //rotate the bowling ball 
guiMove2.add(bowlingSphere3.rotation, 'y', 0, Math.PI*2)
guiMove2.add(bowlingSphere3.rotation, 'z', 0, Math.PI*2)
guiMove2.open()
var guiMove2X = gui.addFolder('Bowling Ball Position')
guiMove2X.add(bowlingSphere3.position, 'x', 0, Math.PI*20) //change bowling ball rotation
guiMove2X.add(bowlingSphere3.position, 'y', 0, Math.PI*10)
guiMove2X.add(bowlingSphere3.position, 'z', 0, Math.PI*2)
guiMove2X.open()
var guiMove3 = gui.addFolder('Bowling Pin Rotation') //rotate the bowling pin
guiMove3.add(bowlingPin10.rotation, 'x', 0, Math.PI*2) 
guiMove3.add(bowlingPin10.rotation, 'y', 0, Math.PI*2)
guiMove3.add(bowlingPin10.rotation, 'z', 0, Math.PI*2)
guiMove3.open()
var guiMove3X = gui.addFolder('Bowling Pin Position') //change bowling position
guiMove3X.add(bowlingPin10.position, 'x', 0, Math.PI*20)
guiMove3X.add(bowlingPin10.position, 'y', 0, Math.PI*10)
guiMove3X.add(bowlingPin10.position, 'z', 0, Math.PI*2)

//const cameraFolder = gui.addFolder('Camera')
//cameraFolder.add(camera.position, 'z', 0, 10)
//cameraFolder.open()
var update = function(){
  bowlingSphere2.rotation.x += 0.1 //move bowling 2
  bowlingSphere.rotation.y += 0.1 //move bowling 1
  bowlingPin9.rotation.y += 0.1 //move bowling 9
  bowlingPin8.rotation.y += 0.1 //move bowling 8
  bowlingPin7.rotation.y += 0.1 //move bowling 7
  bowlingPin6.rotation.y += 0.1 //move bowling 6
  bowlingPin5.rotation.y += 0.1 //move bowling 5
  bowlingPin4.rotation.y += 0.1 //move bowling 4
  bowlingPin3.rotation.y += 0.1 //move bowling 3
  bowlingPin2.rotation.y += 0.1 //move bowling 2
  bowlingPin.rotation.y += 0.1 //move bowling 1
};

//draw the scene
var render = function(){
  renderer.render(scene, camera);
};

//const stats = Stats()
//document.body.appendChild(stats.dom)
//run game loop
var GameLoop = function(){
  requestAnimationFrame(GameLoop);
  controls.update()
  update();
  render();
  //stats.update();
}

GameLoop();

