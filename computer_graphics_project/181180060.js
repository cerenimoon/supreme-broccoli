var numberOfTriangles = 60;
window.onload = function init(){
    var canvas = document.getElementById('gl-canvas');
    // define WebGLRenderingContext
    //// getContext(context, options)
    var gl = canvas.getContext('experimental-webgl');
  
    // Specify the color values used when clearing color buffers.
    //// gl.clearColor(red, green, blue, alpha)
    gl.clearColor(0.0, 0.0, 0.0, 1.0); //clear background as black 
  
    // clears buffers to preset values specified by clearColor(), clearDepth() and clearStencil().
    //// gl.clear(gl.COLOR_BUFFER_BIT || gl.DEPTH_BUFFER_BIT || gl.STENCIL_BUFFER_BIT)
    gl.clear(gl.COLOR_BUFFER_BIT);
  
    var programGL = gl.createProgram();
    var program_sun = gl.createProgram();
    var program_moon = gl.createProgram();
  
    // time to throw some shade
    var vertexShaderScript = document.getElementById('vertex-shader').text;
    var fragmentShaderScript = document.getElementById('fragment-shader').text;
    var sun_vertexShaderScript = document.getElementById('vertex-shader-sun').text;
    var sun_fragmentShaderScript = document.getElementById('fragment-shader-sun').text;
    var moon_vertexShaderScript = document.getElementById('vertex-shader-moon').text;
    var moon_fragmentShaderScript = document.getElementById('fragment-shader-moon').text;
  
  
    // gl.createShader(gl.VERTEX_SHADER || gl.FRAGMENT_SHADER)
    var vertexShader   = gl.createShader(gl.VERTEX_SHADER);
    var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    var sun_vertexShader = gl.createShader(gl.VERTEX_SHADER);
    var sun_fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    var moon_vertexShader = gl.createShader(gl.VERTEX_SHADER);
    var moon_fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    //var shadow_vertexShader = gl.createShader(gl.VERTEX_SHADER);
    //var shadow_fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
  
    // gl.shaderSource(shader, source)
    gl.shaderSource(vertexShader, vertexShaderScript);
    gl.shaderSource(fragmentShader, fragmentShaderScript);
    //gl.shaderSource(moon_fragmentShader, moon_fragmentShaderScript);
    //gl.shaderSource(moon_vertexShader, )

  
    // gl.compileShader(shader)
    gl.compileShader(vertexShader);
    gl.compileShader(fragmentShader);
    //gl.compileShader(moon_fragmentShader);

  
    // gl.attachShader(webgl program, shader)
    gl.attachShader(programGL, vertexShader);
    gl.attachShader(programGL, fragmentShader);
    //gl.attachShader(programGL, moon_fragmentShader);

  
    gl.linkProgram(programGL);
    gl.useProgram(programGL);
    //gl.linkProgram(program_sun);
    //gl.useProgram(program_sun);
  
    var triangleAttributePosition = gl.getAttribLocation(programGL, 'pos'); //position of earth triangle 
    var sunAttribPosition = gl.getAttribLocation(program_sun, 'posSun'); //programGL
    var moonAttribPosition = gl.getAttribLocation(program_moon, 'posMo');
  
    // set the resolution
    var resolutionLocation = gl.getUniformLocation(programGL, 'u_resolution');
    gl.uniform2f(resolutionLocation, canvas.width, canvas.height);
    var resolutionLocationSun = gl.getUniformLocation(program_sun, 'sun_resolution');
    gl.uniform2f(resolutionLocationSun, canvas.width, canvas.height);
    var resolutionLocationMoon = gl.getUniformLocation(programGL, 'moon_resolution');
    //gl.uniform2f(resolutionLocationMoon);
  
    var vertices = []; //earth vertices 
  
    //var numberOfTriangles = 60;
    var degreesPerTriangle = (4 * Math.PI) / numberOfTriangles;
    var centerX = 0.0; //0.7
  
    for(var i = 0; i < numberOfTriangles; i++) {
        var index = i * 3;
        var angle = degreesPerTriangle * i;
        var scale = 4;
  
        vertices[index] = (Math.cos(angle) / scale) + 1.35;               // x
        vertices[index + 1] = Math.sin(angle) / scale + centerX; // y
        vertices[index + 2] = 0;                                 // z
    }
  
  
    var verticesFloatArray = new Float32Array(vertices);
    var bufferId = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId);
    gl.bufferData(gl.ARRAY_BUFFER, verticesFloatArray, gl.DYNAMIC_DRAW);
    gl.enableVertexAttribArray(triangleAttributePosition);
    gl.vertexAttribPointer(triangleAttributePosition, 3, gl.FLOAT, false, 0, 0); //draw earth triangulation
    gl.drawArrays(gl.TRIANGLE_FAN, 0, numberOfTriangles - 5);



    gl.shaderSource(sun_vertexShader, sun_vertexShaderScript); //add shader sources
    gl.shaderSource(sun_fragmentShader, sun_fragmentShaderScript);
    gl.compileShader(sun_vertexShader); //compile shaders
    gl.compileShader(sun_fragmentShader);
    gl.attachShader(program_sun, sun_vertexShader); //attach shaders 
    gl.attachShader(program_sun, sun_fragmentShader);
    gl.linkProgram(program_sun);
    gl.useProgram(program_sun);
  
    var vertices2 = []; //sun vertices
  
    var numOfTriSun = 60;
    var degreesPerTriangleS = (4*Math.PI)/numberOfTriangles;
    var centerS = 0.0; //center
  
    for(var i = 0; i < numberOfTriangles; i++){
        var index = i*3;
        var angle = degreesPerTriangle * i;
        var scale = 2;
  
        vertices2[index] = (Math.cos(angle)/scale) - 0.1; //x coordinate
        vertices2[index + 1] = Math.sin(angle) / scale + centerS; //y coordinate
        vertices2[index + 2] = 0; //z coordinate
    }
  
  
    var verticesFloatArray2 = new Float32Array(vertices2); //create the sun 
  
    var bufferId2 = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId2);
    gl.bufferData(gl.ARRAY_BUFFER, verticesFloatArray2, gl.DYNAMIC_DRAW);
    gl.enableVertexAttribArray(sunAttribPosition);
    gl.vertexAttribPointer(sunAttribPosition, 3, gl.FLOAT, false, 0, 0);
  
    // drawArrays(primatitve shape, start index, number of values to be rendered)
    gl.drawArrays(gl.TRIANGLE_FAN, 0, numberOfTriangles - 5)  

    gl.shaderSource(moon_vertexShader, moon_vertexShaderScript);
    gl.shaderSource(moon_fragmentShader, moon_fragmentShaderScript);
    gl.compileShader(moon_vertexShader);
    gl.compileShader(moon_fragmentShader);
    gl.attachShader(program_moon, moon_vertexShader);
    gl.attachShader(program_moon, moon_fragmentShader);
    gl.linkProgram(program_moon);
    gl.useProgram(program_moon);


    var vertices3 = []; //moon vertices 

    var centerM = 0.0; //0.7 

    for(var i = 0; i < numberOfTriangles; i++){
        var index = i*3;
        var angle = degreesPerTriangle*i;
        var scale = 12;

        vertices3[index] = (Math.cos(angle)/scale) + 0.85;
        vertices3[index + 1] = Math.sin(angle)/ scale + centerM;
        vertices3[index + 2] = 0;  
    }

    var moonArray = new Float32Array(vertices3); //moon vertices

    var bufferId3 = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, bufferId3);
    gl.bufferData(gl.ARRAY_BUFFER, moonArray, gl.DYNAMIC_DRAW);
    gl.enableVertexAttribArray(moonAttribPosition);
    gl.vertexAttribPointer(moonAttribPosition, 3, gl.FLOAT, false, 0, 0);
  
    // drawArrays(primatitve shape, start index, number of values to be rendered)
    gl.drawArrays(gl.TRIANGLE_FAN, 0, numberOfTriangles - 5)     
    
};

function render(){
    
}
  