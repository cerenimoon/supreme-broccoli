"use strict";

function main() {
  // Get A WebGL context
  /** @type {HTMLCanvasElement} */
  var canvas = document.querySelector("#canvas");
  var gl = canvas.getContext("webgl");
  if (!gl) {
    return;
  }

  // create earth, sun and moon buffer information
  const sphereBufferInfo = primitives.createSphereWithVertexColorsBufferInfo(gl, 7, 360, 160); //earth sphere
  const sunBufferInfo   = primitives.createSphereWithVertexColorsBufferInfo(gl, 20, 360, 160); //sun sphere
  const moonBufferInfo   = primitives.createSphereWithVertexColorsBufferInfo(gl, 3, 360, 160); //moon sphere
  var circle_rotation = 0; //earth rotation
  var earth_ro_x = 50; //earth x
  var earth_ro_z = 50; //earth z
  var moon_ro_x = 0.95; //moon x
  var moon_ro_z = 0; //moon z
  var circle_moon_ro = 0; //moon rotation
  // setup GLSL program
  var programInfo = webglUtils.createProgramInfo(gl, ["vertex-shader-3d", "fragment-shader-3d"]);

  function degToRad(d) {
    return d * Math.PI / 180;
  }

  var cameraAngleRadians = degToRad(0);
  var fieldOfViewRadians = degToRad(60);
  var cameraHeight = 50;
  //var cameraVal = degToRad(0);
  var radius = 120; //backward radius
  var viewport_x_ro = 0; //viewport value 

  // earth sun and moon uniforms colors and matrix for each object.
  var sphereUniforms = {
    u_colorMult: [0.2, 0.3, 0.6, 1],
    u_matrix: m4.identity(),
  };
  var sunUniforms = {
    u_colorMult: [1, 0.65, 0.0, 1],
    u_matrix: m4.identity(),
  };
  var moonUniforms = {
    u_colorMult: [1.0, 1.0, 0.6, 1],
    u_matrix: m4.identity(),
  };
  var sphereTranslation = [50, 0, 0]; //earth translation
  var sunTranslation   = [0, 0, 0]; //sun translation
  var moonTranslation   = [ 60, 0, 0]; //moon translation

  function computeMatrix(viewProjectionMatrix, translation, xRotation, yRotation) {
    var matrix = m4.translate(viewProjectionMatrix,
        translation[0], //x translation
        translation[1], //y translation
        translation[2]); //z translation
    matrix = m4.xRotate(matrix, xRotation);
    return m4.yRotate(matrix, yRotation); //rotation
  }

  requestAnimationFrame(drawSolar); //drawSolar

  document.addEventListener('keydown', function(event) {
    if(event.code == 'KeyW'){
      radius -= 5; //zoom out backward
      drawSolar();
    }
    else if(event.code == 'KeyS'){
      radius += 5; //zoom in backward
      drawSolar();
    }
    else if(event.code == 'KeyA'){
      viewport_x_ro -= 5;
      drawSolar(); //left
    }
    else if(event.code == 'KeyD'){
      viewport_x_ro += 5; //right
      drawSolar();
    }
  })

  // Draw the scene.
  function drawSolar(time) {
    time *= 0.0005; //time frames 

    webglUtils.resizeCanvasToDisplaySize(gl.canvas);

    //set the viewport
    gl.viewport(viewport_x_ro, 0, gl.canvas.width, gl.canvas.height);

    gl.enable(gl.CULL_FACE); //depth cull
    gl.enable(gl.DEPTH_TEST); //cull depth test 

    //set the depth buffer
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    //set the projection matrix
    var aspect = gl.canvas.clientWidth / gl.canvas.clientHeight;
    var projectionMatrix =
        m4.perspective(fieldOfViewRadians, aspect, 1, 2000);

    // Compute the camera's matrix using look at.
    //var cameraPosition = [0, 0, 100];
    //var target = [0, 0, 0];
    //var up = [0, 1, 0];
    //var cameraMatrix = m4.lookAt(cameraPosition, target, up);
    var cameraMatrix = m4.yRotation(cameraAngleRadians); //set camera matrix
    cameraMatrix = m4.translate(cameraMatrix, 0, 0, radius*1.5); //m4 translate
    // Make a view matrix from the camera matrix.
    var viewMatrix = m4.inverse(cameraMatrix);

    var viewProjectionMatrix = m4.multiply(projectionMatrix, viewMatrix); //set viewMatrix 

    //set the rotations for earth and moon circles 
    if(circle_rotation <= 360){
      var i = circle_rotation*Math.PI / 180;
      earth_ro_x = Math.cos(i)*50 - 0.765;
      earth_ro_z = Math.sin(i)*50;
      sphereTranslation[0] = earth_ro_x;
      sphereTranslation[1] = 0;
      sphereTranslation[2] = earth_ro_z;
      circle_rotation += 0.05*30;
    }
    else{
      circle_rotation = 0;
      sphereTranslation[0] = earth_ro_x;
      sphereTranslation[1] = 0;
      sphereTranslation[2] = earth_ro_z;
    }

    if(circle_moon_ro <= 360){
      var j = circle_moon_ro*Math.PI/180;
      moon_ro_x = (earth_ro_x + (Math.cos(j)*20)) - 3;
      moon_ro_z = earth_ro_z + (Math.sin(j)*20);
      moonTranslation[0] = moon_ro_x;
      moonTranslation[1] = 0;
      moonTranslation[2] = moon_ro_z;
      circle_moon_ro += 0.05*60;
    }
    else{
      circle_moon_ro = 0;
      moonTranslation[0] = moon_ro_x;
      moonTranslation[1] = 0;
      moonTranslation[2] = moon_ro_z;
    }

    var sphereXRotation =  time; //rotate earth
    var sphereYRotation =  time; //rotate earth
    var sunXRotation   = -time; //rotate sun
    var sunYRotation   =  time; //rotate sun
    var moonXRotation   =  time; //rotate moon
    var moonYRotation   = -time; //rotate moon 

    gl.useProgram(programInfo.program); //program information 

    // set up earth
    webglUtils.setBuffersAndAttributes(gl, programInfo, sphereBufferInfo); //earth sphere 

    sphereUniforms.u_matrix = computeMatrix(
        viewProjectionMatrix,
        sphereTranslation,
        sphereXRotation,
        sphereYRotation);

    // set up earth uniforms
    webglUtils.setUniforms(programInfo, sphereUniforms);

    gl.drawArrays(gl.TRIANGLES, 0, sphereBufferInfo.numElements);


    // set up sun uniform 
    webglUtils.setBuffersAndAttributes(gl, programInfo, sunBufferInfo);

    sunUniforms.u_matrix = computeMatrix(
        viewProjectionMatrix,
        sunTranslation,
        sunXRotation,
        sunYRotation);

    // Set the sun uniforms
    webglUtils.setUniforms(programInfo, sunUniforms);

    gl.drawArrays(gl.TRIANGLES, 0, sunBufferInfo.numElements);


    // set up moon
    webglUtils.setBuffersAndAttributes(gl, programInfo, moonBufferInfo);

    moonUniforms.u_matrix = computeMatrix(
        viewProjectionMatrix,
        moonTranslation,
        moonXRotation,
        moonYRotation);

    // set up moon uniforms 
    webglUtils.setUniforms(programInfo, moonUniforms);

    gl.drawArrays(gl.TRIANGLES, 0, moonBufferInfo.numElements);

    requestAnimationFrame(drawSolar);
  }
}

main(); //main function